Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUIVPqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUIVPqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUIVPqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 11:46:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6604 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266173AbUIVPpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 11:45:47 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] I/O space write barrier
Date: Wed, 22 Sep 2004 11:45:35 -0400
User-Agent: KMail/1.7
Cc: Jeremy Higdon <jeremy@sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_g4ZUB7UhqShHlPj"
Message-Id: <200409221145.36033.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_g4ZUB7UhqShHlPj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On some platforms (e.g. SGI Challenge, Origin, and Altix machines), writes to 
I/O space aren't ordered coming from different CPUs.  For the most part, this 
isn't a problem since drivers generally spinlock around code that does writeX 
calls, but if the last operation a driver does before it releases a lock is a 
write and some other CPU takes the lock and immediately does a write, it's 
possible the second CPU's write could arrive before the first's.

This patch adds a mmiowb() call to deal with this sort of situation, and 
modifies the qla1280 driver to use it.  The idea is to mirror the regular, 
cacheable memory barrier operation, wmb (arg!  I misnamed it in my patch, 
I'll fix that up in the next rev assuming it's ok).  Example:

CPU A:  spin_lock_irqsave(&dev_lock, flags)
CPU A:  ...
CPU A:  writel(newval, ring_ptr);
CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
        ...
CPU B:  spin_lock_irqsave(&dev_lock, flags)
CPU B:  writel(newval2, ring_ptr);
CPU B:  ...
CPU B:  spin_unlock_irqrestore(&dev_lock, flags)

In this case, newval2 could be written to ring_ptr before newval.  Fixing it 
is easy though:

CPU A:  spin_lock_irqsave(&dev_lock, flags)
CPU A:  ...
CPU A:  writel(newval, ring_ptr);
CPU A:  mmiowb(); /* ensure no other writes beat us to the device */
CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
        ...
CPU B:  spin_lock_irqsave(&dev_lock, flags)
CPU B:  writel(newval2, ring_ptr);
CPU B:  ...
CPU B:  mmiowb();
CPU B:  spin_unlock_irqrestore(&dev_lock, flags)

Note that this doesn't address a related case where the driver may want to 
actually make a given write get to the device before proceeding.  This should 
be dealt with by immediately reading a register from the card that has no 
side effects.  According to the PCI spec, that will guarantee that all writes 
have arrived before being sent to the target bus.  If no such register is 
available (in the case of card resets perhaps), reading from config space is 
sufficient (though it may return all ones if the card isn't responding to 
read cycles).

I'm also not quite sure if I got the ppc64 case right (and obviously I need to 
add the macro for other platforms).  The assumption is that *most* platforms 
don't have this issue, and those that do have a chipset register or CPU 
instruction to ensure ordering.  If that turns out not to be the case, we can 
add an address argument to the function.

Thanks,
Jesse

--Boundary-00=_g4ZUB7UhqShHlPj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mmiowb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mmiowb.patch"

===== Documentation/DocBook/deviceiobook.tmpl 1.4 vs edited =====
--- 1.4/Documentation/DocBook/deviceiobook.tmpl	2004-02-03 21:31:10 -08:00
+++ edited/Documentation/DocBook/deviceiobook.tmpl	2004-09-22 07:59:56 -07:00
@@ -147,8 +147,7 @@
 	compiler is not permitted to reorder the I/O sequence. When the 
 	ordering can be compiler optimised, you can use <function>
 	__readb</function> and friends to indicate the relaxed ordering. Use 
-	this with care. The <function>rmb</function> provides a read memory 
-	barrier. The <function>wmb</function> provides a write memory barrier.
+	this with care.
       </para>
 
       <para>
@@ -163,6 +162,15 @@
       </para>
 
       <para>
+	In addition to write posting, some large SMP systems (e.g. SGI
+	Challenge, Origin and Altix machines) won't strongly order writes
+	coming from different CPUs.  Thus it's important to properly
+	protect parts of your driver that do memory-mapped writes with
+	locks and use the <function>mmiob</function> to make sure they
+	arrive in the order intended.
+      </para>
+
+      <para>
 	PCI ordering rules also guarantee that PIO read responses arrive
 	after any outstanding DMA writes on that bus, since for some devices
 	the result of a <function>readb</function> call may signal to the
