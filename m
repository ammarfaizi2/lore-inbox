Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312704AbSDONyA>; Mon, 15 Apr 2002 09:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312706AbSDONx7>; Mon, 15 Apr 2002 09:53:59 -0400
Received: from www.microgate.com ([216.30.46.105]:35083 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S312704AbSDONx5>; Mon, 15 Apr 2002 09:53:57 -0400
Subject: [PATCH] 2.5.8 n_hdlc.c
From: Paul Fulghum <paulkf@microgate.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 15 Apr 2002 08:51:48 -0500
Message-Id: <1018878709.1112.7.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch against 2.5.8

Remove localy defined wait queues and use wait queues
in tty structure of same function. This matches the
n_tty.c behavior.

Handle pty hangup when blocked on read.

These 2 changes fix use of n_hdlc with PPPoATM and
are mirror changes included in 2.4.19-pre

This is unchanged from previously submitted patch against 2.5.8-pre3

--- linux-2.5.8/drivers/char/n_hdlc.c	Sun Apr 14 14:18:48 2002
+++ linux-2.5.8-mg/drivers/char/n_hdlc.c	Wed Apr 10 15:43:28 2002
@@ -9,7 +9,7 @@
  *	Al Longyear <longyear@netcom.com>, Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
  *
  * Original release 01/11/99
- * $Id: n_hdlc.c,v 3.2 2000/11/06 22:34:38 paul Exp $
+ * $Id: n_hdlc.c,v 4.1 2002/04/10 19:30:58 paulkf Exp $
  *
  * This code is released under the GNU General Public License (GPL)
  *
@@ -78,7 +78,7 @@
  */
 
 #define HDLC_MAGIC 0x239e
-#define HDLC_VERSION "3.2"
+#define HDLC_VERSION "$Revision: 4.1 $"
 
 #include <linux/version.h>
 #include <linux/config.h>
@@ -159,11 +159,6 @@
 	struct tty_struct *tty;		/* ptr to TTY structure	*/
 	struct tty_struct *backup_tty;	/* TTY to use if tty gets closed */
 	
-	/* Queues for select() functionality */
-	wait_queue_head_t read_wait;
-	wait_queue_head_t write_wait;
-	wait_queue_head_t poll_wait;
-
 	int		tbusy;		/* reentrancy flag for tx wakeup code */
 	int		woke_up;
 	N_HDLC_BUF	*tbuf;		/* currently transmitting tx buffer */
@@ -234,9 +229,8 @@
 		printk("%s(%d)n_hdlc_release() called\n",__FILE__,__LINE__);
 		
 	/* Ensure that the n_hdlcd process is not hanging on select()/poll() */
-	wake_up_interruptible (&n_hdlc->read_wait);
-	wake_up_interruptible (&n_hdlc->poll_wait);
-	wake_up_interruptible (&n_hdlc->write_wait);
+	wake_up_interruptible (&tty->read_wait);
+	wake_up_interruptible (&tty->write_wait);
 
 	if (tty != NULL && tty->disc_data == n_hdlc)
 		tty->disc_data = NULL;	/* Break the tty->n_hdlc link */
@@ -431,8 +425,7 @@
 			n_hdlc->tbuf = NULL;
 			
 			/* wait up sleeping writers */
-			wake_up_interruptible(&n_hdlc->write_wait);
-			wake_up_interruptible(&n_hdlc->poll_wait);
+			wake_up_interruptible(&tty->write_wait);
 	
 			/* get next pending transmit buffer */
 			tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
@@ -574,8 +567,7 @@
 	n_hdlc_buf_put(&n_hdlc->rx_buf_list,buf);
 	
 	/* wake up any blocked reads and perform async signalling */
-	wake_up_interruptible (&n_hdlc->read_wait);
-	wake_up_interruptible (&n_hdlc->poll_wait);
+	wake_up_interruptible (&tty->read_wait);
 	if (n_hdlc->tty->fasync != NULL)
 		kill_fasync (&n_hdlc->tty->fasync, SIGIO, POLL_IN);
 
@@ -620,6 +612,9 @@
 	}
 
 	for (;;) {
+		if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
+			return -EIO;
+
 		n_hdlc = tty2n_hdlc (tty);
 		if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC ||
 			 tty != n_hdlc->tty)
@@ -633,7 +628,7 @@
 		if (file->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 			
-		interruptible_sleep_on (&n_hdlc->read_wait);
+		interruptible_sleep_on (&tty->read_wait);
 		if (signal_pending(current))
 			return -EINTR;
 	}
@@ -702,7 +697,7 @@
 		count = maxframe;
 	}
 	
-	add_wait_queue(&n_hdlc->write_wait, &wait);
+	add_wait_queue(&tty->write_wait, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	
 	/* Allocate transmit buffer */
@@ -725,7 +720,7 @@
 	}
 
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&n_hdlc->write_wait, &wait);
+	remove_wait_queue(&tty->write_wait, &wait);
 
 	if (!error) {		
 		/* Retrieve the user's buffer */
@@ -835,12 +830,14 @@
 	if (n_hdlc && n_hdlc->magic == HDLC_MAGIC && tty == n_hdlc->tty) {
 		/* queue current process into any wait queue that */
 		/* may awaken in the future (read and write) */
-		poll_wait(filp, &n_hdlc->poll_wait, wait);
+
+		poll_wait(filp, &tty->read_wait, wait);
+		poll_wait(filp, &tty->write_wait, wait);
 
 		/* set bits for operations that wont block */
 		if(n_hdlc->rx_buf_list.head)
 			mask |= POLLIN | POLLRDNORM;	/* readable */
-		if(tty->flags & (1 << TTY_OTHER_CLOSED))
+		if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
 			mask |= POLLHUP;
 		if(tty_hung_up_p(filp))
 			mask |= POLLHUP;
@@ -894,11 +891,7 @@
 	
 	/* Initialize the control block */
 	n_hdlc->magic  = HDLC_MAGIC;
-
 	n_hdlc->flags  = 0;
-	init_waitqueue_head(&n_hdlc->read_wait);
-	init_waitqueue_head(&n_hdlc->poll_wait);
-	init_waitqueue_head(&n_hdlc->write_wait);
 	
 	return n_hdlc;
 	

