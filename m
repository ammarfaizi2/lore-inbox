Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbTFZA46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbTFZA45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:56:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265335AbTFZAtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:49:55 -0400
Subject: [PATCH 2.5.73] tty_driver.h remove ops from struct tty_driver
From: Joe DiMartino <joe@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1056589434.11614.6.camel@joe2.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 25 Jun 2003 18:03:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw the comment in tty_driver.h saying all the function operations
in struct tty_driver "Will be replaced with struct tty_operations".
Was this what you had in mind?

This patch also includes all the busywork changes to drivers that
needed one more level of indirection as a result of the changes.
I have no way to test most of these due to lack of hardware.

-- Joe DiMartino <joe@osd.org>


===== include/linux/tty_driver.h 1.11 vs edited =====
--- 1.11/include/linux/tty_driver.h	Wed Jun 11 12:32:33 2003
+++ edited/include/linux/tty_driver.h	Mon Jun 23 09:59:18 2003
@@ -181,36 +181,9 @@
 	
 	/*
 	 * Interface routines from the upper tty layer to the tty
-	 * driver.	Will be replaced with struct tty_operations.
+	 * driver.
 	 */
-	int  (*open)(struct tty_struct * tty, struct file * filp);
-	void (*close)(struct tty_struct * tty, struct file * filp);
-	int  (*write)(struct tty_struct * tty, int from_user,
-		      const unsigned char *buf, int count);
-	void (*put_char)(struct tty_struct *tty, unsigned char ch);
-	void (*flush_chars)(struct tty_struct *tty);
-	int  (*write_room)(struct tty_struct *tty);
-	int  (*chars_in_buffer)(struct tty_struct *tty);
-	int  (*ioctl)(struct tty_struct *tty, struct file * file,
-		    unsigned int cmd, unsigned long arg);
-	void (*set_termios)(struct tty_struct *tty, struct termios * old);
-	void (*throttle)(struct tty_struct * tty);
-	void (*unthrottle)(struct tty_struct * tty);
-	void (*stop)(struct tty_struct *tty);
-	void (*start)(struct tty_struct *tty);
-	void (*hangup)(struct tty_struct *tty);
-	void (*break_ctl)(struct tty_struct *tty, int state);
-	void (*flush_buffer)(struct tty_struct *tty);
-	void (*set_ldisc)(struct tty_struct *tty);
-	void (*wait_until_sent)(struct tty_struct *tty, int timeout);
-	void (*send_xchar)(struct tty_struct *tty, char ch);
-	int (*read_proc)(char *page, char **start, off_t off,
-			  int count, int *eof, void *data);
-	int (*write_proc)(struct file *file, const char *buffer,
-			  unsigned long count, void *data);
-	int (*tiocmget)(struct tty_struct *tty, struct file *file);
-	int (*tiocmset)(struct tty_struct *tty, struct file *file,
-			unsigned int set, unsigned int clear);
+	struct tty_operations *tty_ops;
 
 	struct list_head tty_drivers;
 };
===== drivers/char/tty_io.c 1.111 vs edited =====
--- 1.111/drivers/char/tty_io.c	Wed Jun 11 12:33:13 2003
+++ edited/drivers/char/tty_io.c	Mon Jun 23 11:03:53 2003
@@ -294,9 +294,10 @@
 	} else {
 		module_put(o_ldisc.owner);
 	}
-	
-	if (tty->ldisc.num != o_ldisc.num && tty->driver->set_ldisc)
-		tty->driver->set_ldisc(tty);
+
+	if (tty->ldisc.num != o_ldisc.num &&
+	    tty->driver->tty_ops && tty->driver->tty_ops->set_ldisc)
+		tty->driver->tty_ops->set_ldisc(tty);
 	return retval;
 }
 
@@ -447,8 +448,8 @@
 		local_irq_save(flags); // FIXME: is this safe?
 		if (tty->ldisc.flush_buffer)
 			tty->ldisc.flush_buffer(tty);
-		if (tty->driver->flush_buffer)
-			tty->driver->flush_buffer(tty);
+		if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+			tty->driver->tty_ops->flush_buffer(tty);
 		if ((test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
 		    tty->ldisc.write_wakeup)
 			(tty->ldisc.write_wakeup)(tty);
@@ -506,11 +507,11 @@
 	 *	So we just call close() the right number of times.
 	 */
 	if (cons_filp) {
-		if (tty->driver->close)
+		if (tty->driver->tty_ops && tty->driver->tty_ops->close)
 			for (n = 0; n < closecount; n++)
-				tty->driver->close(tty, cons_filp);
-	} else if (tty->driver->hangup)
-		(tty->driver->hangup)(tty);
+				tty->driver->tty_ops->close(tty, cons_filp);
+	} else if (tty->driver->tty_ops && tty->driver->tty_ops->hangup)
+		(tty->driver->tty_ops->hangup)(tty);
 	unlock_kernel();
 }
 
@@ -607,8 +608,8 @@
 		tty->ctrl_status |= TIOCPKT_STOP;
 		wake_up_interruptible(&tty->link->read_wait);
 	}
-	if (tty->driver->stop)
-		(tty->driver->stop)(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->stop)
+		(tty->driver->tty_ops->stop)(tty);
 }
 
 void start_tty(struct tty_struct *tty)
@@ -621,8 +622,8 @@
 		tty->ctrl_status |= TIOCPKT_START;
 		wake_up_interruptible(&tty->link->read_wait);
 	}
-	if (tty->driver->start)
-		(tty->driver->start)(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->start)
+		(tty->driver->tty_ops->start)(tty);
 	if ((test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
 	    tty->ldisc.write_wakeup)
 		(tty->ldisc.write_wakeup)(tty);
@@ -761,7 +762,10 @@
 	tty = (struct tty_struct *)file->private_data;
 	if (tty_paranoia_check(tty, inode->i_rdev, "tty_write"))
 		return -EIO;
-	if (!tty || !tty->driver->write || (test_bit(TTY_IO_ERROR, &tty->flags)))
+	if (!tty ||
+	    !tty->driver->tty_ops ||
+	    !tty->driver->tty_ops->write ||
+	    (test_bit(TTY_IO_ERROR, &tty->flags)))
 		return -EIO;
 	if (!tty->ldisc.write)
 		return -EIO;
@@ -1125,8 +1129,8 @@
 	}
 #endif
 
-	if (tty->driver->close)
-		tty->driver->close(tty, filp);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->close)
+		tty->driver->tty_ops->close(tty, filp);
 
 	/*
 	 * Sanity check: if tty->count is going to zero, there shouldn't be
@@ -1380,8 +1384,8 @@
 #ifdef TTY_DEBUG_HANGUP
 	printk(KERN_DEBUG "opening %s...", tty->name);
 #endif
-	if (tty->driver->open)
-		retval = tty->driver->open(tty, filp);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->open)
+		retval = tty->driver->tty_ops->open(tty, filp);
 	else
 		retval = -ENODEV;
 	filp->f_flags = saved_flags;
@@ -1655,10 +1659,16 @@
 {
 	set_current_state(TASK_INTERRUPTIBLE);
 
-	tty->driver->break_ctl(tty, -1);
+	if (!tty ||
+	    !tty->driver ||
+	    !tty->driver->tty_ops ||
+	    !tty->driver->tty_ops->break_ctl)
+		return -EIO;
+
+	tty->driver->tty_ops->break_ctl(tty, -1);
 	if (!signal_pending(current))
 		schedule_timeout(duration);
-	tty->driver->break_ctl(tty, 0);
+	tty->driver->tty_ops->break_ctl(tty, 0);
 	if (signal_pending(current))
 		return -EINTR;
 	return 0;
@@ -1669,8 +1679,8 @@
 {
 	int retval = -EINVAL;
 
-	if (tty->driver->tiocmget) {
-		retval = tty->driver->tiocmget(tty, file);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->tiocmget) {
+		retval = tty->driver->tty_ops->tiocmget(tty, file);
 
 		if (retval >= 0)
 			retval = put_user(retval, (int *)arg);
@@ -1684,7 +1694,7 @@
 {
 	int retval = -EINVAL;
 
-	if (tty->driver->tiocmset) {
+	if (tty->driver->tty_ops && tty->driver->tty_ops->tiocmset) {
 		unsigned int set, clear, val;
 
 		retval = get_user(val, (unsigned int *)arg);
@@ -1708,7 +1718,7 @@
 		set &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2|TIOCM_LOOP;
 		clear &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2|TIOCM_LOOP;
 
-		retval = tty->driver->tiocmset(tty, file, set, clear);
+		retval = tty->driver->tty_ops->tiocmset(tty, file, set, clear);
 	}
 	return retval;
 }
@@ -1726,6 +1736,9 @@
 	if (tty_paranoia_check(tty, inode->i_rdev, "tty_ioctl"))
 		return -EINVAL;
 
+	if (!tty->driver || !tty->driver->tty_ops)
+		return -EIO;
+
 	real_tty = tty;
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver->subtype == PTY_TYPE_MASTER)
@@ -1734,21 +1747,21 @@
 	/*
 	 * Break handling by driver
 	 */
