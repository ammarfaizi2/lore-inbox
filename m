Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289703AbSAJVws>; Thu, 10 Jan 2002 16:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289718AbSAJVwR>; Thu, 10 Jan 2002 16:52:17 -0500
Received: from rj.SGI.COM ([204.94.215.100]:55726 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289709AbSAJVvk>;
	Thu, 10 Jan 2002 16:51:40 -0500
Date: Thu, 10 Jan 2002 13:48:59 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: davem@redhat.com, ralf@uni-koblenz.de
Cc: linux-kernel@vger.kernel.org
Subject: memory-mapped i/o barrier
Message-ID: <20020110134859.A729245@sgi.com>
Mail-Followup-To: davem@redhat.com, ralf@uni-koblenz.de,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a copy of a patch I just got accepted into the 2.5 patch for
ia64, and I'm wondering if you guys will accept something similar.  On
mips64, mmiob() could just be implemented as a 'sync', but I'm not
sure how to do it (or if it's even necessary) on other platforms.
Please let me know what you think.  I wrote a small documentation file
for the macro that appears at the top of the patch.

Thanks,
Jesse


diff -Naur --exclude=*~ --exclude=TAGS linux-2.4.17-ia64/Documentation/mmio_barrier.txt linux-2.4.17-ia64-mmiob/Documentation/mmio_barrier.txt
--- linux-2.4.17-ia64/Documentation/mmio_barrier.txt	Wed Dec 31 16:00:00 1969
+++ linux-2.4.17-ia64-mmiob/Documentation/mmio_barrier.txt	Tue Jan  8 15:57:37 2002
@@ -0,0 +1,15 @@
+On some platforms, so-called memory-mapped I/O is weakly ordered.  For
+example, the following might occur:
+
+CPU A writes 0x1 to Device #1
+CPU B writes 0x2 to Device #1
+Device #1 sees 0x2
+Device #1 sees 0x1
+
+On such platforms, driver writers are responsible for guaranteeing that I/O
+writes to memory-mapped addresses on their device arrive in the order
+intended.  The mmiob() macro is provided for this purpose.  A typical use
+of this macro might be immediately prior to the exit of a critical
+section of code proteced by spinlocks.  This would ensure that subsequent
+writes to I/O space arrived only after all prior writes (much like a
+typical memory barrier op, mb(), only with respect to I/O).
diff -Naur --exclude=*~ --exclude=TAGS linux-2.4.17-ia64/arch/ia64/sn/kernel/sn1/iomv.c linux-2.4.17-ia64-mmiob/arch/ia64/sn/kernel/sn1/iomv.c
--- linux-2.4.17-ia64/arch/ia64/sn/kernel/sn1/iomv.c	Tue Jan  8 15:45:11 2002
+++ linux-2.4.17-ia64-mmiob/arch/ia64/sn/kernel/sn1/iomv.c	Tue Jan  8 15:58:54 2002
@@ -9,6 +9,8 @@
 #include <asm/io.h>
 #include <linux/pci.h>
 #include <asm/sn/simulator.h>
+#include <asm/pio_flush.h>
+#include <asm/delay.h>
 
 static inline void *
 sn1_io_addr(unsigned long port)
@@ -134,3 +136,9 @@
 	__ia64_mf_a();
 }
 #endif /* SN1_IOPORTS */
+
+void
+sn_mmiob ()
+{
+	PIO_FLUSH();
+}
diff -Naur --exclude=*~ --exclude=TAGS linux-2.4.17-ia64/include/asm-ia64/io.h linux-2.4.17-ia64-mmiob/include/asm-ia64/io.h
--- linux-2.4.17-ia64/include/asm-ia64/io.h	Fri Nov  9 14:26:17 2001
+++ linux-2.4.17-ia64-mmiob/include/asm-ia64/io.h	Wed Jan  9 10:53:46 2002
@@ -69,6 +69,21 @@
  */
 #define __ia64_mf_a()	__asm__ __volatile__ ("mf.a" ::: "memory")
 
+/**
+ * __ia64_mmiob - I/O space memory barrier
+ *
+ * Acts as a memory mapped I/O barrier for platforms that queue writes to 
+ * I/O space.  This ensures that subsequent writes to I/O space arrive after
+ * all previous writes.  For most ia64 platforms, this is a simple
+ * 'mf.a' instruction.  For other platforms, mmiob() may have to read
+ * a chipset register to ensure ordering.
+ */
+static inline void
+__ia64_mmiob ()
+{
+	__ia64_mf_a();
+}
+
 static inline const unsigned long
 __ia64_get_io_port_base (void)
 {
@@ -271,6 +286,7 @@
 #define __outb		platform_outb
 #define __outw		platform_outw
 #define __outl		platform_outl
+#define __mmiob         platform_mmiob
 
 #define inb		__inb
 #define inw		__inw
@@ -284,6 +300,7 @@
 #define outsb		__outsb
 #define outsw		__outsw
 #define outsl		__outsl
+#define mmiob           __mmiob
 
 /*
  * The address passed to these functions are ioremap()ped already.
diff -Naur --exclude=*~ --exclude=TAGS linux-2.4.17-ia64/include/asm-ia64/machvec.h linux-2.4.17-ia64-mmiob/include/asm-ia64/machvec.h
--- linux-2.4.17-ia64/include/asm-ia64/machvec.h	Tue Jan  8 15:45:11 2002
+++ linux-2.4.17-ia64-mmiob/include/asm-ia64/machvec.h	Tue Jan  8 15:59:44 2002
@@ -60,6 +60,7 @@
 typedef void ia64_mv_outb_t (unsigned char, unsigned long);
 typedef void ia64_mv_outw_t (unsigned short, unsigned long);
 typedef void ia64_mv_outl_t (unsigned int, unsigned long);
+typedef void ia64_mv_mmiob_t (void);
 
 extern void machvec_noop (void);
 
@@ -107,6 +108,7 @@
 #  define platform_outb		ia64_mv.outb
 #  define platform_outw		ia64_mv.outw
 #  define platform_outl		ia64_mv.outl
+#  define platofrm_mmiob        ia64_mv.mmiob
 # endif
 
 struct ia64_machine_vector {
@@ -140,6 +142,7 @@
 	ia64_mv_outb_t *outb;
 	ia64_mv_outw_t *outw;
 	ia64_mv_outl_t *outl;
+	ia64_mv_mmiob_t *mmiob;
 };
 
 #define MACHVEC_INIT(name)			\
@@ -173,7 +176,8 @@
 	platform_inl,				\
 	platform_outb,				\
 	platform_outw,				\
-	platform_outl				\
+	platform_outl,				\
+        platform_mmiob                          \
 }
 
 extern struct ia64_machine_vector ia64_mv;
@@ -287,6 +291,9 @@
 #endif
 #ifndef platform_outl
 # define platform_outl		__ia64_outl
+#endif
+#ifndef platform_mmiob
+# define platform_mmiob         __ia64_mmiob
 #endif
 
 #endif /* _ASM_IA64_MACHVEC_H */
diff -Naur --exclude=*~ --exclude=TAGS linux-2.4.17-ia64/include/asm-ia64/machvec_sn1.h linux-2.4.17-ia64-mmiob/include/asm-ia64/machvec_sn1.h
--- linux-2.4.17-ia64/include/asm-ia64/machvec_sn1.h	Tue Jan  8 15:45:11 2002
+++ linux-2.4.17-ia64-mmiob/include/asm-ia64/machvec_sn1.h	Tue Jan  8 15:45:54 2002
@@ -14,6 +14,7 @@
 extern ia64_mv_outb_t sn1_outb;
 extern ia64_mv_outw_t sn1_outw;
 extern ia64_mv_outl_t sn1_outl;
+extern ia64_mv_mmiob_t sn_mmiob;
 extern ia64_mv_pci_alloc_consistent	sn1_pci_alloc_consistent;
 extern ia64_mv_pci_free_consistent	sn1_pci_free_consistent;
 extern ia64_mv_pci_map_single		sn1_pci_map_single;
@@ -45,6 +46,7 @@
 #define platform_outb		sn1_outb
 #define platform_outw		sn1_outw
 #define platform_outl		sn1_outl
+#define platform_mmiob          sn_mmiob
 #define platform_pci_dma_init	machvec_noop
 #define platform_pci_alloc_consistent	sn1_pci_alloc_consistent
 #define platform_pci_free_consistent	sn1_pci_free_consistent
