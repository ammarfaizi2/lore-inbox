Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbRERU57>; Fri, 18 May 2001 16:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbRERU5u>; Fri, 18 May 2001 16:57:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26053 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261559AbRERU5e>;
	Fri, 18 May 2001 16:57:34 -0400
Date: Fri, 18 May 2001 16:57:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] videodev_init() -> initcall
Message-ID: <Pine.GSO.4.21.0105181651220.1896-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Alan, drivers/media/videodev.c is your code. See if you are OK
with the patch below - it switches the thing to use of module_init()
and removes the call of videodev_init() from chr_dev_init(). I.e. the
only ordering change is that videodev_init() is postponed until immediately
before the media/video/* drivers.
	Linus, if you are OK with that and Alan will ACK the thing - please,
consider applying it.
								Al


diff -urN S5-pre3/drivers/char/mem.c S5-pre3-videodev/drivers/char/mem.c
--- S5-pre3/drivers/char/mem.c	Wed May 16 16:26:36 2001
+++ S5-pre3-videodev/drivers/char/mem.c	Fri May 18 16:46:37 2001
@@ -29,9 +29,6 @@
 #ifdef CONFIG_I2C
 extern int i2c_init_all(void);
 #endif
-#ifdef CONFIG_VIDEO_DEV
-extern int videodev_init(void);
-#endif
 #ifdef CONFIG_FB
 extern void fbmem_init(void);
 #endif
@@ -647,9 +644,6 @@
 #endif
 #if defined(CONFIG_ADB)
 	adbdev_init();
-#endif
-#ifdef CONFIG_VIDEO_DEV
-	videodev_init();
 #endif
 	return 0;
 }
diff -urN S5-pre3/drivers/media/video/videodev.c S5-pre3-videodev/drivers/media/video/videodev.c
--- S5-pre3/drivers/media/video/videodev.c	Sun Apr  1 23:56:57 2001
+++ S5-pre3-videodev/drivers/media/video/videodev.c	Fri May 18 16:48:34 2001
@@ -546,7 +546,7 @@
  *	Initialise video for linux
  */
  
-int __init videodev_init(void)
+static int __init videodev_init(void)
 {
 	struct video_init *vfli = video_init_list;
 	
@@ -573,13 +573,7 @@
 	return 0;
 }
 
-#ifdef MODULE		
-int init_module(void)
-{
-	return videodev_init();
-}
-
-void cleanup_module(void)
+static void __exit videodev_exit(void)
 {
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 	videodev_proc_destroy ();
@@ -588,7 +582,8 @@
 	devfs_unregister_chrdev(VIDEO_MAJOR, "video_capture");
 }
 
-#endif
+module_init(videodev_init)
+module_exit(videodev_exit)
 
 EXPORT_SYMBOL(video_register_device);
 EXPORT_SYMBOL(video_unregister_device);

