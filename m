Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275607AbTHOBIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 21:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275619AbTHOBIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 21:08:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:8379 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275607AbTHOBI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 21:08:26 -0400
Date: Thu, 14 Aug 2003 18:09:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops during make install
Message-Id: <20030814180915.7b8d8580.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308142049070.15038-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0308142049070.15038-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cablespeed.com> wrote:
>
> I just got the following while doing make install from the latest bk pull.

loop bug.


diff -puN drivers/block/loop.c~loop-oops-fix drivers/block/loop.c
--- 25/drivers/block/loop.c~loop-oops-fix	2003-08-10 18:27:21.000000000 -0700
+++ 25-akpm/drivers/block/loop.c	2003-08-10 18:33:58.000000000 -0700
@@ -736,15 +736,6 @@ static int loop_set_fd(struct loop_devic
 
 	lo->lo_bio = lo->lo_biotail = NULL;
 
-	lo->lo_queue = blk_alloc_queue(GFP_KERNEL);
-	if (!lo->lo_queue) {
-		error = -ENOMEM;
-		fput(file);
-		goto out_putf;
-	}
-
-	disks[lo->lo_number]->queue = lo->lo_queue;
-
 	/*
 	 * set queue make_request_fn, and add limits based on lower level
 	 * device
@@ -858,7 +849,6 @@ static int loop_clr_fd(struct loop_devic
 	mapping_set_gfp_mask(filp->f_dentry->d_inode->i_mapping, gfp);
 	lo->lo_state = Lo_unbound;
 	fput(filp);
-	blk_put_queue(lo->lo_queue);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return 0;
@@ -1187,6 +1177,7 @@ int __init loop_init(void)
 	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
 	if (!loop_dev)
 		goto out_mem1;
+	memset(loop_dev, 0, max_loop * sizeof(struct loop_device));
 
 	disks = kmalloc(max_loop * sizeof(struct gendisk *), GFP_KERNEL);
 	if (!disks)
@@ -1203,7 +1194,12 @@ int __init loop_init(void)
 	for (i = 0; i < max_loop; i++) {
 		struct loop_device *lo = &loop_dev[i];
 		struct gendisk *disk = disks[i];
+
 		memset(lo, 0, sizeof(*lo));
+		lo->lo_queue = blk_alloc_queue(GFP_KERNEL);
+		if (!lo->lo_queue)
+			goto out_mem4;
+		disks[i]->queue = lo->lo_queue;
 		init_MUTEX(&lo->lo_ctl_mutex);
 		init_MUTEX_LOCKED(&lo->lo_sem);
 		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
@@ -1221,6 +1217,10 @@ int __init loop_init(void)
 	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
 	return 0;
 
+out_mem4:
+	while (i--)
+		blk_put_queue(loop_dev[i].lo_queue);
+	i = max_loop;
 out_mem3:
 	while (i--)
 		put_disk(disks[i]);
@@ -1238,6 +1238,7 @@ void loop_exit(void)
 	int i;
 
 	for (i = 0; i < max_loop; i++) {
+		blk_put_queue(loop_dev[i].lo_queue);
 		del_gendisk(disks[i]);
 		put_disk(disks[i]);
 	}

_

