Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUAOUxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAOUu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:50:57 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:23847 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261595AbUAOUtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:49:20 -0500
Date: Thu, 15 Jan 2004 12:49:13 -0800
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, jeremy@sgi.com
Subject: [PATCH] readX_relaxed interface
Message-ID: <20040115204913.GA8172@sgi.com>
Mail-Followup-To: linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	jeremy@sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the PIO ordering disucssion, I've come up with the following
patch.  It has the potential to help any platform that has seperate PIO
and DMA channels, and allows them to be reorderd wrt each other.  Some
SGI MIPS platforms, as well as the SGI Altix (aka sn2) platform behave
this way, and will thus benefit from this patch.

It adds a new PIO read routine for PIOs that don't have to be ordered
wrt DMA on the system.

If it looks ok, I'll add in macros for the other arches and send it out
for inclusion.

Thanks,
Jesse

diff -Nru a/arch/ia64/sn/kernel/sn2/io.c b/arch/ia64/sn/kernel/sn2/io.c
--- a/arch/ia64/sn/kernel/sn2/io.c	Thu Jan 15 11:39:13 2004
+++ b/arch/ia64/sn/kernel/sn2/io.c	Thu Jan 15 11:39:13 2004
@@ -23,6 +23,10 @@
 #undef __sn_readw
 #undef __sn_readl
 #undef __sn_readq
+#undef __sn_readb_relaxed
+#undef __sn_readw_relaxed
+#undef __sn_readl_relaxed
+#undef __sn_readq_relaxed
 
 unsigned int
 __sn_inb (unsigned long port)
@@ -82,6 +86,30 @@
 __sn_readq (void *addr)
 {
 	return ___sn_readq (addr);
+}
+
+unsigned char
+__sn_readb_relaxed (void *addr)
+{
+	return ___sn_readb_relaxed (addr);
+}
+
+unsigned short
+__sn_readw_relaxed (void *addr)
+{
+	return ___sn_readw_relaxed (addr);
+}
+
+unsigned int
+__sn_readl_relaxed (void *addr)
+{
+	return ___sn_readl_relaxed (addr);
+}
+
+unsigned long
+__sn_readq_relaxed (void *addr)
+{
+	return ___sn_readq_relaxed (addr);
 }
 
 #endif
diff -Nru a/include/asm-ia64/io.h b/include/asm-ia64/io.h
--- a/include/asm-ia64/io.h	Thu Jan 15 11:39:13 2004
+++ b/include/asm-ia64/io.h	Thu Jan 15 11:39:13 2004
@@ -125,6 +125,10 @@
 #define __ia64_readw	___ia64_readw
 #define __ia64_readl	___ia64_readl
 #define __ia64_readq	___ia64_readq
+#define __ia64_readb_relaxed	___ia64_readb
+#define __ia64_readw_relaxed	___ia64_readw
+#define __ia64_readl_relaxed	___ia64_readl
+#define __ia64_readq_relaxed	___ia64_readq
 #define __ia64_writeb	___ia64_writeb
 #define __ia64_writew	___ia64_writew
 #define __ia64_writel	___ia64_writel
@@ -337,15 +341,27 @@
 #define __readw		platform_readw
 #define __readl		platform_readl
 #define __readq		platform_readq
+#define __readb_relaxed	platform_readb_relaxed
+#define __readw_relaxed platform_readw_relaxed
+#define __readl_relaxed	platform_readl_relaxed
+#define __readq_relaxed	platform_readq_relaxed
 
 #define readb(a)	__readb((void *)(a))
 #define readw(a)	__readw((void *)(a))
 #define readl(a)	__readl((void *)(a))
 #define readq(a)	__readq((void *)(a))
+#define readb_relaxed(a)	__readb_relaxed((void *)(a))
+#define readw_relaxed(a)	__readw_relaxed((void *)(a))
+#define readl_relaxed(a)	__readl_relaxed((void *)(a))
+#define readq_relaxed(a)	__readq_relaxed((void *)(a))
 #define __raw_readb	readb
 #define __raw_readw	readw
 #define __raw_readl	readl
 #define __raw_readq	readq
+#define __raw_readb_relaxed	readb_relaxed
+#define __raw_readw_relaxed	readw_relaxed
+#define __raw_readl_relaxed	readl_relaxed
+#define __raw_readq_relaxed	readq_relaxed
 #define writeb(v,a)	__writeb((v), (void *) (a))
 #define writew(v,a)	__writew((v), (void *) (a))
 #define writel(v,a)	__writel((v), (void *) (a))
diff -Nru a/include/asm-ia64/machvec.h b/include/asm-ia64/machvec.h
--- a/include/asm-ia64/machvec.h	Thu Jan 15 11:39:13 2004
+++ b/include/asm-ia64/machvec.h	Thu Jan 15 11:39:13 2004
@@ -64,6 +64,10 @@
 typedef unsigned short ia64_mv_readw_t (void *);
 typedef unsigned int ia64_mv_readl_t (void *);
 typedef unsigned long ia64_mv_readq_t (void *);
+typedef unsigned char ia64_mv_readb_relaxed_t (void *);
+typedef unsigned short ia64_mv_readw_relaxed_t (void *);
+typedef unsigned int ia64_mv_readl_relaxed_t (void *);
+typedef unsigned long ia64_mv_readq_relaxed_t (void *);
 
 extern void machvec_noop (void);
 extern void machvec_memory_fence (void);
