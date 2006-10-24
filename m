Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWJXING@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWJXING (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWJXING
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:13:06 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:30971 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932411AbWJXIND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:03 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 7/8] AVR32: Use __raw MMIO access for internal peripherals
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 24 Oct 2006 10:12:45 +0200
Message-Id: <11616775664128-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11616775662032-git-send-email-hskinnemoen@atmel.com>
References: <1161677566706-git-send-email-hskinnemoen@atmel.com> <11616775663220-git-send-email-hskinnemoen@atmel.com> <11616775662194-git-send-email-hskinnemoen@atmel.com> <11616775661390-git-send-email-hskinnemoen@atmel.com> <11616775661978-git-send-email-hskinnemoen@atmel.com> <1161677566524-git-send-email-hskinnemoen@atmel.com> <11616775662032-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The read[bwl] and write[bwl] functions are meant for accessing PCI
devices. How this is achieved on AVR32 is unknown, as there are no
systems with a PCI bridge available yet.

On-chip peripheral access, however, should not depend on how we end
up implementing PCI access, so using __raw_read[bwl]/__raw_write[bwl]
is the right thing to do for on-chip peripherals. This patch converts
the drivers for the static memory controller, interrupt controller,
PIO controller and system manager to use __raw MMIO access.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mach-at32ap/hsmc.h |    4 ++--
 arch/avr32/mach-at32ap/intc.h |    6 ++++--
 arch/avr32/mach-at32ap/pio.h  |    6 ++++--
 arch/avr32/mach-at32ap/sm.h   |    6 ++++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/avr32/mach-at32ap/hsmc.h b/arch/avr32/mach-at32ap/hsmc.h
index 5681276..d1d48e2 100644
--- a/arch/avr32/mach-at32ap/hsmc.h
+++ b/arch/avr32/mach-at32ap/hsmc.h
@@ -120,8 +120,8 @@ #define HSMC_BFINS(name,value,old)					\
 
 /* Register access macros */
 #define hsmc_readl(port,reg)						\
-	readl((port)->regs + HSMC_##reg)
+	__raw_readl((port)->regs + HSMC_##reg)
 #define hsmc_writel(port,reg,value)					\
-	writel((value), (port)->regs + HSMC_##reg)
+	__raw_writel((value), (port)->regs + HSMC_##reg)
 
 #endif /* __ASM_AVR32_HSMC_H__ */
diff --git a/arch/avr32/mach-at32ap/intc.h b/arch/avr32/mach-at32ap/intc.h
index d289ca2..4d3664e 100644
--- a/arch/avr32/mach-at32ap/intc.h
+++ b/arch/avr32/mach-at32ap/intc.h
@@ -321,7 +321,9 @@ #define INTC_BIT(name)               (1 
 #define INTC_MKBF(name, value)       (((value) & ((1 << INTC_##name##_SIZE) - 1)) << INTC_##name##_OFFSET)
 #define INTC_GETBF(name, value)      (((value) >> INTC_##name##_OFFSET) & ((1 << INTC_##name##_SIZE) - 1))
 
-#define intc_readl(port,reg)         readl((port)->regs + INTC_##reg)
-#define intc_writel(port,reg,value)  writel((value), (port)->regs + INTC_##reg)
+#define intc_readl(port,reg)					\
+	__raw_readl((port)->regs + INTC_##reg)
+#define intc_writel(port,reg,value)				\
+	__raw_writel((value), (port)->regs + INTC_##reg)
 
 #endif /* __ASM_AVR32_PERIHP_INTC_H__ */
diff --git a/arch/avr32/mach-at32ap/pio.h b/arch/avr32/mach-at32ap/pio.h
index cfea123..50fa3ac 100644
--- a/arch/avr32/mach-at32ap/pio.h
+++ b/arch/avr32/mach-at32ap/pio.h
@@ -170,8 +170,10 @@ #define PIO_BFEXT(name,value)           
 #define PIO_BFINS(name,value,old)              (((old) & ~(((1 << PIO_##name##_SIZE) - 1) << PIO_##name##_OFFSET)) | PIO_BF(name,value))
 
 /* Register access macros */
-#define pio_readl(port,reg)                    readl((port)->regs + PIO_##reg)
-#define pio_writel(port,reg,value)             writel((value), (port)->regs + PIO_##reg)
+#define pio_readl(port,reg)					\
+	__raw_readl((port)->regs + PIO_##reg)
+#define pio_writel(port,reg,value)				\
+	__raw_writel((value), (port)->regs + PIO_##reg)
 
 void at32_init_pio(struct platform_device *pdev);
 
diff --git a/arch/avr32/mach-at32ap/sm.h b/arch/avr32/mach-at32ap/sm.h
index 2756582..cad02b5 100644
--- a/arch/avr32/mach-at32ap/sm.h
+++ b/arch/avr32/mach-at32ap/sm.h
@@ -234,7 +234,9 @@ #define SM_BFEXT(name,value)            
 #define SM_BFINS(name,value,old)                (((old) & ~(((1 << SM_##name##_SIZE) - 1) << SM_##name##_OFFSET)) | SM_BF(name,value))
 
 /* Register access macros */
-#define sm_readl(port,reg)                      readl((port)->regs + SM_##reg)
-#define sm_writel(port,reg,value)               writel((value), (port)->regs + SM_##reg)
+#define sm_readl(port,reg)					\
+	__raw_readl((port)->regs + SM_##reg)
+#define sm_writel(port,reg,value)				\
+	__raw_writel((value), (port)->regs + SM_##reg)
 
 #endif /* __ASM_AVR32_SM_H__ */
-- 
1.4.1.1

