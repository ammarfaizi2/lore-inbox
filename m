Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbWIVWaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWIVWaM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWIVWaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:30:12 -0400
Received: from vena.lwn.net ([206.168.112.25]:39316 "HELO lwn.net")
	by vger.kernel.org with SMTP id S965239AbWIVWaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:30:11 -0400
To: video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18 VIDIOC_ENUMSTD bug
From: Jonathan Corbet <corbet-v4l@lwn.net>
Date: Fri, 22 Sep 2006 16:30:10 -0600
Message-ID: <9890.1158964210@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The v4l2 API documentation for VIDIOC_ENUMSTD says:

	To enumerate all standards applications shall begin at index
	zero, incrementing by one until the driver returns EINVAL. 

The actual code, however, tests the index this way:

               if (index<=0 || index >= vfd->tvnormsize) {
                        ret=-EINVAL;

So any application which passes in index=0 gets EINVAL right off the bat
- and, in fact, this is what happens to mplayer.  So I think the
following patch is called for, and maybe even appropriate for a 2.6.18.x
stable release.  Disagreement?

jon

Signed-off-by: Jonathan Corbet <corbet@lwn.net>

--- /k/t/2.6.18-vanilla/drivers/media/video/videodev.c	2006-09-22 16:20:56.000000000 -0600
+++ 18-mont/drivers/media/video/videodev.c	2006-09-22 14:34:14.000000000 -0600
@@ -836,7 +836,7 @@ static int __video_do_ioctl(struct inode
 			break;
 		}
 
-		if (index<=0 || index >= vfd->tvnormsize) {
+		if (index < 0 || index >= vfd->tvnormsize) {
 			ret=-EINVAL;
 			break;
 		}

