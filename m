Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263927AbRGCKeU>; Tue, 3 Jul 2001 06:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263906AbRGCKeL>; Tue, 3 Jul 2001 06:34:11 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:12807 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S263948AbRGCKeB>; Tue, 3 Jul 2001 06:34:01 -0400
Date: Tue, 3 Jul 2001 12:33:50 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>, <mike_phillips@urscorp.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <Pine.LNX.4.33L.0107021538030.14332-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0107030932510.4236-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2001, Rik van Riel wrote:

> On Thu, 28 Jun 2001, Marco Colombo wrote:
>
> > I'm not sure that, in general, recent pages with only one access are
> > still better eviction candidates compared to 8 hours old pages. Here
> > we need either another way to detect one-shot activity (like the one
> > performed by updatedb),
>
> Fully agreed, but there is one problem with this idea.
> Suppose you have a maximum of 20% of your RAM for these
> "one-shot" things, now how are you going to be able to
> page in an application with a working set of, say, 25%
> the size of RAM ?
>
> If you don't have any special measures, the pages from
> this "new" application will always be treated as one-shot
> pages and the process will never be able to be cached in
> memory completely...

I see your point. Running Gnome on a 64MB box means you have most
of the pages that are "warm" (using my definition), so there's little
room for "cold" (new) pages, and maybe they don't get a chance of
being accessed a second time before they are evicted, which leads to
thrashing if you're trying to start something really big (well, I guess
the access pattern within a typical ws is not uniformly distributed, so
some pages will get accessed twice, but I see the problem).

I'll try and make my point a bit clearer.
I was referring to background aging only. When aging
is caused by pressure, you don't make any difference between pages.
I don't know how the idea to give high values for page->age on the second
access instead of the first is going to be implemented, but I'm assuming
that new pages are going to be placed on the active list with a low age
value (PAGE_AGE_START_FIRST ?), maybe even 0 (well, I'm not a guru of
course). I'm just saying that, to avoid Mike's "problem" (which BTW
I don't believe is a big one, really), we could stop background aging
on interactive pages (short form for "pages that belong to the ws of an
interactive process") at a certain miminum age, say
PAGE_AGE_BG_INTERACTIVE_MINIMUM, with PAGE_AGE_BG_INTERACTIVE_MINIMUM
 > PAGE_AGE_START_FIRST). Weighting the difference between the two
ages, you can give long-standing interactive pages some advantage vs
new pages. But they will be aged below PAGE_AGE_START_FIRST and eventually
moved to the inactive list. After all, they *are* good candidates.
Does this make some sense?

Oh, yes, since that PAGE_AGE_BG_INTERACTIVE_MINIMUM is applied only
when background aging, maybe it's not enough to keep processes like
updatedb from causing interactive pages to be evicted.
That's why I said we should have another way to detect that kind of
activity... well, the application could just let us know (no need to
embed an autotuning-genetic-page-replacement-optimizer into the kernel).
We should just drop all FS metadata accessed by updatedb, since we
know that's one-shot only, without raising pressure at all. Just like
(not that I'm proposing it) putting those "one-shot" pages directly on
the inactive-clean list instead of the active list. How an application
could declare such a behaviour is an open question, of course. Maybe it's
even possible to detect it. And BTW that's really fine tuning.
Evicting an 8 hours old page may be a mistake sometime, but it's never
a *big* mistake.

>
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
>
> http://www.surriel.com/		http://distro.conectiva.com/
>
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it



