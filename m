Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAVN7S>; Mon, 22 Jan 2001 08:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130367AbRAVN7J>; Mon, 22 Jan 2001 08:59:09 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:13481 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129835AbRAVN6w>; Mon, 22 Jan 2001 08:58:52 -0500
Date: Mon, 22 Jan 2001 14:55:14 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
Message-ID: <Pine.GSO.3.96.1010122140031.1523H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 There is a problem with handling of TTYs, which manifests itself for
modular backends.  I've been able to observe it with the serial.c backend. 
The symptoms are if open() fails for some reason (e.g. due to an inactive
DSR line), the module count for the responsible backend decrements
multiple times.  This may lead (and does for me frequently enough) to the
module being unloaded while still in use and a crash as soon as one of the
module's holders makes use of it.

 I've narrowed it down to tty_io.c calling backend's close() function
after a failed open(), which makes no sense.  Following are two patches,
for 2.4.0 and 2.2.18.  For 2.2.18 there is currently a workaround
implemented in serial.c, which was created by Ted after I reported the
very same problem in 2.1.12* or so about two years ago.  The 2.2.18 patch
reverts the workaround and provides a proper fix. 

 Both patches were proven to work as expected for the serial.c backend.  I
wasn't able to verify it against other backends, especially the zillion of
zs.c drivers.  They need to be fixed if they break after this change.

 I believe the fix should go into 2.4.1 and 2.2.19.  If anyone objects,
please speak up now.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.0-tty_io-2
diff -up --recursive --new-file linux-2.4.0.macro/drivers/char/tty_io.c linux-2.4.0/drivers/char/tty_io.c
--- linux-2.4.0.macro/drivers/char/tty_io.c	Wed Jan  3 07:54:03 2001
+++ linux-2.4.0/drivers/char/tty_io.c	Sun Jan 21 20:39:32 2001
@@ -60,6 +60,9 @@
  *
  * Reduced memory usage for older ARM systems
  *      -- Russell King <rmk@arm.linux.org.uk>
+ *
+ * Don't call close after a failed open.
+ *	-- Maciej W. Rozycki <macro@ds2.pg.gda.pl>, 21-Jan-2001
  */
 
 #include <linux/config.h>
