Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUI0SG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUI0SG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUI0SG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:06:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:52882 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266888AbUI0SEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:04:04 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] I/O space write barrier
Date: Mon, 27 Sep 2004 11:03:39 -0700
User-Agent: KMail/1.7
Cc: gnb@sgi.com, jeremy@sgi.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7XFWBGWpeC6ab3r"
Message-Id: <200409271103.39913.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_7XFWBGWpeC6ab3r
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received a few comments and no complaints, so I'm sending this patch in for 
inclusion.

On some platforms (e.g. SGI Challenge, Origin, and Altix machines), writes to 
I/O space aren't ordered coming from different CPUs.  For the most part, this 
isn't a problem since drivers generally spinlock around code that does writeX 
calls, but if the last operation a driver does before it releases a lock is a 
write and some other CPU takes the lock and immediately does a write, it's 
possible the second CPU's write could arrive before the first's.

This patch adds a mmiowb() call to deal with this sort of situation, and 
adds some documentation describing I/O ordering issues to deviceiobook.tmpl.  
The idea is to mirror the regular, cacheable memory barrier operation, wmb.  
Example of the problem this new macro solves:

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
read cycles).  I've tried to describe how mmiowb() differs from PCI posted 
write flushing in the patch to deviceiobook.tmpl.

Patches to use this new primitive in various drivers will come separately, 
probably via the SCSI tree.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_7XFWBGWpeC6ab3r
Content-Type: text/plain;
  charset="us-ascii";
  name="mmiowb-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mmiowb-3.patch"

diff -Nru a/Documentation/DocBook/deviceiobook.tmpl b/Documentation/DocBook/deviceiobook.tmpl
--- a/Documentation/DocBook/deviceiobook.tmpl	2004-09-27 10:48:41 -07:00
+++ b/Documentation/DocBook/deviceiobook.tmpl	2004-09-27 10:48:41 -07:00
@@ -147,8 +147,7 @@
 	compiler is not permitted to reorder the I/O sequence. When the 
 	ordering can be compiler optimised, you can use <function>
 	__readb</function> and friends to indicate the relaxed ordering. Use 
-	this with care. The <function>rmb</function> provides a read memory 
-	barrier. The <function>wmb</function> provides a write memory barrier.
+	this with care.
       </para>
 
       <para>
@@ -159,10 +158,72 @@
 	asynchronously. A driver author must issue a read from the same
 	device to ensure that writes have occurred in the specific cases the
 	author cares. This kind of property cannot be hidden from driver
-	writers in the API.
+	writers in the API.  In some cases, the read used to flush the device
+	may be expected to fail (if the card is resetting, for example).  In
+	that case, the read should be done from config space, which is
+	guaranteed to soft-fail if the card doesn't respond.
       </para>
 
       <para>
+	The following is an example of flushing a write to a device when
+	the driver would like to ensure the write's effects are visible prior
+	to continuing execution.
+      </para>
+
+<programlisting>
+static inline void
+qla1280_disable_intrs(struct scsi_qla_host *ha)
+{
+	struct device_reg *reg;
+
+	reg = ha->iobase;
+	/* disable risc and host interrupts */
+	WRT_REG_WORD(&reg->ictrl, 0);
+	/*
+	 * The following read will ensure that the above write
+	 * has been received by the device before we return from this
+	 * function.
+	 */
+	RD_REG_WORD(&reg->ictrl);
+	ha->flags.ints_enabled = 0;
+}
+</programlisting>
+
+      <para>
+	In addition to write posting, some large SMP systems (e.g. SGI
+	Challenge, Origin and Altix machines) won't strongly order writes
+	coming from different CPUs.  Thus it's important to properly
+	protect parts of your driver that do memory-mapped writes with
+	locks and use the <function>mmiob</function> to make sure they
+	arrive in the order intended.
+      </para>
+
+      <para>
+	Generally, one should use <function>mmiowb</function> prior to
+	releasing a spinlock that protects regions using <function>writeb
+	</function> or similar functions that aren't surrounded by <function>
+	readb</function> calls, which will ensure ordering and flushing.  The
+	following example (again from qla1280.c) illustrates its use.
+      </para>
+
+<programlisting>
+       sp->flags |= SRB_SENT;
+       ha->actthreads++;
+       WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
+
+       /*
+        * A Memory Mapped I/O Write Barrier is needed to ensure that this write
+        * of the request queue in register is ordered ahead of writes issued
+        * after this one by other CPUs.  Access to the register is protected
+        * by the host_lock.  Without the mmiowb, however, it is possible for
+        * this CPU to release the host lock, another CPU acquire the host lock,
+        * and write to the request queue in, and have the second write make it
+        * to the chip first.
+        */
+       mmiowb(); /* posted write ordering */
+</programlisting>
+
+      <para>
 	PCI ordering rules also guarantee that PIO read responses arrive
 	after any outstanding DMA writes on that bus, since for some devices
 	the result of a <function>readb</function> call may signal to the
