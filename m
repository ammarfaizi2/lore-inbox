Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268279AbTAMFiP>; Mon, 13 Jan 2003 00:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268282AbTAMFiP>; Mon, 13 Jan 2003 00:38:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:37636 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268279AbTAMFiN>;
	Mon, 13 Jan 2003 00:38:13 -0500
Date: Sun, 12 Jan 2003 21:47:09 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] add module reference to struct tty_driver
Message-ID: <20030113054708.GA3604@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In digging into the tty layer locking, I noticed that the tty layer
doesn't handle module reference counting for any tty drivers.  Well, I've
known this for a long time, just finally got around to fixing it :)
Here's a patch against 2.5.56 that should fix this issue (works for
me...)

Comments?  If no one objects, I'll send it on to Linus, and add support
for this to a number of tty drivers that commonly get built as modules.

thanks,

greg k-h


# TTY: add module reference counting for tty drivers.

diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Sun Jan 12 21:46:53 2003
+++ b/drivers/char/tty_io.c	Sun Jan 12 21:46:53 2003
@@ -833,6 +833,11 @@
 	 * and locked termios may be retained.)
 	 */
 
+	if (!try_module_get(driver->owner)) {
+		retval = -ENODEV;
+		goto end_init;
+	}
+
 	o_tty = NULL;
 	tp = o_tp = NULL;
 	ltp = o_ltp = NULL;
@@ -991,6 +996,7 @@
 	free_tty_struct(tty);
 
 fail_no_mem:
+	module_put(driver->owner);
 	retval = -ENOMEM;
 	goto end_init;
 
@@ -1033,6 +1039,7 @@
 	tty->magic = 0;
 	(*tty->driver.refcount)--;
 	list_del(&tty->tty_files);
+	module_put(tty->driver.owner);
 	free_tty_struct(tty);
 }
 
diff -Nru a/include/linux/tty_driver.h b/include/linux/tty_driver.h
--- a/include/linux/tty_driver.h	Sun Jan 12 21:46:53 2003
+++ b/include/linux/tty_driver.h	Sun Jan 12 21:46:53 2003
@@ -120,6 +120,7 @@
 
 struct tty_driver {
 	int	magic;		/* magic number for this structure */
+	struct module	*owner;
 	const char	*driver_name;
 	const char	*name;
 	int	name_base;	/* offset of printed name */
