Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274717AbRIVKxc>; Sat, 22 Sep 2001 06:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274794AbRIVKxW>; Sat, 22 Sep 2001 06:53:22 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:44816 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S274717AbRIVKxK>; Sat, 22 Sep 2001 06:53:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        Bill Davidsen <davidsen@tmr.com>
Subject: Re: broken VM in 2.4.10-pre9
Date: Sat, 22 Sep 2001 13:01:02 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010916204528.6fd48f5b.skraw@ithnet.com> <Pine.LNX.3.96.1010920231251.26679B-100000@gatekeeper.tmr.com> <20010921124338.4e31a635.skraw@ithnet.com>
In-Reply-To: <20010921124338.4e31a635.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010922105332Z16449-2757+1233@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 21, 2001 12:43 pm, Stephan von Krawczynski wrote:
> Sorry to followup to the same post again, but I just read across another thread
> where people discuss heavily about aging up by 3 and down by 1 or vice versa is
> considered to be better or worse. The real problem behind this is that they are
> trying to bring some order in the pages by the age. Unfortunately this cannot
> really work out well, because you will _always_ end up with few or a lot of
> pages with the same age, which does not help you all that much in a situation
> where you need to know who is the _best one_ that is to be dropped next. In
> this drawing situation you have nothing to rely on but the age and some rough
> guesses (or even worse: performance issues, _not_ to walk the whole tree to
> find the best fitting page). This _solely_ comes from the fact that you have no
> steady rising order in page->age ordering (is this correct english for this
> mathematical term?). You _cannot_ know from the current function. So it must be
> considered _bad_. On the other hand a list is always ordered and therefore does
> not have this problem.
> Shit, if I only were able to implement that. Can anybody help me to proove my
> point?

You got your wish.  Andrea's mm patch introduced into the main tree at
2.4.10-pre11 uses a standard LRU:

+               if (PageTestandClearReferenced(page)) {
+                       if (PageInactive(page)) {
+                               del_page_from_inactive_list(page);
+                               add_page_to_active_list(page);
+                       } else if (PageActive(page)) {
+                               list_del(entry);
+                               list_add(entry, &active_list);

<musings>
There are arguments about whether page aging can be superior to standard LRU,
and I personally believe it can be, but there's no question that ordinary LRU
is a lot easier to implement correctly and will perform a lot better than
incorrectly implemented/untuned page aging.

The arguments in support of aging over LRU that I'm aware of are:

  - incrementing an age is more efficient than resetting several LRU list links
  - also captures some frequency-of-use information
  - it can be implemented in hardware (not that that matters much)
  - allows more scope for tuning/balancing (and also rope to hang oneself)

The big problem with aging is that unless it's entirely correctly balanced its
just not going to work very well.  To balance it well requires knowing a lot
about rates of list scanning and so on.  Matt Dillon perfected this art in BSD,
but we never did, being preoccupied with things like just getting the mm
scanners to activate when required, and sorting out our special complexities
like zones and highmem buffers.  Probably another few months of working on it
would let us get past the remaining structural problems and actually start
tuning it, but we've already made people wait way too long for a stable 2.4.
A more robust strategy makes a lot of sense right now.  We can still play with
stronger magic in 2.5, and of course Rik's aging strategy will continue to be
developed in Alan's tree while Andrea's is still going through the test of
fire.
</musings>

I'll keep reading Andrea's code and maybe I'll be able to shed some more light
on the algorithms he's using, since he doesn't seem to be in a big hurry to
do that himself.  (Hi Andrea ;-)

--
Daniel
