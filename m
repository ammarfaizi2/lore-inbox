Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317998AbSGWIOz>; Tue, 23 Jul 2002 04:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317999AbSGWIOz>; Tue, 23 Jul 2002 04:14:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43273 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317998AbSGWIOw>;
	Tue, 23 Jul 2002 04:14:52 -0400
Message-ID: <3D3D1320.4710A756@zip.com.au>
Date: Tue, 23 Jul 2002 01:26:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] vmap_pages()
References: <20020718230003.A6500@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> There's more and more pressure getting XFS into mainline now that most
> distributors ship it and SGI's Red Hat-based installers are in wide use,
> and although most of the core kernel changes in the XFS tree have been
> removed by redesigning/rewriting XFS code.

Hopefully XFS isn't internalising good changes which should
be in the core kernel.

> Still there are a bunch of core code changes that are needed for XFS to
> work without beeing totally rewritten and this patch is an alternate
> version (which should also be usable properly for non-XFS purposes) of
> the probably most important missing core functionality needed by XFS.
> 
> The vmap_pages() functions allows to map an array of virtually
> non-continguos pages into the kernel virtual memory.  The implementation
> is very simple and a small variation of vmalloc() - instead of
> allocating new pages in alloc_area_pte() uncondintionally a pointer to a
> page array is passed down all through vmalloc_area_pages => alloc_area_pmd
> => alloc_area_pte and if it is non-null no pages are allocated but the
> reference count on the existing ones is incremented.

My understanding is that this is used during XFS log recovery
and is not performance-critical.  XFS has a largeish btree
on-disk and it needs to be loaded into virtually contiguous
memory for processing.  Chunking that operation into discontiguous
block-sized memory areas would be rather horrid.  Andrea has
merged the vmalloc enhancements into his tree and he is
presumably OK with them.

The vmap_pages() interface does assume that each page can be mapped
by a single pte.  So it would be awkward for an application such
as, say, turning a bunch of dir-in-pagecache pages into a
virtually contiguous object with PAGE_CACHE_SIZE > PAGE_SIZE.
But the caller could always just chunk those PAGE_CACHE_SIZE
pages into their constituent PAGE_SIZE pages prior to calling
vmap_pages, I guess.

> The old vmalloc_area_pages is renamed to __vmap_area_pages and
> vmalloc_area_pages is a small wrapper around it, passing in an NULL page
> array.  Similarly __vmalloc is renamed to vmap_pages and a small wrapper
> is added.
> 
> In addition I've removed th unused vmalloc_dma and cleaned up vmalloc.h
> a little - this could need more cleanup (and kdoc documentation for
> the vmalloc.c stuff), but I will do this later in an incremental patch.
> 

It'd be better to have the code commentary in-place in the
initial patch - it rather helps reviewing...


I'm not sure that we actually need to get the outside-XFS
changes merged beforehand, really.  It would be sufficient
if you could prepare the individual patches for review as
you've done here and if nobody pukes, they can all be merged
in one big patch.

We also need to work through DMAPI's view of mount semantics
versus Linux's view.  And any duplication between XFS locking
and VFS locking, if any such still exist.

-
