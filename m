Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVGUKj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVGUKj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 06:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVGUKj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 06:39:57 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:36254 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261737AbVGUKj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 06:39:56 -0400
Date: Thu, 21 Jul 2005 12:39:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [RFC - 0/12] NTP cleanup work (v. B4)
In-Reply-To: <1121876812.4259.14.camel@leatherman>
Message-ID: <Pine.LNX.4.61.0507210151570.3728@scrub.home>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0507171706490.3728@scrub.home> <1121876812.4259.14.camel@leatherman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 20 Jul 2005, john stultz wrote:

> I really don't think the NTP changes I've mailed is very complex.
> Please, be specific and point to something you think is an issue and
> I'll do my best to fix it.

Maybe I should explain, in what direction I would take it.
Let's first only take tick based updates, one property I don't want to see 
go away (and which you remove in the last patch), is to basically update 
xtime at every tick by (tick_nsec+time_adj) (and maybe fold time_adjust 
into time_adj), no multiply/divide just adds/shifts. Every second (or 
maybe even less frequently) we update time_adj, where we even might 
integrate a better to way to add previous errors due to SHIFT_HZ.

To add support for continous time sources, the generic ntp code would just 
provide [tick,frequency,offset] values and the time source converts it 
into its internal values. A tick based source calculates [tick_nsec, 
time_adj] and a continous source calculates the [offset,multiplier]. These 
values should be recalculated as infrequently as possible and not every 
single tick as you do with ppc_adjtimex. This also means a continous 
source updates xtime basically by calling gettimeofday (what ppc64 already 
almost does) and doesn't use update_wall_time() at all.

Maybe I'm missing something, but I don't see a reason to forcibly merge 
both ways to update the clock, keep them seperate and let the generic ntp 
code provide the basic parameters which the time source uses to update the 
clock. The important thing is to precalculate as much as possible, so that 
the runtime overhead is as low as possible and these precalculations 
differ between time sources, so what your patches basically do is to 
remove all of these precalculations and I can't convince myself to see 
this as a good thing.

BTW do you have any user space test code for this? This might be useful to 
verify that the changes are really correct and a prototype might be a good 
way to demonstrate the kernel changes.

bye, Roman
