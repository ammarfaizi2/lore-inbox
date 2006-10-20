Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423305AbWJTWre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423305AbWJTWre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423306AbWJTWre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:47:34 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:60777 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423305AbWJTWrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:47:33 -0400
Date: Fri, 20 Oct 2006 15:47:21 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org, joel.becker@oracle.com
Subject: [git patches] ocfs2 and configfs fixes
Message-ID: <20061020224721.GI10128@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a small set of fixes this time.

Please pull from 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git upstream-linus

to receive the following updates:

 fs/configfs/file.c             |   14 ++++++-----
 fs/ocfs2/cluster/nodemanager.c |   10 ++++----
 fs/ocfs2/file.c                |   51 ++++++++++++++++++++++++-----------------
 fs/ocfs2/namei.c               |    8 ------
 4 files changed, 45 insertions(+), 38 deletions(-)

Akinobu Mita:
      ocfs2: delete redundant memcmp()

Chandra Seetharaman:
      configfs: handle kzalloc() failure in check_perm()

Mark Fasheh:
      ocfs2: fix page zeroing during simple extends
      ocfs2: cond_resched() in ocfs2_zero_extend()

Sunil Mushran:
      ocfs2: remove spurious d_count check in ocfs2_rename()

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index e6d5754..cf33fac 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -275,13 +275,14 @@ static int check_perm(struct inode * ino
 	 * it in file->private_data for easy access.
 	 */
 	buffer = kzalloc(sizeof(struct configfs_buffer),GFP_KERNEL);
-	if (buffer) {
-		init_MUTEX(&buffer->sem);
-		buffer->needs_read_fill = 1;
-		buffer->ops = ops;
-		file->private_data = buffer;
-	} else
+	if (!buffer) {
 		error = -ENOMEM;
+		goto Enomem;
+	}
+	init_MUTEX(&buffer->sem);
+	buffer->needs_read_fill = 1;
+	buffer->ops = ops;
+	file->private_data = buffer;
 	goto Done;
 
  Einval:
@@ -289,6 +290,7 @@ static int check_perm(struct inode * ino
 	goto Done;
  Eaccess:
 	error = -EACCES;
+ Enomem:
 	module_put(attr->ca_owner);
  Done:
 	if (error && item)
diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index e1fceb8..d11753c 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -152,14 +152,16 @@ static struct o2nm_node *o2nm_node_ip_tr
 	struct o2nm_node *node, *ret = NULL;
 
 	while (*p) {
+		int cmp;
+
 		parent = *p;
 		node = rb_entry(parent, struct o2nm_node, nd_ip_node);
 
-		if (memcmp(&ip_needle, &node->nd_ipv4_address,
-		           sizeof(ip_needle)) < 0)
+		cmp = memcmp(&ip_needle, &node->nd_ipv4_address,
+				sizeof(ip_needle));
+		if (cmp < 0)
 			p = &(*p)->rb_left;
-		else if (memcmp(&ip_needle, &node->nd_ipv4_address,
-			        sizeof(ip_needle)) > 0)
+		else if (cmp > 0)
 			p = &(*p)->rb_right;
 		else {
 			ret = node;
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index d9ba0a9..1be74c4 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -30,6 +30,7 @@ #include <linux/slab.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/uio.h>
+#include <linux/sched.h>
 
 #define MLOG_MASK_PREFIX ML_INODE
 #include <cluster/masklog.h>
@@ -691,6 +692,12 @@ static int ocfs2_zero_extend(struct inod
 		}
 
 		start_off += sb->s_blocksize;
+
+		/*
+		 * Very large extends have the potential to lock up
+		 * the cpu for extended periods of time.
+		 */
+		cond_resched();
 	}
 
 out:
@@ -728,31 +735,36 @@ static int ocfs2_extend_file(struct inod
 	clusters_to_add = ocfs2_clusters_for_bytes(inode->i_sb, new_i_size) - 
 		OCFS2_I(inode)->ip_clusters;
 
-	if (clusters_to_add) {
-		/* 
-		 * protect the pages that ocfs2_zero_extend is going to
-		 * be pulling into the page cache.. we do this before the
-		 * metadata extend so that we don't get into the situation
-		 * where we've extended the metadata but can't get the data
-		 * lock to zero.
-		 */
-		ret = ocfs2_data_lock(inode, 1);
-		if (ret < 0) {
-			mlog_errno(ret);
-			goto out;
-		}
+	/* 
+	 * protect the pages that ocfs2_zero_extend is going to be
+	 * pulling into the page cache.. we do this before the
+	 * metadata extend so that we don't get into the situation
+	 * where we've extended the metadata but can't get the data
+	 * lock to zero.
+	 */
+	ret = ocfs2_data_lock(inode, 1);
+	if (ret < 0) {
+		mlog_errno(ret);
+		goto out;
+	}
 
+	if (clusters_to_add) {
 		ret = ocfs2_extend_allocation(inode, clusters_to_add);
 		if (ret < 0) {
 			mlog_errno(ret);
 			goto out_unlock;
 		}
+	}
 
-		ret = ocfs2_zero_extend(inode, (u64)new_i_size - tail_to_skip);
-		if (ret < 0) {
-			mlog_errno(ret);
-			goto out_unlock;
-		}
+	/*
+	 * Call this even if we don't add any clusters to the tree. We
+	 * still need to zero the area between the old i_size and the
+	 * new i_size.
+	 */
+	ret = ocfs2_zero_extend(inode, (u64)new_i_size - tail_to_skip);
+	if (ret < 0) {
+		mlog_errno(ret);
+		goto out_unlock;
 	}
 
 	if (!tail_to_skip) {
@@ -764,8 +776,7 @@ static int ocfs2_extend_file(struct inod
 	}
 
 out_unlock:
-	if (clusters_to_add) /* this is the only case in which we lock */
-		ocfs2_data_unlock(inode, 1);
+	ocfs2_data_unlock(inode, 1);
 
 out:
 	return ret;
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 259155f..a57b751 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1085,14 +1085,6 @@ static int ocfs2_rename(struct inode *ol
 			BUG();
 	}
 
-	if (atomic_read(&old_dentry->d_count) > 2) {
-		shrink_dcache_parent(old_dentry);
-		if (atomic_read(&old_dentry->d_count) > 2) {
-			status = -EBUSY;
-			goto bail;
-		}
-	}
-
 	/* Assume a directory heirarchy thusly:
 	 * a/b/c
 	 * a/d
