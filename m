Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWCME5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWCME5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 23:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWCME5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 23:57:10 -0500
Received: from xenotime.net ([66.160.160.81]:11422 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932306AbWCME5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 23:57:09 -0500
Date: Sun, 12 Mar 2006 20:58:55 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: NeilBrown <neilb@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 001 of 4] Update some VFS documentation.
Message-Id: <20060312205855.c96a040b.rdunlap@xenotime.net>
In-Reply-To: <1060312235316.15942@suse.de>
References: <20060313104910.15881.patches@notabene>
	<1060312235316.15942@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a few more; you are too fast.
and thanks for doing this.

On Mon, 13 Mar 2006 10:53:16 +1100 NeilBrown wrote:

> @@ -443,14 +447,81 @@ otherwise noted.
>  The Address Space Object
>  ========================
>  
> +There are a number of distinct yet related services that an
> +address-space can provide.  These include communicating memory
> +pressure, page lookup by address, and keeping track of pages tagged as
> +Dirty or Writeback.
> +
> +The first can be used independantly to the others.  The vm can try to

s/vm/VM/

> +either write dirty pages in order to clean them, or release clean
> +pages in order to reuse them.  To do this it can call the ->writepage
> +method on dirty pages, and ->releasepage on clean pages with
> +PagePrivate set. Clean pages without PagePrivate and with no external
> +references will be released without notice being given to the
> +address_space.
> +
> +To achieve this functionality, pages need to be placed on an lru with

prefer s/lru/LRU/

