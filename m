Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUCVEOL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 23:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUCVEOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 23:14:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:51372 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261678AbUCVEOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 23:14:04 -0500
Date: Sun, 21 Mar 2004 20:13:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] error value for opening block devices
Message-Id: <20040321201358.6546423b.akpm@osdl.org>
In-Reply-To: <20040321195707.14a5a0f8.rddunlap@osdl.org>
References: <405C195B.10004@redhat.com>
	<20040321195707.14a5a0f8.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> [ENXIO]
>  The named file is a character special or block special file, and
>  the device associated with this special file does not exist.

Ho hum... It's chrdev_open which needs to be converted to return -ENXIO.

 25-akpm/fs/block_dev.c |    3 +--
 25-akpm/fs/char_dev.c  |    8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff -puN fs/char_dev.c~chrdev_open-retval-fix fs/char_dev.c
--- 25/fs/char_dev.c~chrdev_open-retval-fix	2004-03-21 20:10:02.961332256 -0800
+++ 25-akpm/fs/char_dev.c	2004-03-21 20:13:18.975533568 -0800
@@ -265,7 +265,7 @@ int chrdev_open(struct inode * inode, st
 		spin_unlock(&cdev_lock);
 		kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx);
 		if (!kobj)
-			return -ENODEV;
+			return -ENXIO;
 		new = container_of(kobj, struct cdev, kobj);
 		spin_lock(&cdev_lock);
 		p = inode->i_cdev;
@@ -275,9 +275,9 @@ int chrdev_open(struct inode * inode, st
 			list_add(&inode->i_devices, &p->list);
 			new = NULL;
 		} else if (!cdev_get(p))
-			ret = -ENODEV;
+			ret = -ENXIO;
 	} else if (!cdev_get(p))
-		ret = -ENODEV;
+		ret = -ENXIO;
 	spin_unlock(&cdev_lock);
 	cdev_put(new);
 	if (ret)
@@ -285,7 +285,7 @@ int chrdev_open(struct inode * inode, st
 	filp->f_op = fops_get(p->ops);
 	if (!filp->f_op) {
 		cdev_put(p);
-		return -ENODEV;
+		return -ENXIO;
 	}
 	if (filp->f_op->open) {
 		lock_kernel();
diff -puN fs/block_dev.c~chrdev_open-retval-fix fs/block_dev.c
--- 25/fs/block_dev.c~chrdev_open-retval-fix	2004-03-21 20:10:02.978329672 -0800
+++ 25-akpm/fs/block_dev.c	2004-03-21 20:13:29.843881328 -0800
@@ -550,7 +550,7 @@ static int do_open(struct block_device *
 {
 	struct module *owner = NULL;
 	struct gendisk *disk;
-	int ret = -ENODEV;
+	int ret = -ENXIO;
 	int part;
 
 	file->f_mapping = bdev->bd_inode->i_mapping;
@@ -563,7 +563,6 @@ static int do_open(struct block_device *
 	}
 	owner = disk->fops->owner;
 
-	ret = -ENXIO;
 	down(&bdev->bd_sem);
 	if (!bdev->bd_openers) {
 		bdev->bd_disk = disk;

_

