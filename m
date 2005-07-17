Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbVGNSd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbVGNSd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbVGNSdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:33:24 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:53188 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263085AbVGNSbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:31:45 -0400
Message-Id: <200507141830.j6EIUue1020761@ms-smtp-02-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Sun, 17 Jul 2005 08:53:59 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc2-mm2 7/7] v9fs: debug and support routines (2.0.2)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [7/7] of the v9fs-2.0.2 patch against Linux 2.6.13-rc2-mm2.

This part of the patch contains debug and other misc routine changes related
to hch's comments.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

 ----------

 fs/9p/error.c    |    3 +--
 fs/9p/error.h    |    3 +++
 fs/9p/fid.c      |   14 ++++++++++----
 fs/9p/idpool.c   |  152 ----------------------------------------------------
 fs/9p/idpool.h   |   42 --------------
 6 files changed, 14 insertions(+), 200 deletions(-)

 ----------

--- a/fs/9p/error.h
+++ b/fs/9p/error.h
@@ -172,3 +172,6 @@ static struct errormap errmap[] = {
 	{"u9fs authnone: no authentication required", 0},
 	{NULL, -1}
 };
+
+extern int v9fs_error_init(void);
+extern int v9fs_errstr2errno(char *errstr);
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
--- a/fs/9p/error.c
+++ b/fs/9p/error.c
@@ -75,8 +75,7 @@ int v9fs_errstr2errno(char *errstr)
 	struct errormap *c = NULL;
 	int bucket = jhash(errstr, strlen(errstr), 0) % ERRHASHSZ;
 
