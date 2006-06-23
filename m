Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWFWOvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWFWOvx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWFWOvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:51:53 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:50564
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750810AbWFWOvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:51:52 -0400
Subject: [PATCH] remove TTY_DONT_FLIP
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 09:51:30 -0500
Message-Id: <1151074290.3650.16.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove TTY_DONT_FLIP tty flag. This flag was introduced
in 2.1.X kernels to prevent the N_TTY line discipline
functions read_chan() and n_tty_receive_buf() from running
at the same time. 2.2.15 introduced tty->read_lock to protect
access to the N_TTY read buffer, which is the only state
requiring protection between these two functions.

The current TTY_DONT_FLIP implementation is broken
for SMP, and is not universally honored by drivers
that send data directly to the line discipline receive_buf function.

Because TTY_DONT_FLIP is not necessary, is broken in implementation,
and is not universally honored, it is removed.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- a/include/linux/tty.h	2006-06-22 10:56:12.000000000 -0500
+++ b/include/linux/tty.h	2006-06-22 12:10:10.000000000 -0500
@@ -260,7 +260,6 @@ struct tty_struct {
 #define TTY_DO_WRITE_WAKEUP 	5	/* Call write_wakeup after queuing new */
 #define TTY_PUSH 		6	/* n_tty private */
 #define TTY_CLOSING 		7	/* ->close() in progress */
-#define TTY_DONT_FLIP 		8	/* Defer buffer flip */
 #define TTY_LDISC 		9	/* Line discipline attached */
 #define TTY_HW_COOK_OUT 	14	/* Hardware can do output cooking */
 #define TTY_HW_COOK_IN 		15	/* Hardware can do input cooking */
--- a/drivers/char/n_tty.c	2006-06-17 20:49:35.000000000 -0500
+++ b/drivers/char/n_tty.c	2006-06-22 12:06:02.000000000 -0500
@@ -1132,7 +1132,7 @@ static inline int input_available_p(stru
  *	buffer, and once to drain the space from the (physical) beginning of
  *	the buffer to head pointer.
  *
- *	Called under the tty->atomic_read_lock sem and with TTY_DONT_FLIP set
+ *	Called under the tty->atomic_read_lock sem
  *
  */
  
@@ -1271,7 +1271,6 @@ do_it_again:
 	}
 
 	add_wait_queue(&tty->read_wait, &wait);
-	set_bit(TTY_DONT_FLIP, &tty->flags);
 	while (nr) {
 		/* First test for status change. */
 		if (tty->packet && tty->link->ctrl_status) {
@@ -1315,9 +1314,7 @@ do_it_again:
 				break;
 			}
 			n_tty_set_room(tty);
-			clear_bit(TTY_DONT_FLIP, &tty->flags);
 			timeout = schedule_timeout(timeout);
-			set_bit(TTY_DONT_FLIP, &tty->flags);
 			continue;
 		}
 		__set_current_state(TASK_RUNNING);
@@ -1394,7 +1391,6 @@ do_it_again:
 		if (time)
 			timeout = time;
 	}
-	clear_bit(TTY_DONT_FLIP, &tty->flags);
 	mutex_unlock(&tty->atomic_read_lock);
 	remove_wait_queue(&tty->read_wait, &wait);
 
--- a/drivers/char/tty_io.c	2006-06-22 10:56:12.000000000 -0500
+++ b/drivers/char/tty_io.c	2006-06-22 12:13:14.000000000 -0500
@@ -784,11 +784,8 @@ restart:
 	}
 
 	clear_bit(TTY_LDISC, &tty->flags);
-	clear_bit(TTY_DONT_FLIP, &tty->flags);
-	if (o_tty) {
+	if (o_tty)
 		clear_bit(TTY_LDISC, &o_tty->flags);
-		clear_bit(TTY_DONT_FLIP, &o_tty->flags);
-	}
 	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 
 	/*
@@ -1955,7 +1952,6 @@ static void release_dev(struct file * fi
 	 * race with the set_ldisc code path.
 	 */
 	clear_bit(TTY_LDISC, &tty->flags);
-	clear_bit(TTY_DONT_FLIP, &tty->flags);
 	cancel_delayed_work(&tty->buf.work);
 
 	/*
@@ -2785,13 +2781,6 @@ static void flush_to_ldisc(void *private
 	if (disc == NULL)	/*  !TTY_LDISC */
 		return;
 
