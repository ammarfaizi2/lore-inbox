Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318934AbSIITRe>; Mon, 9 Sep 2002 15:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318935AbSIITRe>; Mon, 9 Sep 2002 15:17:34 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:53004 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318934AbSIITRb>;
	Mon, 9 Sep 2002 15:17:31 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209091858.g89IwW000957@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <20020909181724.GA31153@ravel.coda.cs.cmu.edu> from Jan Harkes at
	"Sep 9, 2002 02:17:24 pm"
To: Jan Harkes <jaharkes@cs.cmu.edu>
Date: Mon, 9 Sep 2002 20:58:32 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@oboe.it.uc3m.es>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
X-Sorted: Bulk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Jan Harkes wrote:"
> On Mon, Sep 09, 2002 at 06:30:21PM +0200, Peter T. Breuer wrote:
> > A concrete question wrt the current file i/o data flow ...

> > I am confused because ext_get_block says it's the file inode:
...
> > and the vfs layer seems to pass mapping->host, which I believe should
> > be associated with the mount.
> 
> mapping->host is the in memory representation of the file's inode (which
> is stored in the inode cache). Basically all filesystem operations go

Ah.  Thank you.  So inode->i_ino might be sufficient shared info to lock
on at the VFS level (well, excluding dropping the [di]cache data for it
on remote kernels, and locking free-block map updates in case its
a create or extend opn) ...

> through the pagecache, i.e. it is as if all files are memory mapped, but
> not visible to userspace.

OooooKay. And it looks as though the mapping remembers quite a bit about
how it was calculated, which is good news.

> Each in-memory cached inode has an 'address_space' associated with it.
> This is basically a logical representation of the file (i.e.
> offset/length). This mapping or address_space has a 'host', which is the
> actual inode that is associated with the data.

OK.

> Now lets consider inode->i_mapping->host, in most cases inode and host
> are identical, but in some cases (i.e. Coda) these are two completely
> different object, Coda inodes don't have their own backing storage, but

Wonderful. And which one is the more abstract?

> rely on an underlying 'container file' hosted by another filesystem to
> hold the actual file data. Stacking filesystems (overlayfs, cryptfs,
> sockfs, Erik Zadok's work) use the same technique.
> 
> Each physical memory page (struct page) is associated with one specific
> address space (i.e. page->mapping). So depending on how we get into the

Depending? Groan.

> system, we can use inode->i_mapping->host, or page->mapping->host to
> find the inode/file object we have to write to and page->index is the

Oh, OK, I see. That's harmless news.

> offset >> PAGE_SIZE within this file. New pages are allocated and
> initialized in mm/filemap.c:page_cache_read, this is called from both
> the pagefault handler, and when generic_read/write cannot find a page in
> the page cache.

OK. You are saying that page info is filled out there, from the given
file pointer?

> Now everywhere in the code that references a 'struct inode' or
> 'mapping->host', is basically directly pointing to a cached object in
> the inode cache and in order to 'disable' caching, all of these would
> have to be replaced with i_ino, so that the inode can be fetched with

Oh, I see. Replace the object with the info necessary to retrieve the
info (again). Icache objects are reference counted, of course. I don't
want to think about this yet!

> iget. Similarily the pages and address_space objects are 'basically
> cached copies of on-disk data' that can become stale as soon as the
> underlying media is volatile. Several filesystem, NFS, Coda, Reiserfs,

Well, is there a problem with using the i_ino everywhere instead of the
inode struct itself? That is a straightforward (albeit universal)
change to make, and means providing an interface to the icache objects
using their i_ino and fs as index. But I really don't want to go there
yet ..

> actually need more than just i_ino to unambiguously identify and
> retrieve the struct inode, and use iget5_locked with filesystem specific

Hmm. OK.

> test/set functions and data, to obtain the in-memory inode.
> 
> Which is just one reason why everyone went through the roof when you
> suggested to completely disable caching.

Well, :-).

> For pagecache consistency, NFS uses "NFS semantics" and uses
> mm/filemap.c:invalidate_inode_pages to flush unmodified/clean pages from

I see. It takes the inode as argument, but only wants the i_mapping
off it. Also good news. It walks what seems to be a list of associated
pages in the mapping.

> the cache. This is done to keep them consistent with the server. I
> believe NFS semantics only requires them to flush data when a file is
> opened an hasn't been referenced for at least 30 seconds, or was last

I've noticed.

> opened/checked more than 30 seconds ago. If you want better guarantees
> from NFS, you need to use file locking.
> 
> Dirty pages can only be thrown out after they have been written
> back. Writing is typically asyncronous, the FS marks a page as dirty,
> then the VM/bdflush/updated/whatever walks all the 'address-spaces' and
> creates buffer heads for any dirty pages it bumps into. These
> bufferheads are then picked up by another daemon that sends them off to
> the underlying block device.

I'll try and make use of this info (later). It's very valuable. Thank you!

> Coda uses AFS or session semantics, which means that we don't care about
> whether cached pages are stale until after the object is closed. AFS
> semantics allows us to avoid the VM mangling to flush cached pages and
> other objects from memory. We only flush the 'dcache entry' when we get
> notified of an updated version on the server we unhash the cached lookup
> information and subsequent lookups will simply return the new file.

What function flushes a particular dcache entry, if I may ask?

> Regular on-disk filesystems have the very strong Unix Semantics.
> Basically when process A writes "A" and then process B writes "B" the
> file will contain "AB", but will never contain "BA", "A", or "B".

OK. So timing is important.

> - For AFS, the file will contain "B" because process B was the last one
>   to close the file.

I see. Writes can/will delay until forced.

> - With Coda we have an update conflict, both "A" and "B" are preserved
>   as 2 'conflicting' versions of the same file.
> 
> - With NFS it depends when the writeback of dirty pages kicks in, the
>   file may contain either "A" or "B".

Interesting. But not both. The implication is that they got different
copies of the file, not a pointer to the same file.

Well, that gives quite a lot of room to play with. But I  think I can
manage the strong unix semantics. Thanks again.

> But without external synchronization (i.e. file-locking) none of these
> network filesystems will have the "AB" version which is only possible
> with filesystems that provide Unix semantics. There was some other

Yes. I see the problem.

> semantic model that could actually lead to the file ending up with "BA",
> but I don't think there are any real-life examples.

Well, this would happen with locking if the lock were on a third node
and there were a race to obtain the lock between two other writers.
Then the race could come out A B or B A, but whichever way it went,
umm, the other would have its cache invalidated after the first op
(well, before the first op got under way), and be forced to reread ..
almost anything can happen, depending on the application code.

Peter

