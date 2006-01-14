Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWANPPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWANPPA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWANPPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:15:00 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:3213 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751763AbWANPPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:15:00 -0500
Date: Sat, 14 Jan 2006 16:15:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       trond.myklebust@fys.uio.no
Subject: [patch 2.6.15-mm4] sem2mutex: NFS, idmap.c
Message-ID: <20060114151512.GB21978@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build and boot tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 fs/nfs/idmap.c |   42 ++++++++++++++++++++++--------------------
 1 files changed, 22 insertions(+), 20 deletions(-)

Index: linux/fs/nfs/idmap.c
===================================================================
--- linux.orig/fs/nfs/idmap.c
+++ linux/fs/nfs/idmap.c
@@ -35,6 +35,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -74,8 +76,8 @@ struct idmap {
 	struct dentry        *idmap_dentry;
 	wait_queue_head_t     idmap_wq;
 	struct idmap_msg      idmap_im;
-	struct semaphore      idmap_lock;    /* Serializes upcalls */
-	struct semaphore      idmap_im_lock; /* Protects the hashtable */
+	struct mutex          idmap_lock;    /* Serializes upcalls */
+	struct mutex          idmap_im_lock; /* Protects the hashtable */
 	struct idmap_hashtable idmap_user_hash;
 	struct idmap_hashtable idmap_group_hash;
 };
@@ -116,8 +118,8 @@ nfs_idmap_new(struct nfs4_client *clp)
 		return;
 	}
 
-        init_MUTEX(&idmap->idmap_lock);
-        init_MUTEX(&idmap->idmap_im_lock);
+        mutex_init(&idmap->idmap_lock);
+        mutex_init(&idmap->idmap_im_lock);
 	init_waitqueue_head(&idmap->idmap_wq);
 	idmap->idmap_user_hash.h_type = IDMAP_TYPE_USER;
 	idmap->idmap_group_hash.h_type = IDMAP_TYPE_GROUP;
@@ -232,8 +234,8 @@ nfs_idmap_id(struct idmap *idmap, struct
 	if (namelen >= IDMAP_NAMESZ)
 		return -EINVAL;
 
-	down(&idmap->idmap_lock);
-	down(&idmap->idmap_im_lock);
+	mutex_lock(&idmap->idmap_lock);
+	mutex_lock(&idmap->idmap_im_lock);
 
 	he = idmap_lookup_name(h, name, namelen);
 	if (he != NULL) {
@@ -259,11 +261,11 @@ nfs_idmap_id(struct idmap *idmap, struct
 	}
 
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	up(&idmap->idmap_im_lock);
+	mutex_unlock(&idmap->idmap_im_lock);
 	schedule();
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&idmap->idmap_wq, &wq);
-	down(&idmap->idmap_im_lock);
+	mutex_lock(&idmap->idmap_im_lock);
 
 	if (im->im_status & IDMAP_STATUS_SUCCESS) {
 		*id = im->im_id;
@@ -272,8 +274,8 @@ nfs_idmap_id(struct idmap *idmap, struct
 
  out:
 	memset(im, 0, sizeof(*im));
-	up(&idmap->idmap_im_lock);
-	up(&idmap->idmap_lock);
+	mutex_unlock(&idmap->idmap_im_lock);
+	mutex_unlock(&idmap->idmap_lock);
 	return (ret);
 }
 
@@ -293,8 +295,8 @@ nfs_idmap_name(struct idmap *idmap, stru
 
 	im = &idmap->idmap_im;
 
-	down(&idmap->idmap_lock);
-	down(&idmap->idmap_im_lock);
+	mutex_lock(&idmap->idmap_lock);
+	mutex_lock(&idmap->idmap_im_lock);
 
 	he = idmap_lookup_id(h, id);
 	if (he != 0) {
@@ -320,11 +322,11 @@ nfs_idmap_name(struct idmap *idmap, stru
 	}
 
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	up(&idmap->idmap_im_lock);
+	mutex_unlock(&idmap->idmap_im_lock);
 	schedule();
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&idmap->idmap_wq, &wq);
-	down(&idmap->idmap_im_lock);
+	mutex_lock(&idmap->idmap_im_lock);
 
 	if (im->im_status & IDMAP_STATUS_SUCCESS) {
 		if ((len = strnlen(im->im_name, IDMAP_NAMESZ)) == 0)
@@ -335,8 +337,8 @@ nfs_idmap_name(struct idmap *idmap, stru
 
  out:
 	memset(im, 0, sizeof(*im));
-	up(&idmap->idmap_im_lock);
-	up(&idmap->idmap_lock);
+	mutex_unlock(&idmap->idmap_im_lock);
+	mutex_unlock(&idmap->idmap_lock);
 	return ret;
 }
 
@@ -380,7 +382,7 @@ idmap_pipe_downcall(struct file *filp, c
         if (copy_from_user(&im_in, src, mlen) != 0)
 		return (-EFAULT);
 
-	down(&idmap->idmap_im_lock);
+	mutex_lock(&idmap->idmap_im_lock);
 
 	ret = mlen;
 	im->im_status = im_in.im_status;
@@ -440,7 +442,7 @@ idmap_pipe_downcall(struct file *filp, c
 		idmap_update_entry(he, im_in.im_name, namelen_in, im_in.im_id);
 	ret = mlen;
 out:
-	up(&idmap->idmap_im_lock);
+	mutex_unlock(&idmap->idmap_im_lock);
 	return ret;
 }
 
@@ -452,10 +454,10 @@ idmap_pipe_destroy_msg(struct rpc_pipe_m
 
 	if (msg->errno >= 0)
 		return;
-	down(&idmap->idmap_im_lock);
+	mutex_lock(&idmap->idmap_im_lock);
 	im->im_status = IDMAP_STATUS_LOOKUPFAIL;
 	wake_up(&idmap->idmap_wq);
-	up(&idmap->idmap_im_lock);
+	mutex_unlock(&idmap->idmap_im_lock);
 }
 
 /* 
