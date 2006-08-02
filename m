Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWHBR2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWHBR2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWHBR2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:28:13 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:23778 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751068AbWHBR2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:28:13 -0400
Date: Wed, 2 Aug 2006 19:27:38 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] at91_serial: support AVR32
Message-ID: <20060802192738.074af71d@cad-250-152.norway.atmel.com>
In-Reply-To: <20060802160353.GA7173@flint.arm.linux.org.uk>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	<11545303082669-git-send-email-hskinnemoen@atmel.com>
	<20060802151505.GA32102@flint.arm.linux.org.uk>
	<20060802180023.65fe6434@cad-250-152.norway.atmel.com>
	<20060802160353.GA7173@flint.arm.linux.org.uk>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 17:03:53 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Wed, Aug 02, 2006 at 06:00:23PM +0200, Haavard Skinnemoen wrote:
> > What is the best way to get the serial console up and running early
> > in the boot process?
> 
> There is no generic solution to this problem other than to put up with
> the late initialisation of serial console.
> 
> If you want a serial console earlier, have a look at how the
> 8250_early stuff works.

Ok, thanks. I'll have a look at it later.

Here's an updated patch.

Haavard

From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 2 Aug 2006 14:59:13 +0200
Subject: [PATCH 1/3] at91_serial: support AVR32

This makes it possible to select and build the at91_serial driver
on AVR32. It also #ifdefs out some AT91-specific code for AVR32.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/Kconfig       |   12 ++++++------
 drivers/serial/at91_serial.c |    9 +++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

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
index 54c6b2a..bee81ff 100644
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
@@ -693,12 +697,17 @@ static void __devinit at91_init_port(str
 	port->mapbase	= pdev->resource[0].start;
 	port->irq	= pdev->resource[1].start;
 
+#ifdef CONFIG_AVR32
+	port->flags |= UPF_IOREMAP;
+	port->membase = NULL;
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

