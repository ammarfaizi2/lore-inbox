Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVLBPlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVLBPlq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 10:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVLBPlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 10:41:46 -0500
Received: from smtpout.mac.com ([17.250.248.44]:4550 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750794AbVLBPlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 10:41:46 -0500
In-Reply-To: <Pine.LNX.4.61.0512021124360.1609@scrub.home>
References: "dlang@dlang.diginsite.com" <Pine.LNX.4.62.0512011734020.10276@qynat.qvtvafvgr.pbz> <Pine.LNX.4.61.0512021124360.1609@scrub.home>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <272E18D2-1CB6-4474-85F0-845B6FC2AD9D@mac.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 00/43] ktimer reworked
Date: Fri, 2 Dec 2005 10:41:41 -0500
To: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 2, 2005, at 09:43:45, Roman Zippel wrote:
> Hi,
>
> On Thu, 1 Dec 2005, David Lang wrote:
>
>> In addition, once you remove the bulk of these uses from the  
>> picture (by
>> makeing them use a new timer type that's optimized for their  
>> useage pattern,
>> the 'unlikly to expire' case) the remainder of the timer users  
>> easily fall
>> into the catagory where the timer is expected to expire, so that  
>> code can
>> accept a performance hit for removing events prior to them going  
>> off that
>> would not be acceptable in a general case version.
>
> [snip timer wheel is efficient for lots of add remove, timer tree  
> is not]
>
> This means timers which run for less than 2^14 jiffies are better  
> off using the timer wheel, unless they require the higher  
> resolution of the new timer system.

PRECISELY!!!  The point is to provide a new and more flexible API,  
either as two different sets of timer manipulation functions (one for  
timer wheel and one for timer tree) or as a single set with multiple  
backends), and migrate old timers to the new system, reclassifying  
them based on the timer needs.  Some timers/timeouts/whatevers don't  
care much about delivery accuracy and could be placed into a much  
smaller and more efficient timer wheel with only quarter-second or  
half-second accuracy, and maybe even coalesced to one-or-two-second  
boundaries without harming functionality, because they are almost  
certainly going to be removed before they run.  This would be a _big_  
help in tickless systems, where we can schedule a bunch of networking  
timers to all be expired simultaneously, keeping caches hot and  
allowing longer sleep times.  Likewise, we would port some to the new  
API such that they just use the same old ordinary timer wheel.  Other  
timers that want highres guarantees would use the highres part of the  
kernel API (either flags in a structure or a separate set of  
functions) and would be added to a slow but very accurate timer tree.

The fact remains that we have two reasonably useful internal timer  
structures; one which is optimized for lots of timers being added and  
removed frequently, which has poor accuracy, and the other which  
doesn't handle a million timers very well, and is poor at adding and  
removing timers but has excellent accuracy.  We should come up with a  
set of recommendations for when to use each interface.  The _best_  
way to explain that to most kernel developers who don't really  
understand the guts of it is:
1) If you need high resolution and you add the timer and let it  
expire normally, use the ktimer/whatever API.
2) If you just want to time-out an operation or fail when something  
doesn't happen, or a timer that doesn't care about accuracy, use the  
ktimeout/whatever2 API.

> So can we please stop this likely/unlikely expiry nonsense? It's  
> great if you want to tell aunt Tillie about kernel hacking, but  
> it's terrible advice to kernel programmers. When it comes to  
> choosing a timer implementation, the delivery is completely and  
> utterly unimportant.

The fact is, we have a _lot_ of timers, a _lot_ of kernel hackers,  
and we need some easy way to tell people which of two subsystems to  
use.  The fact that the likely/unlikely stuff is easy to tell aunt  
Tillie is precisely what makes it useful to tell kernel hackers with  
a half-million other things on their minds.  Hopefully it will be  
easy enough to understand that when they get around to using timers  
for something or another, they'll pick the right API for their task.

Cheers,
Kyle Moffett
