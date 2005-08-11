Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVHKKtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVHKKtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 06:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVHKKtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 06:49:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24497 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964959AbVHKKtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 06:49:39 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200508110919.13897.phillips@arcor.de>
References: <200508110919.13897.phillips@arcor.de>  <200508102334.43662.phillips@arcor.de> <31567.1123679613@warthog.cambridge.redhat.com> <21701.1123684072@warthog.cambridge.redhat.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, hugh@veritas.com
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Thu, 11 Aug 2005 11:49:20 +0100
Message-ID: <3521.1123757360@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:

> To be honest I'm having some trouble following this through logically.  I'll
> read through a few more times and see if that fixes the problem.  This seems
> cluster-related, so I have an interest.

Well, perhaps I can explain the function for which I'm using this page flag
more clearly. You'll have to excuse me if it's covering stuff you don't know,
but I want to take it from first principles; plus this stuff might well find
its way into the kernel docs.


We want to use a relatively fast medium (such as RAM or local disk) to speed
up repeated accesses to a relatively slow medium (such as NFS, NBD, CDROM) by
means of caching the results of previous accesses to the slow medium on the
fast medium.

Now we already do this at one level: RAM. The page cache _is_ such a cache,
but whilst it's much faster than a disk, it is severely restricted in size
compared to media such as disks, it's more expensive, and it's contents
generally don't last over power failure or reboots. The major attribute of the
page cache is that the CPU can access it directly.

So we want to add another level: local disk. The FS-Cache/CacheFS patches
permit such as AFS and NFS to use local disk as a cache.


So, assume that NFS is using a local disk cache (it doesn't matter whether
it's CacheFS, CacheFiles, or something else), and assume a process has a file
open through NFS.

The process attempts to read from the file. This causes the NFS readpage() or
readpages() operation to be invoked to load the data into the page cache so
that the CPU can make use of it.

So the NFS page reading algorithm first consults the disk cache. Assume this
returns a negative response - NFS will then read from the server into the page
cache. Under cacheless operation, it would then unlock the page and the kernel
could then let userspace play with it, but we're dealing with a cache, and so
the newly fetched data must be stored in the disk cache for future retrieval.

NFS now has three choices:

 (1) It could institigate a write to the disk cache and wait for that to
     complete before unlocking the page and letting userspace see it, but we
     don't know how long that might take.

     CacheFS immediately dispatches a write BIO to get it DMA'd to the disk as
     soon as possible, but something like CacheFiles is dependent on an
     underlying filesystem - be it EXT3, ReiserFS, XFS, etc. - to perform the
     write, and we've no control over that.

	Time to unlock: CacheMiss + NetRead + CacheWrite
	Cache reliable: Yes

 (2) It could just unlock the page and let userspace scribble on it whilst
     simultaneously writing it to the cache. But that means the DMA to the
     disk may pick up some of userspace's scribblings, and that means you
     can't trust what's in the cache in the event of a power loss.

     This can be alleviated by marking untrustworthy files in the cache, but
     that then extends the management time in several ways.

	Time to unlock: CacheMiss + NetRead
	Cache reliable: No

 (3) It could tell the cache that the page needs writing to disk and then
     unlock it for userspace to read, but intercept the change of a PTE
     pointing to this page when it loses its write protection (PTEs start off
     read-only, generating a write protection fault on the first write).

     The interceptor would then force userspace to wait for the cache to
     finish DMA'ing the page before writing to it.

     Similarly, the write() or prepare_write() operations would wait for the
     cache to finish with that page.

	Time to unlock: CacheMiss + NetRead
	Cache reliable: Yes

I originally chose option (1), but then I saw just how much it affected
performance and worked on option (3).

I discarded option (2) because I want to be able to have some surety about the
state in the cache - I don't want to have to reinitialise it after a power
failure. Imagine if you cache /usr... Imagine if everyone in a very large
office caches /usr...


So, the way I implemented (3) is to use an extra page flag to indicate a write
underway to the cache, and thus allow cache write status to be determined when
someone wants to scribble on a page.

The fscache_write_page() function takes a pointer to a callback function. In
NFS this function clears the PG_fs_misc bit on the appropriate pages and wakes
up anyone who was waiting for this event (end_page_fs_misc()).

The NFS page_mkwrite() VMA op calls wait_on_page_fs_misc() to wait on that
page bit if it is set.

> Who is using this interface?

AFS and NFS will both use it. There may be others eventually who use it for
the same purpose. CacheFS has a different use for it internally.

David
