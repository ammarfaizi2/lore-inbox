Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136094AbREJMAl>; Thu, 10 May 2001 08:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136084AbREJMAc>; Thu, 10 May 2001 08:00:32 -0400
Received: from zeus.kernel.org ([209.10.41.242]:61671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135900AbREJMAV>;
	Thu, 10 May 2001 08:00:21 -0400
MIME-Version: 1.0
Message-ID: <15098.27168.109682.272225@charged.uio.no>
Date: Thu, 10 May 2001 12:14:56 +0200
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>, Kurt Garloff <garloff@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs MAP_SHARED corruption fix
In-Reply-To: <Pine.LNX.4.21.0105092045410.15984-100000@freak.distro.conectiva>
In-Reply-To: <20010510031652.G2506@athlon.random>
	<Pine.LNX.4.21.0105092045410.15984-100000@freak.distro.conectiva>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Marcelo Tosatti <marcelo@conectiva.com.br> writes:

     > I suggested the removal of I_DIRTY_PAGES check because the
     > current behaviour of munmap seems to be synchronous (1), so I
     > guess you _always_ want it to be synchronous.

Revised patch (+ necessary change in ksyms.c) follows.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.4/fs/nfs/file.c linux-2.4.4-mmap/fs/nfs/file.c
--- linux-2.4.4/fs/nfs/file.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.4-mmap/fs/nfs/file.c	Thu May 10 12:12:38 2001
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
@@ -104,6 +110,19 @@
 	return result;
 }
 
+static void nfs_file_close_vma(struct vm_area_struct * vma)
+{
+	struct inode * inode;
+
+	inode = vma->vm_file->f_dentry->d_inode;
+
+	filemap_fdatasync(inode->i_mapping);
+	down(&inode->i_sem);
+	nfs_wb_all(inode);
+	up(&inode->i_sem);
+	filemap_fdatawait(inode->i_mapping);
+}
+
 static int
 nfs_file_mmap(struct file * file, struct vm_area_struct * vma)
 {
@@ -115,8 +134,11 @@
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
 
@@ -283,9 +305,11 @@
 	 * Flush all pending writes before doing anything
 	 * with locks..
 	 */
-	down(&filp->f_dentry->d_inode->i_sem);
+	filemap_fdatasync(inode->i_mapping);
+	down(&inode->i_sem);
 	status = nfs_wb_all(inode);
-	up(&filp->f_dentry->d_inode->i_sem);
+	up(&inode->i_sem);
+	filemap_fdatawait(inode->i_mapping);
 	if (status < 0)
 		return status;
 
@@ -300,10 +324,12 @@
 	 */
  out_ok:
 	if ((cmd == F_SETLK || cmd == F_SETLKW) && fl->fl_type != F_UNLCK) {
-		down(&filp->f_dentry->d_inode->i_sem);
+		filemap_fdatasync(inode->i_mapping);
+		down(&inode->i_sem);
 		nfs_wb_all(inode);      /* we may have slept */
+		up(&inode->i_sem);
+		filemap_fdatawait(inode->i_mapping);
 		nfs_zap_caches(inode);
-		up(&filp->f_dentry->d_inode->i_sem);
 	}
 	return status;
 }
diff -u --recursive --new-file linux-2.4.4/kernel/ksyms.c linux-2.4.4-mmap/kernel/ksyms.c
--- linux-2.4.4/kernel/ksyms.c	Fri Apr 27 23:23:25 2001
+++ linux-2.4.4-mmap/kernel/ksyms.c	Wed May  9 18:05:58 2001
@@ -262,6 +262,8 @@
 EXPORT_SYMBOL(dentry_open);
 EXPORT_SYMBOL(filemap_nopage);
 EXPORT_SYMBOL(filemap_sync);
+EXPORT_SYMBOL(filemap_fdatasync);
+EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 
 /* device registration */
