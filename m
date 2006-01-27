Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWA0XTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWA0XTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422677AbWA0XTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:19:19 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:31136 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1422675AbWA0XTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:19:18 -0500
From: Con Kolivas <kernel@kolivas.org>
To: MIke Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Date: Sat, 28 Jan 2006 10:18:51 +1100
User-Agent: KMail/1.9
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>
References: <5.2.1.1.2.20060127175530.00c3db30@pop.gmx.net> <1138392368.7770.72.camel@homer>
In-Reply-To: <1138392368.7770.72.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601281018.52121.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 January 2006 07:06, MIke Galbraith wrote:
> What do you think of the below as an evaluation patch?  It leaves the
> bits I'd really like to change (INTERACTIVE_SLEEP() for one), so it can
> be switched on and off for easy comparison and regression testing.
>
> I really didn't want to add more to the task struct, but after trying
> different things, a timeout was the most effective means of keeping the
> nice burst aspect of the interactivity logic but still make sure that a
> burst doesn't turn into starvation.
>
> The workings are dirt simple just as before.  The goal is to keep
> sleep_avg and slice_avg balanced.  When an imbalance starts, immediately
> cut off interactive bonus points.  If the imbalance doesn't correct
> itself through normal sleep_avg usage, we'll soon hit the (1 dynamic
> prio) trigger point, which starts a countdown toward active
> intervention.  The default setting is that a task can run at higher
> dynamic priority than it's cpu usage can justify for 5 seconds.  After
> than, we start trying to work off the deficit, and if we don't succeeded
> within another second (ie it was a big deficit), we demote the offender
> to the rank his cpu usage indicates.
>
> The strategy works well enough to take the wind out of irman2's sails,
> and interactive tasks can still do a nice reasonable burst of activity
> without being evicted.  Down side to starvation control is that X is
> sometimes a serious cpu user, and _can_ end up in the expired array (not
> nice under load).  I personally don't think that's a show stopper
> though... all you have to do is tell the scheduler that what it already
> noticed, that X is a piggy, but an OK piggy by renicing it. It becomes
> immune from active throttling, and all is well.  I know that's not going
> to be popular, but you just can't let X have free rein without leaving
> the barn door wide open.  (maybe that switch should stay since the
> majority of boxen are workstations, and default to off?).

Sounds good but I have to disagree on the X renice thing. It's not that I have 
a religious objection to renicing things. The problem is that our mainline 
scheduler determines latency also by nice level. This means that if you 
-renice a bursty cpu hog like X, then audio applications will fail unless 
they too are reniced. Try it on your patch.

Con
