Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbSKGSNO>; Thu, 7 Nov 2002 13:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSKGSNO>; Thu, 7 Nov 2002 13:13:14 -0500
Received: from bothawui.bothan.net ([66.92.184.160]:20689 "HELO
	bothawui.bothan.net") by vger.kernel.org with SMTP
	id <S261360AbSKGSNN>; Thu, 7 Nov 2002 13:13:13 -0500
Date: Thu, 7 Nov 2002 10:19:49 -0800 (PST)
From: Drew Hess <dhess@bothan.net>
To: linux-kernel@vger.kernel.org
Subject: Querying mm's from a module
Message-ID: <Pine.LNX.4.21.0211071011310.11645-100000@bothawui.bothan.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I asked this on kernelnewbies but got no response.  Hopefully someone on
lkml can educate me.

I have a module that wants to query a task's mm.  I'm developing this
module for 2.4.18+ kernels.  I tried to implement this using fine-grained
locking ala fs/proc/array.c.  In the following code, mem is a struct that
contains the pid of the task I want to query, and a vmsize field where
total_vm is stored (in kbytes, which explains the shifting):

        /* version 1 */
	struct task_struct * task;
	struct mm_struct * mm;

	read_lock (&tasklist_lock);
	task = find_task_by_pid (mem->pid);
	if (task)
		get_task_struct (task);
	read_unlock (&tasklist_lock);
	if (!task)
		return -EINVAL;
	
	task_lock (task);
	mm = task->mm;

	if (mm)
		atomic_inc (&mm->mm_users);
	task_unlock (task);
	free_task_struct (task);
	if (!mm)
		return -EINVAL;

	down_read (&mm->mmap_sem);
	mem->vmsize = mm->total_vm << (PAGE_SHIFT-10);
	up_read (&mm->mmap_sem);
	mmput (mm);

Unfortunately, it looks like mmput isn't exported to module space.

If I change the code to use just the tasklist_lock, like this:

        /* version 2 */
        int ret;
	struct task_struct * task;
	struct mm_struct * mm;

        ret = -EINVAL;
	read_lock (&tasklist_lock);
	task = find_task_by_pid (mem->pid);
	if (!task)
		goto out;
	
	mm = task->mm;

	if (!mm)
	        goto out;
	mem->vmsize = mm->total_vm << (PAGE_SHIFT-10);
        ret = 0;

out:
	read_unlock (&tasklist_lock);
	return ret;


will this work?  What prevents mm from going away while I'm holding
tasklist_lock?  Version 2 of my code is based on mm/oom_kill.c, so I'd
expect it to be safe, but glancing at do_exit and __exit_mm, I can't see
what prevents the following execution on an SMP machine, where p1 is
running my module (or oom_kill) and p2 is running do_exit():

        p1: mm = task->mm;
	p2: __exit_mm (tsk); <-- assume tsk is the same task that p1 is
	                         examining.
                             <-- after __exit_mm's mmput, mm may have been
			         deallocated
	p1: mem->vmsize = mm->total_vm << (PAGE_SHIFT-10);
	                     <-- boom, if mm was deallocated by
			         __exit_mm on p2


Looks to me like anyone who's trying to do something with mm should be
doing a task_lock + atomic_inc(mm->mm_users) + task_unlock + mmput(mm)
sequence, but that doesn't appear to be the case in mm/oom_kill.c.  And it
doesn't look like tasklist_lock is held when do_exit calls __exit_mm, so I
don't understand how oom_kill is safe. What am I missing?


thanks!
-dwh-




