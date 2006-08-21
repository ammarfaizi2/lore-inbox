Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWHUTTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWHUTTD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 15:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWHUTTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 15:19:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40095 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750799AbWHUTTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 15:19:01 -0400
Subject: [PATCH] tty : Fix bits and note more bits to fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Aug 2006 20:40:16 +0100
Message-Id: <1156189216.18887.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you driver implements "break on" and "break off" this ensures you
won't get multiple overlapping requests or requests in parallel. If
your driver has its own break handling then its still your problem as
the driver author.

Break is also now serialized against writes from user space properly but
no new guarantees are made driver level about writes from the line
discipline itself (eg flow control or echo)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/tty_io.c linux-2.6.18-rc4-mm2/drivers/char/tty_io.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/tty_io.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/tty_io.c	2006-08-21 15:16:04.000000000 +0100
@@ -2718,6 +2720,8 @@
  *	Locking:
  *		Called functions take tty_ldisc_lock
  *		current->signal->tty check is safe without locks
+ *
+ *	FIXME: may race normal receive processing
  */
 
 static int tiocsti(struct tty_struct *tty, char __user *p)
@@ -2877,9 +2881,7 @@
  *	Locking:
  *		Takes tasklist lock internally to walk sessions
  *		Takes task_lock() when updating signal->tty
- *
- *	FIXME: tty_mutex is needed to protect signal->tty references.
- *	FIXME: why task_lock on the signal->tty reference ??
+ *		Takes tty_mutex() to protect tty instance
  *
  */
 
@@ -2914,9 +2916,11 @@
 		} else
 			return -EPERM;
 	}
+	mutex_lock(&tty_mutex);
 	task_lock(current);
 	current->signal->tty = tty;
 	task_unlock(current);
+	mutex_unlock(&tty_mutex);
 	current->signal->tty_old_pgrp = 0;
 	tty->session = current->signal->session;
 	tty->pgrp = process_group(current);
@@ -2956,8 +2960,6 @@
  *	permitted where the tty session is our session.
  *
  *	Locking: None
- *
- *	FIXME: current->signal->tty referencing is unsafe.
  */
 
 static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
@@ -3036,19 +3038,20 @@
  *	timed break functionality.
  *
  *	Locking:
- *		None
+ *		atomic_write_lock serializes
  *
- *	FIXME:
- *		What if two overlap
  */
 
 static int send_break(struct tty_struct *tty, unsigned int duration)
 {
+	if(mutex_lock_interruptible(&tty->atomic_write_lock))
+		return -EINTR;
 	tty->driver->break_ctl(tty, -1);
 	if (!signal_pending(current)) {
 		msleep_interruptible(duration);
 	}
 	tty->driver->break_ctl(tty, 0);
+	mutex_unlock(&tty->atomic_write_lock);
 	if (signal_pending(current))
 		return -EINTR;
 	return 0;
@@ -3141,6 +3144,8 @@
 	if (tty_paranoia_check(tty, inode, "tty_ioctl"))
 		return -EINVAL;
 
+	/* CHECKME: is this safe as one end closes ? */
+	
 	real_tty = tty;
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver->subtype == PTY_TYPE_MASTER)

