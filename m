Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbTDEUs4 (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 15:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbTDEUs4 (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 15:48:56 -0500
Received: from [212.34.181.86] ([212.34.181.86]:50699 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262653AbTDEUri (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 15:47:38 -0500
Date: Sat, 5 Apr 2003 22:58:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libfs
Message-ID: <20030405225846.A3059@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al added fs/libfs.c for common library routines used by filesysems
a while ago, but we have a lot more such library funcions, say
fs/exportfs/ or stuff scribbled all over the core VFS files.

This patch adds a fs/libfs/ dir instead, starting with simple.c
(simple, ramfs-based filesystems), symlink.c (pagecache-based
symlink code) and export.c (Neil's common export helpers).  In
the long term I think it's a good idea too, to have the prototypes
for all this (and whatever we more over) to <linux/libfs.h> so
it's clear they are only intended for filesystem driver, and we
don't get into situations like those people trying to use
do_generic_file_read from inkernel servers like in 2.4.

(I've send this as combined BK/plain patch because the BK patch
 can track the renames, but the plain patch works fine aswell)


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1034, 2003-04-05 21:08:39-05:00, hch@sb.bsdonline.org
  libfs cleanup


 b/fs/Makefile        |    5 
 b/fs/libfs/Makefile  |    3 
 b/fs/libfs/export.c  |  536 +++++++++++++++++++++++++++++++++++++++++++++++++++
 b/fs/libfs/simple.c  |  334 +++++++++++++++++++++++++++++++
 b/fs/libfs/symlink.c |  100 +++++++++
 b/fs/namei.c         |  101 ---------
 fs/exportfs/expfs.c  |  536 ---------------------------------------------------
 fs/libfs.c           |  334 -------------------------------
 8 files changed, 976 insertions(+), 973 deletions(-)


diff -Nru a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	Sat Apr  5 21:29:54 2003
+++ b/fs/Makefile	Sat Apr  5 21:29:54 2003
@@ -5,11 +5,11 @@
 # Rewritten to use lists instead of if-statements.
 # 
 
-obj-y :=	open.o read_write.o file_table.o buffer.o \
+obj-y :=	libfs/ open.o read_write.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
-		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
+		filesystems.o namespace.o seq_file.o xattr.o \
 		fs-writeback.o mpage.o direct-io.o aio.o eventpoll.o
 
 obj-$(CONFIG_COMPAT) += compat.o
@@ -66,7 +66,6 @@
 obj-$(CONFIG_HFS_FS)		+= hfs/
 obj-$(CONFIG_VXFS_FS)		+= freevxfs/
 obj-$(CONFIG_NFS_FS)		+= nfs/
-obj-$(CONFIG_EXPORTFS)		+= exportfs/
 obj-$(CONFIG_NFSD)		+= nfsd/
 obj-$(CONFIG_LOCKD)		+= lockd/
 obj-$(CONFIG_NLS)		+= nls/
diff -Nru a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
--- a/fs/exportfs/expfs.c	Sat Apr  5 21:29:54 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,536 +0,0 @@
-
-#include <linux/fs.h>
-#include <linux/module.h>
-#include <linux/smp_lock.h>
-#include <linux/namei.h>
-
-struct export_operations export_op_default;
-
-#define	CALL(ops,fun) ((ops->fun)?(ops->fun):export_op_default.fun)
-
-#define dprintk(fmt, args...) do{}while(0)
-
-/**
- * find_exported_dentry - helper routine to implement export_operations->decode_fh
- * @sb:		The &super_block identifying the filesystem
- * @obj:	An opaque identifier of the object to be found - passed to
- *		get_inode
- * @parent:	An optional opqaue identifier of the parent of the object.
- * @acceptable:	A function used to test possible &dentries to see if they are
- *		acceptable
- * @context:	A parameter to @acceptable so that it knows on what basis to
- *		judge.
- *
- * find_exported_dentry is the central helper routine to enable file systems
- * to provide the decode_fh() export_operation.  It's main task is to take
- * an &inode, find or create an appropriate &dentry structure, and possibly
- * splice this into the dcache in the correct place.
- *
- * The decode_fh() operation provided by the filesystem should call
- * find_exported_dentry() with the same parameters that it received except
- * that instead of the file handle fragment, pointers to opaque identifiers
- * for the object and optionally its parent are passed.  The default decode_fh
- * routine passes one pointer to the start of the filehandle fragment, and
- * one 8 bytes into the fragment.  It is expected that most filesystems will
- * take this approach, though the offset to the parent identifier may well be
- * different.
- *
- * find_exported_dentry() will call get_dentry to get an dentry pointer from
- * the file system.  If any &dentry in the d_alias list is acceptable, it will
- * be returned.  Otherwise find_exported_dentry() will attempt to splice a new
- * &dentry into the dcache using get_name() and get_parent() to find the
- * appropriate place.
- */
-
-struct dentry *
-find_exported_dentry(struct super_block *sb, void *obj, void *parent,
-		     int (*acceptable)(void *context, struct dentry *de),
-		     void *context)
-{
-	struct dentry *result = NULL;
-	struct dentry *target_dir;
-	int err;
-	struct export_operations *nops = sb->s_export_op;
-	struct list_head *le, *head;
-	struct dentry *toput = NULL;
-	int noprogress;
-
-
-	/*
-	 * Attempt to find the inode.
-	 */
-	result = CALL(sb->s_export_op,get_dentry)(sb,obj);
-	err = -ESTALE;
-	if (result == NULL)
-		goto err_out;
-	if (IS_ERR(result)) {
-		err = PTR_ERR(result);
-		goto err_out;
-	}
-	if (S_ISDIR(result->d_inode->i_mode) &&
-	    (result->d_flags & DCACHE_DISCONNECTED)) {
-		/* it is an unconnected directory, we must connect it */
-		;
-	} else {
-		if (acceptable(context, result))
-			return result;
-		if (S_ISDIR(result->d_inode->i_mode)) {
-			/* there is no other dentry, so fail */
-			goto err_result;
-		}
-		/* try any other aliases */
-		spin_lock(&dcache_lock);
-		head = &result->d_inode->i_dentry;
-		list_for_each(le, head) {
-			struct dentry *dentry = list_entry(le, struct dentry, d_alias);
-			dget_locked(dentry);
-			spin_unlock(&dcache_lock);
-			if (toput)
-				dput(toput);
-			toput = NULL;
-			if (dentry != result &&
-			    acceptable(context, dentry)) {
-				dput(result);
-				dentry->d_vfs_flags |= DCACHE_REFERENCED;
-				return dentry;
-			}
-			spin_lock(&dcache_lock);
-			toput = dentry;
-		}
-		spin_unlock(&dcache_lock);
-		if (toput)
-			dput(toput);
-	}			
-
-	/* It's a directory, or we are required to confirm the file's
-	 * location in the tree based on the parent information
- 	 */
-	dprintk("find_exported_dentry: need to look harder for %s/%d\n",sb->s_id,*(int*)obj);
-	if (S_ISDIR(result->d_inode->i_mode))
-		target_dir = dget(result);
-	else {
-		if (parent == NULL)
-			goto err_result;
-
-		target_dir = CALL(sb->s_export_op,get_dentry)(sb,parent);
-		if (IS_ERR(target_dir))
-			err = PTR_ERR(target_dir);
-		if (target_dir == NULL || IS_ERR(target_dir))
-			goto err_result;
-	}
-	/*
-	 * Now we need to make sure that target_dir is properly connected.
-	 * It may already be, as the flag isn't always updated when connection
-	 * happens.
-	 * So, we walk up parent links until we find a connected directory,
-	 * or we run out of directories.  Then we find the parent, find
-	 * the name of the child in that parent, and do a lookup.
-	 * This should connect the child into the parent
-	 * We then repeat.
-	 */
-
-	/* it is possible that a confused file system might not let us complete 
-	 * the path to the root.  For example, if get_parent returns a directory
-	 * in which we cannot find a name for the child.  While this implies a
-	 * very sick filesystem we don't want it to cause knfsd to spin.  Hence
-	 * the noprogress counter.  If we go through the loop 10 times (2 is
-	 * probably enough) without getting anywhere, we just give up
-	 */
-	lock_kernel();
-	noprogress= 0;
-	while (target_dir->d_flags & DCACHE_DISCONNECTED && noprogress++ < 10) {
-		struct dentry *pd = target_dir;
-
-		dget(pd);
-		spin_lock(&pd->d_lock);
-		while (!IS_ROOT(pd) &&
-				(pd->d_parent->d_flags&DCACHE_DISCONNECTED)) {
-			struct dentry *parent = pd->d_parent;
-
-			dget(parent);
-			spin_unlock(&pd->d_lock);
-			dput(pd);
-			pd = parent;
-			spin_lock(&pd->d_lock);
-		}
-		spin_unlock(&pd->d_lock);
-
-		if (!IS_ROOT(pd)) {
-			/* must have found a connected parent - great */
-			pd->d_flags &= ~DCACHE_DISCONNECTED;
-			noprogress = 0;
-		} else if (pd == sb->s_root) {
-			printk(KERN_ERR "export: Eeek filesystem root is not connected, impossible\n");
-			pd->d_flags &= ~DCACHE_DISCONNECTED;
-			noprogress = 0;
-		} else {
-			/* we have hit the top of a disconnected path.  Try
-			 * to find parent and connect
-			 * note: racing with some other process renaming a
-			 * directory isn't much of a problem here.  If someone
-			 * renames the directory, it will end up properly
-			 * connected, which is what we want
-			 */
-			struct dentry *ppd;
-			struct dentry *npd;
-			char nbuf[NAME_MAX+1];
-
-			down(&pd->d_inode->i_sem);
-			ppd = CALL(nops,get_parent)(pd);
-			up(&pd->d_inode->i_sem);
-
-			if (IS_ERR(ppd)) {
-				err = PTR_ERR(ppd);
-				dprintk("find_exported_dentry: get_parent of %ld failed, err %d\n",
-					pd->d_inode->i_ino, err);
-				dput(pd);
-				break;
-			}
-			dprintk("find_exported_dentry: find name of %lu in %lu\n", pd->d_inode->i_ino, ppd->d_inode->i_ino);
-			err = CALL(nops,get_name)(ppd, nbuf, pd);
-			if (err) {
-				dput(ppd);
-				dput(pd);
-				if (err == -ENOENT)
-					/* some race between get_parent and
-					 * get_name?  just try again
-					 */
-					continue;
-				break;
-			}
-			dprintk("find_exported_dentry: found name: %s\n", nbuf);
-			down(&ppd->d_inode->i_sem);
-			npd = lookup_one_len(nbuf, ppd, strlen(nbuf));
-			up(&ppd->d_inode->i_sem);
-			if (IS_ERR(npd)) {
-				err = PTR_ERR(npd);
-				dprintk("find_exported_dentry: lookup failed: %d\n", err);
-				dput(ppd);
-				dput(pd);
-				break;
-			}
-			/* we didn't really want npd, we really wanted
-			 * a side-effect of the lookup.
-			 * hopefully, npd == pd, though it isn't really
-			 * a problem if it isn't
-			 */
-			if (npd == pd)
-				noprogress = 0;
-			else
-				printk("find_exported_dentry: npd != pd\n");
-			dput(npd);
-			dput(ppd);
-			if (IS_ROOT(pd)) {
-				/* something went wrong, we have to give up */
-				dput(pd);
-				break;
-			}
-		}
-		dput(pd);
-	}
-
-	if (target_dir->d_flags & DCACHE_DISCONNECTED) {
-		/* something went wrong - oh-well */
-		if (!err)
-			err = -ESTALE;
-		unlock_kernel();
-		goto err_target;
-	}
-	/* if we weren't after a directory, have one more step to go */
-	if (result != target_dir) {
-		struct dentry *nresult;
-		char nbuf[NAME_MAX+1];
-		err = CALL(nops,get_name)(target_dir, nbuf, result);
-		if (!err) {
-			down(&target_dir->d_inode->i_sem);
-			nresult = lookup_one_len(nbuf, target_dir, strlen(nbuf));
-			up(&target_dir->d_inode->i_sem);
-			if (!IS_ERR(nresult)) {
-				if (nresult->d_inode) {
-					dput(result);
-					result = nresult;
-				} else
-					dput(nresult);
-			}
-		}
-	}
-	dput(target_dir);
-	unlock_kernel();
-	/* now result is properly connected, it is our best bet */
-	if (acceptable(context, result))
-		return result;
-	/* one last try of the aliases.. */
-	spin_lock(&dcache_lock);
-	toput = NULL;
-	head = &result->d_inode->i_dentry;
-	list_for_each(le, head) {
-		struct dentry *dentry = list_entry(le, struct dentry, d_alias);
-		dget_locked(dentry);
-		spin_unlock(&dcache_lock);
-		if (toput) dput(toput);
-		if (dentry != result &&
-		    acceptable(context, dentry)) {
-			dput(result);
-			dentry->d_vfs_flags |= DCACHE_REFERENCED;
-			return dentry;
-		}
-		spin_lock(&dcache_lock);
-		toput = dentry;
-	}
-	spin_unlock(&dcache_lock);
-	if (toput)
-		dput(toput);
-
-	/* drat - I just cannot find anything acceptable */
-	dput(result);
-	return ERR_PTR(-ESTALE);
-
- err_target:
-	dput(target_dir);
- err_result:
-	dput(result);
- err_out:
-	return ERR_PTR(err);
-}
-
-
-
-static struct dentry *get_parent(struct dentry *child)
-{
-	/* get_parent cannot be supported generically, the locking
-	 * is too icky.
-	 * instead, we just return EACCES.  If server reboots or inodes
-	 * get flushed, you lose
-	 */
-	return ERR_PTR(-EACCES);
-}
-
-
-struct getdents_callback {
-	char *name;		/* name that was found. It already points to a
-				   buffer NAME_MAX+1 is size */
-	unsigned long ino;	/* the inum we are looking for */
-	int found;		/* inode matched? */
-	int sequence;		/* sequence counter */
-};
-
-/*
- * A rather strange filldir function to capture
- * the name matching the specified inode number.
- */
-static int filldir_one(void * __buf, const char * name, int len,
-			loff_t pos, ino_t ino, unsigned int d_type)
-{
-	struct getdents_callback *buf = __buf;
-	int result = 0;
-
-	buf->sequence++;
-	if (buf->ino == ino) {
-		memcpy(buf->name, name, len);
-		buf->name[len] = '\0';
-		buf->found = 1;
-		result = -1;
-	}
-	return result;
-}
-
-/**
- * get_name - default export_operations->get_name function
- * @dentry: the directory in which to find a name
- * @name:   a pointer to a %NAME_MAX+1 char buffer to store the name
- * @child:  the dentry for the child directory.
- *
- * calls readdir on the parent until it finds an entry with
- * the same inode number as the child, and returns that.
- */
-static int get_name(struct dentry *dentry, char *name,
-			struct dentry *child)
-{
-	struct inode *dir = dentry->d_inode;
-	int error;
-	struct file file;
-	struct getdents_callback buffer;
-
-	error = -ENOTDIR;
-	if (!dir || !S_ISDIR(dir->i_mode))
-		goto out;
-	error = -EINVAL;
-	if (!dir->i_fop)
-		goto out;
-	/*
-	 * Open the directory ...
-	 */
-	error = open_private_file(&file, dentry, O_RDONLY);
-	if (error)
-		goto out;
-	error = -EINVAL;
-	if (!file.f_op->readdir)
-		goto out_close;
-
-	buffer.name = name;
-	buffer.ino = child->d_inode->i_ino;
-	buffer.found = 0;
-	buffer.sequence = 0;
-	while (1) {
-		int old_seq = buffer.sequence;
-
-		error = vfs_readdir(&file, filldir_one, &buffer);
-
-		if (error < 0)
-			break;
-
-		error = 0;
-		if (buffer.found)
-			break;
-		error = -ENOENT;
-		if (old_seq == buffer.sequence)
-			break;
-	}
-
-out_close:
-	close_private_file(&file);
-out:
-	return error;
-}
-
-
-static struct dentry *export_iget(struct super_block *sb, unsigned long ino, __u32 generation)
-{
-
-	/* iget isn't really right if the inode is currently unallocated!!
-	 * This should really all be done inside each filesystem
-	 *
-	 * ext2fs' read_inode has been strengthed to return a bad_inode if
-	 * the inode had been deleted.
-	 *
-	 * Currently we don't know the generation for parent directory, so
-	 * a generation of 0 means "accept any"
-	 */
-	struct inode *inode;
-	struct dentry *result;
-	if (ino == 0)
-		return ERR_PTR(-ESTALE);
-	inode = iget(sb, ino);
-	if (inode == NULL)
-		return ERR_PTR(-ENOMEM);
-	if (is_bad_inode(inode)
-	    || (generation && inode->i_generation != generation)
-		) {
-		/* we didn't find the right inode.. */
-		dprintk("fh_verify: Inode %lu, Bad count: %d %d or version  %u %u\n",
-			inode->i_ino,
-			inode->i_nlink, atomic_read(&inode->i_count),
-			inode->i_generation,
-			generation);
-
-		iput(inode);
-		return ERR_PTR(-ESTALE);
-	}
-	/* now to find a dentry.
-	 * If possible, get a well-connected one
-	 */
-	result = d_alloc_anon(inode);
-	if (!result) {
-		iput(inode);
-		return ERR_PTR(-ENOMEM);
-	}
-	result->d_vfs_flags |= DCACHE_REFERENCED;
-	return result;
-}
-
-
-static struct dentry *get_object(struct super_block *sb, void *vobjp)
-{
-	__u32 *objp = vobjp;
-	unsigned long ino = objp[0];
-	__u32 generation = objp[1];
-
-	return export_iget(sb, ino, generation);
-}
-
-
-/**
- * export_encode_fh - default export_operations->encode_fh function
- * @dentry:  the dentry to encode
- * @fh:      where to store the file handle fragment
- * @max_len: maximum length to store there
- * @connectable: whether to store parent information
- *
- * This default encode_fh function assumes that the 32 inode number
- * is suitable for locating an inode, and that the generation number
- * can be used to check that it is still valid.  It places them in the
- * filehandle fragment where export_decode_fh expects to find them.
- */
-static int export_encode_fh(struct dentry *dentry, __u32 *fh, int *max_len,
-		   int connectable)
-{
-	struct inode * inode = dentry->d_inode;
-	int len = *max_len;
-	int type = 1;
-	
-	if (len < 2 || (connectable && len < 4))
-		return 255;
-
-	len = 2;
-	fh[0] = inode->i_ino;
-	fh[1] = inode->i_generation;
-	if (connectable && !S_ISDIR(inode->i_mode)) {
-		struct inode *parent;
-
-		spin_lock(&dentry->d_lock);
-		parent = dentry->d_parent->d_inode;
-		fh[2] = parent->i_ino;
-		fh[3] = parent->i_generation;
-		spin_unlock(&dentry->d_lock);
-		len = 4;
-		type = 2;
-	}
-	*max_len = len;
-	return type;
-}
-
-
-/**
- * export_decode_fh - default export_operations->decode_fh function
- * @sb:  The superblock
- * @fh:  pointer to the file handle fragment
- * @fh_len: length of file handle fragment
- * @acceptable: function for testing acceptability of dentrys
- * @context:   context for @acceptable
- *
- * This is the default decode_fh() function.
- * a fileid_type of 1 indicates that the filehandlefragment
- * just contains an object identifier understood by  get_dentry.
- * a fileid_type of 2 says that there is also a directory
- * identifier 8 bytes in to the filehandlefragement.
- */
-static struct dentry *export_decode_fh(struct super_block *sb, __u32 *fh, int fh_len,
-			      int fileid_type,
-			 int (*acceptable)(void *context, struct dentry *de),
-			 void *context)
-{
-	__u32 parent[2];
-	parent[0] = parent[1] = 0;
-	if (fh_len < 2 || fileid_type > 2)
-		return NULL;
-	if (fileid_type == 2) {
-		if (fh_len > 2) parent[0] = fh[2];
-		if (fh_len > 3) parent[1] = fh[3];
-	}
-	return find_exported_dentry(sb, fh, parent,
-				   acceptable, context);
-}
-
-struct export_operations export_op_default = {
-	.decode_fh	= export_decode_fh,
-	.encode_fh	= export_encode_fh,
-
-	.get_name	= get_name,
-	.get_parent	= get_parent,
-	.get_dentry	= get_object,
-};
-
-EXPORT_SYMBOL(export_op_default);
-EXPORT_SYMBOL(find_exported_dentry);
-
-MODULE_LICENSE("GPL");
diff -Nru a/fs/libfs/Makefile b/fs/libfs/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/libfs/Makefile	Sat Apr  5 21:29:54 2003
@@ -0,0 +1,3 @@
+
+obj-y			+= simple.o symlink.o
+obj-$(CONFIG_EXPORTFS)	+= export.o
diff -Nru a/fs/libfs/export.c b/fs/libfs/export.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/libfs/export.c	Sat Apr  5 21:29:54 2003
@@ -0,0 +1,536 @@
+
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <linux/namei.h>
+
+struct export_operations export_op_default;
+
+#define	CALL(ops,fun) ((ops->fun)?(ops->fun):export_op_default.fun)
+
+#define dprintk(fmt, args...) do{}while(0)
+
+/**
+ * find_exported_dentry - helper routine to implement export_operations->decode_fh
+ * @sb:		The &super_block identifying the filesystem
+ * @obj:	An opaque identifier of the object to be found - passed to
+ *		get_inode
+ * @parent:	An optional opqaue identifier of the parent of the object.
+ * @acceptable:	A function used to test possible &dentries to see if they are
+ *		acceptable
+ * @context:	A parameter to @acceptable so that it knows on what basis to
+ *		judge.
+ *
+ * find_exported_dentry is the central helper routine to enable file systems
+ * to provide the decode_fh() export_operation.  It's main task is to take
+ * an &inode, find or create an appropriate &dentry structure, and possibly
+ * splice this into the dcache in the correct place.
+ *
+ * The decode_fh() operation provided by the filesystem should call
+ * find_exported_dentry() with the same parameters that it received except
+ * that instead of the file handle fragment, pointers to opaque identifiers
+ * for the object and optionally its parent are passed.  The default decode_fh
+ * routine passes one pointer to the start of the filehandle fragment, and
+ * one 8 bytes into the fragment.  It is expected that most filesystems will
+ * take this approach, though the offset to the parent identifier may well be
+ * different.
+ *
+ * find_exported_dentry() will call get_dentry to get an dentry pointer from
+ * the file system.  If any &dentry in the d_alias list is acceptable, it will
+ * be returned.  Otherwise find_exported_dentry() will attempt to splice a new
+ * &dentry into the dcache using get_name() and get_parent() to find the
+ * appropriate place.
+ */
+
+struct dentry *
+find_exported_dentry(struct super_block *sb, void *obj, void *parent,
+		     int (*acceptable)(void *context, struct dentry *de),
+		     void *context)
+{
+	struct dentry *result = NULL;
+	struct dentry *target_dir;
+	int err;
+	struct export_operations *nops = sb->s_export_op;
+	struct list_head *le, *head;
+	struct dentry *toput = NULL;
+	int noprogress;
+
+
+	/*
+	 * Attempt to find the inode.
+	 */
+	result = CALL(sb->s_export_op,get_dentry)(sb,obj);
+	err = -ESTALE;
+	if (result == NULL)
+		goto err_out;
+	if (IS_ERR(result)) {
+		err = PTR_ERR(result);
+		goto err_out;
+	}
+	if (S_ISDIR(result->d_inode->i_mode) &&
+	    (result->d_flags & DCACHE_DISCONNECTED)) {
+		/* it is an unconnected directory, we must connect it */
+		;
+	} else {
+		if (acceptable(context, result))
+			return result;
+		if (S_ISDIR(result->d_inode->i_mode)) {
+			/* there is no other dentry, so fail */
+			goto err_result;
+		}
+		/* try any other aliases */
+		spin_lock(&dcache_lock);
+		head = &result->d_inode->i_dentry;
+		list_for_each(le, head) {
+			struct dentry *dentry = list_entry(le, struct dentry, d_alias);
+			dget_locked(dentry);
+			spin_unlock(&dcache_lock);
+			if (toput)
+				dput(toput);
+			toput = NULL;
+			if (dentry != result &&
+			    acceptable(context, dentry)) {
+				dput(result);
+				dentry->d_vfs_flags |= DCACHE_REFERENCED;
+				return dentry;
+			}
+			spin_lock(&dcache_lock);
+			toput = dentry;
+		}
+		spin_unlock(&dcache_lock);
+		if (toput)
+			dput(toput);
+	}			
+
+	/* It's a directory, or we are required to confirm the file's
+	 * location in the tree based on the parent information
+ 	 */
+	dprintk("find_exported_dentry: need to look harder for %s/%d\n",sb->s_id,*(int*)obj);
+	if (S_ISDIR(result->d_inode->i_mode))
+		target_dir = dget(result);
+	else {
+		if (parent == NULL)
+			goto err_result;
+
+		target_dir = CALL(sb->s_export_op,get_dentry)(sb,parent);
+		if (IS_ERR(target_dir))
+			err = PTR_ERR(target_dir);
+		if (target_dir == NULL || IS_ERR(target_dir))
+			goto err_result;
+	}
+	/*
+	 * Now we need to make sure that target_dir is properly connected.
+	 * It may already be, as the flag isn't always updated when connection
+	 * happens.
+	 * So, we walk up parent links until we find a connected directory,
+	 * or we run out of directories.  Then we find the parent, find
+	 * the name of the child in that parent, and do a lookup.
+	 * This should connect the child into the parent
+	 * We then repeat.
+	 */
+
+	/* it is possible that a confused file system might not let us complete 
+	 * the path to the root.  For example, if get_parent returns a directory
+	 * in which we cannot find a name for the child.  While this implies a
+	 * very sick filesystem we don't want it to cause knfsd to spin.  Hence
+	 * the noprogress counter.  If we go through the loop 10 times (2 is
+	 * probably enough) without getting anywhere, we just give up
+	 */
+	lock_kernel();
+	noprogress= 0;
+	while (target_dir->d_flags & DCACHE_DISCONNECTED && noprogress++ < 10) {
+		struct dentry *pd = target_dir;
+
+		dget(pd);
+		spin_lock(&pd->d_lock);
+		while (!IS_ROOT(pd) &&
+				(pd->d_parent->d_flags&DCACHE_DISCONNECTED)) {
+			struct dentry *parent = pd->d_parent;
+
+			dget(parent);
+			spin_unlock(&pd->d_lock);
+			dput(pd);
+			pd = parent;
+			spin_lock(&pd->d_lock);
+		}
+		spin_unlock(&pd->d_lock);
+
+		if (!IS_ROOT(pd)) {
+			/* must have found a connected parent - great */
+			pd->d_flags &= ~DCACHE_DISCONNECTED;
+			noprogress = 0;
+		} else if (pd == sb->s_root) {
+			printk(KERN_ERR "export: Eeek filesystem root is not connected, impossible\n");
+			pd->d_flags &= ~DCACHE_DISCONNECTED;
+			noprogress = 0;
+		} else {
+			/* we have hit the top of a disconnected path.  Try
+			 * to find parent and connect
+			 * note: racing with some other process renaming a
+			 * directory isn't much of a problem here.  If someone
+			 * renames the directory, it will end up properly
+			 * connected, which is what we want
+			 */
+			struct dentry *ppd;
+			struct dentry *npd;
+			char nbuf[NAME_MAX+1];
+
+			down(&pd->d_inode->i_sem);
+			ppd = CALL(nops,get_parent)(pd);
+			up(&pd->d_inode->i_sem);
+
+			if (IS_ERR(ppd)) {
+				err = PTR_ERR(ppd);
+				dprintk("find_exported_dentry: get_parent of %ld failed, err %d\n",
+					pd->d_inode->i_ino, err);
+				dput(pd);
+				break;
+			}
+			dprintk("find_exported_dentry: find name of %lu in %lu\n", pd->d_inode->i_ino, ppd->d_inode->i_ino);
+			err = CALL(nops,get_name)(ppd, nbuf, pd);
+			if (err) {
+				dput(ppd);
+				dput(pd);
+				if (err == -ENOENT)
+					/* some race between get_parent and
+					 * get_name?  just try again
+					 */
+					continue;
+				break;
+			}
+			dprintk("find_exported_dentry: found name: %s\n", nbuf);
+			down(&ppd->d_inode->i_sem);
+			npd = lookup_one_len(nbuf, ppd, strlen(nbuf));
+			up(&ppd->d_inode->i_sem);
+			if (IS_ERR(npd)) {
+				err = PTR_ERR(npd);
+				dprintk("find_exported_dentry: lookup failed: %d\n", err);
+				dput(ppd);
+				dput(pd);
+				break;
+			}
+			/* we didn't really want npd, we really wanted
+			 * a side-effect of the lookup.
+			 * hopefully, npd == pd, though it isn't really
+			 * a problem if it isn't
+			 */
+			if (npd == pd)
+				noprogress = 0;
+			else
+				printk("find_exported_dentry: npd != pd\n");
+			dput(npd);
+			dput(ppd);
+			if (IS_ROOT(pd)) {
+				/* something went wrong, we have to give up */
+				dput(pd);
+				break;
+			}
+		}
+		dput(pd);
+	}
+
+	if (target_dir->d_flags & DCACHE_DISCONNECTED) {
+		/* something went wrong - oh-well */
+		if (!err)
+			err = -ESTALE;
+		unlock_kernel();
+		goto err_target;
+	}
+	/* if we weren't after a directory, have one more step to go */
+	if (result != target_dir) {
+		struct dentry *nresult;
+		char nbuf[NAME_MAX+1];
+		err = CALL(nops,get_name)(target_dir, nbuf, result);
+		if (!err) {
+			down(&target_dir->d_inode->i_sem);
+			nresult = lookup_one_len(nbuf, target_dir, strlen(nbuf));
+			up(&target_dir->d_inode->i_sem);
+			if (!IS_ERR(nresult)) {
+				if (nresult->d_inode) {
+					dput(result);
+					result = nresult;
+				} else
+					dput(nresult);
+			}
+		}
+	}
+	dput(target_dir);
+	unlock_kernel();
+	/* now result is properly connected, it is our best bet */
+	if (acceptable(context, result))
+		return result;
+	/* one last try of the aliases.. */
+	spin_lock(&dcache_lock);
+	toput = NULL;
+	head = &result->d_inode->i_dentry;
+	list_for_each(le, head) {
+		struct dentry *dentry = list_entry(le, struct dentry, d_alias);
+		dget_locked(dentry);
+		spin_unlock(&dcache_lock);
+		if (toput) dput(toput);
+		if (dentry != result &&
+		    acceptable(context, dentry)) {
+			dput(result);
+			dentry->d_vfs_flags |= DCACHE_REFERENCED;
+			return dentry;
+		}
+		spin_lock(&dcache_lock);
+		toput = dentry;
+	}
+	spin_unlock(&dcache_lock);
+	if (toput)
+		dput(toput);
+
+	/* drat - I just cannot find anything acceptable */
+	dput(result);
+	return ERR_PTR(-ESTALE);
+
+ err_target:
+	dput(target_dir);
+ err_result:
+	dput(result);
+ err_out:
+	return ERR_PTR(err);
+}
+
+
+
+static struct dentry *get_parent(struct dentry *child)
+{
+	/* get_parent cannot be supported generically, the locking
+	 * is too icky.
+	 * instead, we just return EACCES.  If server reboots or inodes
+	 * get flushed, you lose
+	 */
+	return ERR_PTR(-EACCES);
+}
+
+
+struct getdents_callback {
+	char *name;		/* name that was found. It already points to a
+				   buffer NAME_MAX+1 is size */
+	unsigned long ino;	/* the inum we are looking for */
+	int found;		/* inode matched? */
+	int sequence;		/* sequence counter */
+};
+
+/*
+ * A rather strange filldir function to capture
+ * the name matching the specified inode number.
+ */
+static int filldir_one(void * __buf, const char * name, int len,
+			loff_t pos, ino_t ino, unsigned int d_type)
+{
+	struct getdents_callback *buf = __buf;
+	int result = 0;
+
+	buf->sequence++;
+	if (buf->ino == ino) {
+		memcpy(buf->name, name, len);
+		buf->name[len] = '\0';
+		buf->found = 1;
+		result = -1;
+	}
+	return result;
+}
+
+/**
+ * get_name - default export_operations->get_name function
+ * @dentry: the directory in which to find a name
+ * @name:   a pointer to a %NAME_MAX+1 char buffer to store the name
+ * @child:  the dentry for the child directory.
+ *
+ * calls readdir on the parent until it finds an entry with
+ * the same inode number as the child, and returns that.
+ */
+static int get_name(struct dentry *dentry, char *name,
+			struct dentry *child)
+{
+	struct inode *dir = dentry->d_inode;
+	int error;
+	struct file file;
+	struct getdents_callback buffer;
+
+	error = -ENOTDIR;
+	if (!dir || !S_ISDIR(dir->i_mode))
+		goto out;
+	error = -EINVAL;
+	if (!dir->i_fop)
+		goto out;
+	/*
+	 * Open the directory ...
+	 */
+	error = open_private_file(&file, dentry, O_RDONLY);
+	if (error)
+		goto out;
+	error = -EINVAL;
+	if (!file.f_op->readdir)
+		goto out_close;
+
+	buffer.name = name;
+	buffer.ino = child->d_inode->i_ino;
+	buffer.found = 0;
+	buffer.sequence = 0;
+	while (1) {
+		int old_seq = buffer.sequence;
+
+		error = vfs_readdir(&file, filldir_one, &buffer);
+
+		if (error < 0)
+			break;
+
+		error = 0;
+		if (buffer.found)
+			break;
+		error = -ENOENT;
+		if (old_seq == buffer.sequence)
+			break;
+	}
+
+out_close:
+	close_private_file(&file);
+out:
+	return error;
+}
+
+
+static struct dentry *export_iget(struct super_block *sb, unsigned long ino, __u32 generation)
+{
+
+	/* iget isn't really right if the inode is currently unallocated!!
+	 * This should really all be done inside each filesystem
+	 *
+	 * ext2fs' read_inode has been strengthed to return a bad_inode if
+	 * the inode had been deleted.
+	 *
+	 * Currently we don't know the generation for parent directory, so
+	 * a generation of 0 means "accept any"
+	 */
+	struct inode *inode;
+	struct dentry *result;
+	if (ino == 0)
+		return ERR_PTR(-ESTALE);
+	inode = iget(sb, ino);
+	if (inode == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation)
+		) {
+		/* we didn't find the right inode.. */
+		dprintk("fh_verify: Inode %lu, Bad count: %d %d or version  %u %u\n",
+			inode->i_ino,
+			inode->i_nlink, atomic_read(&inode->i_count),
+			inode->i_generation,
+			generation);
+
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 */
+	result = d_alloc_anon(inode);
+	if (!result) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	result->d_vfs_flags |= DCACHE_REFERENCED;
+	return result;
+}
+
+
+static struct dentry *get_object(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+
+	return export_iget(sb, ino, generation);
+}
+
+
+/**
+ * export_encode_fh - default export_operations->encode_fh function
+ * @dentry:  the dentry to encode
+ * @fh:      where to store the file handle fragment
+ * @max_len: maximum length to store there
+ * @connectable: whether to store parent information
+ *
+ * This default encode_fh function assumes that the 32 inode number
+ * is suitable for locating an inode, and that the generation number
+ * can be used to check that it is still valid.  It places them in the
+ * filehandle fragment where export_decode_fh expects to find them.
+ */
+static int export_encode_fh(struct dentry *dentry, __u32 *fh, int *max_len,
+		   int connectable)
+{
+	struct inode * inode = dentry->d_inode;
+	int len = *max_len;
+	int type = 1;
+	
+	if (len < 2 || (connectable && len < 4))
+		return 255;
+
+	len = 2;
+	fh[0] = inode->i_ino;
+	fh[1] = inode->i_generation;
+	if (connectable && !S_ISDIR(inode->i_mode)) {
+		struct inode *parent;
+
+		spin_lock(&dentry->d_lock);
+		parent = dentry->d_parent->d_inode;
+		fh[2] = parent->i_ino;
+		fh[3] = parent->i_generation;
+		spin_unlock(&dentry->d_lock);
+		len = 4;
+		type = 2;
+	}
+	*max_len = len;
+	return type;
+}
+
+
+/**
+ * export_decode_fh - default export_operations->decode_fh function
+ * @sb:  The superblock
+ * @fh:  pointer to the file handle fragment
+ * @fh_len: length of file handle fragment
+ * @acceptable: function for testing acceptability of dentrys
+ * @context:   context for @acceptable
+ *
+ * This is the default decode_fh() function.
+ * a fileid_type of 1 indicates that the filehandlefragment
+ * just contains an object identifier understood by  get_dentry.
+ * a fileid_type of 2 says that there is also a directory
+ * identifier 8 bytes in to the filehandlefragement.
+ */
+static struct dentry *export_decode_fh(struct super_block *sb, __u32 *fh, int fh_len,
+			      int fileid_type,
+			 int (*acceptable)(void *context, struct dentry *de),
+			 void *context)
+{
+	__u32 parent[2];
+	parent[0] = parent[1] = 0;
+	if (fh_len < 2 || fileid_type > 2)
+		return NULL;
+	if (fileid_type == 2) {
+		if (fh_len > 2) parent[0] = fh[2];
+		if (fh_len > 3) parent[1] = fh[3];
+	}
+	return find_exported_dentry(sb, fh, parent,
+				   acceptable, context);
+}
+
+struct export_operations export_op_default = {
+	.decode_fh	= export_decode_fh,
+	.encode_fh	= export_encode_fh,
+
+	.get_name	= get_name,
+	.get_parent	= get_parent,
+	.get_dentry	= get_object,
+};
+
+EXPORT_SYMBOL(export_op_default);
+EXPORT_SYMBOL(find_exported_dentry);
+
+MODULE_LICENSE("GPL");
diff -Nru a/fs/libfs/simple.c b/fs/libfs/simple.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/libfs/simple.c	Sat Apr  5 21:29:54 2003
@@ -0,0 +1,334 @@
+/*
+ *	fs/libfs.c
+ *	Library for filesystems writers.
+ */
+
+#include <linux/pagemap.h>
+#include <linux/vfs.h>
+
+int simple_getattr(struct vfsmount *mnt, struct dentry *dentry,
+		   struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	generic_fillattr(inode, stat);
+	stat->blocks = inode->i_mapping->nrpages << (PAGE_CACHE_SHIFT - 9);
+	return 0;
+}
+
+int simple_statfs(struct super_block *sb, struct statfs *buf)
+{
+	buf->f_type = sb->s_magic;
+	buf->f_bsize = PAGE_CACHE_SIZE;
+	buf->f_namelen = NAME_MAX;
+	return 0;
+}
+
+/*
+ * Lookup the data. This is trivial - if the dentry didn't already
+ * exist, we know it is negative.
+ */
+
+struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry)
+{
+	d_add(dentry, NULL);
+	return NULL;
+}
+
+int simple_sync_file(struct file * file, struct dentry *dentry, int datasync)
+{
+	return 0;
+}
+ 
+int dcache_dir_open(struct inode *inode, struct file *file)
+{
+	static struct qstr cursor_name = {.len = 1, .name = "."};
+
+	file->private_data = d_alloc(file->f_dentry, &cursor_name);
+
+	return file->private_data ? 0 : -ENOMEM;
+}
+
+int dcache_dir_close(struct inode *inode, struct file *file)
+{
+	dput(file->private_data);
+	return 0;
+}
+
+loff_t dcache_dir_lseek(struct file *file, loff_t offset, int origin)
+{
+	down(&file->f_dentry->d_inode->i_sem);
+	switch (origin) {
+		case 1:
+			offset += file->f_pos;
+		case 0:
+			if (offset >= 0)
+				break;
+		default:
+			up(&file->f_dentry->d_inode->i_sem);
+			return -EINVAL;
+	}
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		if (file->f_pos >= 2) {
+			struct list_head *p;
+			struct dentry *cursor = file->private_data;
+			loff_t n = file->f_pos - 2;
+
+			spin_lock(&dcache_lock);
+			p = file->f_dentry->d_subdirs.next;
+			while (n && p != &file->f_dentry->d_subdirs) {
+				struct dentry *next;
+				next = list_entry(p, struct dentry, d_child);
+				if (!d_unhashed(next) && next->d_inode)
+					n--;
+				p = p->next;
+			}
+			list_del(&cursor->d_child);
+			list_add_tail(&cursor->d_child, p);
+			spin_unlock(&dcache_lock);
+		}
+	}
+	up(&file->f_dentry->d_inode->i_sem);
+	return offset;
+}
+
+/* Relationship between i_mode and the DT_xxx types */
+static inline unsigned char dt_type(struct inode *inode)
+{
+	return (inode->i_mode >> 12) & 15;
+}
+
+/*
+ * Directory is locked and all positive dentries in it are safe, since
+ * for ramfs-type trees they can't go away without unlink() or rmdir(),
+ * both impossible due to the lock on directory.
+ */
+
+int dcache_readdir(struct file * filp, void * dirent, filldir_t filldir)
+{
+	struct dentry *dentry = filp->f_dentry;
+	struct dentry *cursor = filp->private_data;
+	struct list_head *p, *q = &cursor->d_child;
+	ino_t ino;
+	int i = filp->f_pos;
+
+	switch (i) {
+		case 0:
+			ino = dentry->d_inode->i_ino;
+			if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
+				break;
+			filp->f_pos++;
+			i++;
+			/* fallthrough */
+		case 1:
+			ino = parent_ino(dentry);
+			if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
+				break;
+			filp->f_pos++;
+			i++;
+			/* fallthrough */
+		default:
+			spin_lock(&dcache_lock);
+			if (filp->f_pos == 2) {
+				list_del(q);
+				list_add(q, &dentry->d_subdirs);
+			}
+			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
+				struct dentry *next;
+				next = list_entry(p, struct dentry, d_child);
+				if (d_unhashed(next) || !next->d_inode)
+					continue;
+
+				spin_unlock(&dcache_lock);
+				if (filldir(dirent, next->d_name.name, next->d_name.len, filp->f_pos, next->d_inode->i_ino, dt_type(next->d_inode)) < 0)
+					return 0;
+				spin_lock(&dcache_lock);
+				/* next is still alive */
+				list_del(q);
+				list_add(q, p);
+				p = q;
+				filp->f_pos++;
+			}
+			spin_unlock(&dcache_lock);
+	}
+	return 0;
+}
+
+ssize_t generic_read_dir(struct file *filp, char *buf, size_t siz, loff_t *ppos)
+{
+	return -EISDIR;
+}
+
+struct file_operations simple_dir_operations = {
+	.open		= dcache_dir_open,
+	.release	= dcache_dir_close,
+	.llseek		= dcache_dir_lseek,
+	.read		= generic_read_dir,
+	.readdir	= dcache_readdir,
+};
+
+struct inode_operations simple_dir_inode_operations = {
+	.lookup		= simple_lookup,
+};
+
+/*
+ * Common helper for pseudo-filesystems (sockfs, pipefs, bdev - stuff that
+ * will never be mountable)
+ */
+struct super_block *
+get_sb_pseudo(struct file_system_type *fs_type, char *name,
+	struct super_operations *ops, unsigned long magic)
+{
+	struct super_block *s = sget(fs_type, NULL, set_anon_super, NULL);
+	static struct super_operations default_ops = {.statfs = simple_statfs};
+	struct dentry *dentry;
+	struct inode *root;
+	struct qstr d_name = {.name = name, .len = strlen(name)};
+
+	if (IS_ERR(s))
+		return s;
+
+	s->s_flags = MS_NOUSER;
+	s->s_maxbytes = ~0ULL;
+	s->s_blocksize = 1024;
+	s->s_blocksize_bits = 10;
+	s->s_magic = magic;
+	s->s_op = ops ? ops : &default_ops;
+	root = new_inode(s);
+	if (!root)
+		goto Enomem;
+	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
+	root->i_uid = root->i_gid = 0;
+	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
+	dentry = d_alloc(NULL, &d_name);
+	if (!dentry) {
+		iput(root);
+		goto Enomem;
+	}
+	dentry->d_sb = s;
+	dentry->d_parent = dentry;
+	d_instantiate(dentry, root);
+	s->s_root = dentry;
+	s->s_flags |= MS_ACTIVE;
+	return s;
+
+Enomem:
+	up_write(&s->s_umount);
+	deactivate_super(s);
+	return ERR_PTR(-ENOMEM);
+}
+
+int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = old_dentry->d_inode;
+
+	inode->i_nlink++;
+	atomic_inc(&inode->i_count);
+	dget(dentry);
+	d_instantiate(dentry, inode);
+	return 0;
+}
+
+static inline int simple_positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
+int simple_empty(struct dentry *dentry)
+{
+	struct dentry *child;
+	int ret = 0;
+
+	spin_lock(&dcache_lock);
+	list_for_each_entry(child, &dentry->d_subdirs, d_child)
+		if (simple_positive(child))
+			goto out;
+	ret = 1;
+out:
+	spin_unlock(&dcache_lock);
+	return ret;
+}
+
+int simple_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+
+	inode->i_nlink--;
+	dput(dentry);
+	return 0;
+}
+
+int simple_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	if (!simple_empty(dentry))
+		return -ENOTEMPTY;
+
+	dentry->d_inode->i_nlink--;
+	simple_unlink(dir, dentry);
+	dir->i_nlink--;
+	return 0;
+}
+
+int simple_rename(struct inode *old_dir, struct dentry *old_dentry,
+		struct inode *new_dir, struct dentry *new_dentry)
+{
+	int they_are_dirs = S_ISDIR(old_dentry->d_inode->i_mode);
+
+	if (!simple_empty(new_dentry))
+		return -ENOTEMPTY;
+
+	if (new_dentry->d_inode) {
+		simple_unlink(new_dir, new_dentry);
+		if (they_are_dirs)
+			old_dir->i_nlink--;
+	} else if (they_are_dirs) {
+		old_dir->i_nlink--;
+		new_dir->i_nlink++;
+	}
+	return 0;
+}
+
+int simple_readpage(struct file *file, struct page *page)
+{
+	void *kaddr;
+
+	if (PageUptodate(page))
+		goto out;
+
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset(kaddr, 0, PAGE_CACHE_SIZE);
+	kunmap_atomic(kaddr, KM_USER0);
+	flush_dcache_page(page);
+	SetPageUptodate(page);
+out:
+	unlock_page(page);
+	return 0;
+}
+
+int simple_prepare_write(struct file *file, struct page *page,
+			unsigned from, unsigned to)
+{
+	if (!PageUptodate(page)) {
+		if (to - from != PAGE_CACHE_SIZE) {
+			void *kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr, 0, from);
+			memset(kaddr + to, 0, PAGE_CACHE_SIZE - to);
+			flush_dcache_page(page);
+			kunmap_atomic(kaddr, KM_USER0);
+		}
+		SetPageUptodate(page);
+	}
+	return 0;
+}
+
+int simple_commit_write(struct file *file, struct page *page,
+			unsigned offset, unsigned to)
+{
+	struct inode *inode = page->mapping->host;
+	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
+
+	if (pos > inode->i_size)
+		inode->i_size = pos;
+	set_page_dirty(page);
+	return 0;
+}
diff -Nru a/fs/libfs/symlink.c b/fs/libfs/symlink.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/libfs/symlink.c	Sat Apr  5 21:29:54 2003
@@ -0,0 +1,100 @@
+/* from fs/namei.c, written by Al Viro */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+
+
+/* get the link contents into pagecache */
+static char *page_getlink(struct dentry *dentry, struct page **ppage)
+{
+	struct page * page;
+	struct address_space *mapping = dentry->d_inode->i_mapping;
+	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage,
+				NULL);
+	if (unlikely(IS_ERR(page)))
+		goto sync_fail;
+	wait_on_page_locked(page);
+	if (unlikely(!PageUptodate(page)))
+		goto async_fail;
+	*ppage = page;
+	return kmap(page);
+
+async_fail:
+	page_cache_release(page);
+	return ERR_PTR(-EIO);
+
+sync_fail:
+	return (char*)page;
+}
+
+int page_readlink(struct dentry *dentry, char *buffer, int buflen)
+{
+	struct page *page = NULL;
+	char *s = page_getlink(dentry, &page);
+	int res = vfs_readlink(dentry,buffer,buflen,s);
+	if (likely(page != NULL)) {
+		kunmap(page);
+		page_cache_release(page);
+	}
+	return res;
+}
+
+int page_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	struct page *page = NULL;
+	char *s = page_getlink(dentry, &page);
+	int res = vfs_follow_link(nd, s);
+	if (likely(page != NULL)) {
+		kunmap(page);
+		page_cache_release(page);
+	}
+	return res;
+}
+
+int page_symlink(struct inode *inode, const char *symname, int len)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page = grab_cache_page(mapping, 0);
+	int err = -ENOMEM;
+	char *kaddr;
+
+	if (unlikely(!page))
+		goto fail;
+	err = mapping->a_ops->prepare_write(NULL, page, 0, len-1);
+	if (unlikely(err))
+		goto fail_map;
+	kaddr = kmap_atomic(page, KM_USER0);
+	memcpy(kaddr, symname, len-1);
+	kunmap_atomic(kaddr, KM_USER0);
+	mapping->a_ops->commit_write(NULL, page, 0, len-1);
+
+	/*
+	 * Notice that we are _not_ going to block here - end of page is
+	 * unmapped, so this will only try to map the rest of page, see
+	 * that it is unmapped (typically even will not look into inode -
+	 * ->i_size will be enough for everything) and zero it out.
+	 * OTOH it's obviously correct and should make the page up-to-date.
+	 */
+	if (!PageUptodate(page)) {
+		err = mapping->a_ops->readpage(NULL, page);
+		wait_on_page_locked(page);
+	} else {
+		unlock_page(page);
+	}
+	page_cache_release(page);
+	if (unlikely(err < 0))
+		goto fail;
+	mark_inode_dirty(inode);
+	return 0;
+fail_map:
+	unlock_page(page);
+	page_cache_release(page);
+fail:
+	return err;
+}
+
+struct inode_operations page_symlink_inode_operations = {
+	.readlink	= page_readlink,
+	.follow_link	= page_follow_link,
+};
diff -Nru a/fs/libfs.c b/fs/libfs.c
--- a/fs/libfs.c	Sat Apr  5 21:29:54 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,334 +0,0 @@
-/*
- *	fs/libfs.c
- *	Library for filesystems writers.
- */
-
-#include <linux/pagemap.h>
-#include <linux/vfs.h>
-
-int simple_getattr(struct vfsmount *mnt, struct dentry *dentry,
-		   struct kstat *stat)
-{
-	struct inode *inode = dentry->d_inode;
-	generic_fillattr(inode, stat);
-	stat->blocks = inode->i_mapping->nrpages << (PAGE_CACHE_SHIFT - 9);
-	return 0;
-}
-
-int simple_statfs(struct super_block *sb, struct statfs *buf)
-{
-	buf->f_type = sb->s_magic;
-	buf->f_bsize = PAGE_CACHE_SIZE;
-	buf->f_namelen = NAME_MAX;
-	return 0;
-}
-
-/*
- * Lookup the data. This is trivial - if the dentry didn't already
- * exist, we know it is negative.
- */
-
-struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry)
-{
-	d_add(dentry, NULL);
-	return NULL;
-}
-
-int simple_sync_file(struct file * file, struct dentry *dentry, int datasync)
-{
-	return 0;
-}
- 
-int dcache_dir_open(struct inode *inode, struct file *file)
-{
-	static struct qstr cursor_name = {.len = 1, .name = "."};
-
-	file->private_data = d_alloc(file->f_dentry, &cursor_name);
-
-	return file->private_data ? 0 : -ENOMEM;
-}
-
-int dcache_dir_close(struct inode *inode, struct file *file)
-{
-	dput(file->private_data);
-	return 0;
-}
-
-loff_t dcache_dir_lseek(struct file *file, loff_t offset, int origin)
-{
-	down(&file->f_dentry->d_inode->i_sem);
-	switch (origin) {
-		case 1:
-			offset += file->f_pos;
-		case 0:
-			if (offset >= 0)
-				break;
-		default:
-			up(&file->f_dentry->d_inode->i_sem);
-			return -EINVAL;
-	}
-	if (offset != file->f_pos) {
-		file->f_pos = offset;
-		if (file->f_pos >= 2) {
-			struct list_head *p;
-			struct dentry *cursor = file->private_data;
-			loff_t n = file->f_pos - 2;
-
-			spin_lock(&dcache_lock);
-			p = file->f_dentry->d_subdirs.next;
-			while (n && p != &file->f_dentry->d_subdirs) {
-				struct dentry *next;
-				next = list_entry(p, struct dentry, d_child);
-				if (!d_unhashed(next) && next->d_inode)
-					n--;
-				p = p->next;
-			}
-			list_del(&cursor->d_child);
-			list_add_tail(&cursor->d_child, p);
-			spin_unlock(&dcache_lock);
-		}
-	}
-	up(&file->f_dentry->d_inode->i_sem);
-	return offset;
-}
-
-/* Relationship between i_mode and the DT_xxx types */
-static inline unsigned char dt_type(struct inode *inode)
-{
-	return (inode->i_mode >> 12) & 15;
-}
-
-/*
- * Directory is locked and all positive dentries in it are safe, since
- * for ramfs-type trees they can't go away without unlink() or rmdir(),
- * both impossible due to the lock on directory.
- */
-
-int dcache_readdir(struct file * filp, void * dirent, filldir_t filldir)
-{
-	struct dentry *dentry = filp->f_dentry;
-	struct dentry *cursor = filp->private_data;
-	struct list_head *p, *q = &cursor->d_child;
-	ino_t ino;
-	int i = filp->f_pos;
-
-	switch (i) {
-		case 0:
-			ino = dentry->d_inode->i_ino;
-			if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
-				break;
-			filp->f_pos++;
-			i++;
-			/* fallthrough */
-		case 1:
-			ino = parent_ino(dentry);
-			if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
-				break;
-			filp->f_pos++;
-			i++;
-			/* fallthrough */
-		default:
-			spin_lock(&dcache_lock);
-			if (filp->f_pos == 2) {
-				list_del(q);
-				list_add(q, &dentry->d_subdirs);
-			}
-			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
-				struct dentry *next;
-				next = list_entry(p, struct dentry, d_child);
-				if (d_unhashed(next) || !next->d_inode)
-					continue;
-
-				spin_unlock(&dcache_lock);
-				if (filldir(dirent, next->d_name.name, next->d_name.len, filp->f_pos, next->d_inode->i_ino, dt_type(next->d_inode)) < 0)
-					return 0;
-				spin_lock(&dcache_lock);
-				/* next is still alive */
-				list_del(q);
-				list_add(q, p);
-				p = q;
-				filp->f_pos++;
-			}
-			spin_unlock(&dcache_lock);
-	}
-	return 0;
-}
-
-ssize_t generic_read_dir(struct file *filp, char *buf, size_t siz, loff_t *ppos)
-{
-	return -EISDIR;
-}
-
-struct file_operations simple_dir_operations = {
-	.open		= dcache_dir_open,
-	.release	= dcache_dir_close,
-	.llseek		= dcache_dir_lseek,
-	.read		= generic_read_dir,
-	.readdir	= dcache_readdir,
-};
-
-struct inode_operations simple_dir_inode_operations = {
-	.lookup		= simple_lookup,
-};
-
-/*
- * Common helper for pseudo-filesystems (sockfs, pipefs, bdev - stuff that
- * will never be mountable)
- */
-struct super_block *
-get_sb_pseudo(struct file_system_type *fs_type, char *name,
-	struct super_operations *ops, unsigned long magic)
-{
-	struct super_block *s = sget(fs_type, NULL, set_anon_super, NULL);
-	static struct super_operations default_ops = {.statfs = simple_statfs};
-	struct dentry *dentry;
-	struct inode *root;
-	struct qstr d_name = {.name = name, .len = strlen(name)};
-
-	if (IS_ERR(s))
-		return s;
-
-	s->s_flags = MS_NOUSER;
-	s->s_maxbytes = ~0ULL;
-	s->s_blocksize = 1024;
-	s->s_blocksize_bits = 10;
-	s->s_magic = magic;
-	s->s_op = ops ? ops : &default_ops;
-	root = new_inode(s);
-	if (!root)
-		goto Enomem;
-	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
-	root->i_uid = root->i_gid = 0;
-	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
-	dentry = d_alloc(NULL, &d_name);
-	if (!dentry) {
-		iput(root);
-		goto Enomem;
-	}
-	dentry->d_sb = s;
-	dentry->d_parent = dentry;
-	d_instantiate(dentry, root);
-	s->s_root = dentry;
-	s->s_flags |= MS_ACTIVE;
-	return s;
-
-Enomem:
-	up_write(&s->s_umount);
-	deactivate_super(s);
-	return ERR_PTR(-ENOMEM);
-}
-
-int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
-{
-	struct inode *inode = old_dentry->d_inode;
-
-	inode->i_nlink++;
-	atomic_inc(&inode->i_count);
-	dget(dentry);
-	d_instantiate(dentry, inode);
-	return 0;
-}
-
-static inline int simple_positive(struct dentry *dentry)
-{
-	return dentry->d_inode && !d_unhashed(dentry);
-}
-
-int simple_empty(struct dentry *dentry)
-{
-	struct dentry *child;
-	int ret = 0;
-
-	spin_lock(&dcache_lock);
-	list_for_each_entry(child, &dentry->d_subdirs, d_child)
-		if (simple_positive(child))
-			goto out;
-	ret = 1;
-out:
-	spin_unlock(&dcache_lock);
-	return ret;
-}
-
-int simple_unlink(struct inode *dir, struct dentry *dentry)
-{
-	struct inode *inode = dentry->d_inode;
-
-	inode->i_nlink--;
-	dput(dentry);
-	return 0;
-}
-
-int simple_rmdir(struct inode *dir, struct dentry *dentry)
-{
-	if (!simple_empty(dentry))
-		return -ENOTEMPTY;
-
-	dentry->d_inode->i_nlink--;
-	simple_unlink(dir, dentry);
-	dir->i_nlink--;
-	return 0;
-}
-
-int simple_rename(struct inode *old_dir, struct dentry *old_dentry,
-		struct inode *new_dir, struct dentry *new_dentry)
-{
-	int they_are_dirs = S_ISDIR(old_dentry->d_inode->i_mode);
-
-	if (!simple_empty(new_dentry))
-		return -ENOTEMPTY;
-
-	if (new_dentry->d_inode) {
-		simple_unlink(new_dir, new_dentry);
-		if (they_are_dirs)
-			old_dir->i_nlink--;
-	} else if (they_are_dirs) {
-		old_dir->i_nlink--;
-		new_dir->i_nlink++;
-	}
-	return 0;
-}
-
-int simple_readpage(struct file *file, struct page *page)
-{
-	void *kaddr;
-
-	if (PageUptodate(page))
-		goto out;
-
-	kaddr = kmap_atomic(page, KM_USER0);
-	memset(kaddr, 0, PAGE_CACHE_SIZE);
-	kunmap_atomic(kaddr, KM_USER0);
-	flush_dcache_page(page);
-	SetPageUptodate(page);
-out:
-	unlock_page(page);
-	return 0;
-}
-
-int simple_prepare_write(struct file *file, struct page *page,
-			unsigned from, unsigned to)
-{
-	if (!PageUptodate(page)) {
-		if (to - from != PAGE_CACHE_SIZE) {
-			void *kaddr = kmap_atomic(page, KM_USER0);
-			memset(kaddr, 0, from);
-			memset(kaddr + to, 0, PAGE_CACHE_SIZE - to);
-			flush_dcache_page(page);
-			kunmap_atomic(kaddr, KM_USER0);
-		}
-		SetPageUptodate(page);
-	}
-	return 0;
-}
-
-int simple_commit_write(struct file *file, struct page *page,
-			unsigned offset, unsigned to)
-{
-	struct inode *inode = page->mapping->host;
-	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
-
-	if (pos > inode->i_size)
-		inode->i_size = pos;
-	set_page_dirty(page);
-	return 0;
-}
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Sat Apr  5 21:29:54 2003
+++ b/fs/namei.c	Sat Apr  5 21:29:54 2003
@@ -2093,8 +2093,7 @@
 	return len;
 }
 
