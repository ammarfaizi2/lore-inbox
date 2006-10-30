Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965510AbWJ3Lz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965510AbWJ3Lz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965518AbWJ3Lz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:55:59 -0500
Received: from o-hand.com ([70.86.75.186]:54698 "EHLO o-hand.com")
	by vger.kernel.org with ESMTP id S965510AbWJ3Lz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:55:58 -0500
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <454348B4.60007@yahoo.com.au>
References: <1161935995.5019.46.camel@localhost.localdomain>
	 <4541C1B2.7070003@yahoo.com.au>
	 <1161938694.5019.83.camel@localhost.localdomain>
	 <4542E2A4.2080400@yahoo.com.au>
	 <1162032227.5555.65.camel@localhost.localdomain>
	 <454348B4.60007@yahoo.com.au>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 11:55:47 +0000
Message-Id: <1162209347.6962.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 22:10 +1000, Nick Piggin wrote: 
> Richard Purdie wrote:
> > I'm open to suggestions as to how to do it. The main problem was that in
> > in order to mark the page bad you needed to hold an extra reference on
> > the page so that the "mark bad" code would be the last code to touch the
> > page. The swapoff code doesn't need this and I don't like the idea of
> > passing some count value to a common function as that would be
> > confusing. I guess swapoff could start taking an extra reference but I
> > can see people objecting to that too as it doesn't need it. 
> 
> If you have the page locked (which you can't from where you're trying,
> but we'll tackle that next), and the page is swapcache, then doesn't
> that pin you a reference to the swap entry as well? So I still don't
> see why you need that extra reference.... I know there is a
> try_to_unuse_page/entry hiding in try_to_unuse somewhere ;)

The final call to swap_free() releases the swap mapping and beyond that
point you can't tell which swap page you were dealing with.
try_to_unuse_page() calls swap_free() each time it removes a reference.
To make sure we control the last swap_free(), I had it take a reference
with swap_duplicate() and then we guarantee we call the last free. The
last free can then mark the page bad and take care of the accounting.
This does mean try_to_unuse_page() succeeds when the refcount is 2 and
not 1 as in the case of the usual try_to_unuse().

> That isn't your only problem though, and we simply don't want to do
> this (potentially expensive) unusing from interrupt context. Noting
> the error and dealing with it in process context I think is the best
> way to do it.

The reasoning was that this circumstance should be extremely rare. If it
happens, we have a hardware problem. Recovering from that hardware
problem gracefully is more important than a slightly longer interrupt.
But yes, process context would be nicer, *if* we can find a way to do
it. 

> BTW. what's the driver you're using? It might be useful to have an
> option to schedule a timer for the completions (at least the ones
> which generate errors).

Its a custom driver. I'm sure I can force it into using interrupt
context for the completions to try and test things although I'm also
fairly sure the existing patch will break when I do that for the reasons
you mention :-(. 

> >>You say that SetPageError makes the processes die unexpectedly? How and
> >>where? We use SetPageError for IO errors, and it doesn't mean the page
> >>has errors AFAIK. 
> > 
> > Most of the testing I did was on ARM. If you mark a page with
> > SetPageError, the next time userspace tries to access it, you get a data
> > abort and the process dies with a SIGBUS or other faults (even if the
> > page is marked as up to date). The effect was very clear and I just
> > assumed it was behaving as intended. It was this problem I started to
> > address as I didn't like processes randomly dieing...
> 
> I can't for the life of me see how or why this is happening. I don't
> doubt it is a problem, but it smells like another bug.

I can't work out the code path it happens in and until I do, I'm not
sure how I can track it down... 

> > Ignoring the filesystem calls to PageError(), the remaining two are
> > wait_on_page_writeback_range() and write_one_page() which something
> > like:
> > 
> > if (PageError(page))
> > 	return -EIO;
> > 
> > I'd guess something somewhere acts on the EIO and ignores the fact the
> > page is uptodate. I'm struggling a bit to work out the exact codepaths
> > though.
> 
> I don't think we have to worry about any of the filesystem code, even
> if we are talking about a swap file. It should all go straight through
> page_io.c. And wait_on_page_writeback doesn't have its return value
> checked in any of the swap code AFAIK...
> 
> Still, something must be triggering it somewhere.

Something must be but I wish I knew what/where...

> > 3. Any other ideas?
> > 
> > Can you give me a hint as to where in the swap out path you might want
> > to detect the error? The only way I can see is to have the end of
> > swap_writepage() wait_on_page_writeback() but that would appear to have
> > significant performance implications. I'm struggling to see a way you
> > can do this which is always outside interrupt context.
> 
> swap_writepage sounds better than . You've even got the page
> already locked for you, so the job's half done ;)
> 
> What performance implications did you imagine? The fastpath will
> just be a single PageError test, and error case slowpath doesn't
> matter too much beyond having something that actually works.

If swap_writepage() is to check for an error, it will have to wait until
the IO is complete with something like wait_on_page_writeback() before
it can check. The performance implication is the extra
wait_on_page_writeback() on every call to swap_writepage(). In the
meantime, it will have to give up the page lock and then reacquire it.
Unless you're thinking of something different?

Regards,

Richard



