Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135885AbREIHaz>; Wed, 9 May 2001 03:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135889AbREIHao>; Wed, 9 May 2001 03:30:44 -0400
Received: from mons.uio.no ([129.240.130.14]:49615 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S135885AbREIHaY>;
	Wed, 9 May 2001 03:30:24 -0400
MIME-Version: 1.0
Message-ID: <15096.61962.130340.998058@charged.uio.no>
Date: Wed, 9 May 2001 09:30:18 +0200
To: Kurt Garloff <garloff@suse.de>, Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs MAP_SHARED corruption fix
In-Reply-To: <20010508173847.I22739@garloff.suse.de>
In-Reply-To: <20010508160050.F543@athlon.random>
	<shs3dafvpcx.fsf@charged.uio.no>
	<20010508173847.I22739@garloff.suse.de>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In addition to the two changes I proposed to Andrea's new patch, I
also realized we might want to do a fdatasync() when locking files. If
we don't, then locking won't be atomic on mmap()...

Here therefore is Andrea's patch with the changes I propose. Opinions?

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.4-fixes/fs/nfs/file.c linux-2.4.4-mmap/fs/nfs/file.c
--- linux-2.4.4/fs/nfs/file.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.4-mmap/fs/nfs/file.c	Wed May  9 09:18:45 2001
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
+		down(&inode->i_sem);
+		filemap_fdatasync(inode->i_mapping);
+		nfs_wb_all(inode);
+		up(&inode->i_sem);
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
 
@@ -283,9 +306,10 @@
 	 * Flush all pending writes before doing anything
 	 * with locks..
 	 */
-	down(&filp->f_dentry->d_inode->i_sem);
+	down(&inode->i_sem);
+	filemap_fdatasync(inode->i_mapping);
 	status = nfs_wb_all(inode);
-	up(&filp->f_dentry->d_inode->i_sem);
+	up(&inode->i_sem);
 	if (status < 0)
 		return status;
 
@@ -300,10 +324,11 @@
 	 */
  out_ok:
 	if ((cmd == F_SETLK || cmd == F_SETLKW) && fl->fl_type != F_UNLCK) {
-		down(&filp->f_dentry->d_inode->i_sem);
+		down(&inode->i_sem);
+		filemap_fdatasync(inode->i_mapping);
 		nfs_wb_all(inode);      /* we may have slept */
 		nfs_zap_caches(inode);
-		up(&filp->f_dentry->d_inode->i_sem);
+		up(&inode->i_sem);
 	}
 	return status;
 }
