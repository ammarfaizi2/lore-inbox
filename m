Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264378AbVBEH77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264378AbVBEH77 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 02:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbVBEH76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 02:59:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59570 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265652AbVBEH7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 02:59:47 -0500
Date: Sat, 5 Feb 2005 08:59:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Manish Lachwani <mlachwani@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.37-02
Message-ID: <20050205075936.GA22103@elte.hu>
References: <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu> <20050122122915.GA7098@elte.hu> <20050201201402.GA31930@elte.hu> <1107481908.27584.448.camel@localhost.localdomain> <1107483490.27584.459.camel@localhost.localdomain> <1107583350.27584.473.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107583350.27584.473.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> 	while(unlikely(error == IN_WAKEUP)) {
> 		cpu_relax();
> 		error = queue.status;
> 	}
> 
> So, what looks to be happening is that as soon as the parent wakes up
> the child, the child preempts the parent, and hits this while loop.
> But since the child is a realtime task, with the highest priority of
> the system, it starves the system. Of course this is a UP and I don't
> think this will show a problem on an SMP machine. 

hm - i had a fix in this area in the -V0.7 series. Then i thought this
is a performance fix only and dropped it eventually, but could you give
it a go - does it fix the deadlock?

	Ingo

--- linux/ipc/sem.c.orig
+++ linux/ipc/sem.c
@@ -359,12 +371,18 @@ static void update_queue (struct sem_arr
 			struct sem_queue *n;
 			remove_from_queue(sma,q);
 			n = q->next;
+			/*
+			 * Make sure that the wakeup doesnt preempt
+			 * _this_ CPU prematurely. (on PREEMPT_RT)
+			 */
+			preempt_disable();
 			q->status = IN_WAKEUP;
 			wake_up_process(q->sleeper);
 			/* hands-off: q will disappear immediately after
 			 * writing q->status.
 			 */
 			q->status = error;
+			preempt_enable();
 			q = n;
 		} else {
 			q = q->next;