-	if (!tty->driver->break_ctl) {
+	if (!tty->driver->tty_ops->break_ctl) {
 		switch(cmd) {
 		case TIOCSBRK:
 		case TIOCCBRK:
-			if (tty->driver->ioctl)
-				return tty->driver->ioctl(tty, file, cmd, arg);
+			if (tty->driver->tty_ops->ioctl)
+				return tty->driver->tty_ops->ioctl(tty, file, cmd, arg);
 			return -EINVAL;
 			
 		/* These two ioctl's always return success; even if */
 		/* the driver doesn't support them. */
 		case TCSBRK:
 		case TCSBRKP:
-			if (!tty->driver->ioctl)
+			if (!tty->driver->tty_ops->ioctl)
 				return 0;
-			retval = tty->driver->ioctl(tty, file, cmd, arg);
+			retval = tty->driver->tty_ops->ioctl(tty, file, cmd, arg);
 			if (retval == -ENOIOCTLCMD)
 				retval = 0;
 			return retval;
@@ -1821,11 +1834,11 @@
 		 * Break handling
 		 */
 		case TIOCSBRK:	/* Turn break on, unconditionally */
-			tty->driver->break_ctl(tty, -1);
+			tty->driver->tty_ops->break_ctl(tty, -1);
 			return 0;
 			
 		case TIOCCBRK:	/* Turn break off, unconditionally */
-			tty->driver->break_ctl(tty, 0);
+			tty->driver->tty_ops->break_ctl(tty, 0);
 			return 0;
 		case TCSBRK:   /* SVID version: non-zero arg --> no break */
 			/*
@@ -1847,8 +1860,8 @@
 		case TIOCMBIS:
 			return tty_tiocmset(tty, file, cmd, arg);
 	}
-	if (tty->driver->ioctl) {
-		int retval = (tty->driver->ioctl)(tty, file, cmd, arg);
+	if (tty->driver->tty_ops->ioctl) {
+		int retval = (tty->driver->tty_ops->ioctl)(tty, file, cmd, arg);
 		if (retval != -ENOIOCTLCMD)
 			return retval;
 	}
@@ -1898,8 +1911,8 @@
 	session  = tty->session;
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	read_lock(&tasklist_lock);
 	for_each_task_pid(session, PIDTYPE_SID, p, l, pid) {
 		if (p->tty == tty || session > 0) {
@@ -2079,7 +2092,7 @@
  */
 static void tty_default_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	tty->driver->write(tty, 0, &ch, 1);
+	tty->driver->tty_ops->write(tty, 0, &ch, 1);
 }
 
 struct tty_dev {
@@ -2235,29 +2248,7 @@
 
 void tty_set_operations(struct tty_driver *driver, struct tty_operations *op)
 {
-	driver->open = op->open;
-	driver->close = op->close;
-	driver->write = op->write;
-	driver->put_char = op->put_char;
-	driver->flush_chars = op->flush_chars;
-	driver->write_room = op->write_room;
-	driver->chars_in_buffer = op->chars_in_buffer;
-	driver->ioctl = op->ioctl;
-	driver->set_termios = op->set_termios;
-	driver->throttle = op->throttle;
-	driver->unthrottle = op->unthrottle;
-	driver->stop = op->stop;
-	driver->start = op->start;
-	driver->hangup = op->hangup;
-	driver->break_ctl = op->break_ctl;
-	driver->flush_buffer = op->flush_buffer;
-	driver->set_ldisc = op->set_ldisc;
-	driver->wait_until_sent = op->wait_until_sent;
-	driver->send_xchar = op->send_xchar;
-	driver->read_proc = op->read_proc;
-	driver->write_proc = op->write_proc;
-	driver->tiocmget = op->tiocmget;
-	driver->tiocmset = op->tiocmset;
+	driver->tty_ops = op;
 }
 
 
@@ -2321,11 +2312,11 @@
 		return error;
 	}
 
-	if (!driver->put_char)
-		driver->put_char = tty_default_put_char;
-	
+	if (driver->tty_ops && !driver->tty_ops->put_char)
+		driver->tty_ops->put_char = tty_default_put_char;
+
 	list_add(&driver->tty_drivers, &tty_drivers);
-	
+
 	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
 		for(i = 0; i < driver->num; i++)
 		    tty_register_device(driver, i, NULL);
===== drivers/char/tty_ioctl.c 1.9 vs edited =====
--- 1.9/drivers/char/tty_ioctl.c	Wed Apr 23 19:53:14 2003
+++ edited/drivers/char/tty_ioctl.c	Mon Jun 23 11:18:04 2003
@@ -45,7 +45,7 @@
 	
 	printk(KERN_DEBUG "%s wait until sent...\n", tty_name(tty, buf));
 #endif
-	if (!tty->driver->chars_in_buffer)
+	if (!tty->driver->tty_ops || !tty->driver->tty_ops->chars_in_buffer)
 		return;
 	add_wait_queue(&tty->write_wait, &wait);
 	if (!timeout)
@@ -53,17 +53,17 @@
 	do {
 #ifdef TTY_DEBUG_WAIT_UNTIL_SENT
 		printk(KERN_DEBUG "waiting %s...(%d)\n", tty_name(tty, buf),
-		       tty->driver->chars_in_buffer(tty));
+		       tty->driver->tty_ops->chars_in_buffer(tty));
 #endif
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (signal_pending(current))
 			goto stop_waiting;
-		if (!tty->driver->chars_in_buffer(tty))
+		if (!tty->driver->tty_ops->chars_in_buffer(tty))
 			break;
 		timeout = schedule_timeout(timeout);
 	} while (timeout);
-	if (tty->driver->wait_until_sent)
-		tty->driver->wait_until_sent(tty, timeout);
+	if (tty->driver->tty_ops->wait_until_sent)
+		tty->driver->tty_ops->wait_until_sent(tty, timeout);
 stop_waiting:
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tty->write_wait, &wait);
@@ -131,8 +131,8 @@
 		}
 	}
 
-	if (tty->driver->set_termios)
-		(*tty->driver->set_termios)(tty, &old_termios);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->set_termios)
+		(*tty->driver->tty_ops->set_termios)(tty, &old_termios);
 
 	if (tty->ldisc.set_termios)
 		(*tty->ldisc.set_termios)(tty, &old_termios);
@@ -346,13 +346,13 @@
 {
 	int	was_stopped = tty->stopped;
 
-	if (tty->driver->send_xchar) {
-		tty->driver->send_xchar(tty, ch);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->send_xchar) {
+		tty->driver->tty_ops->send_xchar(tty, ch);
 		return;
 	}
 	if (was_stopped)
 		start_tty(tty);
-	tty->driver->write(tty, 0, &ch, 1);
+	tty->driver->tty_ops->write(tty, 0, &ch, 1);
 	if (was_stopped)
 		stop_tty(tty);
 }
@@ -450,16 +450,16 @@
 					tty->ldisc.flush_buffer(tty);
 				/* fall through */
 			case TCOFLUSH:
-				if (tty->driver->flush_buffer)
-					tty->driver->flush_buffer(tty);
+				if (tty->driver->tty_ops->flush_buffer)
+					tty->driver->tty_ops->flush_buffer(tty);
 				break;
 			default:
 				return -EINVAL;
 			}
 			return 0;
 		case TIOCOUTQ:
-			return put_user(tty->driver->chars_in_buffer ?
-					tty->driver->chars_in_buffer(tty) : 0,
+			return put_user(tty->driver->tty_ops->chars_in_buffer ?
+					tty->driver->tty_ops->chars_in_buffer(tty) : 0,
 					(int *) arg);
 		case TIOCINQ:
 			retval = tty->read_cnt;
===== drivers/bluetooth/hci_ldisc.c 1.10 vs edited =====
--- 1.10/drivers/bluetooth/hci_ldisc.c	Thu May  8 16:38:32 2003
+++ edited/drivers/bluetooth/hci_ldisc.c	Mon Jun 23 10:22:36 2003
@@ -145,7 +145,7 @@
 		int len;
 	
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-		len = tty->driver->write(tty, 0, skb->data, skb->len);
+		len = tty->driver->tty_ops->write(tty, 0, skb->data, skb->len);
 		hdev->stat.byte_tx += len;
 
 		skb_pull(skb, len);
@@ -193,8 +193,8 @@
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 
 	if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
 		hu->proto->flush(hu);
@@ -286,8 +286,8 @@
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 
 	return 0;
 }
@@ -384,8 +384,9 @@
 	hu->hdev.stat.byte_rx += count;
 	spin_unlock(&hu->rx_lock);
 
