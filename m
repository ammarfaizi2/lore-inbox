Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265801AbRGDJl6>; Wed, 4 Jul 2001 05:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265807AbRGDJlt>; Wed, 4 Jul 2001 05:41:49 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:12047 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S265801AbRGDJlf>; Wed, 4 Jul 2001 05:41:35 -0400
Date: Wed, 4 Jul 2001 11:41:31 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>, <mike_phillips@urscorp.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <01070317045806.00338@starship>
Message-ID: <Pine.LNX.4.33.0107041033230.4236-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001, Daniel Phillips wrote:

> On Tuesday 03 July 2001 12:33, Marco Colombo wrote:
> > Oh, yes, since that PAGE_AGE_BG_INTERACTIVE_MINIMUM is applied only
> > when background aging, maybe it's not enough to keep processes like
> > updatedb from causing interactive pages to be evicted.
> > That's why I said we should have another way to detect that kind of
> > activity... well, the application could just let us know (no need to
> > embed an autotuning-genetic-page-replacement-optimizer into the kernel).
> > We should just drop all FS metadata accessed by updatedb, since we
> > know that's one-shot only, without raising pressure at all.
>
> Note that some of updatedb's metadata pages are of the accessed-often kind,
> e.g., directory blocks and inodes.  A blanket low priority on all the pages
> updatedb touches just won't do.

Remember that the first message was about a laptop. At 4:00AM there's
no activity but the updatedb one (and the other cron jobs). Simply,
there's no 'accessed-often' data.  Moreover, I'd bet that 90% of the
metadata touched by updatedb won't be accessed at all in the future.
Laptop users don't do find /usr/share/terminfo/ so often.

> > Just like
> > (not that I'm proposing it) putting those "one-shot" pages directly on
> > the inactive-clean list instead of the active list. How an application
> > could declare such a behaviour is an open question, of course. Maybe it's
> > even possible to detect it. And BTW that's really fine tuning.
> > Evicting an 8 hours old page may be a mistake sometime, but it's never
> > a *big* mistake.
>
> IMHO, updatedb *should* evict all the "interactive" pages that aren't
> actually doing anything[1].  That way it should run faster, provided of
> course its accessed-once pages are properly given low priority.

So in the morning you find your Gnome session completely on swap,
and at the same time a lot of free mem.

> I see three page priority levels:
>
>   0 - accessed-never/aged to zero
>   1 - accessed-once/just loaded
>   2 - accessed-often
>
> with these transitions:
>
>   0 -> 1, if a page is accessed
>   1 -> 2, if a page is accessed a second time
>   1 -> 0, if a page gets old
>   2 -> 0, if a page gets old
>
> The 0 and 1 level pages are on a fifo queue, the 2 level pages are scanned
> clock-wise, relying on the age computation[2].  Eviction candidates are taken
> from the cold end of the 0 level list, unless it is empty, in which case they
> are taken from the 1 level list. In desperation, eviction candidates are
> taken from the 2 level list, i.e., random eviction policy, as opposed to what
> we do now which is to initiate an emergency scan of the active list for new
> inactive candidates - rather like calling a quick board meeting when the
> building is on fire.

Well, it's just aging faster when it's needed. Random evicting is not
good. List 2 is ordered by age, and there're always better candidates
at the end of the list than at the front. The higher the pressure,
the shorter is the time a page has to rest idle to get at the end of the
list. But the list *is* ordered.

> Note that the above is only a very slight departure from the current design.
> And by the way, this is just brainstorming, it hasn't reached the 'proposal'
> stage yet.
>
> [1] It would be nice to have a mechanism whereby the evicted 'interactive'
> pages are automatically reloaded when updatedb has finished its work.  This
> is a case of scavenging unused disk bandwidth for something useful, i.e.,
> improving the interactive experience.

updatedb doesn't really need all the memory it takes. All it needs is
a small buffer to sequentially scan all the disk. So we should just
drop all the pages it references, since we already know they won't be
referenced again by noone else.

> [2] I much prefer the hot/cold terminology over old/young.  The latter gets
> confusing because a 'high' age is 'young'.  I'd rather think of a high value
> as being 'hot'.

True. s/page->age/page->temp/g B-)

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

