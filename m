Return-Path: <linux-kernel-owner+w=401wt.eu-S932950AbWLSXTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932950AbWLSXTu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932989AbWLSXTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:19:48 -0500
Received: from pat.uio.no ([129.240.10.15]:48428 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932950AbWLSXTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:19:47 -0500
Subject: Re: 2.6.18 mmap hangs unrelated apps
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Sabala <lkml@saahbs.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20061219142624.230b28c0.akpm@osdl.org>
References: <20061215023014.GC2721@prosiaczek>
	 <1166199855.5761.34.camel@lade.trondhjem.org>
	 <20061215175030.GG6220@prosiaczek>
	 <1166211884.5761.49.camel@lade.trondhjem.org>
	 <20061215210642.GI6220@prosiaczek>
	 <1166219054.5761.56.camel@lade.trondhjem.org>
	 <20061219142624.230b28c0.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 18:19:38 -0500
Message-Id: <1166570378.5760.52.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: 141.211.133.154 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 14:26 -0800, Andrew Morton wrote:
> On Fri, 15 Dec 2006 16:44:14 -0500
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > However it is true that the
> > trace you sent indicated that XFree86 was hanging in iput().
> 
> We know what the bug is, don't we?
> 
> > > XFree86       D 00000003     0  2471   2453                     (NOTLB)
> > >        c4871c0c 00003082 c86b72bc 00000003 cb7c94a4 0000001d 3b67f3ff c0146dd2 
> > >        c1184180 cb3e7110 00000000 001ec7ff a60f8097 00000089 c02e1e60 cb3e7000 
> > >        c1184180 00000000 c1180030 c4871c18 c028c7d8 c4871c5c c01435b6 c01435f3 
> > > Call Trace:
> > >  [<c0146dd2>] free_pages_bulk+0x1d/0x1d4
> > >  [<c028c7d8>] io_schedule+0x26/0x30
> > >  [<c01435b6>] sync_page+0x0/0x40
> > >  [<c01435f3>] sync_page+0x3d/0x40
> > >  [<c028c9ce>] __wait_on_bit_lock+0x2c/0x52
> > >  [<c0143c13>] __lock_page+0x6a/0x72
> > >  [<c012ec77>] wake_bit_function+0x0/0x3c
> > >  [<c012ec77>] wake_bit_function+0x0/0x3c
> > >  [<c0149d2f>] pagevec_lookup+0x17/0x1d
> > >  [<c014a085>] truncate_inode_pages_range+0x20a/0x260
> > >  [<c014a0e4>] truncate_inode_pages+0x9/0xc
> > >  [<c0172c8a>] generic_delete_inode+0xb6/0x10f
> > >  [<c0172e73>] iput+0x5f/0x61
> > >  [<c01706bd>] dentry_iput+0x68/0x83
> > >  [<c01707d8>] dput+0x100/0x118
> > >  [<ccb6c334>] put_nfs_open_context+0x67/0x88 [nfs]
> > >  [<ccb701ed>] nfs_release_request+0x38/0x47 [nfs]
> > >  [<ccb736dd>] nfs_wait_on_requests_locked+0x62/0x98 [nfs]
> > >  [<ccb74c32>] nfs_sync_inode_wait+0x4a/0x130 [nfs]
> > >  [<ccb6b639>] nfs_release_page+0x0/0x30 [nfs]
> > >  [<ccb6b655>] nfs_release_page+0x1c/0x30 [nfs]
> > >  [<c015f37c>] try_to_release_page+0x34/0x46
> > >  [<c014aa8b>] shrink_page_list+0x263/0x350
> > >  [<c0104db8>] do_IRQ+0x48/0x50
> > >  [<c01036c6>] common_interrupt+0x1a/0x20
> > >  [<c014acd7>] shrink_inactive_list+0x9b/0x248
> > >  [<c014b2fd>] shrink_zone+0xb5/0xd0
> > >  [<c014b382>] shrink_zones+0x6a/0x7e
> > >  [<c014b48e>] try_to_free_pages+0xf8/0x1da
> > >  [<c0147a18>] __alloc_pages+0x17c/0x278
> > >  [<c014f555>] do_anonymous_page+0x45/0x150
> > >  [<c014f9f7>] __handle_mm_fault+0xda/0x1bf
> > >  [<c0115849>] do_page_fault+0x1c4/0x4bc
> > >  [<c01021b7>] restore_sigcontext+0x10c/0x15f
> > >  [<c0115685>] do_page_fault+0x0/0x4bc
> > >  [<c0103809>] error_code+0x39/0x40
> > 
> > nfs_release_page() was called with a locked page.  It's doing a bunch of
> > stuff which results in a call to truncate_inode_pages(), which will run
> > lock_page(), which is deadlocky.
> 
> Now, arguably the VM shouldn't be calling try_to_release_page() with
> __GFP_FS when it's holding a lock on a page.
> 
> But otoh, NFS should never be running lock_page() within nfs_release_page()
> against the page which was passed into nfs_release_page().  It'll deadlock
> for sure.

The reason why it is happening is that the last dirty page from that
inode gets cleaned, resulting in a call to dput().

> So we could alter the VM to not pass in __GFP_FS in this situation, but
> nfs_release_page() would still be deadlocky.

It certainly never makes sense to call nfs_release_page(__GFP_FS) if the
caller doesn't have a reference to the inode or the dentry.

OK. How about something like this? (untested)

Cheers
  Trond
-------------------
commit ac5d597264255dfc0f29b4e3f54294d3d5f1778e
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 19 18:17:36 2006 -0500

    NFS: Fix race in nfs_release_page()
    
    invalidate_inode_pages2() may set the dirty bit on a page owing to the call
    to unmap_mapping_range() after the page was locked. In order to fix this,
    NFS has hooked the releasepage() method. This, however leads to deadlocks
    in other parts of the VM.
    
    Fix is to add a new callback: flushpage(), which will write out a dirty
    page that is under the page lock.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
 Documentation/filesystems/Locking |    6 ++++++
 fs/nfs/file.c                     |   11 ++---------
 include/linux/fs.h                |    1 +
 mm/truncate.c                     |   23 ++++++++++++++++++-----
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 790ef6f..ddcff76 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -171,6 +171,7 @@ prototypes:
 	int (*releasepage) (struct page *, int);
 	int (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs);
+	int (*flushpage) (struct page *);
 
 locking rules:
 	All except set_page_dirty may block
@@ -188,6 +189,7 @@ bmap:			yes
 invalidatepage:		no	yes
 releasepage:		no	yes
 direct_IO:		no
+flushpage:		no	yes
 
 	->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
 may be called from the request handler (/dev/loop).
@@ -281,6 +283,10 @@ buffers from the page in preparation for
 indicate that the buffers are (or may be) freeable.  If ->releasepage is zero,
 the kernel assumes that the fs has no private interest in the buffers.
 
+	->flushpage() is called when the kernel has locked a dirty page prior
+to releasing it. It returns 0 if the page was successfully cleaned. Note
+that the page lock must be held across the entire operation.
+
 	Note: currently almost all instances of address_space methods are
 using BKL for internal serialization and that's one of the worst sources
 of contention. Normally they are calling library functions (in fs/buffer.c)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 0dd6be3..77e6c42 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -313,15 +313,8 @@ static void nfs_invalidate_page(struct p
 	nfs_wb_page_priority(page->mapping->host, page, FLUSH_INVALIDATE);
 }
 
-static int nfs_release_page(struct page *page, gfp_t gfp)
+static int nfs_flush_page(struct page *page)
 {
-	/*
-	 * Avoid deadlock on nfs_wait_on_request().
-	 */
-	if (!(gfp & __GFP_FS))
-		return 0;
-	/* Hack... Force nfs_wb_page() to write out the page */
-	SetPageDirty(page);
 	return !nfs_wb_page(page->mapping->host, page);
 }
 
@@ -334,10 +327,10 @@ const struct address_space_operations nf
 	.prepare_write = nfs_prepare_write,
 	.commit_write = nfs_commit_write,
 	.invalidatepage = nfs_invalidate_page,
-	.releasepage = nfs_release_page,
 #ifdef CONFIG_NFS_DIRECTIO
 	.direct_IO = nfs_direct_IO,
 #endif
+	.flushpage = nfs_release_page,
 };
 
 static ssize_t nfs_file_write(struct kiocb *iocb, const struct iovec *iov,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 186da81..bb9ce57 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -426,6 +426,7 @@ struct address_space_operations {
 	/* migrate the contents of a page to the specified target */
 	int (*migratepage) (struct address_space *,
 			struct page *, struct page *);
+	int (*flushpage) (struct page *);
 };
 
 struct backing_dev_info;
diff --git a/mm/truncate.c b/mm/truncate.c
index 9bfb8e8..0d6b18d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -321,6 +321,16 @@ failed:
 	return 0;
 }
 
+static int
+flush_page(struct struct address_space *mapping, struct page *page)
+{
+	if (!PageDirty(page))
+		return 0;
+	if (page->mapping != mapping || mapping->a_ops->flushpage == NULL)
+		return 0;
+	return mapping->a_ops->flushpage(page);
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
+			ret = flush_page(page);
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


