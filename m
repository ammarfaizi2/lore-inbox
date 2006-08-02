Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWHBOwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWHBOwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWHBOwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:52:55 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:20444 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751160AbWHBOwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:52:53 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+serial@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 2/3] at91_serial: Fix break handling
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 02 Aug 2006 16:51:47 +0200
Message-Id: <11545303083943-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11545303082669-git-send-email-hskinnemoen@atmel.com>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com> <11545303082669-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The RXBRK field in the AT91/AT32 USART status register has the
following definition according to the AT32AP7000 data sheet:

    RXBRK: Break Received/End of Break
    0: No Break received or End of Break detected since the last RSTSTA.
    1: Break Received or End of Break detected since the last RSTSTA.

Thus, for each break, the USART sets the RXBRK bit twice. This patch
modifies the driver to report the break event to the serial core only
once by keeping track of whether a break condition is currently active.

With this patch, SysRq works as expected on the AT32STK1000 board
with an AT32AP7000 CPU.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/at91_serial.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/at91_serial.c b/drivers/serial/at91_serial.c
index f2fecc6..c759e7c 100644
--- a/drivers/serial/at91_serial.c
+++ b/drivers/serial/at91_serial.c
@@ -112,6 +112,7 @@ struct at91_uart_port {
 	struct uart_port	uart;		/* uart */
 	struct clk		*clk;		/* uart clock */
 	unsigned short		suspended;	/* is port suspended? */
+	unsigned short		break_active;
 };
 
 static struct at91_uart_port at91_ports[AT91_NR_UART];
@@ -250,6 +251,7 @@ static void at91_break_ctl(struct uart_p
  */
 static void at91_rx_chars(struct uart_port *port, struct pt_regs *regs)
 {
+	struct at91_uart_port *at91_port = (struct at91_uart_port *) port;
 	struct tty_struct *tty = port->info->tty;
 	unsigned int status, ch, flg;
 
@@ -269,9 +271,14 @@ static void at91_rx_chars(struct uart_po
 			UART_PUT_CR(port, AT91_US_RSTSTA);	/* clear error */
 			if (status & AT91_US_RXBRK) {
 				status &= ~(AT91_US_PARE | AT91_US_FRAME);	/* ignore side-effect */
-				port->icount.brk++;
-				if (uart_handle_break(port))
+				if (at91_port->break_active) {
+					at91_port->break_active = 0;
+				} else {
+					at91_port->break_active = 1;
+					port->icount.brk++;
+					uart_handle_break(port);
 					goto ignore_char;
+				}
 			}
 			if (status & AT91_US_PARE)
 				port->icount.parity++;
-- 
1.4.0