@@ -171,7 +179,9 @@
 	<function>readb</function> call has no relation to any previous DMA
 	writes performed by the device.  The driver can use
 	<function>readb_relaxed</function> for these cases, although only
-	some platforms will honor the relaxed semantics.
+	some platforms will honor the relaxed semantics.  Using the relaxed
+	read functions will provide significant performance benefits on
+	platforms that support it.
       </para>
     </sect1>
 
===== arch/ia64/sn/io/machvec/iomv.c 1.9 vs edited =====
--- 1.9/arch/ia64/sn/io/machvec/iomv.c	2004-05-26 06:49:19 -07:00
+++ edited/arch/ia64/sn/io/machvec/iomv.c	2004-09-22 08:33:35 -07:00
@@ -54,23 +54,19 @@
 EXPORT_SYMBOL(sn_io_addr);
 
 /**
- * sn_mmiob - I/O space memory barrier
+ * __sn_mmiowb - I/O space write barrier
  *
- * Acts as a memory mapped I/O barrier for platforms that queue writes to 
- * I/O space.  This ensures that subsequent writes to I/O space arrive after
- * all previous writes.  For most ia64 platforms, this is a simple
- * 'mf.a' instruction.  For other platforms, mmiob() may have to read
- * a chipset register to ensure ordering.
+ * See include/asm-ia64/io.h and Documentation/DocBook/deviceiobook.tmpl
+ * for details.
  *
  * On SN2, we wait for the PIO_WRITE_STATUS SHub register to clear.
  * See PV 871084 for details about the WAR about zero value.
  *
  */
-void
-sn_mmiob (void)
+void __sn_mmiowb(void)
 {
 	while ((((volatile unsigned long) (*pda->pio_write_status_addr)) & SH_PIO_WRITE_STATUS_0_PENDING_WRITE_COUNT_MASK) != 
 				SH_PIO_WRITE_STATUS_0_PENDING_WRITE_COUNT_MASK)
 		cpu_relax();
 }
-EXPORT_SYMBOL(sn_mmiob);
+EXPORT_SYMBOL(__sn_mmiowb);
===== drivers/scsi/qla1280.c 1.65 vs edited =====
--- 1.65/drivers/scsi/qla1280.c	2004-07-28 20:59:10 -07:00
+++ edited/drivers/scsi/qla1280.c	2004-09-22 08:31:46 -07:00
@@ -1715,7 +1715,7 @@
 	reg = ha->iobase;
 	/* enable risc and host interrupts */
 	WRT_REG_WORD(&reg->ictrl, (ISP_EN_INT | ISP_EN_RISC));
-	RD_REG_WORD(&reg->ictrl);	/* PCI Posted Write flush */
+	mmiowb(); /* make sure this write arrives before any others */
 	ha->flags.ints_enabled = 1;
 }
 
@@ -1727,7 +1727,7 @@
 	reg = ha->iobase;
 	/* disable risc and host interrupts */
 	WRT_REG_WORD(&reg->ictrl, 0);
-	RD_REG_WORD(&reg->ictrl);	/* PCI Posted Write flush */
+	mmiowb(); /* make sure this write arrives before any others */
 	ha->flags.ints_enabled = 0;
 }
 
@@ -3398,7 +3398,7 @@
 	sp->flags |= SRB_SENT;
 	ha->actthreads++;
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
-	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
+	mmiowb(); /* make sure this write arrives before any others */
 
  out:
 	if (status)
===== include/asm-ia64/io.h 1.19 vs edited =====
--- 1.19/include/asm-ia64/io.h	2004-02-03 21:31:10 -08:00
+++ edited/include/asm-ia64/io.h	2004-09-22 08:11:50 -07:00
@@ -91,6 +91,20 @@
  */
 #define __ia64_mf_a()	ia64_mfa()
 
