Return-Path: <linux-kernel-owner+w=401wt.eu-S1754844AbWL1NQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844AbWL1NQy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbWL1NQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:16:54 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:43642 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754844AbWL1NQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:16:53 -0500
Message-id: <1776969361374112179@wsc.cz>
In-reply-to: <188453909150148968@wsc.cz>
Subject: [PATCH 3/4] Char: mxser_new, remove tty_wakeup bottomhalf
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 28 Dec 2006 14:16:57 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, remove tty_wakeup bottomhalf

It's safe to call tty_wakeup from irq context. Do not schedule it for later
calling.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit ec5dee09bf3e78d886d61168625e63280c715739
tree ec09e7afa162b4901d4304d89e588a12df77e494
parent ce3d140accc090dee75676a4db2b1ddf7b39843e
author Jiri Slaby <jirislaby@gmail.com> Thu, 28 Dec 2006 14:09:47 +0059
committer Jiri Slaby <jirislaby@gmail.com> Thu, 28 Dec 2006 14:09:47 +0059

 drivers/char/.mxser_new.c.swp |  Bin
 drivers/char/mxser_new.c      |   26 ++++++--------------------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 4d4721e..420d23f 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -269,7 +269,6 @@ struct mxser_port {
 	struct mxser_mon mon_data;
 
 	spinlock_t slock;
-	struct work_struct tqueue;
 	wait_queue_head_t open_wait;
 	wait_queue_head_t delta_msr_wait;
 };
@@ -355,15 +354,6 @@ static void process_txrx_fifo(struct mxser_port *info)
 			}
 }
 
-static void mxser_do_softint(struct work_struct *work)
-{
-	struct mxser_port *info = container_of(work, struct mxser_port, tqueue);
-	struct tty_struct *tty = info->tty;
-
-	if (test_and_clear_bit(MXSER_EVENT_TXLOW, &info->event))
-		tty_wakeup(tty);
-}
-
 static unsigned char mxser_get_msr(int baseaddr, int mode, int port)
 {
 	unsigned char status = 0;
@@ -607,8 +597,8 @@ static int mxser_change_speed(struct mxser_port *info,
 						outb(info->IER, info->ioaddr +
 								UART_IER);
 					}
-					set_bit(MXSER_EVENT_TXLOW, &info->event);
-					schedule_work(&info->tqueue);				}
+					tty_wakeup(info->tty);
+				}
 			} else {
 				if (!(status & UART_MSR_CTS)) {
 					info->tty->hw_stopped = 1;
@@ -703,7 +693,6 @@ static void mxser_check_modem_status(struct mxser_port *port, int status)
 	if ((port->flags & ASYNC_CHECK_CD) && (status & UART_MSR_DDCD)) {
 		if (status & UART_MSR_DCD)
 			wake_up_interruptible(&port->open_wait);
-		schedule_work(&port->tqueue);
 	}
 
 	if (port->flags & ASYNC_CTS_FLOW) {
@@ -719,8 +708,7 @@ static void mxser_check_modem_status(struct mxser_port *port, int status)
 					outb(port->IER, port->ioaddr +
 							UART_IER);
 				}
-				set_bit(MXSER_EVENT_TXLOW, &port->event);
-				schedule_work(&port->tqueue);
+				tty_wakeup(port->tty);
 			}
 		} else {
 			if (!(status & UART_MSR_CTS)) {
@@ -2220,10 +2208,9 @@ static void mxser_transmit_chars(struct mxser_port *port)
 	port->mon_data.up_txcnt += (cnt - port->xmit_cnt);
 	port->icount.tx += (cnt - port->xmit_cnt);
 
-	if (port->xmit_cnt < WAKEUP_CHARS) {
-		set_bit(MXSER_EVENT_TXLOW, &port->event);
-		schedule_work(&port->tqueue);
-	}
+	if (port->xmit_cnt < WAKEUP_CHARS)
+		tty_wakeup(port->tty);
+
 	if (port->xmit_cnt <= 0) {
 		port->IER &= ~UART_IER_THRI;
 		outb(port->IER, port->ioaddr + UART_IER);
@@ -2400,7 +2387,6 @@ static int __devinit mxser_initbrd(struct mxser_board *brd,
 		info->custom_divisor = info->baud_base * 16;
 		info->close_delay = 5 * HZ / 10;
 		info->closing_wait = 30 * HZ;
-		INIT_WORK(&info->tqueue, mxser_do_softint);
 		info->normal_termios = mxvar_sdriver->init_termios;
 		init_waitqueue_head(&info->open_wait);
 		init_waitqueue_head(&info->delta_msr_wait);
