Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbUB0U3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUB0U3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:29:23 -0500
Received: from waste.org ([209.173.204.2]:60033 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263090AbUB0U3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:29:19 -0500
Date: Fri, 27 Feb 2004 14:29:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Tim Hockin <thockin@hockin.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
Message-ID: <20040227202906.GL3883@waste.org>
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com> <20040227185555.GJ3883@waste.org> <20040227190914.GA21737@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227190914.GA21737@hockin.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 11:09:14AM -0800, Tim Hockin wrote:
> On Fri, Feb 27, 2004 at 12:55:55PM -0600, Matt Mackall wrote:
> > Let's imagine you have n sources simultaneously interrupting on a
> > given descriptor. Check the first, it's happening, acknowledge it,
> > exit, notice interrupt still asserted, check the first, nope, check
> > the second, yep, exit, etc. By the time we've made it to the nth ISR,
> > we've banged on the first one n times, the second n-1 times, etc. In
> > other words, early chain termination has an O(n^2) worst case.
> 
> That is a pretty pathological worst case, and n is (almost?) always small.
> I don't know if it would make a lick of difference, or if it is worth the
> risk. Someone who has a lot of shared interrupts ought to try it.

For small n, it shouldn't make a difference. With early exit, best
case you end up walking half the chain on average, worst case you hit
the quadratic behavior. Given that the likelihood of contention rises
with chain length, we tend to lean towards the latter for larger n.
For try-them-all, we test n in all cases. So we've got [n/2] < n <
n^2/2. The try-them-all approach wins by virtue of being deterministic
and nicely bounded.

Oh, another concern is that early-exit lets sources in the front of
the chain starve the remainder and doing bookkeeping on
last-ISR-succeeded so that we can have some sort of fairness is just
not worth the trouble. So nix on the whole idea.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
