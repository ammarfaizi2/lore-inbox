Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVG2KxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVG2KxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVG2KxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:53:02 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:1811 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262574AbVG2Kwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:52:49 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] fuse: request counter overflow fix
Message-Id: <E1DySTi-0004pC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 29 Jul 2005 12:52:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a signed/unsigned comparison bug found by Franco Broi
after months of filesystem uptime and 2,147,483,648 performed fs
operations.

Since the request identifier is already 64 bits on the userspace ABI,
the counter is now made 64-bit too.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.13-rc3-mm1/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.13-rc3-mm1/fs/fuse/dev.c	2005-07-27 09:23:53.000000000 +0200
+++ linux-fuse/fs/fuse/dev.c	2005-07-27 09:29:01.000000000 +0200
@@ -669,7 +671,7 @@ static ssize_t fuse_dev_read(struct file
 }
 
 /* Look up request on processing list by unique ID */
-static struct fuse_req *request_find(struct fuse_conn *fc, unsigned unique)
+static struct fuse_req *request_find(struct fuse_conn *fc, u64 unique)
 {
 	struct list_head *entry;
 
diff -rup linux-2.6.13-rc3-mm1/fs/fuse/fuse_i.h linux-fuse/fs/fuse/fuse_i.h
--- linux-2.6.13-rc3-mm1/fs/fuse/fuse_i.h	2005-07-27 09:23:53.000000000 +0200
+++ linux-fuse/fs/fuse/fuse_i.h	2005-07-27 09:29:01.000000000 +0200
@@ -240,7 +240,7 @@ struct fuse_conn {
 	struct list_head unused_list;
 
 	/** The next unique request id */
-	int reqctr;
+	u64 reqctr;
 
 	/** Mount is active */
 	unsigned mounted : 1;
diff -rup linux-2.6.13-rc3-mm1/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.13-rc3-mm1/fs/fuse/inode.c	2005-07-27 09:23:53.000000000 +0200
+++ linux-fuse/fs/fuse/inode.c	2005-07-27 09:29:01.000000000 +0200
@@ -407,7 +417,7 @@ static struct fuse_conn *new_conn(void)
 		}
 		fc->bdi.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 		fc->bdi.unplug_io_fn = default_unplug_io_fn;
-		fc->reqctr = 1;
+		fc->reqctr = 0;
 	}
 	return fc;
 }
