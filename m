Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWHBOxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWHBOxD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWHBOw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:52:56 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:18164 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751155AbWHBOwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:52:54 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+serial@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 1/3] at91_serial: support AVR32
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 02 Aug 2006 16:51:46 +0200
Message-Id: <11545303082669-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11545303083273-git-send-email-hskinnemoen@atmel.com>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to select and build the at91_serial driver
on AVR32. It also #ifdefs out some AT91-specific code for AVR32.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/Kconfig       |   12 ++++++------
 drivers/serial/at91_serial.c |   14 +++++++++++++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 5b48ac2..61b5b52 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -301,21 +301,21 @@ config SERIAL_AMBA_PL011_CONSOLE
 
 config SERIAL_AT91
 	bool "AT91RM9200 / AT91SAM9261 serial port support"
-	depends on ARM && (ARCH_AT91RM9200 || ARCH_AT91SAM9261)
+	depends on ARM && (ARCH_AT91RM9200 || ARCH_AT91SAM9261) || AVR32
 	select SERIAL_CORE
 	help
 	  This enables the driver for the on-chip UARTs of the Atmel
-	  AT91RM9200 and AT91SAM926 processor.
+	  AT91RM9200, AT91SAM926 and AT32AP7000 processors.
 
 config SERIAL_AT91_CONSOLE
 	bool "Support for console on AT91RM9200 / AT91SAM9261 serial port"
 	depends on SERIAL_AT91=y
 	select SERIAL_CORE_CONSOLE
 	help
-	  Say Y here if you wish to use a UART on the Atmel AT91RM9200 or
-	  AT91SAM9261 as the system console (the system console is the device
-	  which receives all kernel messages and warnings and which allows
-	  logins in single user mode).
+	  Say Y here if you wish to use a UART on the Atmel AT91RM9200,
+	  AT91SAM9261 or AT32AP7000 as the system console (the system console
+	  is the device which receives all kernel messages and warnings and
+	  which allows logins in single user mode).
 
 config SERIAL_AT91_TTYAT
 	bool "Install as device ttyAT0-4 instead of ttyS0-4"
diff --git a/drivers/serial/at91_serial.c b/drivers/serial/at91_serial.c
index 54c6b2a..f2fecc6 100644
--- a/drivers/serial/at91_serial.c
+++ b/drivers/serial/at91_serial.c
@@ -40,8 +40,10 @@ #include <asm/arch/at91rm9200_usart.h>
 #include <asm/arch/at91rm9200_pdc.h>
 #include <asm/mach/serial_at91.h>
 #include <asm/arch/board.h>
+#ifdef CONFIG_ARM
 #include <asm/arch/system.h>
 #include <asm/arch/gpio.h>
+#endif
 
 #if defined(CONFIG_SERIAL_AT91_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -134,6 +136,7 @@ static void at91_set_mctrl(struct uart_p
 	unsigned int control = 0;
 	unsigned int mode;
 
+#ifdef CONFIG_ARM
 	if (arch_identify() == ARCH_ID_AT91RM9200) {
 		/*
 		 * AT91RM9200 Errata #39: RTS0 is not internally connected to PA21.
@@ -146,6 +149,7 @@ static void at91_set_mctrl(struct uart_p
 				at91_set_gpio_value(AT91_PIN_PA21, 1);
 		}
 	}
+#endif
 
 	if (mctrl & TIOCM_RTS)
 		control |= AT91_US_RTSEN;
@@ -611,7 +615,8 @@ static int at91_request_port(struct uart
 		return -EBUSY;
 
 	if (port->flags & UPF_IOREMAP) {
-		port->membase = ioremap(port->mapbase, size);
+		if (port->membase == NULL)
+			port->membase = ioremap(port->mapbase, size);
 		if (port->membase == NULL) {
 			release_mem_region(port->mapbase, size);
 			return -ENOMEM;
@@ -693,12 +698,19 @@ static void __devinit at91_init_port(str
 	port->mapbase	= pdev->resource[0].start;
 	port->irq	= pdev->resource[1].start;
 
+#ifdef CONFIG_AVR32
+	port->flags |= UPF_IOREMAP;
+	port->membase = ioremap(pdev->resource[0].start,
+				pdev->resource[0].end
+				- pdev->resource[0].start + 1);
+#else
 	if (port->mapbase == AT91_VA_BASE_SYS + AT91_DBGU)		/* Part of system perpherals - already mapped */
 		port->membase = (void __iomem *) port->mapbase;
 	else {
 		port->flags	|= UPF_IOREMAP;
 		port->membase	= NULL;
 	}
+#endif
 
 	if (!at91_port->clk) {		/* for console, the clock could already be configured */
 		at91_port->clk = clk_get(&pdev->dev, "usart");
-- 
1.4.0

