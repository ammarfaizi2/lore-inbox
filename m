Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312391AbSCURFf>; Thu, 21 Mar 2002 12:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSCURF0>; Thu, 21 Mar 2002 12:05:26 -0500
Received: from [216.167.37.170] ([216.167.37.170]:8719 "EHLO cob427.dn.net")
	by vger.kernel.org with ESMTP id <S312391AbSCURFO>;
	Thu, 21 Mar 2002 12:05:14 -0500
Date: Thu, 21 Mar 2002 22:27:47 +0530
From: "Sapan J . Bhatia" <lists@corewars.org>
To: linux-kernel@vger.kernel.org
Cc: jdike@karaya.com
Subject: [PATCH] POLL_OUT for tty drivers, misc bug
Message-ID: <20020321222747.A16865@corewars.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux corewars 2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

While fixing a flow control bug that truncated output to a terminal in
User Mode Linux, I noticed that the tty drivers only send POLL_IN on new
data being available but not POLL_OUT when the device is ready for new
data.

This patch fixes the bug in the line discipline and the pty driver.

Also, there's another minor bug in n_tty.c where write_chan returns
on a (retvalue < 0) unconditionally. This is a problem, since the type of
IO (BLOCKING / NON_BLOCKING) is stored in the tty, and if the console driver
returns a -EAGAIN (eg. in UML on getting an EAGAIN from the host kernel), 
write_chan returns even in the case of a blocking write, which is wrong
since the process doesn't expect it.

Regards,
Sapan
 

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tty_bugs.diff"

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
+++ /usr/src/linux-2.4.18/drivers/char/n_tty.c	Thu Mar 21 07:22:44 2002
@@ -23,6 +23,13 @@
  * 2000/01/20   Fixed SMP locking on put_tty_queue using bits of 
  *		the patch by Andrew J. Kroll <ag784@freenet.buffalo.edu>
  *		who actually finally proved there really was a race.
+ *
+ * 2002/03/18   Implemented n_tty_wakeup to send SIGIO POLL_OUTs to
+ *		waiting writing processes-Sapan Bhatia <sapan@corewars.org>
+ *
+ * 2002/03/19   Fixed write_chan to stay put if console driver returns
+ *              EAGAIN and not return since it returns an EAGAIN in a 
+ *		non-blocking operation-Sapan Bhatia <sapan@corewars.org>
  */
 
 #include <linux/types.h>
@@ -711,6 +718,22 @@
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
@@ -1156,7 +1179,7 @@
 		if (O_OPOST(tty) && !(test_bit(TTY_HW_COOK_OUT, &tty->flags))) {
 			while (nr > 0) {
 				ssize_t num = opost_block(tty, b, nr);
-				if (num < 0) {
+				if (num < 0 && num != -EAGAIN) {
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
 

--EeQfGwPcQSOJBaQU--
