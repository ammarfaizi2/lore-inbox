Return-Path: <linux-kernel-owner+w=401wt.eu-S932524AbXARV4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbXARV4H (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbXARV4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:56:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3717 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932524AbXARVzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:55:49 -0500
Date: Thu, 18 Jan 2007 22:55:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jsipek@cs.sunysb.edu
Cc: linux-kernel@vger.kernel.org, unionfs@filesystems.org
Subject: [-mm patch] fs/unionfs/: possible cleanups
Message-ID: <20070118215554.GG9093@stusta.de>
References: <20070111222627.66bb75ab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111222627.66bb75ab.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
>...
> - Added the unionfs filesystem driver as git-unionfs.patch (Josef "Jeff"
>   Sipek <jsipek@cs.sunysb.edu>)
>...
> Changes since 2.6.20-rc3-mm1:
>...
>  git-unionfs.patch
>...
>  git trees
>...


Let's start with a small exercise:

Consider sparse tells you about a global function:
  warning: symbol 'unionfs_d_revalidate_wrap' was not declared. Should 
  it be static?

I'll give three possible solutions, spot the one that is always wrong:

1. make the function static
2. add a prototype in a header file
3. add a prototype in the C file

If you need a hint, look at what the patch below removes...


<--  snip  -->


This patch contains the following possible cleanups:
- every function should #include the headers containing the prototypes
  of it's global functions
- static functions in C files shouldn't be marked "inline", gcc should 
  know best when to inline them
- make needlessly global code static
- #if 0 the following unused global function:
  - stale_inode.c: is_stale_inode()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/unionfs/commonfops.c  |    6 +--
 fs/unionfs/copyup.c      |   59 +++++++++++++++++++++------------------
 fs/unionfs/dentry.c      |   11 +------
 fs/unionfs/file.c        |   17 +++--------
 fs/unionfs/inode.c       |   19 ++++--------
 fs/unionfs/main.c        |    4 +-
 fs/unionfs/rdstate.c     |    2 -
 fs/unionfs/sioq.c        |    2 -
 fs/unionfs/sioq.h        |    1 
 fs/unionfs/stale_inode.c |    9 +++--
 fs/unionfs/union.h       |   13 --------
 11 files changed, 60 insertions(+), 83 deletions(-)

--- linux-2.6.20-rc4-mm1/fs/unionfs/union.h.old	2007-01-18 21:02:45.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/union.h	2007-01-18 21:32:42.000000000 +0100
@@ -241,11 +241,6 @@
 /* replicates the directory structure upto given dentry in given branch */
 extern struct dentry *create_parents(struct inode *dir, struct dentry *dentry,
 				     int bindex);
-struct dentry *create_parents_named(struct inode *dir, struct dentry *dentry,
-				    const char *name, int bindex);
-
-/* check if two branches overlap */
-extern int is_branch_overlap(struct dentry *dent1, struct dentry *dent2);
 
 /* partial lookup */
 extern int unionfs_partial_lookup(struct dentry *dentry);
@@ -265,10 +260,6 @@
 /* copies a dentry from dbstart to newbindex branch */
 extern int copyup_dentry(struct inode *dir, struct dentry *dentry, int bstart,
 			 int new_bindex, struct file **copyup_file, loff_t len);
-extern int copyup_named_dentry(struct inode *dir, struct dentry *dentry,
-			       int bstart, int new_bindex, const char *name,
-			       int namelen, struct file **copyup_file,
-			       loff_t len);
 
 extern int remove_whiteouts(struct dentry *dentry, struct dentry *hidden_dentry,
 			    int bindex);
@@ -325,9 +316,6 @@
 int unionfs_ioctl_queryfile(struct file *file, unsigned int cmd,
 			    unsigned long arg);
 
-/* Verify that a branch is valid. */
-int check_branch(struct nameidata *nd);
-
 #ifdef CONFIG_UNION_FS_XATTR
 /* Extended attribute functions. */
 extern void *unionfs_xattr_alloc(size_t size, size_t limit);
@@ -395,7 +383,6 @@
 }
 
 struct dentry *unionfs_lookup_backend(struct dentry *dentry, struct nameidata *nd, int lookupmode);
-int is_stale_inode(struct inode *inode);
 void make_stale_inode(struct inode *inode);
 
 #define IS_SET(sb, check_flag) ((check_flag) & MOUNT_FLAG(sb))
--- linux-2.6.20-rc4-mm1/fs/unionfs/copyup.c.old	2007-01-18 21:03:05.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/copyup.c	2007-01-18 21:35:33.000000000 +0100
@@ -18,6 +18,14 @@
 
 #include "union.h"
 
