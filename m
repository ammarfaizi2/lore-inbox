Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbTJQVsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 17:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbTJQVsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 17:48:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:10188 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263533AbTJQVsM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 17:48:12 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: online resizing of devices/filesystems (2.6)
Date: Fri, 17 Oct 2003 16:42:32 -0500
User-Agent: KMail/1.5
Cc: thornber@sistina.com, linux-kernel@vger.kernel.org
References: <200310171116.07362.kevcorry@us.ibm.com> <20031017130543.0e01d862.akpm@osdl.org> <200310171549.44589.kevcorry@us.ibm.com>
In-Reply-To: <200310171549.44589.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171642.32064.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 October 2003 15:49, Kevin Corry wrote:
> On Friday 17 October 2003 15:05, Andrew Morton wrote:
> > So one approach would be to do what NBD does, and just write i_size
> > directly.
>
> We had considered that originally. It just seemed like too big of a hack.
> :) Plus I wasn't sure if there were locking issues with changing fields in
> the inode.
>
> > You could create a little helper library function which takes i_sem and
> > then writes i_size.  But the VFS tends to avoid taking i_sem on blockdevs
> > because it doesn't expect i_size to change ;)
>
> So...should I take i_sem or not? :)  Perhaps calling i_size_write() in
> include/linux/fs.h would be preferrable, since it seems to be doing
> different things for SMP and preempt.
>
> Thanks for the feedback!

Here's a patch that takes bdev->bd_inode->i_sem, and then calls
i_size_write() to update the inode size. My initial tests have been
successful in resizing mounted reiser and xfs filesystems on
2.6.0-test7.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/


When setting the size of a Device-Mapper device in the gendisk entry, also try
to set the size of the corresponding block_device entry's inode. This is
necessary to allow online device/filesystem resizing to work correctly.

--- a/drivers/md/dm.c	9 Oct 2003 16:47:44 -0000
+++ b/drivers/md/dm.c	17 Oct 2003 21:06:01 -0000
@@ -726,6 +726,20 @@
 	up_write(&md->lock);
 }
 
+static void __set_size(struct gendisk *disk, sector_t size)
+{
+	struct block_device *bdev;
+
+	set_capacity(disk, size);
+	bdev = bdget_disk(disk, 0);
+	if (bdev) {
+		down(&bdev->bd_inode->i_sem);
+		i_size_write(bdev->bd_inode, size << SECTOR_SHIFT);
+		up(&bdev->bd_inode->i_sem);
+		bdput(bdev);
+	}
+}
+
 static int __bind(struct mapped_device *md, struct dm_table *t)
 {
 	request_queue_t *q = md->queue;
@@ -733,7 +747,7 @@
 	md->map = t;
 
 	size = dm_table_get_size(t);
-	set_capacity(md->disk, size);
+	__set_size(md->disk, size);
 	if (size == 0)
 		return 0;
 

