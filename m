Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVLGJgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVLGJgu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 04:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVLGJgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 04:36:49 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:12698 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750739AbVLGJgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 04:36:49 -0500
Message-ID: <4396ACF5.3050204@andrew.cmu.edu>
Date: Wed, 07 Dec 2005 04:35:49 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: David Lang <david.lang@digitalinsight.com>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/43] ktimer reworked
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0512011734020.10276@qynat.qvtvafvgr.pbz> <Pine.LNX.4.61.0512021124360.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0512021124360.1609@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Roman Zippel wrote:
> On Thu, 1 Dec 2005, David Lang wrote:
>>In addition, once you remove the bulk of these uses from the picture (by
>>makeing them use a new timer type that's optimized for their useage pattern,
>>the 'unlikly to expire' case) the remainder of the timer users easily fall
>>into the catagory where the timer is expected to expire, so that code can
>>accept a performance hit for removing events prior to them going off that
>>would not be acceptable in a general case version.
> 
> Guys, before you continue spreading nonsense, please read carefully Ingos 
> description of the timer wheel at http://lwn.net/Articles/156329/ .
> Let me also refine the statement I made in this mail: the _focus_ on 
> delivery is complete nonsense.

Must you start every email with inflammatory rhetoric?  If you want to 
know why you find it difficult to get people to see things your way, the 
key is in the above paragraph.  In everyday life you don't insult a 
person on the street and then ask them for directions.

Yes, the expiry/non-expiry distinction is an approximation and perhaps 
an oversimplification.  However, after insulting others for that, you 
continue with your own oversimplification of the algorithms involved. 
Following your words, I could say "Roman, before you continue spreading 
nonsense, please go back and read your algorithms textbook".  The 
reality though is that both of you are approximately correct, and 
neither post deserves to be called nonsense.

> The delivery is really not the important part, what is important is the 
> _lifetime_ of the timer. As Ingo said we try to delay as much work as 
> possible into the future, so that all the work needed for short-lived 
> timer is basically:
> 
> 	list_add() + list_del()
> 
> This is a constant operation and whether at the end is a callback is 
> unimportant from the perspective of the timer system.

Timeout-style timers imply a short lifetime, independent of their 
maximum expiry time.  Regular timers expected to expire can have their 
lifetime predicted accurately by looking at their expiry time.  An 
interface which gives a hint as to the type of timer allows us to 
predict the lifetime.  Please tell me how this tight relation is nonsense?

You are right in that the lifetime is what is important, but the whole 
point of the ktimer distinction is that by knowing if something is a 
timer vs a timeout, *we can more accurately predict the lifetime*.

> When the timer spends more time in the timer wheel, it has to be moved 
> into different slots over time, but this not a really expensive operation 
> either, so e.g. all the work needed with a single cascading step is:
> 
> 	list_add() + list_del() + list_add() + list_del()
> 
> This is still quite cheap and with a single cascading step we cover 2^14 
> jiffies (2^10 for small configurations), which is quite a lot of time and 
> whether in that time the timer is delivered or not doesn't change above 
> cost. Another important thing to realize is that this cost is independent 
> of the amount of timers, the per timer cost depends only on the timeout 
> value.

On the other hand, there is a huge difference between *amortized* 
constant time, and constant time.  The cascade falls into the former 
category, and affects latency a great deal.  It's cheap *per timer*, but 
by batching so much work to be done at once, it's not cheap to execute 
the *cascade operation*.  If you are putting important, latency 
sensitive timers in the same data structure as non-latency-sensitive 
timeouts, it is going to hurt accuracy and timeliness.  For timeouts we 
don't care much, since they rarely cascade; Timers which expire *will* 
go through all the cascades based on their expiry time, and if there are 
many of them, worst-case latency will suffer.  In a mathematical sense 
then, it's not O(1) and to call it so is incorrect.  It's "amortized 
O(log(l))", where "l" is the lifetime of the timer, and the minimum 
resolution is constant.

> So let's look at the new timer which uses a rbtree. Its per timer cost 
> doesn't depend on the expiry value, but on the size of the tree instead. 
> All you have to do with the timer is:
> 
> 	tree_insert() + tree_remove()
> 
> This is not a constant operation, with O(log(n)) it grows quite slowly, 
> but in any case it's more expensive than a simple list_add/list_del, this 
> means you have to do a number of list operations before it becomes more 
> expensive than a single tree operation. The nonconstant cost also means 
> the more timer start using the rbtree, the relatively cheaper it becomes 
> to use the timer wheel again.

Thank you for a very good argument about why timeouts shouldn't use 
rbtree, and should continue to use the timer wheel.  Nobody disagrees on 
this however, and adding ktimers will not force any existing users to 
change to the new interface.

> The break-even point may now be different on various machines, but I think 
> it's safe to assume that two list add/del is at least as cheap and usually 
> cheaper then a tree add/del. This means timers which run for less than 
> 2^14 jiffies are better off using the timer wheel, unless they require the 
> higher resolution of the new timer system.

Again, putting timeouts on the timer wheel is ideal, since we know they 
tend to have short lifetimes.  Same goes for low-resolution timers which 
only need jiffy accuracy.  However, jiffy accuracy doesn't cut it for a 
lot of applications.  It is when we add high accuracy that the timer 
wheel falls down, and requires a different approach.  So let's call "dt" 
the desired resolution of the timer in seconds.  Then the timer wheel 
becomes "amortized O(log(l/dt)) = O(log(l) + log(1/dt))".  When you 
start talking about resolutions where dt=25usec, then the timer wheel 
all the sudden becomes worse than a balanced tree, which is always O(n), 
independent of resolution.

And that's the whole *point* about how we got here.  Let the low 
resolution, low lifetime timeouts stay on the timer wheel, and make a 
new approach that specializes in handling longer lifetime, higher 
resolution timers.  That's ktimers in a nutshell.  You seem to be 
arguing for it rather than against it.

> Moving timers away from the timer wheel will also not help with the 
> problem cases of the timer wheel. If you have a million network timer, a 
> cascading step for thousands of timer takes time, but it doesn't change 
> the cost per timer, we just have to do the work that we were too lazy to 
> do before. In this case it would be better to look into solutions which 
> avoid generating millions of timer in first place.

Putting timers on an rbtree most definitely helps with the worst-case 
latency of the timer wheel.  That is an issue that some of us care very 
deeply about.

You've brought up the fact that networking shouldn't use lots of timers 
several times in the overall discussion.  If you know how to do this, 
I'm sure you can start sending patches to netdev and show them all how 
stupid they've been all along.  However, more likely you'll just find 
out that just maybe the networking people really *have* thought about 
the problem, and the solution they came up with is actually a pretty 
good one.

At any rate, while you fix up all those "timer-abusing" subsystems 
throughout the kernel, can we just try to improve the timer system in 
the meantime?

> So can we please stop this likely/unlikely expiry nonsense? It's great if 
> you want to tell aunt Tillie about kernel hacking, but it's terrible 
> advice to kernel programmers. When it comes to choosing a timer 
> implementation, the delivery is completely and utterly unimportant.

Expected expiry is a simple predictor of expected lifetime.  If we knew 
the lifetime, we could use that, but expiry is one hint that is easier 
for the developer to provide.  Really, we want to know "E[l]/dt" (E[] is 
notation for expected value), but that's unrealistic to estimate.  What 
ktimers says is: if it's a timeout (E[l] is low and dt is high), use the 
timer wheel, and if its a timer (E[l] is high and dt is low), use an 
rbtree.  In what way is that not a reasonable approach?

Jim Bruce
