Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVAONfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVAONfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVAONfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:35:47 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11176 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262279AbVAON3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:29:16 -0500
Subject: [PATCH 4/6] cifs: remove spurious casts
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: sfrench@samba.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1105795682.9555.5.camel@localhost>
References: <1105795546.9555.2.camel@localhost>
	 <1105795614.9555.3.camel@localhost>  <1105795682.9555.5.camel@localhost>
Date: Sat, 15 Jan 2005 15:29:11 +0200
Message-Id: <1105795751.9555.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spurious void pointer casts.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 cifsfs.c    |    9 ++++-----
 dir.c       |    6 ++----
 file.c      |   32 +++++++++++++-------------------
 misc.c      |   17 ++++-------------
 readdir.c   |    6 +++---
 transport.c |    5 ++---
 6 files changed, 28 insertions(+), 47 deletions(-)

Index: linux/fs/cifs/cifsfs.c
===================================================================
--- linux.orig/fs/cifs/cifsfs.c	2005-01-12 20:13:39.874862088 +0200
+++ linux/fs/cifs/cifsfs.c	2005-01-12 20:13:47.453709928 +0200
@@ -221,10 +221,9 @@
 static struct inode *
 cifs_alloc_inode(struct super_block *sb)
 {
-	struct cifsInodeInfo *cifs_inode;
-	cifs_inode =
-	    (struct cifsInodeInfo *) kmem_cache_alloc(cifs_inode_cachep,
-						      SLAB_KERNEL);
+	struct cifsInodeInfo *cifs_inode =
+		kmem_cache_alloc(cifs_inode_cachep, SLAB_KERNEL);
+
 	if (!cifs_inode)
 		return NULL;
 	cifs_inode->cifsAttrs = 0x20;	/* default */
@@ -578,7 +577,7 @@
 static void
 cifs_init_once(void *inode, kmem_cache_t * cachep, unsigned long flags)
 {
-	struct cifsInodeInfo *cifsi = (struct cifsInodeInfo *) inode;
+	struct cifsInodeInfo *cifsi = inode;
 
 	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
Index: linux/fs/cifs/dir.c
===================================================================
--- linux.orig/fs/cifs/dir.c	2005-01-12 20:13:40.114825608 +0200
+++ linux/fs/cifs/dir.c	2005-01-12 20:13:47.454709776 +0200
@@ -284,12 +284,10 @@
 			/* mknod case - do not leave file open */
 			CIFSSMBClose(xid, pTcon, fileHandle);
 		} else if(newinode) {
-			pCifsFile = (struct cifsFileInfo *)
-			   kmalloc(sizeof (struct cifsFileInfo), GFP_KERNEL);
+			pCifsFile = kmalloc(sizeof (struct cifsFileInfo), GFP_KERNEL);
 		
 			if (pCifsFile) {
-				memset((char *)pCifsFile, 0,
-				       sizeof (struct cifsFileInfo));
+				memset(pCifsFile, 0, sizeof (struct cifsFileInfo));
 				pCifsFile->netfid = fileHandle;
 				pCifsFile->pid = current->tgid;
 				pCifsFile->pInode = newinode;
Index: linux/fs/cifs/file.c
===================================================================
--- linux.orig/fs/cifs/file.c	2005-01-12 20:13:40.119824848 +0200
+++ linux/fs/cifs/file.c	2005-01-12 20:13:47.457709320 +0200
@@ -166,7 +166,7 @@
 			kmalloc(sizeof (struct cifsFileInfo), GFP_KERNEL);
 		if (file->private_data) {
 			memset(file->private_data, 0, sizeof(struct cifsFileInfo));
-			pCifsFile = (struct cifsFileInfo *) file->private_data;
+			pCifsFile = file->private_data;
 			pCifsFile->netfid = netfid;
 			pCifsFile->pid = current->tgid;
 			init_MUTEX(&pCifsFile->fh_sem);
@@ -285,7 +285,7 @@
 	if(inode == NULL)
 		return -EBADF;
 	if (file->private_data) {
-		pCifsFile = (struct cifsFileInfo *) file->private_data;
+		pCifsFile = file->private_data;
 	} else
 		return -EBADF;
 
@@ -399,8 +399,7 @@
 	int xid;
 	struct cifs_sb_info *cifs_sb;
 	struct cifsTconInfo *pTcon;
-	struct cifsFileInfo *pSMBFile =
-		(struct cifsFileInfo *) file->private_data;
+	struct cifsFileInfo *pSMBFile = file->private_data;
 
 	xid = GetXid();
 
@@ -446,8 +445,7 @@
 {
 	int rc = 0;
 	int xid;
-	struct cifsFileInfo *pCFileStruct =
-	    (struct cifsFileInfo *) file->private_data;
+	struct cifsFileInfo *pCFileStruct = file->private_data;
 	char * ptmp;
 
 	cFYI(1, ("Closedir inode = 0x%p with ", inode));
@@ -618,7 +616,7 @@
 	if (file->private_data == NULL) {
 		return -EBADF;
 	} else {
-		open_file = (struct cifsFileInfo *) file->private_data;
+		open_file = file->private_data;
 	}
 	
 	xid = GetXid();
@@ -734,7 +732,7 @@
 	if (file->private_data == NULL) {
 		return -EBADF;
 	} else {
-		open_file = (struct cifsFileInfo *) file->private_data;
+		open_file = file->private_data;
 	}
 	
 	xid = GetXid();
@@ -1057,7 +1055,7 @@
 		FreeXid(xid);
 		return -EBADF;
 	}
-	open_file = (struct cifsFileInfo *)file->private_data;
+	open_file = file->private_data;
 
 	if((file->f_flags & O_ACCMODE) == O_WRONLY) {
 		cFYI(1,("attempting read on write only file instance"));
@@ -1136,7 +1134,7 @@
 		FreeXid(xid);
 		return -EBADF;
 	}
-	open_file = (struct cifsFileInfo *)file->private_data;
+	open_file = file->private_data;
 
 	if((file->f_flags & O_ACCMODE) == O_WRONLY) {
 		cFYI(1,("attempting read on write only file instance"));
@@ -1274,7 +1272,7 @@
 		FreeXid(xid);
 		return -EBADF;
 	}
-	open_file = (struct cifsFileInfo *)file->private_data;
+	open_file = file->private_data;
 	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 
@@ -1712,9 +1710,7 @@
 static void reset_resume_key(struct file * dir_file, 
 				unsigned char * filename, 
 				unsigned int len,int Unicode,struct nls_table * nls_tab) {
-	struct cifsFileInfo *cifsFile;
-
-	cifsFile = (struct cifsFileInfo *)dir_file->private_data;
+	struct cifsFileInfo *cifsFile = dir_file->private_data;
 	if(cifsFile == NULL)
 		return;
 	if(cifsFile->search_resume_name) {
@@ -1897,8 +1893,7 @@
 		/* fallthrough */
 	case 2:
 		if (file->private_data != NULL) {
-			cifsFile =
-				(struct cifsFileInfo *) file->private_data;
+			cifsFile = file->private_data;
 			if (cifsFile->srch_inf.endOfSearch) {
 				if(cifsFile->srch_inf.emptyDir) {
 					cFYI(1, ("End of search, empty dir"));
@@ -1930,8 +1925,7 @@
 			if (file->private_data) {
 				memset(file->private_data, 0,
 				       sizeof (struct cifsFileInfo));
-				cifsFile =
-				    (struct cifsFileInfo *) file->private_data;
+				cifsFile = file->private_data;
 				cifsFile->netfid = searchHandle;
 				cifsFile->invalidHandle = FALSE;
 				init_MUTEX(&cifsFile->fh_sem);
@@ -2104,7 +2098,7 @@
 			     ("Readdir on closed srch, pos = %lld",
 			      file->f_pos));
 		} else {
-			cifsFile = (struct cifsFileInfo *) file->private_data;
+			cifsFile = file->private_data;
 			if (cifsFile->srch_inf.endOfSearch) {
 				rc = 0;
 				cFYI(1, ("End of search "));
Index: linux/fs/cifs/misc.c
===================================================================
--- linux.orig/fs/cifs/misc.c	2005-01-12 20:13:40.124824088 +0200
+++ linux/fs/cifs/misc.c	2005-01-12 20:13:47.459709016 +0200
@@ -66,11 +66,7 @@
 struct cifsSesInfo *
 sesInfoAlloc(void)
 {
-	struct cifsSesInfo *ret_buf;
-
-	ret_buf =
-	    (struct cifsSesInfo *) kmalloc(sizeof (struct cifsSesInfo),
-					   GFP_KERNEL);
+	struct cifsSesInfo *ret_buf = kmalloc(sizeof(*ret_buf), GFP_KERNEL);
 	if (ret_buf) {
 		memset(ret_buf, 0, sizeof (struct cifsSesInfo));
 		write_lock(&GlobalSMBSeslock);
@@ -109,10 +105,7 @@
 struct cifsTconInfo *
 tconInfoAlloc(void)
 {
-	struct cifsTconInfo *ret_buf;
-	ret_buf =
-	    (struct cifsTconInfo *) kmalloc(sizeof (struct cifsTconInfo),
-					    GFP_KERNEL);
+	struct cifsTconInfo *ret_buf = kmalloc(sizeof (*ret_buf), GFP_KERNEL);
 	if (ret_buf) {
 		memset(ret_buf, 0, sizeof (struct cifsTconInfo));
 		write_lock(&GlobalSMBSeslock);
@@ -155,8 +148,7 @@
    but it may be more efficient to always alloc same size 
    albeit slightly larger than necessary and maxbuffersize 
    defaults to this and can not be bigger */
-	ret_buf =
-	    (struct smb_hdr *) mempool_alloc(cifs_req_poolp, SLAB_KERNEL | SLAB_NOFS);
+	ret_buf = mempool_alloc(cifs_req_poolp, SLAB_KERNEL | SLAB_NOFS);
 
 	/* clear the first few header bytes */
 	/* for most paths, more is cleared in header_assemble */
@@ -189,8 +181,7 @@
    but it may be more efficient to always alloc same size 
    albeit slightly larger than necessary and maxbuffersize 
    defaults to this and can not be bigger */
-	ret_buf =
-	    (struct smb_hdr *) mempool_alloc(cifs_sm_req_poolp, SLAB_KERNEL | SLAB_NOFS);
+	ret_buf = mempool_alloc(cifs_sm_req_poolp, SLAB_KERNEL | SLAB_NOFS);
 	if (ret_buf) {
 	/* No need to clear memory here, cleared in header assemble */
 		atomic_inc(&smBufAllocCount);
Index: linux/fs/cifs/readdir.c
===================================================================
--- linux.orig/fs/cifs/readdir.c	2005-01-12 20:13:40.126823784 +0200
+++ linux/fs/cifs/readdir.c	2005-01-12 20:13:47.460708864 +0200
@@ -65,7 +65,7 @@
 	} else {
 		memset(file->private_data,0,sizeof(struct cifsFileInfo));
 	}
-	cifsFile = (struct cifsFileInfo *)file->private_data;
+	cifsFile = file->private_data;
 	cifsFile->invalidHandle = TRUE;
 	cifsFile->srch_inf.endOfSearch = FALSE;
 
@@ -221,7 +221,7 @@
 	int pos_in_buf = 0;
 	loff_t first_entry_in_buffer;
 	loff_t index_to_find = file->f_pos;
-	struct cifsFileInfo * cifsFile = (struct cifsFileInfo *)file->private_data;
+	struct cifsFileInfo * cifsFile = file->private_data;
 	/* check if index in the buffer */
 	
 	if((cifsFile == NULL) || (ppCurrentEntry == NULL) || (num_to_ret == NULL))
@@ -534,7 +534,7 @@
 			FreeXid(xid);
 			return rc;
 		}
-		cifsFile = (struct cifsFileInfo *) file->private_data;
+		cifsFile = file->private_data;
 		if (cifsFile->srch_inf.endOfSearch) {
 			if(cifsFile->srch_inf.emptyDir) {
 				cFYI(1, ("End of search, empty dir"));
Index: linux/fs/cifs/transport.c
===================================================================
--- linux.orig/fs/cifs/transport.c	2005-01-12 20:13:40.127823632 +0200
+++ linux/fs/cifs/transport.c	2005-01-12 20:13:47.462708560 +0200
@@ -48,7 +48,7 @@
 		return NULL;
 	}
 	
-	temp = (struct mid_q_entry *) mempool_alloc(cifs_mid_poolp,SLAB_KERNEL | SLAB_NOFS);
+	temp = mempool_alloc(cifs_mid_poolp,SLAB_KERNEL | SLAB_NOFS);
 	if (temp == NULL)
 		return temp;
 	else {
@@ -90,8 +90,7 @@
 		cERROR(1, ("Null parms passed to AllocOplockQEntry"));
 		return NULL;
 	}
-	temp = (struct oplock_q_entry *) kmem_cache_alloc(cifs_oplock_cachep,
-						       SLAB_KERNEL);
+	temp = kmem_cache_alloc(cifs_oplock_cachep, SLAB_KERNEL);
 	if (temp == NULL)
 		return temp;
 	else {


