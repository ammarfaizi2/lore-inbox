Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSIAN00>; Sun, 1 Sep 2002 09:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSIAN0Z>; Sun, 1 Sep 2002 09:26:25 -0400
Received: from dsl-213-023-020-041.arcor-ip.net ([213.23.20.41]:2286 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316898AbSIAN0Y>;
	Sun, 1 Sep 2002 09:26:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC] [PATCH] Include LRU in page count
Date: Sun, 1 Sep 2002 05:36:59 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
References: <3D644C70.6D100EA5@zip.com.au> <E17lFQV-0004RO-00@starship> <20020831223044.GC18114@holomorphy.com>
In-Reply-To: <20020831223044.GC18114@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lLXo-0004WG-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 September 2002 00:30, William Lee Irwin III wrote:
> On Sat, Aug 31, 2002 at 11:05:02PM +0200, Daniel Phillips wrote:
> > The current patch seems satisfactory performance-wise and if it's
> > also raceless as it's supposed to be, it gives us something that works,
> > and we can evaluate alternatives at our leisure.  Right now I'm afraid
> > we have something that just works most of the time.
> > I think we're getting to the point where this needs to get some heavy
> > beating up, to see what happens.
> 
> It's not going to get much heavier than how I'm beating on it.
> Although it seems my box is mighty bored during 64 simultaneous
> tiobench 256's (i.e. 16384 tasks). I got bored & compiled a kernel:
> 
> make -j64 bzImage  304.60s user 848.70s system 694% cpu 2:46.05 total
> 
> The cpus are 95+% idle except for when I touch /proc/, where the task
> fishing around /proc/ gets stuck spinning hard in the kernel for
> anywhere from 30 minutes to several hours before killing it succeeds.
> It didn't quite finish the run, as the tty deadlock happened again. The
> VM doesn't appear to be oopsing, though I should slap on the OOM fixes.

Is that good or bad?  It sounds like the VM cycle is doing what it's
supposed to.  I've been running lots_of_forks for about 5 hours and
things have reached a steady state with free memory slowly racheting
down 1% then, apparently in a sudden fit of scanning, jumping to 2.5%.
Pretty normal looking behaviour, though I don't much like the way the
free list refill is so sporadic. I can't think of any reason why that is
good.  It doesn't cost a lot of cpu though.  There's been a little bit of
(useless) swapping, so I guess I can consider that path at least somewhat
tested.

Every now and then, instead of free jumping up to 2.5% it jumps up to
over 10%.  I doubt that's my fault.  Even though I'm missing an if
(--nr_pages) at the orphan collection point, there aren't enough orphans
to cause that effect - about 3 million out of 12 billion lru_cache_dels.

The orphans appear during or shortly after the episodes of free list
filling, as you would expect, since page_cache_release fails the trylock
whenever shrink_cache is active.  There are lots of parallel
page_cache_releases going on, but they don't seem to create any 
noticable number of orphans.

I think what's happening normally is this:

   if (page_count(page) == 2 /* no, it's 3 */
   put_page(page);
			     if (page_count(page) == 2 /* now it is */
			             if (PageLRU(page) && page_count(page) == 2)
			                     __lru_cache_del(page);
as opposed to this:

   if (page_count(page) == 2 /* no, it's 3 */
			     if (page_count(page) == 2 /* no, still 3 */
   put_page(page);
			     put_page(page);

which requires hitting a 3 instruction window or on the same page.
It's not going to happen often.

Statm_pte_range looks like it's going to get even more confused about
what constitutes a shared page than it already is.  The solution to
this is to examine the rmap.

-- 
Daniel
