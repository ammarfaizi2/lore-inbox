Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbTBPQaD>; Sun, 16 Feb 2003 11:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267288AbTBPQaD>; Sun, 16 Feb 2003 11:30:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:65185 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267285AbTBPQaA>; Sun, 16 Feb 2003 11:30:00 -0500
Date: Sun, 16 Feb 2003 08:39:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Anton Blanchard <anton@samba.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.5.61 oops running SDET
Message-ID: <21410000.1045413579@[10.10.2.4]>
In-Reply-To: <20030216130558.GL9833@krispykreme>
References: <Pine.LNX.4.44.0302151820200.25000-100000@home.transmeta.com> <11830000.1045368054@[10.10.2.4]> <20030216130558.GL9833@krispykreme>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, I did the following, which is what I think you wanted, plus Zwane's
>> observation that task_state acquires the task_struct lock (we're the only 
>> caller, so I just removed it), but I still get the same panic and this time
>> the box hung. No doubt I've just done something stupid in the patch ...
>> (task_state takes the tasklist_lock ... is that safe to do inside task_lock?)
> 
> It looks like you now try and take the tasklist_lock inside a task_lock()
> region, but task_lock says no-can-do:
> 
> /* Protects ->fs, ->files, ->mm, and synchronises with wait4().  Nests
>  * inside tasklist_lock */
> static inline void task_lock(struct task_struct *p)
> {
> ...

Right, that's what I expected, and that may well explain the hang, but I 
don't see how that explains the oops still happening. What exactly is 
tasklist_lock protecting here anyway?

        read_lock(&tasklist_lock);
        buffer += sprintf(buffer,
                "State:\t%s\n"
                "Tgid:\t%d\n"
                "Pid:\t%d\n"
                "PPid:\t%d\n"
                "TracerPid:\t%d\n"
                "Uid:\t%d\t%d\t%d\t%d\n"
                "Gid:\t%d\t%d\t%d\t%d\n",
                get_task_state(p), p->tgid,
                p->pid, p->pid ? p->real_parent->pid : 0,
                p->pid && p->ptrace ? p->parent->pid : 0,
                p->uid, p->euid, p->suid, p->fsuid,
                p->gid, p->egid, p->sgid, p->fsgid);
        read_unlock(&tasklist_lock);

Is it these two accesses:

p->real_parent->pid ?
p->parent->pid ?

Don't see what I can do for this apart from to invert the ordering and take
tasklist_lock around the whole function, and nest task_lock inside that, or
I suppose I could take the task_lock for each of the parents? I seem to 
recall Linus reminding people recently that it was only the lock 
acquisition order that was important, not release ... does something like 
the following look OK?


diff -urpN -X /home/fletch/.diff.exclude virgin/fs/proc/array.c sdet2/fs/proc/array.c
--- virgin/fs/proc/array.c	Sat Feb 15 16:11:45 2003
+++ sdet2/fs/proc/array.c	Sun Feb 16 08:37:45 2003
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
+	read_unlock(&tasklist_lock);
  
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
 	return buffer - orig;
 }
 