-	if (test_and_clear_bit(TTY_THROTTLED,&tty->flags) && tty->driver->unthrottle)
-		tty->driver->unthrottle(tty);
+	if (test_and_clear_bit(TTY_THROTTLED,&tty->flags) &&
+	    tty->driver->tty_ops && tty->driver->tty_ops->unthrottle)
+		tty->driver->tty_ops->unthrottle(tty);
 }
 
 static int hci_uart_register_dev(struct hci_uart *hu)
===== drivers/char/cyclades.c 1.27 vs edited =====
--- 1.27/drivers/char/cyclades.c	Wed Jun 11 12:32:39 2003
+++ edited/drivers/char/cyclades.c	Mon Jun 23 11:37:01 2003
@@ -2842,8 +2842,8 @@
 
     CY_UNLOCK(info, flags);
     shutdown(info);
-    if (tty->driver->flush_buffer)
-        tty->driver->flush_buffer(tty);
+    if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+        tty->driver->tty_ops->flush_buffer(tty);
     if (tty->ldisc.flush_buffer)
         tty->ldisc.flush_buffer(tty);
     CY_LOCK(info, flags);
===== drivers/char/epca.c 1.29 vs edited =====
--- 1.29/drivers/char/epca.c	Sat Jun 14 16:16:12 2003
+++ edited/drivers/char/epca.c	Mon Jun 23 11:35:44 2003
@@ -547,8 +547,8 @@
 			tty_wait_until_sent(tty, 3000); /* 30 seconds timeout */
 		}
 	
-		if (tty->driver->flush_buffer)
-			tty->driver->flush_buffer(tty);
+		if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+			tty->driver->tty_ops->flush_buffer(tty);
 
 		if (tty->ldisc.flush_buffer)
 			tty->ldisc.flush_buffer(tty);
@@ -654,8 +654,8 @@
 
 		save_flags(flags);
 		cli();
-		if (tty->driver->flush_buffer)
-			tty->driver->flush_buffer(tty);
+		if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+			tty->driver->tty_ops->flush_buffer(tty);
 
 		if (tty->ldisc.flush_buffer)
 			tty->ldisc.flush_buffer(tty);
===== drivers/char/esp.c 1.24 vs edited =====
--- 1.24/drivers/char/esp.c	Wed Jun 11 12:32:43 2003
+++ edited/drivers/char/esp.c	Mon Jun 23 12:50:53 2003
@@ -2096,8 +2096,8 @@
 		rs_wait_until_sent(tty, info->timeout);
 	}
 	shutdown(info);
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 	tty->closing = 0;
===== drivers/char/generic_serial.c 1.12 vs edited =====
--- 1.12/drivers/char/generic_serial.c	Wed Jun 11 12:32:33 2003
+++ edited/drivers/char/generic_serial.c	Mon Jun 23 12:59:34 2003
@@ -757,8 +757,8 @@
 
 	port->flags &= ~GS_ACTIVE;
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 	tty->closing = 0;
===== drivers/char/ip2main.c 1.38 vs edited =====
--- 1.38/drivers/char/ip2main.c	Wed Jun 11 12:32:49 2003
+++ edited/drivers/char/ip2main.c	Mon Jun 23 11:43:53 2003
@@ -707,6 +707,7 @@
 				} 
 			} 
 #else /* LINUX_VERSION_CODE > 2.1.99 */
+			{
 			struct pci_dev *pci_dev_i = NULL;
 			pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
 						  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
@@ -747,6 +748,7 @@
 			printk( KERN_ERR "IP2: configured in this kernel.\n");
 			printk( KERN_ERR "IP2: Recompile kernel with CONFIG_PCI defined!\n");
 #endif /* CONFIG_PCI */
+			}
 			break;
 		case EISA:
 			if ( (ip2config.addr[i] = find_eisa_board( Eisa_slot + 1 )) != 0) {
@@ -1704,8 +1706,8 @@
 
 	serviceOutgoingFifo ( pCh->pMyBord );
 
-	if ( tty->driver->flush_buffer ) 
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer) 
+		tty->driver->tty_ops->flush_buffer(tty);
 	if ( tty->ldisc.flush_buffer )  
 		tty->ldisc.flush_buffer(tty);
 	tty->closing = 0;
===== drivers/char/isicom.c 1.24 vs edited =====
--- 1.24/drivers/char/isicom.c	Wed Jun 11 12:32:39 2003
+++ edited/drivers/char/isicom.c	Mon Jun 23 12:49:24 2003
@@ -1131,8 +1131,8 @@
 		outw(card->port_status, card->base + 0x02);
 	}	
 	isicom_shutdown_port(port);
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 	tty->closing = 0;
===== drivers/char/mxser.c 1.27 vs edited =====
--- 1.27/drivers/char/mxser.c	Wed Jun 11 12:32:40 2003
+++ edited/drivers/char/mxser.c	Mon Jun 23 11:32:15 2003
@@ -803,8 +803,8 @@
 		}
 	}
 	mxser_shutdown(info);
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 	tty->closing = 0;
===== drivers/char/n_hdlc.c 1.16 vs edited =====
--- 1.16/drivers/char/n_hdlc.c	Fri May 30 19:53:01 2003
+++ edited/drivers/char/n_hdlc.c	Mon Jun 23 12:57:50 2003
@@ -350,8 +350,8 @@
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer (tty);
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer (tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer (tty);
 		
 	if (debuglevel >= DEBUG_LEVEL_INFO)	
 		printk("%s(%d)n_hdlc_tty_open() success\n",__FILE__,__LINE__);
@@ -403,7 +403,7 @@
 			
 		/* Send the next block of data to device */
 		tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);
-		actual = tty->driver->write(tty, 0, tbuf->buf, tbuf->count);
+		actual = tty->driver->tty_ops->write(tty, 0, tbuf->buf, tbuf->count);
 		    
 		/* if transmit error, throw frame away by */
 		/* pretending it was accepted by driver */
@@ -761,8 +761,8 @@
 
 	case TIOCOUTQ:
 		/* get the pending tx byte count in the driver */
-		count = tty->driver->chars_in_buffer ?
-				tty->driver->chars_in_buffer(tty) : 0;
+		count = tty->driver->tty_ops->chars_in_buffer ?
+				tty->driver->tty_ops->chars_in_buffer(tty) : 0;
 		/* add size of next output frame in queue */
 		spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock,flags);
 		if (n_hdlc->tx_buf_list.head)
===== drivers/char/n_r3964.c 1.12 vs edited =====
--- 1.12/drivers/char/n_r3964.c	Mon Apr 21 20:58:40 2003
+++ edited/drivers/char/n_r3964.c	Mon Jun 23 13:40:51 2003
@@ -418,9 +418,9 @@
    if(tty==NULL)
       return;
 
-   if(tty->driver->put_char)
+   if(tty->driver->tty_ops && tty->driver->tty_ops->put_char)
    {
-      tty->driver->put_char(tty, ch);
+      tty->driver->tty_ops->put_char(tty, ch);
    }
    pInfo->bcc ^= ch;
 }
@@ -432,9 +432,9 @@
    if(tty==NULL)
       return;
 
-   if(tty->driver->flush_chars)
+   if(tty->driver->tty_ops && tty->driver->tty_ops->flush_chars)
    {
-      tty->driver->flush_chars(tty);
+      tty->driver->tty_ops->flush_chars(tty);
    }
 }
 
@@ -507,8 +507,8 @@
       return;
    }
 
-   if(tty->driver->write_room)
-      room=tty->driver->write_room(tty);
+   if(tty->driver->tty_ops && tty->driver->tty_ops->write_room)
+      room=tty->driver->tty_ops->write_room(tty);
 
    TRACE_PS("transmit_block %x, room %d, length %d", 
           (int)pBlock, room, pBlock->length);
===== drivers/char/n_tty.c 1.14 vs edited =====
--- 1.14/drivers/char/n_tty.c	Mon Apr 21 20:58:40 2003
+++ edited/drivers/char/n_tty.c	Mon Jun 23 11:10:44 2003
@@ -117,8 +117,8 @@
 {
 	if (tty->count &&
 	    test_and_clear_bit(TTY_THROTTLED, &tty->flags) && 
-	    tty->driver->unthrottle)
-		tty->driver->unthrottle(tty);
+	    tty->driver->tty_ops && tty->driver->tty_ops->unthrottle)
+		tty->driver->tty_ops->unthrottle(tty);
 }
 
 /*
@@ -181,9 +181,10 @@
  */
 static int opost(unsigned char c, struct tty_struct *tty)
 {
-	int	space, spaces;
+	int	space = 0, spaces;
 
-	space = tty->driver->write_room(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->write_room)
+		space = tty->driver->tty_ops->write_room(tty);
 	if (!space)
 		return -1;
 
@@ -195,7 +196,7 @@
 			if (O_ONLCR(tty)) {
 				if (space < 2)
 					return -1;
-				tty->driver->put_char(tty, '\r');
+				tty->driver->tty_ops->put_char(tty, '\r');
 				tty->column = 0;
 			}
 			tty->canon_column = tty->column;
@@ -217,7 +218,7 @@
 				if (space < spaces)
 					return -1;
 				tty->column += spaces;
-				tty->driver->write(tty, 0, "        ", spaces);
+				tty->driver->tty_ops->write(tty, 0, "        ", spaces);
 				return 0;
 			}
 			tty->column += spaces;
