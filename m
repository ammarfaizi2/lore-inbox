Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVGKSdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVGKSdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVGKSbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:31:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57034 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261393AbVGKSaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:30:46 -0400
Date: Mon, 11 Jul 2005 14:33:37 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: pty_chars_in_buffer oops fix
Message-ID: <Pine.LNX.4.61.0507111426240.5005@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

This is a re-posting of a fix for a race condition between changing the 
line discipline on a pty and and a poll on the 'other' side. The reference 
is: http://marc.theaimsgroup.com/?l=linux-kernel&m=111342171410005&w=2. 
Below is a diff against the current tree.

thanks,

-Jason

--- linux-2.6.12/drivers/char/pty.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.12.working/drivers/char/pty.c	2005-07-11 12:21:03.000000000 -0400
@@ -149,15 +149,14 @@
 static int pty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct tty_struct *to = tty->link;
-	ssize_t (*chars_in_buffer)(struct tty_struct *);
 	int count;
 
 	/* We should get the line discipline lock for "tty->link" */
-	if (!to || !(chars_in_buffer = to->ldisc.chars_in_buffer))
+	if (!to || !to->ldisc.chars_in_buffer)
 		return 0;
 
 	/* The ldisc must report 0 if no characters available to be read */
-	count = chars_in_buffer(to);
+	count = to->ldisc.chars_in_buffer(to);
 
 	if (tty->driver->subtype == PTY_TYPE_SLAVE) return count;
 
--- linux-2.6.12/drivers/char/tty_io.c	2005-07-11 12:13:48.000000000 -0400
+++ linux-2.6.12.working/drivers/char/tty_io.c	2005-07-11 12:19:21.000000000 -0400
@@ -470,21 +470,19 @@
  
 static int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 {
-	int	retval = 0;
-	struct	tty_ldisc o_ldisc;
+	int retval = 0;
+	struct tty_ldisc o_ldisc;
 	char buf[64];
 	int work;
 	unsigned long flags;
 	struct tty_ldisc *ld;
+	struct tty_struct *o_tty;
 
 	if ((ldisc < N_TTY) || (ldisc >= NR_LDISCS))
 		return -EINVAL;
 
 restart:
 
-	if (tty->ldisc.num == ldisc)
-		return 0;	/* We are already in the desired discipline */
-	
 	ld = tty_ldisc_get(ldisc);
 	/* Eduardo Blanco <ejbs@cs.cs.com.uy> */
 	/* Cyrus Durgin <cider@speakeasy.org> */
@@ -495,45 +493,74 @@
 	if (ld == NULL)
 		return -EINVAL;
 
-	o_ldisc = tty->ldisc;
-
 	tty_wait_until_sent(tty, 0);
 
+	if (tty->ldisc.num == ldisc) {
+		tty_ldisc_put(ldisc);
+		return 0;
+	}
+
+	o_ldisc = tty->ldisc;
+	o_tty = tty->link;
+
 	/*
 	 *	Make sure we don't change while someone holds a
 	 *	reference to the line discipline. The TTY_LDISC bit
 	 *	prevents anyone taking a reference once it is clear.
 	 *	We need the lock to avoid racing reference takers.
 	 */
-	 
+
 	spin_lock_irqsave(&tty_ldisc_lock, flags);
-	if(tty->ldisc.refcount)
-	{
-		/* Free the new ldisc we grabbed. Must drop the lock
-		   first. */
+	if (tty->ldisc.refcount || (o_tty && o_tty->ldisc.refcount)) {
+		if(tty->ldisc.refcount) {
+			/* Free the new ldisc we grabbed. Must drop the lock
+			   first. */
+			spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+			tty_ldisc_put(ldisc);		
+			/*
+			 * There are several reasons we may be busy, including
+			 * random momentary I/O traffic. We must therefore
+			 * retry. We could distinguish between blocking ops
+			 * and retries if we made tty_ldisc_wait() smarter. That
+			 * is up for discussion.
+			 */
+			if (wait_event_interruptible(tty_ldisc_wait, tty->ldisc.refcount == 0) < 0)
+				return -ERESTARTSYS;
+			goto restart;
+		}
+		if(o_tty && o_tty->ldisc.refcount) {
+			spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+			tty_ldisc_put(ldisc);
+			if (wait_event_interruptible(tty_ldisc_wait, o_tty->ldisc.refcount == 0) < 0)
+				return -ERESTARTSYS;
+			goto restart;
+		}
+	}
+
+	/* if the TTY_LDISC bit is set, then we are racing against another ldisc change */
+
+	if (!test_bit(TTY_LDISC, &tty->flags)) {
 		spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 		tty_ldisc_put(ldisc);
-		/*
-		 * There are several reasons we may be busy, including
-		 * random momentary I/O traffic. We must therefore
-		 * retry. We could distinguish between blocking ops
-		 * and retries if we made tty_ldisc_wait() smarter. That
-		 * is up for discussion.
-		 */
-		if(wait_event_interruptible(tty_ldisc_wait, tty->ldisc.refcount == 0) < 0)
-			return -ERESTARTSYS;			
+		ld = tty_ldisc_ref_wait(tty);
+		tty_ldisc_deref(ld);
 		goto restart;
 	}
-	clear_bit(TTY_LDISC, &tty->flags);	
+
+	clear_bit(TTY_LDISC, &tty->flags);
 	clear_bit(TTY_DONT_FLIP, &tty->flags);
-	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
-	
+	if (o_tty) {
+		clear_bit(TTY_LDISC, &o_tty->flags);
+		clear_bit(TTY_DONT_FLIP, &o_tty->flags);
+	}
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);		
+
 	/*
 	 *	From this point on we know nobody has an ldisc
 	 *	usage reference, nor can they obtain one until
 	 *	we say so later on.
 	 */
-	 
+
 	work = cancel_delayed_work(&tty->flip.work);
 	/*
 	 * Wait for ->hangup_work and ->flip.work handlers to terminate
@@ -584,10 +611,12 @@
 	 */
 	 
 	tty_ldisc_enable(tty);
+	if (o_tty)
+		tty_ldisc_enable(o_tty);
 	
 	/* Restart it in case no characters kick it off. Safe if
 	   already running */
-	if(work)
+	if (work)
 		schedule_delayed_work(&tty->flip.work, 1);
 	return retval;
 }
