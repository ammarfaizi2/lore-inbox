Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318643AbSHEQMo>; Mon, 5 Aug 2002 12:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSHEQLq>; Mon, 5 Aug 2002 12:11:46 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:972 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318657AbSHEQJX>; Mon, 5 Aug 2002 12:09:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
Organization: IBM Deutschland Entwicklung GmbH
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 17/18 support arbitrary devfs names for tty devices
Date: Mon, 5 Aug 2002 20:04:03 +0200
User-Agent: KMail/1.4.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200208051830.50713.arndb@de.ibm.com>
In-Reply-To: <200208051830.50713.arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208051959.53644.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces two functions tty_io. They are needed by the 3270 driver
to generate the correct entries in the device file system. We do not want
the 3270 device to get device names according to their minor number but
we want to see the real device number. If the device file system is not
used this can be replaced by a call to tty_register_devfs.

diff -urN linux-2.4.19-rc3/drivers/char/tty_io.c linux-2.4.19-s390/drivers/char/tty_io.c
--- linux-2.4.19-rc3/drivers/char/tty_io.c	Tue Jul 30 09:02:27 2002
+++ linux-2.4.19-s390/drivers/char/tty_io.c	Tue Jul 30 09:02:43 2002
@@ -2058,8 +2058,63 @@
 #endif /* CONFIG_DEVFS_FS */
 }
 
+/*
+ * Register a tty device described by <driver>, with minor number <minor>,
+ * device name <name> and in the /dev directory given by <dir>.
+ */
+void tty_register_devfs_name (struct tty_driver *driver, unsigned int flags,
+			      unsigned minor, devfs_handle_t dir,
+			      const char *name)
+{
+#ifdef CONFIG_DEVFS_FS
+	umode_t mode = S_IFCHR | S_IRUSR | S_IWUSR;
+	kdev_t device = MKDEV (driver->major, minor);
+
+	switch (device) {
+		case TTY_DEV:
+		case PTMX_DEV:
+			mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
+			break;
+		default:
+			if (driver->major == PTY_MASTER_MAJOR)
+				flags |= DEVFS_FL_AUTO_OWNER;
+			break;
+	}
+	if ( (minor <  driver->minor_start) || 
+	     (minor >= driver->minor_start + driver->num) ) {
+		printk(KERN_ERR "Attempt to register invalid minor number "
+		       "with devfs (%d:%d).\n", (int)driver->major,(int)minor);
+		return;
+	}
+#  ifdef CONFIG_UNIX98_PTYS
+	if ( (driver->major >= UNIX98_PTY_SLAVE_MAJOR) &&
+	     (driver->major < UNIX98_PTY_SLAVE_MAJOR + UNIX98_NR_MAJORS) )
+		flags |= DEVFS_FL_CURRENT_OWNER;
+#  endif
+	devfs_register (dir, name, flags | DEVFS_FL_DEFAULT,
+			driver->major, minor, mode, &tty_fops, NULL);
+#endif /* CONFIG_DEVFS_FS */
+}
+
+void tty_unregister_devfs_name (struct tty_driver *driver, unsigned minor,
+				devfs_handle_t dir, const char *name)
+{
+#ifdef CONFIG_DEVFS_FS
+	void * handle;
+
+	handle = devfs_find_handle (dir, name, driver->major, minor,
+				    DEVFS_SPECIAL_CHR, 0);
+	devfs_unregister (handle);
+#endif /* CONFIG_DEVFS_FS */
+}
+
+extern void tty_unregister_devfs_name (struct tty_driver *driver,
+				       unsigned minor, devfs_handle_t dir,
+				       const char *name);
 EXPORT_SYMBOL(tty_register_devfs);
 EXPORT_SYMBOL(tty_unregister_devfs);
+EXPORT_SYMBOL(tty_register_devfs_name);
+EXPORT_SYMBOL(tty_unregister_devfs_name);
 
 /*
  * Called by a tty driver to register itself.
diff -urN linux-2.4.19-rc3/include/linux/tty.h linux-2.4.19-s390/include/linux/tty.h
--- linux-2.4.19-rc3/include/linux/tty.h	Thu Nov 22 20:46:19 2001
+++ linux-2.4.19-s390/include/linux/tty.h	Tue Jul 30 09:01:23 2002
@@ -381,6 +381,13 @@
 extern void tty_register_devfs (struct tty_driver *driver, unsigned int flags,
 				unsigned minor);
 extern void tty_unregister_devfs (struct tty_driver *driver, unsigned minor);
+struct devfs_entry;
+extern void tty_register_devfs_name (struct tty_driver *driver,
+				     unsigned int flags, unsigned minor,
+				     struct devfs_entry *dir, const char *name);
+extern void tty_unregister_devfs_name (struct tty_driver *driver,
+				       unsigned minor, struct devfs_entry *dir,
+				       const char *name);
 extern int tty_read_raw_data(struct tty_struct *tty, unsigned char *bufp,
 			     int buflen);
 extern void tty_write_message(struct tty_struct *tty, char *msg);


