Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWDMUgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWDMUgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWDMUf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:35:56 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:38166 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964975AbWDMUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:35:49 -0400
Date: Thu, 13 Apr 2006 16:35:47 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 08/08] dm: fix ordering of initialization in alloc_dev()
Message-ID: <20060413203547.GA3268@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 In alloc_dev(), we register the device with the block layer and then
 continue to initialize the device. register_disk() will have already
 made the device available to userspace, and a potential race exists
 with the device being opened for use and the completion of the
 initialization.

 This patch moves the final bits of the initialization above the disk
 registration.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
--
 drivers/md/dm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -ruNpX ../dontdiff linux-2.6.16-staging1/drivers/md/dm.c linux-2.6.16-staging2/drivers/md/dm.c
--- linux-2.6.16-staging1/drivers/md/dm.c	2006-04-13 16:18:24.000000000 -0400
+++ linux-2.6.16-staging2/drivers/md/dm.c	2006-04-13 16:18:24.000000000 -0400
@@ -837,6 +837,10 @@ static struct mapped_device *alloc_dev(u
 	if (!md->disk)
 		goto bad4;
 
+	atomic_set(&md->pending, 0);
+	init_waitqueue_head(&md->wait);
+	init_waitqueue_head(&md->eventq);
+
 	md->disk->major = _major;
 	md->disk->first_minor = minor;
 	md->disk->fops = &dm_blk_dops;
@@ -845,10 +849,6 @@ static struct mapped_device *alloc_dev(u
 	sprintf(md->disk->disk_name, "dm-%d", minor);
 	add_disk(md->disk);
 
-	atomic_set(&md->pending, 0);
-	init_waitqueue_head(&md->wait);
-	init_waitqueue_head(&md->eventq);
-
 	/* Populate the mapping, nobody knows we exist yet */
 	spin_lock(&_minor_lock);
 	r = idr_replace(&_minor_idr, md, minor);
