Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSDDT2H>; Thu, 4 Apr 2002 14:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310434AbSDDT0m>; Thu, 4 Apr 2002 14:26:42 -0500
Received: from zero.tech9.net ([209.61.188.187]:43783 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293603AbSDDT0W>;
	Thu, 4 Apr 2002 14:26:22 -0500
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
	boot time
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Adam J. Richter" <adam@yggdrasil.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204041113410.12895-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 14:26:22 -0500
Message-Id: <1017948383.22303.537.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 14:14, Linus Torvalds wrote:

> The answer is that preempt_schedule() illegally sets 
> 
> 	current->state = TASK_RUNNING;
> 
> without asking the process whether that's ok. The SMP code never does 
> anything like that.

Well Ingo added that ;)

We used to just set a flag in the preempt_count that marked the task as
preempted and made sure on its next trip into schedule it ran again.

Do you think it is better to deny preemption if state==TASK_ZOMBIE (note
this requires code in preempt_schedule and the interrupt return path,
since Ingo decoupled the two) or just disable preemption around critical
regions caused by setting state to TASK_ZOMBIE ?

I suspect this is the first occurrence of a problem of this kind ... and
the attached patch handles it.

	Robert Love

diff -urN linux-2.5.8-pre1/kernel/exit.c linux/kernel/exit.c
--- linux-2.5.8-pre1/kernel/exit.c	Wed Apr  3 20:57:37 2002
+++ linux/kernel/exit.c	Thu Apr  4 14:22:30 2002
@@ -499,6 +499,8 @@
 	acct_process(code);
 	__exit_mm(tsk);
 
+	preempt_disable();
+
 	sem_exit();
 	__exit_files(tsk);
 	__exit_fs(tsk);
@@ -515,6 +517,7 @@
 
 	tsk->exit_code = code;
 	exit_notify();
+	preempt_enable_no_resched();
 	schedule();
 	BUG();
 /*