@@ -234,7 +235,7 @@
 			break;
 		}
 	}
-	tty->driver->put_char(tty, c);
+	tty->driver->tty_ops->put_char(tty, c);
 	return 0;
 }
 
@@ -246,11 +247,12 @@
 		       const unsigned char * inbuf, unsigned int nr)
 {
 	char	buf[80];
-	int	space;
+	int	space = 0;
 	int 	i;
 	char	*cp;
 
-	space = tty->driver->write_room(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->write_room)
+		space = tty->driver->tty_ops->write_room(tty);
 	if (!space)
 		return 0;
 	if (nr > space)
@@ -296,9 +298,9 @@
 		}
 	}
 break_out:
-	if (tty->driver->flush_chars)
-		tty->driver->flush_chars(tty);
-	i = tty->driver->write(tty, 0, buf, i);	
+	if (tty->driver->tty_ops->flush_chars)
+		tty->driver->tty_ops->flush_chars(tty);
+	i = tty->driver->tty_ops->write(tty, 0, buf, i);	
 	return i;
 }
 
@@ -306,7 +308,7 @@
 
 static inline void put_char(unsigned char c, struct tty_struct *tty)
 {
-	tty->driver->put_char(tty, c);
+	tty->driver->tty_ops->put_char(tty, c);
 }
 
 /* Must be called only when L_ECHO(tty) is true. */
@@ -452,8 +454,8 @@
 		kill_pg(tty->pgrp, sig, 1);
 	if (flush || !L_NOFLSH(tty)) {
 		n_tty_flush_buffer(tty);
-		if (tty->driver->flush_buffer)
-			tty->driver->flush_buffer(tty);
+		if (tty->driver->tty_ops->flush_buffer)
+			tty->driver->tty_ops->flush_buffer(tty);
 	}
 }
 
@@ -782,8 +784,8 @@
 				break;
 			}
 		}
-		if (tty->driver->flush_chars)
-			tty->driver->flush_chars(tty);
+		if (tty->driver->tty_ops->flush_chars)
+			tty->driver->tty_ops->flush_chars(tty);
 	}
 
 	if (!tty->icanon && (tty->read_cnt >= tty->minimum_to_wake)) {
@@ -800,8 +802,8 @@
 	if (n_tty_receive_room(tty) < TTY_THRESHOLD_THROTTLE) {
 		/* check TTY_THROTTLED first so it indicates our state */
 		if (!test_and_set_bit(TTY_THROTTLED, &tty->flags) &&
-		    tty->driver->throttle)
-			tty->driver->throttle(tty);
+		    tty->driver->tty_ops->throttle)
+			tty->driver->tty_ops->throttle(tty);
 	}
 }
 
@@ -1205,10 +1207,10 @@
 					break;
 				b++; nr--;
 			}
-			if (tty->driver->flush_chars)
-				tty->driver->flush_chars(tty);
+			if (tty->driver->tty_ops->flush_chars)
+				tty->driver->tty_ops->flush_chars(tty);
 		} else {
-			c = tty->driver->write(tty, 1, b, nr);
+			c = tty->driver->tty_ops->write(tty, 1, b, nr);
 			if (c < 0) {
 				retval = c;
 				goto break_out;
@@ -1251,7 +1253,7 @@
 		else
 			tty->minimum_to_wake = 1;
 	}
-	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
+	if (tty->driver->tty_ops->chars_in_buffer(tty) < WAKEUP_CHARS)
 		mask |= POLLOUT | POLLWRNORM;
 	return mask;
 }
===== drivers/char/pty.c 1.21 vs edited =====
--- 1.21/drivers/char/pty.c	Wed Jun 11 12:33:13 2003
+++ edited/drivers/char/pty.c	Mon Jun 23 11:21:10 2003
@@ -341,7 +341,7 @@
 	pty_driver->flags = TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_REAL_RAW;
 	pty_driver->other = pty_slave_driver;
 	tty_set_operations(pty_driver, &pty_ops);
-	pty_driver->ioctl = pty_bsd_ioctl;
+	pty_driver->tty_ops->ioctl = pty_bsd_ioctl;
 
 	pty_slave_driver->owner = THIS_MODULE;
 	pty_slave_driver->driver_name = "pty_slave";
@@ -391,7 +391,7 @@
 				TTY_DRIVER_NO_DEVFS;
 	ptm_driver->other = pts_driver;
 	tty_set_operations(ptm_driver, &pty_ops);
-	ptm_driver->ioctl = pty_unix98_ioctl;
+	ptm_driver->tty_ops->ioctl = pty_unix98_ioctl;
 
 	pts_driver->owner = THIS_MODULE;
 	pts_driver->driver_name = "pty_slave";
===== drivers/char/rocket_int.h 1.8 vs edited =====
--- 1.8/drivers/char/rocket_int.h	Fri Jun 13 01:03:58 2003
+++ edited/drivers/char/rocket_int.h	Mon Jun 23 11:30:37 2003
@@ -1296,7 +1296,7 @@
 #define TTY_DRIVER_SUBTYPE(t) t->driver->subtype
 #define TTY_DRIVER_NAME(t) t->driver->name
 #define TTY_DRIVER_NAME_BASE(t) t->driver->name_base
-#define TTY_DRIVER_FLUSH_BUFFER_EXISTS(t) t->driver->flush_buffer
-#define TTY_DRIVER_FLUSH_BUFFER(t) t->driver->flush_buffer(t)
+#define TTY_DRIVER_FLUSH_BUFFER_EXISTS(t) (t->driver->tty_ops && t->driver->tty_ops->flush_buffer)
+#define TTY_DRIVER_FLUSH_BUFFER(t) t->driver->tty_ops->flush_buffer(t)
 
 
===== drivers/char/synclink.c 1.40 vs edited =====
--- 1.40/drivers/char/synclink.c	Wed Jun 11 12:32:41 2003
+++ edited/drivers/char/synclink.c	Mon Jun 23 12:52:37 2003
@@ -3217,8 +3217,8 @@
  	if (info->flags & ASYNC_INITIALIZED)
  		mgsl_wait_until_sent(tty, info->timeout);
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 		
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
@@ -4461,7 +4461,6 @@
 int mgsl_init_tty(void);
 int mgsl_init_tty()
 {
-	struct mgsl_struct *info;
 	serial_driver = alloc_tty_driver(mgsl_device_count);
 	if (!serial_driver)
 		return -ENOMEM;
===== drivers/char/synclinkmp.c 1.18 vs edited =====
--- 1.18/drivers/char/synclinkmp.c	Wed Jun 11 12:32:41 2003
+++ edited/drivers/char/synclinkmp.c	Mon Jun 23 12:54:33 2003
@@ -864,8 +864,8 @@
  	if (info->flags & ASYNC_INITIALIZED)
  		wait_until_sent(tty, info->timeout);
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
@@ -3775,8 +3775,6 @@
 
 static int __init synclinkmp_init(void)
 {
-	SLMP_INFO *info;
-
 	if (break_on_load) {
 	 	synclinkmp_get_text_ptr();
   		BREAKPOINT();
===== drivers/char/pcmcia/synclink_cs.c 1.22 vs edited =====
--- 1.22/drivers/char/pcmcia/synclink_cs.c	Wed Jun 11 12:32:41 2003
+++ edited/drivers/char/pcmcia/synclink_cs.c	Mon Jun 23 11:24:49 2003
@@ -2585,8 +2585,8 @@
  	if (info->flags & ASYNC_INITIALIZED)
  		mgslpc_wait_until_sent(tty, info->timeout);
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 		
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
===== drivers/input/serio/serport.c 1.12 vs edited =====
--- 1.12/drivers/input/serio/serport.c	Sun May  4 09:36:03 2003
+++ edited/drivers/input/serio/serport.c	Mon Jun 23 14:36:37 2003
@@ -44,7 +44,7 @@
 static int serport_serio_write(struct serio *serio, unsigned char data)
 {
 	struct serport *serport = serio->driver;
-	return -(serport->tty->driver->write(serport->tty, 0, &data, 1) != 1);
+	return -(serport->tty->driver->tty_ops->write(serport->tty, 0, &data, 1) != 1);
 }
 
 static int serport_serio_open(struct serio *serio)
===== drivers/isdn/i4l/isdn_tty.c 1.52 vs edited =====
--- 1.52/drivers/isdn/i4l/isdn_tty.c	Wed Jun 18 21:25:09 2003
+++ edited/drivers/isdn/i4l/isdn_tty.c	Mon Jun 23 15:11:03 2003
@@ -1840,8 +1840,8 @@
 	}
 	dev->modempoll--;
 	isdn_tty_shutdown(info);
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 	info->tty = 0;
===== drivers/net/ppp_async.c 1.12 vs edited =====
--- 1.12/drivers/net/ppp_async.c	Thu Jun 19 18:48:08 2003
+++ edited/drivers/net/ppp_async.c	Wed Jun 25 10:46:06 2003
@@ -329,8 +329,8 @@
 	spin_unlock_bh(&ap->recv_lock);
 	ap_put(ap);
 	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags)
-	    && tty->driver->unthrottle)
-		tty->driver->unthrottle(tty);
+	    && tty->driver->tty_ops && tty->driver->tty_ops->unthrottle)
+		tty->driver->tty_ops->unthrottle(tty);
 }
 
 static void
