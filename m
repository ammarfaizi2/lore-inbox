Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTCYGxw>; Tue, 25 Mar 2003 01:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbTCYGxw>; Tue, 25 Mar 2003 01:53:52 -0500
Received: from hera.cwi.nl ([192.16.191.8]:45992 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261495AbTCYGxu>;
	Tue, 25 Mar 2003 01:53:50 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 25 Mar 2003 08:04:58 +0100 (MET)
Message-Id: <UTC200303250704.h2P74wE14222.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] tty_io cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the unregister_chrdev_region call that is the counterpart
to register_chrdev_region, we get a nice cleanup of tty_io.c.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Tue Mar 25 04:54:31 2003
+++ b/drivers/char/tty_io.c	Tue Mar 25 07:48:48 2003
@@ -2143,31 +2143,16 @@
  */
 int tty_unregister_driver(struct tty_driver *driver)
 {
-	int	retval;
-	struct tty_driver *p;
-	int	i, found = 0;
+	int retval, i;
 	struct termios *tp;
-	const char *othername = NULL;
-	
+
 	if (*driver->refcount)
 		return -EBUSY;
 
-	list_for_each_entry(p, &tty_drivers, tty_drivers) {
-		if (p == driver)
-			found++;
-		else if (p->major == driver->major)
-			othername = p->name;
-	}
-	
-	if (!found)
-		return -ENOENT;
-
-	if (othername == NULL) {
-		retval = unregister_chrdev(driver->major, driver->name);
-		if (retval)
-			return retval;
-	} else
-		register_chrdev(driver->major, othername, &tty_fops);
+	retval = unregister_chrdev_region(driver->major, driver->minor_start,
+					  driver->num, driver->name);
+	if (retval)
+		return retval;
 
 	list_del(&driver->tty_drivers);
 
diff -u --recursive --new-file -X /linux/dontdiff a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	Tue Mar 25 04:54:40 2003
+++ b/fs/char_dev.c	Tue Mar 25 07:48:48 2003
@@ -174,7 +174,8 @@
 }
 
 /* todo: make void - error printk here */
-int unregister_chrdev(unsigned int major, const char * name)
+int unregister_chrdev_region(unsigned int major, unsigned int baseminor,
+			     int minorct, const char *name)
 {
 	struct char_device_struct *cd, **cp;
 	int ret = 0;
@@ -184,7 +185,9 @@
 
 	write_lock(&chrdevs_lock);
 	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
-		if ((*cp)->major == major)
+		if ((*cp)->major == major &&
+		    (*cp)->baseminor == baseminor &&
+		    (*cp)->minorct == minorct)
 			break;
 	if (!*cp || strcmp((*cp)->name, name))
 		ret = -EINVAL;
@@ -198,6 +201,11 @@
 	return ret;
 }
 
+int unregister_chrdev(unsigned int major, const char *name)
+{
+	return unregister_chrdev_region(major, 0, 256, name);
+}
+
 /*
  * Called every time a character special file is opened
  */
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Tue Mar 25 04:54:45 2003
+++ b/include/linux/fs.h	Tue Mar 25 07:35:49 2003
@@ -1060,6 +1060,8 @@
 extern int register_chrdev(unsigned int, const char *,
 			   struct file_operations *);
 extern int unregister_chrdev(unsigned int, const char *);
+extern int unregister_chrdev_region(unsigned int, unsigned int, int,
+				    const char *);
 extern int chrdev_open(struct inode *, struct file *);
 
 /* fs/block_dev.c */
