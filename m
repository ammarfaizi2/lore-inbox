Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271736AbRH0OYw>; Mon, 27 Aug 2001 10:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271737AbRH0OYm>; Mon, 27 Aug 2001 10:24:42 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:11795 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271736AbRH0OYf>; Mon, 27 Aug 2001 10:24:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 16:31:21 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva> <20010824222226Z16116-32383+1242@humbolt.nl.linux.org> <3B89F1FC.40F747D4@idb.hist.no>
In-Reply-To: <3B89F1FC.40F747D4@idb.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827142441Z16237-32383+1641@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 09:08 am, Helge Hafting wrote:
> Daniel Phillips wrote:
> > 
> > On August 24, 2001 09:02 pm, Rik van Riel wrote:
> > > I guess in the long run we should have automatic collapse
> > > of the readahead window when we find that readahead window
> > > thrashing is going on, in the short term I think it is
> > > enough to have the maximum readahead size tunable in /proc,
> > > like what is happening in the -ac kernels.
> > 
> > Yes, and the most effective way to detect that the readahead window is too
> > high is by keeping a history of recently evicted pages.  When we find
> > ourselves re-reading pages that were evicted before ever being used we 
> > know exactly what the problem is.
> 
> Counting how much we are reading ahead and comparing with total RAM
> (or total cache) might also be an idea.  We may then read ahead
> a lot for those who runs a handful of processes, and
> do smaller readahead for those that runs thousands of processes.

Yes.  In fact I was just sitting down to write up a design for a new 
readahead-handling strategy that incorporates this idea.  Here are my design 
notes so far:

  - Readahead cache should be able to expand to fill (almost) all
    memory in the absence of other activity.

  - Readahead pages have higher priority than inactive pages, lower
    than active.

  - Readahead cache is naturally a fifo - new chunks of readahead
    are added at the head and unused readahead is (eventually)
    culled from the tail.

  - Readahead cache is important enough to get its own lru list.
    We know it's a fifo so don't have to waste cycles scanning/aging.
    Having a distinct list makes the accounting trivial, vs keeping
    readahead on the active list for example.

  - A new readahead page starts on the readahead queue.  When used
    (by generic_file_read) the readahead page moves to the inactive
    queue and becomes a used-once page (i.e., low priority).  If a
    readahead page reaches the tail of the readahead queue it may
    be culled by moving it to the inactive queue.

  - When the readahead cache fills up past its falloff limit we
    will reduce amount of readahead submitted proportionally by the
    amount the readahead cache exceeds the falloff limit.  At the
    cutoff limit, no new readahead is submitted.

  - At each try_to_free_pages step the readahead queue is culled
    proportionally by the amount it exceeds its falloff limit.  A
    tuning parameter controls the rate at which readahead is 
    culled vs new readahead submissions (is there a better way?).

  - The cutoff limit is adjusted periodically according to the size
    of the active list, implementing the idea that active pages
    take priority over readahead pages.

  - The falloff limit is set proportionally to the cutoff limit.

  - The mechanism operates without user intervention, though there
    are several points at which proportional factors could be
    exposed as tuning parameters.

The overarching idea here is that we can pack more readahead into memory by 
managing it carefully, in such a way that we do not often discard unused 
readahead pages.  In other words, we do as much readahead as possible but 
avoid thrashing.

The advantages seem clear enough that I'll proceed to an implementation
without further ado.

--
Daniel
