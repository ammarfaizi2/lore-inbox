Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271209AbUJVCTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271209AbUJVCTc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271194AbUJVCT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:19:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:41649 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S271087AbUJVCRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:17:35 -0400
Subject: [PATCH] ppc: Disable IRQ probe on ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098411405.6008.50.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 12:16:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The current "generic" implementation of IRQ probing isn't well suited
for ppc in it's current form, and causes issues with yenta_socket
(and possibly others) on pmac laptops. We didn't have a probe implementation
in the past, we probably don't need one anyway, so for now, the fix is to
make this optional and enable it on x86 and x86_64 but not ppc and ppc64
(the 4 archs to use the generic IRQ code).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/kernel/irq/Makefile
===================================================================
--- linux-work.orig/kernel/irq/Makefile	2004-10-22 10:40:03.000000000 +1000
+++ linux-work/kernel/irq/Makefile	2004-10-22 11:32:45.105850448 +1000
@@ -1,4 +1,5 @@
 
-obj-y := autoprobe.o handle.o manage.o spurious.o
+obj-y := handle.o manage.o spurious.o
+obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
Index: linux-work/include/linux/interrupt.h
===================================================================
--- linux-work.orig/include/linux/interrupt.h	2004-10-20 13:01:04.000000000 +1000
+++ linux-work/include/linux/interrupt.h	2004-10-22 11:45:24.742368144 +1000
@@ -252,8 +252,24 @@
  * or zero if none occurred, or a negative irq number
  * if more than one irq occurred.
  */
+
+#if defined(CONFIG_GENERIC_HARDIRQS) && !defined(CONFIG_GENERIC_IRQ_PROBE) 
+static inline unsigned long probe_irq_on(void)
+{
+	return 0;
+}
+static inline int probe_irq_off(unsigned long val)
+{
+	return 0;
+}
+static inline unsigned int probe_irq_mask(unsigned long val)
+{
+	return 0;
+}
+#else
 extern unsigned long probe_irq_on(void);	/* returns 0 on failure */
 extern int probe_irq_off(unsigned long);	/* returns 0 or negative on failure */
 extern unsigned int probe_irq_mask(unsigned long);	/* returns mask of ISA interrupts */
+#endif
 
 #endif
Index: linux-work/arch/x86_64/Kconfig
===================================================================
--- linux-work.orig/arch/x86_64/Kconfig	2004-10-21 11:47:01.000000000 +1000
+++ linux-work/arch/x86_64/Kconfig	2004-10-22 11:36:04.036608376 +1000
@@ -346,6 +346,10 @@
 	bool
 	default y
 
+config GENERIC_IRQ_PROBE
+	bool
+	default y
+
 menu "Power management options"
 
 source kernel/power/Kconfig
Index: linux-work/arch/i386/Kconfig
===================================================================
--- linux-work.orig/arch/i386/Kconfig	2004-10-21 11:47:00.000000000 +1000
+++ linux-work/arch/i386/Kconfig	2004-10-22 11:35:11.273629568 +1000
@@ -1207,6 +1207,10 @@
 	bool
 	default y
 
+config GENERIC_IRQ_PROBE
+	bool
+	default y
+
 config X86_SMP
 	bool
 	depends on SMP && !X86_VOYAGER


