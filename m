Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265675AbUATSfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUATSfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:35:46 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:9111 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S265675AbUATSdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:33:14 -0500
Date: Tue, 20 Jan 2004 10:33:04 -0800
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add readX_relaxed() interface
Message-ID: <20040120183304.GA31058@sgi.com>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040120175201.GA30470@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120175201.GA30470@sgi.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, that last mail didn't make for a very good changeset comment.
Here's another.

Add readX_relaxed() interface.  Allows drivers to specify that a
particular PIO read doesn't need to be held up behind previous DMA
writes, which can save CPU time and improve performance.

Jesse

diff -Nru a/Documentation/DocBook/deviceiobook.tmpl b/Documentation/DocBook/deviceiobook.tmpl
--- a/Documentation/DocBook/deviceiobook.tmpl	Tue Jan 20 09:50:27 2004
+++ b/Documentation/DocBook/deviceiobook.tmpl	Tue Jan 20 09:50:27 2004
@@ -126,7 +126,9 @@
       <para>
 	The functions are named <function>readb</function>,
 	<function>readw</function>, <function>readl</function>,
-	<function>readq</function>, <function>writeb</function>,
+	<function>readq</function>, <function>readb_relaxed</function>,
+	<function>readw_relaxed</function>, <function>readl_relaxed</function>,
+	<function>readq_relaxed</function>, <function>writeb</function>,
 	<function>writew</function>, <function>writel</function> and
 	<function>writeq</function>.
       </para>
@@ -158,6 +160,18 @@
 	device to ensure that writes have occurred in the specific cases the
 	author cares. This kind of property cannot be hidden from driver
 	writers in the API.
+      </para>
+
+      <para>
+	PCI ordering rules also guarantee that PIO read responses arrive
+	after any outstanding DMA writes on that bus, since for some devices
+	the result of a <function>readb</function> call may signal to the
+	driver that a DMA transaction is complete.  In many cases, however,
+	the driver may want to indicate that the next
+	<function>readb</function> call has no relation to any previous DMA
+	writes performed by the device.  The driver can use
+	<function>readb_relaxed</function> for these cases, although only
+	some platforms will honor the relaxed semantics.
       </para>
     </sect1>
 
diff -Nru a/arch/ia64/sn/kernel/sn2/io.c b/arch/ia64/sn/kernel/sn2/io.c
--- a/arch/ia64/sn/kernel/sn2/io.c	Tue Jan 20 09:50:27 2004
+++ b/arch/ia64/sn/kernel/sn2/io.c	Tue Jan 20 09:50:27 2004
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
diff -Nru a/include/asm-alpha/io.h b/include/asm-alpha/io.h
--- a/include/asm-alpha/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-alpha/io.h	Tue Jan 20 09:50:27 2004
@@ -412,6 +412,11 @@
 # define readq(a)	_readq((unsigned long)(a))
 #endif
 
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
+#define readq_relaxed(addr) readq(addr)
+
 #ifndef writeb
 # define writeb(v,a)	_writeb((v),(unsigned long)(a))
 #endif
diff -Nru a/include/asm-arm/arch-ebsa110/io.h b/include/asm-arm/arch-ebsa110/io.h
--- a/include/asm-arm/arch-ebsa110/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-arm/arch-ebsa110/io.h	Tue Jan 20 09:50:27 2004
@@ -38,6 +38,9 @@
 #define readb(b)		__readb(b)
 #define readw(b)		__readw(b)
 #define readl(b)		__readl(b)
+#define readb_relaxed(addr)	readb(addr)
+#define readw_relaxed(addr)	readw(addr)
+#define readl_relaxed(addr)	readl(addr)
 
 void __writeb(u8  val, void *addr);
 void __writew(u16 val, void *addr);
diff -Nru a/include/asm-arm/io.h b/include/asm-arm/io.h
--- a/include/asm-arm/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-arm/io.h	Tue Jan 20 09:50:27 2004
@@ -149,6 +149,9 @@
 #define readb(c) ({ unsigned int __v = __raw_readb(__mem_pci(c)); __v; })
 #define readw(c) ({ unsigned int __v = le16_to_cpu(__raw_readw(__mem_pci(c))); __v; })
 #define readl(c) ({ unsigned int __v = le32_to_cpu(__raw_readl(__mem_pci(c))); __v; })
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
 
 #define readsb(p,d,l)		__raw_readsb((unsigned int)__mem_pci(p),d,l)
 #define readsw(p,d,l)		__raw_readsw((unsigned int)__mem_pci(p),d,l)
diff -Nru a/include/asm-arm26/io.h b/include/asm-arm26/io.h
--- a/include/asm-arm26/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-arm26/io.h	Tue Jan 20 09:50:27 2004
@@ -308,6 +308,9 @@
 #define readb(c)                        (__readwrite_bug("readb"),0)
 #define readw(c)                        (__readwrite_bug("readw"),0)
 #define readl(c)                        (__readwrite_bug("readl"),0)
