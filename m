Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267584AbSKQULQ>; Sun, 17 Nov 2002 15:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267583AbSKQULQ>; Sun, 17 Nov 2002 15:11:16 -0500
Received: from mons.uio.no ([129.240.130.14]:33517 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267584AbSKQULK>;
	Sun, 17 Nov 2002 15:11:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15831.63868.96933.508631@helicity.uio.no>
Date: Sun, 17 Nov 2002 21:18:04 +0100
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, richard@bouska.cz
Subject: Re: NFS mountned  directory  and apache2 (2.5.47)
In-Reply-To: <20021116044454.A31763@infradead.org>
References: <79A23782BB8@vcnet.vc.cvut.cz>
	<15829.22032.166977.73195@helicity.uio.no>
	<20021115202649.A18706@infradead.org>
	<15829.24239.643774.231548@helicity.uio.no>
	<20021116044454.A31763@infradead.org>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christoph Hellwig <hch@infradead.org> writes:

     > just a little bit more then one line :) nfs needs to do the
     > same revalidation as in nfs_file_read and then call
     > generic_file_sendfile.

Duh, I must have eaten a bad mushroom at dinner. Thanks for staying
awake...

The correct patch is of course as appended.

Cheers,
  Trond

--- linux-2.5.47/fs/nfs/file.c	2002-11-08 14:16:27.000000000 -0500
+++ linux-2.5.47-01-sendfile/fs/nfs/file.c	2002-11-17 15:15:04.000000000 -0500
@@ -35,6 +35,7 @@
 #define NFSDBG_FACILITY		NFSDBG_FILE
 
 static int  nfs_file_mmap(struct file *, struct vm_area_struct *);
+static ssize_t nfs_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
 static ssize_t nfs_file_read(struct kiocb *, char *, size_t, loff_t);
 static ssize_t nfs_file_write(struct kiocb *, const char *, size_t, loff_t);
 static int  nfs_file_flush(struct file *);
@@ -52,6 +53,7 @@
 	.release	= nfs_release,
 	.fsync		= nfs_fsync,
 	.lock		= nfs_lock,
+	.sendfile	= nfs_file_sendfile,
 };
 
 struct inode_operations nfs_file_inode_operations = {
@@ -102,6 +104,24 @@
 	return result;
 }
 
+static ssize_t
+nfs_file_sendfile(struct file *filp, loff_t *ppos, size_t count,
+		read_actor_t actor, void *target)
+{
+	struct dentry *dentry = filp->f_dentry;
+	struct inode *inode = dentry->d_inode;
+	ssize_t res;
+
+	dfprintk(VFS, "nfs: sendfile(%s/%s, %lu@%Lu)\n",
+		dentry->d_parent->d_name.name, dentry->d_name.name,
+		(unsigned long) count, (unsigned long long) *ppos);
+
+	res = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	if (!res)
+		res = generic_file_sendfile(filp, ppos, count, actor, target);
+	return res;
+}
+
 static int
 nfs_file_mmap(struct file * file, struct vm_area_struct * vma)
 {
