Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032393AbWLGQtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032393AbWLGQtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032398AbWLGQtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:49:41 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:50478 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032393AbWLGQtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:49:40 -0500
Message-id: <2468138171231116414@wsc.cz>
In-reply-to: <45776D4F.6070806@gmail.com>
References: <45776D4F.6070806@gmail.com>, <1165451982-AXRLGS2HCEVCUY1@www.vabmail.com>
Subject: [PATCH 1/1] Char: isicom, fix card locking
From: Jiri Slaby <jirislaby@gmail.com>
To: Eric Fox <efox@einsteinindustries.com>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu,  7 Dec 2006 17:49:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you test this one and turn on lock debugging?
(It's applicable instead of the last one.)

--

isicom, fix card locking

- Somebody omitted spin_unlock in interrupt handler and hence card causes
  deadlock. Add two unlocks, before returning from handler, if the lock was
  acquired before.
- Recursive locking causes deadlock, fix this by avoiding recursion.
Thanks Eric Fox <efox@einsteinindustries.com> for pointing these out.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d1cf4c06710e37fee58dbca38e08b236ba8ff50c
tree da27dc848eb073662174276ab7e0472c9da4193c
parent 1240cd642c42688fab680d1d783eb1821ded9490
author Jiri Slaby <jirislaby@gmail.com> Thu, 07 Dec 2006 17:42:51 +0059
committer Jiri Slaby <jirislaby@gmail.com> Thu, 07 Dec 2006 17:42:51 +0059

 drivers/char/isicom.c |   90 ++++++++++++++++++++++++++-----------------------
 1 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 1637c1d..adbb16d 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -228,6 +228,20 @@ static struct isi_port  isi_ports[PORT_C
  *	it wants to talk.
  */
 
+static inline int WaitTillCardIsFree(u16 base)
+{
+	unsigned int count = 0;
+	unsigned int a = in_atomic(); /* do we run under spinlock? */
+
+	while (!(inw(base + 0xe) & 0x1) && count++ < 100)
+		if (a)
+			mdelay(1);
+		else
+			msleep(1);
+
+	return !(inw(base + 0xe) & 0x1);
+}
+
 static int lock_card(struct isi_board *card)
 {
 	char		retries;
@@ -274,69 +288,71 @@ static void unlock_card(struct isi_board
  *  ISI Card specific ops ...
  */
 
+/* card->lock HAS to be held */
 static void raise_dtr(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
 	unsigned long base = card->base;
 	u16 channel = port->channel;
 
-	if (!lock_card(card))
+	if (WaitTillCardIsFree(base))
 		return;
 
 	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0504, base);
 	InterruptTheCard(base);
 	port->status |= ISI_DTR;
-	unlock_card(card);
 }
 
+/* card->lock HAS to be held */
 static inline void drop_dtr(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
 	unsigned long base = card->base;
 	u16 channel = port->channel;
 
-	if (!lock_card(card))
+	if (WaitTillCardIsFree(base))
 		return;
 
 	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0404, base);
 	InterruptTheCard(base);
 	port->status &= ~ISI_DTR;
-	unlock_card(card);
 }
 
+/* card->lock HAS to be held */
 static inline void raise_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
 	unsigned long base = card->base;
 	u16 channel = port->channel;
 
-	if (!lock_card(card))
+	if (WaitTillCardIsFree(base))
 		return;
 
 	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0a04, base);
 	InterruptTheCard(base);
 	port->status |= ISI_RTS;
-	unlock_card(card);
 }
+
+/* card->lock HAS to be held */
 static inline void drop_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
 	unsigned long base = card->base;
 	u16 channel = port->channel;
 
-	if (!lock_card(card))
+	if (WaitTillCardIsFree(base))
 		return;
 
 	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0804, base);
 	InterruptTheCard(base);
 	port->status &= ~ISI_RTS;
-	unlock_card(card);
 }
 
+/* card->lock MUST NOT be held */
 static inline void raise_dtr_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
@@ -353,35 +369,20 @@ static inline void raise_dtr_rts(struct 
 	unlock_card(card);
 }
 
+/* card->lock HAS to be held */
 static void drop_dtr_rts(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
 	unsigned long base = card->base;
 	u16 channel = port->channel;
 
-	if (!lock_card(card))
+	if (WaitTillCardIsFree(base))
 		return;
 
 	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0c04, base);
 	InterruptTheCard(base);
 	port->status &= ~(ISI_RTS | ISI_DTR);
-	unlock_card(card);
-}
-
-static inline void kill_queue(struct isi_port *port, short queue)
-{
-	struct isi_board *card = port->card;
-	unsigned long base = card->base;
-	u16 channel = port->channel;
-
-	if (!lock_card(card))
-		return;
-
-	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
-	outw((queue << 8) | 0x06, base);
-	InterruptTheCard(base);
-	unlock_card(card);
 }
 
 /*
@@ -592,6 +593,7 @@ static irqreturn_t isicom_interrupt(int 
 			ClearInterrupt(base);
 		else
 			outw(0x0000, base+0x04); /* enable interrupts */
+		spin_unlock(&card->card_lock);
 		return IRQ_HANDLED;
 	}
 
@@ -712,6 +714,7 @@ static irqreturn_t isicom_interrupt(int 
 		ClearInterrupt(base);
 	else
 		outw(0x0000, base+0x04); /* enable interrupts */
+	spin_unlock(&card->card_lock);
 
 	return IRQ_HANDLED;
 }
