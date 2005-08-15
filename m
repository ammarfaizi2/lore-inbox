Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVHONPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVHONPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 09:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVHONPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 09:15:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14741 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932394AbVHONPe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 09:15:34 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200508130534.54155.phillips@arcor.de> 
References: <200508130534.54155.phillips@arcor.de>  <200508110919.13897.phillips@arcor.de> <21701.1123684072@warthog.cambridge.redhat.com> <3521.1123757360@warthog.cambridge.redhat.com> 
To: Daniel Phillips <phillips@arcor.de>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, hugh@veritas.com
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 15 Aug 2005 14:15:17 +0100
Message-ID: <8985.1124111717@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:

> > Now we already do this at one level: RAM. The page cache _is_ such a cache,
> > but whilst it's much faster than a disk, it is severely restricted in size
> 
> Did you just suggest that 16 TB/address_space is too small to cache NFS pages?

No. I meant that you normally have a lot less RAM than you have, say, local
disk space or the NFS fileserver has available file data to serve.

> > compared to media such as disks, it's more expensive
> 
> It is?

By expensive, I mean moneywise. You can get large disks at under 50p/Gig these
days. If you can get 400GB of RAM for under £200, I'd really love to know from
where.

> > and it's contents generally don't last over power failure or reboots.
> 
> When used by RAMFS maybe.  But fortunately the page cache has a backing store 
> API, in fact, that is its raison d'etre.

Are you referring to writepage(s)? If so, your statement is irrelevant. The NFS
filesystem does not currently save anything locally, except in the page cache -
in RAM.

Swap is also irrelevant.

> > The major attribute of the page cache is that the CPU can access it
> > directly. 
> 
> You seem to have forgotten about non-resident pages.

Non-resident pages? The page cache doesn't have non-resident pages. Dirty pages
wind up either being written back to the host mapping or get written to swap
when evicted from RAM, and in either case have left the page cache.

Can you be more explicit about what you mean?

> > So we want to add another level: local disk. The FS-Cache/CacheFS patches
> > permit such as AFS and NFS to use local disk as a cache.
> 
> The page cache already lets you do that.

How? And if you wish to say inode->i_host, you must first consider the problems
with that mechanism.

> I have not yet discerned a fundamental reason why you need to interface to
> another filesystem to implement backing store for an address_space.

Where are you going to place the cache backing store? Are you going to point
the i_host from each NFS inode, say, directly at the i_data of a block device?

>From what you said, you aren't going to point i_host at the i_data from an
inode from another filesystem...

