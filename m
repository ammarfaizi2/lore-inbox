Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWE3Pin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWE3Pin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 11:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWE3Pin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 11:38:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3540 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932315AbWE3Pim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 11:38:42 -0400
Date: Tue, 30 May 2006 08:38:07 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: David Howells <dhowells@redhat.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages 
In-Reply-To: <12042.1148976035@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0605300818080.16904@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0605260825160.31609@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com>
 <20060525135534.20941.91650.sendpatchset@lappy> <20060525135555.20941.36612.sendpatchset@lappy>
 <24747.1148653985@warthog.cambridge.redhat.com>  <12042.1148976035@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006, David Howells wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > > page_mkwrite() is called just before the _PTE_ is dirtied.  Take
> > > do_wp_page() for example, set_page_dirty() is called after a lot of stuff,
> > > including some stuff that marks the PTE dirty... by which time it's too
> > > late as another thread sharing the page tables can come along and modify
> > > the page before the first thread calls set_page_dirty().

Maybe I do not understand properly. I thought page_mkwrite is called 
before a page is made writable not before it is dirtied. If its only 
called before the page is dirtied then a better name maybe before_dirty or 
so?

> > Since we are terminating the application with extreme prejudice on an 
> > error (SIGBUS) it does not matter if another process has written to the 
> > page in the meantime.
> 
> Erm... Yes, it does matter, at least for AFS or NFS using FS-Cache, and whether
> or not we're generating a SIGBUS or just proceeding normally.  There are two
> cases I've come across:
> 
> Firstly I use page_mkwrite() to make sure that the page is written to the cache
> before we let anyone modify it, just so that we've got a reasonable idea of
> what's in the cache.

What do you mean by "written to the cache"? It cannot be written back 
since the page has been dirtied yet. So "written to the cache" means 
that the FS does some reservation, right?

> What we currently have is:
> 
> 	invoke page_mkwrite()
> 	  - wait for page to be written to the cache

I am not sure what the point would be to write a page that is
not dirty. So I guess this reserves space on disk for the page.

> 	lock
> 	modify PTE
> 	unlock
> 	invoke set_page_dirty()
> 
> What your suggestion gives is:
> 
> 	lock
> 	modify PTE
> 	unlock
> 	invoke set_page_dirty()
> 	  - wait for page to be written to the cache

Regardless of what "written to the cache" exactly means here
we have the page marked dirty in the mapping and queued for write back.

> But what can happen is:
> 
> 	CPU 1			CPU 2
> 	=======================	=======================
> 	write to page (faults)
> 	lock
> 	modify PTE
> 	unlock
> 				write to page (succeeds)

Correct.

> 	invoke set_page_dirty()
> 	  - wait for page to be written to the cache
> 	write to page (succeeds)
> 
> That potentially lets data of uncertain state into the cache, which means we
> can't trust what's in the cache any longer.

It continues established usage and usage that even with your patch 
continues at least for anonymous pages. The page dirty state may also be 
reflected by any dirty bit set in a pte pointing to the page even if the 
dirty state is not set on the page itself.

> Secondly some filesystems want to use page_mkwrite() to prevent a write from
> occurring if a write to a shared writable mapping would require an allocation
> from a filesystem that's currently in an ENOSPC state.  That means that we may
> not change the PTE until we're sure that the allocation is guaranteed to
> succeed, and that means that the kernel isn't left with dirty pages attached to
> inodes it'd like to dispose of but can't because there's nowhere to write the
> data.

If set_page_dirty cannot reserve the page then we know that some severe
action is required. The FS method set_page_dirty() could:

1. Determine the ENOSPC condition before it sets the page dirty.
   That leaves the potential that some writes to the page have occurred
   by other processes.

2. Track down all processes that use the mapping (or maybe less
   severe: processes that have set the dirty bit in the pte) and 
   terminate them with SIGBUS.

