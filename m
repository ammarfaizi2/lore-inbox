Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130617AbRCPQqz>; Fri, 16 Mar 2001 11:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130618AbRCPQqq>; Fri, 16 Mar 2001 11:46:46 -0500
Received: from mnh-1-19.mv.com ([207.22.10.51]:54533 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S130617AbRCPQqn>;
	Fri, 16 Mar 2001 11:46:43 -0500
Message-Id: <200103161757.MAA01897@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org, engler@csl.Stanford.EDU, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] big stack variables 
In-Reply-To: Your message of "Fri, 16 Mar 2001 19:23:45 +1100."
             <3AB1CD91.7C70CD49@uow.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Mar 2001 12:57:30 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrewm@uow.edu.au said:
> I've got my nose stuck in tty_io.c at present - I'll fix this this
> one. 

This is the patch I've been carrying around in the UML pool since this bit me:

diff -Naur -X exclude-files orig/drivers/char/tty_io.c um/drivers/char/tty_io.c
--- orig/drivers/char/tty_io.c	Thu Feb 22 11:53:50 2001
+++ um/drivers/char/tty_io.c	Thu Feb 22 11:54:55 2001
@@ -1991,12 +1991,11 @@
 {
 #ifdef CONFIG_DEVFS_FS
 	umode_t mode = S_IFCHR | S_IRUSR | S_IWUSR;
-	struct tty_struct tty;
+	kdev_t device = MKDEV (driver->major, minor);
+	int idx = minor - driver->minor_start;
 	char buf[32];
 
-	tty.driver = *driver;
-	tty.device = MKDEV (driver->major, minor);
-	switch (tty.device) {
+	switch (device) {
 		case TTY_DEV:
 		case PTMX_DEV:
 			mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
@@ -2017,23 +2016,21 @@
 	     (driver->major < UNIX98_PTY_SLAVE_MAJOR + UNIX98_NR_MAJORS) )
 		flags |= DEVFS_FL_CURRENT_OWNER;
 #  endif
-	devfs_register (NULL, tty_name (&tty, buf), flags | DEVFS_FL_DEFAULT,
+	sprintf(buf, driver->name, idx + driver->name_base);
+	devfs_register (NULL, buf, flags | DEVFS_FL_DEFAULT,
 			driver->major, minor, mode, &tty_fops, NULL);
 #endif /* CONFIG_DEVFS_FS */
 }
 
-void tty_unregister_devfs (struct tty_driver *driver, unsigned minor)
+void tty_unregister_devfs (struct tty_driver *driver, unsigned int minor)
 {
 #ifdef CONFIG_DEVFS_FS
 	void * handle;
-	struct tty_struct tty;
+	int idx = minor - driver->minor_start;
 	char buf[32];
 
-	tty.driver = *driver;
-	tty.device = MKDEV(driver->major, minor);
-	
-	handle = devfs_find_handle (NULL, tty_name (&tty, buf),
-				    driver->major, minor,
+	sprintf(buf, driver->name, idx + driver->name_base);
+	handle = devfs_find_handle (NULL, buf, driver->major, minor,
 				    DEVFS_SPECIAL_CHR, 0);
 	devfs_unregister (handle);
 #endif /* CONFIG_DEVFS_FS */
@@ -2192,6 +2189,9 @@
 #endif
 #ifdef CONFIG_HWC
         hwc_console_init();
+#endif
+#ifdef CONFIG_STDIO_CONSOLE
+	stdio_console_init();
 #endif
 #ifdef CONFIG_SERIAL_21285_CONSOLE
 	rs285_console_init();


