Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUIOU0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUIOU0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267396AbUIOUYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:24:53 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:62525 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267383AbUIOUXd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:23:33 -0400
Subject: Re: PATCH: tty locking for 2.6.9rc2
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040915200856.GA8000@devserv.devel.redhat.com>
References: <20040914163426.GA29253@devserv.devel.redhat.com>
	 <1095265595.2924.27.camel@deimos.microgate.com>
	 <20040915163051.GA9096@devserv.devel.redhat.com>
	 <1095274482.2686.16.camel@deimos.microgate.com>
	 <20040915200856.GA8000@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095279799.2958.11.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Sep 2004 15:23:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan:

Here is a patch against your last patch that clears
up both the per tty refcount initialization and
the remove_dev() global refcount leak.

I've tested it and it seems to work.

The patch is not meant to be applied and
is just for your information in deciding
how you want the final code to look.

--- linux-2.6.9/drivers/char/tty_io.c	2004-09-15 15:19:58.044611590 -0500
+++ linux-2.6.9-mg/drivers/char/tty_io.c	2004-09-15 15:19:34.690680997 -0500
@@ -288,6 +288,7 @@
 	}
 	else
 		ld = NULL;
+	if (ld) printk("tty_ldisc_get ld=%p refcount=%d\n", ld, ld->refcount);
 	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	return ld;
 }
@@ -307,6 +308,7 @@
 	if(ld->refcount == 0)
 		BUG();
 	ld->refcount --;
+	printk("tty_ldisc_put ld=%p refcount=%d\n", ld, ld->refcount);
 	module_put(ld->owner);
 	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 }
@@ -497,6 +499,7 @@
 
 	/* Now set up the new line discipline. */
 	tty->ldisc = *ld;
+	tty->ldisc.refcount = 0;
 	tty->termios->c_line = ldisc;
 	if (tty->ldisc.open)
 		retval = (tty->ldisc.open)(tty);
@@ -504,11 +507,13 @@
 		tty_ldisc_put(ldisc);
 		/* There is an outstanding reference here so this is safe */
 		tty->ldisc = *tty_ldisc_get(o_ldisc.num);
+		tty->ldisc.refcount = 0;
 		tty->termios->c_line = tty->ldisc.num;
 		if (tty->ldisc.open && (tty->ldisc.open(tty) < 0)) {
 			tty_ldisc_put(o_ldisc.num);
 			/* This driver is always present */
 			tty->ldisc = *tty_ldisc_get(N_TTY);
+			tty->ldisc.refcount = 0;
 			tty->termios->c_line = N_TTY;
 			if (tty->ldisc.open) {
 				int r = tty->ldisc.open(tty);
@@ -1567,15 +1572,15 @@
 	/*
 	 *	Switch the line discipline back
 	 */
-	tty->ldisc = *tty_ldisc_get(N_TTY);
-	tty->termios->c_line = N_TTY;
+//	tty->ldisc = *tty_ldisc_get(N_TTY);
+//	tty->termios->c_line = N_TTY;
 	if (o_tty) {
 		/* FIXME: could o_tty be in setldisc here ? */
 		clear_bit(TTY_LDISC, &o_tty->flags);
 		if (o_tty->ldisc.close)
 			(o_tty->ldisc.close)(o_tty);
 		tty_ldisc_put(o_tty->ldisc.num);
-		o_tty->ldisc = *tty_ldisc_get(N_TTY);
+//		o_tty->ldisc = *tty_ldisc_get(N_TTY);
 	}
 
 	/*
@@ -2466,6 +2471,7 @@
 	memset(tty, 0, sizeof(struct tty_struct));
 	tty->magic = TTY_MAGIC;
 	tty->ldisc = *tty_ldisc_get(N_TTY);
+	tty->ldisc.refcount = 0;
 	tty->pgrp = -1;
 	tty->flip.char_buf_ptr = tty->flip.char_buf;
 	tty->flip.flag_buf_ptr = tty->flip.flag_buf;

Thanks,
Paul
 
--
Paul Fulghum
paulkf@microgate.com


