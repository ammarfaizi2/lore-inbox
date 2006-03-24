Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422761AbWCXHxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422761AbWCXHxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422756AbWCXHxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:53:20 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:60385 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422761AbWCXHxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:53:18 -0500
Message-ID: <4423A4EB.2030804@jp.fujitsu.com>
Date: Fri, 24 Mar 2006 16:51:07 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 5/6] PCIERR : interfaces for synchronous I/O error detection
 on driver (poison)
References: <44210D1B.7010806@jp.fujitsu.com> <20060322210157.GH12335@kroah.com>
In-Reply-To: <20060322210157.GH12335@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is 4/4 of PCIERR implementation for IA64.

This part defines ia64_mca_barrier.
This barrier makes sure that the passed value is poisoned or not.
It can say that this will work as light-version of PAL_MC_DRAIN.
Please refer the comment in patch to get more detail.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

-----
  arch/ia64/kernel/mca.c     |    4 +
  arch/ia64/kernel/mca_asm.S |   30 +++++++++++++
  include/asm-ia64/io.h      |   98 +++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 132 insertions(+)

Index: linux-2.6.16_WORK/arch/ia64/kernel/mca.c
===================================================================
--- linux-2.6.16_WORK.orig/arch/ia64/kernel/mca.c
+++ linux-2.6.16_WORK/arch/ia64/kernel/mca.c
@@ -103,6 +103,10 @@
  /* In mca_asm.S */
  extern void			ia64_os_init_dispatch_monarch (void);
  extern void			ia64_os_init_dispatch_slave (void);
+#ifdef CONFIG_PCIERR_CHECK
+extern void			ia64_mca_barrier (unsigned long value);
+EXPORT_SYMBOL(ia64_mca_barrier);
+#endif

  static int monarch_cpu = -1;

Index: linux-2.6.16_WORK/arch/ia64/kernel/mca_asm.S
===================================================================
--- linux-2.6.16_WORK.orig/arch/ia64/kernel/mca_asm.S
+++ linux-2.6.16_WORK/arch/ia64/kernel/mca_asm.S
@@ -19,6 +19,9 @@
  // 12/08/05 Keith Owens <kaos@sgi.com>
  //		   Use per cpu MCA/INIT stacks for all data.
  //
+// 06/03/22 Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
+//		   Added ia64_mca_barrier.
+//
  #include <linux/config.h>
  #include <linux/threads.h>

@@ -39,6 +42,7 @@
  	.global ia64_os_mca_dispatch
  	.global ia64_os_init_dispatch_monarch
  	.global ia64_os_init_dispatch_slave
+	.global ia64_mca_barrier

  	.text
  	.align 16
@@ -413,6 +417,32 @@

  //EndMain//////////////////////////////////////////////////////////////////////

+//StartMain////////////////////////////////////////////////////////////////////
+
+//
+// ia64_mca_barrier:
+//
+// Some chipset may poison the data read, instead of signaling a BERR.
+// The consummation of poisoned data triggers a MCA, which tells us the
+// polluted address.
+// Note that the read operation by itself does not consume the bad data,
+// so we have to do something with it before it is too late.
+//
+// Calling this function forces a consumption of the passed value since
+// the compiler will have to copy it from whatever register it was in to
+// an "out" register to pass to the function.
+// To avoid possible optimization by compiler, and to make doubly sure,
+// this assenbly clearly consumes the value by moving it to r8.
+//
+// In this way, the value is guaranteed secure, not poisoned, and sanity.
+//
+
+ia64_mca_barrier:
+	mov	r8=r32
+	br.ret.sptk.many rp
+
+//EndMain//////////////////////////////////////////////////////////////////////
+
  // common defines for the stubs
  #define	ms		r4
  #define	regs		r5
Index: linux-2.6.16_WORK/include/asm-ia64/io.h
===================================================================
--- linux-2.6.16_WORK.orig/include/asm-ia64/io.h
+++ linux-2.6.16_WORK/include/asm-ia64/io.h
@@ -165,6 +165,51 @@
   * during optimization, which is why we use "volatile" pointers.
   */

+#ifdef CONFIG_PCIERR_CHECK
+
+extern void ia64_mca_barrier(unsigned long value);
+
+static inline unsigned int
+___ia64_inb (unsigned long port)
+{
+	volatile unsigned char *addr = __ia64_mk_io_addr(port);
+	unsigned char ret;
+
+	ret = *addr;
+	__ia64_mf_a();
+	ia64_mca_barrier(ret);
+
+	return ret;
+}
+
+static inline unsigned int
+___ia64_inw (unsigned long port)
+{
+	volatile unsigned short *addr = __ia64_mk_io_addr(port);
+	unsigned short ret;
+
+	ret = *addr;
+	__ia64_mf_a();
+	ia64_mca_barrier(ret);
+
+	return ret;
+}
+
+static inline unsigned int
+___ia64_inl (unsigned long port)
+{
+	volatile unsigned int *addr = __ia64_mk_io_addr(port);
+	unsigned int ret;
+
+	ret = *addr;
+	__ia64_mf_a();
+	ia64_mca_barrier(ret);
+
+	return ret;
+}
+
+#else /* CONFIG_PCIERR_CHECK */
+
  static inline unsigned int
  ___ia64_inb (unsigned long port)
  {
@@ -198,6 +243,8 @@
  	return ret;
  }

+#endif /* CONFIG_PCIERR_CHECK */
+
  static inline void
  ___ia64_outb (unsigned char val, unsigned long port)
  {
@@ -314,6 +361,55 @@
   * a good idea).  Writes are ok though for all existing ia64 platforms (and
   * hopefully it'll stay that way).
   */
+
+#ifdef CONFIG_PCIERR_CHECK
+
+static inline unsigned char
+___ia64_readb (const volatile void __iomem *addr)
+{
+	unsigned char val;
+
+	val = *(volatile unsigned char __force *)addr;
+	ia64_mca_barrier(val);
+
+	return val;
+}
+
+static inline unsigned short
+___ia64_readw (const volatile void __iomem *addr)
+{
+	unsigned short val;
+
+	val = *(volatile unsigned short __force *)addr;
+	ia64_mca_barrier(val);
+
+	return val;
+}
+
+static inline unsigned int
+___ia64_readl (const volatile void __iomem *addr)
+{
+	unsigned int val;
+
+	val = *(volatile unsigned int __force *) addr;
+	ia64_mca_barrier(val);
+
+	return val;
+}
+
+static inline unsigned long
+___ia64_readq (const volatile void __iomem *addr)
+{
+	unsigned long val;
+
+	val = *(volatile unsigned long __force *) addr;
+	ia64_mca_barrier(val);
+
+	return val;
+}
+
+#else /* CONFIG_PCIERR_CHECK */
+
  static inline unsigned char
  ___ia64_readb (const volatile void __iomem *addr)
  {
@@ -338,6 +434,8 @@
  	return *(volatile unsigned long __force *) addr;
  }

+#endif /* CONFIG_PCIERR_CHECK */
+
  static inline void
  __writeb (unsigned char val, volatile void __iomem *addr)
  {

