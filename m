Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbTBPS4w>; Sun, 16 Feb 2003 13:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbTBPS4w>; Sun, 16 Feb 2003 13:56:52 -0500
Received: from franka.aracnet.com ([216.99.193.44]:10715 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267329AbTBPS4v>; Sun, 16 Feb 2003 13:56:51 -0500
Date: Sun, 16 Feb 2003 11:06:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Fw: 2.5.61 oops running SDET
Message-ID: <26480000.1045422382@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302161017500.2619-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302161017500.2619-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Don't see what I can do for this apart from to invert the ordering and take
>> tasklist_lock around the whole function, and nest task_lock inside that, or
>> I suppose I could take the task_lock for each of the parents? I seem to 
>> recall Linus reminding people recently that it was only the lock 
>> acquisition order that was important, not release ... does something like 
>> the following look OK?
> 
> This patch looks like it should certainly fix the problem, but that is 
> still some god-awful ugly overkill in locking.
> 
> I'd rather make the rule be that you have to take the task lock before 
> modifying things like the parent pointers (and all the other fundamntal 
> pointers), since that's already the rule for most of it anyway.
> 
> And then the tasklist lock would go away _entirely_ from /proc (except for
> task lookup in ->readdir/->lookup, of course, where it is fundamentally
> needed and proper - and will probably some day be replaced by RCU, I
> suspect).

Well, I did the stupid safe thing, and it hangs the box once we get up to 
a load of 32 with SDET. Below is what I did, the only other issue I can
see in here is that task_mem takes mm->mmap_sem which is now nested inside
the task_lock inside tasklist_lock ... but I can't see anywhere that's a
problem from a quick search

diff -urpN -X /home/fletch/.diff.exclude virgin/fs/proc/array.c sdet2/fs/proc/array.c
--- virgin/fs/proc/array.c	Sat Feb 15 16:11:45 2003
+++ sdet2/fs/proc/array.c	Sun Feb 16 09:59:24 2003
@@ -147,11 +147,11 @@ static inline const char * get_task_stat
 	return *p;
 }
 
+/* Call me with the tasklist_lock and task_lock for p held already */
 static inline char * task_state(struct task_struct *p, char *buffer)
 {
 	int g;
 
-	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
 		"Tgid:\t%d\n"
@@ -165,13 +165,10 @@ static inline char * task_state(struct t
 		p->pid && p->ptrace ? p->parent->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
-	read_unlock(&tasklist_lock);	
-	task_lock(p);
 	buffer += sprintf(buffer,
 		"FDSize:\t%d\n"
 		"Groups:\t",
 		p->files ? p->files->max_fds : 0);
-	task_unlock(p);
 
 	for (g = 0; g < p->ngroups; g++)
 		buffer += sprintf(buffer, "%d ", p->groups[g]);
@@ -243,20 +240,22 @@ extern char *task_mem(struct mm_struct *
 int proc_pid_status(struct task_struct *task, char * buffer)
 {
 	char * orig = buffer;
-	struct mm_struct *mm = get_task_mm(task);
 
+	read_lock(&tasklist_lock);
+	task_lock(task);
 	buffer = task_name(task, buffer);
 	buffer = task_state(task, buffer);
  
-	if (mm) {
-		buffer = task_mem(mm, buffer);
-		mmput(mm);
-	}
-	buffer = task_sig(task, buffer);
+	if (task->mm)
+		buffer = task_mem(task->mm, buffer);
+	if (task->sighand)
+		buffer = task_sig(task, buffer);
 	buffer = task_cap(task, buffer);
 #if defined(CONFIG_ARCH_S390)
 	buffer = task_show_regs(task, buffer);
 #endif
+	task_unlock(task);
+	read_unlock(&tasklist_lock);
 	return buffer - orig;
 }
 




