Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbTBPCAR>; Sat, 15 Feb 2003 21:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbTBPCAR>; Sat, 15 Feb 2003 21:00:17 -0500
Received: from franka.aracnet.com ([216.99.193.44]:8841 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265589AbTBPCAO>; Sat, 15 Feb 2003 21:00:14 -0500
Date: Sat, 15 Feb 2003 18:09:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.5.61 oops running SDET
Message-ID: <67320000.1045361394@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302151723560.23951-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302151723560.23951-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, but I think the bug has existed for much longer. 
> 
> It looks like "proc_pid_status()" doesn't actually lock the task at all, 
> nor even bother to test whether the task has signal state. Which has 
> _always_ been a bug. I don't know why it would start happening now, but
> it  might just be unlucky timing.
> 
> I think the proper fix is to put a 
> 
> 	task_lock()
> 	..
> 	task_unlock()
> 
> around the whole proc_pid_status() function, _and_ then verify that 
> "tsk->sighand" is non-NULL.
> 
> (Oh, careful, that's already what "get_task_mm()" does internally, so
> look  out for deadlocks - you'd need to open-code the get_task_mm() in
> there  too, so the end result is something like
> 
> 	task_lock(task)
> 	if (task->mm) {
> 		.. mm state
> 	}
> 	if (task->sighand) {
> 		.. signal state
> 	}
> 	..
> 	task_unlock(task);
> 
> instead).

Something like this? Compiles, but not tested yet ...

diff -urpN -X /home/fletch/.diff.exclude virgin/fs/proc/array.c
proc/fs/proc/array.c
--- virgin/fs/proc/array.c	Sat Feb 15 16:11:45 2003
+++ proc/fs/proc/array.c	Sat Feb 15 18:05:10 2003
@@ -243,8 +243,10 @@ extern char *task_mem(struct mm_struct *
 int proc_pid_status(struct task_struct *task, char * buffer)
 {
 	char * orig = buffer;
-	struct mm_struct *mm = get_task_mm(task);
+	struct mm_struct *mm;
 
+	task_lock(task);
+	mm = __get_task_mm(task);
 	buffer = task_name(task, buffer);
 	buffer = task_state(task, buffer);
  
@@ -257,6 +259,7 @@ int proc_pid_status(struct task_struct *
 #if defined(CONFIG_ARCH_S390)
 	buffer = task_show_regs(task, buffer);
 #endif
+	task_unlock(task);
 	return buffer - orig;
 }
 
diff -urpN -X /home/fletch/.diff.exclude virgin/include/linux/sched.h
proc/include/linux/sched.h
--- virgin/include/linux/sched.h	Sat Feb 15 16:11:47 2003
+++ proc/include/linux/sched.h	Sat Feb 15 18:04:42 2003
@@ -706,6 +706,18 @@ static inline struct mm_struct * get_tas
 
 	return mm;
 }
+
+/* lockless version of get_task_mm */
+static inline struct mm_struct * __get_task_mm(struct task_struct * task)
+{
+	struct mm_struct * mm;
+ 
+	mm = task->mm;
+	if (mm)
+		atomic_inc(&mm->mm_users);
+
+	return mm;
+}
  
  
 /* set thread flags in other task's structures

