Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbTIKCxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 22:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbTIKCxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 22:53:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:38821 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265970AbTIKCxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 22:53:01 -0400
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Wed, 10 Sep 2003 21:55:16 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309102155.16407.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
>>  There are a _lot_ of scheduler changes in 2.6-mm, and who knows which
>>  ones are an improvement, a detriment, and a noop?

> We know that sched-2.6.0-test2-mm2-A3.patch caused the regression, and
> we now that sched-CAN_MIGRATE_TASK-fix.patch mostly fixed it up.

> What we don't know is whether the thing which
> sched-CAN_MIGRATE_TASK-fix.patch
> fixed was the thing which sched-2.6.0-test2-mm2-A3.patch broke.

Sorry for jumping into this late.  I didn't even know the can_migrate patch 
was being discussed, let alone in -mm :).  And to be fair, this really is 
Ingo's aggressive idle steal patch.

Anyway, these patches are somewhat related.  It would seem that A3's 
shortening the tasks' run time would not only slow performance beacuse of 
cache thrash, but could possibly break CAN_MIGRATE's cache warmth check, 
right?  That in turn would stop load balancing from working well, leading to 
more idle time, which the CAN_MIGRATE patch sort of bypassed for idle cpus.

I see Nick's balance patch as somewhat harmless, at least combined with A3 
patch.  However, one concern is that the "ping-pong" steal interval is not 
really 200ms, but 200ms/(nr_cpus-1), which without A3, could show up as a 
problem, especially on an 8 way box.  In addition, I do think there's a 
problem with num tasks we steal.  It should not be imbalance/2, it should be:  
max_load - (node_nr_running / num_cpus_node).  If we steal any more than 
this, which is quite possible with imbalance/2, then it's likely this_cpu now 
has too many tasks, and some other cpu will steal again.  Using *imbalance/2 
works fine on 2-way smp, but I'm pretty sure we "over steal" tasks on 4 way 
and up.  Anyway, I'm getting off topic here...

But Steve's latest results have me toally stumped.  Why would a patch which 
shortens run time and probbaly thrashes cache improve a cpu bound workload 
like JBB?  And why would a patch that makes sure idle cpus don't stay idle 
reduce performance by so much?

Steve, are you absolutely sure your latest results on test5 are correct?  Any 
possibility the original results were the "good" ones?   

FWIW, I have seen the CAN_MIGRATE patch make a huge difference, not just in 
testing, but a -real- enterprise application used in "production".  And 
unlike JBB and Volano, there's no high rate of sched_yield either.  They do 
have a high rate of cswitches, but only because their workload message 
driven.  This patch made a 40% improvement on 4-way on a 2.4 distro kernel 
that has O(1).

-Andrew Theurer





