Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbWLSH0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWLSH0t (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWLSH0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:26:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60893 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbWLSH0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:26:48 -0500
Date: Mon, 18 Dec 2006 23:26:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <45878BE8.8010700@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins> <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
 <45876C65.7010301@yahoo.com.au> <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
 <45878BE8.8010700@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Nick Piggin wrote:
> 
> I wouldn't have thought it becomes clean by dropping it ;) Is this a
> trick question? My answer is that we clean a page by by taking some
> action such that the underlying data matches the data in RAM...

Sure.

> We don't "drop" any data until it has been cleaned (again, ignoring
> things like truncate for a minute). That's a bug!

Actually, it's the other way around. We have to drop the dirty bits BEFORE 
cleaning. If we clean first, and _then_ drop the dirty bits, THAT is a 
bug, because the dirty bits can now refer to _new_ dirty data that didn't 
get written out.

So the proper sequence is _literally_ to mark the page clean FIRST. Drop 
all the dirty bits, but not the _data_ obviously (ie you have a reference 
to the page). And _then_ you do the writeout to actually clean the data 
itself.

So you actually state it exactly the wrogn way around.

We MUST clear the dirty bits before we do the IO that actually cleans the 
data. Exactly because if new writes keep on happening, if we do it in the 
other order, we'll drop dirty data on the floor.

> > In no other circumstance do we ever want to clear a dirty bit, as far as I
> > can tell. 
> 
> Exactly. And that is exactly what try_to_free_buffers is doing now.
> 
> I still think you should have a look at the patch.

I claim that dropping dirty bits AFTER the IO is always wrong. 
Try_to_free_buffers() must never touch the dirty bits at all, because by 
definition that thing happens after the IO has actually been done.

Anbd yes, I looked at your patch. And it looks a million times cleaner 
than Andrew's patch. However, it's already been tested multiple times, and 
totally REMOVING the "clear_page_dirty()" from try_to_free_buffers() still 
resulted in the corruption.

That said, I think your patch is worth it just as a cleanup. Much nicer 
than Andrews code, also from a naming standpoint. So I'm not actually 
disagreeing about the patch itself, but I _am_ saying that I don't 
actually see the point of ever moving the dirty bits around.

So I repeat: we have the case where we really want to _remove_ the dirty 
bits (because we're going to write the current state of the page to disk, 
and we need to clear the dirty bits BEFORE we do that). That's the one 
that makes sense, and that's the code we want to run before doing IO. It's 
the "clear_dirty_bits_for_io()" case.

The code that doesn't make sense is the "shuffle the dirty bits around" In 
other words: when does it actually make sense to call your 
(well-implemented, don't get me wrong) "test_clear_page_dirty_sync_ptes()"
function? It doesn't _fix_ anything. It just shuffles dirty bits from one 
place to another. What was the point again?

If the point is "try_to_free_buffers()", then my argument was that I had a 
much simpler solution: "Just don't do that then". My simple patch sadly 
didn't fix the data corruption, so the data corruption comes from 
something ELSE than try_to_free_buffers().

		Linus
