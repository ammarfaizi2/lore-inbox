Return-Path: <linux-kernel-owner+w=401wt.eu-S932656AbWLSIFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbWLSIFe (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWLSIFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:05:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35241 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932653AbWLSIFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:05:33 -0500
Date: Tue, 19 Dec 2006 00:04:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins> <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
 <45876C65.7010301@yahoo.com.au> <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
 <45878BE8.8010700@yahoo.com.au> <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Linus Torvalds wrote:
> 
> The code that doesn't make sense is the "shuffle the dirty bits around" In 
> other words: when does it actually make sense to call your 
> (well-implemented, don't get me wrong) "test_clear_page_dirty_sync_ptes()"
> function? It doesn't _fix_ anything. It just shuffles dirty bits from one 
> place to another. What was the point again?

Let me try to phrase that another way, in terms that you defined.

In other words, look at your test_clear_page_dirty_sync_ptes() function.

First, start out from the _inner_ part, the:

	if (mapping_cap_account_dirty(mapping)) {
		if (page_mkclean(page))
			set_page_dirty(page);
	}

part.

This the one that both you and I agree is a "working" situation: we are 
moving the dirty bits from the pte into the "struct page", and we both 
agree that this is fine. No dirty bits get lost. You even make a BIG DEAL 
about the fact that no dirty bits get lost.

So begin by just explaining:
 - why do it?

Why shuffle the dirty bits around? Why not just _leave_ the PG_dirty bit 
on the "struct page", and simply leave it all at that? I agree that the 
above doesn't lose any dirty bits, but what I'm asking for is WHAT IS THE 
POINT?

So that is the code that we both agree "works", but I personally don't see 
the _point_ of. However, that's actually not even important, because I 
don't even care about the point. I wanted to bring that up just in order 
to then ignore it, and look at the stuff _around: it, namely the other 
part in "test_clear_page_dirty_sync_ptes()":

	int test_clear_page_dirty_sync_ptes(struct page *page)
	{
		if (test_clear_page_dirty_leave_ptes(page)) {
			.. do the inner part ..
			return 1;
		}
		return 0;
	}

Now, the above is the OUTER part. Please realize that this DOES actually 
drop the PG-dirty bit. So ignore the inner part entirely (which is a no-op 
for the case where the page isn't mapped), and explain to me why it's ok 
to DROP the dirty bit in the outer part, when you tried to say that it was 
NOT ok to drop it in the inner part?

NOTICE? First you make a BIG DEAL about how dirty bits should never get 
lost, but THE VERY SAME FUNCTION actually very much on purpose DOES drop 
the dirty bit for when it's not in the page tables.

In fact, if you just call that function twice, the first time it will 
MOVE the dirty bits from the PTE to the "struct page *", and the _second_ 
time it will just clear the dirty bit from the "struct page *". You end up 
with a clean page. It returned the same return value BOTH TIMES, even 
though it did two very different things (once just moving dirty bits 
around, and the second time actually _removing_ the dirty bit entirely).

Again, I have a very simple claim: I claim that NONE of the 
"test_clear_page_dirty()" functions make any sense what-so-ever. They're 
all wrong.

The "funny" part is, that the only thing that Andrei reports actually 
fixed his corruption (apart from the patch tjhat just stops removign the 
dirty bits from the PTE's _entirely_) is actually the part where he had an 
"#if 0 .. #endif" around basically _all_ of the "test_clear_page_dirty()" 
function (ie he had mis-understood what I asked for, and put it outside 
the _outer_ if(), rather than putting it around the inner one).

So I claim:
 - there is ONE and only ONE place where you can really drop the dirty 
   bits: it's when you're going to immediately afterwards do a writeout.

   This is the "clear_page_dirty_for_io()"

 - all the other "[test_and_]clear_dirty*()" functions seem to be outright 
   buggy and bogus. Shuffling dirty bits around from the page tables to 
   the "struct page *" (after having _cleared_ that "very important" 
   PG_dirty bit just before - apparently it wasn't that important after 
   all, was it?) is insane.

Nobody has actually ever explained why "test_clear_page_dirty()" is good 
at all.

 - Why is it ever used instead of "clear_page_dirty_for_io()"?

 - What is the difference?

 - Why would you EVER want to clear bits just in the "struct page *" or 
   just in the PTE's?

 - Why is it EVER correct to clear dirty bits except JUST BEFORE THE IO?

In other words, I have a theory:

 "A lot of this is actually historical cruft. Some of it may even be code 
  that was never supposed to work, but because we maintained _other_ dirty 
  bits in the PTE's, and never touched them before, we never even realized 
  that the code that played with PG_dirty was totally insane"

Now, that's just a theory. And yeah, it may be stated a bit provocatively. 
It may not be entirely correct. I'm just saying.. maybe it is?

And yes, we actually really _do_ have a data-point from Andrei that says 
that if you just make "test_clear_page_dirty()" a no-op, the corruption 
goes away. It was unintentional, bit hey, it's a real datapoint.

See the email from Andrei:

	Subject: Re: 2.6.19 file content corruption on ext3
	From: Andrei Popa <andrei.popa@i-neo.ro>
	Date: Tue, 19 Dec 2006 01:48:11 +0200
	Message-Id: <1166485691.6977.6.camel@localhost>

and look at what remains of his "test_clear_page_dirty()". 

Scary, isn't it? And a big hint that "test_clear_page_dirty()" is just 
totally BOGUS. 

And the thing is, I think it's bogus just because I don't understand why 
it would EVER be ok to drop those dirty bits _except_ very much just 
before doing the IO that makes it non-dirty (where "truncate()" is really 
a special case where the IO ends up being not done, but it's the same kind 
of situation).

			Linus
