Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUFDHkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUFDHkv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 03:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUFDHkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 03:40:51 -0400
Received: from gizmo09bw.bigpond.com ([144.140.70.19]:33958 "HELO
	gizmo09bw.bigpond.com") by vger.kernel.org with SMTP
	id S261951AbUFDHki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 03:40:38 -0400
Message-ID: <40C02771.1080803@bigpond.net.au>
Date: Fri, 04 Jun 2004 17:40:33 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       kernel.linux@lists.sw.oz.au
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired
 with a single array
References: <214A1-6NK-7@gated-at.bofh.it> <21acm-2GN-1@gated-at.bofh.it> <m37juvpgjc.fsf@averell.firstfloor.org>
In-Reply-To: <m37juvpgjc.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
>>I think your aims of simplifying the scheduler are admirable but I hope you 
>>don't suffer the quagmire that is manipulating the interactivity stuff. 
>>Changing one value and saying it has no apparent effect is almost certainly 
>>wrong; surely it was put there for a reason - or rather I put it there for a 
>>reason.
> 
> 
> But that doesn't mean that the reason cannot be reevaluated later.
> If Peter can up with a simpler scheduler and nobody can break it significantly
> it would be great, and i'm hope such simplifications could be merged
> after testing. Certainly the current one does far too much black magic.

As a result of your encouragement I have implemented a simplified 
version of the interactive bonus scheme and an extension whose aim is to 
improve general system throughput on to of my SPA patch (to the 2.6.6 
kernel) an updated version of which is available at:

<http://users.bigpond.net.au/Peter-Williams/patch-2.6.6-spa-v2>

Interactive Bonus (SPA_IA_BONUS) patch is available at:

<http://users.bigpond.net.au/Peter-Williams/patch-2.6.6-spa_ia_bonus>

This patch approaches the problem from a control systems perspective and 
the statistics are calculated for each task (using extremely simple and 
efficient Kalman filters):

A_c which is the running average number of nanoseconds of CPU time that 
it spends on the CPU during a scheduling cycle (SC) which is defined to 
be the period from one activation (or wake up) to the next.

A_s which is the running average number of nanoseconds that it spends 
sleeping during the SC

A_d which is the running average number of nanoseconds that it spends on 
a run queue waiting for CPU access

These statistics are then used to make the following tests about the task:

1. is it showing interactive behaviour, and/or
2. is it showing CPU bound behaviour.

The first test consists of testing that A_s / (A_s + A_c) (where A_s is 
the average sleep time per cycle and A_c is the average CPU time per 
cycle) is greater than a threshold (currently 90%) (NB this is 
equivalent to A_c / (A_c + A_s) being less than 10%) and also that the 
average sleep time isn't greater than a threshold (currently set at 15 
minutes).  This test is applied at the end of each scheduling cycle when 
the task is woken and put back on the run queue.  If the task passes 
this test its interactive bonus is increased asymptotically towards the 
maximum bonus (or, at least, the maximum multiplied by their average A_s 
/ (A_s + A_c)).

The second test is applied at the end of a cycle if the above test fails 
and also at the end of each time slice (if the task stays active for 
more than one time slice).  This task consists of testing whether the 
ratio A_c / (A_s + A_c + A_d) (where A_d is the average delay on run 
queues waiting for CPU access per cycle) is greater a threshold 
(currently 50%) or A_s is zero or very large (currently greater than 2 
hours) and if the task passes this test it is considered to be CPU bound 
or a chronic idler and NOT interactive and its interactive bonus is 
decreased asymptotically towards zero.  The reason that A_c / (A_s + A_c 
+ A_d) instead of the equivalent A_c / (A_c + A_s) form the first test 
is so that interactive tasks are not mistakenly classified as CPU bound 
tasks when the system is very busy and their wait time becomes squeezed 
and turns into run queue delay time.  Similarly, the reason that A_c / 
(A_c + A_s + A_d) isn't used in the first test is that it could lead to 
CPU bound tasks being wrongly classed as interactive tasks when the 
system is very busy.

In the description of the first test, I mention that the interactive 
bonus of a tasks asymptotically approaches the product of the maximum 
bonus and their average A_s / (A_s + A_c).  This has the important side 
effect that the interactive bonus of a fairly busy task such as the X 
server doesn't get as big bonus as that of those low CPU usage stream 
servers such as xmms and they work quite happily under extremely heavy 
loads including heavy X server activity.

Although this may sound complex and expensive it's actually quite cheap 
as estimating the averages is very simple and the more complex bits 
(involving 64 bit division to calculate the ratios) occur relatively 
infrequently.

Throughput Bonus (SPA_TPT_BONUS) patch is available at:

<http://users.bigpond.net.au/Peter-Williams/patch-2.6.6-spa_tpt_bonus>

This bonus is also based on the statistics described above and awards 
bonus points to tasks that are spending a disproportionate amount of 
time (compared to the CPU time they are using) on run queues.  The 
maximum amount of this bonus is half that of the maximum interactive 
bonus so it should not cause tasks receiving it to interfere with them.
The bonus awarded is proportional to the equation: (A_d / (A_d + A_c * 
N)) where N is the number of tasks running on the CPU in question.  This 
latter correction is necessary to stop all tasks getting the maximum 
bonus when the system is busy.  Unlike the interactive bonus this bonus 
is not persistent and is recalculated every time the task is to be 
requeued.  When the system is not heavily loaded this bonus has the 
tendency to reduce the overall amount of queuing on the system and 
improve throughput.  When the system is heavily loaded it tends to 
spread the pain evenly among the non interactive tasks (subject, of 
course, to niceness).

Hopefully my explanations above don't fall into the "black magic" 
category and the mechanics of the scheduler are easy to understand? :-)

If not and you have any questions don't hesitate to ask
Peter
PS Patches for 2.6.7-rc2 should be available next week.
-- 
Dr Peter Williams                                pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

