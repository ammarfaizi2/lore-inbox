Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWI0Q6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWI0Q6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWI0Q6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:58:06 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:42473 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751258AbWI0Q6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:58:02 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       hskinnemoen@atmel.com
Subject: [PATCH 8/8] atmel_serial: Kill at91_register_uart_fns
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 27 Sep 2006 18:58:05 +0200
Message-Id: <11593762852950-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <1159376285621-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com> <115937628584-git-send-email-hskinnemoen@atmel.com> <11593762852168-git-send-email-hskinnemoen@atmel.com> <11593762851735-git-send-email-hskinnemoen@atmel.com> <11593762853931-git-send-email-hskinnemoen@atmel.com> <11593762851544-git-send-email-hskinnemoen@atmel.com> <11593762851494-git-send-email-hskinnemoen@atmel.com> <1159376285621-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

at91_register_uart_fns has no users as far as I can see. Let's get
rid of it.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/atmel_serial.c        |   41 ----------------------------------
 include/asm-arm/mach/serial_at91.h   |   33 ---------------------------
 include/asm-avr32/mach/serial_at91.h |   33 ---------------------------
 3 files changed, 0 insertions(+), 107 deletions(-)

diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 420921d..ae29b78 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -37,7 +37,6 @@ #include <linux/platform_device.h>
 #include <asm/io.h>
 
 #include <asm/arch/at91rm9200_pdc.h>
-#include <asm/mach/serial_at91.h>
 #include <asm/arch/board.h>
 #include <asm/arch/system.h>
 #include <asm/arch/gpio.h>
@@ -101,9 +100,6 @@ #define UART_PUT_TCR(port,v)	writel(v, (
 //#define UART_PUT_TNPR(port,v)	writel(v, (port)->membase + ATMEL_PDC_TNPR)
 //#define UART_PUT_TNCR(port,v)	writel(v, (port)->membase + ATMEL_PDC_TNCR)
 
-static int (*at91_open)(struct uart_port *);
-static void (*at91_close)(struct uart_port *);
-
 /*
  * We wrap our port structure around the generic uart_port.
  */
@@ -396,18 +392,6 @@ static int atmel_startup(struct uart_por
 	}
 
 	/*
-	 * If there is a specific "open" function (to register
-	 * control line interrupts)
-	 */
-	if (at91_open) {
-		retval = at91_open(port);
-		if (retval) {
-			free_irq(port->irq, port);
-			return retval;
-		}
-	}
-
-	/*
 	 * Finally, enable the serial port
 	 */
 	UART_PUT_CR(port, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
@@ -435,13 +419,6 @@ static void atmel_shutdown(struct uart_p
 	 * Free the interrupt
 	 */
 	free_irq(port->irq, port);
-
-	/*
-	 * If there is a specific "close" function (to unregister
-	 * control line interrupts)
-	 */
-	if (at91_close)
-		at91_close(port);
 }
 
 /*
@@ -708,24 +685,6 @@ static void __devinit atmel_init_port(st
 	}
 }
 
-/*
- * Register board-specific modem-control line handlers.
- */
-void __init at91_register_uart_fns(struct at91_port_fns *fns)
-{
-	if (fns->enable_ms)
-		atmel_pops.enable_ms = fns->enable_ms;
-	if (fns->get_mctrl)
-		atmel_pops.get_mctrl = fns->get_mctrl;
-	if (fns->set_mctrl)
-		atmel_pops.set_mctrl = fns->set_mctrl;
-	at91_open		= fns->open;
-	at91_close		= fns->close;
-	atmel_pops.pm		= fns->pm;
-	atmel_pops.set_wake	= fns->set_wake;
-}
-
-
 #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
 static void atmel_console_putchar(struct uart_port *port, int ch)
 {
diff --git a/include/asm-arm/mach/serial_at91.h b/include/asm-arm/mach/serial_at91.h
deleted file mode 100644
index 239e1f6..0000000
--- a/include/asm-arm/mach/serial_at91.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  linux/include/asm-arm/mach/serial_at91.h
- *
- *  Based on serial_sa1100.h  by Nicolas Pitre
- *
- *  Copyright (C) 2002 ATMEL Rousset
- *
- *  Low level machine dependent UART functions.
- */
-
-struct uart_port;
-
-/*
- * This is a temporary structure for registering these
- * functions; it is intended to be discarded after boot.
- */
-struct at91_port_fns {
-	void	(*set_mctrl)(struct uart_port *, u_int);
-	u_int	(*get_mctrl)(struct uart_port *);
-	void	(*enable_ms)(struct uart_port *);
-	void	(*pm)(struct uart_port *, u_int, u_int);
-	int	(*set_wake)(struct uart_port *, u_int);
-	int	(*open)(struct uart_port *);
-	void	(*close)(struct uart_port *);
-};
-
-#if defined(CONFIG_SERIAL_ATMEL)
-void at91_register_uart_fns(struct at91_port_fns *fns);
-#else
-#define at91_register_uart_fns(fns) do { } while (0)
-#endif
-
-
diff --git a/include/asm-avr32/mach/serial_at91.h b/include/asm-avr32/mach/serial_at91.h
deleted file mode 100644
index 239e1f6..0000000
--- a/include/asm-avr32/mach/serial_at91.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  linux/include/asm-arm/mach/serial_at91.h
- *
- *  Based on serial_sa1100.h  by Nicolas Pitre
- *
- *  Copyright (C) 2002 ATMEL Rousset
- *
- *  Low level machine dependent UART functions.
- */
-
-struct uart_port;
-
-/*
- * This is a temporary structure for registering these
- * functions; it is intended to be discarded after boot.
- */
-struct at91_port_fns {
-	void	(*set_mctrl)(struct uart_port *, u_int);
-	u_int	(*get_mctrl)(struct uart_port *);
-	void	(*enable_ms)(struct uart_port *);
-	void	(*pm)(struct uart_port *, u_int, u_int);
-	int	(*set_wake)(struct uart_port *, u_int);
-	int	(*open)(struct uart_port *);
-	void	(*close)(struct uart_port *);
-};
-
-#if defined(CONFIG_SERIAL_ATMEL)
-void at91_register_uart_fns(struct at91_port_fns *fns);
-#else
-#define at91_register_uart_fns(fns) do { } while (0)
-#endif
-
-
-- 
1.4.1.1

