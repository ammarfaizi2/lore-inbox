Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275472AbTHJFOR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 01:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275473AbTHJFOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 01:14:17 -0400
Received: from smtp01.web.de ([217.72.192.180]:55305 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S275472AbTHJFOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 01:14:14 -0400
Message-ID: <3F35D538.1040205@web.de>
Date: Sun, 10 Aug 2003 07:16:40 +0200
From: Stefan B <ChromosML@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ov511 2.6.0-test3
References: <200308092115.18501.linux@1g6.biz> <3F356BC6.9020904@web.de>
In-Reply-To: <3F356BC6.9020904@web.de>
Content-Type: multipart/mixed;
 boundary="------------010900090402060606030200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010900090402060606030200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stefan B. wrote:

> Try adding this to driver/media/video/videodev.c:
> (e.g. after the other EXPORT_SYMBOL lines)
> 
> void *video_proc_entry;
> EXPORT_SYMBOL(video_proc_entry);
> 

sorry, not good; this patch should do

--------------010900090402060606030200
Content-Type: text/plain;
 name="patch-2.6.0-test3-videoproc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.0-test3-videoproc"

diff -Nru drivers/media/video/videodev.c
--- drivers/media/video/videodev.c	Sun Aug 10 07:01:27 2003
+++ drivers/media/video/videodev.c	Sun Aug 10 07:05:37 2003
@@ -367,6 +367,8 @@
  *	Initialise video for linux
  */
  
+struct proc_dir_entry *video_proc_entry = NULL;
+
 static int __init videodev_init(void)
 {
 	printk(KERN_INFO "Linux video capture interface: v1.00\n");
@@ -375,11 +377,19 @@
 		return -EIO;
 	}
 	class_register(&video_class);
+	
+	video_proc_entry = create_proc_entry("video", S_IFDIR, &proc_root);
+	if (video_proc_entry)
+		video_proc_entry->owner = THIS_MODULE;
 	return 0;
 }
 
 static void __exit videodev_exit(void)
 {
+	if (video_proc_entry)
+		remove_proc_entry("video", &proc_root);
+	video_proc_entry = NULL;
+
 	class_unregister(&video_class);
 	unregister_chrdev(VIDEO_MAJOR, VIDEO_NAME);
 }
@@ -395,6 +405,7 @@
 EXPORT_SYMBOL(video_exclusive_release);
 EXPORT_SYMBOL(video_device_alloc);
 EXPORT_SYMBOL(video_device_release);
+EXPORT_SYMBOL(video_proc_entry);
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("Device registrar for Video4Linux drivers");

--------------010900090402060606030200--


