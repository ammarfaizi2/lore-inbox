Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWATQzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWATQzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWATQzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:55:05 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:43214 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751086AbWATQzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:55:03 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fuse: fix async read for legacy filesystems
Message-Id: <E1EzzX2-000305-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 Jan 2006 17:54:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This is a performance fix, that should go into 2.6.16.

Thanks
--

While asynchronous reads mean a performance improvement in most cases,
if the filesystem assumed that reads are synchronous, then async reads
may degrade performance (filesystem may receive reads out of order,
which can confuse it's own readahead logic).

With sshfs a 1.5 to 4 times slowdown can be measured.

There's also a need for userspace filesystems to know whether
asynchronous reads are supported by the kernel or not.

To achive these, negotiate in the INIT request whether async reads
will be used and the maximum readahead value.  Update interface
version to 7.6

If userspace uses a version earlier than 7.6, then disable async
reads, and set maximum readahead value to the maximum read size, as
done in previous versions.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-01-20 16:35:18.000000000 +0100
+++ linux/fs/fuse/file.c	2006-01-20 16:39:59.000000000 +0100
@@ -335,9 +335,14 @@ static void fuse_send_readpages(struct f
 	loff_t pos = page_offset(req->pages[0]);
 	size_t count = req->num_pages << PAGE_CACHE_SHIFT;
 	req->out.page_zeroing = 1;
-	req->end = fuse_readpages_end;
 	fuse_read_fill(req, file, inode, pos, count, FUSE_READ);
-	request_send_background(fc, req);
+	if (fc->async_read) {
+		req->end = fuse_readpages_end;
+		request_send_background(fc, req);
+	} else {
+		request_send(fc, req);
+		fuse_readpages_end(fc, req);
+	}
 }
 
 struct fuse_readpages_data {
Index: linux/fs/fuse/fuse_i.h
===================================================================
--- linux.orig/fs/fuse/fuse_i.h	2006-01-20 16:35:18.000000000 +0100
+++ linux/fs/fuse/fuse_i.h	2006-01-20 16:39:59.000000000 +0100
@@ -272,6 +272,9 @@ struct fuse_conn {
 	    reply, before any other request, and never cleared */
 	unsigned conn_error : 1;
 
+	/** Do readpages asynchronously?  Only set in INIT */
+	unsigned async_read : 1;
+
 	/*
 	 * The following bitfields are only for optimization purposes
 	 * and hence races in setting them will not cause malfunction
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-01-20 16:35:18.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-01-20 17:11:39.000000000 +0100
@@ -473,6 +473,16 @@ static void process_init_reply(struct fu
 	if (req->out.h.error || arg->major != FUSE_KERNEL_VERSION)
 		fc->conn_error = 1;
 	else {
+		unsigned long ra_pages;
+
+		if (arg->minor >= 6) {
+			ra_pages = arg->max_readahead / PAGE_CACHE_SIZE;
+			if (arg->flags & FUSE_ASYNC_READ)
+				fc->async_read = 1;
+		} else
+			ra_pages = fc->max_read / PAGE_CACHE_SIZE;
+
+		fc->bdi.ra_pages = min(fc->bdi.ra_pages, ra_pages);
 		fc->minor = arg->minor;
 		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
 	}
@@ -496,6 +506,8 @@ static void fuse_send_init(struct fuse_c
 
 	arg->major = FUSE_KERNEL_VERSION;
 	arg->minor = FUSE_KERNEL_MINOR_VERSION;
+	arg->max_readahead = fc->bdi.ra_pages * PAGE_CACHE_SIZE;
+	arg->flags |= FUSE_ASYNC_READ;
 	req->in.h.opcode = FUSE_INIT;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(*arg);
@@ -552,8 +564,6 @@ static int fuse_fill_super(struct super_
 	fc->user_id = d.user_id;
 	fc->group_id = d.group_id;
 	fc->max_read = d.max_read;
-	if (fc->max_read / PAGE_CACHE_SIZE < fc->bdi.ra_pages)
-		fc->bdi.ra_pages = fc->max_read / PAGE_CACHE_SIZE;
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2006-01-20 16:35:18.000000000 +0100
+++ linux/include/linux/fuse.h	2006-01-20 16:39:59.000000000 +0100
@@ -14,7 +14,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 5
+#define FUSE_KERNEL_MINOR_VERSION 6
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -58,6 +58,9 @@ struct fuse_kstatfs {
 	__u32	spare[6];
 };
 
+/**
+ * Bitmasks for fuse_setattr_in.valid
+ */
 #define FATTR_MODE	(1 << 0)
 #define FATTR_UID	(1 << 1)
 #define FATTR_GID	(1 << 2)
@@ -75,6 +78,11 @@ struct fuse_kstatfs {
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
 
+/**
+ * INIT request/reply flags
+ */
+#define FUSE_ASYNC_READ		(1 << 0)
+
 enum fuse_opcode {
 	FUSE_LOOKUP	   = 1,
 	FUSE_FORGET	   = 2,  /* no reply */
@@ -247,12 +255,16 @@ struct fuse_access_in {
 struct fuse_init_in {
 	__u32	major;
 	__u32	minor;
+	__u32	max_readahead;
+	__u32	flags;
 };
 
 struct fuse_init_out {
 	__u32	major;
 	__u32	minor;
-	__u32	unused[3];
+	__u32	max_readahead;
+	__u32	flags;
+	__u32	unused;
 	__u32	max_write;
 };
 
