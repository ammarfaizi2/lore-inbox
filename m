Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWI1Nbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWI1Nbj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWI1Nbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:31:35 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:50396 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751889AbWI1Nbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:31:33 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 2/4] atmel_serial: Support AVR32
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 28 Sep 2006 15:31:40 +0200
Message-Id: <11594503023619-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11594503023213-git-send-email-hskinnemoen@atmel.com>
References: <11594503023218-git-send-email-hskinnemoen@atmel.com> <11594503023213-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make CONFIG_SERIAL_ATMEL selectable on AVR32 and #ifdef out some ARM-
specific code in the driver.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/Kconfig        |   24 ++++++++++++------------
 drivers/serial/atmel_serial.c |    4 ++++
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 4f962de..7eff74a 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -301,31 +301,31 @@ config SERIAL_AMBA_PL011_CONSOLE
 
 config SERIAL_ATMEL
 	bool "AT91 / AT32 on-chip serial port support"
-	depends on ARM && (ARCH_AT91RM9200 || ARCH_AT91SAM9261)
+	depends on ARM && (ARCH_AT91RM9200 || ARCH_AT91SAM9261) || AVR32
 	select SERIAL_CORE
 	help
 	  This enables the driver for the on-chip UARTs of the Atmel
-	  AT91RM9200 and AT91SAM926 processor.
+	  AT91RM9200, AT91SAM926 and AT32AP7000 processors.
 
 config SERIAL_ATMEL_CONSOLE
 	bool "Support for console on AT91 / AT32 serial port"
 	depends on SERIAL_ATMEL=y
 	select SERIAL_CORE_CONSOLE
 	help
-	  Say Y here if you wish to use a UART on the Atmel AT91RM9200 or
-	  AT91SAM9261 as the system console (the system console is the device
-	  which receives all kernel messages and warnings and which allows
-	  logins in single user mode).
+	  Say Y here if you wish to use a UART on the Atmel AT91RM9200,
+	  AT91SAM9261 or AT32AP7000 as the system console (the system
+	  console is the device which receives all kernel messages and
+	  warnings and which allows logins in single user mode).
 
 config SERIAL_ATMEL_TTYAT
-	bool "Install as device ttyAT0-4 instead of ttyS0-4"
+	bool "Install as device ttyATn instead of ttySn"
 	depends on SERIAL_ATMEL=y
 	help
-	  Say Y here if you wish to have the five internal AT91RM9200 UARTs
-	  appear as /dev/ttyAT0-4 (major 204, minor 154-158) instead of the
-	  normal /dev/ttyS0-4 (major 4, minor 64-68). This is necessary if
-	  you also want other UARTs, such as external 8250/16C550 compatible
-	  UARTs.
+	  Say Y here if you wish to have the internal AT91 / AT32 UARTs
+	  appear as /dev/ttyATn (major 204, minor starting at 154)
+	  instead of the normal /dev/ttySn (major 4, minor starting at
+	  64). This is necessary if you also want other UARTs, such as
+	  external 8250/16C550 compatible UARTs.
 	  The ttySn nodes are legally reserved for the 8250 serial driver
 	  but are often misused by other serial drivers.
 
diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 8fff85c..6f1f4ea 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -39,8 +39,10 @@ #include <asm/io.h>
 #include <asm/arch/at91rm9200_pdc.h>
 #include <asm/mach/serial_at91.h>
 #include <asm/arch/board.h>
+#ifdef CONFIG_ARM
 #include <asm/arch/system.h>
 #include <asm/arch/gpio.h>
+#endif
 
 #include "atmel_serial.h"
 
@@ -135,6 +137,7 @@ static void atmel_set_mctrl(struct uart_
 	unsigned int control = 0;
 	unsigned int mode;
 
+#ifdef CONFIG_ARM
 	if (arch_identify() == ARCH_ID_AT91RM9200) {
 		/*
 		 * AT91RM9200 Errata #39: RTS0 is not internally connected to PA21.
@@ -147,6 +150,7 @@ static void atmel_set_mctrl(struct uart_
 				at91_set_gpio_value(AT91_PIN_PA21, 1);
 		}
 	}
+#endif
 
 	if (mctrl & TIOCM_RTS)
 		control |= ATMEL_US_RTSEN;
-- 
1.4.1.1

