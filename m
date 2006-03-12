Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWCLXy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWCLXy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWCLXy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:54:28 -0500
Received: from ns.suse.de ([195.135.220.2]:41095 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932220AbWCLXy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:54:27 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 13 Mar 2006 10:53:16 +1100
Message-Id: <1060312235316.15942@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 001 of 4] Update some VFS documentation.
References: <20060313104910.15881.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Flesh out the description of the address_space operations.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/filesystems/vfs.txt |  216 ++++++++++++++++++++++++++++++++----
 1 file changed, 194 insertions(+), 22 deletions(-)

diff ./Documentation/filesystems/vfs.txt~current~ ./Documentation/filesystems/vfs.txt
--- ./Documentation/filesystems/vfs.txt~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./Documentation/filesystems/vfs.txt	2006-03-13 10:42:31.000000000 +1100
@@ -230,10 +230,14 @@ only called from a process context (i.e.
 or bottom half).
 
   alloc_inode: this method is called by inode_alloc() to allocate memory
- 	for struct inode and initialize it.
+ 	for struct inode and initialize it.  If this function is not
+ 	defined, a simple 'struct inode' is allocated.  Normally
+ 	alloc_inode will be used to allocate a larger structure which
+ 	contains a 'struct inode' embedded within it.
 
   destroy_inode: this method is called by destroy_inode() to release
-  	resources allocated for struct inode.
+  	resources allocated for struct inode.  It is only required of
+  	->alloc_inode was defined and simply does a deallocate.
 
   read_inode: this method is called to read a specific inode from the
         mounted filesystem.  The i_ino member in the struct inode is
@@ -443,14 +447,81 @@ otherwise noted.
 The Address Space Object
 ========================
 
-The address space object is used to identify pages in the page cache.
+The address space object is used to group and manage pages in the page
+cache.  It can be used to keep track of the pages in a file (or
+anything else) and also track the mapping of sections of the file into
+process address spaces.
+
+There are a number of distinct yet related services that an
+address-space can provide.  These include communicating memory
+pressure, page lookup by address, and keeping track of pages tagged as
+Dirty or Writeback.
+
+The first can be used independantly to the others.  The vm can try to
+either write dirty pages in order to clean them, or release clean
+pages in order to reuse them.  To do this it can call the ->writepage
+method on dirty pages, and ->releasepage on clean pages with
+PagePrivate set. Clean pages without PagePrivate and with no external
+references will be released without notice being given to the
+address_space.
+
+To achieve this functionality, pages need to be placed on an lru with
+lru_cache_add and mark_page_active needs to be called whenever the
+page is used.
+
+Pages are normally kept in a radix tree index by ->index. This tree
+maintains information about the PG_Dirty and PG_Writeback status of
+each page, so that pages with either of these flags can be found
+quickly.
+
+The Dirty tag is primarily used by mpage_writepages - the default
+->writepages method.  It uses the tag to find dirty pages to call
+->writepage on.  If mpage_writepages is not used (i.e. the address
+provides it's own ->writepages) , the PAGECACHE_TAG_DIRTY tag is
+almost unused.  write_inode_now and sync_inode do use it (through
+__sync_single_inode) to check if ->writepages has been successful in
+writing out the whole address_space.
+
+The Writeback tag is used by filemap*wait* and sync_page* functions,
+though wait_on_page_writeback_range, to wait for all writeback to
+complete.  While waiting ->sync_page (if defined) will be called on
+each page that is found to require writeback
+
+An address_space handler may attach extra information to a page,
+typically using the 'private' field in the 'struct page'.  If such
+information is attached, the PG_Private flag should be set.  This will
+cause various mm routines to make extra calls into the address_space
+handler to deal with that data.
+
+An address space acts as an intermediate between storage and
+application.  Data is read into the address space a whole page at a
+time, and provided to the application either by copying of the page,
+or by memory-mapping the page.
+Data is written into the address space by the application, and then
+written-back to storage typically in whole pages, however the
+address_space has finner control of write sizes.
+
+The read process essentially only requires 'readpage'.  The write
+process is more complicated and uses prepare_write/commit_write or
+set_page_dirty to write data into the address_space, and writepage,
+sync_page, and writepages to writeback data to storage.
+
+Adding and removing pages to/from an address_space is protected by the
+inode's i_mutex.
+
+When data is written to a page, the PG_Dirty flag should be set.  It
+typically remains set until writepage asks for it to be written.  This
+should clear PG_Dirty and set PG_Writeback.  It can be actually
+written at any point after PG_Dirty is clear.  Once it is known to be
+safe, PG_Writeback is cleared.
 
+Writeback makes use of a writeback_control structure...
 
 struct address_space_operations
 -------------------------------
 
 This describes how the VFS can manipulate mapping of a file to page cache in
-your filesystem. As of kernel 2.6.13, the following members are defined:
+your filesystem. As of kernel 2.6.16, the following members are defined:
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
@@ -469,47 +540,148 @@ struct address_space_operations {
 			loff_t offset, unsigned long nr_segs);
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
 			int);