+/**
+ * __ia64_mmiowb - I/O write barrier
+ *
+ * Ensure ordering of I/O space writes.  This will make sure that writes
+ * following the barrier will arrive after all previous writes.  For most
+ * ia64 platforms, this is a simple 'mf.a' instruction.
+ *
+ * See Documentation/DocBook/deviceiobook.tmpl for more information.
+ */
+static inline void __ia64_mmiowb(void)
+{
+	ia64_mfa();
+}
+
 static inline const unsigned long
 __ia64_get_io_port_base (void)
 {
@@ -267,6 +281,7 @@
 #define __outb		platform_outb
 #define __outw		platform_outw
 #define __outl		platform_outl
+#define __mmiowb	platform_mmiowb
 
 #define inb(p)		__inb(p)
 #define inw(p)		__inw(p)
@@ -280,6 +295,7 @@
 #define outsb(p,s,c)	__outsb(p,s,c)
 #define outsw(p,s,c)	__outsw(p,s,c)
 #define outsl(p,s,c)	__outsl(p,s,c)
+#define mmiowb()	__mmiowb()
 
 /*
  * The address passed to these functions are ioremap()ped already.
===== include/asm-ia64/machvec.h 1.26 vs edited =====
--- 1.26/include/asm-ia64/machvec.h	2004-08-03 16:05:22 -07:00
+++ edited/include/asm-ia64/machvec.h	2004-09-22 08:12:33 -07:00
@@ -62,6 +62,7 @@
 typedef void ia64_mv_outb_t (unsigned char, unsigned long);
 typedef void ia64_mv_outw_t (unsigned short, unsigned long);
 typedef void ia64_mv_outl_t (unsigned int, unsigned long);
+typedef void ia64_mv_mmiowb_t (void);
 typedef unsigned char ia64_mv_readb_t (void *);
 typedef unsigned short ia64_mv_readw_t (void *);
 typedef unsigned int ia64_mv_readl_t (void *);
@@ -130,6 +131,7 @@
 #  define platform_outb		ia64_mv.outb
 #  define platform_outw		ia64_mv.outw
 #  define platform_outl		ia64_mv.outl
+#  define platform_mmiowb	ia64_mv.mmiowb
 #  define platform_readb        ia64_mv.readb
 #  define platform_readw        ia64_mv.readw
 #  define platform_readl        ia64_mv.readl
@@ -176,6 +178,7 @@
 	ia64_mv_outb_t *outb;
 	ia64_mv_outw_t *outw;
 	ia64_mv_outl_t *outl;
+	ia64_mv_mmiowb_t *mmiowb;
 	ia64_mv_readb_t *readb;
 	ia64_mv_readw_t *readw;
 	ia64_mv_readl_t *readl;
@@ -218,6 +221,7 @@
 	platform_outb,				\
 	platform_outw,				\
 	platform_outl,				\
+	platform_mmiowb,			\
 	platform_readb,				\
 	platform_readw,				\
 	platform_readl,				\
@@ -343,6 +347,9 @@
 #endif
 #ifndef platform_outl
 # define platform_outl		__ia64_outl
+#endif
+#ifndef platform_mmiowb
+# define platform_mmiowb	__ia64_mmiowb
 #endif
 #ifndef platform_readb
 # define platform_readb		__ia64_readb
===== include/asm-ia64/machvec_init.h 1.7 vs edited =====
--- 1.7/include/asm-ia64/machvec_init.h	2004-02-06 00:30:24 -08:00
+++ edited/include/asm-ia64/machvec_init.h	2004-09-22 08:13:45 -07:00
@@ -12,6 +12,7 @@
 extern ia64_mv_outb_t __ia64_outb;
 extern ia64_mv_outw_t __ia64_outw;
 extern ia64_mv_outl_t __ia64_outl;
+extern ia64_mv_mmiowb_t __ia64_mmiowb;
 extern ia64_mv_readb_t __ia64_readb;
 extern ia64_mv_readw_t __ia64_readw;
 extern ia64_mv_readl_t __ia64_readl;
===== include/asm-ia64/machvec_sn2.h 1.14 vs edited =====
--- 1.14/include/asm-ia64/machvec_sn2.h	2004-07-10 17:14:00 -07:00
+++ edited/include/asm-ia64/machvec_sn2.h	2004-09-22 08:14:03 -07:00
@@ -49,6 +49,7 @@
 extern ia64_mv_outb_t __sn_outb;
 extern ia64_mv_outw_t __sn_outw;
 extern ia64_mv_outl_t __sn_outl;
+extern ia64_mv_mmiowb_t __sn_mmiowb;
 extern ia64_mv_readb_t __sn_readb;
 extern ia64_mv_readw_t __sn_readw;
 extern ia64_mv_readl_t __sn_readl;
@@ -92,6 +93,7 @@
 #define platform_outb			__sn_outb
 #define platform_outw			__sn_outw
 #define platform_outl			__sn_outl
+#define platform_mmiowb			__sn_mmiowb
 #define platform_readb			__sn_readb
 #define platform_readw			__sn_readw
 #define platform_readl			__sn_readl
===== include/asm-ia64/sn/io.h 1.7 vs edited =====
--- 1.7/include/asm-ia64/sn/io.h	2004-02-13 07:00:22 -08:00
+++ edited/include/asm-ia64/sn/io.h	2004-09-22 08:32:52 -07:00
@@ -58,8 +58,8 @@
 #include <asm/sn/sn2/shubio.h>
 
 /*
- * Used to ensure write ordering (like mb(), but for I/O space)
+ * Used to ensure write ordering
  */
-extern void sn_mmiob(void);
+extern void __sn_mmiowb(void);
 
 #endif /* _ASM_IA64_SN_IO_H */
===== include/asm-ia64/sn/sn2/io.h 1.6 vs edited =====
--- 1.6/include/asm-ia64/sn/sn2/io.h	2004-07-22 17:00:00 -07:00
+++ edited/include/asm-ia64/sn/sn2/io.h	2004-09-22 08:15:12 -07:00
@@ -11,8 +11,10 @@
 #include <linux/compiler.h>
 #include <asm/intrinsics.h>
 
-extern void * sn_io_addr(unsigned long port) __attribute_const__; /* Forward definition */
-extern void sn_mmiob(void); /* Forward definition */
+/* Forward declarations */
+struct device;
+extern void *sn_io_addr(unsigned long port) __attribute_const__;
+extern void __sn_mmiowb(void);
 
 #define __sn_mf_a()   ia64_mfa()
 
@@ -91,7 +93,7 @@
 
 	if ((addr = sn_io_addr(port))) {
 		*addr = val;
-		sn_mmiob();
+		__sn_mmiowb();
 	}
 }
 