> > So, assume that NFS is using a local disk cache (it doesn't matter whether
> > it's CacheFS, CacheFiles, or something else), and assume a process has a
> > file open through NFS.
> >
> > The process attempts to read from the file. This causes the NFS readpage()
> > or readpages() operation to be invoked to load the data into the page cache
> > so that the CPU can make use of it.
> >
> > So the NFS page reading algorithm first consults the disk cache.  Assume 
> > this returns a negative response - NFS will then read from the server into
> > the page cache. Under cacheless operation, it would then unlock the page
> > and the kernel could then let userspace play with it, but we're dealing
> > with a cache, and so the newly fetched data must be stored in the disk
> > cache for future retrieval.
> >
> > NFS now has three choices:
> >
> >  (1) It could institigate a write to the disk cache and wait for that to
> >      complete before unlocking the page and letting userspace see it, but
> > we don't know how long that might take.
> 
> Pages are typically unlocked while being written to backing store, e.g.:
> 
> http://lxr.linux.no/source/fs/buffer.c#L1839
> 
> What makes NFS special in this regard?

You're asking the wrong question. Nothing makes NFS, AFS, ISOFS special in this
regard. What _is_ special is the procedure they're having to go through to
write data into the cache.

They don't want to extent the readpage-to-unlock time any more than they have
to, which means the data must be written to the cache after the page is
unlocked.

> >      CacheFS immediately dispatches a write BIO to get it DMA'd to the disk
> > as soon as possible, but something like CacheFiles is dependent on an
> > underlying filesystem - be it EXT3, ReiserFS, XFS, etc. - to perform the
> > write, and we've no control over that.
> 
> That is a problem you are in the process of inventing.

No. It's a problem, full stop - unless you're advocating reading the entire
file on open() or read_inode()...

I suppose in one way it's a problem of my inventing: I want to know what state
the cache is in, and so refuse to let userspace corrupt as-yet uncached data.

> >  (2) It could just unlock the page and let userspace scribble on it whilst
> >      simultaneously writing it to the cache. But that means the DMA to the
> >      disk may pick up some of userspace's scribblings, and that means you
> >      can't trust what's in the cache in the event of a power loss.
> 
> I thought I saw a journal in there.

That gives me full filesystem integrity and data integrity on the cache.

> Anyway, if the user has asked for a racy write, that is what they should get.

There are three things for you to consider:

 (1) What happens when the power goes off and comes back on again. Can you
     trust what's in the cache? It may have been modified by userspace process
     through a MAP_SHARED/PROT_WRITE mapping whilst it was initially being
     DMA'd to the cache, and we would not have recorded this fact.

 (2) The user hasn't asked for a racy write. We can - and by default should -
     maintain data integrity where possible.

 (3) The cache-less behaviour should match the cached behaviour if we can.

> >      This can be alleviated by marking untrustworthy files in the cache,
> > but that then extends the management time in several ways.
> >
> > 	Time to unlock: CacheMiss + NetRead
> > 	Cache reliable: No
> 
> I think your definition of trustworthy goes beyond what is required by Posix 
> or Linux local filesystem semantics.

Maybe there are other requirements than those of which you're aware. _You_ may
not care, but other people do. Some people have offices full of people with
/usr network mounted. They want to be sure when the power is restored that all
their machines come up with a minimum of fuss - and they certainly don't want
the network to melt down.

Besides, I can have my cake and eat it too, it would seem, from the little
performance testing I've been able to do thus far.

Furthermore, unless you're planning something more exotic than what I am,
you're still going to have to go through the loving hands of _some_ filesystem
or other. CacheFS is just one option; FS-Cache allows for others. There _will_
be a caching on cache files on an already mounted filesystem option too, if I
can get it to work, and despite what you may think, it's not as easy as it
seems - not if I want to keep the impact down.

Of course, if you have a better way of doing it, please say! I'll implement it
if I can work out how it's done, and if I think it is better.

> >  (3) It could tell the cache that the page needs writing to disk and then
> >      unlock it for userspace to read, but intercept the change of a PTE
> >      pointing to this page when it loses its write protection (PTEs start
> > off read-only, generating a write protection fault on the first write).
> 
> We need to do something like this to implemented cross-node caching of 
> shared-writeable mmaps.  This is another reason that your ideas need clear 
> explanations: we need to go the rest of the way and get this sorted out for 
> cluster filesystems in general, not just NFS (v4).  It does help a lot that 
> you are attempting to explain what the needs of NFS actually are.  
> Unfortunately, it seems you are proposing that this mechanism is essential 
> even for single-node use, which is far from clear.

It isn't essential. But it improves performance no end, because it lets you
avoid adding the write-to-disk time into the readpage-till-unlock time without
corrupting your cache.

Think of it this then:

   Doing, say, an NFS read through a cold disk cache involves two I/O
   operations: one to read the data from the network and the other to write it
   to the disk cache. Not only that, but the two operations _have_ to be
   sequential.

   In the simplest method, you do both operations before releasing the data to
   userspace. This is, however, really slow.

   Another method is to do the read operation, release the data to userspace
   and then write the data to the cache, not caring if userspace changes the
   data before they're written to the cache. This is, however, a real pain to
   recover from after a power failure or a crash.

   A third mechanism is to do the read, release and write in that order, but
   don't permit userspace to _modify_ the data until it has been written to the
   cache. This means you have some idea of the state your cache is in, even
   despite crashes and power failure, but at the expense of holding up writes
   to existing data, be it through a mapping or directly.

I've chosen the third mechanism. Most data read are never modified; most writes
truncate the intended file or create a new one.

> >      The interceptor would then force userspace to wait for the cache to
> >      finish DMA'ing the page before writing to it.
> >
> >      Similarly, the write() or prepare_write() operations would wait for
> > the cache to finish with that page.
> 
> Here you return to the assumption that the VFS should enforce per-page write 
> granularity.  There is no such rule as far as I know.

You mean like readpage(s) and writepage(s) don't suggest page granularity? And
the MMU certainly doesn't enforce it?

Actually, what you said is true, to a certain extent, but the VFS doesn't
currently get a look in on FS-Cache. I'd sort of like it to, but it can live
entirely within the interested filesystem (by which I mean NFS, AFS, ISOFS,
etc.).

I've optimised FS-Cache around pages, yes; but generally that's good enough for
the cache - though it does mean you might end up doing a little extra DMA'ing
than you'd really like to. However, most writes are a contiguous steam,
starting with the first byte of the file. FS-Cache must be given the size of
the file before the file may be extended that far, and so the caching backend
need only write out what is required.

> > The NFS page_mkwrite() VMA op calls wait_on_page_fs_misc() to wait on that
> > page bit if it is set.
> >
> > > Who is using this interface?
> >
> > AFS and NFS will both use it. There may be others eventually who use it for
> > the same purpose. CacheFS has a different use for it internally.

There's another use for this too: filesystems like EXT3 and JFFS2 could (and
perhaps should?) use page_mkwrite() to deal with ENOSPC by delivering a SIGBUS
rather than letting an unwritable, unreleasable page lurk in memory forever.

> Let's try to clear up the page write atomicity question, please.  It seems 
> your argument depends on it.

What about it? I want to know when a page is going to be modified so that I can
predict the state of the cache as much as possible. I don't want userspace
processes corrupting the cache in unrecorded ways. I'd very much rather not
have to blow my cache away on booting because it hadn't been shut down cleanly.

David
