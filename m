Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283595AbRK3Kty>; Fri, 30 Nov 2001 05:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283597AbRK3Kto>; Fri, 30 Nov 2001 05:49:44 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:24242 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S283595AbRK3KtZ>; Fri, 30 Nov 2001 05:49:25 -0500
Date: Fri, 30 Nov 2001 11:44:14 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: randall@uph.com
cc: Balbir Singh <balbir_soni@yahoo.com>, rmk@arm.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
In-Reply-To: <200111291803.fATI37q08404@sword.damocles.com>
Message-ID: <Pine.GSO.3.96.1011130112041.15249C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001, Jeff Randall wrote:

> > lets say I call rs_open() on /dev/ttyS0 and if it
> > fails then I should not call rs_close() after a failed
> > rs_open().
> > 
> > I hope this is clear now.
> 
> All of the other UNIX variants I've dealth with behave that way.
> However, you cannot just make that change without having some means
> of identifying that behavior change because all of the linux
> serial drivers have been written to assume that their close()
> will be called even after their open() has failed.

 Nope, at least serial.c decrements its use count in rs_close() 
unconditionally (I believe other drivers do so as well), whether it was
called after a failed rs_open() or not.  As a result you may suddenly have
the use count zero while the driver is still in use.  Then modprobe
unloads it and a crash is due out soon.  That's sad the problem persists
at least since 2.2 (a temporary fix was made to 2.2.x, then it was removed
again with no better one in 2.3.x). 

 Here is a fix I'm using for 2.4.  It was submitted to Alan once, then a
discussion was performed with a conclusion like "that may be a temporary
fix for 2.4, but it needs a complete rework for 2.5".  I'm not sure if the
patch went in anywhere.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.5-tty_io-3
diff -up --recursive --new-file linux-2.4.5.macro/drivers/char/tty_io.c linux-2.4.5/drivers/char/tty_io.c
--- linux-2.4.5.macro/drivers/char/tty_io.c	Tue May  1 17:24:08 2001
+++ linux-2.4.5/drivers/char/tty_io.c	Wed Jun 27 20:46:57 2001
@@ -61,6 +61,9 @@
  * Reduced memory usage for older ARM systems
  *      -- Russell King <rmk@arm.linux.org.uk>
  *
+ * Don't call close after a failed open.
+ *	-- Maciej W. Rozycki <macro@ds2.pg.gda.pl>, 21-Jan-2001
+ *
  * Move do_SAK() into process context.  Less stack use in devfs functions.
  * alloc_tty_struct() always uses kmalloc() -- Andrew Morton <andrewm@uow.edu.eu> 17Mar01
  */
@@ -1043,7 +1046,7 @@ static void release_mem(struct tty_struc
  * WSH 09/09/97: rewritten to avoid some nasty race conditions that could
  * lead to double frees or releasing memory still in use.
  */
-static void release_dev(struct file * filp)
+static void release_dev(struct file * filp, int do_close)
 {
 	struct tty_struct *tty, *o_tty;
 	int	pty_master, tty_closing, o_tty_closing, do_sleep;
@@ -1121,7 +1124,7 @@ static void release_dev(struct file * fi
 	}
 #endif
 
-	if (tty->driver.close)
+	if (do_close && tty->driver.close)
 		tty->driver.close(tty, filp);
 
 	/*
@@ -1284,7 +1287,7 @@ static void release_dev(struct file * fi
 static int tty_open(struct inode * inode, struct file * filp)
 {
 	struct tty_struct *tty;
-	int noctty, retval;
+	int noctty, retval, open_ok;
 	kdev_t device;
 	unsigned short saved_flags;
 	char	buf[64];
@@ -1369,9 +1372,12 @@ init_dev_done:
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
 
@@ -1384,7 +1390,7 @@ init_dev_done:
 		       tty_name(tty, buf));
 #endif
 
-		release_dev(filp);
+		release_dev(filp, open_ok);
 		if (retval != -ERESTARTSYS)
 			return retval;
 		if (signal_pending(current))
@@ -1426,7 +1432,7 @@ init_dev_done:
 static int tty_release(struct inode * inode, struct file * filp)
 {
 	lock_kernel();
-	release_dev(filp);
+	release_dev(filp, 1);
 	unlock_kernel();
 	return 0;
 }

