Return-Path: <linux-kernel-owner+w=401wt.eu-S1422961AbWLUOKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422961AbWLUOKa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422962AbWLUOKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:10:30 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:58509 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1422961AbWLUOKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:10:30 -0500
Date: Thu, 21 Dec 2006 17:11:04 +0300
From: Vitaly Wool <vitalywool@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] pnx8xxx-uart: irq and ktermios fixes
Message-Id: <20061221171104.b8186ee8.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

this patch adds irq 2.6.19 changes and 2.6.20 ktermios changes to pnx8xxx-uart.c (which was added to -mm tree with pnx8550-uart-driver.patch).

 drivers/serial/pnx8xxx_uart.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Index: linux-2.6/drivers/serial/pnx8xxx_uart.c
===================================================================
--- linux-2.6.orig/drivers/serial/pnx8xxx_uart.c
+++ linux-2.6/drivers/serial/pnx8xxx_uart.c
@@ -179,8 +179,7 @@ static void pnx8xxx_enable_ms(struct uar
 	mod_timer(&sport->timer, jiffies);
 }
 
-static void
-pnx8xxx_rx_chars(struct pnx8xxx_port *sport, struct pt_regs *regs)
+static void pnx8xxx_rx_chars(struct pnx8xxx_port *sport)
 {
 	struct tty_struct *tty = sport->port.info->tty;
 	unsigned int status, ch, flg;
@@ -220,7 +219,7 @@ pnx8xxx_rx_chars(struct pnx8xxx_port *sp
 #endif
 		}
 
-		if (uart_handle_sysrq_char(&sport->port, ch, regs))
+		if (uart_handle_sysrq_char(&sport->port, ch))
 			goto ignore_char;
 
 		uart_insert_char(&sport->port, status,
@@ -276,7 +275,7 @@ static void pnx8xxx_tx_chars(struct pnx8
 		pnx8xxx_stop_tx(&sport->port);
 }
 
-static irqreturn_t pnx8xxx_int(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t pnx8xxx_int(int irq, void *dev_id)
 {
 	struct pnx8xxx_port *sport = dev_id;
 	unsigned int status;
@@ -293,7 +292,7 @@ static irqreturn_t pnx8xxx_int(int irq, 
 
 	/* Byte received */
 	if (status & PNX8XXX_UART_INT_RX)
-		pnx8xxx_rx_chars(sport, regs);
+		pnx8xxx_rx_chars(sport);
 
 	/* TX holding register empty - transmit a byte */
 	if (status & PNX8XXX_UART_INT_TX)
@@ -429,8 +428,8 @@ static void pnx8xxx_shutdown(struct uart
 }
 
 static void
-pnx8xxx_set_termios(struct uart_port *port, struct termios *termios,
-		   struct termios *old)
+pnx8xxx_set_termios(struct uart_port *port, struct ktermios *termios,
+		   struct ktermios *old)
 {
 	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
 	unsigned long flags;
@@ -727,7 +726,7 @@ pnx8xxx_console_setup(struct console *co
 	return uart_set_options(&sport->port, co, baud, parity, bits, flow);
 }
 
-extern struct uart_driver pnx8xxx_reg;
+static struct uart_driver pnx8xxx_reg;
 static struct console pnx8xxx_console = {
 	.name		= "ttyS",
 	.write		= pnx8xxx_console_write,
