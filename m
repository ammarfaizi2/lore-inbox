Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752114AbWJ1Knx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbWJ1Knx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 06:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbWJ1Knx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 06:43:53 -0400
Received: from o-hand.com ([70.86.75.186]:27084 "EHLO o-hand.com")
	by vger.kernel.org with ESMTP id S1752114AbWJ1Knw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 06:43:52 -0400
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <4542E2A4.2080400@yahoo.com.au>
References: <1161935995.5019.46.camel@localhost.localdomain>
	 <4541C1B2.7070003@yahoo.com.au>
	 <1161938694.5019.83.camel@localhost.localdomain>
	 <4542E2A4.2080400@yahoo.com.au>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 11:43:47 +0100
Message-Id: <1162032227.5555.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 14:55 +1000, Nick Piggin wrote:
> Richard Purdie wrote:
> > On Fri, 2006-10-27 at 18:22 +1000, Nick Piggin wrote:
> >>This is the right approach to handling swap write errors. However, you need
> >>to cut down on the amount of code duplication. 
> > 
> > The code is subtly different to the swapoff code but I'll take another
> > look and see if I can refactor it now I have it all working.
> 
> Subtly different code is the worst kind of code to be duplicating. It
> really needs improving, I think.

I'm open to suggestions as to how to do it. The main problem was that in
in order to mark the page bad you needed to hold an extra reference on
the page so that the "mark bad" code would be the last code to touch the
page. The swapoff code doesn't need this and I don't like the idea of
passing some count value to a common function as that would be
confusing. I guess swapoff could start taking an extra reference but I
can see people objecting to that too as it doesn't need it. 

> It's just the wrong thing to do if the page has been set writeback with
> a valid mapping. Presently we don't do any mapping specific accounting
> in that path, but we could.

Ok, I couldn't find a specific problem with calling that code with a
page set as writeback and I don't know enough about that code to realise
its the "wrong thing to do". I didn't really want to duplicate the set
of delete_from_swap_cache functions.

> But now that I look at your patch, I don't think it is going to work.
> end_swap_bio_write can be called from interrupt context, so you can't
> lock the page, and you can't take any of those swap specific spinlocks
> either.

This would seem to be a major problem. My tests were done with a driver
that wouldn't use interrupt context there. Is the writeback lock enough
or is the page lock really needed? I suspect some of the functions don't
like being called without the page lock.

> You say that SetPageError makes the processes die unexpectedly? How and
> where? We use SetPageError for IO errors, and it doesn't mean the page
> has errors AFAIK.

Most of the testing I did was on ARM. If you mark a page with
SetPageError, the next time userspace tries to access it, you get a data
abort and the process dies with a SIGBUS or other faults (even if the
page is marked as up to date). The effect was very clear and I just
assumed it was behaving as intended. It was this problem I started to
address as I didn't like processes randomly dieing...

Ignoring the filesystem calls to PageError(), the remaining two are
wait_on_page_writeback_range() and write_one_page() which something
like:

if (PageError(page))
	return -EIO;

I'd guess something somewhere acts on the EIO and ignores the fact the
page is uptodate. I'm struggling a bit to work out the exact codepaths
though.

> The best policy would probably be to keep the end_page_writeback path as
> it is, and then detect the PageError in the swap out path somewhere.

I wanted to do it this way but couldn't as you end up with processes
dieing if you don't correct the PageError before the page is accessed.
Can someone comment on exactly what PageError should/shouldn't meant? Is
this an ARM specific issue or does it happen on other architectures too?

The possible solutions I can see are:

1. ARM has the PageError behaviour wrong somewhere and if so, there
might be different ways to handle this. 
2. The PageError behaviour is correct so we need to find some other way
to mark a page as needing marking as bad and do so out of interrupt
context.
3. Any other ideas?

Can you give me a hint as to where in the swap out path you might want
to detect the error? The only way I can see is to have the end of
swap_writepage() wait_on_page_writeback() but that would appear to have
significant performance implications. I'm struggling to see a way you
can do this which is always outside interrupt context.

Cheers,

Richard