@@ -171,7 +232,9 @@
 	<function>readb</function> call has no relation to any previous DMA
 	writes performed by the device.  The driver can use
 	<function>readb_relaxed</function> for these cases, although only
-	some platforms will honor the relaxed semantics.
+	some platforms will honor the relaxed semantics.  Using the relaxed
+	read functions will provide significant performance benefits on
+	platforms that support it.
       </para>
     </sect1>
 
diff -Nru a/Documentation/io_ordering.txt b/Documentation/io_ordering.txt
--- a/Documentation/io_ordering.txt	2004-09-27 10:48:41 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,47 +0,0 @@
-On some platforms, so-called memory-mapped I/O is weakly ordered.  On such
-platforms, driver writers are responsible for ensuring that I/O writes to
-memory-mapped addresses on their device arrive in the order intended.  This is
-typically done by reading a 'safe' device or bridge register, causing the I/O
-chipset to flush pending writes to the device before any reads are posted.  A
-driver would usually use this technique immediately prior to the exit of a
-critical section of code protected by spinlocks.  This would ensure that
-subsequent writes to I/O space arrived only after all prior writes (much like a
-memory barrier op, mb(), only with respect to I/O).
-
-A more concrete example from a hypothetical device driver:
-
-        ...
-CPU A:  spin_lock_irqsave(&dev_lock, flags)
-CPU A:  val = readl(my_status);
-CPU A:  ...
-CPU A:  writel(newval, ring_ptr);
-CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
-        ...
-CPU B:  spin_lock_irqsave(&dev_lock, flags)
-CPU B:  val = readl(my_status);
-CPU B:  ...
-CPU B:  writel(newval2, ring_ptr);
-CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
-        ...
-
-In the case above, the device may receive newval2 before it receives newval,
-which could cause problems.  Fixing it is easy enough though:
-
-        ...
-CPU A:  spin_lock_irqsave(&dev_lock, flags)
-CPU A:  val = readl(my_status);
-CPU A:  ...
-CPU A:  writel(newval, ring_ptr);
-CPU A:  (void)readl(safe_register); /* maybe a config register? */
-CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
-        ...
-CPU B:  spin_lock_irqsave(&dev_lock, flags)
-CPU B:  val = readl(my_status);
-CPU B:  ...
-CPU B:  writel(newval2, ring_ptr);
-CPU B:  (void)readl(safe_register); /* maybe a config register? */
-CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
-
-Here, the reads from safe_register will cause the I/O chipset to flush any
-pending writes before actually posting the read to the chipset, preventing
-possible data corruption.
diff -Nru a/arch/ia64/sn/io/machvec/iomv.c b/arch/ia64/sn/io/machvec/iomv.c
--- a/arch/ia64/sn/io/machvec/iomv.c	2004-09-27 10:48:41 -07:00
+++ b/arch/ia64/sn/io/machvec/iomv.c	2004-09-27 10:48:41 -07:00
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
diff -Nru a/include/asm-alpha/io.h b/include/asm-alpha/io.h
--- a/include/asm-alpha/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-alpha/io.h	2004-09-27 10:48:41 -07:00
@@ -489,6 +489,8 @@
 #define readl_relaxed(addr) __raw_readl(addr)
 #define readq_relaxed(addr) __raw_readq(addr)
 
