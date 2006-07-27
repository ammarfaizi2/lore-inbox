Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWG0M6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWG0M6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWG0M6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:58:54 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:36226 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1161016AbWG0M6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:58:52 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1G65Ok-0002fh-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Thu, 27 Jul 2006 14:55:30 +0200)
Subject: [PATCH 2/5] fuse: use jiffies_64
References: <E1G65Ok-0002fh-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1G65Rj-0002hJ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Jul 2006 14:58:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is entirely possible (though rare) that jiffies half-wraps around,
while a dentry/inode remains in the cache.  This could mean that the
dentry/inode is not invalidated for another half wraparound-time.

To get around this problem, use 64-bit jiffies.  The only problem with
this is that dentry->d_time is 32 bits on 32-bit archs.  So use
d_fsdata as the high 32 bits.  This is an ugly hack, but far simpler,
than having to allocate private data just for this purpose.

Since 64-bit jiffies can be assumed never to wrap around, simple
comparison can be used, and a zero time value can represent "invalid".

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-07-27 14:37:59.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-07-27 14:38:04.000000000 +0200
@@ -14,6 +14,33 @@
 #include <linux/sched.h>
 #include <linux/namei.h>
 
+#if BITS_PER_LONG >= 64
+static inline void fuse_dentry_settime(struct dentry *entry, u64 time)
+{
+	entry->d_time = time;
+}
+
+static inline u64 fuse_dentry_time(struct dentry *entry)
+{
+	return entry->d_time;
+}
+#else
+/*
+ * On 32 bit archs store the high 32 bits of time in d_fsdata
+ */
+static void fuse_dentry_settime(struct dentry *entry, u64 time)
+{
+	entry->d_time = time;
+	entry->d_fsdata = (void *) (unsigned long) (time >> 32);
+}
+
+static u64 fuse_dentry_time(struct dentry *entry)
+{
+	return (u64) entry->d_time +
+		((u64) (unsigned long) entry->d_fsdata << 32);
+}
+#endif
+
 /*
  * FUSE caches dentries and attributes with separate timeout.  The
  * time in jiffies until the dentry/attributes are valid is stored in
@@ -23,13 +50,13 @@
 /*
  * Calculate the time in jiffies until a dentry/attributes are valid
  */
-static unsigned long time_to_jiffies(unsigned long sec, unsigned long nsec)
+static u64 time_to_jiffies(unsigned long sec, unsigned long nsec)
 {
 	if (sec || nsec) {
 		struct timespec ts = {sec, nsec};
-		return jiffies + timespec_to_jiffies(&ts);
+		return get_jiffies_64() + timespec_to_jiffies(&ts);
 	} else
-		return jiffies - 1;
+		return 0;
 }
 
 /*
@@ -38,7 +65,8 @@ static unsigned long time_to_jiffies(uns
  */
 static void fuse_change_timeout(struct dentry *entry, struct fuse_entry_out *o)
 {
-	entry->d_time = time_to_jiffies(o->entry_valid, o->entry_valid_nsec);
+	fuse_dentry_settime(entry,
+		time_to_jiffies(o->entry_valid, o->entry_valid_nsec));
 	if (entry->d_inode)
 		get_fuse_inode(entry->d_inode)->i_time =
 			time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
@@ -50,7 +78,7 @@ static void fuse_change_timeout(struct d
  */
 void fuse_invalidate_attr(struct inode *inode)
 {
-	get_fuse_inode(inode)->i_time = jiffies - 1;
+	get_fuse_inode(inode)->i_time = 0;
 }
 
 /*
@@ -63,7 +91,7 @@ void fuse_invalidate_attr(struct inode *
  */
 static void fuse_invalidate_entry_cache(struct dentry *entry)
 {
-	entry->d_time = jiffies - 1;
+	fuse_dentry_settime(entry, 0);
 }
 
 /*
@@ -105,7 +133,7 @@ static int fuse_dentry_revalidate(struct
 
 	if (inode && is_bad_inode(inode))
 		return 0;
-	else if (time_after(jiffies, entry->d_time)) {
+	else if (fuse_dentry_time(entry) < get_jiffies_64()) {
 		int err;
 		struct fuse_entry_out outarg;
 		struct fuse_conn *fc;
@@ -669,7 +697,7 @@ static int fuse_revalidate(struct dentry
 	if (!fuse_allow_task(fc, current))
 		return -EACCES;
 	if (get_node_id(inode) != FUSE_ROOT_ID &&
-	    time_before_eq(jiffies, fi->i_time))
+	    fi->i_time >= get_jiffies_64())
 		return 0;
 
 	return fuse_do_getattr(inode);
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-07-27 14:35:14.000000000 +0200
+++ linux/fs/fuse/fuse_i.h	2006-07-27 14:38:04.000000000 +0200
@@ -59,7 +59,7 @@ struct fuse_inode {
 	struct fuse_req *forget_req;
 
 	/** Time in jiffies until the file attributes are valid */
-	unsigned long i_time;
+	u64 i_time;
 };
 
 /** FUSE specific file data */
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-07-27 14:35:15.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-07-27 14:38:04.000000000 +0200
@@ -51,7 +51,7 @@ static struct inode *fuse_alloc_inode(st
 		return NULL;
 
 	fi = get_fuse_inode(inode);
-	fi->i_time = jiffies - 1;
+	fi->i_time = 0;
 	fi->nodeid = 0;
 	fi->nlookup = 0;
 	fi->forget_req = fuse_request_alloc();
