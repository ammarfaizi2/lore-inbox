Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWFPPdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWFPPdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWFPPdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:33:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7817 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751454AbWFPPdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:33:52 -0400
Date: Fri, 16 Jun 2006 17:33:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: clocksource
In-Reply-To: <1150428084.15267.74.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0606161620190.32445@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org> 
 <Pine.LNX.4.64.0606050141120.17704@scrub.home>  <1149538810.9226.29.camel@localhost.localdomain>
  <Pine.LNX.4.64.0606052226150.32445@scrub.home>  <1149622955.4266.84.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.64.0606070005550.32445@scrub.home>  <1149753904.2764.24.camel@leatherman>
  <Pine.LNX.4.64.0606151319440.32445@scrub.home> <1150428084.15267.74.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jun 2006, john stultz wrote:

> I've also been working on improving the adjustment algorithm. Paul
> Mckenney enlightened me to the established concepts in control theory, I
> started reading up on PID control (see:
> http://en.wikipedia.org/wiki/PID_controller ). While I have understood
> the basic concept, it was useful to read up on it. I've tried to rework
> the adjustment code accordingly.
> 
> The method I came up with is really just P-D (proportional-derivative)
> control, but that should be ok since the adjustments are all linear so I
> don't think the integral control is necessary (control theorists can
> pipe in here).

This makes it more complex than necessary. AFAICT this controller 
calculates the adjustment solely based on the current error, but we have 
more information than this, which make the current error rather 
uninteresting.
We know the clock frequency and the NTP frequency so we can easily 
precalculate, how the error will look like at the next few ticks. Based on 
this we can calculate how we have to adjust the clock frequency to reduce 
the error. Overshooting is also not a real problem as long as the absolute 
error gets smaller.

An important point about the last patch is not just robustness but also 
speed, it tries to keep the fast path small, which is basically:

	interval = clock->cycle_interval;
	if (error > interval / 2) {
		adj = 1;
		if (unlikely(error > interval * 2)) {
			...
		}
	} else if (error < -interval / 2) {
		adj = -1
		interval = -interval;
		offset = -offset;
		if (unlikely(error < interval * 2)) {
			...
		}
	} else
		return;

	clock->mult += adj;
	clock->xtime_interval += interval;
	clock->xtime_nsec -= offset;
	clock->error -= interval - offset;

You'll need a very good reason to do anything more than this for small 
errors and I would suggest you start from something like this, as this is 
the very core of the error adjustment.

bye, Roman
