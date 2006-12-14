Return-Path: <linux-kernel-owner+w=401wt.eu-S1751881AbWLNAj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWLNAj2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWLNAj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:39:27 -0500
Received: from av1.karneval.cz ([81.27.192.123]:19924 "EHLO av1.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881AbWLNAj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:39:27 -0500
Message-id: <16468312961305320785@karneval.cz>
Subject: [RFC 1/1] Char: isicom, remove tty_{hang,wake}up bottomhalves
From: Jiri Slaby <jirislaby@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>
Date: Thu, 14 Dec 2006 01:35:17 +0100 (CET)
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, remove tty_{hang,wake}up bottomhalves

- tty_hangup() itself schedules work, so there is no need to schedule hangup
  in the driver
- tty_wakeup() its safe to call it while in atomic (IS THIS CORRECT?), so that
  its schedule_work might be also wiped out

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit b62174aca5765ae3276ca6e6818851ec891549de
tree 4817d10d4653c336e8fb4a10d4f3465c18ad4aa1
parent e390aa02b0dc66a2b3531f779b94441b14c68c39
author Jiri Slaby <jirislaby@gmail.com> Thu, 14 Dec 2006 01:30:50 +0100
committer Jiri Slaby <jirislaby@gmail.com> Thu, 14 Dec 2006 01:30:50 +0100

 drivers/char/isicom.c |   36 +++---------------------------------
 1 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 41fb8bd..836e967 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -213,8 +213,6 @@ struct	isi_port {
 	struct tty_struct 	* tty;
 	wait_queue_head_t	close_wait;
 	wait_queue_head_t	open_wait;
-	struct work_struct	hangup_tq;
-	struct work_struct	bh_tqueue;
 	unsigned char		* xmit_buf;
 	int			xmit_head;
 	int			xmit_tail;
@@ -509,7 +507,7 @@ static void isicom_tx(unsigned long _data)
 		if (port->xmit_cnt <= 0)
 			port->status &= ~ISI_TXOK;
 		if (port->xmit_cnt <= WAKEUP_CHARS)
-			schedule_work(&port->bh_tqueue);
+			tty_wakeup(tty);
 		unlock_card(&isi_card[card]);
 	}
 
@@ -523,21 +521,6 @@ sched_again:
 	mod_timer(&tx, jiffies + msecs_to_jiffies(10));
 }
 
-/* 	Interrupt handlers 	*/
-
-
-static void isicom_bottomhalf(struct work_struct *work)
-{
-	struct isi_port *port = container_of(work, struct isi_port, bh_tqueue);
-	struct tty_struct *tty = port->tty;
-
-	if (!tty)
-		return;
-
-	tty_wakeup(tty);
-	wake_up_interruptible(&tty->write_wait);
-}
-
 /*
  *	Main interrupt handler routine
  */
@@ -609,7 +592,7 @@ static irqreturn_t isicom_interrupt(int irq, void *dev_id)
 						pr_dbg("interrupt: DCD->low.\n"
 							);
 						port->status &= ~ISI_DCD;
-						schedule_work(&port->hangup_tq);
+						tty_hangup(tty);
 					}
 				} else if (header & ISI_DCD) {
 				/* Carrier has been detected */
@@ -631,7 +614,7 @@ static irqreturn_t isicom_interrupt(int irq, void *dev_id)
 						/* start tx ing */
 						port->status |= (ISI_TXOK
 							| ISI_CTS);
-						schedule_work(&port->bh_tqueue);
+						tty_wakeup(tty);
 					}
 				} else if (!(header & ISI_CTS)) {
 					port->tty->hw_stopped = 1;
@@ -1457,17 +1440,6 @@ static void isicom_start(struct tty_struct *tty)
 	port->status |= ISI_TXOK;
 }
 
-/* hangup et all */
-static void do_isicom_hangup(struct work_struct *work)
-{
-	struct isi_port *port = container_of(work, struct isi_port, hangup_tq);
-	struct tty_struct *tty;
-
-	tty = port->tty;
-	if (tty)
-		tty_hangup(tty);
-}
-
 static void isicom_hangup(struct tty_struct *tty)
 {
 	struct isi_port *port = tty->driver_data;
@@ -1861,8 +1833,6 @@ static int __init isicom_init(void)
 			port->channel = channel;
 			port->close_delay = 50 * HZ/100;
 			port->closing_wait = 3000 * HZ/100;
-			INIT_WORK(&port->hangup_tq, do_isicom_hangup);
-			INIT_WORK(&port->bh_tqueue, isicom_bottomhalf);
 			port->status = 0;
 			init_waitqueue_head(&port->open_wait);
 			init_waitqueue_head(&port->close_wait);