@@ -660,7 +660,7 @@
 		if (!tty_stuffed && ap->optr < ap->olim) {
 			avail = ap->olim - ap->optr;
 			set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-			sent = tty->driver->write(tty, 0, ap->optr, avail);
+			sent = tty->driver->tty_ops->write(tty, 0, ap->optr, avail);
 			if (sent < 0)
 				goto flush;	/* error, e.g. loss of CD */
 			ap->optr += sent;
===== drivers/net/ppp_synctty.c 1.9 vs edited =====
--- 1.9/drivers/net/ppp_synctty.c	Sun Apr 27 00:58:13 2003
+++ edited/drivers/net/ppp_synctty.c	Wed Jun 25 10:47:38 2003
@@ -382,8 +382,8 @@
 	spin_unlock_bh(&ap->recv_lock);
 	sp_put(ap);
 	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags)
-	    && tty->driver->unthrottle)
-		tty->driver->unthrottle(tty);
+	    && tty->driver->tty_ops && tty->driver->tty_ops->unthrottle)
+		tty->driver->tty_ops->unthrottle(tty);
 }
 
 static void
@@ -608,7 +608,7 @@
 			tty_stuffed = 0;
 		if (!tty_stuffed && ap->tpkt != 0) {
 			set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-			sent = tty->driver->write(tty, 0, ap->tpkt->data, ap->tpkt->len);
+			sent = tty->driver->tty_ops->write(tty, 0, ap->tpkt->data, ap->tpkt->len);
 			if (sent < 0)
 				goto flush;	/* error, e.g. loss of CD */
 			if (sent < ap->tpkt->len) {
===== drivers/net/slip.c 1.18 vs edited =====
--- 1.18/drivers/net/slip.c	Sun Jun 15 00:44:29 2003
+++ edited/drivers/net/slip.c	Wed Jun 25 10:52:04 2003
@@ -417,7 +417,7 @@
 	 *       14 Oct 1994  Dmitry Gorodchanin.
 	 */
 	sl->tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);
-	actual = sl->tty->driver->write(sl->tty, 0, sl->xbuff, count);
+	actual = sl->tty->driver->tty_ops->write(sl->tty, 0, sl->xbuff, count);
 #ifdef SL_CHECK_TRANSMIT
 	sl->dev->trans_start = jiffies;
 #endif
@@ -451,7 +451,7 @@
 		return;
 	}
 
-	actual = tty->driver->write(tty, 0, sl->xhead, sl->xleft);
+	actual = tty->driver->tty_ops->write(tty, 0, sl->xhead, sl->xleft);
 	sl->xleft -= actual;
 	sl->xhead += actual;
 }
@@ -477,7 +477,7 @@
 			goto out;
 		}
 		printk(KERN_WARNING "%s: transmit timed out, %s?\n", dev->name,
-		       (sl->tty->driver->chars_in_buffer(sl->tty) || sl->xleft) ?
+		       (sl->tty->driver->tty_ops->chars_in_buffer(sl->tty) || sl->xleft) ?
 		       "bad line quality" : "driver error");
 		sl->xleft = 0;
 		sl->tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);
@@ -876,8 +876,8 @@
 	tty->disc_data = sl;
 	sl->line = tty->device;
 	sl->pid = current->pid;
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 
@@ -1467,7 +1467,7 @@
 			if (!netif_queue_stopped(sl->dev))
 			{
 				/* if device busy no outfill */
-				sl->tty->driver->write(sl->tty, 0, &s, 1);
+				sl->tty->driver->tty_ops->write(sl->tty, 0, &s, 1);
 			}
 		}
 		else
===== drivers/net/hamradio/6pack.c 1.13 vs edited =====
--- 1.13/drivers/net/hamradio/6pack.c	Mon May 19 23:22:51 2003
+++ edited/drivers/net/hamradio/6pack.c	Mon Jun 23 16:38:53 2003
@@ -315,13 +315,13 @@
 		   immediately after data has arrived. */
 		if (sp->duplex == 1) {
 			sp->led_state = 0x70;
-			sp->tty->driver->write(sp->tty, 0, &sp->led_state, 1);
+			sp->tty->driver->tty_ops->write(sp->tty, 0, &sp->led_state, 1);
 			sp->tx_enable = 1;
-			actual = sp->tty->driver->write(sp->tty, 0, sp->xbuff, count);
+			actual = sp->tty->driver->tty_ops->write(sp->tty, 0, sp->xbuff, count);
 			sp->xleft = count - actual;
 			sp->xhead = sp->xbuff + actual;
 			sp->led_state = 0x60;
-			sp->tty->driver->write(sp->tty, 0, &sp->led_state, 1);
+			sp->tty->driver->tty_ops->write(sp->tty, 0, &sp->led_state, 1);
 		} else {
 			sp->xleft = count;
 			sp->xhead = sp->xbuff;
@@ -357,7 +357,7 @@
 	}
 
 	if (sp->tx_enable == 1) {
-		actual = tty->driver->write(tty, 0, sp->xhead, sp->xleft);
+		actual = tty->driver->tty_ops->write(tty, 0, sp->xhead, sp->xleft);
 		sp->xleft -= actual;
 		sp->xhead += actual;
 	}
@@ -394,13 +394,13 @@
 
 	if (((sp->status1 & SIXP_DCD_MASK) == 0) && (random < sp->persistence)) {
 		sp->led_state = 0x70;
-		sp->tty->driver->write(sp->tty, 0, &sp->led_state, 1);
+		sp->tty->driver->tty_ops->write(sp->tty, 0, &sp->led_state, 1);
 		sp->tx_enable = 1;
-		actual = sp->tty->driver->write(sp->tty, 0, sp->xbuff, sp->status2);
+		actual = sp->tty->driver->tty_ops->write(sp->tty, 0, sp->xbuff, sp->status2);
 		sp->xleft -= actual;
 		sp->xhead += actual;
 		sp->led_state = 0x60;
-		sp->tty->driver->write(sp->tty, 0, &sp->led_state, 1);
+		sp->tty->driver->tty_ops->write(sp->tty, 0, &sp->led_state, 1);
 		sp->status2 = 0;
 	} else
 		sp_start_tx_timer(sp);
@@ -566,8 +566,8 @@
 		return -ENFILE;
 	sp->tty = tty;
 	tty->disc_data = sp;
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
@@ -882,7 +882,7 @@
 {
 	unsigned char inbyte = 0xe8;
 
-	sp->tty->driver->write(sp->tty, 0, &inbyte, 1);
+	sp->tty->driver->tty_ops->write(sp->tty, 0, &inbyte, 1);
 
 	del_timer(&sp->resync_t);
 	sp->resync_t.data = (unsigned long) sp;
@@ -924,9 +924,9 @@
 	else { /* output watchdog char if idle */
 		if ((sp->status2 != 0) && (sp->duplex == 1)) {
 			sp->led_state = 0x70;
-			sp->tty->driver->write(sp->tty, 0, &sp->led_state, 1);
+			sp->tty->driver->tty_ops->write(sp->tty, 0, &sp->led_state, 1);
 			sp->tx_enable = 1;
-			actual = sp->tty->driver->write(sp->tty, 0, sp->xbuff, sp->status2);
+			actual = sp->tty->driver->tty_ops->write(sp->tty, 0, sp->xbuff, sp->status2);
 			sp->xleft -= actual;
 			sp->xhead += actual;
 			sp->led_state = 0x60;
@@ -936,7 +936,7 @@
 	}
 
 	/* needed to trigger the TNC watchdog */
-	sp->tty->driver->write(sp->tty, 0, &sp->led_state, 1);
+	sp->tty->driver->tty_ops->write(sp->tty, 0, &sp->led_state, 1);
 
         /* if the state byte has been received, the TNC is present,
            so the resync timer can be reset. */
@@ -977,8 +977,8 @@
 	/* resync the TNC */
 
 	sp->led_state = 0x60;
-	sp->tty->driver->write(sp->tty, 0, &sp->led_state, 1);
-	sp->tty->driver->write(sp->tty, 0, &resync_cmd, 1);
+	sp->tty->driver->tty_ops->write(sp->tty, 0, &sp->led_state, 1);
+	sp->tty->driver->tty_ops->write(sp->tty, 0, &resync_cmd, 1);
 
 
 	/* Start resync timer again -- the TNC might be still absent */
@@ -1006,12 +1006,12 @@
 				if ((sp->status & SIXP_RX_DCD_MASK) ==
 					SIXP_RX_DCD_MASK) {
 					sp->led_state = 0x68;
-					sp->tty->driver->write(sp->tty, 0, &sp->led_state, 1);
+					sp->tty->driver->tty_ops->write(sp->tty, 0, &sp->led_state, 1);
 				}
 			} else {
 				sp->led_state = 0x60;
 				/* fill trailing bytes with zeroes */
-				sp->tty->driver->write(sp->tty, 0, &sp->led_state, 1);
+				sp->tty->driver->tty_ops->write(sp->tty, 0, &sp->led_state, 1);
 				rest = sp->rx_count;
 				if (rest != 0)
 					 for (i = rest; i <= 3; i++)
===== drivers/net/hamradio/mkiss.c 1.11 vs edited =====
--- 1.11/drivers/net/hamradio/mkiss.c	Wed Jun  4 04:17:01 2003
+++ edited/drivers/net/hamradio/mkiss.c	Mon Jun 23 16:29:18 2003
@@ -391,7 +391,7 @@
 			 break;
 		}
 		ax->tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);
