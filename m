Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWE3R5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWE3R5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWE3R5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:57:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60834 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932364AbWE3R5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:57:03 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0605300953390.17716@schroedinger.engr.sgi.com> 
References: <Pine.LNX.4.64.0605300953390.17716@schroedinger.engr.sgi.com>  <Pine.LNX.4.64.0605300818080.16904@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0605260825160.31609@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com> <20060525135534.20941.91650.sendpatchset@lappy> <20060525135555.20941.36612.sendpatchset@lappy> <24747.1148653985@warthog.cambridge.redhat.com> <12042.1148976035@warthog.cambridge.redhat.com> <7966.1149006374@warthog.cambridge.redhat.com> 
To: Christoph Lameter <clameter@sgi.com>
Cc: David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 30 May 2006 18:56:27 +0100
Message-ID: <18903.1149011787@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:

> On Tue, 30 May 2006, David Howells wrote:
> 
> > > If set_page_dirty cannot reserve the page then we know that some severe
> > > action is required. The FS method set_page_dirty() could:
> > 
> > But by the time set_page_dirty() is called, it's too late as the code
> > currently stands.  We've already marked the PTE writable and dirty.  The
> > page_mkwrite() op is called _first_.
> 
> We are in set_page_dirty and this would be part of set_page_dirty 
> processing.

Eh?  What do you mean "We are in set_page_dirty"?

The main caller of page_mkwrite() is do_wp_page().  With my patch, this
function does the following steps in order:

	(1) Invoke page_mkwrite() if available, giving SIGBUS on error.

	(2) Mark the PTE writable and dirty.

	(3) Unlock the page table.

Then with Peter's patch:

	(4) Invoke set_page_dirty_balance().

We shouldn't be having to handle an error at step (4), and we shouldn't be
marking the page dirty before step (2).

In fact, it could be argued that we shouldn't be marking the page dirty until
it is actually dirty, but I can't see any way to do that atomically short of
emulating the store instruction without hardware support.

> > > 2. Track down all processes that use the mapping (or maybe less
> > 
> > That's bad, even if you restrict it to those that have MAP_SHARED and
> > PROT_WRITE set.  They should not be terminated if they haven't attempted to
> > write to the mapping.
> 
> Its bad but the out of space situation is an exceptional situation. We do 
> similar contortions when we run out of memory space. As I said: One can 
> track down the processes that have dirtied the pte to the page in question 
> and just terminate those and remove the page.

In general, we really really shouldn't just remove the page.  The only place I
would consider it appropriate to destroy a dirty page is if we can't write it
back because the backing store is no longer available due to an event we
cannot predict (network filesystems for example).

We should operate on preventative measures rather than curative ones: we
should detect ENOSPC in advance and signal the process doing the write that
that it's not permitted to proceed.  We shouldn't go and kill all the
processes that might write to that mapping.

Prevention is almost always cleaner than trying to fix things up afterwards.

> > What's wrong with my suggestion anyway?
> 
> Adds yet another method with functionality that for the most part 
> is the same as set_page_dirty().

It's not exactly the same.  It's almost the same difference as between
prepare_write() and commit_write().  Currently it's very much the same
because, as I understand it, the PTE dirty flag is transferred to the page
struct when the PTE is destroyed (in zap_pte_range()).

Actually, I'm not sure that calling set_page_dirty() at the bottom of
do_wp_page() is necessarily a good idea.  It's possible that the page will be
marked dirty in do_wp_page() and then will get written back before the write
actually succeeds.  In other words the page may be marked dirty and cleaned up
all before the modification _actually_ occurs.  On the other hand, the common
case is probably that the store instruction will beat the writeback.

Of course, if you're proposing to call set_page_dirty() before the PTE is
modified, that would work.  But you still have to make sure that it isn't
called under spinlock, and doing that would make zap_pte_range() potentially
indulge in lock thrashing.

> The advantage of such a method seems to be that it reserves filesystem 
> space for pages that could potentially be written to. This allows the 
> filesystem to accurately deal with out of space situations (a very rare 
> condition. Is this really justifiable?). Maybe having already reserved 
> space could speed up the real dirtying of pages?

It's better than having unwritable pages sat around in the pagecache because
there's no space on the backing device to write them back.  At least this way
gives a graceful way to handle the situation.

Destroying uncommitted data isn't really an acceptable answer.

David