@@ -762,7 +765,7 @@ static void isicom_config_port(struct is
 	else
 		raise_dtr(port);
 
-	if (lock_card(card)) {
+	if (WaitTillCardIsFree(base) == 0) {
 		outw(0x8000 | (channel << shift_count) |0x03, base);
 		outw(linuxb_to_isib[baud] << 8 | 0x03, base);
 		channel_setup = 0;
@@ -790,7 +793,6 @@ static void isicom_config_port(struct is
 		}
 		outw(channel_setup, base);
 		InterruptTheCard(base);
-		unlock_card(card);
 	}
 	if (C_CLOCAL(tty))
 		port->flags &= ~ASYNC_CHECK_CD;
@@ -809,12 +811,11 @@ static void isicom_config_port(struct is
 	if (I_IXOFF(tty))
 		flow_ctrl |= ISICOM_INITIATE_XONXOFF;
 
-	if (lock_card(card)) {
+	if (WaitTillCardIsFree(base) == 0) {
 		outw(0x8000 | (channel << shift_count) |0x04, base);
 		outw(flow_ctrl << 8 | 0x05, base);
 		outw((STOP_CHAR(tty)) << 8 | (START_CHAR(tty)), base);
 		InterruptTheCard(base);
-		unlock_card(card);
 	}
 
 	/*	rx enabled -> enable port for rx on the card	*/
@@ -839,10 +840,9 @@ static inline void isicom_setup_board(st
 	}
 	port = bp->ports;
 	bp->status |= BOARD_ACTIVE;
-	spin_unlock_irqrestore(&bp->card_lock, flags);
 	for (channel = 0; channel < bp->port_count; channel++, port++)
 		drop_dtr_rts(port);
-	return;
+	spin_unlock_irqrestore(&bp->card_lock, flags);
 }
 
 static int isicom_setup_port(struct isi_port *port)
@@ -875,7 +875,12 @@ static int isicom_setup_port(struct isi_
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
 
 	/*	discard any residual data	*/
-	kill_queue(port, ISICOM_KILLTX | ISICOM_KILLRX);
+	if (WaitTillCardIsFree(card->base) == 0) {
+		outw(0x8000 | (port->channel << card->shift_count) | 0x02,
+				card->base);
+		outw(((ISICOM_KILLTX | ISICOM_KILLRX) << 8) | 0x06, card->base);
+		InterruptTheCard(card->base);
+	}
 
 	isicom_config_port(port);
 	port->flags |= ASYNC_INITIALIZED;
@@ -1030,7 +1035,6 @@ static void isicom_shutdown_port(struct 
 	port->flags &= ~ASYNC_INITIALIZED;
 	/* 3rd October 2000 : Vinayak P Risbud */
 	port->tty = NULL;
-	spin_unlock_irqrestore(&card->card_lock, flags);
 
 	/*Fix done by Anil .S on 30-04-2001
 	remote login through isi port has dtr toggle problem
@@ -1041,6 +1045,7 @@ static void isicom_shutdown_port(struct 
 	if (C_HUPCL(tty))
 		/* drop dtr on this port */
 		drop_dtr(port);
+	spin_unlock_irqrestore(&card->card_lock, flags);
 
 	/* any other port uninits  */
 	if (tty)
@@ -1276,10 +1281,12 @@ static int isicom_tiocmset(struct tty_st
 	unsigned int set, unsigned int clear)
 {
 	struct isi_port *port = tty->driver_data;
+	unsigned long flags;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
 		return -ENODEV;
 
+	spin_lock_irqsave(&port->card->card_lock, flags);
 	if (set & TIOCM_RTS)
 		raise_rts(port);
 	if (set & TIOCM_DTR)
@@ -1289,6 +1296,7 @@ static int isicom_tiocmset(struct tty_st
 		drop_rts(port);
 	if (clear & TIOCM_DTR)
 		drop_dtr(port);
+	spin_unlock_irqrestore(&port->card->card_lock, flags);
 
 	return 0;
 }
@@ -1321,7 +1329,10 @@ static int isicom_set_serial_info(struct
 				(newinfo.flags & ASYNC_FLAGS));
 	}
 	if (reconfig_port) {
+		unsigned long flags;
+		spin_lock_irqsave(&port->card->card_lock, flags);
 		isicom_config_port(port);
+		spin_unlock_irqrestore(&port->card->card_lock, flags);
 	}
 	return 0;
 }
@@ -1402,6 +1413,7 @@ static void isicom_set_termios(struct tt
 	struct termios *old_termios)
 {
 	struct isi_port *port = tty->driver_data;
+	unsigned long flags;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_set_termios"))
 		return;
@@ -1410,7 +1422,9 @@ static void isicom_set_termios(struct tt
 			tty->termios->c_iflag == old_termios->c_iflag)
 		return;
 
+	spin_lock_irqsave(&port->card->card_lock, flags);
 	isicom_config_port(port);
+	spin_unlock_irqrestore(&port->card->card_lock, flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) &&
 			!(tty->termios->c_cflag & CRTSCTS)) {
@@ -1704,16 +1718,6 @@ end:
 	return retval;
 }
 
-static inline int WaitTillCardIsFree(u16 base)
-{
-	unsigned long count = 0;
-
-	while (!(inw(base + 0xe) & 0x1) && count++ < 100)
-		msleep(5);
-
-	return !(inw(base + 0xe) & 0x1);
-}
-
 static int __devinit load_firmware(struct pci_dev *pdev,
 	const unsigned int index, const unsigned int signature)
 {
