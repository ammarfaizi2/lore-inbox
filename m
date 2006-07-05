Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWGEIFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWGEIFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWGEIFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:05:42 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:30097 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932402AbWGEIFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:05:41 -0400
Date: Wed, 5 Jul 2006 10:05:39 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
Message-ID: <20060705080539.GA22099@rhlx01.fht-esslingen.de>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <200607051014.48089.kernel@kolivas.org> <44AB0CA2.5080908@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AB0CA2.5080908@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 10:49:38AM +1000, Peter Williams wrote:
> Con Kolivas wrote:
> >On Wednesday 05 July 2006 09:35, Peter Williams wrote:
> >Could we just call it SCHED_IDLEPRIO since it's the same thing and there 
> >are tools out there that already use this name?

That makes quite some sense, seconded.

Plus, I like SCHED_IDLEPRIO more than SCHED_BGND, since it's more descriptive
when stuff happens and when not (but of course the SCHED_BGND name is shorter).

> I'm easy.  Which user space visible headers contain the definition? 
> That's the only place that it matters.  When I was writing a program to 
> use this feature, I couldn't find a header that defined any of the 
> scheduler policies that was visible in user space (of course, that 
> doesn't mean there isn't one - just that I couldn't find it).
> 
> Peter
> PS Any programs that use SCHED_IDLEPRIO should work as long as its value 
> is defined as 4.

OK, nice, but:

2.6.17-ck1:

/*
 * Scheduling policies
 */
#define SCHED_NORMAL            0
#define SCHED_FIFO              1
#define SCHED_RR                2
#define SCHED_BATCH             3
#define SCHED_ISO               4
#define SCHED_IDLEPRIO          5

#define SCHED_MIN               0
#define SCHED_MAX               5


Arggl.

So what does that tell us?

Does it tell us that the new policy should indeed be called SCHED_BGND
so that user-space programs that make use of a policy (e.g. schedtool
or any user-space app that wants to adjust its policy on its own) can figure
out which policy number to use (the 4 vs. 5 difference) by
#ifdef SCHED_IDLEPRIO elseif SCHED_BGND checks?

A less favourable solution would be to rename SCHED_BGND to SCHED_IDLEPRIO
but keep the current last policy number (4) for it, since that would
introduce a gross conflict (or do programs always go after the
policy name defines instead of the raw policy numbers?).
Given this issue, maybe best would be to add SCHED_IDLEPRIO *and* SCHED_ISO
to mainline at the same time, in order to keep the current
policy numbering extension as done in -ck.

Or maybe we should even introduce a more flexible way of dealing scheduling
policy registration and listing? A numbered solution that changes on a whim
whenever someone adds his own policy may be.... numbered ;) (in terms of days,
that is).

Semi-hard-coding scheduling numbers that get used by user-space sounds
somewhat hackish to me, maybe we should instead (or additionally?) have a
query API that returns a list of policy numbers for a given query input
(near-hard realtime features, non-root access, interactivity, cache usage
friendliness, batched operation, background processing).
What do other systems (*BSD, Solaris, ...) do in this case?

Andreas Mohr