+static int copyup_named_dentry(struct inode *dir, struct dentry *dentry,
+			       int bstart, int new_bindex, const char *name,
+			       int namelen, struct file **copyup_file,
+			       loff_t len);
+static struct dentry *create_parents_named(struct inode *dir,
+					   struct dentry *dentry,
+					   const char *name, int bindex);
+
 #ifdef CONFIG_UNION_FS_XATTR
 /* copyup all extended attrs for a given dentry */
 static int copyup_xattrs(struct dentry *old_hidden_dentry,
@@ -129,10 +137,10 @@
  * if the object being copied up is a regular file, the file is only created,
  * the contents have to be copied up separately
  */
-static inline int __copyup_ndentry(struct dentry *old_hidden_dentry,
-				   struct dentry *new_hidden_dentry,
-				   struct dentry *new_hidden_parent_dentry,
-				   char *symbuf)
+static int __copyup_ndentry(struct dentry *old_hidden_dentry,
+			    struct dentry *new_hidden_dentry,
+			    struct dentry *new_hidden_parent_dentry,
+			    char *symbuf)
 {
 	int err = 0;
 	umode_t old_mode = old_hidden_dentry->d_inode->i_mode;
@@ -179,13 +187,10 @@
 	return err;
 }
 
-static inline int __copyup_reg_data(struct dentry *dentry,
-				    struct dentry *new_hidden_dentry,
-				    int new_bindex,
-				    struct dentry *old_hidden_dentry,
-				    int old_bindex,
-				    struct file **copyup_file,
-				    loff_t len)
+static int __copyup_reg_data(struct dentry *dentry,
+			     struct dentry *new_hidden_dentry, int new_bindex,
+			     struct dentry *old_hidden_dentry, int old_bindex,
+			     struct file **copyup_file, loff_t len)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct file *input_file;
@@ -300,11 +305,9 @@
 /* dput the lower references for old and new dentry & clear a lower dentry
  * pointer
  */
-static inline void __clear(struct dentry *dentry,
-			   struct dentry *old_hidden_dentry,
-			   int old_bstart, int old_bend,
-			   struct dentry *new_hidden_dentry,
-			   int new_bindex)
+static void __clear(struct dentry *dentry, struct dentry *old_hidden_dentry,
+		    int old_bstart, int old_bend,
+		    struct dentry *new_hidden_dentry, int new_bindex)
 {
 	/* get rid of the hidden dentry and all its traces */
 	unionfs_set_lower_dentry_idx(dentry, new_bindex, NULL);
@@ -316,9 +319,10 @@
 }
 
 /* copy up a dentry to a file of specified name */
-int copyup_named_dentry(struct inode *dir, struct dentry *dentry,
-			int bstart, int new_bindex, const char *name,
-			int namelen, struct file **copyup_file, loff_t len)
+static int copyup_named_dentry(struct inode *dir, struct dentry *dentry,
+			       int bstart, int new_bindex, const char *name,
+			       int namelen, struct file **copyup_file,
+			       loff_t len)
 {
 	struct dentry *new_hidden_dentry;
 	struct dentry *old_hidden_dentry = NULL;
@@ -510,8 +514,8 @@
 	return create_parents_named(dir, dentry, dentry->d_name.name, bindex);
 }
 
-static inline void __cleanup_dentry(struct dentry * dentry, int bindex,
-					int old_bstart, int old_bend)
+static void __cleanup_dentry(struct dentry * dentry, int bindex,
+			     int old_bstart, int old_bend)
 {
 	int loop_start;
 	int loop_end;
@@ -557,8 +561,8 @@
 }
 
 /* set lower inode ptr and update bstart & bend if necessary */
-static inline void __set_inode(struct dentry * upper, struct dentry * lower,
-				int bindex)
+static void __set_inode(struct dentry * upper, struct dentry * lower,
+			int bindex)
 {
 	unionfs_set_lower_inode_idx(upper->d_inode, bindex,
 			igrab(lower->d_inode));
@@ -570,8 +574,8 @@
 }
 
 /* set lower dentry ptr and update bstart & bend if necessary */
-static inline void __set_dentry(struct dentry * upper, struct dentry * lower,
-				int bindex)
+static void __set_dentry(struct dentry * upper, struct dentry * lower,
+			 int bindex)
 {
 	unionfs_set_lower_dentry_idx(upper, bindex, lower);
 	if (likely(dbstart(upper) > bindex))
@@ -583,8 +587,9 @@
 /* This function replicates the directory structure upto given dentry
  * in the bindex branch.
  */
-struct dentry *create_parents_named(struct inode *dir, struct dentry *dentry,
-				    const char *name, int bindex)
+static struct dentry *create_parents_named(struct inode *dir,
+					   struct dentry *dentry,
+					   const char *name, int bindex)
 {
 	int err;
 	struct dentry *child_dentry;
--- linux-2.6.20-rc4-mm1/fs/unionfs/dentry.c.old	2007-01-18 21:15:30.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/dentry.c	2007-01-18 21:21:21.000000000 +0100
@@ -18,12 +18,6 @@
 
 #include "union.h"
 
-/* declarations added for "sparse" */
-extern int unionfs_d_revalidate_wrap(struct dentry *dentry,
-				     struct nameidata *nd);
-extern void unionfs_d_release(struct dentry *dentry);
-extern void unionfs_d_iput(struct dentry *dentry, struct inode *inode);
-
 /*
  * returns 1 if valid, 0 otherwise.
  */
@@ -180,7 +174,8 @@
 	return valid;
 }
 
-int unionfs_d_revalidate_wrap(struct dentry *dentry, struct nameidata *nd)
+static int unionfs_d_revalidate_wrap(struct dentry *dentry,
+				     struct nameidata *nd)
 {
 	int err;
 
@@ -191,7 +186,7 @@
 	return err;
 }
 
-void unionfs_d_release(struct dentry *dentry)
+static void unionfs_d_release(struct dentry *dentry)
 {
 	int bindex, bstart, bend;
 
--- linux-2.6.20-rc4-mm1/fs/unionfs/file.c.old	2007-01-18 21:21:45.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/file.c	2007-01-18 21:23:51.000000000 +0100
@@ -18,11 +18,6 @@
 
 #include "union.h"
 
-/* declarations for sparse */
-extern ssize_t unionfs_read(struct file *, char __user *, size_t, loff_t *);
-extern ssize_t unionfs_write(struct file *, const char __user *, size_t,
-			     loff_t *);
-
 /*******************
  * File Operations *
  *******************/
@@ -56,8 +51,8 @@
 	return err;
 }
 
-ssize_t unionfs_read(struct file * file, char __user * buf, size_t count,
-		     loff_t * ppos)
+static ssize_t unionfs_read(struct file * file, char __user * buf,
+			    size_t count, loff_t * ppos)
 {
 	struct file *hidden_file;
 	loff_t pos = *ppos;
@@ -78,8 +73,8 @@
 	return err;
 }
 
-ssize_t __unionfs_write(struct file * file, const char __user * buf,
-			size_t count, loff_t * ppos)
+static ssize_t __unionfs_write(struct file * file, const char __user * buf,
+			       size_t count, loff_t * ppos)
 {
 	int err = -EINVAL;
 	struct file *hidden_file = NULL;
@@ -123,8 +118,8 @@
 	return err;
 }
 
-ssize_t unionfs_write(struct file * file, const char __user * buf, size_t count,
-		      loff_t * ppos)
+static ssize_t unionfs_write(struct file * file, const char __user * buf,
+			     size_t count, loff_t * ppos)
 {
 	int err = 0;
 
--- linux-2.6.20-rc4-mm1/fs/unionfs/inode.c.old	2007-01-18 21:28:17.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/inode.c	2007-01-18 21:29:43.000000000 +0100
@@ -18,14 +18,6 @@
 
 #include "union.h"
 
-/* declarations added for "sparse" */
-extern struct dentry *unionfs_lookup(struct inode *, struct dentry *,
-				     struct nameidata *);
-extern int unionfs_readlink(struct dentry *dentry, char __user * buf,
-			    int bufsiz);
-extern void unionfs_put_link(struct dentry *dentry, struct nameidata *nd,
-			     void *cookie);
-
 static int unionfs_create(struct inode *parent, struct dentry *dentry,
 			  int mode, struct nameidata *nd)
 {
@@ -195,8 +187,9 @@
 	return err;
 }
 
-struct dentry *unionfs_lookup(struct inode *parent, struct dentry *dentry,
-			      struct nameidata *nd)
+static struct dentry *unionfs_lookup(struct inode *parent,
+				     struct dentry *dentry,
+				     struct nameidata *nd)
 {
 	struct nameidata lowernd; /* TODO: be gentler to the stack */
 
@@ -688,7 +681,8 @@
 	return err;
 }
 
-int unionfs_readlink(struct dentry *dentry, char __user * buf, int bufsiz)
+static int unionfs_readlink(struct dentry *dentry, char __user * buf,
+			    int bufsiz)
 {
 	int err;
 	struct dentry *hidden_dentry;
@@ -743,7 +737,8 @@
 	return ERR_PTR(err);
 }
 
-void unionfs_put_link(struct dentry *dentry, struct nameidata *nd, void *cookie)
+static void unionfs_put_link(struct dentry *dentry, struct nameidata *nd,
+			     void *cookie)
 {
 	kfree(nd_get_link(nd));
 }
--- linux-2.6.20-rc4-mm1/fs/unionfs/main.c.old	2007-01-18 21:30:34.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/main.c	2007-01-18 21:31:05.000000000 +0100
@@ -188,7 +188,7 @@
  * 2) it exists
  * 3) is a directory
  */
-int check_branch(struct nameidata *nd)
+static int check_branch(struct nameidata *nd)
 {
 	if (!strcmp(nd->dentry->d_sb->s_type->name, "unionfs"))
 		return -EINVAL;
@@ -200,7 +200,7 @@
 }
 
 /* checks if two hidden_dentries have overlapping branches */
-int is_branch_overlap(struct dentry *dent1, struct dentry *dent2)
+static int is_branch_overlap(struct dentry *dent1, struct dentry *dent2)
 {
 	struct dentry *dent = NULL;
 
--- linux-2.6.20-rc4-mm1/fs/unionfs/rdstate.c.old	2007-01-18 21:31:24.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/rdstate.c	2007-01-18 21:31:37.000000000 +0100
@@ -232,7 +232,7 @@
 	return cursor;
 }
 
-inline struct filldir_node *alloc_filldir_node(const char *name, int namelen,
+static struct filldir_node *alloc_filldir_node(const char *name, int namelen,
 					       unsigned int hash, int bindex)
 {
 	return kmem_cache_alloc(unionfs_filldir_cachep, GFP_KERNEL);
--- linux-2.6.20-rc4-mm1/fs/unionfs/sioq.h.old	2007-01-18 21:36:56.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/sioq.h	2007-01-18 21:37:02.000000000 +0100
@@ -61,7 +61,6 @@
 	};
 };
 
-extern struct workqueue_struct *sioq;
 extern int __init init_sioq(void);
 extern __exit void stop_sioq(void);
 extern void run_sioq(work_func_t func, struct sioq_args *args);
--- linux-2.6.20-rc4-mm1/fs/unionfs/sioq.c.old	2007-01-18 21:32:14.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/sioq.c	2007-01-18 21:32:22.000000000 +0100
@@ -24,7 +24,7 @@
  * whiteouts).
  */
 
