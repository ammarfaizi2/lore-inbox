Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSGJGZu>; Wed, 10 Jul 2002 02:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317484AbSGJGZt>; Wed, 10 Jul 2002 02:25:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7117 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315449AbSGJGZs>;
	Wed, 10 Jul 2002 02:25:48 -0400
Date: Thu, 11 Jul 2002 08:27:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O(1) batch scheduler
In-Reply-To: <20020709223021.A4567@arizona.localdomain>
Message-ID: <Pine.LNX.4.44.0207110817160.2263-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jul 2002, Kevin O'Connor wrote:

> I looked through your sched-2.5.25-A5 patch, and I'm confused by the
> idle_count array. It calculates the idle average of the last 9 seconds -
> but why not just use a weighted average. A weighted average is going to
> be very close to the true average, and where it differs the weighted
> average should be preferable.

i agree, the hybrid weighted average you suggest is the right solution
here, because the sampling in that case has a fixed frequency which is
HZ-independent. I've applied your patch to my tree.

the problem with a pure weighted average (ie. no ->idle_count, just a
weighted average calculated in the scheduler tick) is that with HZ=1000
and a 32-bit word length the sampling gets too inaccurate. For the average
to be meaningful it needs to be at least 'a few seconds worth' - which is
'a few thousands of events' - the rounding errors are pretty severe in
that case.

(a good example where a running average has fundamental accuracy problem
is the ->sleep_avg sampling. The frequency of wakeups/sleep events can be
almost arbitrarily high, destroying the accuracy of a weighted average.)

	Ingo

