Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTIQPg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 11:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTIQPg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 11:36:26 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:20414 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262782AbTIQPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 11:36:22 -0400
From: Angus Sawyer <angus.sawyer@dsl.pipex.com>
Reply-To: angus.sawyer@dsl.pipex.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] loop driver kernel thread module reference fix
Date: Wed, 17 Sep 2003 16:28:53 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309171628.55240.angus.sawyer@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the loop driver does not hold module references for the kernel_thread, and 
does not appear to wait for thread termination at any point.  

This patch associates the ref counting with the kernel thread which covers
the existing set/clear fd interval.

Hope this is OK.

 drivers/block/loop.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff -puN drivers/block/loop.c~loop drivers/block/loop.c
--- linux-2.6.0-test5/drivers/block/loop.c~loop	2003-09-17 16:16:19.447291752 
+0100
+++ linux-2.6.0-test5-angus/drivers/block/loop.c	2003-09-17 16:25:55.103778664 
+0100
@@ -651,7 +651,7 @@ static int loop_thread(void *data)
 	}
 
 	up(&lo->lo_sem);
-	return 0;
+	module_put_and_exit(0);
 }
 
 static int loop_set_fd(struct loop_device *lo, struct file *lo_file,
@@ -664,9 +664,6 @@ static int loop_set_fd(struct loop_devic
 	int		lo_flags = 0;
 	int		error;
 
-	/* This is safe, since we have a reference from open(). */
-	__module_get(THIS_MODULE);
-
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
 		goto out;
@@ -757,6 +754,8 @@ static int loop_set_fd(struct loop_devic
 		blk_queue_merge_bvec(lo->lo_queue, q->merge_bvec_fn);
 	}
 
+	/* This is safe, since we have a reference from open(). */
+	__module_get(THIS_MODULE);
 	kernel_thread(loop_thread, lo, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
 	down(&lo->lo_sem);
 
@@ -767,7 +766,6 @@ static int loop_set_fd(struct loop_devic
 	fput(file);
  out:
 	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	return error;
 }
 
@@ -849,8 +847,6 @@ static int loop_clr_fd(struct loop_devic
 	mapping_set_gfp_mask(filp->f_dentry->d_inode->i_mapping, gfp);
 	lo->lo_state = Lo_unbound;
 	fput(filp);
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	return 0;
 }
 

_