@@ -1044,7 +1047,7 @@ static void release_mem(struct tty_struc
  * WSH 09/09/97: rewritten to avoid some nasty race conditions that could
  * lead to double frees or releasing memory still in use.
  */
-static void release_dev(struct file * filp)
+static void release_dev(struct file * filp, int do_close)
 {
 	struct tty_struct *tty, *o_tty;
 	int	pty_master, tty_closing, o_tty_closing, do_sleep;
@@ -1122,7 +1125,7 @@ static void release_dev(struct file * fi
 	}
 #endif
 
-	if (tty->driver.close)
+	if (do_close && tty->driver.close)
 		tty->driver.close(tty, filp);
 
 	/*
@@ -1285,7 +1288,7 @@ static void release_dev(struct file * fi
 static int tty_open(struct inode * inode, struct file * filp)
 {
 	struct tty_struct *tty;
-	int noctty, retval;
+	int noctty, retval, open_ok;
 	kdev_t device;
 	unsigned short saved_flags;
 	char	buf[64];
@@ -1370,9 +1373,12 @@ init_dev_done:
 #ifdef TTY_DEBUG_HANGUP
 	printk("opening %s...", tty_name(tty, buf));
 #endif
-	if (tty->driver.open)
+	open_ok = 0;
+	if (tty->driver.open) {
 		retval = tty->driver.open(tty, filp);
-	else
+		if (!retval)
+			open_ok = 1;
+	} else
 		retval = -ENODEV;
 	filp->f_flags = saved_flags;
 
@@ -1385,7 +1391,7 @@ init_dev_done:
 		       tty_name(tty, buf));
 #endif
 
-		release_dev(filp);
+		release_dev(filp, open_ok);
 		if (retval != -ERESTARTSYS)
 			return retval;
 		if (signal_pending(current))
@@ -1427,7 +1433,7 @@ init_dev_done:
 static int tty_release(struct inode * inode, struct file * filp)
 {
 	lock_kernel();
-	release_dev(filp);
+	release_dev(filp, 1);
 	unlock_kernel();
 	return 0;
 }

patch-2.2.18-tty_io-4
diff -up --recursive --new-file linux-2.2.18.macro/drivers/char/serial.c linux-2.2.18/drivers/char/serial.c
--- linux-2.2.18.macro/drivers/char/serial.c	Thu Jun  8 19:14:48 2000
+++ linux-2.2.18/drivers/char/serial.c	Sun Jan 21 17:35:45 2001
@@ -2622,7 +2622,7 @@ static int rs_open(struct tty_struct *tt
 	tty->driver_data = info;
 	info->tty = tty;
 	if (serial_paranoia_check(info, tty->device, "rs_open")) {
-		/* MOD_DEC_USE_COUNT; "info->tty" will cause this */
+		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
 
@@ -2635,7 +2635,7 @@ static int rs_open(struct tty_struct *tt
 	if (!tmp_buf) {
 		page = get_free_page(GFP_KERNEL);
 		if (!page) {
-			/* MOD_DEC_USE_COUNT; "info->tty" will cause this? */
+			MOD_DEC_USE_COUNT;
 			return -ENOMEM;
 		}
 		if (tmp_buf)
@@ -2651,7 +2651,7 @@ static int rs_open(struct tty_struct *tt
 	    (info->flags & ASYNC_CLOSING)) {
 		if (info->flags & ASYNC_CLOSING)
 			interruptible_sleep_on(&info->close_wait);
-		/* MOD_DEC_USE_COUNT; "info->tty" will cause this? */
+		MOD_DEC_USE_COUNT;
 #ifdef SERIAL_DO_RESTART
 		return ((info->flags & ASYNC_HUP_NOTIFY) ?
 			-EAGAIN : -ERESTARTSYS);
@@ -2665,13 +2665,13 @@ static int rs_open(struct tty_struct *tt
 	 */
 	retval = startup(info);
 	if (retval) {
-		/* MOD_DEC_USE_COUNT; "info->tty" will cause this? */
+		MOD_DEC_USE_COUNT;
 		return retval;
 	}
 
 	retval = block_til_ready(tty, filp, info);
 	if (retval) {
-		/* MOD_DEC_USE_COUNT; "info->tty" will cause this? */
+		MOD_DEC_USE_COUNT;
 #ifdef SERIAL_DEBUG_OPEN
 		printk("rs_open returning after block_til_ready with %d\n",
 		       retval);
diff -up --recursive --new-file linux-2.2.18.macro/drivers/char/tty_io.c linux-2.2.18/drivers/char/tty_io.c
--- linux-2.2.18.macro/drivers/char/tty_io.c	Mon Dec 11 22:50:34 2000
+++ linux-2.2.18/drivers/char/tty_io.c	Sun Jan 21 20:48:08 2001
@@ -54,6 +54,9 @@
  *
  * Added support for a Unix98-style ptmx device.
  *      -- C. Scott Ananian <cananian@alumni.princeton.edu>, 14-Jan-1998
+ *
+ * Don't call close after a failed open.
+ *	-- Maciej W. Rozycki <macro@ds2.pg.gda.pl>, 21-Jan-2001
  */
 
 #include <linux/config.h>
@@ -1009,7 +1012,7 @@ static void release_mem(struct tty_struc
  * WSH 09/09/97: rewritten to avoid some nasty race conditions that could
  * lead to double frees or releasing memory still in use.
  */
-static void release_dev(struct file * filp)
+static void release_dev(struct file * filp, int do_close)
 {
 	struct tty_struct *tty, *o_tty;
 	int	pty_master, tty_closing, o_tty_closing, do_sleep;
@@ -1087,7 +1090,7 @@ static void release_dev(struct file * fi
 	}
 #endif
 
-	if (tty->driver.close)
+	if (do_close && tty->driver.close)
 		tty->driver.close(tty, filp);
 
 	/*
@@ -1258,7 +1261,7 @@ static void release_dev(struct file * fi
 static int tty_open(struct inode * inode, struct file * filp)
 {
 	struct tty_struct *tty;
-	int noctty, retval;
+	int noctty, retval, open_ok;
 	kdev_t device;
 	unsigned short saved_flags;
 	char	buf[64];
@@ -1340,9 +1343,12 @@ init_dev_done:
 #ifdef TTY_DEBUG_HANGUP
 	printk("opening %s...", tty_name(tty, buf));
 #endif
-	if (tty->driver.open)
+	open_ok = 0;
+	if (tty->driver.open) {
 		retval = tty->driver.open(tty, filp);
-	else
+		if (!retval)
+			open_ok = 1;
+	} else
 		retval = -ENODEV;
 	filp->f_flags = saved_flags;
 
@@ -1355,7 +1361,7 @@ init_dev_done:
 		       tty_name(tty, buf));
 #endif
 
-		release_dev(filp);
+		release_dev(filp, open_ok);
 		if (retval != -ERESTARTSYS)
 			return retval;
 		if (signal_pending(current))
@@ -1394,7 +1400,7 @@ init_dev_done:
 
 static int tty_release(struct inode * inode, struct file * filp)
 {
-	release_dev(filp);
+	release_dev(filp, 1);
 	return 0;
 }
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
