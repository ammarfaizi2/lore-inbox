Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313054AbSDFG2m>; Sat, 6 Apr 2002 01:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313080AbSDFG2d>; Sat, 6 Apr 2002 01:28:33 -0500
Received: from [216.167.37.170] ([216.167.37.170]:15635 "EHLO cob427.dn.net")
	by vger.kernel.org with ESMTP id <S313054AbSDFG22>;
	Sat, 6 Apr 2002 01:28:28 -0500
Date: Sat, 6 Apr 2002 11:58:00 +0530
From: "Sapan J . Bhatia" <lists@corewars.org>
To: marcelo@conectiva.com.br, andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] revision: POLL_OUT for ttys, serial drivers
Message-ID: <20020406115800.A1421@corewars.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux corewars 2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

    Hi!

This revised version of the patch includes a fix for serial.c as well, 
since it had the same problem, and a minor change in the second fix.
Please use this version instead of the previous one.

      Cheers,
    Sapan

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tty_bugs.diff"

--- /tmp/work/linux/drivers/char/serial.c	Tue Feb 26 01:07:57 2002
+++ /usr/src/linux-2.4.18/drivers/char/serial.c	Sat Apr  6 11:29:22 2002
@@ -57,6 +57,10 @@
  * 10/00: add in optional software flow control for serial console.
  *	  Kanoj Sarcar <kanoj@sgi.com>  (Modified by Theodore Ts'o)
  *
+ *  4/02: added TTY_DO_WRITE_WAKEUP to enable n_tty to send POLL_OUTS
+ *        to waiting processes
+ *        Sapan Bhatia <sapan@corewars.org>
+ *
  */
 
 static char *serial_version = "5.05c";
@@ -3233,6 +3237,7 @@
 #ifdef SERIAL_DEBUG_OPEN
 	printk("rs_open ttys%d successful...", info->line);
 #endif
+	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	return 0;
 }
 
--- /tmp/work/linux/drivers/char/pty.c	Fri Dec 21 23:11:54 2001
+++ /usr/src/linux-2.4.18/drivers/char/pty.c	Thu Mar 21 20:26:01 2002
@@ -5,6 +5,10 @@
  *
  *  Added support for a Unix98-style ptmx device.
  *    -- C. Scott Ananian <cananian@alumni.princeton.edu>, 14-Jan-1998
+ *  Added TTY_DO_WRITE_WAKEUP to enable n_tty to send POLL_OUT to
+ *      waiting writers -- Sapan Bhatia <sapan@corewars.org>
+ *
+ *
  */
 
 #include <linux/config.h>
@@ -331,6 +335,8 @@
 	clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
 	wake_up_interruptible(&pty->open_wait);
 	set_bit(TTY_THROTTLED, &tty->flags);
+	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+
 	/*  Register a slave for the master  */
 	if (tty->driver.major == PTY_MASTER_MAJOR)
 		tty_register_devfs(&tty->link->driver,
--- /tmp/work/linux/drivers/char/n_tty.c	Fri Apr  6 23:12:55 2001
+++ /usr/src/linux-2.4.18/drivers/char/n_tty.c	Sat Mar 30 12:39:14 2002
@@ -23,6 +23,11 @@
  * 2000/01/20   Fixed SMP locking on put_tty_queue using bits of 
  *		the patch by Andrew J. Kroll <ag784@freenet.buffalo.edu>
  *		who actually finally proved there really was a race.
+ *
+ * 2002/03/18   Implemented n_tty_wakeup to send SIGIO POLL_OUTs to
+ *		waiting writing processes-Sapan Bhatia <sapan@corewars.org>.
+ *		Also fixed a bug in BLOCKING mode where write_chan returns
+ *		EAGAIN
  */
 
 #include <linux/types.h>
@@ -711,6 +716,22 @@
 	return 0;
 }
 
+/*
+ * Required for the ptys, serial driver etc. since processes
+ * that attach themselves to the master and rely on ASYNC
+ * IO must be woken up
+ */
+
+static void n_tty_write_wakeup(struct tty_struct *tty)
+{
+	if (tty->fasync)
+	{
+ 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+		kill_fasync(&tty->fasync, SIGIO, POLL_OUT);
+	}
+	return;
+}
+
 static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			      char *fp, int count)
 {
@@ -1157,6 +1178,8 @@
 			while (nr > 0) {
 				ssize_t num = opost_block(tty, b, nr);
 				if (num < 0) {
+					if (num == -EAGAIN)
+						break;
 					retval = num;
 					goto break_out;
 				}
@@ -1236,6 +1259,6 @@
 	normal_poll,		/* poll */
 	n_tty_receive_buf,	/* receive_buf */
 	n_tty_receive_room,	/* receive_room */
-	0			/* write_wakeup */
+	n_tty_write_wakeup	/* write_wakeup */
 };
 

--cWoXeonUoKmBZSoM--
