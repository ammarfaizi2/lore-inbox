Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264101AbUEXHVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUEXHVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUEXHV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:21:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52131 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264088AbUEXHUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:20:00 -0400
Date: Mon, 24 May 2004 11:20:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Billy Biggs <vektor@dumbterm.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tvtime and the Linux 2.6 scheduler
Message-ID: <20040524092057.GA26715@elte.hu>
References: <20040523154859.GC22399@dumbterm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523154859.GC22399@dumbterm.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Billy Biggs <vektor@dumbterm.net> wrote:

>   for(;;)
>       9 ms : process frame
>       4 ms : draw frame
>       3 ms : wait until next field time using /dev/rtc
>       9 ms : process frame
>       4 ms : draw frame
>       3 ms : block on /dev/video0 for next frame
>      -----
>      33 ms : time per NTSC frame
> 
>   The theory is that Linux classifies this as a CPU hog regardless of
> its priority, and preempts tvtime with other processes. [...]

this would indicate a pretty broken scheduler. To prove (or exclude)
this possibility, could you apply the attached debugging patch? The
patch checks whether we ever switch away from a still running (and
hence, on-runqueue) RT task to a non-RT task.

(NOTE: dont run this patch on an SMP kernel, the debugging message will
deadlock there due to spinlock recursion.)

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -2279,6 +2279,7 @@ switch_tasks:
 	prev->timestamp = now;
 
 	if (likely(prev != next)) {
+		WARN_ON(rt_task(prev) && (prev->state == TASK_RUNNING) && !rt_task(next));
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
