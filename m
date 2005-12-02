Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVLBOoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVLBOoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 09:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVLBOoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 09:44:34 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:31202 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750761AbVLBOod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 09:44:33 -0500
Date: Fri, 2 Dec 2005 15:43:45 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: David Lang <david.lang@digitalinsight.com>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Steven Rostedt <rostedt@goodmis.org>,
       johnstul@us.ibm.com, george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <Pine.LNX.4.62.0512011734020.10276@qynat.qvtvafvgr.pbz>
Message-ID: <Pine.LNX.4.61.0512021124360.1609@scrub.home>
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0512011734020.10276@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Dec 2005, David Lang wrote:

> In addition, once you remove the bulk of these uses from the picture (by
> makeing them use a new timer type that's optimized for their useage pattern,
> the 'unlikly to expire' case) the remainder of the timer users easily fall
> into the catagory where the timer is expected to expire, so that code can
> accept a performance hit for removing events prior to them going off that
> would not be acceptable in a general case version.

Guys, before you continue spreading nonsense, please read carefully Ingos 
description of the timer wheel at http://lwn.net/Articles/156329/ .
Let me also refine the statement I made in this mail: the _focus_ on 
delivery is complete nonsense.

The delivery is really not the important part, what is important is the 
_lifetime_ of the timer. As Ingo said we try to delay as much work as 
possible into the future, so that all the work needed for short-lived 
timer is basically:

	list_add() + list_del()

This is a constant operation and whether at the end is a callback is 
unimportant from the perspective of the timer system.
When the timer spends more time in the timer wheel, it has to be moved 
into different slots over time, but this not a really expensive operation 
either, so e.g. all the work needed with a single cascading step is:

	list_add() + list_del() + list_add() + list_del()

This is still quite cheap and with a single cascading step we cover 2^14 
jiffies (2^10 for small configurations), which is quite a lot of time and 
whether in that time the timer is delivered or not doesn't change above 
cost. Another important thing to realize is that this cost is independent 
of the amount of timers, the per timer cost depends only on the timeout 
value.

So let's look at the new timer which uses a rbtree. Its per timer cost 
doesn't depend on the expiry value, but on the size of the tree instead. 
All you have to do with the timer is:

	tree_insert() + tree_remove()

This is not a constant operation, with O(log(n)) it grows quite slowly, 
but in any case it's more expensive than a simple list_add/list_del, this 
means you have to do a number of list operations before it becomes more 
expensive than a single tree operation. The nonconstant cost also means 
the more timer start using the rbtree, the relatively cheaper it becomes 
to use the timer wheel again.
The break-even point may now be different on various machines, but I think 
it's safe to assume that two list add/del is at least as cheap and usually 
cheaper then a tree add/del. This means timers which run for less than 
2^14 jiffies are better off using the timer wheel, unless they require the 
higher resolution of the new timer system.

Moving timers away from the timer wheel will also not help with the 
problem cases of the timer wheel. If you have a million network timer, a 
cascading step for thousands of timer takes time, but it doesn't change 
the cost per timer, we just have to do the work that we were too lazy to 
do before. In this case it would be better to look into solutions which 
avoid generating millions of timer in first place.

So can we please stop this likely/unlikely expiry nonsense? It's great if 
you want to tell aunt Tillie about kernel hacking, but it's terrible 
advice to kernel programmers. When it comes to choosing a timer 
implementation, the delivery is completely and utterly unimportant.

bye, Roman
