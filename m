Return-Path: <linux-kernel-owner+w=401wt.eu-S1753720AbWLWTq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbWLWTq3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 14:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbWLWTq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 14:46:29 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:40904 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbWLWTq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 14:46:28 -0500
Message-id: <2249412545243025582@wsc.cz>
Subject: [PATCH 1/1] Char: isicom, eliminate spinlock recursion
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 23 Dec 2006 20:46:35 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, eliminate spinlock recursion

Many spinlock recursion was in the isicom driver. Eliminate it.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 59988b8c2d1ce45e5ccb715ac7ece78dfb73545a
tree d6060769defd71c77ffa340d579f95e24b783ebf
parent fe13ee556f3b973a3b27f154db9852766634d0d6
author Jiri Slaby <jirislaby@gmail.com> Sat, 23 Dec 2006 20:43:42 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 23 Dec 2006 20:43:42 +0059

 drivers/char/isicom.c |  103 ++++++++++++++++++++++++-------------------------
 1 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 0362740..26d3f78 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -228,6 +228,20 @@ static struct isi_port  isi_ports[PORT_COUNT];
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
@@ -274,69 +288,71 @@ static void unlock_card(struct isi_board *card)
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
@@ -353,35 +369,20 @@ static inline void raise_dtr_rts(struct isi_port *port)
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
@@ -727,7 +728,7 @@ static void isicom_config_port(struct isi_port *port)
 	else
 		raise_dtr(port);
 
-	if (lock_card(card)) {
+	if (WaitTillCardIsFree(base) == 0) {
 		outw(0x8000 | (channel << shift_count) |0x03, base);
 		outw(linuxb_to_isib[baud] << 8 | 0x03, base);
 		channel_setup = 0;
@@ -755,7 +756,6 @@ static void isicom_config_port(struct isi_port *port)
 		}
 		outw(channel_setup, base);
 		InterruptTheCard(base);
-		unlock_card(card);
 	}
 	if (C_CLOCAL(tty))
 		port->flags &= ~ASYNC_CHECK_CD;
@@ -774,12 +774,11 @@ static void isicom_config_port(struct isi_port *port)
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
@@ -804,10 +803,9 @@ static inline void isicom_setup_board(struct isi_board *bp)
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
@@ -840,7 +838,12 @@ static int isicom_setup_port(struct isi_port *port)
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
@@ -966,28 +969,22 @@ static int isicom_open(struct tty_struct *tty, struct file *filp)
 
 static inline void isicom_shutdown_board(struct isi_board *bp)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&bp->card_lock, flags);
 	if (bp->status & BOARD_ACTIVE) {
 		bp->status &= ~BOARD_ACTIVE;
 	}
-	spin_unlock_irqrestore(&bp->card_lock, flags);
 }
 
+/* card->lock HAS to be held */
 static void isicom_shutdown_port(struct isi_port *port)
 {
 	struct isi_board *card = port->card;
 	struct tty_struct *tty;
-	unsigned long flags;
 
 	tty = port->tty;
 
-	spin_lock_irqsave(&card->card_lock, flags);
-	if (!(port->flags & ASYNC_INITIALIZED)) {
-		spin_unlock_irqrestore(&card->card_lock, flags);
+	if (!(port->flags & ASYNC_INITIALIZED))
 		return;
-	}
+
 	if (port->xmit_buf) {
 		free_page((unsigned long) port->xmit_buf);
 		port->xmit_buf = NULL;
@@ -995,7 +992,6 @@ static void isicom_shutdown_port(struct isi_port *port)
 	port->flags &= ~ASYNC_INITIALIZED;
 	/* 3rd October 2000 : Vinayak P Risbud */
 	port->tty = NULL;
-	spin_unlock_irqrestore(&card->card_lock, flags);
 
 	/*Fix done by Anil .S on 30-04-2001
 	remote login through isi port has dtr toggle problem
@@ -1241,10 +1237,12 @@ static int isicom_tiocmset(struct tty_struct *tty, struct file *file,
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
@@ -1254,6 +1252,7 @@ static int isicom_tiocmset(struct tty_struct *tty, struct file *file,
 		drop_rts(port);
 	if (clear & TIOCM_DTR)
 		drop_dtr(port);
+	spin_unlock_irqrestore(&port->card->card_lock, flags);
 
 	return 0;
 }
@@ -1286,7 +1285,10 @@ static int isicom_set_serial_info(struct isi_port *port,
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
@@ -1367,6 +1369,7 @@ static void isicom_set_termios(struct tty_struct *tty,
 	struct ktermios *old_termios)
 {
 	struct isi_port *port = tty->driver_data;
+	unsigned long flags;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_set_termios"))
 		return;
@@ -1375,7 +1378,9 @@ static void isicom_set_termios(struct tty_struct *tty,
 			tty->termios->c_iflag == old_termios->c_iflag)
 		return;
 
+	spin_lock_irqsave(&port->card->card_lock, flags);
 	isicom_config_port(port);
+	spin_unlock_irqrestore(&port->card->card_lock, flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) &&
 			!(tty->termios->c_cflag & CRTSCTS)) {
@@ -1441,11 +1446,15 @@ static void isicom_start(struct tty_struct *tty)
 static void isicom_hangup(struct tty_struct *tty)
 {
 	struct isi_port *port = tty->driver_data;
+	unsigned long flags;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_hangup"))
 		return;
 
+	spin_lock_irqsave(&port->card->card_lock, flags);
 	isicom_shutdown_port(port);
+	spin_unlock_irqrestore(&port->card->card_lock, flags);
+
 	port->count = 0;
 	port->flags &= ~ASYNC_NORMAL_ACTIVE;
 	port->tty = NULL;
@@ -1550,16 +1559,6 @@ end:
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
