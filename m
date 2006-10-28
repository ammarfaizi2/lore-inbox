Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752191AbWJ1MKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbWJ1MKs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 08:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbWJ1MKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 08:10:48 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:18856 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752191AbWJ1MKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 08:10:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=G2s+JPhqq2JJcLDqk7zJ0j71olj5/YNgHZu8Lta6YxzbV/mQ/JGOmNhjZuHLafx0zNKgGbZQ63rSbkHDne85UZIrBXMh7fZAWQSM2VvFeepEa/cEbTY0f2TniKHXyrEtrNg2nGAexKUqXIBhPdk3UclsryhsGpt7iQ918zUXwhI=  ;
Message-ID: <454348B4.60007@yahoo.com.au>
Date: Sat, 28 Oct 2006 22:10:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Purdie <richard@openedhand.com>
CC: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
References: <1161935995.5019.46.camel@localhost.localdomain>	 <4541C1B2.7070003@yahoo.com.au>	 <1161938694.5019.83.camel@localhost.localdomain>	 <4542E2A4.2080400@yahoo.com.au> <1162032227.5555.65.camel@localhost.localdomain>
In-Reply-To: <1162032227.5555.65.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> On Sat, 2006-10-28 at 14:55 +1000, Nick Piggin wrote:
> 
>>Richard Purdie wrote:
>>
>>>On Fri, 2006-10-27 at 18:22 +1000, Nick Piggin wrote:
>>>
>>>>This is the right approach to handling swap write errors. However, you need
>>>>to cut down on the amount of code duplication. 
>>>
>>>The code is subtly different to the swapoff code but I'll take another
>>>look and see if I can refactor it now I have it all working.
>>
>>Subtly different code is the worst kind of code to be duplicating. It
>>really needs improving, I think.
> 
> 
> I'm open to suggestions as to how to do it. The main problem was that in
> in order to mark the page bad you needed to hold an extra reference on
> the page so that the "mark bad" code would be the last code to touch the
> page. The swapoff code doesn't need this and I don't like the idea of
> passing some count value to a common function as that would be
> confusing. I guess swapoff could start taking an extra reference but I
> can see people objecting to that too as it doesn't need it. 

If you have the page locked (which you can't from where you're trying,
but we'll tackle that next), and the page is swapcache, then doesn't
that pin you a reference to the swap entry as well? So I still don't
see why you need that extra reference.... I know there is a
try_to_unuse_page/entry hiding in try_to_unuse somewhere ;)

>>It's just the wrong thing to do if the page has been set writeback with
>>a valid mapping. Presently we don't do any mapping specific accounting
>>in that path, but we could.
> 
> 
> Ok, I couldn't find a specific problem with calling that code with a
> page set as writeback and I don't know enough about that code to realise
> its the "wrong thing to do". I didn't really want to duplicate the set
> of delete_from_swap_cache functions.

That's just how the pagecache works in general. You might be right
that there isn't anything wrong in this case, but hopefully we can
avoid it.

>>But now that I look at your patch, I don't think it is going to work.
>>end_swap_bio_write can be called from interrupt context, so you can't
>>lock the page, and you can't take any of those swap specific spinlocks
>>either.
> 
> 
> This would seem to be a major problem. My tests were done with a driver
> that wouldn't use interrupt context there. Is the writeback lock enough
> or is the page lock really needed? I suspect some of the functions don't
> like being called without the page lock.

The writeback bit isn't a lock, and yes the page lock is needed when
dealing with swapcache.

That isn't your only problem though, and we simply don't want to do
this (potentially expensive) unusing from interrupt context. Noting
the error and dealing with it in process context I think is the best
way to do it.

BTW. what's the driver you're using? It might be useful to have an
option to schedule a timer for the completions (at least the ones
which generate errors).

>>You say that SetPageError makes the processes die unexpectedly? How and
>>where? We use SetPageError for IO errors, and it doesn't mean the page
>>has errors AFAIK.
> 
> 
> Most of the testing I did was on ARM. If you mark a page with
> SetPageError, the next time userspace tries to access it, you get a data
> abort and the process dies with a SIGBUS or other faults (even if the
> page is marked as up to date). The effect was very clear and I just
> assumed it was behaving as intended. It was this problem I started to
> address as I didn't like processes randomly dieing...

I can't for the life of me see how or why this is happening. I don't
doubt it is a problem, but it smells like another bug.

> Ignoring the filesystem calls to PageError(), the remaining two are
> wait_on_page_writeback_range() and write_one_page() which something
> like:
> 
> if (PageError(page))
> 	return -EIO;
> 
> I'd guess something somewhere acts on the EIO and ignores the fact the
> page is uptodate. I'm struggling a bit to work out the exact codepaths
> though.

I don't think we have to worry about any of the filesystem code, even
if we are talking about a swap file. It should all go straight through
page_io.c. And wait_on_page_writeback doesn't have its return value
checked in any of the swap code AFAIK...

Still, something must be triggering it somewhere.

>>The best policy would probably be to keep the end_page_writeback path as
>>it is, and then detect the PageError in the swap out path somewhere.
> 
> 
> I wanted to do it this way but couldn't as you end up with processes
> dieing if you don't correct the PageError before the page is accessed.
> Can someone comment on exactly what PageError should/shouldn't meant? Is
> this an ARM specific issue or does it happen on other architectures too?
> 
> The possible solutions I can see are:
> 
> 1. ARM has the PageError behaviour wrong somewhere and if so, there
> might be different ways to handle this. 
> 2. The PageError behaviour is correct so we need to find some other way
> to mark a page as needing marking as bad and do so out of interrupt
> context.

PageError means that the page could not be written / read from disk.
This is true in the pagecache / filesystem code too, and it is
PageUptodate that tells whether the page itself is valid or not.

> 3. Any other ideas?
> 
> Can you give me a hint as to where in the swap out path you might want
> to detect the error? The only way I can see is to have the end of
> swap_writepage() wait_on_page_writeback() but that would appear to have
> significant performance implications. I'm struggling to see a way you
> can do this which is always outside interrupt context.

swap_writepage sounds better than . You've even got the page
already locked for you, so the job's half done ;)

What performance implications did you imagine? The fastpath will
just be a single PageError test, and error case slowpath doesn't
matter too much beyond having something that actually works.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