@@ -114,6 +118,10 @@
 #  define platform_readw        ia64_mv.readw
 #  define platform_readl        ia64_mv.readl
 #  define platform_readq        ia64_mv.readq
+#  define platform_readb_relaxed        ia64_mv.readb_relaxed
+#  define platform_readw_relaxed        ia64_mv.readw_relaxed
+#  define platform_readl_relaxed        ia64_mv.readl_relaxed
+#  define platform_readq_relaxed        ia64_mv.readq_relaxed
 # endif
 
 /* __attribute__((__aligned__(16))) is required to make size of the
@@ -155,6 +163,10 @@
 	ia64_mv_readw_t *readw;
 	ia64_mv_readl_t *readl;
 	ia64_mv_readq_t *readq;
+	ia64_mv_readb_relaxed_t *readb_relaxed;
+	ia64_mv_readw_relaxed_t *readw_relaxed;
+	ia64_mv_readl_relaxed_t *readl_relaxed;
+	ia64_mv_readq_relaxed_t *readq_relaxed;
 } __attribute__((__aligned__(16))); /* align attrib? see above comment */
 
 #define MACHVEC_INIT(name)			\
@@ -192,6 +204,10 @@
 	platform_readw,				\
 	platform_readl,				\
 	platform_readq,				\
+	platform_readb_relaxed,			\
+	platform_readw_relaxed,			\
+	platform_readl_relaxed,			\
+	platform_readq_relaxed,			\
 }
 
 extern struct ia64_machine_vector ia64_mv;
@@ -314,6 +330,18 @@
 #endif
 #ifndef platform_readq
 # define platform_readq		__ia64_readq
+#endif
+#ifndef platform_readb_relaxed
+# define platform_readb_relaxed	__ia64_readb_relaxed
+#endif
+#ifndef platform_readw_relaxed
+# define platform_readw_relaxed	__ia64_readw_relaxed
+#endif
+#ifndef platform_readl_relaxed
+# define platform_readl_relaxed	__ia64_readl_relaxed
+#endif
+#ifndef platform_readq_relaxed
+# define platform_readq_relaxed	__ia64_readq_relaxed
 #endif
 
 #endif /* _ASM_IA64_MACHVEC_H */
diff -Nru a/include/asm-ia64/machvec_sn2.h b/include/asm-ia64/machvec_sn2.h
--- a/include/asm-ia64/machvec_sn2.h	Thu Jan 15 11:39:13 2004
+++ b/include/asm-ia64/machvec_sn2.h	Thu Jan 15 11:39:13 2004
@@ -51,6 +51,10 @@
 extern ia64_mv_readw_t __sn_readw;
 extern ia64_mv_readl_t __sn_readl;
 extern ia64_mv_readq_t __sn_readq;
+extern ia64_mv_readb_t __sn_readb_relaxed;
+extern ia64_mv_readw_t __sn_readw_relaxed;
+extern ia64_mv_readl_t __sn_readl_relaxed;
+extern ia64_mv_readq_t __sn_readq_relaxed;
 extern ia64_mv_dma_alloc_coherent	sn_dma_alloc_coherent;
 extern ia64_mv_dma_free_coherent	sn_dma_free_coherent;
 extern ia64_mv_dma_map_single		sn_dma_map_single;
@@ -85,6 +89,10 @@
 #define platform_readw			__sn_readw
 #define platform_readl			__sn_readl
 #define platform_readq			__sn_readq
+#define platform_readb_relaxed		__sn_readb_relaxed
+#define platform_readw_relaxed		__sn_readw_relaxed
+#define platform_readl_relaxed		__sn_readl_relaxed
+#define platform_readq_relaxed		__sn_readq_relaxed
 #define platform_irq_desc		sn_irq_desc
 #define platform_irq_to_vector		sn_irq_to_vector
 #define platform_local_vector_to_irq	sn_local_vector_to_irq
diff -Nru a/include/asm-ia64/sn/sn2/io.h b/include/asm-ia64/sn/sn2/io.h
--- a/include/asm-ia64/sn/sn2/io.h	Thu Jan 15 11:39:13 2004
+++ b/include/asm-ia64/sn/sn2/io.h	Thu Jan 15 11:39:13 2004
@@ -27,6 +27,10 @@
 #define __sn_readw ___sn_readw
 #define __sn_readl ___sn_readl
 #define __sn_readq ___sn_readq
+#define __sn_readb_relaxed ___sn_readb_relaxed
+#define __sn_readw_relaxed ___sn_readw_relaxed
+#define __sn_readl_relaxed ___sn_readl_relaxed
+#define __sn_readq_relaxed ___sn_readq_relaxed
 
 /*
  * The following routines are SN Platform specific, called when
@@ -208,25 +212,25 @@
 }
 
 static inline unsigned char
-sn_readb_fast (void *addr)
+___sn_readb_relaxed (void *addr)
 {
 	return *(volatile unsigned char *)addr;
 }
 
 static inline unsigned short
-sn_readw_fast (void *addr)
+___sn_readw_relaxed (void *addr)
 {
 	return *(volatile unsigned short *)addr;
 }
 
 static inline unsigned int
-sn_readl_fast (void *addr)
+___sn_readl_relaxed (void *addr)
 {
 	return *(volatile unsigned int *) addr;
 }
 
 static inline unsigned long
-sn_readq_fast (void *addr)
+___sn_readq_relaxed (void *addr)
 {
 	return *(volatile unsigned long *) addr;
 }
