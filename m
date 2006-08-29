Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWH2Bav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWH2Bav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWH2Bav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:30:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:49602 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750941AbWH2Bau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:30:50 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 29 Aug 2006 11:30:44 +1000
Message-Id: <1060829013044.18525@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: v9fs-developer@lists.sourceforge.net, trond.myklebust@fys.uio.no,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 2] Make data destruction in invalidate_inode_pages2 optional.
References: <20060829111641.18391.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


invalidate_inode_pages2 is called when the caller has determined
that the page cache might be inconsistant with the backing store.

It is possible for invalidate_complete_page (which it calls) to fail
if a page is dirty.

It is not possible to lock against this as a writable memory mapping
can dirty a page at any time.

Different callers have different preferences about how this situation
is handled.

For nfs (and presumably 9p) the cache invalidation is advisory only.
When byte-range locking is not used, nfs cache coherancy is on a
best-effort basis.  So while nfs would like to invalidate the cache,
it doesn't want to do it at the risk of discarding newly written data.
If a process writes (via mmap) to a page that some other client may
have updated on the server, then we want to local write to go through
(after all, it only 'may' conflict with another client and as they didn't
use locking, that is what they should expect).

For O_DIRECT writes, the situation is different.
generic_file_direct_IO *knows* that there has been an independant,
write to the page in question.  If this races with some other process
performing an update via a mmap then the only way that we can
serialise these writes is to act as though the O_DIRECT comes second
and overwrites the mmap write.

So for O_DIRECT writes, invalidate_inode_pages2 should remove the
Dirty flag from any pages where that is possible.

If that page has already entered Writeback, it may not be possible to
full clean the page.  In this case, -EIO is returned to inform the
writer that their write was not completely successful.

Currently, invalidate_inode_pages2 always tries to clear the Dirty
bit.  This is good for O_DIRECT but bad for NFS (and probably 9p).

This patch makes the clearing of the dirty bit optional via a flag
and sets the flag as appropriate.

Note that I am not at all sure what should happen in the NFS +
O_DIRECT case (and the comment in nfs/direct.c suggests that I am not
alone in this).  So I have left the behaviour at that call site
unchanged.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/9p/vfs_file.c   |    2 +-
 ./fs/nfs/dir.c       |    2 +-
 ./fs/nfs/direct.c    |    2 +-
 ./fs/nfs/fscache.h   |    2 +-
 ./fs/nfs/inode.c     |    2 +-
 ./include/linux/fs.h |    6 ++++--
 ./mm/filemap.c       |    2 +-
 ./mm/truncate.c      |   11 +++++++----
 8 files changed, 17 insertions(+), 12 deletions(-)

diff .prev/fs/9p/vfs_file.c ./fs/9p/vfs_file.c
--- .prev/fs/9p/vfs_file.c	2006-08-29 10:40:51.000000000 +1000
+++ ./fs/9p/vfs_file.c	2006-08-29 10:40:59.000000000 +1000
@@ -266,7 +266,7 @@ v9fs_file_write(struct file *filp, const
 		total += result;
 	} while (count);
 
-		invalidate_inode_pages2(inode->i_mapping);
+	invalidate_inode_pages2(inode->i_mapping, 0);
 	return total;
 }
 

diff .prev/fs/nfs/dir.c ./fs/nfs/dir.c
--- .prev/fs/nfs/dir.c	2006-08-29 10:41:42.000000000 +1000
+++ ./fs/nfs/dir.c	2006-08-29 10:41:49.000000000 +1000
@@ -204,7 +204,7 @@ int nfs_readdir_filler(nfs_readdir_descr
 	 *	 through inode->i_mutex or some other mechanism.
 	 */
 	if (page->index == 0)
-		invalidate_inode_pages2_range(inode->i_mapping, PAGE_CACHE_SIZE, -1);
+		invalidate_inode_pages2_range(inode->i_mapping, PAGE_CACHE_SIZE, -1, 0);
 	unlock_page(page);
 	return 0;
  error:

diff .prev/fs/nfs/direct.c ./fs/nfs/direct.c
--- .prev/fs/nfs/direct.c	2006-08-29 10:45:41.000000000 +1000
+++ ./fs/nfs/direct.c	2006-08-29 10:45:47.000000000 +1000
@@ -859,7 +859,7 @@ ssize_t nfs_file_direct_write(struct kio
 	 *      occur before the writes complete.  Kind of racey.
 	 */
 	if (mapping->nrpages)
-		invalidate_inode_pages2(mapping);
+		invalidate_inode_pages2(mapping, 1);
 
 	if (retval > 0)
 		iocb->ki_pos = pos + retval;

diff .prev/fs/nfs/fscache.h ./fs/nfs/fscache.h
--- .prev/fs/nfs/fscache.h	2006-08-29 10:46:54.000000000 +1000
+++ ./fs/nfs/fscache.h	2006-08-29 10:49:09.000000000 +1000
@@ -184,7 +184,7 @@ static inline void nfs_fscache_disable_f
 		 * turning off the cache.
 		 */
 		if (inode->i_mapping && inode->i_mapping->nrpages)
-			invalidate_inode_pages2(inode->i_mapping);
+			invalidate_inode_pages2(inode->i_mapping, 0);
 
 		nfs_fscache_zap_fh_cookie(NFS_SERVER(inode), NFS_I(inode));
 	}

diff .prev/fs/nfs/inode.c ./fs/nfs/inode.c
--- .prev/fs/nfs/inode.c	2006-08-29 10:45:54.000000000 +1000
+++ ./fs/nfs/inode.c	2006-08-29 10:46:29.000000000 +1000
@@ -685,7 +685,7 @@ int nfs_revalidate_mapping(struct inode 
 		nfs_inc_stats(inode, NFSIOS_DATAINVALIDATE);
 		if (S_ISREG(inode->i_mode))
 			nfs_sync_mapping(mapping);
-		invalidate_inode_pages2(mapping);
+		invalidate_inode_pages2(mapping, 0);
 
 		spin_lock(&inode->i_lock);
 		nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;

diff .prev/include/linux/fs.h ./include/linux/fs.h
--- .prev/include/linux/fs.h	2006-08-29 10:22:02.000000000 +1000
+++ ./include/linux/fs.h	2006-08-29 10:40:35.000000000 +1000
@@ -1636,9 +1636,11 @@ static inline void invalidate_remote_ino
 	    S_ISLNK(inode->i_mode))
 		invalidate_inode_pages(inode->i_mapping);
 }
