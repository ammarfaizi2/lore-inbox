Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTAOBFf>; Tue, 14 Jan 2003 20:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTAOBFf>; Tue, 14 Jan 2003 20:05:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40201 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265637AbTAOBFc>;
	Tue, 14 Jan 2003 20:05:32 -0500
Date: Tue, 14 Jan 2003 17:14:10 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] TTY changes for 2.5.58
Message-ID: <20030115011409.GB18283@kroah.com>
References: <20030115011312.GA18283@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115011312.GA18283@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1025, 2003/01/14 16:51:58-08:00, greg@kroah.com

TTY: add module reference counting for tty drivers.

Note, there are still races with unloading modules, this patch
does not fix that...


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Tue Jan 14 17:07:05 2003
+++ b/drivers/char/tty_io.c	Tue Jan 14 17:07:05 2003
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
--- a/include/linux/tty_driver.h	Tue Jan 14 17:07:05 2003
+++ b/include/linux/tty_driver.h	Tue Jan 14 17:07:05 2003
@@ -120,6 +120,7 @@
 
 struct tty_driver {
 	int	magic;		/* magic number for this structure */
+	struct module	*owner;
 	const char	*driver_name;
 	const char	*name;
 	int	name_base;	/* offset of printed name */