@@ -102,7 +104,7 @@
 
 	if ((addr = sn_io_addr(port))) {
 		*addr = val;
-		sn_mmiob();
+		__sn_mmiowb();
 	}
 }
 
@@ -113,7 +115,7 @@
 
 	if ((addr = sn_io_addr(port))) {
 		*addr = val;
-		sn_mmiob();
+		__sn_mmiowb();
 	}
 }
 
===== include/asm-mips/io.h 1.7 vs edited =====
--- 1.7/include/asm-mips/io.h	2004-02-19 12:53:02 -08:00
+++ edited/include/asm-mips/io.h	2004-09-22 08:24:53 -07:00
@@ -290,6 +290,9 @@
 #define __raw_writeb(b,addr)	((*(volatile unsigned char *)(addr)) = (b))
 #define __raw_writew(w,addr)	((*(volatile unsigned short *)(addr)) = (w))
 #define __raw_writel(l,addr)	((*(volatile unsigned int *)(addr)) = (l))
+
+#define mmiowb() asm volatile ("sync" ::: "memory")
+
 #ifdef CONFIG_MIPS32
 #define ____raw_writeq(val,addr)						\
 ({									\
===== include/asm-ppc64/io.h 1.21 vs edited =====
--- 1.21/include/asm-ppc64/io.h	2004-09-13 11:31:52 -07:00
+++ edited/include/asm-ppc64/io.h	2004-09-22 08:24:12 -07:00
@@ -152,6 +152,8 @@
 extern void _insl_ns(volatile u32 *port, void *buf, int nl);
 extern void _outsl_ns(volatile u32 *port, const void *buf, int nl);
 
+#define mmiowb() asm volatile ("eieio" ::: "memory")
+
 /*
  * output pause versions need a delay at least for the
  * w83c105 ide controller in a p610.

--Boundary-00=_g4ZUB7UhqShHlPj--
