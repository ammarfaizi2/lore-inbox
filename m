Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTDFHLq (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 03:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbTDFHLq (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 03:11:46 -0400
Received: from verein.lst.de ([212.34.181.86]:37646 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262856AbTDFHLm (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 03:11:42 -0400
Date: Sun, 6 Apr 2003 09:23:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make devpts filesystem mandatory even for CONFIG_DEVFS
Message-ID: <20030406092313.C6637@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch rips out handling of UNIX98 ptys from devfs.  We already
have a special small filesystem to handle it (devpts) that's always
compiled in anyway.  This allows to get rid of all DEVFS_FL* flags and
some gunk in devfs.

Please add a sentence about this in your relnotes, to avoid confusion
for devfs users who don't mount devfspts and don't get unix98 pty
support anymore (traditional ptys still work fine so there shouldn't
be any real problems even if they forget it)


--- 1.9/drivers/char/pty.c	Sat Mar 22 10:38:04 2003
+++ edited/drivers/char/pty.c	Mon Mar 31 08:16:19 2003
@@ -305,7 +305,6 @@
 	}
 }
 
-extern void tty_register_devfs (struct tty_driver *driver, unsigned int flags, unsigned minor);
 static int pty_open(struct tty_struct *tty, struct file * filp)
 {
 	int	retval;
@@ -333,13 +332,6 @@
 	wake_up_interruptible(&pty->open_wait);
 	set_bit(TTY_THROTTLED, &tty->flags);
 	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-
-	/*  Register a slave for the master  */
-	if (tty->driver.major == PTY_MASTER_MAJOR)
-		tty_register_devfs(&tty->link->driver,
-				   DEVFS_FL_CURRENT_OWNER | DEVFS_FL_WAIT,
-				   tty->link->driver.minor_start +
-				   minor(tty->device)-tty->driver.minor_start);
 	retval = 0;
 out:
 	return retval;
===== drivers/char/tty_io.c 1.67 vs edited =====
--- 1.67/drivers/char/tty_io.c	Sun Mar 23 01:14:19 2003
+++ edited/drivers/char/tty_io.c	Mon Mar 31 08:21:47 2003
@@ -1348,46 +1348,38 @@
 
 	if (IS_PTMX_DEV(device)) {
 #ifdef CONFIG_UNIX98_PTYS
-
 		/* find a free pty. */
 		int major, minor;
 		struct tty_driver *driver;
 
 		/* find a device that is not in use. */
 		retval = -1;
-		for ( major = 0 ; major < UNIX98_NR_MAJORS ; major++ ) {
+		for (major = 0 ; major < UNIX98_NR_MAJORS ; major++) {
 			driver = &ptm_driver[major];
-			for (minor = driver->minor_start ;
-			     minor < driver->minor_start + driver->num ;
+			for (minor = driver->minor_start;
+			     minor < driver->minor_start + driver->num;
 			     minor++) {
 				device = mk_kdev(driver->major, minor);
-				if (!init_dev(device, &tty)) goto ptmx_found; /* ok! */
+				if (!init_dev(device, &tty))
+					goto ptmx_found; /* ok! */
 			}
 		}
 		return -EIO; /* no free ptys */
+
 	ptmx_found:
 		set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
 		minor -= driver->minor_start;
 		devpts_pty_new(driver->other->name_base + minor, MKDEV(driver->other->major, minor + driver->other->minor_start));
-		tty_register_device(&pts_driver[major],
-				   pts_driver[major].minor_start + minor);
 		noctty = 1;
-		goto init_dev_done;
-
-#else   /* CONFIG_UNIX_98_PTYS */
-
+#else
 		return -ENODEV;
-
 #endif  /* CONFIG_UNIX_98_PTYS */
+	} else {
+		retval = init_dev(device, &tty);
+		if (retval)
+			return retval;
 	}
 
-	retval = init_dev(device, &tty);
-	if (retval)
-		return retval;
-
-#ifdef CONFIG_UNIX98_PTYS
-init_dev_done:
-#endif
 	filp->private_data = tty;
 	file_move(filp, &tty->tty_files);
 	check_tty_count(tty, "tty_open");
@@ -2055,51 +2047,48 @@
 	tty->driver.write(tty, 0, &ch, 1);
 }
 
-void tty_register_devfs (struct tty_driver *driver, unsigned int flags, unsigned minor)
-{
 #ifdef CONFIG_DEVFS_FS
+static void tty_register_devfs(struct tty_driver *driver, unsigned minor)
+{
 	umode_t mode = S_IFCHR | S_IRUSR | S_IWUSR;
-	kdev_t device = mk_kdev(driver->major, minor);
+	kdev_t dev = mk_kdev(driver->major, minor);
 	int idx = minor - driver->minor_start;
 	char buf[32];
 
-	if (IS_TTY_DEV(device) || IS_PTMX_DEV(device)) 
-		mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
-	else {
-		if (driver->major == PTY_MASTER_MAJOR)
-			mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
-	}
-	if ( (minor <  driver->minor_start) || 
-	     (minor >= driver->minor_start + driver->num) ) {
+	if ((minor < driver->minor_start) || 
+	    (minor >= driver->minor_start + driver->num)) {
 		printk(KERN_ERR "Attempt to register invalid minor number "
 		       "with devfs (%d:%d).\n", (int)driver->major,(int)minor);
 		return;
 	}
-#  ifdef CONFIG_UNIX98_PTYS
-	if ( (driver->major >= UNIX98_PTY_SLAVE_MAJOR) &&
-	     (driver->major < UNIX98_PTY_SLAVE_MAJOR + UNIX98_NR_MAJORS) )
-		flags |= DEVFS_FL_CURRENT_OWNER;
-#  endif
+
+	if (IS_TTY_DEV(dev) || IS_PTMX_DEV(dev)) 
+		mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
+
 	sprintf(buf, driver->name, idx + driver->name_base);
-	devfs_register (NULL, buf, flags | DEVFS_FL_DEFAULT,
-			driver->major, minor, mode, &tty_fops, NULL);
-#endif /* CONFIG_DEVFS_FS */
+	devfs_register(NULL, buf, 0, driver->major, minor, mode,
+		       &tty_fops, NULL);
 }
 
-void tty_unregister_devfs (struct tty_driver *driver, unsigned minor)
+static void tty_unregister_devfs(struct tty_driver *driver, unsigned minor)
 {
-	devfs_remove(driver->name, minor-driver->minor_start+driver->name_base);
+	devfs_remove(driver->name,
+		     minor - driver->minor_start + driver->name_base);
 }
+#else
+# define tty_register_devfs(driver, minor)	do { } while (0)
+# define tty_unregister_devfs(driver, minor)	do { } while (0)
+#endif /* CONFIG_DEVFS_FS */
 
 /*
  * Register a tty device described by <driver>, with minor number <minor>.
  */
-void tty_register_device (struct tty_driver *driver, unsigned minor)
+void tty_register_device(struct tty_driver *driver, unsigned minor)
 {
-	tty_register_devfs(driver, 0, minor);
+	tty_register_devfs(driver, minor);
 }
 
-void tty_unregister_device (struct tty_driver *driver, unsigned minor)
+void tty_unregister_device(struct tty_driver *driver, unsigned minor)
 {
 	tty_unregister_devfs(driver, minor);
 }
