Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272313AbTHNLI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 07:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272314AbTHNLIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 07:08:55 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:17 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S272313AbTHNLIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 07:08:39 -0400
Date: Thu, 14 Aug 2003 13:16:01 +0200
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm1 interactivity scheduling mistakes (smp)
Message-ID: <20030814111601.GA2514@hh.idb.hist.no>
References: <20030813180020.GA1339@hh.idb.hist.no> <1060798101.603.47.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060798101.603.47.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 08:08:21PM +0200, Felipe Alfaro Solana wrote:
> On Wed, 2003-08-13 at 20:00, Helge Hafting wrote:
> > I ran a "nice make -j3 bzImage" on 2.6.9-test3-mm1 in order
> > to compile 2.6.0-test3-mm2 on my dual celeron.
> > 
> > While waiting I played cuyo, a lightweight game similiar to tetris.
> > 
> > This mostly behaved as expected, with a responsive game.
> > But mozilla (on some other virtual desktop) occationally
> > refreshed its page, causing several seconds with jerky response
> > in the game.
> > 
> > This is wrong for two reasons:
> > 1. There should be enough cpu with two processors,
> >    one running the game and another the heavy mozilla stuff.
> >    The make was niced after all.  No guessing, I told it explicitly.
> > 
> > 2. The game has very interactive behaviour, it uses  4-10% cpu
> >    and cause X to use about 20%.  Mozilla may have been idle for a 
> >    while, getting "interactive".  But it shouldn't remain
> >    interactive  for so long,  it sat at 100% till it went
> >    idle again.   
> > 
> > X runs with elevated priority, (std. debian testing setup)
> > but that shouldn't matter - X only used 20% and that was
> > for the game and two xterms.  Mozilla wasn't visible
> > at all.
> 
> I can't tell you why, but for me, X behaves horribly if it's not reniced
> exactly at +0. In the past, I reniced X at -20, but Con told me that
> with O??int patches, X must/should work with no nicing at all.
> 
> Could you please try again with X not reniced?
> Thanks!

I can, but I cannot see why it should make a difference.
I was NOT running a video or anything else graphichs-intensive.

X never took more than 20% cpu in top, 80% was then available
for other uses.  As well as the other cpu!  So X had advantage,
but ran out of work.  Anfd the _one_ process actually
using X was the one I wanted to not starve anyway.

I understand that over-prioritized X may starve other
processes to the point where they miss deadlines or don't
get enough time to process their events. But this didn't happen here.
The machine was only under light load,
a _niced_ make -j3  (3 processes)
an interactive game using 4% cpu, occationally spiking to 10%
X using 20% cpu to keep the game visible, but failing
and mozilla burning cpu with no display.

The scheduler failed even though there were _more_ cpu than
non-niced tasks available - one cpu could run mozilla
all the time and the other could run the game and X and
still have 70% "spare time" for niced tasks.  

This is different from "a bunch of make -j10 (non niced)
plus and audio app plus frantically dragging
a window" which people try to manage.  This ought to
be an easy case.  Of course dragging windows with 
high-priority X might starve an audio app - no surprise there.
In that case the high-priority task simply get too much
to do to justify the priority.

My guess: Two of the cpu-intensive compiles monopolized
one cpu, migrating all sporadic tasks and one compile
to the other one.  When mozilla eventually woke up it
was "interactive" for a while and starved the game running on 
the same cpu for a while.  I don't think a single process 
should be able to do that for several seconds though.

Helge Hafting

