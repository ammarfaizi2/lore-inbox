Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVCFXYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVCFXYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVCFXWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:22:20 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:30158 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261597AbVCFXUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 18:20:55 -0500
Date: Mon, 7 Mar 2005 08:20:37 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2.6.11-mm1] mips: add spare timer init
Message-Id: <20050307082037.2c670c29.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds spare timer initialization for NEC VR41xx.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/init.c a/arch/mips/vr41xx/common/init.c
--- a-orig/arch/mips/vr41xx/common/init.c	Thu Mar  3 07:26:49 2005
+++ a/arch/mips/vr41xx/common/init.c	Thu Mar  3 07:30:17 2005
@@ -19,9 +19,11 @@
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/irq.h>
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
+#include <asm/time.h>
 #include <asm/vr41xx/vr41xx.h>
 
 #define IO_MEM_RESOURCE_START	0UL
@@ -33,6 +35,29 @@
 	iomem_resource.end = IO_MEM_RESOURCE_END;
 }
 
+static void __init setup_timer_frequency(void)
+{
+	unsigned long tclock;
+
+	tclock = vr41xx_get_tclock_frequency();
+	if (current_cpu_data.processor_id == PRID_VR4131_REV2_0 ||
+	    current_cpu_data.processor_id == PRID_VR4131_REV2_1)
+		mips_hpt_frequency = tclock / 2;
+	else
+		mips_hpt_frequency = tclock / 4;
+}
+
+static void __init setup_timer_irq(struct irqaction *irq)
+{
+	setup_irq(TIMER_IRQ, irq);
+}
+
+static void __init timer_init(void)
+{
+	board_time_init = setup_timer_frequency;
+	board_timer_setup = setup_timer_irq;
+}
+
 void __init prom_init(void)
 {
 	int argc, i;
@@ -48,6 +73,8 @@
 	}
 
 	vr41xx_calculate_clock_frequency();
+
+	timer_init();
 
 	iomem_resource_init();
 }
diff -urN -X dontdiff a-orig/include/asm-mips/vr41xx/vr41xx.h a/include/asm-mips/vr41xx/vr41xx.h
--- a-orig/include/asm-mips/vr41xx/vr41xx.h	Thu Mar  3 07:26:49 2005
+++ a/include/asm-mips/vr41xx/vr41xx.h	Thu Mar  3 07:29:10 2005
@@ -84,7 +84,7 @@
 #define INT2_CASCADE_IRQ	MIPS_CPU_IRQ(4)
 #define INT3_CASCADE_IRQ	MIPS_CPU_IRQ(5)
 #define INT4_CASCADE_IRQ	MIPS_CPU_IRQ(6)
-#define MIPS_COUNTER_IRQ	MIPS_CPU_IRQ(7)
+#define TIMER_IRQ		MIPS_CPU_IRQ(7)
 
 /* SYINT1 Interrupt Numbers */
 #define SYSINT1_IRQ_BASE	8