+#define readb_relaxed(addr)		readb(addr)
+#define readw_relaxed(addr)		readw(addr)
+#define readl_relaxed(addr)		readl(addr)
 #define writeb(v,c)                     __readwrite_bug("writeb")
 #define writew(v,c)                     __readwrite_bug("writew")
 #define writel(v,c)                     __readwrite_bug("writel")
diff -Nru a/include/asm-cris/io.h b/include/asm-cris/io.h
--- a/include/asm-cris/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-cris/io.h	Tue Jan 20 09:50:27 2004
@@ -42,6 +42,9 @@
 #define readb(addr) (*(volatile unsigned char *) (addr))
 #define readw(addr) (*(volatile unsigned short *) (addr))
 #define readl(addr) (*(volatile unsigned int *) (addr))
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
 #define __raw_readb readb
 #define __raw_readw readw
 #define __raw_readl readl
diff -Nru a/include/asm-h8300/io.h b/include/asm-h8300/io.h
--- a/include/asm-h8300/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-h8300/io.h	Tue Jan 20 09:50:27 2004
@@ -47,6 +47,10 @@
 #define readl(addr) \
     ({ unsigned int __v = (*(volatile unsigned int *) (addr & 0x00ffffff)); __v; })
 
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
+
 #define writeb(b,addr) (void)((*(volatile unsigned char *) (addr & 0x00ffffff)) = (b))
 #define writew(b,addr) (void)((*(volatile unsigned short *) (addr & 0x00ffffff)) = (b))
 #define writel(b,addr) (void)((*(volatile unsigned int *) (addr & 0x00ffffff)) = (b))
diff -Nru a/include/asm-i386/io.h b/include/asm-i386/io.h
--- a/include/asm-i386/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-i386/io.h	Tue Jan 20 09:50:27 2004
@@ -153,6 +153,9 @@
 #define readb(addr) (*(volatile unsigned char *) __io_virt(addr))
 #define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
 #define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
 #define __raw_readb readb
 #define __raw_readw readw
 #define __raw_readl readl
diff -Nru a/include/asm-ia64/io.h b/include/asm-ia64/io.h
--- a/include/asm-ia64/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-ia64/io.h	Tue Jan 20 09:50:27 2004
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
+#define __readw_relaxed	platform_readw_relaxed
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
--- a/include/asm-ia64/machvec.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-ia64/machvec.h	Tue Jan 20 09:50:27 2004
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
--- a/include/asm-ia64/machvec_sn2.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-ia64/machvec_sn2.h	Tue Jan 20 09:50:27 2004
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
--- a/include/asm-ia64/sn/sn2/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-ia64/sn/sn2/io.h	Tue Jan 20 09:50:27 2004
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
diff -Nru a/include/asm-m68k/io.h b/include/asm-m68k/io.h
--- a/include/asm-m68k/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-m68k/io.h	Tue Jan 20 09:50:27 2004
@@ -261,6 +261,10 @@
 #define writeb(val,addr)  out_8((addr),(val))
 #define writew(val,addr)  out_le16((addr),(val))
 
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
+
 #ifndef CONFIG_ISA
 #define inb(port)      in_8(port)
 #define outb(val,port) out_8((port),(val))
diff -Nru a/include/asm-m68knommu/io.h b/include/asm-m68knommu/io.h
--- a/include/asm-m68knommu/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-m68knommu/io.h	Tue Jan 20 09:50:27 2004
@@ -39,6 +39,10 @@
 #define readl(addr) \
     ({ unsigned int __v = (*(volatile unsigned int *) (addr)); __v; })
 
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
+
 #define writeb(b,addr) (void)((*(volatile unsigned char *) (addr)) = (b))
 #define writew(b,addr) (void)((*(volatile unsigned short *) (addr)) = (b))
 #define writel(b,addr) (void)((*(volatile unsigned int *) (addr)) = (b))
diff -Nru a/include/asm-mips/io.h b/include/asm-mips/io.h
--- a/include/asm-mips/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-mips/io.h	Tue Jan 20 09:50:27 2004
@@ -264,6 +264,10 @@
 #define readw(addr)		__ioswab16(__raw_readw(addr))
 #define readl(addr)		__ioswab32(__raw_readl(addr))
 #define readq(addr)		__ioswab64(__raw_readq(addr))
+#define readb_relaxed(addr)	readb(addr)
+#define readw_relaxed(addr)	readw(addr)
+#define readl_relaxed(addr)	readl(addr)
+#define readq_relaxed(addr)	readq(addr)
 
 #define __raw_writeb(b,addr)	((*(volatile unsigned char *)(addr)) = (b))
 #define __raw_writew(w,addr)	((*(volatile unsigned short *)(addr)) = (w))
diff -Nru a/include/asm-parisc/io.h b/include/asm-parisc/io.h
--- a/include/asm-parisc/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-parisc/io.h	Tue Jan 20 09:50:27 2004
@@ -171,6 +171,11 @@
 #define writeq(b,addr) __raw_writeq(cpu_to_le64(b),addr)
 #endif /* !USE_HPPA_IOREMAP */
 
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
+#define readq_relaxed(addr) readq(addr)
+
 extern void __memcpy_fromio(unsigned long dest, unsigned long src, int count);
 extern void __memcpy_toio(unsigned long dest, unsigned long src, int count);
 extern void __memset_io(unsigned long dest, char fill, int count);
