Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269590AbUJFXxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269590AbUJFXxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269511AbUJFXgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:36:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24062 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S269637AbUJFXel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:34:41 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] add class/tty/console/real_dev symlink
Date: Wed, 6 Oct 2004 18:30:52 +0000
User-Agent: KMail/1.7
Cc: greg@kroah.com, katzj@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410061830.52563.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a symlink from /sys/class/tty/console/real_dev to 
e.g. /sys/class/tty/ttyS0 . This is needed because there is no way for 
userspace to determine what device the kernel is using as its console, and in 
the case of an installer that is important information. Otherwise, the 
installer cannot know which serial port you're booting on, for example, and 
so wouldn't know where to display itself.

This "works for me". I'm not overly attached to the name of the symlink 
though. Comments?

-- 
Hollis Blanchard
IBM Linux Technology Center

===== drivers/char/tty_io.c 1.147 vs edited =====
--- 1.147/drivers/char/tty_io.c Sat Oct  2 17:45:19 2004
+++ edited/drivers/char/tty_io.c Wed Oct  6 17:08:27 2004
@@ -110,6 +110,8 @@
 #define TTY_PARANOIA_CHECK 1
 #define CHECK_TTY_COUNT 1
 
+static struct class_device *console_dev;
+
 struct termios tty_std_termios = { /* for the benefit of tty drivers  */
  .c_iflag = ICRNL | IXON,
  .c_oflag = OPOST | ONLCR,
@@ -2640,6 +2642,9 @@
 {
  char name[64];
  dev_t dev = MKDEV(driver->major, driver->minor_start) + index;
+ struct class_device *tty_dev;
+ struct tty_driver *console_driver;
+ int console_index;
 
  if (index >= driver->num) {
   printk(KERN_ERR "Attempt to register invalid tty line number "
@@ -2654,7 +2659,12 @@
   pty_line_name(driver, index, name);
  else
   tty_line_name(driver, index, name);
- class_simple_device_add(tty_class, dev, device, name);
+ tty_dev = class_simple_device_add(tty_class, dev, device, name);
+
+ console_driver = console_device(&console_index);
+ if ((console_driver == driver) && (console_index == index)) {
+  sysfs_create_link(&console_dev->kobj, &tty_dev->kobj, "real_dev");
+ }
 }
 
 /**
@@ -2921,7 +2931,8 @@
      register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
   panic("Couldn't register /dev/console driver\n");
  devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
- class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
+ console_dev = class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 1),
+   NULL, "console");
 
 #ifdef CONFIG_UNIX98_PTYS
  cdev_init(&ptmx_cdev, &ptmx_fops);