> +lru_cache_add and mark_page_active needs to be called whenever the
> +page is used.
> +
> +Pages are normally kept in a radix tree index by ->index. This tree
> +maintains information about the PG_Dirty and PG_Writeback status of
> +each page, so that pages with either of these flags can be found
> +quickly.
> +
> +The Dirty tag is primarily used by mpage_writepages - the default
> +->writepages method.  It uses the tag to find dirty pages to call
> +->writepage on.  If mpage_writepages is not used (i.e. the address
> +provides it's own ->writepages) , the PAGECACHE_TAG_DIRTY tag is

its

> +almost unused.  write_inode_now and sync_inode do use it (through
> +__sync_single_inode) to check if ->writepages has been successful in
> +writing out the whole address_space.
> +
> +The Writeback tag is used by filemap*wait* and sync_page* functions,
> +though wait_on_page_writeback_range, to wait for all writeback to

s/though/through/ ??

> +complete.  While waiting ->sync_page (if defined) will be called on
> +each page that is found to require writeback

full stop.

> +An address_space handler may attach extra information to a page,
> +typically using the 'private' field in the 'struct page'.  If such
> +information is attached, the PG_Private flag should be set.  This will
> +cause various mm routines to make extra calls into the address_space

prefer s/mm/MM/ (or use VM as above)

> +handler to deal with that data.
> +
> +An address space acts as an intermediate between storage and
> +application.  Data is read into the address space a whole page at a
> +time, and provided to the application either by copying of the page,
> +or by memory-mapping the page.
> +Data is written into the address space by the application, and then
> +written-back to storage typically in whole pages, however the
> +address_space has finner control of write sizes.

finer

> +
> +The read process essentially only requires 'readpage'.  The write
> +process is more complicated and uses prepare_write/commit_write or
> +set_page_dirty to write data into the address_space, and writepage,
> +sync_page, and writepages to writeback data to storage.

> -  writepage: called by the VM write a dirty page to backing store.
> +  writepage: called by the VM to write a dirty page to backing store.
> +      This may happen for data integrity reason (i.e. 'sync'), or

reasons

> +      to free up memory (flush).  The difference can be seen in
> +      wbc->sync_mode.
> +      The PG_Dirty flag has been cleared and PageLocked is true.
> +      writepage should start writeout, should set PG_Writeback,
> +      and should make sure the page is Unlocked, either synchronously
> +      or asynchronously when the write operation completes.
> +
> +      If wbc->sync_mode is WB_SYNC_NONE, ->writepage doesn't have to
> +      try too hard if there are problems, and may choose to write out a
> +      different page from the mapping if that would be more
> +      appropriate.  If it chooses not to start writeout, it should

any definition of appropriate?

> +      return AOP_WRITEPAGE_ACTIVATE so that the VM will not keep
> +      calling ->writepage on that page.
> +
> +      See the file "Locking" for more details.
>  
>    readpage: called by the VM to read a page from backing store.
> +       The page will be Locked when readpage is called, and should be
> +       unlocked and marked uptodate once the read completes.
> +       If ->readpage discovers that it needs to unlock the page for
> +       some reason, it can do so, and then return AOP_TRUNCATED_PAGE.
> +       In this case, the page will be re-located, re-locked and if

drop the hyphens

> +       that all succeeds, ->readpage will be called again.
>  
>    sync_page: called by the VM to notify the backing store to perform all
>    	queued I/O operations for a page. I/O operations for other pages
> -	associated with this address_space object may also be performed.
> +	associated with this address_space object may also be
> +  	performed.
> +	This function is optional and is called only for pages with
> +  	PG_Writeback set while waiting for the writeback to complete.
>  
>    writepages: called by the VM to write out pages associated with the
> -  	address_space object.
> +  	address_space object.  If WBC_SYNC_ALL, then the

If WBC_SYNC_ALL <what> ?

> +  	writeback_control will specify a range of pages that must be
> +  	written out.  If WBC_SYNC_NONE, then a nr_to_write is given

If WBC_SYNC_NONE <what> ?

> +	and that many pages should be written if possible.
> +	If no ->writepages is given, then mpage_writepages is used
> +  	instead.  This will choose pages from the addresspace that are
> +  	tagged as DIRTY and will pass them to ->writepage.
>  
> -  commit_write: called by the generic write path in VM to write page to
> -  	its backing store.
> +  	request for a page.  This indicates to the address space that
> +  	the given range of bytes are about to be written.  The

is about to be written.

> +  	address_space should check that the write will be able to
> +  	complete, by allocating space if necessary and doing any other
> +  	internal house keeping.  If the write will update parts some

housekeeping.

> +  	some basic-blocks on storage, then those blocks should be
> +  	pre-read (if they haven't been read already) so that the
> +  	update will not leave half-blocks that need to be written out.
> +	The page will be locked.  If prepare_write wants to unlock the
> +  	page it, like readpage, may do so and return
> +  	AOP_TRUNCATED_PAGE.
> +	In this case the prepare_write will be retried one the lock is
> +  	regained.
> +
> +  commit_write: If prepare_write succeeds, new data will be copied
> +        into the page and then commit_write will be called.  It will
> +        typically update the size of the file (if appropriate) and
> +        mark the inode as dirty, and do any other related housekeeping
> +        operations.  It should avoid returning an error if possible -
> +        errors should have been handled by prepare_write.
>  

> -  direct_IO: called by the VM for direct I/O writes and reads.
> +  	physical block number. This method is used by for the FIBMAP

by for ??

> +  	ioctl and for working with swap-files.  To be able to swap to
> +  	a file, the file must have as stable mapping to a block

must have a

> +  	device.  The swap system does not go through the filesystem
> +  	but instead uses bmap to find out where the blocks in the file
> +  	are and uses those addresses directly.
> +
> +
> +  invalidatepage: If a page has PagePrivate set, then invalidatepage
> +        will be called when part or all of the page is to be removed
> +	from the address space.  This generally corresponds either a

corresponds to

> +	truncation or a complete invalidation of the address space
> +	(in the latter case 'offset' will always be 0).
> +	Any private data associated with the page should be updated
> +	to reflect this truncation.  If offset is 0, then
> +	the private data should be released, because the page
> +	must be able to be completely discarded.  This may be done by
> +        calling the ->releasepage function, but in this case the
> +        release MUST succeed.
> +
> +  releasepage: releasepage is called on PagePrivate pages to indicate
> +        that the page should be freed if possible.  ->releasepage
> +        should remove any private data from the page and clear the
> +        PagePrivate flag.  It may also remove the page from the
> +        address_space.  If this fails for some reason, it may indicate
> +        failure with a 0 return value.
> +	This is used in two distinct though related cases.  The first
> +        is when the VM finds a clean page with no active users and
> +        wants to make it a free page.  If ->releasepage succeeds, the
> +        page will be removed from the address_space and become free.
> +
> +	The second case if when a request has been made to invalidate
> +        some or all pages in an address_space.  This can happen
> +        through the fadvice(POSIX_FADV_DONTNEED) system call or by the
> +        filesystem explicitly requesting it as nfs and 9fs do (when
> +        they believe the cache may be out of date with storage) by
> +        calling invalidate_inode_pages2().
> +	If the filesystem makes such a call, and needs to be certain
> +        that all pages are invalidated, then it's releasepage will

its

> +        need to ensure this.  Possibly it can clear the PageUptodate
> +        bit if it cannot free private data yet.
> +
> +  direct_IO: called by the generic read/write routines to perform
> +        direct_IO - that is IO requests which bypass the page cache
> +        and tranfer data directly between the storage and the

transfer

> +        application's address space.
>  

HTH.
---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