-extern int invalidate_inode_pages2(struct address_space *mapping);
+extern int invalidate_inode_pages2(struct address_space *mapping,
+				   int may_destroy);
 extern int invalidate_inode_pages2_range(struct address_space *mapping,
-					 pgoff_t start, pgoff_t end);
+					 pgoff_t start, pgoff_t end,
+					 int may_destroy);
 extern int write_inode_now(struct inode *, int);
 extern void generic_sync_sb_inodes(struct super_block *, struct writeback_control *);
 extern int filemap_fdatawrite(struct address_space *);

diff .prev/mm/filemap.c ./mm/filemap.c
--- .prev/mm/filemap.c	2006-08-29 10:23:11.000000000 +1000
+++ ./mm/filemap.c	2006-08-29 10:49:25.000000000 +1000
@@ -2633,7 +2633,7 @@ generic_file_direct_IO(int rw, struct ki
 			pgoff_t end = (offset + write_len - 1)
 						>> PAGE_CACHE_SHIFT;
 			int err = invalidate_inode_pages2_range(mapping,
-					offset >> PAGE_CACHE_SHIFT, end);
+					offset >> PAGE_CACHE_SHIFT, end, 1);
 			if (err)
 				retval = err;
 		}

diff .prev/mm/truncate.c ./mm/truncate.c
--- .prev/mm/truncate.c	2006-08-29 10:24:34.000000000 +1000
+++ ./mm/truncate.c	2006-08-29 10:50:24.000000000 +1000
@@ -275,6 +275,8 @@ EXPORT_SYMBOL(invalidate_inode_pages);
  * @mapping: the address_space
  * @start: the page offset 'from' which to invalidate
  * @end: the page offset 'to' which to invalidate (inclusive)
+ * @may_destroy: flag to say if Dirty pages may be marked clean, thus possibly
+ *          destroying recent updates to the pages.
  *
  * Any pages which are found to be mapped into pagetables are unmapped prior to
  * invalidation.
@@ -282,7 +284,8 @@ EXPORT_SYMBOL(invalidate_inode_pages);
  * Returns -EIO if any pages could not be invalidated.
  */
 int invalidate_inode_pages2_range(struct address_space *mapping,
-				  pgoff_t start, pgoff_t end)
+				  pgoff_t start, pgoff_t end,
+				  int may_destroy)
 {
 	struct pagevec pvec;
 	pgoff_t next;
@@ -335,7 +338,7 @@ int invalidate_inode_pages2_range(struct
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}
-			was_dirty = test_clear_page_dirty(page);
+			was_dirty = may_destroy && test_clear_page_dirty(page);
 			if (!invalidate_complete_page(mapping, page)) {
 				if (was_dirty)
 					set_page_dirty(page);
@@ -359,8 +362,8 @@ EXPORT_SYMBOL_GPL(invalidate_inode_pages
  *
  * Returns -EIO if any pages could not be invalidated.
  */
-int invalidate_inode_pages2(struct address_space *mapping)
+int invalidate_inode_pages2(struct address_space *mapping, int may_destroy)
 {
-	return invalidate_inode_pages2_range(mapping, 0, -1);
+	return invalidate_inode_pages2_range(mapping, 0, -1, may_destroy);
 }
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