+#define mmiowb()
+
 /*
  * String version of IO memory access ops:
  */
diff -Nru a/include/asm-arm/io.h b/include/asm-arm/io.h
--- a/include/asm-arm/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-arm/io.h	2004-09-27 10:48:41 -07:00
@@ -135,6 +135,8 @@
 extern void _memcpy_toio(unsigned long, const void *, size_t);
 extern void _memset_io(unsigned long, int, size_t);
 
+#define mmiowb()
+
 /*
  *  Memory access primitives
  *  ------------------------
diff -Nru a/include/asm-arm26/io.h b/include/asm-arm26/io.h
--- a/include/asm-arm26/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-arm26/io.h	2004-09-27 10:48:41 -07:00
@@ -320,6 +320,8 @@
 #define writesw(p,d,l)                        __readwrite_bug("writesw")
 #define writesl(p,d,l)                        __readwrite_bug("writesl")
 
+#define mmiowb()
+
 /* the following macro is depreciated */
 #define ioaddr(port)                    __ioaddr((port))
 
diff -Nru a/include/asm-cris/io.h b/include/asm-cris/io.h
--- a/include/asm-cris/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-cris/io.h	2004-09-27 10:48:41 -07:00
@@ -56,6 +56,8 @@
 #define __raw_writew writew
 #define __raw_writel writel
 
+#define mmiowb()
+
 #define memset_io(a,b,c)	memset((void *)(a),(b),(c))
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
diff -Nru a/include/asm-h8300/io.h b/include/asm-h8300/io.h
--- a/include/asm-h8300/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-h8300/io.h	2004-09-27 10:48:41 -07:00
@@ -200,6 +200,8 @@
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+#define mmiowb()
+
 #define inb(addr)    ((h8300_buswidth(addr))?readw((addr) & ~1) & 0xff:readb(addr))
 #define inw(addr)    _swapw(readw(addr))
 #define inl(addr)    _swapl(readl(addr))
diff -Nru a/include/asm-i386/io.h b/include/asm-i386/io.h
--- a/include/asm-i386/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-i386/io.h	2004-09-27 10:48:41 -07:00
@@ -178,6 +178,8 @@
 #define __raw_writew writew
 #define __raw_writel writel
 
+#define mmiowb()
+
 static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
 	memset((void __force *) addr, val, count);
diff -Nru a/include/asm-ia64/io.h b/include/asm-ia64/io.h
--- a/include/asm-ia64/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-ia64/io.h	2004-09-27 10:48:41 -07:00
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
diff -Nru a/include/asm-ia64/machvec.h b/include/asm-ia64/machvec.h
--- a/include/asm-ia64/machvec.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-ia64/machvec.h	2004-09-27 10:48:41 -07:00
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
diff -Nru a/include/asm-ia64/machvec_init.h b/include/asm-ia64/machvec_init.h
--- a/include/asm-ia64/machvec_init.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-ia64/machvec_init.h	2004-09-27 10:48:41 -07:00
@@ -12,6 +12,7 @@
 extern ia64_mv_outb_t __ia64_outb;
 extern ia64_mv_outw_t __ia64_outw;
 extern ia64_mv_outl_t __ia64_outl;
+extern ia64_mv_mmiowb_t __ia64_mmiowb;
 extern ia64_mv_readb_t __ia64_readb;
 extern ia64_mv_readw_t __ia64_readw;
 extern ia64_mv_readl_t __ia64_readl;
