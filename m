Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVF3SJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVF3SJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVF3SJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:09:32 -0400
Received: from [85.8.12.41] ([85.8.12.41]:26810 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262839AbVF3SG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:06:27 -0400
Message-ID: <42C432BB.407@drzeus.cx>
Date: Thu, 30 Jun 2005 19:58:19 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-26945-1120154784-0001-2"
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 2/2] ISA DMA suspend for x86_64
References: <42987450.9000601@drzeus.cx>	 <1117288285.2685.10.camel@localhost.localdomain>	 <42A2B610.1020408@drzeus.cx> <42A3061C.7010604@drzeus.cx>	 <42B1A08B.8080601@drzeus.cx> <20050616170622.A1712@flint.arm.linux.org.uk>	 <42C3A698.9020404@drzeus.cx> <1120130926.6482.83.camel@localhost.localdomain> <42C3E3A4.3090305@drzeus.cx>
In-Reply-To: <42C3E3A4.3090305@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-26945-1120154784-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Reset the ISA DMA controller into a known state after a suspend. Primary
concern was reenabling the cascading DMA channel (4).

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

Word of warning, I haven't tested this platform since I don't have any
x86_64 hardware. But it shouldn't differ from i386.


--=_hermes.drzeus.cx-26945-1120154784-0001-2
Content-Type: text/x-patch; name="i8237-x86_64.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i8237-x86_64.patch"

Index: linux-wbsd/arch/x86_64/kernel/i8237.c
===================================================================
--- linux-wbsd/arch/x86_64/kernel/i8237.c	(revision 0)
+++ linux-wbsd/arch/x86_64/kernel/i8237.c	(revision 0)
@@ -0,0 +1,67 @@
+/*
+ * i8237.c: 8237A DMA controller suspend functions.
+ *
+ * Written by Pierre Ossman, 2005.
+ */
+
+#include <linux/init.h>
+#include <linux/sysdev.h>
+
+#include <asm/dma.h>
+
+/*
+ * This module just handles suspend/resume issues with the
+ * 8237A DMA controller (used for ISA and LPC).
+ * Allocation is handled in kernel/dma.c and normal usage is
+ * in asm/dma.h.
+ */
+
+static int i8237A_resume(struct sys_device *dev)
+{
+	unsigned long flags;
+	int i;
+
+	flags = claim_dma_lock();
+
+	dma_outb(DMA1_RESET_REG, 0);
+	dma_outb(DMA2_RESET_REG, 0);
+
+	for (i = 0;i < 8;i++) {
+		set_dma_addr(i, 0x000000);
+		/* DMA count is a bit weird so this is not 0 */
+		set_dma_count(i, 1);
+	}
+
+	/* Enable cascade DMA or channel 0-3 won't work */
+	enable_dma(4);
+
+	release_dma_lock(flags);
+
+	return 0;
+}
+
+static int i8237A_suspend(struct sys_device *dev, pm_message_t state)
+{
+	return 0;
+}
+
+static struct sysdev_class i8237_sysdev_class = {
+	set_kset_name("i8237"),
+	.suspend = i8237A_suspend,
+	.resume = i8237A_resume,
+};
+
+static struct sys_device device_i8237A = {
+	.id	= 0,
+	.cls	= &i8237_sysdev_class,
+};
+
+static int __init i8237A_init_sysfs(void)
+{
+	int error = sysdev_class_register(&i8237_sysdev_class);
+	if (!error)
+		error = sysdev_register(&device_i8237A);
+	return error;
+}
+
+device_initcall(i8237A_init_sysfs);
Index: linux-wbsd/arch/x86_64/kernel/Makefile
===================================================================
--- linux-wbsd/arch/x86_64/kernel/Makefile	(revision 153)
+++ linux-wbsd/arch/x86_64/kernel/Makefile	(working copy)
@@ -7,7 +7,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
-		setup64.o bootflag.o e820.o reboot.o quirks.o
+		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o

 obj-$(CONFIG_X86_MCE)         += mce.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o

--=_hermes.drzeus.cx-26945-1120154784-0001-2--
