Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUJOJTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUJOJTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 05:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUJOJTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 05:19:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23435 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267548AbUJOJTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 05:19:05 -0400
Date: Fri, 15 Oct 2004 11:20:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Mateusz.Blaszczyk@nask.pl, rml@tech9.net, linux-kernel@vger.kernel.org,
       wli@holomorphy.com, torvalds@osdl.org
Subject: [patch, 2.6.9-rc4-mm1, 2.6.9-rc4] fix the prof=schedule feature
Message-ID: <20041015092026.GA16458@elte.hu>
References: <Pine.GSO.4.58.0410150833330.9897@boromir> <20041015090336.GA14362@elte.hu> <20041015020712.1514f48c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015020712.1514f48c.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> > in the next mail i will send a patch against 2.6.9-rc4 too (which
> > luckily doesnt have the crash bug, but has the feature mismerge).
> 
> OK.  So it sounds like no additional patch will be needed for -mm?

the sched.c chunks below are still needed. prof=schedule must be driven
from schedule(), not from setscheduler().

The profile.c one is a cleanup. [ and you surely must be a great fan of
profiler cleanups by now B-) ]

the patch applies to 2.6.9-rc4 cleanly as well, and the sched.c bits are
necessary there too. I have tested this patch with and without
prof=schedule and it now produces the expected results:

   314 work_resched                              14.2727
   389 log_wait_commit                            1.2006
   391 kjournald                                  0.6872
   499 need_resched                               9.9800
  1549 worker_thread                              2.5310
  1649 wait_for_completion                        7.4615
  2551 do_exit                                    2.6435
  2999 schedule_timeout                          16.7542
  3073 io_schedule                               64.0208
  7863 preempt_schedule                         126.8226

the above is the scheduling profile of a bootup. ~40% of the reschedules
were caused by PREEMPT, ~20% by IO and the remaining ~40% by process
communication.

without this patch the output is a boring empty profile ...

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2646,6 +2646,7 @@ asmlinkage void __sched schedule(void)
 			dump_stack();
 		}
 	}
+	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
 need_resched:
 	preempt_disable();
@@ -3222,7 +3223,6 @@ static int setscheduler(pid_t pid, int p
 				policy != SCHED_NORMAL)
 			goto out_unlock;
 	}
-	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
--- linux/kernel/profile.c.orig
+++ linux/kernel/profile.c
@@ -22,14 +22,14 @@ static int __init profile_setup(char * s
 	int par;
 
 	if (!strncmp(str, "schedule", 8)) {
-		prof_on = 2;
+		prof_on = SCHED_PROFILING;
 		printk(KERN_INFO "kernel schedule profiling enabled\n");
 		if (str[7] == ',')
 			str += 8;
 	}
 	if (get_option(&str,&par)) {
 		prof_shift = par;
-		prof_on = 1;
+		prof_on = CPU_PROFILING;
 		printk(KERN_INFO "kernel profiling enabled (shift: %ld)\n",
 			prof_shift);
 	}

