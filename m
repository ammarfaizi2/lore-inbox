Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUJBWQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUJBWQR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 18:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUJBWQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 18:16:17 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:10648 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267576AbUJBWQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 18:16:00 -0400
Subject: PATCH: Update termios to use per tty semaphore
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096751613.25752.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 02 Oct 2004 22:13:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the agreed change of termios locking to be semaphore based
sleep locking. This is needed for USB in particular as it has to use
messaging to issue terminal mode changes.

This code passes Torvalds test grades 0, 1 and 2 (it looks ok, it
compiles and it booted). It does mean that a driver cannot take an
atomic peek at termios data during an interrupt. Nobody seems to be
doing this although some of the driver receive paths for line
disciplines will eventually want to (n_tty currently doesn't do this
locked on the receive path). Since the ldisc is given a chance to copy
any essential bits on the ->set_termios path this seems not to be a
problem.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/Documentation/tty.txt linux-2.6.9rc3/Documentation/tty.txt
--- linux.vanilla-2.6.9rc3/Documentation/tty.txt	2004-09-30 16:13:07.000000000 +0100
+++ linux-2.6.9rc3/Documentation/tty.txt	2004-10-02 20:54:28.000000000 +0100
@@ -60,8 +60,8 @@
 
 set_termios()	-	Called on termios structure changes. The caller
 			passes the old termios data and the current data
-			is in the tty. Called under the termios lock so
-			may not sleep. Serialized against itself only.
+			is in the tty. Called under the termios semaphore so
+			allowed to sleep. Serialized against itself only.
 
 read()		-	Move data from the line discipline to the user.
 			Multiple read calls may occur in parallel and the
@@ -158,8 +158,8 @@
 
 ioctl()		-	Called when an ioctl may be for the driver
 
-set_termios()	-	Called on termios change, may get parallel calls,
-			may block for now (may change that)
+set_termios()	-	Called on termios change, serialized against
+			itself by a semaphore. May sleep.
 
 set_ldisc()	-	Notifier for discipline change. At the point this 
 			is done the discipline is not yet usable. Can now
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/drivers/char/tty_io.c linux-2.6.9rc3/drivers/char/tty_io.c
--- linux.vanilla-2.6.9rc3/drivers/char/tty_io.c	2004-09-30 16:13:08.000000000 +0100
+++ linux-2.6.9rc3/drivers/char/tty_io.c	2004-10-02 21:18:45.354174688 +0100
@@ -130,8 +130,6 @@
 /* Semaphore to protect creating and releasing a tty. This is shared with
    vt.c for deeply disgusting hack reasons */
 DECLARE_MUTEX(tty_sem);
-/* Lock for tty_termios changes - private to tty_io/tty_ioctl */
-spinlock_t tty_termios_lock = SPIN_LOCK_UNLOCKED;
 
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
@@ -239,10 +237,9 @@
  
 static void tty_set_termios_ldisc(struct tty_struct *tty, int num)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&tty_termios_lock, flags);
+	down(&tty->termios_sem);
 	tty->termios->c_line = num;
-	spin_unlock_irqrestore(&tty_termios_lock, flags);
+	up(&tty->termios_sem);
 }
 
 /*
@@ -811,10 +808,9 @@
 	 */
 	if (tty->driver->flags & TTY_DRIVER_RESET_TERMIOS)
 	{
-		unsigned long flags;
-		spin_lock_irqsave(&tty_termios_lock, flags);
+		down(&tty->termios_sem);
 		*tty->termios = tty->driver->init_termios;
-		spin_unlock_irqrestore(&tty_termios_lock, flags);
+		up(&tty->termios_sem);
 	}
 	
 	/* Defer ldisc switch */
@@ -2606,6 +2602,7 @@
 	tty->flip.flag_buf_ptr = tty->flip.flag_buf;
 	INIT_WORK(&tty->flip.work, flush_to_ldisc, tty);
 	init_MUTEX(&tty->flip.pty_sem);
+	init_MUTEX(&tty->termios_sem);
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
 	INIT_WORK(&tty->hangup_work, do_tty_hangup, tty);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/drivers/char/tty_ioctl.c linux-2.6.9rc3/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.9rc3/drivers/char/tty_ioctl.c	2004-09-30 16:13:08.000000000 +0100
