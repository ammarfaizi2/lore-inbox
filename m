Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUJEFd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUJEFd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 01:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268802AbUJEFd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 01:33:26 -0400
Received: from gizmo11bw.bigpond.com ([144.140.70.21]:58519 "HELO
	gizmo11bw.bigpond.com") by vger.kernel.org with SMTP
	id S268805AbUJEFct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 01:32:49 -0400
Message-ID: <416231FA.9080406@bigpond.net.au>
Date: Tue, 05 Oct 2004 15:32:42 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rui Nuno Capela <rncbc@rncbc.org>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       thewade <pdman@aproximation.org>, Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm1-S9
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <32786.192.168.1.5.1096939184.squirrel@192.168.1.5>
In-Reply-To: <32786.192.168.1.5.1096939184.squirrel@192.168.1.5>
Content-Type: multipart/mixed;
 boundary="------------060501070501010508040205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060501070501010508040205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rui Nuno Capela wrote:
> Ingo wrote:
> 
>>i've released the -S9 VP patch:
>>http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9
>>
> 
> 
> Me again, we bad humor :(
> 
> My SMP/HT box is (again) terribly in that uglyness of being quite
> unfriendly to -mm1, -mm2, and indirectly to -S8 and -S9 labeled kernels.
> 
> It works quite well with vanilla 2.6.9-rc3, though.
> 
> But very, very bad with those -mm1 or -mm2 patches. To get it straight,
> almost all the time it hangs, randomly, but not as completely as to a
> dramatic cold-reboot. It stalls on the the most administrative tasks. Name
> one, and it stalls! I can hardly feel lucky if it sometimes reaches the
> login prompt, while boot/initing.
> 
> I know you remember this story. Yeah. This seems quite similar to some of
> earlier problems, but (un/fortunately) it doesn't seem related to VP at
> all. Just having -mm1 or -mm2 is enough to make this machine go astray.
> 
> However, as usual, this seems to be ix86 SMP/HT specific. On my laptop, I
> get to run full 2.6.9-rc3-mm2-S9 UP very happily.
> 
> Sorry if I can't get any real or useful debug data for now. The bad
> behavior I'm referring to, is terribly non-deterministic, so I couldn't
> get a pattern yet.
> 
> I just wanted to let you know ;)

This may be my fault.  I made changes in the SMH code as part of the 
ZAPHOD patch but was unable to test them on a hyperthreaded machine due 
to a lack thereof (I have one on order).  I've attached a patch that 
reverts the changes that I made.  Can you give them a try please and let 
me know if they fix your problem?

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------060501070501010508040205
Content-Type: text/x-patch;
 name="smh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smh.patch"

--- linux-2.6.9-rc3-mm2/kernel/sched.c	2004-10-05 15:17:09.157119322 +1000
+++ linux-2.6.9-rc3-mm2-mod/kernel/sched.c	2004-10-05 15:27:05.355561830 +1000
@@ -3240,18 +3240,21 @@ need_resched:
 		put_task_in_sinbin(prev);
 
 	cpu = smp_processor_id();
-	if (unlikely(needs_idle_balance(rq))) {
+	if (unlikely(!rq->nr_running)) {
 go_idle:
 		idle_balance(cpu, rq);
-		/* This code should get optimised away when CONFIG_SCHED_SMT
-		 * is not defined
-		 */
-		if (dependent_idle(rq))
+		if (!rq->nr_running) {
+			next = rq->idle;
 			wake_sleeping_dependent(cpu, rq);
+			/*
+			 * wake_sleeping_dependent() might have released
+			 * the runqueue, so break out if we got new
+			 * tasks meanwhile:
+			 */
+			if (!rq->nr_running)
+				goto switch_tasks;
+		}
 	} else {
-		/* This code should all get optimised away when CONFIG_SCHED_SMT
-		 * is not defined
-		 */
 		if (dependent_sleeper(cpu, rq)) {
 			schedstat_inc(rq, sched_goidle);
 			next = rq->idle;
@@ -3262,7 +3265,7 @@ go_idle:
 		 * lock, hence go into the idle loop if the rq went
 		 * empty meanwhile:
 		 */
-		if (unlikely(recheck_needs_idle_balance(rq)))
+		if (unlikely(!rq->nr_running))
 			goto go_idle;
 	}
 

--------------060501070501010508040205--
