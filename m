Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbTBPVF2>; Sun, 16 Feb 2003 16:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbTBPVF2>; Sun, 16 Feb 2003 16:05:28 -0500
Received: from franka.aracnet.com ([216.99.193.44]:19349 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267408AbTBPVF1>; Sun, 16 Feb 2003 16:05:27 -0500
Date: Sun, 16 Feb 2003 13:15:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Fw: 2.5.61 oops running SDET
Message-ID: <30110000.1045430104@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302161115290.2874-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302161115290.2874-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well, I did the stupid safe thing, and it hangs the box once we get up to 
>> a load of 32 with SDET. Below is what I did, the only other issue I can
>> see in here is that task_mem takes mm->mmap_sem which is now nested inside
>> the task_lock inside tasklist_lock ... but I can't see anywhere that's a
>> problem from a quick search
> 
> Ho - you can _never_ nest a semaphore inside a spinlock - if the semaphore 
> sleeps, the spinlock will cause a lockup regardless of any reverse nesting 
> issues.. So I guess the old "get_task_mm()" code is requried anyway.

True ... staring at unfamiliar code made me forget a few things ;-)
OK, the below patch works, no oopses, no hangs. If this is acceptable
(even if it's not the final solution), could you apply it? Seems to
be better than the current situation, at any rate.

-----------------------------------------------------

We can encounter a race condition where task->sighand can be NULL in 
proc_pid_status, resulting in an offset NULL pointer dereference in 
render_sigset_t. This can be easily demonstrated running SDET with a 
load of 32 to 64 on a large machine (16x NUMA-Q in this case).

This patch makes us take task_lock around the sighand deferences,
and fixes the oops in testing on the same machine. Thanks to Linus,
Andrew, Manfred and Zwane for lots of guidance ;-)

diff -urpN -X /home/fletch/.diff.exclude virgin/fs/proc/array.c sdet3/fs/proc/array.c
--- virgin/fs/proc/array.c	Sat Feb 15 16:11:45 2003
+++ sdet3/fs/proc/array.c	Sun Feb 16 11:44:24 2003
@@ -252,8 +252,11 @@ int proc_pid_status(struct task_struct *
 		buffer = task_mem(mm, buffer);
 		mmput(mm);
 	}
-	buffer = task_sig(task, buffer);
+	task_lock(task);
+	if (task->sighand)
+		buffer = task_sig(task, buffer);
 	buffer = task_cap(task, buffer);
+	task_unlock(task);
 #if defined(CONFIG_ARCH_S390)
 	buffer = task_show_regs(task, buffer);
 #endif