diff -Nru a/include/asm-ia64/machvec_sn2.h b/include/asm-ia64/machvec_sn2.h
--- a/include/asm-ia64/machvec_sn2.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-ia64/machvec_sn2.h	2004-09-27 10:48:41 -07:00
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
diff -Nru a/include/asm-ia64/sn/io.h b/include/asm-ia64/sn/io.h
--- a/include/asm-ia64/sn/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-ia64/sn/io.h	2004-09-27 10:48:41 -07:00
@@ -58,8 +58,8 @@
 #include <asm/sn/sn2/shubio.h>
 
 /*
- * Used to ensure write ordering (like mb(), but for I/O space)
+ * Used to ensure write ordering
  */
-extern void sn_mmiob(void);
+extern void __sn_mmiowb(void);
 
 #endif /* _ASM_IA64_SN_IO_H */
diff -Nru a/include/asm-ia64/sn/sn2/io.h b/include/asm-ia64/sn/sn2/io.h
--- a/include/asm-ia64/sn/sn2/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-ia64/sn/sn2/io.h	2004-09-27 10:48:41 -07:00
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
 
diff -Nru a/include/asm-m32r/io.h b/include/asm-m32r/io.h
--- a/include/asm-m32r/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-m32r/io.h	2004-09-27 10:48:41 -07:00
@@ -150,6 +150,9 @@
 #define __raw_readb readb
 #define __raw_readw readw
 #define __raw_readl readl
+#define readb_relaxed readb
+#define readw_relaxed readw
+#define readl_relaxed readl
 
 #define writeb(val, addr)  _writeb((val), (unsigned long)(addr))
 #define writew(val, addr)  _writew((val), (unsigned long)(addr))
@@ -157,6 +160,8 @@
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
+
+#define mmiowb()
 
 #define flush_write_buffers() do { } while (0)  /* M32R_FIXME */
 
diff -Nru a/include/asm-m68k/io.h b/include/asm-m68k/io.h
--- a/include/asm-m68k/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-m68k/io.h	2004-09-27 10:48:41 -07:00
@@ -306,6 +306,7 @@
 #endif
 #endif /* CONFIG_PCI */
 
+#define mmiowb()
 
 static inline void *ioremap(unsigned long physaddr, unsigned long size)
 {
diff -Nru a/include/asm-m68knommu/io.h b/include/asm-m68knommu/io.h
--- a/include/asm-m68knommu/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-m68knommu/io.h	2004-09-27 10:48:41 -07:00
@@ -102,6 +102,8 @@
 		*bp++ = _swapl(*ap);
 }
 
+#define mmiowb()
+
 /*
  *	make the short names macros so specific devices
  *	can override them as required
diff -Nru a/include/asm-mips/io.h b/include/asm-mips/io.h
--- a/include/asm-mips/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-mips/io.h	2004-09-27 10:48:41 -07:00
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
diff -Nru a/include/asm-parisc/io.h b/include/asm-parisc/io.h
--- a/include/asm-parisc/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-parisc/io.h	2004-09-27 10:48:41 -07:00
@@ -177,6 +177,8 @@
 #define readl_relaxed(addr) readl(addr)
 #define readq_relaxed(addr) readq(addr)
 
+#define mmiowb()
+
 extern void __memcpy_fromio(unsigned long dest, unsigned long src, int count);
 extern void __memcpy_toio(unsigned long dest, unsigned long src, int count);
 extern void __memset_io(unsigned long dest, char fill, int count);
diff -Nru a/include/asm-ppc/io.h b/include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-ppc/io.h	2004-09-27 10:48:41 -07:00
@@ -197,6 +197,8 @@
 #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
+#define mmiowb() asm volatile ("eieio" ::: "memory")
+
 /*
  * Map in an area of physical address space, for accessing
  * I/O devices etc.
diff -Nru a/include/asm-ppc64/io.h b/include/asm-ppc64/io.h
--- a/include/asm-ppc64/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-ppc64/io.h	2004-09-27 10:48:41 -07:00
@@ -152,6 +152,8 @@
 extern void _insl_ns(volatile u32 *port, void *buf, int nl);
 extern void _outsl_ns(volatile u32 *port, const void *buf, int nl);
 
+#define mmiowb() asm volatile ("eieio" ::: "memory")
+
 /*
  * output pause versions need a delay at least for the
  * w83c105 ide controller in a p610.
diff -Nru a/include/asm-s390/io.h b/include/asm-s390/io.h
--- a/include/asm-s390/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-s390/io.h	2004-09-27 10:48:41 -07:00
@@ -105,6 +105,8 @@
 #define outb(x,addr) ((void) writeb(x,addr))
 #define outb_p(x,addr) outb(x,addr)
 
+#define mmiowb()
+
 #endif /* __KERNEL__ */
 
 #endif
