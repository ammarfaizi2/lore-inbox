Return-Path: <linux-kernel-owner+w=401wt.eu-S1751572AbXAHOus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbXAHOus (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 09:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbXAHOus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 09:50:48 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:4181 "EHLO
	amsfep14-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751572AbXAHOuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 09:50:46 -0500
Subject: [PATCH] NFS: Fix race in nfs_release_page()
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, Michal Sabala <lkml@saahbs.net>,
       linux-kernel@vger.kernel.org, torvalds <torvalds@osdl.org>
In-Reply-To: <1166577675.5768.19.camel@lade.trondhjem.org>
References: <20061215023014.GC2721@prosiaczek>
	 <1166199855.5761.34.camel@lade.trondhjem.org>
	 <20061215175030.GG6220@prosiaczek>
	 <1166211884.5761.49.camel@lade.trondhjem.org>
	 <20061215210642.GI6220@prosiaczek>
	 <1166219054.5761.56.camel@lade.trondhjem.org>
	 <20061219142624.230b28c0.akpm@osdl.org>
	 <1166570378.5760.52.camel@lade.trondhjem.org>
	 <20061219160315.ea83ca38.akpm@osdl.org>
	 <1166573863.5768.10.camel@lade.trondhjem.org>
	 <1166577675.5768.19.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 15:48:34 +0100
Message-Id: <1168267714.12503.7.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could we push this to mainline before .20 - pretty please?

---
From: Trond Myklebust <Trond.Myklebust@netapp.com>

    NFS: Fix race in nfs_release_page()
    
    invalidate_inode_pages2() may find the dirty bit has been set on a page
    owing to the fact that the page may still be mapped after it was locked.
    Only after the call to unmap_mapping_range() are we sure that the page
    can no longer be dirtied.
    In order to fix this, NFS has hooked the releasepage() method and tries
    to write the page out between the call to unmap_mapping_range() and the
    call to remove_mapping(). This, however leads to deadlocks in the page
    reclaim code, where the page may be locked without holding a reference
    to the inode or dentry.
    
    Fix is to add a new address_space_operation, launder_page(), which will
    attempt to write out a dirty page without releasing the page lock.
    
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

    Also, the bare SetPageDirty() can skew all sort of accounting leading to 
    other nasties.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 Documentation/filesystems/Locking |    8 ++++++++
 fs/nfs/file.c                     |   16 ++++++++--------
 include/linux/fs.h                |    1 +
 mm/truncate.c                     |   13 ++++++++++++-
 4 files changed, 29 insertions(+), 9 deletions(-)

Index: linux-2.6-git/Documentation/filesystems/Locking
===================================================================
--- linux-2.6-git.orig/Documentation/filesystems/Locking	2006-12-08 10:11:33.000000000 +0100
+++ linux-2.6-git/Documentation/filesystems/Locking	2007-01-08 15:11:15.000000000 +0100
@@ -171,6 +171,7 @@ prototypes:
 	int (*releasepage) (struct page *, int);
 	int (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs);
+	int (*launder_page) (struct page *);
 
 locking rules:
 	All except set_page_dirty may block
@@ -188,6 +189,7 @@ bmap:			yes
 invalidatepage:		no	yes
 releasepage:		no	yes
 direct_IO:		no
+launder_page:		no	yes
 
 	->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
 may be called from the request handler (/dev/loop).
@@ -281,6 +283,12 @@ buffers from the page in preparation for
 indicate that the buffers are (or may be) freeable.  If ->releasepage is zero,
 the kernel assumes that the fs has no private interest in the buffers.
 
+	->launder_page() may be called prior to releasing a page if
+it is still found to be dirty. It returns zero if the page was successfully
+cleaned, or an error value if not. Note that in order to prevent the page
+getting mapped back in and redirtied, it needs to be kept locked
+across the entire operation.
+
 	Note: currently almost all instances of address_space methods are
 using BKL for internal serialization and that's one of the worst sources
 of contention. Normally they are calling library functions (in fs/buffer.c)
Index: linux-2.6-git/fs/nfs/file.c
===================================================================
--- linux-2.6-git.orig/fs/nfs/file.c	2007-01-08 11:53:13.000000000 +0100
+++ linux-2.6-git/fs/nfs/file.c	2007-01-08 15:11:15.000000000 +0100
@@ -315,14 +315,13 @@ static void nfs_invalidate_page(struct p
 
 static int nfs_release_page(struct page *page, gfp_t gfp)
 {
-	/*
-	 * Avoid deadlock on nfs_wait_on_request().
-	 */
-	if (!(gfp & __GFP_FS))
-		return 0;
-	/* Hack... Force nfs_wb_page() to write out the page */
-	SetPageDirty(page);
-	return !nfs_wb_page(page->mapping->host, page);
+	/* If PagePrivate() is set, then the page is not freeable */
+	return 0;
+}
+
+static int nfs_launder_page(struct page *page)
+{
+	return nfs_wb_page(page->mapping->host, page);
 }
 
 const struct address_space_operations nfs_file_aops = {
@@ -338,6 +337,7 @@ const struct address_space_operations nf
 #ifdef CONFIG_NFS_DIRECTIO
 	.direct_IO = nfs_direct_IO,
 #endif
+	.launder_page = nfs_launder_page,
 };
 
 static ssize_t nfs_file_write(struct kiocb *iocb, const struct iovec *iov,
Index: linux-2.6-git/include/linux/fs.h
===================================================================
--- linux-2.6-git.orig/include/linux/fs.h	2007-01-08 11:53:13.000000000 +0100
+++ linux-2.6-git/include/linux/fs.h	2007-01-08 15:11:15.000000000 +0100
@@ -426,6 +426,7 @@ struct address_space_operations {
 	/* migrate the contents of a page to the specified target */
 	int (*migratepage) (struct address_space *,
 			struct page *, struct page *);
+	int (*launder_page) (struct page *);
 };
 
 struct backing_dev_info;
Index: linux-2.6-git/mm/truncate.c
===================================================================
--- linux-2.6-git.orig/mm/truncate.c	2007-01-08 11:53:13.000000000 +0100
+++ linux-2.6-git/mm/truncate.c	2007-01-08 15:30:08.000000000 +0100
@@ -341,6 +341,16 @@ failed:
 	return 0;
 }
 
+static int
+do_launder_page(struct address_space *mapping, struct page *page)
+{
+	if (!PageDirty(page))
+		return 0;
+	if (page->mapping != mapping || mapping->a_ops->launder_page == NULL)
+		return 0;
+	return mapping->a_ops->launder_page(page);
+}
+
 /**
  * invalidate_inode_pages2_range - remove range of pages from an address_space
  * @mapping: the address_space
@@ -405,7 +415,8 @@ int invalidate_inode_pages2_range(struct
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}
-			if (!invalidate_complete_page2(mapping, page))
+			ret = do_launder_page(mapping, page);
+			if (ret == 0 && !invalidate_complete_page2(mapping, page))
 				ret = -EIO;
 			unlock_page(page);
 		}


