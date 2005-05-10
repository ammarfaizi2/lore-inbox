Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVEJJCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVEJJCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 05:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVEJJCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 05:02:54 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:42001 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261581AbVEJJCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 05:02:21 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] FUSE: fix lookup/forget interface
Message-Id: <E1DVQcp-0007V1-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 10 May 2005 11:01:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the way in which the kernel notifies the userspace
filesystem that it has no more reference to a particular inode (FORGET
message).

The old way was to set inode's i_version after each successful LOOKUP
operation, and send this version in the FORGET message invoked from
the clear_inode() method.  If the userspace filesystem received a
FORGET with an old version, it discarded it.

The problem with this was that it was possible that two FORGETs would
be sent to userspace, and the filesystem would process them out of
order.  In this case the when processing the FORGET sent first, the
node is already deleted.  The only solution would be for the userspace
filesystem to somehow validate the node ID received in the FORGET.

It would be much better if the node ID was always valid.  So instead
of sending a version number in FORGET.  The number of lookups on an
inode is accounted by both the kernel and the userspace part.  A
FORGET is sent with the stored lookup number.  In userspace when a
node's lookup counter goes to zero, it can be deleted.  This mechanism
ensures that FORGETs processed out order do not cause a problem.

This change needs libfuse version 2.3-pre7 or later.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

 fs/fuse/dir.c        |   25 ++++++++++++-------------
 fs/fuse/fuse_i.h     |    7 +++++--
 fs/fuse/inode.c      |   15 +++++++++------
 include/linux/fuse.h |    4 ++--
 4 files changed, 28 insertions(+), 23 deletions(-)

