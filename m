Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFKgG>; Wed, 6 Dec 2000 05:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbQLFKf5>; Wed, 6 Dec 2000 05:35:57 -0500
Received: from pat.uio.no ([129.240.130.16]:23787 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129183AbQLFKfp>;
	Wed, 6 Dec 2000 05:35:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14894.3921.666596.67064@charged.uio.no>
Date: Wed, 6 Dec 2000 11:05:05 +0100 (CET)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Urban Widmark <urban@teststation.com>, Alexander Viro <aviro@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smbfs writepage & struct file
In-Reply-To: <Pine.LNX.4.10.10012051530100.13428-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0012051959090.3205-100000@cola.svenskatest.se>
	<Pine.LNX.4.10.10012051530100.13428-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

    >> I was "borrowing" stuff from the nfs code and this looked
    >> strange:
    >>
    >> nfs_writepage_sync: struct dentry *dentry = file->f_dentry;
    >> struct rpc_cred *cred = nfs_file_cred(file);
    >>
    >> yet it is called like this from nfs_writepage: err =
    >> nfs_writepage_sync(NULL, inode, page, 0, offset);
    >>
    >> where file is the 1st argument. Oh, it calls
    >> nfs_writepage_async most of the time. All of the time?

     > That's bogus. But Trond probably overlooked it in testing,
     > because yes, it always calls the async version unless there has
     > been errors doing async writes (which should be rather
     > uncommon).

     > Trond? Can you massage the sync version to do the same as the
     > async one?

Oops. That was due to a stupid oversight... I grepped for dependencies
upon dentry->d_inode, but forgot to do the same in order to weed out
the remaining file->f_dentry.

The appended patch should remove the last 'struct file' dependencies
from both readpage() and writepage().

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.0-test12-pre6/fs/nfs/read.c linux-2.4.0-test12-fixme/fs/nfs/read.c
--- linux-2.4.0-test12-pre6/fs/nfs/read.c	Wed Dec  6 08:34:53 2000
+++ linux-2.4.0-test12-fixme/fs/nfs/read.c	Wed Dec  6 08:41:54 2000
@@ -84,8 +84,7 @@
 static int
 nfs_readpage_sync(struct file *file, struct inode *inode, struct page *page)
 {
-	struct dentry	*dentry = file->f_dentry;
-	struct rpc_cred	*cred = nfs_file_cred(file);
+	struct rpc_cred	*cred = NULL;
 	struct nfs_fattr fattr;
 	loff_t		offset = page_offset(page);
 	char		*buffer;
@@ -97,6 +96,9 @@
 
 	dprintk("NFS: nfs_readpage_sync(%p)\n", page);
 
+	if (file)
+		cred = nfs_file_cred(file);
+
 	/*
 	 * This works now because the socket layer never tries to DMA
 	 * into this buffer directly.
@@ -106,9 +108,9 @@
 		if (count < rsize)
 			rsize = count;
 
-		dprintk("NFS: nfs_proc_read(%s, (%s/%s), %Ld, %d, %p)\n",
+		dprintk("NFS: nfs_proc_read(%s, (%x/%Ld), %Ld, %d, %p)\n",
 			NFS_SERVER(inode)->hostname,
-			dentry->d_parent->d_name.name, dentry->d_name.name,
+			inode->i_dev, (long long)NFS_FILEID(inode),
 			(long long)offset, rsize, buffer);
 
 		lock_kernel();
diff -u --recursive --new-file linux-2.4.0-test12-pre6/fs/nfs/write.c linux-2.4.0-test12-fixme/fs/nfs/write.c
--- linux-2.4.0-test12-pre6/fs/nfs/write.c	Wed Dec  6 08:34:53 2000
+++ linux-2.4.0-test12-fixme/fs/nfs/write.c	Wed Dec  6 08:43:52 2000
@@ -171,8 +171,7 @@
 nfs_writepage_sync(struct file *file, struct inode *inode, struct page *page,
 		   unsigned int offset, unsigned int count)
 {
-	struct dentry	*dentry = file->f_dentry;
-	struct rpc_cred	*cred = nfs_file_cred(file);
+	struct rpc_cred	*cred = NULL;
 	loff_t		base;
 	unsigned int	wsize = NFS_SERVER(inode)->wsize;
 	int		result, refresh = 0, written = 0, flags;
@@ -180,9 +179,13 @@
 	struct nfs_fattr fattr;
 	struct nfs_writeverf verf;
 
+
+	if (file)
+		cred = nfs_file_cred(file);
+
 	lock_kernel();
-	dprintk("NFS:      nfs_writepage_sync(%s/%s %d@%Ld)\n",
-		dentry->d_parent->d_name.name, dentry->d_name.name,
+	dprintk("NFS:      nfs_writepage_sync(%x/%Ld %d@%Ld)\n",
+		inode->i_dev, (long long)NFS_FILEID(inode),
 		count, (long long)(page_offset(page) + offset));
 
 	buffer = kmap(page) + offset;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