diff -Nru a/include/asm-ppc/io.h b/include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-ppc/io.h	Tue Jan 20 09:50:27 2004
@@ -58,6 +58,9 @@
 #define writel(b,addr) out_le32((volatile u32 *)(addr),(b))
 #endif /* CONFIG_APUS */
 
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
 
 #define __raw_readb(addr)	(*(volatile unsigned char *)(addr))
 #define __raw_readw(addr)	(*(volatile unsigned short *)(addr))
diff -Nru a/include/asm-ppc64/io.h b/include/asm-ppc64/io.h
--- a/include/asm-ppc64/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-ppc64/io.h	Tue Jan 20 09:50:27 2004
@@ -79,6 +79,10 @@
 #define outsl(port, buf, nl)	_outsl_ns((u32 *)((port)+pci_io_base), (buf), (nl))
 #endif
 
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
+
 extern void _insb(volatile u8 *port, void *buf, int ns);
 extern void _outsb(volatile u8 *port, const void *buf, int ns);
 extern void _insw(volatile u16 *port, void *buf, int ns);
diff -Nru a/include/asm-s390/io.h b/include/asm-s390/io.h
--- a/include/asm-s390/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-s390/io.h	Tue Jan 20 09:50:27 2004
@@ -87,6 +87,10 @@
 #define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
 #define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
 
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
+
 #define writeb(b,addr) (*(volatile unsigned char *) __io_virt(addr) = (b))
 #define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))
 #define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))
diff -Nru a/include/asm-sh/io.h b/include/asm-sh/io.h
--- a/include/asm-sh/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-sh/io.h	Tue Jan 20 09:50:27 2004
@@ -264,6 +264,10 @@
 # define readl(a)	_readl((unsigned long)(a))
 #endif
 
+#define readb_relaxed(a) readb(a)
+#define readw_relaxed(a) readw(a)
+#define readl_relaxed(a) readl(a)
+
 #ifndef writeb
 # define writeb(v,a)	_writeb((v),(unsigned long)(a))
 #endif
diff -Nru a/include/asm-sparc/io.h b/include/asm-sparc/io.h
--- a/include/asm-sparc/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-sparc/io.h	Tue Jan 20 09:50:27 2004
@@ -99,6 +99,9 @@
 #define readb(addr)	__readb((unsigned long)(addr))
 #define readw(addr)	__readw((unsigned long)(addr))
 #define readl(addr)	__readl((unsigned long)(addr))
+#define readb_relaxed(addr) readb(addr)
+#define readw_relaxed(addr) readw(addr)
+#define readl_relaxed(addr) readl(addr)
 
 #define writeb(b, addr)	__writeb((b),(unsigned long)(addr))
 #define writew(b, addr)	__writew((b),(unsigned long)(addr))
diff -Nru a/include/asm-sparc64/io.h b/include/asm-sparc64/io.h
--- a/include/asm-sparc64/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-sparc64/io.h	Tue Jan 20 09:50:27 2004
@@ -176,6 +176,10 @@
 #define readw(__addr)		(_readw((unsigned long)(__addr)))
 #define readl(__addr)		(_readl((unsigned long)(__addr)))
 #define readq(__addr)		(_readq((unsigned long)(__addr)))
+#define readb_relaxed(a)	readb(a)
+#define readw_relaxed(a)	readw(a)
+#define readl_relaxed(a)	readl(a)
+#define readq_relaxed(a)	readq(a)
 #define writeb(__b, __addr)	(_writeb((u8)(__b), (unsigned long)(__addr)))
 #define writew(__w, __addr)	(_writew((u16)(__w), (unsigned long)(__addr)))
 #define writel(__l, __addr)	(_writel((u32)(__l), (unsigned long)(__addr)))
diff -Nru a/include/asm-v850/io.h b/include/asm-v850/io.h
--- a/include/asm-v850/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-v850/io.h	Tue Jan 20 09:50:27 2004
@@ -23,6 +23,10 @@
 #define readl(addr) \
   ({ unsigned long __v = (*(volatile unsigned long *) (addr)); __v; })
 
+#define readb_relaxed(a) readb(a)
+#define readw_relaxed(a) readw(a)
+#define readl_relaxed(a) readl(a)
+
 #define writeb(b, addr) \
   (void)((*(volatile unsigned char *) (addr)) = (b))
 #define writew(b, addr) \
diff -Nru a/include/asm-x86_64/io.h b/include/asm-x86_64/io.h
--- a/include/asm-x86_64/io.h	Tue Jan 20 09:50:27 2004
+++ b/include/asm-x86_64/io.h	Tue Jan 20 09:50:27 2004
@@ -188,6 +188,10 @@
 #define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
 #define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
 #define readq(addr) (*(volatile unsigned long *) __io_virt(addr))
+#define readb_relaxed(a) readb(a)
+#define readw_relaxed(a) readw(a)
+#define readl_relaxed(a) readl(a)
+#define readq_relaxed(a) readq(a)
 #define __raw_readb readb
 #define __raw_readw readw
 #define __raw_readl readl
