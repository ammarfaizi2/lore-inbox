Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSLLKTQ>; Thu, 12 Dec 2002 05:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSLLKTQ>; Thu, 12 Dec 2002 05:19:16 -0500
Received: from mons.uio.no ([129.240.130.14]:56978 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262450AbSLLKTO>;
	Thu, 12 Dec 2002 05:19:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15864.25714.339197.675770@charged.uio.no>
Date: Thu, 12 Dec 2002 11:26:58 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH 2.4.21-pre] Fix possible SMP race in nfs_sync_page()
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo,

  The following patch fixes a race in nfs_sync_page() whereby one
thread may call the generic sync_page() and then block on a given page
while another thread is working in mapping->a_ops->readpage().

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.21-pre1/fs/nfs/file.c linux-2.4.21-01-nfs_sync/fs/nfs/file.c
--- linux-2.4.21-pre1/fs/nfs/file.c	2002-02-05 15:10:21.000000000 +0100
+++ linux-2.4.21-01-nfs_sync/fs/nfs/file.c	2002-12-12 11:23:09.000000000 +0100
@@ -187,6 +187,7 @@
 	if (!inode)
 		return 0;
 
+	NFS_SetPageSync(page);
 	rpages = NFS_SERVER(inode)->rpages;
 	result = nfs_pagein_inode(inode, index, rpages);
 	if (result < 0)
diff -u --recursive --new-file linux-2.4.21-pre1/fs/nfs/read.c linux-2.4.21-01-nfs_sync/fs/nfs/read.c
--- linux-2.4.21-pre1/fs/nfs/read.c	2002-10-06 01:03:40.000000000 +0200
+++ linux-2.4.21-01-nfs_sync/fs/nfs/read.c	2002-12-12 11:23:09.000000000 +0100
@@ -171,11 +171,16 @@
 	struct nfs_page	*new;
 
 	new = nfs_create_request(nfs_file_cred(file), inode, page, 0, PAGE_CACHE_SIZE);
-	if (IS_ERR(new))
+	if (IS_ERR(new)) {
+		SetPageError(page);
+		NFS_ClearPageSync(page);
+		UnlockPage(page);
 		return PTR_ERR(new);
+	}
 	nfs_mark_request_read(new);
 
-	if (inode->u.nfs_i.nread >= NFS_SERVER(inode)->rpages ||
+	if (NFS_TestClearPageSync(page) ||
+	    inode->u.nfs_i.nread >= NFS_SERVER(inode)->rpages ||
 	    page_index(page) == (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT)
 		nfs_pagein_inode(inode, 0, 0);
 	return 0;
@@ -222,6 +227,7 @@
 		req = nfs_list_entry(head->next);
 		page = req->wb_page;
 		nfs_list_remove_request(req);
+		NFS_ClearPageSync(page);
 		SetPageError(page);
 		UnlockPage(page);
 		nfs_clear_request(req);
@@ -429,6 +435,7 @@
 		} else
 			SetPageError(page);
 		flush_dcache_page(page);
+		NFS_ClearPageSync(page);
 		UnlockPage(page);
 
 		dprintk("NFS: read (%x/%Ld %d@%Ld)\n",
@@ -482,6 +489,7 @@
 	return error;
 
 out_error:
+	NFS_ClearPageSync(page);
 	UnlockPage(page);
 	goto out;
 }
diff -u --recursive --new-file linux-2.4.21-pre1/include/linux/mm.h linux-2.4.21-01-nfs_sync/include/linux/mm.h
--- linux-2.4.21-pre1/include/linux/mm.h	2002-03-27 00:11:32.000000000 +0100
+++ linux-2.4.21-01-nfs_sync/include/linux/mm.h	2002-12-12 11:23:09.000000000 +0100
@@ -297,6 +297,7 @@
 #define PG_arch_1		13
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
+#define PG_fs_1			16	/* Filesystem specific */
 
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)
diff -u --recursive --new-file linux-2.4.21-pre1/include/linux/nfs_fs.h linux-2.4.21-01-nfs_sync/include/linux/nfs_fs.h
--- linux-2.4.21-pre1/include/linux/nfs_fs.h	2002-10-15 18:32:18.000000000 +0200
+++ linux-2.4.21-01-nfs_sync/include/linux/nfs_fs.h	2002-12-12 11:23:09.000000000 +0100
@@ -269,6 +269,10 @@
 extern int  nfs_scan_lru_read(struct nfs_server *, struct list_head *);
 extern int  nfs_scan_lru_read_timeout(struct nfs_server *, struct list_head *);
 
+#define NFS_SetPageSync(page)		set_bit(PG_fs_1, &(page)->flags)
+#define NFS_ClearPageSync(page)		clear_bit(PG_fs_1, &(page)->flags)
+#define NFS_TestClearPageSync(page)	test_and_clear_bit(PG_fs_1, &(page)->flags)
+
 /*
  * linux/fs/mount_clnt.c
  * (Used only by nfsroot module)

