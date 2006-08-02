Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWHBRkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWHBRkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWHBRkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:40:12 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:19162 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932071AbWHBRkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:40:10 -0400
Date: Wed, 2 Aug 2006 19:39:59 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] at91_serial: Fix break handling
Message-ID: <20060802193959.76b930b7@cad-250-152.norway.atmel.com>
In-Reply-To: <20060802151741.GB32102@flint.arm.linux.org.uk>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	<11545303082669-git-send-email-hskinnemoen@atmel.com>
	<11545303083943-git-send-email-hskinnemoen@atmel.com>
	<20060802151741.GB32102@flint.arm.linux.org.uk>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 16:17:41 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> 1. Effectively, this just ignores every second break status.  We've
> no idea _which_ break interrupt is going to be ignored.
> 2. it breaks break handling.  uart_handle_break returns a value for a
>    reason.  Use it - don't unconditionally ignore the received
> character.

Here's another attempt, which should at least fix #2 and hopefully #1.
If a break appears to have been active for more than one second, we
assume it's a new start-of-break.

Tested using SysRq on AT32AP7000. Seems to work well when dumping lots
of text to the console.

Haavard

From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 4 Jul 2006 10:25:59 +0200
Subject: [PATCH] at91_serial: Fix break handling

The RXBRK field in the AT91/AT32 USART status register has the
following definition according to the AT32AP7000 data sheet:

    RXBRK: Break Received/End of Break
    0: No Break received or End of Break detected since the last RSTSTA.
    1: Break Received or End of Break detected since the last RSTSTA.

Thus, for each break, the USART sets the RXBRK bit twice. This patch
modifies the driver to report the break event to the serial core only
once by keeping track of whether a break condition is currently active.

Also, if an end-of-break appears more than one second after
start-of-break, assume that we missed the last one and treat it as a
start-of-break.

With this patch, SysRq works as expected on the AT32STK1000 board
with an AT32AP7000 CPU.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/at91_serial.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/at91_serial.c b/drivers/serial/at91_serial.c
index bee81ff..484faa2 100644
--- a/drivers/serial/at91_serial.c
+++ b/drivers/serial/at91_serial.c
@@ -112,6 +112,8 @@ struct at91_uart_port {
 	struct uart_port	uart;		/* uart */
 	struct clk		*clk;		/* uart clock */
 	unsigned short		suspended;	/* is port suspended? */
+	unsigned short		break_active;	/* currently receiving break */
+	unsigned long		break_timeout;	/* when to stop waiting for end-of-break */
 };
 
 static struct at91_uart_port at91_ports[AT91_NR_UART];
@@ -250,6 +252,7 @@ static void at91_break_ctl(struct uart_p
  */
 static void at91_rx_chars(struct uart_port *port, struct pt_regs *regs)
 {
+	struct at91_uart_port *at91_port = (struct at91_uart_port *) port;
 	struct tty_struct *tty = port->info->tty;
 	unsigned int status, ch, flg;
 
@@ -269,9 +272,18 @@ static void at91_rx_chars(struct uart_po
 			UART_PUT_CR(port, AT91_US_RSTSTA);	/* clear error */
 			if (status & AT91_US_RXBRK) {
 				status &= ~(AT91_US_PARE | AT91_US_FRAME);	/* ignore side-effect */
-				port->icount.brk++;
-				if (uart_handle_break(port))
-					goto ignore_char;
+				if (at91_port->break_active
+				    && time_before(jiffies,
+						   at91_port->break_timeout)) {
+					at91_port->break_active = 0;
+					status &= ~AT91_US_RXBRK;
+				} else {
+					at91_port->break_active = 1;
+					at91_port->break_timeout = jiffies + HZ;
+					port->icount.brk++;
+					if (uart_handle_break(port))
+						goto ignore_char;
+				}
 			}
 			if (status & AT91_US_PARE)
 				port->icount.parity++;
-- 
1.4.0

