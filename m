Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWI1OBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWI1OBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWI1OBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:01:36 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:51931 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161134AbWI1OBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:01:35 -0400
Date: Thu, 28 Sep 2006 16:01:38 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Victor <andrew@sanpeople.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] atmel_serial: Support AVR32
Message-ID: <20060928160138.26cf01ce@cad-250-152.norway.atmel.com>
In-Reply-To: <11594503023619-git-send-email-hskinnemoen@atmel.com>
References: <11594503023218-git-send-email-hskinnemoen@atmel.com>
	<11594503023213-git-send-email-hskinnemoen@atmel.com>
	<11594503023619-git-send-email-hskinnemoen@atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 15:31:40 +0200
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> Make CONFIG_SERIAL_ATMEL selectable on AVR32 and #ifdef out some ARM-
> specific code in the driver.

Hmm...the dependency changes I promised to make got left out during the
final git-reset/git-am/git-format-patch shuffling. This patch includes
them.

Haavard
---
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 2/4] atmel_serial: Support AVR32

Make CONFIG_SERIAL_ATMEL selectable on AVR32 and #ifdef out some ARM-
specific code in the driver.

Also simplify the ARM dependencies a bit. This driver is usable on all
AT91 parts, and ARCH_AT91 implies ARCH_AT91RM9200 || ARCH_AT91SAM9261
as well as any future AT91 parts.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/Kconfig        |   24 ++++++++++++------------
 drivers/serial/atmel_serial.c |    4 ++++
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 4f962de..b9c277d 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -301,31 +301,31 @@ config SERIAL_AMBA_PL011_CONSOLE
 
 config SERIAL_ATMEL
 	bool "AT91 / AT32 on-chip serial port support"
-	depends on ARM && (ARCH_AT91RM9200 || ARCH_AT91SAM9261)
+	depends on (ARM && ARCH_AT91) || AVR32
 	select SERIAL_CORE
 	help
 	  This enables the driver for the on-chip UARTs of the Atmel
-	  AT91RM9200 and AT91SAM926 processor.
+	  AT91 and AT32 processors.
 
 config SERIAL_ATMEL_CONSOLE
 	bool "Support for console on AT91 / AT32 serial port"
 	depends on SERIAL_ATMEL=y
 	select SERIAL_CORE_CONSOLE
 	help
-	  Say Y here if you wish to use a UART on the Atmel AT91RM9200 or
-	  AT91SAM9261 as the system console (the system console is the device
-	  which receives all kernel messages and warnings and which allows
-	  logins in single user mode).
+	  Say Y here if you wish to use an on-chip UART on a Atmel
+	  AT91 or AT32 processor as the system console (the system
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

