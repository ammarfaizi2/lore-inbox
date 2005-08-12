Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVHLTeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVHLTeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVHLTeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:34:25 -0400
Received: from smtp.istop.com ([66.11.167.126]:5086 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1750926AbVHLTeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:34:25 -0400
From: Daniel Phillips <phillips@arcor.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Sat, 13 Aug 2005 05:34:53 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, hugh@veritas.com
References: <200508110919.13897.phillips@arcor.de> <21701.1123684072@warthog.cambridge.redhat.com> <3521.1123757360@warthog.cambridge.redhat.com>
In-Reply-To: <3521.1123757360@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508130534.54155.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 August 2005 20:49, David Howells wrote:
> Daniel Phillips <phillips@arcor.de> wrote:
> > To be honest I'm having some trouble following this through logically. 
> > I'll read through a few more times and see if that fixes the problem. 
> > This seems cluster-related, so I have an interest.
>
> Well, perhaps I can explain the function for which I'm using this page flag
> more clearly. You'll have to excuse me if it's covering stuff you don't
> know, but I want to take it from first principles; plus this stuff might
> well find its way into the kernel docs.
>
>
> We want to use a relatively fast medium (such as RAM or local disk) to
> speed up repeated accesses to a relatively slow medium (such as NFS, NBD,
> CDROM) by means of caching the results of previous accesses to the slow
> medium on the fast medium.
>
> Now we already do this at one level: RAM. The page cache _is_ such a cache,
> but whilst it's much faster than a disk, it is severely restricted in size

Did you just suggest that 16 TB/address_space is too small to cache NFS pages?

> compared to media such as disks, it's more expensive

It is?

> and it's contents generally don't last over power failure or reboots.

When used by RAMFS maybe.  But fortunately the page cache has a backing store 
API, in fact, that is its raison d'etre.

> The major attribute of the page cache is that the CPU can access it
> directly. 

You seem to have forgotten about non-resident pages.

> So we want to add another level: local disk. The FS-Cache/CacheFS patches
> permit such as AFS and NFS to use local disk as a cache.

The page cache already lets you do that.  I have not yet discerned a 
fundamental reason why you need to interface to another filesystem to 
implement backing store for an address_space.

> So, assume that NFS is using a local disk cache (it doesn't matter whether
> it's CacheFS, CacheFiles, or something else), and assume a process has a
> file open through NFS.
>
> The process attempts to read from the file. This causes the NFS readpage()
> or readpages() operation to be invoked to load the data into the page cache
> so that the CPU can make use of it.
>
> So the NFS page reading algorithm first consults the disk cache.  Assume 
> this returns a negative response - NFS will then read from the server into
> the page cache. Under cacheless operation, it would then unlock the page
> and the kernel could then let userspace play with it, but we're dealing
> with a cache, and so the newly fetched data must be stored in the disk
> cache for future retrieval.
>
> NFS now has three choices:
>
>  (1) It could institigate a write to the disk cache and wait for that to
>      complete before unlocking the page and letting userspace see it, but
> we don't know how long that might take.

Pages are typically unlocked while being written to backing store, e.g.:

http://lxr.linux.no/source/fs/buffer.c#L1839

What makes NFS special in this regard?

>      CacheFS immediately dispatches a write BIO to get it DMA'd to the disk
> as soon as possible, but something like CacheFiles is dependent on an
> underlying filesystem - be it EXT3, ReiserFS, XFS, etc. - to perform the
> write, and we've no control over that.

That is a problem you are in the process of inventing.

> 	Time to unlock: CacheMiss + NetRead + CacheWrite
> 	Cache reliable: Yes
>
>  (2) It could just unlock the page and let userspace scribble on it whilst
>      simultaneously writing it to the cache. But that means the DMA to the
>      disk may pick up some of userspace's scribblings, and that means you
>      can't trust what's in the cache in the event of a power loss.

I thought I saw a journal in there.  Anyway, if the user has asked for a racy 
write, that is what they should get.

>      This can be alleviated by marking untrustworthy files in the cache,
> but that then extends the management time in several ways.
>
> 	Time to unlock: CacheMiss + NetRead
> 	Cache reliable: No

I think your definition of trustworthy goes beyond what is required by Posix 
or Linux local filesystem semantics.

>  (3) It could tell the cache that the page needs writing to disk and then
>      unlock it for userspace to read, but intercept the change of a PTE
>      pointing to this page when it loses its write protection (PTEs start
> off read-only, generating a write protection fault on the first write).

We need to do something like this to implemented cross-node caching of 
shared-writeable mmaps.  This is another reason that your ideas need clear 
explanations: we need to go the rest of the way and get this sorted out for 
cluster filesystems in general, not just NFS (v4).  It does help a lot that 
you are attempting to explain what the needs of NFS actually are.  
Unfortunately, it seems you are proposing that this mechanism is essential 
even for single-node use, which is far from clear.

>      The interceptor would then force userspace to wait for the cache to
>      finish DMA'ing the page before writing to it.
>
>      Similarly, the write() or prepare_write() operations would wait for
> the cache to finish with that page.

Here you return to the assumption that the VFS should enforce per-page write 
granularity.  There is no such rule as far as I know.

> 	Time to unlock: CacheMiss + NetRead
> 	Cache reliable: Yes
>
> I originally chose option (1), but then I saw just how much it affected
> performance and worked on option (3).
>
> I discarded option (2) because I want to be able to have some surety about
> the state in the cache - I don't want to have to reinitialise it after a
> power failure. Imagine if you cache /usr... Imagine if everyone in a very
> large office caches /usr...
>
>
> So, the way I implemented (3) is to use an extra page flag to indicate a
> write underway to the cache, and thus allow cache write status to be
> determined when someone wants to scribble on a page.
>
> The fscache_write_page() function takes a pointer to a callback function.
> In NFS this function clears the PG_fs_misc bit on the appropriate pages and
> wakes up anyone who was waiting for this event (end_page_fs_misc()).
>
> The NFS page_mkwrite() VMA op calls wait_on_page_fs_misc() to wait on that
> page bit if it is set.
>
> > Who is using this interface?
>
> AFS and NFS will both use it. There may be others eventually who use it for
> the same purpose. CacheFS has a different use for it internally.

Let's try to clear up the page write atomicity question, please.  It seems 
your argument depends on it.

Regards,

Daniel
