Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWGGGf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWGGGf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 02:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWGGGf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 02:35:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49083 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751191AbWGGGf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 02:35:26 -0400
Date: Thu, 6 Jul 2006 23:35:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Bret Towe" <magnade@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1 bttv modprobe null pointer dereference
Message-Id: <20060706233521.686300d2.akpm@osdl.org>
In-Reply-To: <dda83e780607062219q1db55c58ga7eb1d5438635dcc@mail.gmail.com>
References: <dda83e780607062051x220841c7ya88ff0aefd5d3071@mail.gmail.com>
	<20060706215225.290360bf.akpm@osdl.org>
	<dda83e780607062219q1db55c58ga7eb1d5438635dcc@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 22:19:09 -0700
"Bret Towe" <magnade@gmail.com> wrote:

> > > Code: 4c 8b bf 48 01 00 00 48 8b bf c0 00 00 00 8b 5e 10 48 81 c7
> > > RIP  [<ffffffff802f1f9b>] sysfs_add_file+0x2b/0xb0
> > >  RSP <ffff81002ac71c28>
> > > CR2: 0000000000000149
> >
> > There don't seem to have been significant changes in bttv-driver.c for some
> > time, and we're seeing a few reports like this.  I'm suspecting that either
> > a sysfs/driver-core change was wrong, or previously wrong driver behaviour
> > is now causing oopses.
> >
> > And Mauro is offline until July 12.
> >
> > Can you send the .config please?
> 
> of course

I spent ten minutes and got lost.  I suspect videodev's class_device
handling is wrong, but I fail to spot it.

This might tell us something.

--- a/drivers/media/video/videodev.c~videodev-check-return-values
+++ a/drivers/media/video/videodev.c
@@ -1512,6 +1512,7 @@ int video_register_device(struct video_d
 	int i=0;
 	int base;
 	int end;
+	int ret;
 	char *name_base;
 
 	switch(type)
@@ -1571,9 +1572,19 @@ int video_register_device(struct video_d
 	vfd->class_dev.class       = &video_class;
 	vfd->class_dev.devt        = MKDEV(VIDEO_MAJOR, vfd->minor);
 	sprintf(vfd->class_dev.class_id, "%s%d", name_base, i - base);
-	class_device_register(&vfd->class_dev);
-	class_device_create_file(&vfd->class_dev,
-				&class_device_attr_name);
+	ret = class_device_register(&vfd->class_dev);
+	if (ret < 0) {
+		printk(KERN_ERR "%s: class_device_register() returned %d\n",
+			__FUNCTION__, ret);
+	} else {
+		ret = class_device_create_file(&vfd->class_dev,
+					&class_device_attr_name);
+		if (ret < 0) {
+			printk(KERN_ERR "%s: class_device_create_file() "
+					"returned %d\n", __FUNCTION__, ret);
+			class_device_unregister(&vfd->class_dev);
+		}
+	}
 
 #if 1
 	/* needed until all drivers are fixed */
@@ -1582,7 +1593,7 @@ int video_register_device(struct video_d
 		       "Please fix your driver for proper sysfs support, see "
 		       "http://lwn.net/Articles/36850/\n", vfd->name);
 #endif
-	return 0;
+	return ret;
 }
 
 /**
_