-		actual = ax->tty->driver->write(ax->tty, 0, ax->xbuff, count);
+		actual = ax->tty->driver->tty_ops->write(ax->tty, 0, ax->xbuff, count);
 		ax->tx_packets++;
 		ax->tx_bytes+=actual;
 		ax->dev->trans_start = jiffies;
@@ -400,7 +400,7 @@
 	} else {
 		count = kiss_esc(p, (unsigned char *) ax->mkiss->xbuff, len);
 		ax->mkiss->tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);
-		actual = ax->mkiss->tty->driver->write(ax->mkiss->tty, 0, ax->mkiss->xbuff, count);
+		actual = ax->mkiss->tty->driver->tty_ops->write(ax->mkiss->tty, 0, ax->mkiss->xbuff, count);
 		ax->tx_packets++;
 		ax->tx_bytes+=actual;
 		ax->mkiss->dev->trans_start = jiffies;
@@ -438,7 +438,7 @@
 		return;
 	}
 
-	actual = tty->driver->write(tty, 0, ax->xhead, ax->xleft);
+	actual = tty->driver->tty_ops->write(tty, 0, ax->xhead, ax->xleft);
 	ax->xleft -= actual;
 	ax->xhead += actual;
 }
@@ -484,7 +484,7 @@
 		}
 
 		printk(KERN_ERR "mkiss: %s: transmit timed out, %s?\n", dev->name,
-		       (ax->tty->driver->chars_in_buffer(ax->tty) || ax->xleft) ?
+		       (ax->tty->driver->tty_ops->chars_in_buffer(ax->tty) || ax->xleft) ?
 		       "bad line quality" : "driver error");
 
 		ax->xleft = 0;
@@ -652,8 +652,8 @@
 	ax->mkiss = NULL;
 	tmp_ax    = NULL;
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 
===== drivers/net/irda/irtty-sir.c 1.7 vs edited =====
--- 1.7/drivers/net/irda/irtty-sir.c	Mon May 12 10:53:09 2003
+++ edited/drivers/net/irda/irtty-sir.c	Mon Jun 23 17:36:24 2003
@@ -62,7 +62,7 @@
 	ASSERT(priv != NULL, return -1;);
 	ASSERT(priv->magic == IRTTY_MAGIC, return -1;);
 
-	return priv->tty->driver->chars_in_buffer(priv->tty);
+	return priv->tty->driver->tty_ops->chars_in_buffer(priv->tty);
 }
 
 /* Wait (sleep) until underlaying hardware finished transmission
@@ -91,9 +91,9 @@
 	ASSERT(priv->magic == IRTTY_MAGIC, return;);
 
 	tty = priv->tty;
-	if (tty->driver->wait_until_sent) {
+	if (tty->driver->tty_ops && tty->driver->tty_ops->wait_until_sent) {
 		lock_kernel();
-		tty->driver->wait_until_sent(tty, MSECS_TO_JIFFIES(100));
+		tty->driver->tty_ops->wait_until_sent(tty, MSECS_TO_JIFFIES(100));
 		unlock_kernel();
 	}
 	else {
@@ -161,8 +161,8 @@
 	}	
 
 	tty->termios->c_cflag = cflag;
-	if (tty->driver->set_termios)
-		tty->driver->set_termios(tty, &old_termios);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->set_termios)
+		tty->driver->tty_ops->set_termios(tty, &old_termios);
 	unlock_kernel();
 
 	priv->io.speed = speed;
@@ -201,8 +201,9 @@
 	 * This function is not yet defined for all tty driver, so
 	 * let's be careful... Jean II
 	 */
-	ASSERT(priv->tty->driver->tiocmset != NULL, return -1;);
-	priv->tty->driver->tiocmset(priv->tty, NULL, set, clear);
+	ASSERT(priv->tty->driver->tty_ops &&
+		priv->tty->driver->tty_ops->tiocmset, return -1;);
+	priv->tty->driver->tty_ops->tiocmset(priv->tty, NULL, set, clear);
 
 	return 0;
 }
@@ -231,17 +232,17 @@
 	ASSERT(priv->magic == IRTTY_MAGIC, return -1;);
 
 	tty = priv->tty;
-	if (!tty->driver->write)
+	if (!tty->driver->tty_ops || !tty->driver->tty_ops->write)
 		return 0;
 	tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);
-	if (tty->driver->write_room) {
-		writelen = tty->driver->write_room(tty);
+	if (tty->driver->tty_ops->write_room) {
+		writelen = tty->driver->tty_ops->write_room(tty);
 		if (writelen > len)
 			writelen = len;
 	}
 	else
 		writelen = len;
-	return tty->driver->write(tty, 0, ptr, writelen);
+	return tty->driver->tty_ops->write(tty, 0, ptr, writelen);
 }
 
 /* ------------------------------------------------------- */
@@ -354,8 +355,8 @@
 		cflag |= CREAD;
 
 	tty->termios->c_cflag = cflag;
-	if (tty->driver->set_termios)
-		tty->driver->set_termios(tty, &old_termios);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->set_termios)
+		tty->driver->tty_ops->set_termios(tty, &old_termios);
 	unlock_kernel();
 }
 
@@ -381,8 +382,8 @@
 
 	tty = priv->tty;
 
-	if (tty->driver->start)
-		tty->driver->start(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->start)
+		tty->driver->tty_ops->start(tty);
 	/* Make sure we can receive more data */
 	irtty_stop_receiver(tty, FALSE);
 
@@ -410,8 +411,8 @@
 
 	/* Make sure we don't receive more data */
 	irtty_stop_receiver(tty, TRUE);
-	if (tty->driver->stop)
-		tty->driver->stop(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->stop)
+		tty->driver->tty_ops->stop(tty);
 
 	up(&irtty_sem);
 
@@ -518,11 +519,11 @@
 
 	/* stop the underlying  driver */
 	irtty_stop_receiver(tty, TRUE);
-	if (tty->driver->stop)
-		tty->driver->stop(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->stop)
+		tty->driver->tty_ops->stop(tty);
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	
 /* from old irtty - but what is it good for?
  * we _are_ the ldisc and we _don't_ implement flush_buffer!
@@ -606,8 +607,8 @@
 	/* Stop tty */
 	irtty_stop_receiver(tty, TRUE);
 	tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);
-	if (tty->driver->stop)
-		tty->driver->stop(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->stop)
+		tty->driver->tty_ops->stop(tty);
 
 	kfree(priv);
 }
===== drivers/net/irda/irtty.c 1.20 vs edited =====
--- 1.20/drivers/net/irda/irtty.c	Thu May 29 23:50:31 2003
+++ edited/drivers/net/irda/irtty.c	Mon Jun 23 16:47:26 2003
@@ -174,8 +174,8 @@
 
 	hashbin_insert(irtty, (irda_queue_t *) self, (int) self, NULL);
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
@@ -330,7 +330,7 @@
 
 	/* This is unsafe, but currently under discussion - Jean II */
 	self->tty->termios->c_cflag = cflag;
-	self->tty->driver->set_termios(self->tty, &old_termios);
+	self->tty->driver->tty_ops->set_termios(self->tty, &old_termios);
 }
 
 /* 
@@ -383,7 +383,7 @@
 
 	/* This is unsafe, but currently under discussion - Jean II */
 	self->tty->termios->c_cflag = cflag;
-	self->tty->driver->set_termios(self->tty, &old_termios);
+	self->tty->driver->tty_ops->set_termios(self->tty, &old_termios);
 
 	self->io.speed = speed;
 }
@@ -424,7 +424,7 @@
 		 * Make sure all data is sent before changing the speed of the
 		 * serial port.
 		 */
