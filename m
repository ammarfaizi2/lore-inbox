Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSG1PV7>; Sun, 28 Jul 2002 11:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSG1PV6>; Sun, 28 Jul 2002 11:21:58 -0400
Received: from mons.uio.no ([129.240.130.14]:54930 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316860AbSG1PV4>;
	Sun, 28 Jul 2002 11:21:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15684.3286.74735.41434@charged.uio.no>
Date: Sun, 28 Jul 2002 17:25:10 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Support for cached lookups via readdirplus [1/6]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Cleanup for the readdirplus code. Make struct nfs_entry take pointers
to the filehandle and file attributes.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.29-noac/fs/nfs/dir.c linux-2.5.29-rdplus1/fs/nfs/dir.c
--- linux-2.5.29-noac/fs/nfs/dir.c	Fri Jul 26 23:15:42 2002
+++ linux-2.5.29-rdplus1/fs/nfs/dir.c	Sat Jul 27 18:10:53 2002
@@ -333,7 +333,8 @@
 	/* Reset read descriptor so it searches the page cache from
 	 * the start upon the next call to readdir_search_pagecache() */
 	desc->page_index = 0;
-	memset(desc->entry, 0, sizeof(*desc->entry));
+	desc->entry->cookie = desc->entry->prev_cookie = 0;
+	desc->entry->eof = 0;
  out:
 	dfprintk(VFS, "NFS: uncached_readdir() returns %d\n", status);
 	return status;
@@ -352,6 +353,8 @@
 	nfs_readdir_descriptor_t my_desc,
 			*desc = &my_desc;
 	struct nfs_entry my_entry;
+	struct nfs_fh	 fh;
+	struct nfs_fattr fattr;
 	long		res;
 
 	lock_kernel();
@@ -369,13 +372,17 @@
 	 * itself.
 	 */
 	memset(desc, 0, sizeof(*desc));
-	memset(&my_entry, 0, sizeof(my_entry));
 
 	desc->file = filp;
 	desc->target = filp->f_pos;
-	desc->entry = &my_entry;
 	desc->decode = NFS_PROTO(inode)->decode_dirent;
 
+	my_entry.cookie = my_entry.prev_cookie = 0;
+	my_entry.eof = 0;
+	my_entry.fh = &fh;
+	my_entry.fattr = &fattr;
+	desc->entry = &my_entry;
+
 	while(!desc->entry->eof) {
 		res = readdir_search_pagecache(desc);
 		if (res == -EBADCOOKIE) {
diff -u --recursive --new-file linux-2.5.29-noac/fs/nfs/nfs3xdr.c linux-2.5.29-rdplus1/fs/nfs/nfs3xdr.c
--- linux-2.5.29-noac/fs/nfs/nfs3xdr.c	Tue Jul 16 13:43:08 2002
+++ linux-2.5.29-rdplus1/fs/nfs/nfs3xdr.c	Sat Jul 27 17:56:10 2002
@@ -603,21 +603,19 @@
 	p = xdr_decode_hyper(p, &entry->cookie);
 
 	if (plus) {
-		p = xdr_decode_post_op_attr(p, &entry->fattr);
+		entry->fattr->valid = 0;
+		p = xdr_decode_post_op_attr(p, entry->fattr);
 		/* In fact, a post_op_fh3: */
 		if (*p++) {
-			p = xdr_decode_fhandle(p, &entry->fh);
+			p = xdr_decode_fhandle(p, entry->fh);
 			/* Ugh -- server reply was truncated */
 			if (p == NULL) {
 				dprintk("NFS: FH truncated\n");
 				*entry = old;
 				return ERR_PTR(-EAGAIN);
 			}
-		} else {
-			/* If we don't get a file handle, the attrs
-			 * aren't worth a lot. */
-			entry->fattr.valid = 0;
-		}
+		} else
+			memset((u8*)(entry->fh), 0, sizeof(*entry->fh));
 	}
 
 	entry->eof = !p[0] && p[1];
diff -u --recursive --new-file linux-2.5.29-noac/include/linux/nfs_xdr.h linux-2.5.29-rdplus1/include/linux/nfs_xdr.h
--- linux-2.5.29-noac/include/linux/nfs_xdr.h	Fri Jul 26 16:35:23 2002
+++ linux-2.5.29-rdplus1/include/linux/nfs_xdr.h	Sat Jul 27 17:56:10 2002
@@ -109,8 +109,8 @@
 	const char *		name;
 	unsigned int		len;
 	int			eof;
-	struct nfs_fh		fh;
-	struct nfs_fattr	fattr;
+	struct nfs_fh *		fh;
+	struct nfs_fattr *	fattr;
 };
 
 /*