diff -rup linux-2.6.12-rc3-mm3/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.12-rc3-mm3/fs/fuse/dir.c	2005-05-10 10:31:13.000000000 +0200
+++ linux-fuse/fs/fuse/dir.c	2005-05-10 10:31:51.000000000 +0200
@@ -42,7 +42,6 @@ static int fuse_dentry_revalidate(struct
 		return 0;
 	else if (time_after(jiffies, entry->d_time)) {
 		int err;
-		int version;
 		struct fuse_entry_out outarg;
 		struct inode *inode = entry->d_inode;
 		struct fuse_inode *fi = get_fuse_inode(inode);
@@ -53,15 +52,19 @@ static int fuse_dentry_revalidate(struct
 
 		fuse_lookup_init(req, entry->d_parent->d_inode, entry, &outarg);
 		request_send_nonint(fc, req);
-		version = req->out.h.unique;
 		err = req->out.h.error;
+		if (!err) {
+			if (outarg.nodeid != get_node_id(inode)) {
+				fuse_send_forget(fc, req, outarg.nodeid, 1);
+				return 0;
+			}
+			fi->nlookup ++;
+		}
 		fuse_put_request(fc, req);
-		if (err || outarg.nodeid != get_node_id(inode) ||
-		    (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
+		if (err || (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
 			return 0;
 
 		fuse_change_attributes(inode, &outarg.attr);
-		inode->i_version = version;
 		entry->d_time = time_to_jiffies(outarg.entry_valid,
 						outarg.entry_valid_nsec);
 		fi->i_time = time_to_jiffies(outarg.attr_valid,
@@ -78,7 +81,6 @@ static int fuse_lookup_iget(struct inode
 			    struct inode **inodep)
 {
 	int err;
-	int version;
 	struct fuse_entry_out outarg;
 	struct inode *inode = NULL;
 	struct fuse_conn *fc = get_fuse_conn(dir);
@@ -93,13 +95,12 @@ static int fuse_lookup_iget(struct inode
 
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
-	version = req->out.h.unique;
 	err = req->out.h.error;
 	if (!err) {
 		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
-				  &outarg.attr, version);
+				  &outarg.attr);
 		if (!inode) {
-			fuse_send_forget(fc, req, outarg.nodeid, version);
+			fuse_send_forget(fc, req, outarg.nodeid, 1);
 			return -ENOMEM;
 		}
 	}
@@ -138,7 +139,6 @@ static int create_new_entry(struct fuse_
 	struct fuse_entry_out outarg;
 	struct inode *inode;
 	struct fuse_inode *fi;
-	int version;
 	int err;
 
 	req->in.h.nodeid = get_node_id(dir);
@@ -147,16 +147,15 @@ static int create_new_entry(struct fuse_
 	req->out.args[0].size = sizeof(outarg);
 	req->out.args[0].value = &outarg;
 	request_send(fc, req);
-	version = req->out.h.unique;
 	err = req->out.h.error;
 	if (err) {
 		fuse_put_request(fc, req);
 		return err;
 	}
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
-			  &outarg.attr, version);
+			  &outarg.attr);
 	if (!inode) {
-		fuse_send_forget(fc, req, outarg.nodeid, version);
+		fuse_send_forget(fc, req, outarg.nodeid, 1);
 		return -ENOMEM;
 	}
 	fuse_put_request(fc, req);
diff -rup linux-2.6.12-rc3-mm3/fs/fuse/fuse_i.h linux-fuse/fs/fuse/fuse_i.h
--- linux-2.6.12-rc3-mm3/fs/fuse/fuse_i.h	2005-05-10 10:31:13.000000000 +0200
+++ linux-fuse/fs/fuse/fuse_i.h	2005-05-10 10:31:51.000000000 +0200
@@ -46,6 +46,9 @@ struct fuse_inode {
 	 * and kernel */
 	u64 nodeid;
 
+	/** Number of lookups on this inode */
+	u64 nlookup;
+
 	/** The request used for sending the FORGET message */
 	struct fuse_req *forget_req;
 
@@ -320,13 +323,13 @@ extern spinlock_t fuse_lock;
  * Get a filled in inode
  */
 struct inode *fuse_iget(struct super_block *sb, unsigned long nodeid,
-			int generation, struct fuse_attr *attr, int version);
+			int generation, struct fuse_attr *attr);
 
 /**
  * Send FORGET command
  */
 void fuse_send_forget(struct fuse_conn *fc, struct fuse_req *req,
-		      unsigned long nodeid, int version);
+		      unsigned long nodeid, u64 nlookup);
 
 /**
  * Send READ or READDIR request
diff -rup linux-2.6.12-rc3-mm3/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.12-rc3-mm3/fs/fuse/inode.c	2005-05-10 10:31:13.000000000 +0200
+++ linux-fuse/fs/fuse/inode.c	2005-05-10 10:31:51.000000000 +0200
@@ -48,6 +48,7 @@ static struct inode *fuse_alloc_inode(st
 	fi = get_fuse_inode(inode);
 	fi->i_time = jiffies - 1;
 	fi->nodeid = 0;
+	fi->nlookup = 0;
 	fi->forget_req = fuse_request_alloc();
 	if (!fi->forget_req) {
 		kmem_cache_free(fuse_inode_cachep, inode);
@@ -71,10 +72,10 @@ static void fuse_read_inode(struct inode
 }
 
 void fuse_send_forget(struct fuse_conn *fc, struct fuse_req *req,
-		      unsigned long nodeid, int version)
+		      unsigned long nodeid, u64 nlookup)
 {
 	struct fuse_forget_in *inarg = &req->misc.forget_in;
-	inarg->version = version;
+	inarg->nlookup = nlookup;
 	req->in.h.opcode = FUSE_FORGET;
 	req->in.h.nodeid = nodeid;
 	req->in.numargs = 1;
@@ -88,7 +89,7 @@ static void fuse_clear_inode(struct inod
 	if (inode->i_sb->s_flags & MS_ACTIVE) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
 		struct fuse_inode *fi = get_fuse_inode(inode);
-		fuse_send_forget(fc, fi->forget_req, fi->nodeid, inode->i_version);
+		fuse_send_forget(fc, fi->forget_req, fi->nodeid, fi->nlookup);
 		fi->forget_req = NULL;
 	}
 }
@@ -155,9 +156,10 @@ static int fuse_inode_set(struct inode *
 }
 
 struct inode *fuse_iget(struct super_block *sb, unsigned long nodeid,
-			int generation, struct fuse_attr *attr, int version)
+			int generation, struct fuse_attr *attr)
 {
 	struct inode *inode;
+	struct fuse_inode *fi;
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 	int retried = 0;
 
@@ -180,8 +182,9 @@ struct inode *fuse_iget(struct super_blo
 		goto retry;
 	}
 
+	fi = get_fuse_inode(inode);
+	fi->nlookup ++;
 	fuse_change_attributes(inode, attr);
-	inode->i_version = version;
 	return inode;
 }
 
@@ -440,7 +443,7 @@ static struct inode *get_root_inode(stru
 
 	attr.mode = mode;
 	attr.ino = FUSE_ROOT_ID;
-	return fuse_iget(sb, 1, 0, &attr, 0);
+	return fuse_iget(sb, 1, 0, &attr);
 }
 
 static struct dentry *fuse_get_dentry(struct super_block *sb, void *vobjp)
diff -rup linux-2.6.12-rc3-mm3/include/linux/fuse.h linux-fuse/include/linux/fuse.h
--- linux-2.6.12-rc3-mm3/include/linux/fuse.h	2005-05-10 10:31:21.000000000 +0200
+++ linux-fuse/include/linux/fuse.h	2005-05-10 10:31:51.000000000 +0200
@@ -11,7 +11,7 @@
 #include <asm/types.h>
 
 /** Version number of this interface */
-#define FUSE_KERNEL_VERSION 6
+#define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
 #define FUSE_KERNEL_MINOR_VERSION 1
@@ -113,7 +113,7 @@ struct fuse_entry_out {
 };
 
 struct fuse_forget_in {
-	__u64	version;
+	__u64	nlookup;
 };
 
 struct fuse_attr_out {
