Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136573AbREIP4h>; Wed, 9 May 2001 11:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136576AbREIP42>; Wed, 9 May 2001 11:56:28 -0400
Received: from mons.uio.no ([129.240.130.14]:48369 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S136573AbREIP4S>;
	Wed, 9 May 2001 11:56:18 -0400
MIME-Version: 1.0
Message-ID: <15097.26760.222369.483083@charged.uio.no>
Date: Wed, 9 May 2001 17:55:52 +0200
To: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Linux-2.4.4 flush out dirty NFS pages on munmap()
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan and Linus,

 The Suse people have identified a problem with shared mmap() under
Linux 2.4.

Basically it boils down to the fact that we want to commit pages to
the server when we munmap() both in order to ensure that they are
flushed out with the correct credentials (page launder is too
unreliable in that respect), and to ensure that file close-to-open
cache consistency is maintained.

The following patch by Andrea passes the test that Kurt Garloff put
out on Linux Kernel, both on my setup and on his. As you can see it
hooks the vm_ops and installs a vma close method that calls
filemap_fdatasync() for us, then flushes out those pages and puts them
on the clean_pages list.
I also added in similar protection around the locking code. I'm not
sure if anybody is using locking + shared mmap(), but if they do, then
we want to try to ensure data cache consistency.

Please note: there remains a question about what to do when
page_launder() clears the PG_dirty bit for us, and yet writepage()
receives an error. I'm nervous about just automatically marking the
page as dirty again, as that could easily lead to infinite loops. For
the moment, therefore, I'd prefer to delay making a decision about
that case...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.4/fs/nfs/file.c linux-2.4.4-mmap/fs/nfs/file.c
--- linux-2.4.4/fs/nfs/file.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.4-mmap/fs/nfs/file.c	Wed May  9 17:30:26 2001
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
@@ -104,6 +110,21 @@
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
+		down(&inode->i_sem);
+		nfs_wb_all(inode);
+		up(&inode->i_sem);
+		filemap_fdatawait(inode->i_mapping);
+	}
+}
+
 static int
 nfs_file_mmap(struct file * file, struct vm_area_struct * vma)
 {
@@ -115,8 +136,11 @@
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
 
@@ -283,9 +307,11 @@
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
 
@@ -300,10 +326,12 @@
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
