Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSHJSLc>; Sat, 10 Aug 2002 14:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317148AbSHJSLb>; Sat, 10 Aug 2002 14:11:31 -0400
Received: from dsl-213-023-020-194.arcor-ip.net ([213.23.20.194]:45207 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317141AbSHJSLa>;
	Sat, 10 Aug 2002 14:11:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Date: Sat, 10 Aug 2002 20:16:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208100948100.2134-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208100948100.2134-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17damz-0001Zq-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 August 2002 19:01, Linus Torvalds wrote:
> On Sat, 10 Aug 2002, Daniel Phillips wrote:
> > Sorry, this connection is too subtle for me.  I see why we want to do
> > this, and in fact I've been researching how to do it for the last few
> > weeks, but I don't see how it's related to the atomic kmap path.  Could
> > you please explain, in words of one syllable?
> 
> We cannot do that optimization generally. I'll give you two reasons, both 
> of which are sufficient on their own:
> 
>  - doing the page table walk is simply slower than doing the memcpy if the
>    page is just there. So you have to have a good heuristic on when it
>    might be worthwhile to do page table tricks. That heuristic should 
>    include "is the page directly accessible". Which is exactly what you 
>    get if you have a "atomic copy_to_user() that returns failure if it
>    cannot be done atomically".
> 
>  - Even if walking the page tables were to be fast (ie ignoring #1), 
>    replacing a page in virtual memory is absolutely not. Especially not on 
>    SMP, where replacing a page in memory implies doing CPU crosscalls in 
>    order to invalidate the TLB on other CPU's for the old page. So before 
>    you do the "clever VM stuff", you had better have a heuristic that says
>    "this page isn't mapped, so it doesn't need the expensive cross-calls".
> 
>    Again: guess what gives you pretty much exactly that heuristic?
> 
> See?

Yes, I see.  Easy, when you put it that way.

> The fact is, "memcpy()" is damned fast for a lot of cases, because it 
> natively uses the TLB and existing caches. It's slow for other cases, but 
> you want to have a good _heuristic_ for when you might want to try to 
> avoid the slow case without avoiding the fast case. Without that heuristic 
> you can't do the optimization sanely.
> 
> And obviously the heuristic should be a really fast one. The atomic 
> copy_to_user() is the _perfect_ heuristic, because if it just does the 
> memcpy there is absolutely zero overhead (it just does it). The overhead 
> comes in only in the case where we're going to be slowed down by the fault 
> anyway, _and_ where we want to do the clever tricks.

So the overhead consists of inc/deccing preempt_count around the
copy_*_user, which fakes do_page_fault into forcing an early return.

> > While I'm feeling disoriented, what exactly is the deadlock path for a
> > write from a mmaped, not uptodate page, to the same page?  And why does
> > __get_user need to touch the page in *two* places to instantiate it?
> 
> It doesn't touch it twice. It touches _both_ of the potential pages that 
> will be involved in the memcpy - since the copy may well not be 
> page-aligned in user space.

Oh duh.  I stared at that for the longest time, without realizing there's no
alignment requirement.

> The deadlock is when you do a write of a page into a mapping of the very 
> same page that isn't yet mapped. What happens is:
> 
>  - the write has gotten the page lock. Since the wrie knows that the whole 
>    page is going to be overwritten, it is _not_ marked uptodate, and the
>    old contents (garbage from the allocation) are left alone.
> 
>  - the copy_from_user() pagefaults and tries to bring in the _same_ page 
>    into user land.
> 
>  - that involves reading in the page and making sure it is up-to-date
> 
>  - but since the write has already locked the page, you now have a 
>    deadlock. The write cannot continue, since it needs the old contents,
>    and the old contents cannot be read in since the write holds the page
>    lock.
> 
> The "copy_from_user() atomically" solves the problem quite nicely. If the 
> atomic copy fails, we can afford to do the things that we cannot afford to 
> do normally (because the thing never triggers under real load, and real 
> load absolutely _needs_ to not try to get the page up-to-date before the 
> write). 
> 
> So with the atomic copy-from-user, we can trap the problem only when it is 
> a problem, and go full speed normally.

That's all crystal clear now.  (Though the way do_page_fault finesses
copy_from_user into returning early is a little - how should I put it -
opaque.  Yes, I see it, but...)

I'm sure you're aware there's a lot more you can do with these tricks
than just zero-copy read - there's zero-copy write as well, and there
are both of the above, except a full pte page at a time.  There could
even be a file to file copy if there were an interface for it.

I don't see what prevents the read optimization even with a mmapped
page, the page just becomes CoW in all of the mapped region, the read
destination and the page cache.

-- 
Daniel