-	hlist_for_each(p, &hash_errmap[bucket]) {
-		c = hlist_entry(p, struct errormap, list);
+	hlist_for_each_entry(c, p, &hash_errmap[bucket], list) {
 		if (!strcmp(c->name, errstr)) {
 			errno = c->val;
 			break;
diff --git a/fs/9p/error.h b/fs/9p/error.h
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -25,9 +25,9 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
@@ -123,7 +123,7 @@ struct v9fs_fid *v9fs_fid_lookup(struct 
 {
 	struct list_head *fid_list = (struct list_head *)dentry->d_fsdata;
 	struct v9fs_fid *current_fid = NULL;
-	struct list_head *p, *temp;
+	struct v9fs_fid *temp = NULL;
 	struct v9fs_fid *return_fid = NULL;
 	int found_parent = 0;
 	int found_user = 0;
@@ -132,8 +132,7 @@ struct v9fs_fid *v9fs_fid_lookup(struct 
 		type);
 
 	if (fid_list && !list_empty(fid_list)) {
-		list_for_each_safe(p, temp, fid_list) {
-			current_fid = list_entry(p, struct v9fs_fid, list);
+		list_for_each_entry_safe(current_fid, temp, fid_list, list) {
 			if (current_fid->uid == current->uid) {
 				if (return_fid == NULL) {
 					if ((type == FID_OP)
@@ -205,7 +204,14 @@ struct v9fs_fid *v9fs_fid_lookup(struct 
 			oldfid = current_fid->fid;
 			par = current->fs->pwd;
 			/* TODO: take advantage of multiwalk */
+
 			fidnum = v9fs_get_idpool(&v9ses->fidpool);
+			if(fidnum < 0) {
+				dprintk(DEBUG_ERROR,
+					"could not get a new fid num\n");
+				return return_fid;
+			}
+
 			while (par != dentry) {
 				result =
 				    v9fs_t_walk(v9ses, oldfid, fidnum, "..",

diff --git a/fs/9p/idpool.c b/fs/9p/idpool.c
deleted file mode 100644
--- a/fs/9p/idpool.c
+++ /dev/null
@@ -1,152 +0,0 @@
-/*
- *  linux/fs/9p/idpool.c
- *
- *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
- *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to:
- *  Free Software Foundation
- *  51 Franklin Street, Fifth Floor
- *  Boston, MA  02111-1301  USA
- *
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <asm/semaphore.h>
-#include <linux/config.h>
-#include "idpool.h"
-#include "debug.h"
-
-/**
- * grow_idpool - increase the size of an id pool
- * @i: pointer to idpool to initialize
- * @size: size (in bits) of idpool
- *
- */
-
-static int grow_idpool(struct idpool *i, int newsize)
-{
-	unsigned long *newpool;
-
-	newpool = kmalloc((newsize / 8), GFP_KERNEL);
-	if (!newpool) {
-		eprintk(KERN_WARNING,
-			"Couldn't allocate memory to grow idpool\n");
-		return 0;
-	}
-
-	memset(newpool, 0, newsize / 8);
-	if (i->idlist) {
-		memcpy(newpool, i->idlist, (i->maxalloc) / 8);
-		kfree(i->idlist);
-	}
-
-	i->idlist = newpool;
-	i->maxalloc = newsize;
-
-	return newsize;
-}
-
-/**
- * v9fs_alloc_idpool - allocate an id pool
- * @i: pointer to idpool to initialize
- * @size: size of idpool
- *
- */
-
-int v9fs_alloc_idpool(struct idpool *i, int size)
-{
-	int newsize;
-
-	init_MUTEX(&i->sem);
-	i->maxalloc = 0;
-	i->numalloc = 0;
-	i->lastfree = 0;
-	i->idlist = NULL;
-	newsize = grow_idpool(i, size);
-	return newsize;
-}
-
-/**
- * v9fs_free_idpool - deallocate an id pool
- * @i: pointer to idpool to free
- *
- */
-
-void v9fs_free_idpool(struct idpool *i)
-{
-	kfree(i->idlist);
-}
-
-/**
- * v9fs_get_idpool - get a new id from the pool
- * @i: pointer to idpool
- *
- */
-
-int v9fs_get_idpool(struct idpool *i)
-{
-	int nextbit;
-
-	if (down_interruptible(&i->sem) == -EINTR) {
-		eprintk(KERN_WARNING, "Interrupted while locking\n");
-		return -1;
-	}
-
-	nextbit = find_next_zero_bit(i->idlist, i->maxalloc, i->lastfree);
-	if (nextbit > i->maxalloc) {
-		if (grow_idpool(i, i->maxalloc * 2) == 0) {
-			up(&i->sem);
-			return -1;
-		} else {
-			nextbit =
-			    find_next_zero_bit(i->idlist, i->maxalloc,
-					       i->lastfree);
-		}
-	}
-
-	set_bit(nextbit, i->idlist);
-	if (i->lastfree == nextbit)
-		i->lastfree = nextbit + 1;
-
-	up(&i->sem);
-	return nextbit;
-}
-
-/**
- * v9fs_put_idpool - get a new id from the pool
- * @which: which id to put
- * @i: pointer to idpool
- *
- */
-
-void v9fs_put_idpool(int which, struct idpool *i)
-{
-	if ((which < 0) || (which > i->maxalloc)) {
-		return;
-	}
-
-	if (down_interruptible(&i->sem) == -EINTR) {
-		eprintk(KERN_WARNING, "Interrupted while locking\n");
-		return;
-	}
-
-	clear_bit(which, i->idlist);
-	if (which < i->lastfree)
-		i->lastfree = which;
-
-	up(&i->sem);
-}
diff --git a/fs/9p/idpool.h b/fs/9p/idpool.h
deleted file mode 100644
--- a/fs/9p/idpool.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- *  linux/fs/9p/idpool.h
- *
- *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
- *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to:
- *  Free Software Foundation
- *  51 Franklin Street, Fifth Floor
- *  Boston, MA  02111-1301  USA
- *
- */
-
-/*
- * This is for getting unique IDs.
- * 0 means free, non-zero means used.
- *
- */
-
-struct idpool {
-	struct semaphore sem;
-	int maxalloc;
-	int numalloc;
-	int lastfree;
-	unsigned long *idlist;
-};
-
-int v9fs_alloc_idpool(struct idpool *, int);
-void v9fs_free_idpool(struct idpool *);
-int v9fs_get_idpool(struct idpool *i);
-void v9fs_put_idpool(int which, struct idpool *i);
