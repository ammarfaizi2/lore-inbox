Return-Path: <linux-kernel-owner+w=401wt.eu-S964981AbWL2Gte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWL2Gte (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 01:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWL2Gte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 01:49:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35562 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964981AbWL2Gtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 01:49:33 -0500
Date: Thu, 28 Dec 2006 22:48:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       linux-kernel@vger.kernel.org, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, akpm@osdl.org, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
 <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Segher Boessenkool wrote:
>
> > I think what might be happening is that pdflush writes them out fine,
> > however we don't trap writes by the application _during_ that writeout.
> 
> Yeah.  I believe that more exactly it happens if the very last
> write to the page causes a writeback (due to dirty balancing)
> while another writeback for the page is already happening.
> 
> As usual in these cases, I have zero proof.

I actually have proof to the contrary, ie I have traces that say "the 
write was started" after the last write.

And the VM layer in this area is actually fairly sane and civilized. It 
has a bit that says "writeback in progress", and if that bit is set, it 
simply _will_not_ start a new write. It even has various BUG_ON()'s to 
that effect.

So everything I have ever seen says that the VM layer is actually doing 
everything right.

> It's the do_wp_page -> balance_dirty_pages -> generic_writepages
> path for sure.  Maybe it's enough to change
> 
>                         if (wbc->sync_mode != WB_SYNC_NONE)
>                                 wait_on_page_writeback(page);
> 
>                         if (PageWriteback(page) ||
>                             !clear_page_dirty_for_io(page)) {
>                                 unlock_page(page);
>                                 continue;
>                         }

Notive how this one basically says:

 - if it's under writeback, don't even clear the page dirty flag.

Your suggested change:

>                         if (wbc->sync_mode != WB_SYNC_NONE)
>                                 wait_on_page_writeback(page);
> 
>                         if (PageWriteback(page)) {
>                         	    redirty_page_for_writepage(wbc, page);

makes no sense, because we simply never _did_ the "clear_page_dirty()" if 
the thing was under writeback in the first place. That's how C 
conditionals work.  So there's no reason to "redirty" it, because it 
wasn't cleaned in the first place.

I've double- and triple-checked the dirty bits, including having traces 
that actually say that the IO was started (from a VM perspective) _after_ 
the last write was done. The IO just didn't hit the disk.

I'm personally fairly convinced that it's not a VM issue, but a "IO 
issue". Either in a low-level filesystem or in some of the fs/buffer.c 
helper routines.

But I'd love to be proven wrong. 

I do have a few interesting details from the trace I haven't really 
analyzed yet. Here's the trace for events on one of the pages that was 
corrupted. Note how the events are numbered (there were 171640 events 
total), so the thing you see is just a small set of events from the whole 
big trace, but it's the ones that talk about _that_ particular page.

I've grouped them so hat "consecutive" events group together. That just 
means that no events on any other pages happened in between those events, 
and it is usually a sign that it's really one single call-chain that 
causes all the events.

For example, for the first group of three events (44366-44368), it's the 
page fault that brings in the page, and since it's a write-fault, it will 
not only map the page, it will mark the page itself dirty and then also 
set the TAG_DIRTY on the mapping. So the "group" is just really a result 
of one single event happening, which causes several things to happen to 
that page. That's exactly what you'd expect.

Anyway, here is the list of events that page went through:

   44366  PG 00000f6d: mm/memory.c:2254 mapping at b789fc54 (write)
   44367  PG 00000f6d: mm/page-writeback.c:817 setting dirty
   44368  PG 00000f6d: fs/buffer.c:738 setting TAG_DIRTY

   64231  PG 00000f6d: mm/page-writeback.c:872 clean_for_io
   64232  PG 00000f6d: mm/rmap.c:451 cleaning PTE b789f000
   64233  PG 00000f6d: mm/page-writeback.c:914 set writeback
   64234  PG 00000f6d: mm/page-writeback.c:916 setting TAG_WRITEBACK
   64235  PG 00000f6d: mm/page-writeback.c:922 clearing TAG_DIRTY

   67570  PG 00000f6d: mm/page-writeback.c:891 end writeback
   67571  PG 00000f6d: mm/page-writeback.c:893 clearing TAG_WRITEBACK

   76705  PG 00000f6d: mm/page-writeback.c:817 setting dirty
   76706  PG 00000f6d: fs/buffer.c:725 dirtied buffers
   76707  PG 00000f6d: fs/buffer.c:738 setting TAG_DIRTY

  105267  PG 00000f6d: mm/page-writeback.c:872 clean_for_io
  105268  PG 00000f6d: mm/rmap.c:451 cleaning PTE b789f000
  105269  PG 00000f6d: mm/page-writeback.c:914 set writeback
  105270  PG 00000f6d: mm/page-writeback.c:916 setting TAG_WRITEBACK
  105271  PG 00000f6d: mm/page-writeback.c:922 clearing TAG_DIRTY
  105272  PG 00000f6d: mm/page-writeback.c:891 end writeback
  105273  PG 00000f6d: mm/page-writeback.c:893 clearing TAG_WRITEBACK

  128032  PG 00000f6d: mm/memory.c:670 unmapped at b789f000

  132662  PG 00000f6d: mm/filemap.c:119 Removing page cache

  148278  PG 00000f6d: mm/memory.c:2254 mapping at b789f000 (read)

  166326  PG 00000f6d: mm/memory.c:670 unmapped at b789f000

  171958  PG 00000f6d: mm/filemap.c:119 Removing page cache

And notice that big grouping of seven events (105267-105273). The five 
first events really _do_ make sense together: it's our page cleaning that 
happens. But notice how the "end writeback" happens _immediately_.

Here's another page cleaning event for the page that preceded that page, 
and did _not_ get corrupted:

  105262  PG 00000f6c: mm/page-writeback.c:872 clean_for_io
  105263  PG 00000f6c: mm/rmap.c:451 cleaning PTE b789e000
  105264  PG 00000f6c: mm/page-writeback.c:914 set writeback
  105265  PG 00000f6c: mm/page-writeback.c:916 setting TAG_WRITEBACK
  105266  PG 00000f6c: mm/page-writeback.c:922 clearing TAG_DIRTY

  108437  PG 00000f6c: mm/page-writeback.c:891 end writeback
  108438  PG 00000f6c: mm/page-writeback.c:893 clearing TAG_WRITEBACK

and this looks a lot more like what you'd expect: other thngs happened in 
between the "clear dirty, set writeback" stage and the "end writeback" 
stage. That's what you'd expect to see if there was actually overlapping 
IO and/or work. 

(And notice that that _was_ what you saw even for the corrupted page for 
the _first_ writeback: you saw the group-of-five that indicated a page 
cleaning event had started, and then a group-of-two to indicate that the 
writeback finished).

So I find this kind of pattern really suspicious. We have a missing 
writeout, and my traces show (I didn't analyze this _particular_ one 
closely, but I did the previous trace for another page that I posted) that 
the writeback was actually started after the write that went missing was 
done. AND I have this trace that seems to show that the writeback 
basically completed immediately, with no other work in between.

That to me says: "somebody didn't actually write out out". The VM layer 
asked the filesystem to do the write, but the filesystem just didn't do 
it. I personally think it's because some buffer-head BH_dirty bit got 
scrogged, but it could be some event that makes the filesystem simply not 
do the IO because it thinks the "disk queues are too full", so it just 
says "IO completed", without actually doing anything at all.

Now, the fact that it apparently happens for all of ext2, ext3 
and reiserfs (but NOT apparently with "data=writeback"), makes me suspect 
that there is some common interaction, and that it's somehow BH-related 
(they all share much of the buffer head infrastructure). So it doesn't 
look like it's just a bug in one random filesystem, I think it's a bug in 
some buffer-head infrastructure/helper function.

So I don't think it's "core VM". I don't think it's the "page cache". I 
think we handle the dirty state correctly at that level.

It looks more like "buffer cache" or "filesystem" to me by now.

(Btw, don't get me wrong - the above sequence numbers are in no way 
*proof* of anything. You could get big groups for one page just because 
something ended up being synchronous. I'll add some timestamps to my 
traces to make it easier to see where there was real IO going on and where 
there wasn't).

		Linus