-struct workqueue_struct *sioq;
+static struct workqueue_struct *sioq;
 
 int __init init_sioq(void)
 {
--- linux-2.6.20-rc4-mm1/fs/unionfs/stale_inode.c.old	2007-01-18 21:33:03.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/stale_inode.c	2007-01-18 21:37:40.000000000 +0100
@@ -13,10 +13,9 @@
 #include <linux/stat.h>
 #include <linux/sched.h>
 
-static struct address_space_operations unionfs_stale_aops;
+#include "union.h"
 
-/* declarations for "sparse */
-extern struct inode_operations stale_inode_ops;
+static struct address_space_operations unionfs_stale_aops;
 
 /*
  * The follow_link operation is special: it must behave as a no-op
@@ -51,7 +50,7 @@
 	.lock		= ESTALE_ERROR,
 };
 
-struct inode_operations stale_inode_ops = {
+static struct inode_operations stale_inode_ops = {
 	.create		= ESTALE_ERROR,
 	.lookup		= ESTALE_ERROR,
 	.link		= ESTALE_ERROR,
@@ -99,6 +98,7 @@
  * those created by make_stale_inode() above.
  */
 
+#if 0
 /**
  * is_stale_inode - is an inode errored
  * @inode: inode to test
@@ -109,4 +109,5 @@
 {
 	return (inode->i_op == &stale_inode_ops);
 }
+#endif  /*  0  */
 
--- linux-2.6.20-rc4-mm1/fs/unionfs/commonfops.c.old	2007-01-18 21:34:11.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/unionfs/commonfops.c	2007-01-18 21:34:24.000000000 +0100
@@ -292,7 +292,7 @@
 }
 
 /* unionfs_open helper function: open a directory */
-static inline int __open_dir(struct inode *inode, struct file *file)
+static int __open_dir(struct inode *inode, struct file *file)
 {
 	struct dentry *hidden_dentry;
 	struct file *hidden_file;
@@ -326,7 +326,7 @@
 }
 
 /* unionfs_open helper function: open a file */
-static inline int __open_file(struct inode *inode, struct file *file)
+static int __open_file(struct inode *inode, struct file *file)
 {
 	struct dentry *hidden_dentry;
 	struct file *hidden_file;
@@ -493,7 +493,7 @@
 }
 
 /* pass the ioctl to the lower fs */
-static inline long do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct file *hidden_file;
 	int err;

