Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSGBO1f>; Tue, 2 Jul 2002 10:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSGBO1e>; Tue, 2 Jul 2002 10:27:34 -0400
Received: from server72.aitcom.net ([208.234.0.72]:40936 "EHLO test-area.com")
	by vger.kernel.org with ESMTP id <S316185AbSGBO1d>;
	Tue, 2 Jul 2002 10:27:33 -0400
Message-Id: <200207021430.KAA30171@test-area.com>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: low-latency patch bug?
Date: Tue, 2 Jul 2002 10:40:20 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think I found a bug in the low latency patch. In reschedule_idle there is 
code that it adds that looks like this:


/*1*/#if LOWLATENCY_NEEDED
/*2*/       if (enable_lowlatency && (p->policy != SCHED_OTHER)) {
/*3*/              struct task_struct *t;
/*4*/               for (i = 0; i < smp_num_cpus; i++) {
/*5*/                       cpu = cpu_logical_map(i);
/*6*/                       t = cpu_curr(cpu);
/*7*/                       if (t != tsk)        //<------BUG
/*8*/                               t->need_resched = 1;
/*9*/               }
/*10*/       }
/*11*/#endif

This code does not check to see if tsk (target_tsk) is NULL at line 7. 
Therefore, the scheduler will try to reschedule even if tsk == NULL. In the 
worst case, if your process selection loop finds a different process to run 
everytime, and tsk is always NULL, the scheduler will enter an infinite loop.

I ran into this problem because I was pushing SCHED_RR tasks with the same 
priority to the back of the runqueue everytime the scheduler was called. 
Therefore a new process is found everytime and __schedule_tail is called 
everytime, and therefore a infinite loop.

Anton Wilson





-- 
Camotion
Software Development
