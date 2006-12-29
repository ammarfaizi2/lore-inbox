Return-Path: <linux-kernel-owner+w=401wt.eu-S965160AbWL2Uzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWL2Uzg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWL2Uzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:55:36 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:42649 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965160AbWL2Uzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:55:35 -0500
Message-id: <26150293961999718626@wsc.cz>
Subject: [PATCH 1/4] Char: mxser_new, alter locking in isr
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Sergei Organov <osv@javad.com>
Date: Fri, 29 Dec 2006 21:55:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, alter locking in isr

Avoid oopsing when stress-testing open/close -- port->tty is NULL
sometimes, but is expected to be non-NULL, since dereferencing.
Receive/transmit chars iff ASYNC_CLOSING is not set and ASYNC_INITIALIZED
is set. Thanks Sergei for pointing this out and testing.

Cc: Sergei Organov <osv@javad.com>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 15e7e157283a86bb819a0193a8cb137d7640d3a6
tree c0d4130f898c835c4e283af0e343ee504345d4c0
parent ab35af25a3d01f1e07fc8de5b96f484b93a8ad2a
author Jiri Slaby <jirislaby@gmail.com> Fri, 29 Dec 2006 20:00:21 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 29 Dec 2006 20:00:21 +0059

 drivers/char/mxser_new.c      |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 8da8833..ec61cf8 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2073,9 +2073,6 @@ static void mxser_receive_chars(struct mxser_port *port, int *status)
 	int cnt = 0;
 	int recv_room;
 	int max = 256;
-	unsigned long flags;
-
-	spin_lock_irqsave(&port->slock, flags);
 
 	recv_room = tty->receive_room;
 	if ((recv_room == 0) && (!port->ldisc_stop_rx))
@@ -2159,7 +2156,6 @@ end_intr:
 	mxvar_log.rxcnt[port->tty->index] += cnt;
 	port->mon_data.rxcnt += cnt;
 	port->mon_data.up_rxcnt += cnt;
-	spin_unlock_irqrestore(&port->slock, flags);
 
 	tty_flip_buffer_push(tty);
 }
@@ -2167,9 +2163,6 @@ end_intr:
 static void mxser_transmit_chars(struct mxser_port *port)
 {
 	int count, cnt;
-	unsigned long flags;
-
-	spin_lock_irqsave(&port->slock, flags);
 
 	if (port->x_char) {
 		outb(port->x_char, port->ioaddr + UART_TX);
@@ -2178,11 +2171,11 @@ static void mxser_transmit_chars(struct mxser_port *port)
 		port->mon_data.txcnt++;
 		port->mon_data.up_txcnt++;
 		port->icount.tx++;
-		goto unlock;
+		return;
 	}
 
 	if (port->xmit_buf == 0)
-		goto unlock;
+		return;
 
 	if ((port->xmit_cnt <= 0) || port->tty->stopped ||
 			(port->tty->hw_stopped &&
@@ -2190,7 +2183,7 @@ static void mxser_transmit_chars(struct mxser_port *port)
 			(!port->board->chip_flag))) {
 		port->IER &= ~UART_IER_THRI;
 		outb(port->IER, port->ioaddr + UART_IER);
-		goto unlock;
+		return;
 	}
 
 	cnt = port->xmit_cnt;
@@ -2215,8 +2208,6 @@ static void mxser_transmit_chars(struct mxser_port *port)
 		port->IER &= ~UART_IER_THRI;
 		outb(port->IER, port->ioaddr + UART_IER);
 	}
-unlock:
-	spin_unlock_irqrestore(&port->slock, flags);
 }
 
 /*
@@ -2257,12 +2248,16 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 			port = &brd->ports[i];
 
 			int_cnt = 0;
+			spin_lock(&port->slock);
 			do {
 				iir = inb(port->ioaddr + UART_IIR);
 				if (iir & UART_IIR_NO_INT)
 					break;
 				iir &= MOXA_MUST_IIR_MASK;
-				if (!port->tty) {
+				if (!port->tty ||
+						(port->flags & ASYNC_CLOSING) ||
+						!(port->flags &
+							ASYNC_INITIALIZED)) {
 					status = inb(port->ioaddr + UART_LSR);
 					outb(0x27, port->ioaddr + UART_FCR);
 					inb(port->ioaddr + UART_MSR);
@@ -2308,6 +2303,7 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 						mxser_transmit_chars(port);
 				}
 			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
+			spin_unlock(&port->slock);
 		}
 		if (pass_counter++ > MXSER_ISR_PASS_LIMIT)
 			break;	/* Prevent infinite loops */
