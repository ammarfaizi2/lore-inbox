Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291746AbSBAMxb>; Fri, 1 Feb 2002 07:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291747AbSBAMxU>; Fri, 1 Feb 2002 07:53:20 -0500
Received: from mons.uio.no ([129.240.130.14]:24270 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S291746AbSBAMxE>;
	Fri, 1 Feb 2002 07:53:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15450.36775.470342.23126@charged.uio.no>
Date: Fri, 1 Feb 2002 13:52:55 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.3] Drop reliance on file->f_dentry in NFS reads/writes
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following a request by David Chow on linux fsdevel, this patch causes
NFS read and write requests to take the inode from page->mapping->host
rather than relying on file->f_dentry->d_inode. Apparently this will
simplify some work he is doing on another filesystem.

In any case, it cleans up the current mix of sometimes doing one
thing, sometimes the other (historical cruft), and puts NFS client
behaviour on par with what is done in other filesystems...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.3-fix_put/fs/nfs/read.c linux-2.5.3-fix_mapping/fs/nfs/read.c
--- linux-2.5.3-fix_put/fs/nfs/read.c	Thu Jan 31 16:05:53 2002
+++ linux-2.5.3-fix_mapping/fs/nfs/read.c	Thu Jan 31 16:06:40 2002
@@ -452,19 +452,9 @@
 int
 nfs_readpage(struct file *file, struct page *page)
 {
-	struct inode *inode;
+	struct inode *inode = page->mapping->host;
 	int		error;
 
-	if (!file) {
-		struct address_space *mapping = page->mapping;
-		if (!mapping)
-			BUG();
-		inode = mapping->host;
-	} else
-		inode = file->f_dentry->d_inode;
-	if (!inode)
-		BUG();
-
 	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
 		page, PAGE_CACHE_SIZE, page->index);
 	/*
diff -u --recursive --new-file linux-2.5.3-fix_put/fs/nfs/write.c linux-2.5.3-fix_mapping/fs/nfs/write.c
--- linux-2.5.3-fix_put/fs/nfs/write.c	Thu Jan 31 16:05:53 2002
+++ linux-2.5.3-fix_mapping/fs/nfs/write.c	Thu Jan 31 16:06:40 2002
@@ -239,17 +239,11 @@
 int
 nfs_writepage(struct page *page)
 {
-	struct inode *inode;
+	struct inode *inode = page->mapping->host;
 	unsigned long end_index;
 	unsigned offset = PAGE_CACHE_SIZE;
 	int err;
-	struct address_space *mapping = page->mapping;
 
-	if (!mapping)
-		BUG();
-	inode = mapping->host;
-	if (!inode)
-		BUG();
 	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 
 	/* Ensure we've flushed out any previous writes */
@@ -769,7 +763,7 @@
 int
 nfs_flush_incompatible(struct file *file, struct page *page)
 {
-	struct inode	*inode = file->f_dentry->d_inode;
+	struct inode	*inode = page->mapping->host;
 	struct nfs_page	*req;
 	int		status = 0;
 	/*
@@ -799,7 +793,7 @@
 nfs_updatepage(struct file *file, struct page *page, unsigned int offset, unsigned int count)
 {
 	struct dentry	*dentry = file->f_dentry;
-	struct inode	*inode = dentry->d_inode;
+	struct inode	*inode = page->mapping->host;
 	struct nfs_page	*req;
 	loff_t		end;
 	int		status = 0;

