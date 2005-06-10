Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVFJHwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVFJHwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVFJHwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:52:42 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:2822 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S262509AbVFJHwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:52:37 -0400
Message-ID: <42A946BB.50108@stud.feec.vutbr.cz>
Date: Fri, 10 Jun 2005 09:52:27 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Milan Svoboda <milan.svoboda@centrum.cz>
CC: linux-kernel@vger.kernel.org, simlo@phys.au.dk
Subject: Re: bug in Real-Time Preemption
References: <200506100918.3335@centrum.cz>
In-Reply-To: <200506100918.3335@centrum.cz>
Content-Type: multipart/mixed;
 boundary="------------040206070001060007000005"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040206070001060007000005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Milan Svoboda wrote:
> under non RT preempt:
> (these results are expected)
> 
> ./a.out
> Flag: 0, Dif:11714
> ./a.out
> Flag: 0, Dif:11678
> 
> under full RT preempt:
> ./a.out
> Flag: 1, Dif:582536
> ./a.out
> Flag: 1, Dif:579791
> 
> This shows that thread with bigger priority was
> blocked by the thread with lower priority!

Can you retry with RT-V0.7.48-05 and this patch applied?

Michal

--------------040206070001060007000005
Content-Type: text/plain;
 name="rt-fix-delayed-preemption-lags2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-fix-delayed-preemption-lags2.diff"

diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/kernel/sched.c linux-RT.mich/kernel/sched.c
--- linux-RT/kernel/sched.c	2005-06-09 23:09:43.000000000 +0200
+++ linux-RT.mich/kernel/sched.c	2005-06-09 23:29:20.000000000 +0200
@@ -1190,18 +1190,14 @@ out_activate:
 	 * this cpu. Delayed preemption is guaranteed to happen upon
 	 * return to userspace.
 	 */
-	if (cpu != this_cpu) {
+	if (!sync || cpu != this_cpu) {
 		activate_task(p, rq, cpu == this_cpu);
 		if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
 	} else {
 		__activate_task(p, rq);
-		if (TASK_PREEMPTS_CURR(p, rq)) {
-			if (sync)
-				set_tsk_need_resched_delayed(rq->curr);
-			else
-				resched_task(rq->curr);
-		}
+		if (TASK_PREEMPTS_CURR(p, rq))
+			set_tsk_need_resched_delayed(rq->curr);
 	}
 	trace_start_sched_wakeup(p, rq);
 	if (rq->curr && p && rq && _need_resched())

--------------040206070001060007000005--
