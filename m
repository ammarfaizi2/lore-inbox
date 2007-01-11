Return-Path: <linux-kernel-owner+w=401wt.eu-S965276AbXAKAZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbXAKAZH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 19:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbXAKAZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 19:25:07 -0500
Received: from mail.alkar.net ([195.248.191.95]:50103 "EHLO mail.alkar.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965285AbXAKAZF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 19:25:05 -0500
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc4: known unfixed regressions (v2)
Date: Thu, 11 Jan 2007 03:24:42 +0300
User-Agent: KMail/1.8.2
Cc: reiserfs-dev@namesys.com,
       Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <200701091908.44576.MalteSch@gmx.de> <Pine.LNX.4.64.0701091022180.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701091022180.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701110324.42920.vs@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tuesday 09 January 2007 21:30, Linus Torvalds wrote:
> 
> On Tue, 9 Jan 2007, Malte Schröder wrote:
> > 
> > > So something interesting is definitely going on, but I don't know exactly
> > > what it is. Why does reiserfs do the truncate as part of a close, if the
> > > same inode is actually mapped somewhere else? 

on file close reiserfs tries to "pack" content of last incomplete page of file into metadata blocks.
It should not if that page is still mapped somewhere. 
It does not actually truncate, it calls the same function which does truncate, but file size does not change.

Please consider the below patch.

From: Vladimir Saveliev <vs@namesys.com>

This patch fixes a confusion reiserfs has for a long time.

On release file operation reiserfs used to try to pack file data stored in last incomplete page of some files
into metadata blocks. After packing the page got cleared with clear_page_dirty.
It did not take into account that the page may be mmaped into
other process's address space. Recent replacement for clear_page_dirty cancel_dirty_page found the confusion
with sanity check that page has to be not mapped.

The patch fixes the confusion by making reiserfs to avoid tail packing if an inode was ever mmapped.
reiserfs_mmap and reiserfs_file_release are serialized with mutex in reiserfs specific inode.
reiserfs_mmap locks the mutex and sets a bit in reiserfs specific inode flags.
reiserfs_file_release checks the bit having the mutex locked. If bit is set - tail packing is avoided.
This eliminates a possibility that mmapped page gets cancel_page_dirty-ed.

Signed-off-by: Vladimir Saveliev <vs@namesys.com>



diff -puN fs/reiserfs/file.c~reiserfs-dont-convert-if-tail-page-mapped fs/reiserfs/file.c
--- linux-2.6.20-rc4/fs/reiserfs/file.c~reiserfs-dont-convert-if-tail-page-mapped	2007-01-11 02:09:19.000000000 +0300
+++ linux-2.6.20-rc4-vs/fs/reiserfs/file.c	2007-01-11 02:09:19.000000000 +0300
@@ -48,6 +48,11 @@ static int reiserfs_file_release(struct 
 	}
 
 	mutex_lock(&inode->i_mutex);
+
+	mutex_lock(&(REISERFS_I(inode)->i_mmap));
+	if (REISERFS_I(inode)->i_flags & i_ever_mapped)
+		REISERFS_I(inode)->i_flags &= ~i_pack_on_close_mask;
+
 	reiserfs_write_lock(inode->i_sb);
 	/* freeing preallocation only involves relogging blocks that
 	 * are already in the current transaction.  preallocation gets
@@ -100,11 +105,24 @@ static int reiserfs_file_release(struct 
 		err = reiserfs_truncate_file(inode, 0);
 	}
       out:
+	mutex_unlock(&(REISERFS_I(inode)->i_mmap));
 	mutex_unlock(&inode->i_mutex);
 	reiserfs_write_unlock(inode->i_sb);
 	return err;
 }
 
+static int reiserfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode;
+
+	inode = file->f_path.dentry->d_inode;
+	mutex_lock(&(REISERFS_I(inode)->i_mmap));
+	REISERFS_I(inode)->i_flags |= i_ever_mapped;
+	mutex_unlock(&(REISERFS_I(inode)->i_mmap));
+	
+	return generic_file_mmap(file, vma);
+}
+
 static void reiserfs_vfs_truncate_file(struct inode *inode)
 {
 	reiserfs_truncate_file(inode, 1);
@@ -1527,7 +1545,7 @@ const struct file_operations reiserfs_fi
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = reiserfs_compat_ioctl,
 #endif
-	.mmap = generic_file_mmap,
+	.mmap = reiserfs_file_mmap,
 	.open = generic_file_open,
 	.release = reiserfs_file_release,
 	.fsync = reiserfs_sync_file,
diff -puN fs/reiserfs/inode.c~reiserfs-dont-convert-if-tail-page-mapped fs/reiserfs/inode.c
--- linux-2.6.20-rc4/fs/reiserfs/inode.c~reiserfs-dont-convert-if-tail-page-mapped	2007-01-11 02:09:19.000000000 +0300
+++ linux-2.6.20-rc4-vs/fs/reiserfs/inode.c	2007-01-11 02:14:57.000000000 +0300
@@ -1125,6 +1125,7 @@ static void init_inode(struct inode *ino
 	REISERFS_I(inode)->i_prealloc_count = 0;
 	REISERFS_I(inode)->i_trans_id = 0;
 	REISERFS_I(inode)->i_jl = NULL;
+	mutex_init(&(REISERFS_I(inode)->i_mmap));
 	reiserfs_init_acl_access(inode);
 	reiserfs_init_acl_default(inode);
 	reiserfs_init_xattr_rwsem(inode);
@@ -1832,6 +1833,7 @@ int reiserfs_new_inode(struct reiserfs_t
 	REISERFS_I(inode)->i_attrs =
 	    REISERFS_I(dir)->i_attrs & REISERFS_INHERIT_MASK;
 	sd_attrs_to_i_attrs(REISERFS_I(inode)->i_attrs, inode);
+	mutex_init(&(REISERFS_I(inode)->i_mmap));
 	reiserfs_init_acl_access(inode);
 	reiserfs_init_acl_default(inode);
 	reiserfs_init_xattr_rwsem(inode);
diff -puN include/linux/reiserfs_fs_i.h~reiserfs-dont-convert-if-tail-page-mapped include/linux/reiserfs_fs_i.h
--- linux-2.6.20-rc4/include/linux/reiserfs_fs_i.h~reiserfs-dont-convert-if-tail-page-mapped	2007-01-11 02:09:19.000000000 +0300
+++ linux-2.6.20-rc4-vs/include/linux/reiserfs_fs_i.h	2007-01-11 02:09:19.000000000 +0300
@@ -25,6 +25,7 @@ typedef enum {
 	i_link_saved_truncate_mask = 0x0020,
 	i_has_xattr_dir = 0x0040,
 	i_data_log = 0x0080,
+	i_ever_mapped = 0x0100
 } reiserfs_inode_flags;
 
 struct reiserfs_inode_info {
@@ -52,6 +53,7 @@ struct reiserfs_inode_info {
 	 ** flushed */
 	unsigned long i_trans_id;
 	struct reiserfs_journal_list *i_jl;
+	struct mutex i_mmap;
 #ifdef CONFIG_REISERFS_FS_POSIX_ACL
 	struct posix_acl *i_acl_access;
 	struct posix_acl *i_acl_default;

_



> > > And if it's a race with two 
> > > different CPU's (one doing a "munmap()" and the other doing a "close()",
> > > then the unmap should _still_ have actually unmapped the pages before it
> > > actually did _its_ "release()" call.
> > 
> > This was on a single core. But with CONFIG_PREEMPT_VOLUNTARY=y.
> > It didn't happen again since then. 
> 
> Yeah, PREEMPT would be able to show most races like this too. In fact, 
> some races show up much better with preemption than they do with real SMP.
> 
> But I haven't looked at what exactly reiserfs does. I did check that the 
> VM layer definitely does the remove_vma() stuff (that actually closes the 
> files) _after_ it has unmapped everything. It would have surprised me if 
> we had had that kind of bug, but still..
> 
> 		Linus