-static inline int
-__vfs_follow_link(struct nameidata *nd, const char *link)
+int vfs_follow_link(struct nameidata *nd, const char *link)
 {
 	int res = 0;
 	char *name;
@@ -2128,101 +2127,3 @@
 	path_release(nd);
 	return PTR_ERR(link);
 }
-
-int vfs_follow_link(struct nameidata *nd, const char *link)
-{
-	return __vfs_follow_link(nd, link);
-}
-
-/* get the link contents into pagecache */
-static char *page_getlink(struct dentry * dentry, struct page **ppage)
-{
-	struct page * page;
-	struct address_space *mapping = dentry->d_inode->i_mapping;
-	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage,
-				NULL);
-	if (IS_ERR(page))
-		goto sync_fail;
-	wait_on_page_locked(page);
-	if (!PageUptodate(page))
-		goto async_fail;
-	*ppage = page;
-	return kmap(page);
-
-async_fail:
-	page_cache_release(page);
-	return ERR_PTR(-EIO);
-
-sync_fail:
-	return (char*)page;
-}
-
-int page_readlink(struct dentry *dentry, char *buffer, int buflen)
-{
-	struct page *page = NULL;
-	char *s = page_getlink(dentry, &page);
-	int res = vfs_readlink(dentry,buffer,buflen,s);
-	if (page) {
-		kunmap(page);
-		page_cache_release(page);
-	}
-	return res;
-}
-
-int page_follow_link(struct dentry *dentry, struct nameidata *nd)
-{
-	struct page *page = NULL;
-	char *s = page_getlink(dentry, &page);
-	int res = __vfs_follow_link(nd, s);
-	if (page) {
-		kunmap(page);
-		page_cache_release(page);
-	}
-	return res;
-}
-
-int page_symlink(struct inode *inode, const char *symname, int len)
-{
-	struct address_space *mapping = inode->i_mapping;
-	struct page *page = grab_cache_page(mapping, 0);
-	int err = -ENOMEM;
-	char *kaddr;
-
-	if (!page)
-		goto fail;
-	err = mapping->a_ops->prepare_write(NULL, page, 0, len-1);
-	if (err)
-		goto fail_map;
-	kaddr = kmap_atomic(page, KM_USER0);
-	memcpy(kaddr, symname, len-1);
-	kunmap_atomic(kaddr, KM_USER0);
-	mapping->a_ops->commit_write(NULL, page, 0, len-1);
-	/*
-	 * Notice that we are _not_ going to block here - end of page is
-	 * unmapped, so this will only try to map the rest of page, see
-	 * that it is unmapped (typically even will not look into inode -
-	 * ->i_size will be enough for everything) and zero it out.
-	 * OTOH it's obviously correct and should make the page up-to-date.
-	 */
-	if (!PageUptodate(page)) {
-		err = mapping->a_ops->readpage(NULL, page);
-		wait_on_page_locked(page);
-	} else {
-		unlock_page(page);
-	}
-	page_cache_release(page);
-	if (err < 0)
-		goto fail;
-	mark_inode_dirty(inode);
-	return 0;
-fail_map:
-	unlock_page(page);
-	page_cache_release(page);
-fail:
-	return err;
-}
-
-struct inode_operations page_symlink_inode_operations = {
-	.readlink	= page_readlink,
-	.follow_link	= page_follow_link,
-};

