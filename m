Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWFBI2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWFBI2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWFBI2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:28:46 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:27306 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751322AbWFBI2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:28:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=03IL1cwYVunMHxOcxGiVbA540QIde2+cT37xYGJtV1eHqm4uxpIjIuod11aGM3OFbGIwGnH4lsFjyfCjKkexyIPM3brroSw5GtP3YBE/vo9D7HGIlKAffXUBLhSxPdj5Rov6O+ORH+voSVw3o7vAyaDbKysPAH7maK8WTSbr5EI=  ;
Message-ID: <447FF6B8.1000700@yahoo.com.au>
Date: Fri, 02 Jun 2006 18:28:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
References: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com> <200606021608.33928.kernel@kolivas.org> <447FEE6C.7000408@yahoo.com.au> <200606021817.46745.kernel@kolivas.org>
In-Reply-To: <200606021817.46745.kernel@kolivas.org>
Content-Type: multipart/mixed;
 boundary="------------070705050307050500050603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070705050307050500050603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> On Friday 02 June 2006 17:53, Nick Piggin wrote:
> 
>>This is a small micro-optimisation / cleanup we can do after
>>smtnice gets converted to use trylocks. Might result in a little
>>less cacheline footprint in some cases.
> 
> 
> It's only dependent_sleeper that is being converted in these patches. The 
> wake_sleeping_dependent component still locks all runqueues and needs to 

Oh I missed that.

> succeed in order to ensure a task doesn't keep sleeping indefinitely. That 

Let's make it use trylocks as well. wake_priority_sleeper should ensure
things don't sleep forever I think? We should be optimising for the most
common case, and in many workloads, the runqueue does go idle frequently.

> one doesn't get called from schedule() so is far less expensive. This means I 
> don't think we can change that cpu based locking order which I believe was 
> introduce to prevent a deadlock (?DaveJ disovered it iirc).
> 

AntonB, I think.

-- 
SUSE Labs, Novell Inc.

--------------070705050307050500050603
Content-Type: text/plain;
 name="sntnice2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sntnice2.patch"

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2006-06-02 18:23:18.000000000 +1000
+++ linux-2.6/kernel/sched.c	2006-06-02 18:26:40.000000000 +1000
@@ -2686,6 +2686,9 @@ static inline void wakeup_busy_runqueue(
 		resched_task(rq->idle);
 }
 
+/*
+ * Called with interrupts disabled and this_rq's runqueue locked.
+ */
 static void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *tmp, *sd = NULL;
@@ -2699,22 +2702,13 @@ static void wake_sleeping_dependent(int 
 	if (!sd)
 		return;
 
-	/*
-	 * Unlock the current runqueue because we have to lock in
-	 * CPU order to avoid deadlocks. Caller knows that we might
-	 * unlock. We keep IRQs disabled.
-	 */
-	spin_unlock(&this_rq->lock);
-
 	sibling_map = sd->span;
-
-	for_each_cpu_mask(i, sibling_map)
-		spin_lock(&cpu_rq(i)->lock);
-	/*
-	 * We clear this CPU from the mask. This both simplifies the
-	 * inner loop and keps this_rq locked when we exit:
-	 */
 	cpu_clear(this_cpu, sibling_map);
+	for_each_cpu_mask(i, sibling_map) {
+		if (unlikely(!spin_trylock(&cpu_rq(i)->lock)))
+			cpu_clear(i, sibling_map);
+	}
+
 
 	for_each_cpu_mask(i, sibling_map) {
 		runqueue_t *smt_rq = cpu_rq(i);
@@ -2724,10 +2718,6 @@ static void wake_sleeping_dependent(int 
 
 	for_each_cpu_mask(i, sibling_map)
 		spin_unlock(&cpu_rq(i)->lock);
-	/*
-	 * We exit with this_cpu's rq still held and IRQs
-	 * still disabled:
-	 */
 }
 
 /*
@@ -2961,13 +2951,6 @@ need_resched_nonpreemptible:
 			next = rq->idle;
 			rq->expired_timestamp = 0;
 			wake_sleeping_dependent(cpu, rq);
-			/*
-			 * wake_sleeping_dependent() might have released
-			 * the runqueue, so break out if we got new
-			 * tasks meanwhile:
-			 */
-			if (!rq->nr_running)
-				goto switch_tasks;
 		}
 	}
 

--------------070705050307050500050603--
Send instant messages to your online friends http://au.messenger.yahoo.com 