+++ linux-2.6.9rc3/drivers/char/tty_ioctl.c	2004-10-02 21:00:51.029496864 +0100
@@ -29,8 +29,6 @@
 
 #undef	DEBUG
 
-extern spinlock_t tty_termios_lock;
-
 /*
  * Internal flag options for termios setting behavior
  */
@@ -101,7 +99,6 @@
 	int canon_change;
 	struct termios old_termios = *tty->termios;
 	struct tty_ldisc *ld;
-	unsigned long flags;
 	
 	/*
 	 *	Perform the actual termios internal changes under lock.
@@ -110,7 +107,7 @@
 
 	/* FIXME: we need to decide on some locking/ordering semantics
 	   for the set_termios notification eventually */
-	spin_lock_irqsave(&tty_termios_lock, flags);
+	down(&tty->termios_sem);
 
 	*tty->termios = *new_termios;
 	unset_locked_termios(tty->termios, &old_termios, tty->termios_locked);
@@ -155,7 +152,7 @@
 			(ld->set_termios)(tty, &old_termios);
 		tty_ldisc_deref(ld);
 	}
-	spin_unlock_irqrestore(&tty_termios_lock, flags);
+	up(&tty->termios_sem);
 }
 
 static int set_termios(struct tty_struct * tty, void __user *arg, int opt)
@@ -249,15 +246,14 @@
 static int get_sgttyb(struct tty_struct * tty, struct sgttyb __user * sgttyb)
 {
 	struct sgttyb tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&tty_termios_lock, flags);
+	down(&tty->termios_sem);
 	tmp.sg_ispeed = 0;
 	tmp.sg_ospeed = 0;
 	tmp.sg_erase = tty->termios->c_cc[VERASE];
 	tmp.sg_kill = tty->termios->c_cc[VKILL];
 	tmp.sg_flags = get_sgflags(tty);
-	spin_unlock_irqrestore(&tty_termios_lock, flags);
+	up(&tty->termios_sem);
 	
 	return copy_to_user(sgttyb, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
@@ -293,7 +289,6 @@
 	int retval;
 	struct sgttyb tmp;
 	struct termios termios;
-	unsigned long flags;
 
 	retval = tty_check_change(tty);
 	if (retval)
@@ -301,13 +296,13 @@
 	
 	if (copy_from_user(&tmp, sgttyb, sizeof(tmp)))
 		return -EFAULT;
-		
-	spin_lock_irqsave(&tty_termios_lock, flags);
+
+	down(&tty->termios_sem);		
 	termios =  *tty->termios;
 	termios.c_cc[VERASE] = tmp.sg_erase;
 	termios.c_cc[VKILL] = tmp.sg_kill;
 	set_sgflags(&termios, tmp.sg_flags);
-	spin_unlock_irqrestore(&tty_termios_lock, flags);
+	up(&tty->termios_sem);
 	change_termios(tty, &termios);
 	return 0;
 }
@@ -543,11 +538,11 @@
 		case TIOCSSOFTCAR:
 			if (get_user(arg, (unsigned int __user *) arg))
 				return -EFAULT;
-			spin_lock_irqsave(&tty_termios_lock, flags);
+			down(&tty->termios_sem);
 			tty->termios->c_cflag =
 				((tty->termios->c_cflag & ~CLOCAL) |
 				 (arg ? CLOCAL : 0));
-			spin_unlock_irqrestore(&tty_termios_lock, flags);
+			up(&tty->termios_sem);
 			return 0;
 		default:
 			return -ENOIOCTLCMD;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/include/linux/tty.h linux-2.6.9rc3/include/linux/tty.h
--- linux.vanilla-2.6.9rc3/include/linux/tty.h	2004-09-30 16:13:13.000000000 +0100
+++ linux-2.6.9rc3/include/linux/tty.h	2004-10-02 20:58:43.768843424 +0100
@@ -244,6 +244,7 @@
 	struct tty_driver *driver;
 	int index;
 	struct tty_ldisc ldisc;
+	struct semaphore termios_sem;
 	struct termios *termios, *termios_locked;
 	char name[64];
 	int pgrp;