+	/* migrate the contents of a page to the specified target */
+	int (*migratepage) (struct page *, struct page *);
 };
 
-  writepage: called by the VM write a dirty page to backing store.
+  writepage: called by the VM to write a dirty page to backing store.
+      This may happen for data integrity reason (i.e. 'sync'), or
+      to free up memory (flush).  The difference can be seen in
+      wbc->sync_mode.
+      The PG_Dirty flag has been cleared and PageLocked is true.
+      writepage should start writeout, should set PG_Writeback,
+      and should make sure the page is Unlocked, either synchronously
+      or asynchronously when the write operation completes.
+
+      If wbc->sync_mode is WB_SYNC_NONE, ->writepage doesn't have to
+      try too hard if there are problems, and may choose to write out a
+      different page from the mapping if that would be more
+      appropriate.  If it chooses not to start writeout, it should
+      return AOP_WRITEPAGE_ACTIVATE so that the VM will not keep
+      calling ->writepage on that page.
+
+      See the file "Locking" for more details.
 
   readpage: called by the VM to read a page from backing store.
+       The page will be Locked when readpage is called, and should be
+       unlocked and marked uptodate once the read completes.
+       If ->readpage discovers that it needs to unlock the page for
+       some reason, it can do so, and then return AOP_TRUNCATED_PAGE.
+       In this case, the page will be re-located, re-locked and if
+       that all succeeds, ->readpage will be called again.
 
   sync_page: called by the VM to notify the backing store to perform all
   	queued I/O operations for a page. I/O operations for other pages
-	associated with this address_space object may also be performed.
+	associated with this address_space object may also be
+  	performed.
+	This function is optional and is called only for pages with
+  	PG_Writeback set while waiting for the writeback to complete.
 
   writepages: called by the VM to write out pages associated with the
-  	address_space object.
+  	address_space object.  If WBC_SYNC_ALL, then the
+  	writeback_control will specify a range of pages that must be
+  	written out.  If WBC_SYNC_NONE, then a nr_to_write is given
+	and that many pages should be written if possible.
+	If no ->writepages is given, then mpage_writepages is used
+  	instead.  This will choose pages from the addresspace that are
+  	tagged as DIRTY and will pass them to ->writepage.
 
   set_page_dirty: called by the VM to set a page dirty.
+        This is particularly needed if an address space attaches
+        private data to a page, and that data needs to be updated when
+        a page is dirtied.  This is called, for example, when a memory
+	mapped page gets modified.
+	If defined, it should set the PageDirty flag, and the
+        PAGECACHE_TAG_DIRTY tag in the radix tree.
 
   readpages: called by the VM to read pages associated with the address_space
-  	object.
+  	object. This is essentailly just a vector version of
+  	readpage.  Instead of just one page, several pages are
+  	requested.
+	readpages is only used for readahead, so read errors are
+  	ignored.  If anything goes wrong, feel free to give up.
 
   prepare_write: called by the generic write path in VM to set up a write
