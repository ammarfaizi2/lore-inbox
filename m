Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVKOR7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVKOR7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVKOR7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:59:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17302 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964916AbVKOR7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:59:13 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051114150347.1188499e.akpm@osdl.org> 
References: <20051114150347.1188499e.akpm@osdl.org>  <dhowells1132005277@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org> 
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 15 Nov 2005 17:59:02 +0000
Message-ID: <11717.1132077542@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > > This series of patches does four things:
> > 
> > Ok, interesting, and I like most of what I see..
> 
> Less impressed.  It (still) adds a very large amount of tricksy code which
> pokes around in core pagecache functions,

What I'm trying to do is actually fairly simple in concept:

 (1) Have a metadata inode (imeta) that covers the block device.

 (2) Metadata pages are attached to imeta at page indexes corresponding to the
     block indexes on disk.

 (3) Metadata blocks on disk are to be considered invariant[*] once attached
     to the on-disk metadata tree rooted in the journal.

     [*] atimes and netfs metadata can be updated in place. They fit into a
     	 single sector, and so we assume changing them is atomic.

 (4) A new metadata tree is constructed by replacing the disk blocks that need
     to be modified with newly allocated blocks, then attaching the old
     unchanged branches to that new block. Think of RCU or LISP.

     The data then needs to be copied from the old block to the new, and the
     old block discarded when the journal is advanced.

 (5) If a copy of the old block is resident on a page in memory and is up to
     date with respect to the old block on disk, then we really don't want to
     have to copy it to another page in memory. This would require allocation
     of an extra page, as well as requiring a full-page copy, thus thrashing
     the data cache.

     What we do is to detach the page from imeta at the old block index and
     reattach it at the new block index (having allocated a new block first).

     However, this means that we potentially have to allocate new radix tree
     bits, and so we're subject to ENOMEM. But once we've allocated a new
     block, we don't want to have to try and roll the allocation back or
     recycle the block because that would potentially incur ENOMEM also...

     In fact, we don't want to take any errors at all (EIO we can deal with
     because that means the blockdev is screwed).

     So we pre-allocate sufficient radix tree bits and attach them to the task
     so that we can (a) sleep and (b) evade ENOMEM between allocating a new
     block and attaching it to the tree's superstructure.

Using buffer heads doesn't help, and using the blockdev's inode to hold pages
doesn't help. This way, I can keep my metadata in the pagecache and the VM will
schedule it to be written out. I also want to avoid bufferheads because they
use up a big additional chunk of memory I'd prefer to avoid having to pin.

> slows down the radix-tree hotpath,

What I wanted was to be able to supply sufficient radix tree nodes in advance
that I wouldn't incur ENOMEM from that source, but I also needed to be able to
sleep after having loaded the cache, which meant I couldn't just shove the
extra in the per-CPU cache.

Admittedly, this is going to slow things down, and there's not a lot I can do
about that without adding full rollback support, which would be a lot of work,
particularly coping with the case of there being insufficient memory for the
cause.

Another way to deal with this would be to provide alternate
add_to_page_cache*() and radix_tree_preload() or radix_tree_insert() functions
that could be given a cache from which to allocate radix tree nodes.

I could also separate out the two sorts of cache. I changed the form of the
radix tree cache to a linked list with a counter instead of an array. This uses
less memory at the head (which we want for adding to task_struct), but may well
be slower when dequeuing elements as the dcache can't help. I could revert the
per-CPU cache to the original form, whilst keeping the per-task cache in the
less-intrusive form.

I could even remove the metadata from the pagecache entirely. I'd rather not do
that, though. Using the page cache has a lot of advantages, and they mostly
outweigh its disadvantages. Probably the biggest advantage is that I can leave
a metadata block I'm not using at the moment lying around in the pagecache; the
VM can discard it if it likes, but if not, it'll be there when I need it again.

> exports mysterious symbols.  And that's on a 60-second scan.

 (*) clear_page_dirty_for_io()

	Used in mpage.c, mpage_writepages() which I have a very simplified
	version of.

 (*) lru_cache_add()

	Normally called indirectly via add_to_page_cache_lru(), but I wanted
	to call add_to_page_cache(), and sometimes use it for multiple pages
	with pagevec_lru_add() which is exported, and sometimes on a single
	page, which means using lru_cache_add().

> It'll be a sizeable job going through it in detail.  Not as sizeable as
> writing it though ;)

:-)

> All of this for an undisclosed speedup of AFS!

What about NFS?

> I think we need an NFS implementation and some numbers which make it
> interesting.  Or at least, some AFS numbers,

I'll generate some, at least for AFS.

> some explanation as to why they can be extrapolated to NFS and some degree of
> interest from the NFS guys.  Ditto CIFS.
> 
> Because it _is_ a lot of code.

Yes, I noticed that too:-)

David
