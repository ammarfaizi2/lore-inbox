Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269541AbRHQDbV>; Thu, 16 Aug 2001 23:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269549AbRHQDbC>; Thu, 16 Aug 2001 23:31:02 -0400
Received: from zurich.ai.mit.edu ([18.43.0.244]:31757 "EHLO zurich.ai.mit.edu")
	by vger.kernel.org with ESMTP id <S269541AbRHQDaz> convert rfc822-to-8bit;
	Thu, 16 Aug 2001 23:30:55 -0400
To: mdharm-kernel@one-eyed-alien.net
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20010811222936.A13150@one-eyed-alien.net> (mdharm-kernel@one-eyed-alien.net)
Subject: Booting from USB floppy?
User-Agent: IMAIL/1.11; Edwin/3.110; MIT-Scheme/7.5.18.pre
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-Id: <E15XaL3-00039X-00@trixia.ai.mit.edu>
From: Chris Hanson <cph@zurich.ai.mit.edu>
Date: Thu, 16 Aug 2001 23:30:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sat, 11 Aug 2001 22:29:36 -0700
   From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>

   Some people have reported limited success by placing a multi-second delay
   just before the root fs is mounted, to give the USB system time to identify
   and properly attach the scsi devices.

Thanks for the information.

I've made some small changes that seem to work OK.  I've attached them
to this message, not to be submitted for inclusion in the kernel, but
just to have a public record of something that works, should someone
else be interested in this problem.

Chris

----------------------------------------------------------------------
diff -ruN linux-2.4.8-orig/drivers/block/rd.c linux-2.4.8/drivers/block/rd.c
--- linux-2.4.8-orig/drivers/block/rd.c	Sun Jul 15 19:15:44 2001
+++ linux-2.4.8/drivers/block/rd.c	Wed Aug 15 13:34:53 2001
@@ -704,11 +704,29 @@
 int swim3_fd_eject(int devnum);
 #endif
 
+#ifdef CONFIG_USB_STORAGE
+static void __init wait_for_usb_root_floppy(void)
+{
+	extern int blkdev_ops_exist(unsigned int);
+	long t;
+
+	while (!blkdev_ops_exist(MAJOR(ROOT_DEV)))
+		schedule_timeout(HZ);
+	/* Extra timeout for remaining messages.  */
+	t = 5*HZ;
+	while (t > 0)
+		t = schedule_timeout(t);
+}
+#endif
+
 static void __init rd_load_disk(int n)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
 	extern kdev_t real_root_dev;
 #endif
+#ifdef CONFIG_USB_STORAGE
+	extern int usb_root_floppy_p;
+#endif
 
 	if (rd_doload == 0)
 		return;
@@ -717,6 +735,9 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 		&& MAJOR(real_root_dev) != FLOPPY_MAJOR
 #endif
+#ifdef CONFIG_USB_STORAGE
+		&& !usb_root_floppy_p
+#endif
 	)
 		return;
 
@@ -729,6 +750,10 @@
 			swim3_fd_eject(MINOR(ROOT_DEV));
 		else if(MAJOR(real_root_dev) == FLOPPY_MAJOR)
 			swim3_fd_eject(MINOR(real_root_dev));
+#endif
+#ifdef CONFIG_USB_STORAGE
+		if (usb_root_floppy_p)
+			wait_for_usb_root_floppy();
 #endif
 		printk(KERN_NOTICE
 		       "VFS: Insert root floppy disk to be loaded into RAM disk and press ENTER\n");
diff -ruN linux-2.4.8-orig/fs/block_dev.c linux-2.4.8/fs/block_dev.c
--- linux-2.4.8-orig/fs/block_dev.c	Thu Aug  9 19:41:36 2001
+++ linux-2.4.8/fs/block_dev.c	Sun Aug 12 23:05:13 2001
@@ -517,6 +517,14 @@
 	return ret;
 }
 
+int blkdev_ops_exist(unsigned int major)
+{
+	/* major 0 is used for non-device mounts */
+	if (major && major < MAX_BLKDEV)
+		return (blkdevs[major].bdops != 0);
+	return 0;
+}
+
 int register_blkdev(unsigned int major, const char * name, struct block_device_operations *bdops)
 {
 	if (major == 0) {
diff -ruN linux-2.4.8-orig/init/main.c linux-2.4.8/init/main.c
--- linux-2.4.8-orig/init/main.c	Thu Jul  5 14:31:58 2001
+++ linux-2.4.8/init/main.c	Sun Aug 12 23:05:13 2001
@@ -124,6 +124,10 @@
 kdev_t real_root_dev;
 #endif
 
+#ifdef CONFIG_USB_STORAGE
+int usb_root_floppy_p = 0;
+#endif
+
 int root_mountflags = MS_RDONLY;
 char *execute_command;
 char root_device_name[64];
@@ -303,6 +307,20 @@
 }
 
 __setup("root=", root_dev_setup);
+
+#ifdef CONFIG_USB_STORAGE
+
+static int __init usb_root_floppy_setup(char *line)
+{
+	extern int usb_root_floppy_p;
+	root_dev_setup (line);
+	usb_root_floppy_p = 1;
+	return 1;
+}
+
+__setup("usb_root_floppy=", usb_root_floppy_setup);
+
+#endif
 
 static int __init checksetup(char *line)
 {
