Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWCTOuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWCTOuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWCTOuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:50:50 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:32442 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S964825AbWCTOut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:50:49 -0500
Date: Mon, 20 Mar 2006 15:50:48 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
Message-ID: <20060320145047.GA12332@rhlx01.fht-esslingen.de>
References: <20060320122449.GA29718@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320122449.GA29718@outpost.ds9a.nl>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 20, 2006 at 01:24:49PM +0100, bert hubert wrote:
> Yesterday, together with Zwane, I discovered each gettimeofday call costs me
> 4 usec on some boxes and almost nothing on others. We did a fruitless chase
> for vsyscall/sysenter happening but the problem turned out to be
> CONFIG_X86_PM_TIMER.
> 
> This problem has been discussed before
> http://www.ussg.iu.edu/hypermail/linux/kernel/0411.1/2135.html
> 
> Not only is the pm timer slow by design, it also needs to be read multiple
> times to work around a bug in certain hardware.
I've been realizing this, too, when looking at some oprofile logs.
pmtmr reading uses almost 3% CPU time (e.g. P3/700) when idle, and it's
similarly problematic when not idle.

I think it's crazy to do a safe tripled readout (with *very* expensive I/O!)
of the PM timer unconditionally on *all* systems when only a
(albeit not that small) subset of systems is affected by buggy (un-latched)
PM timers.
I want to improve things there; I can see three ways to do it:
a) maintain a blacklist (or probably better a whitelist) of systems that
   are (not) affected
b) detect long-time timer accuracy, then switch to fast readout if timer
   is verified to be accurate (no white/blacklist needed this way)
c) give up on PM timer completely

Any comments on which way and how this could/should be done?

> Would a patch removing the link to EMBEDDED and adding a warning that while
> this timer is of high quality, it is slow, be welcome?
I don't want to comment on the first part, but adding a note to the Kconfig
text would be very useful, I think.

Andreas Mohr
