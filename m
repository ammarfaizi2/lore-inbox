Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313882AbSEIQgk>; Thu, 9 May 2002 12:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSEIQgk>; Thu, 9 May 2002 12:36:40 -0400
Received: from wiproecmx2.wipro.com ([164.164.31.6]:42635 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S313882AbSEIQgi>; Thu, 9 May 2002 12:36:38 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "Rusty Russell" <rusty@rustcorp.com.au>, <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Hotplug CPU prep III: daemonize idle tasks
Date: Thu, 9 May 2002 17:36:43 +0530
Message-ID: <AAEGIMDAKGCBHLBAACGBAELNCHAA.balbir.singh@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-14d8fbe0-6342-11d6-a942-00b0d0d06be8"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E175jcp-00022d-00@wagner.rustcorp.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-14d8fbe0-6342-11d6-a942-00b0d0d06be8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I tried a version of __daemonize in 2.4. It panics in
schedule()

        prepare_to_switch();
        {
                struct mm_struct *mm = next->mm;
                struct mm_struct *oldmm = prev->active_mm;
                if (!mm) {
                        if (next->active_mm) BUG();

I got hit by the BUG() in 2.4, I think prepare_to_switch has
moved to specific archs in 2.5. A quick look showed that
this issue no longer exists in 2.5.

Comments,
Balbir Singh.

|-----Original Message-----
|From: linux-kernel-owner@vger.kernel.org
|[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Rusty Russell
|Sent: Thursday, May 09, 2002 2:20 PM
|To: torvalds@transmeta.com
|Cc: linux-kernel@vger.kernel.org
|Subject: [PATCH] Hotplug CPU prep III: daemonize idle tasks
|
|
|This patch introduces __daemonize(task), so idle tasks can be detached
|after cloning (required for late creation of idle tasks).
|
|This is independent of the last two patches.
|
|Name: Daemonize idle task
|Author: Rusty Russell
|
|D: This patch allows daemonize() to be called on another process (if
|D: not started yet), and calls it on the idle task.
|
|diff -urN -I \$.*\$ --exclude TAGS -X 
|/home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal 
|working-2.5.14-dofork+clonepid/include/linux/sched.h 
|tmp/include/linux/sched.h
|--- working-2.5.14-dofork+clonepid/include/linux/sched.h	Thu 
|May  9 18:25:21 2002
|+++ tmp/include/linux/sched.h	Thu May  9 18:36:17 2002
|@@ -654,7 +654,12 @@
| extern void exit_sighand(struct task_struct *);
| 
| extern void reparent_to_init(void);
|-extern void daemonize(void);
|+extern void __daemonize(struct task_struct *);
|+static inline void daemonize(void)
|+{
|+	__daemonize(current);
|+}
|+
| extern task_t *child_reaper;
| 
| extern int do_execve(char *, char **, char **, struct pt_regs *);
|diff -urN -I \$.*\$ --exclude TAGS -X 
|/home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal 
|working-2.5.14-dofork+clonepid/kernel/exit.c tmp/kernel/exit.c
|--- working-2.5.14-dofork+clonepid/kernel/exit.c	Mon Apr 29 
|16:00:29 2002
|+++ tmp/kernel/exit.c	Thu May  9 18:36:17 2002
|@@ -201,32 +201,30 @@
|  *	Put all the gunge required to become a kernel thread without
|  *	attached user resources in one place where it belongs.
|  */
|-
|-void daemonize(void)
|+void __daemonize(struct task_struct *tsk)
| {
| 	struct fs_struct *fs;
| 
|-
| 	/*
| 	 * If we were started as result of loading a module, close 
|all of the
| 	 * user space pages.  We don't need them, and if we didn't 
|close them
| 	 * they would be locked into memory.
| 	 */
|-	exit_mm(current);
|+	exit_mm(tsk);
| 
|-	current->session = 1;
|-	current->pgrp = 1;
|-	current->tty = NULL;
|+	tsk->session = 1;
|+	tsk->pgrp = 1;
|+	tsk->tty = NULL;
| 
| 	/* Become as one with the init task */
| 
|-	exit_fs(current);	/* current->fs->count--; */
|+	exit_fs(tsk);	/* current->fs->count--; */
| 	fs = init_task.fs;
|-	current->fs = fs;
|+	tsk->fs = fs;
| 	atomic_inc(&fs->count);
|- 	exit_files(current);
|-	current->files = init_task.files;
|-	atomic_inc(&current->files->count);
|+ 	exit_files(tsk);
|+	tsk->files = init_task.files;
|+	atomic_inc(&tsk->files->count);
| }
| 
| /*
|diff -urN -I \$.*\$ --exclude TAGS -X 
|/home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal 
|working-2.5.14-dofork+clonepid/kernel/sched.c tmp/kernel/sched.c
|--- working-2.5.14-dofork+clonepid/kernel/sched.c	Wed May  1 
|15:09:29 2002
|+++ tmp/kernel/sched.c	Thu May  9 18:45:17 2002
|@@ -1555,6 +1555,8 @@
| 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = 
|cpu_rq(idle->thread_info->cpu);
| 	unsigned long flags;
| 
|+	if (idle != &init_task)
|+		__daemonize(idle);
| 	__save_flags(flags);
| 	__cli();
| 	double_rq_lock(idle_rq, rq);
|
|--
|  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
|-
|To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
|the body of a message to majordomo@vger.kernel.org
|More majordomo info at  http://vger.kernel.org/majordomo-info.html
|Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPartTM-000-14d8fbe0-6342-11d6-a942-00b0d0d06be8
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************
      


Information contained in this E-MAIL being proprietary to Wipro Limited
is 'privileged' and 'confidential' and intended for use only by the
individual or entity to which it is addressed. You are notified that any
use, copying or dissemination of the information contained in the E-MAIL
in any manner whatsoever is strictly prohibited.



 ********************************************************************

------=_NextPartTM-000-14d8fbe0-6342-11d6-a942-00b0d0d06be8--