-  	request for a page.
-
-  commit_write: called by the generic write path in VM to write page to
-  	its backing store.
+  	request for a page.  This indicates to the address space that
+  	the given range of bytes are about to be written.  The
+  	address_space should check that the write will be able to
+  	complete, by allocating space if necessary and doing any other
+  	internal house keeping.  If the write will update parts some
+  	some basic-blocks on storage, then those blocks should be
+  	pre-read (if they haven't been read already) so that the
+  	update will not leave half-blocks that need to be written out.
+	The page will be locked.  If prepare_write wants to unlock the
+  	page it, like readpage, may do so and return
+  	AOP_TRUNCATED_PAGE.
+	In this case the prepare_write will be retried one the lock is
+  	regained.
+
+  commit_write: If prepare_write succeeds, new data will be copied
+        into the page and then commit_write will be called.  It will
+        typically update the size of the file (if appropriate) and
+        mark the inode as dirty, and do any other related housekeeping
+        operations.  It should avoid returning an error if possible -
+        errors should have been handled by prepare_write.
 
   bmap: called by the VFS to map a logical block offset within object to
-  	physical block number. This method is use by for the legacy FIBMAP
-	ioctl. Other uses are discouraged.
-
-  invalidatepage: called by the VM on truncate to disassociate a page from its
-  	address_space mapping.
-
-  releasepage: called by the VFS to release filesystem specific metadata from
-  	a page.
-
-  direct_IO: called by the VM for direct I/O writes and reads.
+  	physical block number. This method is used by for the FIBMAP
+  	ioctl and for working with swap-files.  To be able to swap to
+  	a file, the file must have as stable mapping to a block
+  	device.  The swap system does not go through the filesystem
+  	but instead uses bmap to find out where the blocks in the file
+  	are and uses those addresses directly.
+
+
+  invalidatepage: If a page has PagePrivate set, then invalidatepage
+        will be called when part or all of the page is to be removed
+	from the address space.  This generally corresponds either a
+	truncation or a complete invalidation of the address space
+	(in the latter case 'offset' will always be 0).
+	Any private data associated with the page should be updated
+	to reflect this truncation.  If offset is 0, then
+	the private data should be released, because the page
+	must be able to be completely discarded.  This may be done by
+        calling the ->releasepage function, but in this case the
+        release MUST succeed.
+
+  releasepage: releasepage is called on PagePrivate pages to indicate
+        that the page should be freed if possible.  ->releasepage
+        should remove any private data from the page and clear the
+        PagePrivate flag.  It may also remove the page from the
+        address_space.  If this fails for some reason, it may indicate
+        failure with a 0 return value.
+	This is used in two distinct though related cases.  The first
+        is when the VM finds a clean page with no active users and
+        wants to make it a free page.  If ->releasepage succeeds, the
+        page will be removed from the address_space and become free.
+
+	The second case if when a request has been made to invalidate
+        some or all pages in an address_space.  This can happen
+        through the fadvice(POSIX_FADV_DONTNEED) system call or by the
+        filesystem explicitly requesting it as nfs and 9fs do (when
+        they believe the cache may be out of date with storage) by
+        calling invalidate_inode_pages2().
+	If the filesystem makes such a call, and needs to be certain
+        that all pages are invalidated, then it's releasepage will
+        need to ensure this.  Possibly it can clear the PageUptodate
+        bit if it cannot free private data yet.
+
+  direct_IO: called by the generic read/write routines to perform
+        direct_IO - that is IO requests which bypass the page cache
+        and tranfer data directly between the storage and the
+        application's address space.
 
   get_xip_page: called by the VM to translate a block number to a page.
 	The page is valid until the corresponding filesystem is unmounted.
 	Filesystems that want to use execute-in-place (XIP) need to implement
 	it.  An example implementation can be found in fs/ext2/xip.c.
 
+  migrate_page:  This is used to compact the physical memory usage.
+        If the VM wants to relocate a page (maybe off a memory card
+        that is signalling imminent failure) it will pass a new page
+	and an old page to this function.  migrate_page should
+	transfer any private data across and update any references
+        that it has to the page.
 
 The File Object
 ===============