===================================================================


This BitKeeper patch contains the following changesets:
1.1034
## Wrapped with gzip_uu ##


M'XL( "*1CSX  ]59>W/;-A+_6_P4V\G-G:SJ 1(D)2J5QVWLM)X\G%&23F>:
M&PY(0A)/%,'CPXYZRG?O B1EO>Q$;IR[BS42 ^PN=G_[ L G\#[CZ; Q\V?:
M$_A%9/FPD7E=+PM$'(4Q[XITBA-C(7"B=R/2>0])>RE/1 _GBX\=HVMI2/&&
MY?X,KGF:#1MZEZY'\F7"AXWQQ<_O7_XXUK31")[-6#SE;WD.HY&6B_2:14%V
MQO)9).)NGK(X6_"<=7VQ6*U)5P8A!OY9>I\2RU[I-C'[*U\/=)V9.@^(80YL
M4V/SLT7A=P.^S4F)B9P#?4#-E6'W;5L[![VK$VH"H3UB]H@%ACXD@R%U.L0:
M$@)HY-DN#O"]#1VB_01?5^EGF@]1Z$TR\"/.XB+17H")REK:FUNLM,Z1_S2-
M,**='C1D-<EZ:L7>*S;GDS#B-4HVT?&)K&QJ(U;4MCDU L8=P]#IQ'Z0,'U%
M+(*0GT+,P\@[\S/>+>+LILN#HLL*R<X_)B+-RX=)UO5+X$S$RZ+4,E?$M,A@
MI9N>:=JZ9SJ$>0.+?4:;4F@IK-*&4L-"+PSZ!FIS':;B;($>["99(959L]8*
M4-TRT''H.<,AMK[JVX.!SHF'.A@3C]#/*)"%BR3B6PI@!!HK70I#!>Z/(A00
MLP4/:V7*,'+H8$4H=3",!G:?]HD1\("9'I_<J<R&E%(+@^B6LR*.8] OT6+3
MJUMJZ'V]OZ+!I.]XEL/-@4^,@76G&OO!4>JAVZ9A?#9.L^4"!^=;8!K4Q'2F
M_;ZY"B83T[:IY[" 6-PY7EBE"Y59)VO47DS+6O6:WX!\'NY/:[^"J6E?,]=4
MB2(;]8D,\4/(O?6)/$9]\N&G,'_!><)393[<U09Z^["\ &4=5K+]N3'LV?P;
MD(\#0W] L?OZV.M'8D\?IS<\!QU15!7T"CKIC?J@Q8<0/1ZV2P)4^Z )[U^=
M9:/1^'X$5=424&>)4+-_:SZ[>OW\\F?WXK<W5^-WS]^>2.*JQHKMG%GGUQU)
MLY[_DJPY+O,/90T=FN;_1=;<XO("E'6;3KZ=',.NT8^6-@\ 7S\2?,=Y#/3+
MK'$&NG%GUMP"^J"T<1RMUX))*A9PVV3;<).&><YC\);P8P2_XAX#6CW,L"=A
M[$=%P.$'Y?C>G*<QC[JST[T9W'_@Z ?\0_E3W"7G,PY24_!%C*+S#,(X%Y"P
M*?>9CY.X0):S//3!G[$46G+&14[)U,SRM/!S") Q74*K_&U#-2Q)H=5*Y.^)
M]A^ML36N?IZN!UD0I#S+W"QA/LXN6)*$\11&E?#.:>"&L0AXYS1TJTED5J)&
MD'(6N$I?5XXT*X(VD#8T,4$BGKHYM$ZJ\<XI<T62=4XEGV1H:UB?&J_?OWQY
M@D+#"30+C*(YCY;-R[?NQ7C<5#:<G"#=5.2R?L6^.V%AA.0W+,Q=$:N5W4CX
M<QZ4Y+NBOGN#H^^37 0LY[L2V:;($C,TK,(HY7F1QC!'_6O1'[1;CF$)1(5 
MRG&GG_&U#A4S6N&^>3=N=BXNKQ3_)GM%TY0^;IV4JWY"&@P&I8,KD;K/Y65P
M>,5DPM.VC"' YXC'^WZO+)-@HW(E7U:9N@ZL6NS?UT"B1(P/I+N>9+?:5'35
MNN62[:Q&OL*]1!I0D<:\B#<P;-P'VZ<U*KCN#AH3$47BQOV"'%"YB_YFT(J#
MQP%C4YDXP)4?W?RJNM6FJ[R$EOIIRT*2Y54\(*$$H R(G6BX,^$/I/DAS*8I
M\P[G? T13U.DZUR\OGIU\6H-[UPN+.-_)SE+F.ITK!*Q%+%;-A)LLBSEKJS'
MO"F=UU:ZJ7J#9G;TO=Q'0=O"I75(I+3!)61JNRP7B]!OEJ)>O'+?O[T8*VL6
M?.$GRZ8B;L,:U?52I5]K_HIL2\".!=CV%EBU[C4 $>JUM 96ZM<"ZS_'7L%R
MN.& IH,;B]R%J9 N0XL\6?=@QG&F SP.0$Q*;X69DJ#T2[B,3H%RP@QNL"H#
M]NHER+1!$4B@NA$&15ZS(SGG2H!:.\1/MI8%S7R9A#Z+4 :_QK:H1*)>$ DQ
M+_M8&9H=)4*&5!;^P4LZCZ.>HIC.8")2R9\N4:]X>@(,U?^#8V_%Y421=Q7S
MU;NK7W#@'QD([SH418:+^B)-N8QD9,AFHH@"-&+.E17*^"+IY*(CJ[T2TBMC
MXE ;4-EY.-CJ'K7A)I6[][6=3\"CC"NA&($X5Z;(1F[?D_F[<0L_8$KM)L:"
MI?.R(;M!F.;+IGK>:#?DJ5:'.?:70UK<K<)V4T(5ROJS66X0&Y[BM@2+S59-
M<O=F1Q*&;MTQ&J/M?H:=O[M10.OIC:&V]NGI [>RUHJH7:+<NAK;MX'ZT+K_
M-A!/?,8WN0TL[R4>92-KXD9Y=P<JX<68D-O0<VHAP:7ZWFU8\%W9%55JG)M]
M2:B^[R7<.BG6=W3RH/B5;P<U-D\69T$XY4+ZX??:2_^\2Z2,":K;QL"B*TIU
MISK.T*WSC#[X+QTFQUSV$W6(WE4>J^8>HD+>&>B&0>Z,FC7A\4'SF4RK)6_=
M>^*9L=1'@6IN@4KIT+"^/:C/MF'=5OX0J/)<7MX>?P;4AV1BE1>;]XU?^6I6
MF[/P+$_T;EK,TDX1AQU/^+-B(5^7[%V1&80:ABZ%Z8[1+W/!ZA]9( WHT&]3
M(-4E\KY7_L+-V/E UC/YI2['8#AJE#X&;%PQ!H@ZT*K=&?Y'+N+FS%,W9^51
M!Q\^:.>Z(<6H[T9#4F7++.>+#&=EY*F=M;QLX_]VY2P^?F1Y7C';#K)5@5'=
M,'Q17!SUXN#>0KGS\D#51U.^0^G;5,5$GQP9$SIT=/)M7J*I-QS[05'9])"8
M,(AC@Z%=XJ]L=/($LWN\.W2HW#YQ2;(3E(5='9S!SM5I]<Y(NOFOOZ!2A3K*
M<LSP;;=N2)%N172)89$51<#TLD+;NVV/&O\;%7JGW]6 R2*@WJO=N4NJ"8]W
<^_I=-NZ#_7E6+$9^WYE8WJ"O_0G-Q8FV/Q\     
 
