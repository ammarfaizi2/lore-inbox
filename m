Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965286AbWCTPk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbWCTPk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965293AbWCTPZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:25:07 -0500
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:35969 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965290AbWCTPYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:24:54 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
Date: Tue, 21 Mar 2006 02:24:23 +1100
User-Agent: KMail/1.9.1
Cc: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
References: <20060320122449.GA29718@outpost.ds9a.nl> <20060320145047.GA12332@rhlx01.fht-esslingen.de>
In-Reply-To: <20060320145047.GA12332@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603210224.23540.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 March 2006 01:50, Andreas Mohr wrote:
> Hi,
>
> On Mon, Mar 20, 2006 at 01:24:49PM +0100, bert hubert wrote:
> > Yesterday, together with Zwane, I discovered each gettimeofday call costs
> > me 4 usec on some boxes and almost nothing on others. We did a fruitless
> > chase for vsyscall/sysenter happening but the problem turned out to be
> > CONFIG_X86_PM_TIMER.
> >
> > This problem has been discussed before
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0411.1/2135.html
> >
> > Not only is the pm timer slow by design, it also needs to be read
> > multiple times to work around a bug in certain hardware.
>
> I've been realizing this, too, when looking at some oprofile logs.
> pmtmr reading uses almost 3% CPU time (e.g. P3/700) when idle, and it's
> similarly problematic when not idle.
>
> I think it's crazy to do a safe tripled readout (with *very* expensive
> I/O!) of the PM timer unconditionally on *all* systems when only a
> (albeit not that small) subset of systems is affected by buggy (un-latched)
> PM timers.
> I want to improve things there; I can see three ways to do it:
> a) maintain a blacklist (or probably better a whitelist) of systems that
>    are (not) affected
> b) detect long-time timer accuracy, then switch to fast readout if timer
>    is verified to be accurate (no white/blacklist needed this way)
> c) give up on PM timer completely
>
> Any comments on which way and how this could/should be done?

The pm timer is very fast when the timer is latched and that strange loop uses 
hardly any cpu time. The same can't be said about the unlatched timer case 
where absurd amounts of cpu seem the norm. You have a catch 22 situation if 
you depend on the accuracy of the pm timer only to end up wasting time trying 
to actually use that timer. 

Currently if you compile in pmtimer it is used by default. Perhaps when it's 
detected that the timer is unlatched it should actually be used as a last 
resort when all other timers have failed or it has been specified by 
bootparam rather than the default timer. I figured having separate functions 
for latched and unlatched timers would make more sense so that hardware with 
good timers aren't unfairly disadvantaged by reading the time 2 more times 
than necessary.

Cheers,
Con
