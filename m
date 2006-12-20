Return-Path: <linux-kernel-owner+w=401wt.eu-S932917AbWLTBW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932917AbWLTBW1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWLTBVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:21:54 -0500
Received: from pat.uio.no ([129.240.10.15]:55451 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964770AbWLTBVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:21:25 -0500
Subject: Re: 2.6.18 mmap hangs unrelated apps
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Sabala <lkml@saahbs.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1166573863.5768.10.camel@lade.trondhjem.org>
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
Content-Type: text/plain
Date: Tue, 19 Dec 2006 20:21:15 -0500
Message-Id: <1166577675.5768.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: UIO-GREYLIST 69.242.210.120 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 1 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 19:17 -0500, Trond Myklebust wrote:
> Ack, I'll add one in. If PagePrivate() is set during the call to
> try_to_release_page(), then the page should never be freeable.

OK. This one actually compiles, and eliminates a few logic bugs. Note
that I renamed the callback to ->launder_page() for clarity (and for
histerical reasons).

Cheers
  Trond

----------------------------------------------------------------
commit 85a5b844c56706a5e3f47cde8b82109d325ad609
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 19 20:18:55 2006 -0500

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
---
 Documentation/filesystems/Locking |    8 ++++++++
 fs/nfs/file.c                     |   16 ++++++++--------
 include/linux/fs.h                |    1 +
 mm/truncate.c                     |   23 ++++++++++++++++++-----
 4 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 790ef6f..28bfea7 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
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
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 0dd6be3..fab20d0 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 186da81..14a337c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -426,6 +426,7 @@ struct address_space_operations {
 	/* migrate the contents of a page to the specified target */
 	int (*migratepage) (struct address_space *,
 			struct page *, struct page *);
+	int (*launder_page) (struct page *);
 };
 
 struct backing_dev_info;
diff --git a/mm/truncate.c b/mm/truncate.c
index 9bfb8e8..d4811dc 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -321,6 +321,16 @@ failed:
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
@@ -386,11 +396,14 @@ int invalidate_inode_pages2_range(struct
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}
-			was_dirty = test_clear_page_dirty(page);
-			if (!invalidate_complete_page2(mapping, page)) {
-				if (was_dirty)
-					set_page_dirty(page);
-				ret = -EIO;
+			ret = do_launder_page(mapping, page);
+			if (ret == 0) {
+				was_dirty = test_clear_page_dirty(page);
+				if (!invalidate_complete_page2(mapping, page)) {
+					if (was_dirty)
+						set_page_dirty(page);
+					ret = -EIO;
+				}
 			}
 			unlock_page(page);
 		}