-	if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
-		/*
-		 * Do it after the next timer tick:
-		 */
-		schedule_delayed_work(&tty->buf.work, 1);
-		goto out;
-	}
 	spin_lock_irqsave(&tty->buf.lock, flags);
 	while((tbuf = tty->buf.head) != NULL) {
 		while ((count = tbuf->commit - tbuf->read) != 0) {
@@ -2810,7 +2799,7 @@ static void flush_to_ldisc(void *private
 		tty_buffer_free(tty, tbuf);
 	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
-out:
+
 	tty_ldisc_deref(disc);
 }
 
--- a/drivers/char/pty.c	2006-06-17 20:49:35.000000000 -0500
+++ b/drivers/char/pty.c	2006-06-22 12:14:10.000000000 -0500
@@ -101,7 +101,7 @@ static void pty_unthrottle(struct tty_st
  *
  * FIXME: Our pty_write method is called with our ldisc lock held but
  * not our partners. We can't just take the other one blindly without
- * risking deadlocks.  There is also the small matter of TTY_DONT_FLIP
+ * risking deadlocks.
  */
 static int pty_write(struct tty_struct * tty, const unsigned char *buf, int count)
 {
--- a/drivers/char/mxser.c	2006-06-17 20:49:35.000000000 -0500
+++ b/drivers/char/mxser.c	2006-06-22 12:15:06.000000000 -0500
@@ -953,7 +953,6 @@ static int mxser_open(struct tty_struct 
 
 	info->session = current->signal->session;
 	info->pgrp = process_group(current);
-	clear_bit(TTY_DONT_FLIP, &tty->flags);
 
 	//status = mxser_get_msr(info->base, 0, info->port);
 	//mxser_check_modem_status(info, status);
--- a/drivers/serial/crisv10.c	2006-06-17 20:49:35.000000000 -0500
+++ b/drivers/serial/crisv10.c	2006-06-22 12:17:12.000000000 -0500
@@ -2573,12 +2573,6 @@ static void flush_to_flip_buffer(struct 
 
 	DFLIP(
 	  if (1) {
-
-		  if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
-			  DEBUG_LOG(info->line, "*** TTY_DONT_FLIP set flip.count %i ***\n", tty->flip.count);
-			  DEBUG_LOG(info->line, "*** recv_cnt %i\n", info->recv_cnt);
-		  } else {
-		  }
 		  DEBUG_LOG(info->line, "*** rxtot %i\n", info->icount.rx);
 		  DEBUG_LOG(info->line, "ldisc %lu\n", tty->ldisc.chars_in_buffer(tty));
 		  DEBUG_LOG(info->line, "room  %lu\n", tty->ldisc.receive_room(tty));
--- a/drivers/serial/jsm/jsm_tty.c	2006-06-17 20:49:35.000000000 -0500
+++ b/drivers/serial/jsm/jsm_tty.c	2006-06-22 12:19:14.000000000 -0500
@@ -589,13 +589,6 @@ void jsm_input(struct jsm_channel *ch)
 	ld = tty_ldisc_ref(tp);
 
 	/*
-	 * If the DONT_FLIP flag is on, don't flush our buffer, and act
-	 * like the ld doesn't have any space to put the data right now.
-	 */
-	if (test_bit(TTY_DONT_FLIP, &tp->flags))
-		len = 0;
-
-	/*
 	 * If we were unable to get a reference to the ld,
 	 * don't flush our buffer, and act like the ld doesn't
 	 * have any space to put the data right now.
--- a/drivers/usb/serial/ir-usb.c	2006-06-17 20:49:35.000000000 -0500
+++ b/drivers/usb/serial/ir-usb.c	2006-06-22 12:20:51.000000000 -0500
@@ -453,8 +453,7 @@ static void ir_read_bulk_callback (struc
 			tty = port->tty;
 
 			/*
-			 *	FIXME: must not do this in IRQ context,
-			 *	must honour TTY_DONT_FLIP
+			 *	FIXME: must not do this in IRQ context
 			 */
 			tty->ldisc.receive_buf(
 				tty,
--- a/net/bluetooth/rfcomm/tty.c	2006-06-17 20:49:35.000000000 -0500
+++ b/net/bluetooth/rfcomm/tty.c	2006-06-22 12:24:30.000000000 -0500
@@ -480,12 +480,8 @@ static void rfcomm_dev_data_ready(struct
 
 	BT_DBG("dlc %p tty %p len %d", dlc, tty, skb->len);
 
-	if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
-		tty_buffer_request_room(tty, skb->len);
-		tty_insert_flip_string(tty, skb->data, skb->len);
-		tty_flip_buffer_push(tty);
-	} else
-		tty->ldisc.receive_buf(tty, skb->data, NULL, skb->len);
+	tty_insert_flip_string(tty, skb->data, skb->len);
+	tty_flip_buffer_push(tty);
 
 	kfree_skb(skb);
 }


