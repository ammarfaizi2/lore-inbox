Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbREICtV>; Tue, 8 May 2001 22:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131307AbREICtD>; Tue, 8 May 2001 22:49:03 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:52829 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130487AbREICsk>; Tue, 8 May 2001 22:48:40 -0400
Date: Wed, 9 May 2001 04:48:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs MAP_SHARED corruption fix
Message-ID: <20010509044826.B2506@athlon.random>
In-Reply-To: <20010508160050.F543@athlon.random> <shs3dafvpcx.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shs3dafvpcx.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, May 08, 2001 at 05:21:02PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2001 at 05:21:02PM +0200, Trond Myklebust wrote:
> AFAICs this fix will clearly deadlock...

yeah, it didn't triggered because it probably needs to be the same page
writepaged and in the dirty list at the same time. I hooked it very deep
into the writeback logic to keep it generic (it wasn't going to add a
significant overhead) but it didn't need to be _that_ deep.

Even worse I think it was partly wrong because it was only in the
close(2) path but not in the fput path that is the one walked by munmap.

This looks better to me, what do you think?

diff -urN ref/fs/nfs/file.c nfs-corruption/fs/nfs/file.c
--- ref/fs/nfs/file.c	Thu Feb 22 03:45:10 2001
+++ nfs-corruption/fs/nfs/file.c	Tue May  8 19:11:57 2001
@@ -39,6 +39,7 @@
 static ssize_t nfs_file_write(struct file *, const char *, size_t, loff_t *);
 static int  nfs_file_flush(struct file *);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
+static void nfs_file_close_vma(struct vm_area_struct *);
 
 struct file_operations nfs_file_operations = {
 	read:		nfs_file_read,
@@ -57,6 +58,11 @@
 	setattr:	nfs_notify_change,
 };
 
+static struct vm_operations_struct nfs_file_vm_ops = {
+	nopage:		filemap_nopage,
+	close:		nfs_file_close_vma,
+};
+
 /* Hack for future NFS swap support */
 #ifndef IS_SWAPFILE
 # define IS_SWAPFILE(inode)	(0)
@@ -104,6 +110,20 @@
 	return result;
 }
 
+static void nfs_file_close_vma(struct vm_area_struct * vma)
+{
+	struct inode * inode;
+
+	inode = vma->vm_file->f_dentry->d_inode;
+
+	if (inode->i_state & I_DIRTY_PAGES) {
+		filemap_fdatasync(inode->i_mapping);
+		lock_kernel();
+		nfs_wb_file(inode, vma->vm_file);
+		unlock_kernel();
+	}
+}
+
 static int
 nfs_file_mmap(struct file * file, struct vm_area_struct * vma)
 {
@@ -115,8 +135,11 @@
 		dentry->d_parent->d_name.name, dentry->d_name.name);
 
 	status = nfs_revalidate_inode(NFS_SERVER(inode), inode);
-	if (!status)
+	if (!status) {
 		status = generic_file_mmap(file, vma);
+		if (!status)
+			vma->vm_ops = &nfs_file_vm_ops;
+	}
 	return status;
 }
 

Andrea
