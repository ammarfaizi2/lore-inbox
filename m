Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTH3Tzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 15:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbTH3Tzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 15:55:40 -0400
Received: from mail-8.tiscali.it ([195.130.225.154]:45627 "EHLO
	mail-8.tiscali.it") by vger.kernel.org with ESMTP id S262069AbTH3Tzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 15:55:39 -0400
Date: Sat, 30 Aug 2003 21:55:29 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: "Alan Cox" <alan@redhat.com>, kraxel@bytesex.org
Subject: [PATCH] Use after free in drivers/media/video/videodev.c
Message-ID: <20030830195529.GA15036@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I think that there's a bug in videdev.c. Look at
video_unregister_device:

void video_unregister_device(struct video_device *vfd) {
        [...]
        class_device_unregister(&vfd->class_dev);
        devfs_remove(vfd->devfs_name);
        video_device[vfd->minor]=NULL;
}

The class_device_unregister will  call video_release. This function will
call  a  ->release callback. As  far  as  I  can  see drivers  do  their
own cleanup  outside video_unregister_device so there is no problem.

However,  if  a  driver  switch to  dynamically  allocated  video_device
this  ->release  callback  will   free  the  struct  video_device  (look
at   video_device_release)   and   possibly  its   container. So   after
class_device_unregister vfd may be a pointer to deallocated memory.

I think that class_device_unregister should be moved down:

--- 2.6.0.orig/drivers/media/video/videodev.c	Tue Aug 12 17:02:29 2003
+++ 2.6.0/drivers/media/video/videodev.c	Sat Aug 30 21:13:29 2003
@@ -349,9 +349,9 @@
 	if(video_device[vfd->minor]!=vfd)
 		panic("videodev: bad unregister");
 
-	class_device_unregister(&vfd->class_dev);
 	devfs_remove(vfd->devfs_name);
 	video_device[vfd->minor]=NULL;
+	class_device_unregister(&vfd->class_dev);
 	up(&videodev_lock);
 }
 

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
The trouble with computers is that they do what you tell them,
not what you want.
D. Cohen
