Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVATRaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVATRaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVATR14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:27:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3774 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262789AbVATRZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:25:19 -0500
Date: Thu, 20 Jan 2005 18:25:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Message-ID: <20050120172506.GA20295@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8eo9hed.fsf@sulphur.joq.us>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


just finished a short testrun with nice--20 compared to SCHED_FIFO, on a
relatively slow 466 MHz box:

 SCHED_FIFO:
 ************* SUMMARY RESULT ****************
 Total seconds ran . . . . . . :   120
 Number of clients . . . . . . :     4
 Ports per client  . . . . . . :     4
 *********************************************
 Timeout Count . . . . . . . . :(    0)
 XRUN Count  . . . . . . . . . :    10
 Delay Count (>spare time) . . :     0
 Delay Count (>1000 usecs) . . :     0
 Delay Maximum . . . . . . . . : 27879   usecs
 Cycle Maximum . . . . . . . . :   732   usecs
 Average DSP Load. . . . . . . :    38.8 %
 Average CPU System Load . . . :    10.9 %
 Average CPU User Load . . . . :    26.4 %
 Average CPU Nice Load . . . . :     0.0 %
 Average CPU I/O Wait Load . . :     0.1 %
 Average CPU IRQ Load  . . . . :     0.0 %
 Average CPU Soft-IRQ Load . . :     0.0 %
 Average Interrupt Rate  . . . :  1709.6 /sec
 Average Context-Switch Rate . :  6359.9 /sec
 *********************************************

nice--20-hack:

 ************* SUMMARY RESULT ****************
 Total seconds ran . . . . . . :   120
 Number of clients . . . . . . :     4
 Ports per client  . . . . . . :     4
 *********************************************
 Timeout Count . . . . . . . . :(    0)
 XRUN Count  . . . . . . . . . :    10
 Delay Count (>spare time) . . :     0
 Delay Count (>1000 usecs) . . :     0
 Delay Maximum . . . . . . . . :  6807   usecs
 Cycle Maximum . . . . . . . . :  1059   usecs
 Average DSP Load. . . . . . . :    39.9 %
 Average CPU System Load . . . :    10.9 %
 Average CPU User Load . . . . :    26.0 %
 Average CPU Nice Load . . . . :     0.0 %
 Average CPU I/O Wait Load . . :     0.1 %
 Average CPU IRQ Load  . . . . :     0.0 %
 Average CPU Soft-IRQ Load . . :     0.0 %
 Average Interrupt Rate  . . . :  1712.8 /sec
 Average Context-Switch Rate . :  5113.0 /sec
 *********************************************

this shows the surprising result that putting all RT tasks on nice--20
reduced context-switch rate by 20% and the Delay Maximum is lower as
well. (although the Delay Maximum is quite unreliable so this could be a
fluke.) But the XRUN count is the same.

can anyone else reproduce this, with the test-patch below applied?

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2245,10 +2245,10 @@ EXPORT_PER_CPU_SYMBOL(kstat);
  * if a better static_prio task has expired:
  */
 #define EXPIRED_STARVING(rq) \
-	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
+	((task_nice(current) > -20) && ((STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
 			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
-			((rq)->curr->static_prio > (rq)->best_expired_prio))
+			((rq)->curr->static_prio > (rq)->best_expired_prio)))
 
 /*
  * Do the virtual cpu time signal calculations.
@@ -3211,6 +3211,12 @@ static inline task_t *find_process_by_pi
 static void __setscheduler(struct task_struct *p, int policy, int prio)
 {
 	BUG_ON(p->array);
+	if (policy != SCHED_NORMAL) {
+		p->policy = SCHED_NORMAL;
+		p->static_prio = NICE_TO_PRIO(-20);
+		p->prio = p->static_prio;
+		return;
+	}
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL)
