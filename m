Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312584AbSDJLVg>; Wed, 10 Apr 2002 07:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312585AbSDJLVf>; Wed, 10 Apr 2002 07:21:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58119 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312584AbSDJLVe>;
	Wed, 10 Apr 2002 07:21:34 -0400
Message-ID: <3CB4203D.C3BE7298@zip.com.au>
Date: Wed, 10 Apr 2002 04:21:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [prepatch] address_space-based writeback
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a largish patch which makes some fairly deep changes.  It's
currently at the "wow, it worked" stage.  Most of it is fairly
mature code, but some conceptual changes were recently made.
Hopefully it'll be in respectable state in a few days, but I'd
like people to take a look.

The idea is: all writeback is against address_spaces.  All dirty data
has the dirty bit set against its page.  So all dirty data is
accessible by

	superblock list
		-> superblock dirty inode list
			-> inode mapping's dirty page list.
				-> page_buffers(page) (maybe)

pdflush threads are used to implement periodic writeback (kupdate) by
descending the data structures decribed above.  address_spaces now
carry a timestamp (when it was first dirtied) to permit the traditional
"write back stuff which is older than thirty second" behaviour.

pflush threads are used for global writeback (bdflush analogue).

New address_space operations are introduced for whole-file writeback
and for VM writeback.  The VM writeback function is designed so that
large chunks of data (I grabbed 4 megs out of the air) will be sent
down to the I/O layers in a single operation.

Aside: Remember, although there's a lot of cleanup and uniformity being
introduced here, one goal is to get rid of the whole practice of
chunking data up into tiny pieces, passing them to the request layer,
adding tiny BIOs to them, sorting them, stringing them onto requests,
then feeding them to the device driver to puzzle over.  A key objective
is to deal with maximal-sized chunks of data in an efficient manner. 
Assemble large scatter/gather arrays directly against pagecache at the
filemap level.  No single-buffer I/O.  No single page I/O.


New rules are introduced for the relationship between buffers and their
page:

- If a page has one or more dirty buffers, the page is marked dirty.

- If a page is marked dirty, it *may* have dirty buffers.

- If a page is marked dirty but has no buffers, it is entirely dirty.
   So if buffers are later attached to that page, they are all set
  dirty.

So block_write_full_page will now only write the dirty buffers.

All this is desiged to support file metadata.  Metadata is written back
via its blockdevice's address_space.  So mark_buffer_dirty sets the
buffer dirty, sets the page dirty, attaches the page to the blockdev's
address_space's dirty_pages, attaches the blockdev's inode to its dummy
superblock's dirty inodes list and there we are.  The blockdev mapping
is treated in an identical manner to other address_spaces.

A consequence of this is that if someone cleans a page by directly
writing back its buffers with ll_rw_block or submit_bh, the page will
still be marked dirty, but its buffers will be clean.  That's fine -
block_write_full_page will perform no I/O.  PG_dirty is advisory if
the page has buffers.

We need to be careful to not free buffers against a dirty page. 
Because when they are reattached, *all* the buffers will be marked
dirty.  Which, in the case of the blockdev mapping will corrupt file
data.

Numerous changes in fs/inode.c make it the means by which we perform
most sorts of writeback.  I'll be splitting a new file out from
fs/inode.c for this.


As a consequence of all the above, some adjustments were possible at
the buffer layer.

The patch deletes the buffer LRUs, lru_list_lock, write_locked_buffers,
write_some_buffers, wait_for_buffers, sync_buffers, etc.  The bdflush
tunables have been removed.  All the sync functions operate at the
address_space level only.  The kupdate and bdflush functions have been
removed.

The buffer hash has been removed - hash_table_lock, etc.  Buffercache
lookups use the page hash and then a walk across the page's buffer list.

Per-inode locking for i_dirty_buffers and i_dirty_data_buffers has been
introduced.  That same lock is held across try_to_free_buffers so that
spinlocking may be used to get exclusion against try_to_free_buffers. 
This enabled the new __get_hash_table() to be non-blocking, which is what
some filesystems appear to expect.

sync_page_buffers() has been removed.  This is because all VM writeback
occurs at the address_space level, and all pages which contain dirty
data are marked dirty.  VM throttling occurs purely at the page level -
wait_on_page().

buffer_head.b_inode, unused_list and address_space.i_dirty_data_buffers
have not been removed yet.

The diff (along with another eight patches) is at

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8-pre3/dallocbase-70-writeback.patch

As I say, it's still a few days away from being presentable.  I
definitely need to test a lot of other filesystems because it
did find a few warts in ext2.


-
