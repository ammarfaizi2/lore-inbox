Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUJOJCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUJOJCQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 05:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbUJOJCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 05:02:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52353 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267415AbUJOJCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 05:02:12 -0400
Date: Fri, 15 Oct 2004 11:03:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mateusz.Blaszczyk@nask.pl
Cc: rml@tech9.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch, 2.6.9-rc4-mm1] fix oops in sched_setscheduler
Message-ID: <20041015090336.GA14362@elte.hu>
References: <Pine.GSO.4.58.0410150833330.9897@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0410150833330.9897@boromir>
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


* Mateusz.Blaszczyk@nask.pl <Mateusz.Blaszczyk@nask.pl> wrote:

> Running cdrecord caused oops in sched_setscheduler syscall (i think)
> so i tested with my little setp.c program that follows. It seems that
> it always oops - no matter what policy I request. It runs ok on
> 2.6.9-rc2-mm1, same config. Rc3 not tested. I run setp. 3 times. The
> first I decoded using ksymoops. My .config follows at the end.

the crash happens if 1) someone doesnt have profiling enabled 2) uses an
UP kernel and 3) does setscheduler. The patch below fixes 3 problems:
finishes and fixes the consolidation and fixes the profile=schedule
feature. Against 2.6.9-rc4-mm1. Tested.

also it seems that some serious mismerge happened of the
profile=schedule feature. Wli or akpm merge damage?

in the next mail i will send a patch against 2.6.9-rc4 too (which
luckily doesnt have the crash bug, but has the feature mismerge).

	Ingo


Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2744,6 +2744,7 @@ asmlinkage void __sched schedule(void)
 			dump_stack();
 		}
 	}
+	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
 need_resched:
 	preempt_disable();
@@ -3342,7 +3343,6 @@ static int setscheduler(pid_t pid, int p
 				policy != SCHED_NORMAL)
 			goto out_unlock;
 	}
-	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
--- linux/kernel/profile.c.orig
+++ linux/kernel/profile.c
@@ -49,14 +49,14 @@ static int __init profile_setup(char * s
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
@@ -385,6 +385,8 @@ inline void profile_hit(int type, void *
 {
 	unsigned long pc;
 
+	if (prof_on != type || !prof_buffer)
+		return;
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
 	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
 }
@@ -394,8 +396,6 @@ void profile_tick(int type, struct pt_re
 {
 	if (type == CPU_PROFILING)
 		profile_hook(regs);
-	if (prof_on != type || !prof_buffer)
-		return;
 	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }
