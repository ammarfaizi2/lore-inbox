Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTHVRNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 13:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbTHVRNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 13:13:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:13031 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264981AbTHVRNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 13:13:32 -0400
Date: Fri, 22 Aug 2003 10:13:05 -0700
From: Greg KH <greg@kroah.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix bug in v4l core for 2.6.0-test3-bk
Message-ID: <20030822171305.GA9631@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When working on converting the usb v4l drivers to the new v4l class
changes, I ran into this nasty bug.  Seems that the core was using a
structure after it had been freed.  The patch below fixes it.

If you don't mind, I'll include it with some USB patches in a send to
Linus, as my USB fixes will not work without it.

thanks,

greg k-h


# V4L: fix use after free bug in v4l core.

diff -Nru a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
--- a/drivers/media/video/videodev.c	Fri Aug 22 10:09:38 2003
+++ b/drivers/media/video/videodev.c	Fri Aug 22 10:09:38 2003
@@ -349,9 +349,9 @@
 	if(video_device[vfd->minor]!=vfd)
 		panic("videodev: bad unregister");
 
-	class_device_unregister(&vfd->class_dev);
 	devfs_remove(vfd->devfs_name);
 	video_device[vfd->minor]=NULL;
+	class_device_unregister(&vfd->class_dev);
 	up(&videodev_lock);
 }
 
