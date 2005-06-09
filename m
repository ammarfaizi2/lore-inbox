Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVFIVeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVFIVeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVFIVeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:34:44 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:2313 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S262481AbVFIVe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:34:27 -0400
Message-ID: <42A8B5CC.5010509@stud.feec.vutbr.cz>
Date: Thu, 09 Jun 2005 23:34:04 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu> <42A8B390.2060400@stud.feec.vutbr.cz>
In-Reply-To: <42A8B390.2060400@stud.feec.vutbr.cz>
Content-Type: multipart/mixed;
 boundary="------------020803060708060209030907"
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
--------------020803060708060209030907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I wrote:
> Shouldn't we call the full activate_task(...) instead of 
> __activate_task(...) in the !sync case?
> 
> 
> The attached patch fixes seems to fix it for me. It is against V0.7.48-05.


This patch should work the same and is a bit nicer.
Michal

--------------020803060708060209030907
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

--------------020803060708060209030907--
