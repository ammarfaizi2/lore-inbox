Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263876AbUE1Vnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbUE1Vnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUE1Vmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:42:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:46092 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263876AbUE1Vhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:37:43 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andy Lutomirski <luto@myrealbox.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: why swap at all?
Date: Sat, 29 May 2004 00:37:17 +0300
User-Agent: KMail/1.5.4
Cc: Tom Felker <tcfelker@mtco.com>, Matthias Schniedermeyer <ms@citd.de>,
       linux-kernel@vger.kernel.org
References: <fa.fegqf9v.kmidof@ifi.uio.no> <fa.bqpvcrs.u648jq@ifi.uio.no> <40B5D359.2030702@myrealbox.com>
In-Reply-To: <40B5D359.2030702@myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 May 2004 14:39, Andy Lutomirski wrote:
> Nick Piggin wrote:
> > Tom Felker wrote:
> >> On Wednesday 26 May 2004 7:37 am, Matthias Schniedermeyer wrote:
> >>> program to kernel: "i read ONCE though this file caching not useful".
> >>
> >> Very true.  The system is based on the assumption that just-used pages
> >> are more useful that older pages, and it slows when this isn't true.
> >> We need ways to tell the kernel whether the assumption holds.
> >
> > A streaming flag is great, but we usually do OK without it. There
> > is a "used once" heuristic that often gets it right as far as I
> > know. Basically, new pages that are only used once put almost zero
> > pressure on the rest of the memory.
>
> (Disclaimer: I don't know all that much about the current scheme.)
>
> First, I don't believe this works.  A couple weeks ago I did
>
> # cp -a <~100GB> <different physical disk>
>
> and my system was nearly unusable for a few hours.  This is Athlon 64
> 3200+, 512MB RAM, DMA on on both drives, iowait time around 90%.  So this
> was an io/pagecache problem.
>
> The benchmark involved was ls.  It took several seconds.  If I ran it again
> in 5 seconds or so, it was fine.  Much longer and it would take several
> seconds again.  Sounds like pages getting evicted in LRU order.

By what magic system can know that you are going to do ls again
in 2 minutes?

Does is happen if you do ls several times in a row (to make needed pages
not-once-used), then wait a bit and do ls again?

> I have this problem not only on every linux kernel I've ever tried (on
> different computers) but on other OS's as well.  It's not an easy one to
> solve.
>
> For kicks, I checked out vmstat 1 (I don't have a copy right of the
> output).  It looked like cp -a dirtied pages as long as it could get them,
> and they got written out as quickly as they could.  And, for whatever
> reason, the writes lag behind the reads by an amount comparable to the size
> of my physical memory.

cp should use fadvise() and say that it _really_ does not need those pages.

> It seems like some kind of limiting/balancing of what gets to use the cache
> is needed.  I bet that most workloads that touch data much larger than RAM
> don't benefit that much from caching it all.  (Yes, that kernel-tree-grep
> from cache is nice, but having glibc in cache is also nice.)
>
> Should there be something like a (small) limit to how many dirty,
> non-mmaped pages a task can have?  I have no objection to a program taking
> longer to finish because the 100MB it writes need to mostly hit the platter
> before it returns, since, in return, I get a usable system while it's
> running and it's not taking any more CPU time.
>
> Second (IMHO) a "used once" heuristic has a fundamental problem:
>
> If there are more pages "used more than once" _in roughly sequential order_
> than fit in memory, then trying to cache them all is absurd.  That is, if
> some program makes _multiple passes_ over that 100GB (mkisofs?), the system
> should never try to cache it all.  It would be better off taking a guess
> (even a wild-ass-guess) of which 200MB to cache plus a few MB for
> readahead, leaving pages from other programs in cache for more than a few
> seconds, and probably getting better performance (i.e. those 200MB are at
> least cached next time around).

Easier said than done... Why 200MB and not 400? etc...

> Is any of this reasonable?

If you think you see VM misbehavior,
1) verify that it is indeed MISbehaving
2) produce useful bug report
3) report it and track it until fixed

Apps take ages to start after cache being trashed because they are bloated.
Fight bloat. Join uclibc/dietlibc/etc efforts.

Random example: why on earth ntpd daemon have RSS of ~1.5 Mb???!
--
vda