diff -Nru a/include/asm-sh/io.h b/include/asm-sh/io.h
--- a/include/asm-sh/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-sh/io.h	2004-09-27 10:48:41 -07:00
@@ -134,6 +134,8 @@
 #define readw_relaxed(a) readw(a)
 #define readl_relaxed(a) readl(a)
 
+#define mmiowb()
+
 /*
  * If the platform has PC-like I/O, this function converts the offset into
  * an address.
diff -Nru a/include/asm-sh64/io.h b/include/asm-sh64/io.h
--- a/include/asm-sh64/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-sh64/io.h	2004-09-27 10:48:41 -07:00
@@ -86,6 +86,9 @@
 #define readb(addr)		sh64_in8(addr)
 #define readw(addr)		sh64_in16(addr)
 #define readl(addr)		sh64_in32(addr)
+#define readb_relaxed(addr)		sh64_in8(addr)
+#define readw_relaxed(addr)		sh64_in16(addr)
+#define readl_relaxed(addr)		sh64_in32(addr)
 
 #define writeb(b, addr)		sh64_out8(b, addr)
 #define writew(b, addr)		sh64_out16(b, addr)
@@ -105,6 +108,8 @@
 void outb(unsigned long value, unsigned long port);
 void outw(unsigned long value, unsigned long port);
 void outl(unsigned long value, unsigned long port);
+
+#define mmiowb()
 
 #ifdef __KERNEL__
 
diff -Nru a/include/asm-sparc/io.h b/include/asm-sparc/io.h
--- a/include/asm-sparc/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-sparc/io.h	2004-09-27 10:48:41 -07:00
@@ -23,6 +23,8 @@
 	return ((w&0xff) << 8) | ((w>>8)&0xff);
 }
 
+#define mmiowb()
+
 /*
  * Memory mapped I/O to PCI
  *
diff -Nru a/include/asm-sparc64/io.h b/include/asm-sparc64/io.h
--- a/include/asm-sparc64/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-sparc64/io.h	2004-09-27 10:48:41 -07:00
@@ -439,6 +439,8 @@
 	return retval;
 }
 
+#define mmiowb()
+
 #ifdef __KERNEL__
 
 /* On sparc64 we have the whole physical IO address space accessible
diff -Nru a/include/asm-v850/io.h b/include/asm-v850/io.h
--- a/include/asm-v850/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-v850/io.h	2004-09-27 10:48:41 -07:00
@@ -102,6 +102,8 @@
 #define ioremap_writethrough(physaddr, size)	(physaddr)
 #define ioremap_fullcache(physaddr, size)	(physaddr)
 
+#define mmiowb()
+
 #define page_to_phys(page)      ((page - mem_map) << PAGE_SHIFT)
 #if 0
 /* This is really stupid; don't define it.  */
diff -Nru a/include/asm-x86_64/io.h b/include/asm-x86_64/io.h
--- a/include/asm-x86_64/io.h	2004-09-27 10:48:41 -07:00
+++ b/include/asm-x86_64/io.h	2004-09-27 10:48:41 -07:00
@@ -186,6 +186,8 @@
 #define __raw_readl readl
 #define __raw_readq readq
 
+#define mmiowb()
+
 #ifdef CONFIG_UNORDERED_IO
 static inline void __writel(u32 val, void *addr)
 {

--Boundary-00=_7XFWBGWpeC6ab3r--
