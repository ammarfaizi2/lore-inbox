Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTELIKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 04:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTELIKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 04:10:40 -0400
Received: from mxintern.kundenserver.de ([212.227.126.204]:59086 "EHLO
	mxintern.kundenserver.de") by vger.kernel.org with ESMTP
	id S261998AbTELIKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 04:10:36 -0400
Date: Mon, 12 May 2003 10:25:12 +0200
From: Dominik Vogt <dominik.vogt@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Bug: MM Oops in 2.4.20
Message-ID: <20030512082512.GA18352@gmx.de>
Reply-To: dominik.vogt@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4.20 (and earlier kernels, at least 2.4.19 and 2.4.18) have
a bug that causes an Oops (NULL pointer dereference) when a
process A "exec"s while some other process B reads A's
/proc/<pid-A>/maps file.

This code is from fs/exec.c, function exec_mmap():

 A1	old_mm = current->mm;
 A2	if (old_mm && atomic_read(&old_mm->mm_users) == 1) {
 A3		mm_release();
 A4		exit_mmap(old_mm);
 A5		return 0;
 A6	}

And this is from fs/proc/array.c, function proc_pid_read_maps():

 B1	task_lock(task);
 B2	mm = task->mm;
 B3	if (mm)
 B4		atomic_inc(&mm->mm_users);
 B5	task_unlock(task);

Let's assume process A just called execve() and its mm->mm_users
is one.  Process A has already executed the test in A2 when a
timer interrupt schedules process B ("cat /proc/<pid-A>/maps").
Now, process B grabs the mm structure of process A, increases the
mm_users counter and continues to access it.  Later, process A
resumes execution and calls exit_mmap(), destroying the structure
that is still used by B.

In our specific case, we get a NULL pointer dereference in
proc_pid_maps_get_line():

  dev = map->vm_file->f_dentry->d_inode->i_dev;

because vm_file is in the free_list and f_dentry is NULL.  On our
site, we get about one Oops every 2 days on 200 machines (runnig
lsof and a concurrent "exec uptime" once a minute).

--

In some places in the code, specifically in fs/proc, accessing
mm->mm_users or mm->map is protected with a task_(un)lock, while
it is not protected at all in many other places, e.g. schedule(),
exec_mmap(), flush_tlb_mm() (in arch/alpha/kernel/smp.c), ...

We were able to stabilize our systems by protecting the above code
from fs/exec.c with task_lock() and task_unlock(), but I am quite
sure this patch is not sufficient.  Also, there are many other
places in the proc fs that have similar code as the one in
proc_pid_read_maps(), so the problem should occur in many other
situations too.

Bye

Dominik ^_^  ^_^

P.S.: Please cc me.
