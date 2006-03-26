Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWCZXny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWCZXny (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWCZXny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:43:54 -0500
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:60298 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932216AbWCZXny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:43:54 -0500
Message-ID: <44272737.50309@bigpond.net.au>
Date: Mon, 27 Mar 2006 10:43:51 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] sched: smpnice prevent integer arithmetic wrap problems
References: <20060322155122.2745649f.akpm@osdl.org> <4421F702.5040609@bigpond.net.au> <20060324154558.A20018@unix-os.sc.intel.com> <442722C4.4030409@bigpond.net.au>
In-Reply-To: <442722C4.4030409@bigpond.net.au>
Content-Type: multipart/mixed;
 boundary="------------000501050902000109020303"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 26 Mar 2006 23:43:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000501050902000109020303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> Siddha, Suresh B wrote:
>> more issues with smpnice patch...
>>
>> a) consider a 4-way system (simple SMP system with no HT and cores) 
>> scenario
>> where a high priority task (nice -20) is running on P0 and two normal
>> priority tasks running on P1. load balance with smp nice code
>> will never be able to detect an imbalance and hence will never move 
>> one of the normal priority tasks on P1 to idle cpus P2 or P3.
> 
> Fix already sent.
> 
>>
>> b) smpnice seems to break this patch..
>>
>> [PATCH] sched: allow the load to grow upto its cpu_power
>> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=0c117f1b4d14380baeed9c883f765ee023da8761 
>>
>>
>> example scenario for this case: consider a numa system with two nodes, 
>> each
>> node containing four processors. if there are two processes in node-0 
>> and with
>> node-1 being completely idle, your patch will move one of those 
>> processes to
>> node-1 whereas the previous behavior will retain those two processes 
>> in node-0..
>> (in this case, in your code max_load will be less than 
>> busiest_load_per_task)
> 
> I think that the patch I sent to address a) above will also fix this 
> problem as find_busiest_queue() will no longer find node-0 as the 
> busiest group unless both of the processes in node-0 are on the same 
> CPU.  This is because it now only considers groups that have at least 
> one CPU with more than one running task as candidates for being the 
> busiest group.
> 
> Implicit in this is the assumption that it's OK to move one of the tasks 
> from node-0 to node-1 if they're both on the same CPU within node-0.
> 
> Could you confirm this is OK?

It looks like my coffee was slow kicking in this morning :-)

When I looked at the code more carefully I realized that you're 
suggestion re comparing avg_load and busiest_load_per_task is needed to 
protect the calculation of max_pull from integer arithmetic wrapping 
problems.  There was a big clue to this need in the comment above the 
calculation of max_pull that I failed to read :-(

Anyway the attached patch should fix the problem.  It should be applied 
on top of the other patch.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------000501050902000109020303
Content-Type: text/plain;
 name="smpnice-allow-load-up-to-cpu_power"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-allow-load-up-to-cpu_power"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-03-25 13:56:37.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-03-27 10:15:38.000000000 +1100
@@ -2161,7 +2161,7 @@ find_busiest_group(struct sched_domain *
 		group = group->next;
 	} while (group != sd->groups);
 
-	if (!busiest || this_load >= max_load || busiest_nr_running <= 1)
+	if (!busiest || this_load >= max_load)
 		goto out_balanced;
 
 	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
@@ -2171,6 +2171,9 @@ find_busiest_group(struct sched_domain *
 		goto out_balanced;
 
 	busiest_load_per_task /= busiest_nr_running;
+
+	if (avg_load <= busiest_load_per_task)
+		goto out_balanced;
 	/*
 	 * We're trying to get all the cpus to the average_load, so we don't
 	 * want to push ourselves above the average load, nor do we wish to

--------------000501050902000109020303--