-		if (self->tty->driver->chars_in_buffer(self->tty)) {
+		if (self->tty->driver->tty_ops->chars_in_buffer(self->tty)) {
 			/* Keep state, and try again later */
 			ret = MSECS_TO_JIFFIES(10);
 			break;
@@ -679,8 +679,8 @@
 	dev->trans_start = jiffies;
 	self->stats.tx_bytes += self->tx_buff.len;
 
-	if (self->tty->driver->write)
-		actual = self->tty->driver->write(self->tty, 0, 
+	if (self->tty->driver->tty_ops->write)
+		actual = self->tty->driver->tty_ops->write(self->tty, 0, 
 						 self->tx_buff.data, 
 						 self->tx_buff.len);
 	/* Hide the part we just transmitted */
@@ -733,7 +733,7 @@
 	/* Finished with frame?  */
 	if (self->tx_buff.len > 0)  {
 		/* Write data left in transmit buffer */
-		actual = tty->driver->write(tty, 0, self->tx_buff.data, 
+		actual = tty->driver->tty_ops->write(tty, 0, self->tx_buff.data, 
 					   self->tx_buff.len);
 
 		self->tx_buff.data += actual;
@@ -818,7 +818,7 @@
 	set_fs(get_ds());
 	
 	/* This is probably unsafe, but currently under discussion - Jean II */
-	if (tty->driver->ioctl(tty, NULL, TIOCMSET, (unsigned long) &arg)) { 
+	if (tty->driver->tty_ops->ioctl(tty, NULL, TIOCMSET, (unsigned long) &arg)) { 
 		IRDA_DEBUG(2, "%s(), error doing ioctl!\n", __FUNCTION__);
 	}
 	set_fs(fs);
@@ -918,8 +918,8 @@
 	ASSERT(self != NULL, return 0;);
 	ASSERT(self->magic == IRTTY_MAGIC, return 0;);
 
-	if (self->tty->driver->write)
-		actual = self->tty->driver->write(self->tty, 0, buf, len);
+	if (self->tty->driver->tty_ops->write)
+		actual = self->tty->driver->tty_ops->write(self->tty, 0, buf, len);
 
 	return actual;
 }
===== drivers/net/wan/pc300_tty.c 1.13 vs edited =====
--- 1.13/drivers/net/wan/pc300_tty.c	Wed Jun 11 12:32:33 2003
+++ edited/drivers/net/wan/pc300_tty.c	Tue Jun 24 11:46:11 2003
@@ -110,7 +110,7 @@
 	} st_cpc_tty_area;
 
 /* TTY data structures */
-static struct tty_driver serial_drv;
+static struct tty_driver *serial_drv;
 
 /* local variables */
 st_cpc_tty_area	cpc_tty_area[CPC_TTY_NPORTS];
@@ -179,6 +179,17 @@
 	CPC_TTY_UNLOCK(card,flags); 
 }
 
+static struct tty_operations cpc_ops = {
+	.open = cpc_tty_open,
+	.close = cpc_tty_close,
+	.write = cpc_tty_write,
+	.write_room = cpc_tty_write_room,
+	.chars_in_buffer = cpc_tty_chars_in_buffer,
+	.ioctl = cpc_tty_ioctl,
+	.flush_buffer = cpc_tty_flush_buffer,
+	.hangup = cpc_tty_hangup,
+};
+
 /*
  * PC300 TTY initialization routine
  *
@@ -209,33 +220,29 @@
 			CPC_TTY_MAJOR, CPC_TTY_MINOR_START,
 			CPC_TTY_MINOR_START+CPC_TTY_NPORTS);
 		/* initialize tty driver struct */
-		memset(&serial_drv,0,sizeof(struct tty_driver));
-		serial_drv.magic = TTY_DRIVER_MAGIC;
-		serial_drv.owner = THIS_MODULE;
-		serial_drv.driver_name = "pc300_tty";
-		serial_drv.name = "ttyCP";
-		serial_drv.major = CPC_TTY_MAJOR;
-		serial_drv.minor_start = CPC_TTY_MINOR_START;
-		serial_drv.num = CPC_TTY_NPORTS;
-		serial_drv.type = TTY_DRIVER_TYPE_SERIAL;
-		serial_drv.subtype = SERIAL_TYPE_NORMAL;
-
-		serial_drv.init_termios = tty_std_termios;
-		serial_drv.init_termios.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
-		serial_drv.flags = TTY_DRIVER_REAL_RAW;
-
-		/* interface routines from the upper tty layer to the tty driver */
-		serial_drv.open = cpc_tty_open;
-		serial_drv.close = cpc_tty_close;
-		serial_drv.write = cpc_tty_write; 
-		serial_drv.write_room = cpc_tty_write_room; 
-		serial_drv.chars_in_buffer = cpc_tty_chars_in_buffer; 
-		serial_drv.ioctl = cpc_tty_ioctl; 
-		serial_drv.flush_buffer = cpc_tty_flush_buffer; 
-		serial_drv.hangup = cpc_tty_hangup;
+		serial_drv = alloc_tty_driver(CPC_TTY_NPORTS + 1);
+		if (!serial_drv) {
+			printk("%s-tty: Failed memory alloc serial driver! ",
+				((struct net_device*)(pc300dev->hdlc))->name);
+			return;
+		}
+
+		serial_drv->owner = THIS_MODULE;
+		serial_drv->driver_name = "pc300_tty";
+		serial_drv->name = "ttyCP";
+		serial_drv->major = CPC_TTY_MAJOR;
+		serial_drv->minor_start = CPC_TTY_MINOR_START;
+		serial_drv->type = TTY_DRIVER_TYPE_SERIAL;
+		serial_drv->subtype = SERIAL_TYPE_NORMAL;
+
+		serial_drv->init_termios = tty_std_termios;
+		serial_drv->init_termios.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
+		serial_drv->flags = TTY_DRIVER_REAL_RAW;
+
+		tty_set_operations(serial_drv, &cpc_ops);
 
 		/* register the TTY driver */
-		if (tty_register_driver(&serial_drv)) { 
+		if (tty_register_driver(serial_drv)) { 
 			printk("%s-tty: Failed to register serial driver! ",
 				((struct net_device*)(pc300dev->hdlc))->name);
 		   	return;
@@ -405,10 +412,10 @@
 
 	CPC_TTY_DBG("%s: TTY closed\n",cpc_tty->name);
 	
-	if (!serial_drv.refcount && cpc_tty_unreg_flag) {
+	if (!serial_drv->refcount && cpc_tty_unreg_flag) {
 		cpc_tty_unreg_flag = 0;
 		CPC_TTY_DBG("%s: unregister the tty driver\n", cpc_tty->name);
-		if ((res=tty_unregister_driver(&serial_drv))) { 
+		if ((res=tty_unregister_driver(serial_drv))) { 
 			CPC_TTY_DBG("%s: ERROR ->unregister the tty driver error=%d\n",
 							cpc_tty->name,res);
 		}
@@ -653,10 +660,10 @@
 		CPC_TTY_DBG("%s: TTY is not opened\n",cpc_tty->name);
 		return ;
 	}
-	if (!serial_drv.refcount && cpc_tty_unreg_flag) {
+	if (!serial_drv->refcount && cpc_tty_unreg_flag) {
 		cpc_tty_unreg_flag = 0;
 		CPC_TTY_DBG("%s: unregister the tty driver\n", cpc_tty->name);
-		if ((res=tty_unregister_driver(&serial_drv))) { 
+		if ((res=tty_unregister_driver(serial_drv))) { 
 			CPC_TTY_DBG("%s: ERROR ->unregister the tty driver error=%d\n",
 							cpc_tty->name,res);
 		}
@@ -1048,15 +1055,15 @@
 	}
 
 	if (--cpc_tty_cnt == 0) { 
-		if (serial_drv.refcount) {
+		if (serial_drv->refcount) {
 			CPC_TTY_DBG("%s: unregister is not possible, refcount=%d",
-							cpc_tty->name, serial_drv.refcount);
+					cpc_tty->name, serial_drv->refcount);
 			cpc_tty_cnt++;
 			cpc_tty_unreg_flag = 1;
 			return;
 		} else { 
 			CPC_TTY_DBG("%s: unregister the tty driver\n", cpc_tty->name);
-			if ((res=tty_unregister_driver(&serial_drv))) { 
+			if ((res=tty_unregister_driver(serial_drv))) { 
 				CPC_TTY_DBG("%s: ERROR ->unregister the tty driver error=%d\n",
 								cpc_tty->name,res);
 			}
@@ -1092,8 +1099,11 @@
 	int i ; 
 
 	CPC_TTY_DBG("hdlcX-tty: reset variables\n");
-	/* reset  the tty_driver structure - serial_drv */ 
-	memset(&serial_drv, 0, sizeof(struct tty_driver));
+	/* reset the tty_driver structure - serial_drv */
+	if (serial_drv)
+		put_tty_driver(serial_drv);
+	serial_drv = alloc_tty_driver(CPC_TTY_NPORTS + 1);
+
 	for (i=0; i < CPC_TTY_NPORTS; i++){
 		memset(&cpc_tty_area[i],0, sizeof(st_cpc_tty_area)); 
 	}
===== drivers/net/wan/x25_asy.c 1.6 vs edited =====
--- 1.6/drivers/net/wan/x25_asy.c	Fri May  9 09:35:53 2003
+++ edited/drivers/net/wan/x25_asy.c	Tue Jun 24 09:18:29 2003
@@ -286,7 +286,7 @@
 	 *       14 Oct 1994  Dmitry Gorodchanin.
 	 */
 	sl->tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);
-	actual = sl->tty->driver->write(sl->tty, 0, sl->xbuff, count);
+	actual = sl->tty->driver->tty_ops->write(sl->tty, 0, sl->xbuff, count);
 	sl->xleft = count - actual;
 	sl->xhead = sl->xbuff + actual;
 	/* VSV */
@@ -316,7 +316,7 @@
 		return;
 	}
 
-	actual = tty->driver->write(tty, 0, sl->xhead, sl->xleft);
+	actual = tty->driver->tty_ops->write(tty, 0, sl->xhead, sl->xleft);
 	sl->xleft -= actual;
 	sl->xhead += actual;
 }
@@ -328,7 +328,7 @@
 	 *      14 Oct 1994 Dmitry Gorodchanin.
 	 */
 	printk(KERN_WARNING "%s: transmit timed out, %s?\n", dev->name,
-	       (sl->tty->driver->chars_in_buffer(sl->tty) || sl->xleft) ?
+	       (sl->tty->driver->tty_ops->chars_in_buffer(sl->tty) || sl->xleft) ?
 	       "bad line quality" : "driver error");
 	sl->xleft = 0;
 	sl->tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);
@@ -618,8 +618,8 @@
 
 	sl->tty = tty;
 	tty->disc_data = sl;
-	if (tty->driver->flush_buffer)  {
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)  {
+		tty->driver->tty_ops->flush_buffer(tty);
 	}
 	if (tty->ldisc.flush_buffer)  {
 		tty->ldisc.flush_buffer(tty);
===== drivers/net/wireless/strip.c 1.12 vs edited =====
--- 1.12/drivers/net/wireless/strip.c	Thu Apr 24 05:25:35 2003
+++ edited/drivers/net/wireless/strip.c	Wed Jun 25 10:22:40 2003
@@ -801,7 +801,7 @@
 	struct termios old_termios = *(tty->termios);
 	tty->termios->c_cflag &= ~CBAUD;	/* Clear the old baud setting */
 	tty->termios->c_cflag |= baudcode;	/* Set the new baud setting */
-	tty->driver->set_termios(tty, &old_termios);
+	tty->driver->tty_ops->set_termios(tty, &old_termios);
 }
 
 /*
@@ -1268,7 +1268,7 @@
 			set_baud(tty, strip_info->user_baud);
 	}
 
-	tty->driver->write(tty, 0, s.string, s.length);
+	tty->driver->tty_ops->write(tty, 0, s.string, s.length);
 #ifdef EXT_COUNTERS
 	strip_info->tx_ebytes += s.length;
 #endif
@@ -1290,7 +1290,7 @@
 
 	if (strip_info->tx_left > 0) {
 		int num_written =
-		    tty->driver->write(tty, 0, strip_info->tx_head,
+		    tty->driver->tty_ops->write(tty, 0, strip_info->tx_head,
 				      strip_info->tx_left);
 		strip_info->tx_left -= num_written;
 		strip_info->tx_head += num_written;
@@ -2690,8 +2690,8 @@
 
 	strip_info->tty = tty;
 	tty->disc_data = strip_info;
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 
===== drivers/usb/serial/digi_acceleport.c 1.34 vs edited =====
--- 1.34/drivers/usb/serial/digi_acceleport.c	Thu May 29 13:48:17 2003
+++ edited/drivers/usb/serial/digi_acceleport.c	Wed Jun 25 12:06:54 2003
@@ -1580,8 +1580,8 @@
 	}
 
 	/* flush driver and line discipline buffers */
-	if( tty->driver->flush_buffer )
-		tty->driver->flush_buffer( tty );
+	if( tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer )
+		tty->driver->tty_ops->flush_buffer( tty );
 	if( tty->ldisc.flush_buffer )
 		tty->ldisc.flush_buffer( tty );
 
===== drivers/usb/serial/whiteheat.c 1.38 vs edited =====
--- 1.38/drivers/usb/serial/whiteheat.c	Thu May 29 14:57:06 2003
+++ edited/drivers/usb/serial/whiteheat.c	Wed Jun 25 12:05:16 2003
@@ -651,8 +651,8 @@
 	}
 */
 
-	if (port->tty->driver->flush_buffer)
-		port->tty->driver->flush_buffer(port->tty);
+	if (port->tty->driver->tty_ops && port->tty->driver->tty_ops->flush_buffer)
+		port->tty->driver->tty_ops->flush_buffer(port->tty);
 	if (port->tty->ldisc.flush_buffer)
 		port->tty->ldisc.flush_buffer(port->tty);
 
===== kernel/printk.c 1.25 vs edited =====
--- 1.25/kernel/printk.c	Mon Apr 21 20:58:40 2003
+++ edited/kernel/printk.c	Fri Jun 20 17:29:25 2003
@@ -674,7 +674,7 @@
  */
 void tty_write_message(struct tty_struct *tty, char *msg)
 {
-	if (tty && tty->driver->write)
-		tty->driver->write(tty, 0, msg, strlen(msg));
+	if (tty && tty->driver && tty->driver->tty_ops && tty->driver->tty_ops->write)
+		tty->driver->tty_ops->write(tty, 0, msg, strlen(msg));
 	return;
 }
===== net/irda/ircomm/ircomm_tty.c 1.25 vs edited =====
--- 1.25/net/irda/ircomm/ircomm_tty.c	Wed Jun 11 12:32:33 2003
+++ edited/net/irda/ircomm/ircomm_tty.c	Wed Jun 25 14:54:04 2003
@@ -553,8 +553,8 @@
 
 	ircomm_tty_shutdown(self);
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 
===== fs/proc/proc_tty.c 1.7 vs edited =====
--- 1.7/fs/proc/proc_tty.c	Mon May 26 15:29:30 2003
+++ edited/fs/proc/proc_tty.c	Mon Jun 23 10:07:52 2003
@@ -181,14 +181,16 @@
 }
 
 /*
- * Thsi function is called by register_tty_driver() to handle
+ * This function is called by register_tty_driver() to handle
  * registering the driver's /proc handler into /proc/tty/driver/<foo>
  */
 void proc_tty_register_driver(struct tty_driver *driver)
 {
 	struct proc_dir_entry *ent;
 		
-	if ((!driver->read_proc && !driver->write_proc) ||
+	if (!driver->tty_ops ||
+	    !driver->tty_ops->read_proc ||
+	    !driver->tty_ops->write_proc ||
 	    !driver->driver_name ||
 	    driver->proc_entry)
 		return;
@@ -196,8 +198,8 @@
 	ent = create_proc_entry(driver->driver_name, 0, proc_tty_driver);
 	if (!ent)
 		return;
-	ent->read_proc = driver->read_proc;
-	ent->write_proc = driver->write_proc;
+	ent->read_proc = driver->tty_ops->read_proc;
+	ent->write_proc = driver->tty_ops->write_proc;
 	ent->data = driver;
 
 	driver->proc_entry = ent;
===== drivers/char/moxa.c 1.24 vs edited =====
--- 1.24/drivers/char/moxa.c	Tue Jun 17 20:34:45 2003
+++ edited/drivers/char/moxa.c	Wed Jun 25 16:27:55 2003
@@ -624,8 +624,8 @@
 	shut_down(ch);
 	MoxaPortFlushData(port, 2);
 
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->tty_ops && tty->driver->tty_ops->flush_buffer)
+		tty->driver->tty_ops->flush_buffer(tty);
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 	tty->closing = 0;

===== drivers/char/keyboard.c 1.33 vs edited =====
--- 1.33/drivers/char/keyboard.c	Sat Jun 21 04:43:48 2003
+++ edited/drivers/char/keyboard.c	Wed Jun 25 16:51:02 2003
@@ -1091,7 +1091,7 @@
 		clear_bit(keycode, key_down);
 
 	if (rep && (!vc_kbd_mode(kbd, VC_REPEAT) || (tty && 
-		(!L_ECHO(tty) && tty->driver->chars_in_buffer(tty))))) {
+		(!L_ECHO(tty) && tty->driver->tty_ops->chars_in_buffer(tty))))) {
 		/*
 		 * Don't repeat a key if the input buffers are not empty and the
 		 * characters get aren't echoed locally. This makes key repeat 



