Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270416AbUJTDPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270416AbUJTDPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 23:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270413AbUJTDPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 23:15:22 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:4795 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S266768AbUJTDGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 23:06:36 -0400
Date: Wed, 20 Oct 2004 05:05:54 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>
Subject: gradual timeofday overhaul
In-Reply-To: <1098233967.20778.93.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0410200441210.11067@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl> 
 <1098216701.20778.78.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.53.0410200233280.9510@gockel.physik3.uni-rostock.de>
 <1098233967.20778.93.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004, john stultz wrote:

> As for the timeofday overhaul, I've had zero time to work on it
> recently. I hate that I dropped code and then went missing for weeks.
> I'll have to see if I can get a few cycles at home to sync up my current
> tree and send it out. 

I still haven't looked at your code and it's discussion. From what I
remember, I liked your proposal very much. It's surely where we want to
end up someday. But from the above mail it strikes me that we just don't
have enough manpower to get there all at once, so we should have a plan 
for the time code to gradually evolve into what we finally want. I think 
we could do it in the following steps:

  1. Sync up jiffies with the monotonic clock, very much like we
     already handle lost ticks. This would immediately remove the
     hassles with incompatible time sources.
     Judging from the jiffies wrap experience, we there probably are
     some drivers which need fixing (mostly because they wait until 
     jiffies==something), but these are bugs already right now
     in the case of lost ticks.

  2. Decouple jiffies from the actual interrupt counter. We could
     then e.g. set HZ to 10000, also increasing the resolution of
     timers, without increasing the interrupt frequency.
     We'd then need to identify the places where this might lead to
     overflows and promote them to use jiffies_64 instead of jiffies
     (where this hasn't been done already).

  3. Increase HZ all the way up to 1e9. jiffies_64 would then be the
     same as your plain 64 bit nanoseconds value.
     This would require an optimization to the timer code to be able
     to increment jiffies in steps larger than 1.

Thoughts?

