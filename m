Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVFIVZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVFIVZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVFIVZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:25:51 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:41736 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262474AbVFIVY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:24:58 -0400
Message-ID: <42A8B390.2060400@stud.feec.vutbr.cz>
Date: Thu, 09 Jun 2005 23:24:32 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu>
In-Reply-To: <20050608112801.GA31084@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------090406040607000803020601"
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
                              [score: 0.0004]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090406040607000803020601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ingo,

Since the introduction of the delayed preemption feature in V0.7.47-20 
my KDE desktop has been jerky. The sound from artsd often skips. The 
mouse pointer jumps when I compile anything the background and try to 
browse the web with Firefox.

I think that try_to_wake_up is broken for the !sync case. We have:

		__activate_task(p, rq);
                 if (TASK_PREEMPTS_CURR(p, rq)) {
                         if (sync)
                                 set_tsk_need_resched_delayed(rq->curr);
                         else
                                 resched_task(rq->curr);
                 }

Shouldn't we call the full activate_task(...) instead of 
__activate_task(...) in the !sync case?


The attached patch fixes seems to fix it for me. It is against V0.7.48-05.

Michal

--------------090406040607000803020601
Content-Type: text/plain;
 name="rt-fix-delayed-preemption-lags.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-fix-delayed-preemption-lags.diff"

diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/kernel/sched.c linux-RT.mich/kernel/sched.c
--- linux-RT/kernel/sched.c	2005-06-09 23:09:43.000000000 +0200
+++ linux-RT.mich/kernel/sched.c	2005-06-09 23:07:43.000000000 +0200
@@ -1195,11 +1195,13 @@ out_activate:
 		if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
 	} else {
-		__activate_task(p, rq);
-		if (TASK_PREEMPTS_CURR(p, rq)) {
-			if (sync)
+		if (sync) {
+			__activate_task(p, rq);
+			if (TASK_PREEMPTS_CURR(p, rq))
 				set_tsk_need_resched_delayed(rq->curr);
-			else
+		} else {
+			activate_task(p, rq, cpu == this_cpu);
+			if (TASK_PREEMPTS_CURR(p, rq))
 				resched_task(rq->curr);
 		}
 	}

--------------090406040607000803020601--
