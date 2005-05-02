Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVEBQh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVEBQh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVEBQeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:34:37 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:38862 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261465AbVEBQdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:33:44 -0400
Subject: Re: scheduler/SCHED_FIFO behaviour
From: Steven Rostedt <rostedt@goodmis.org>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY10-F2709F2A16EEE74732F797FD9270@phx.gbl>
References: <BAY10-F2709F2A16EEE74732F797FD9270@phx.gbl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 02 May 2005 12:33:17 -0400
Message-Id: <1115051597.5081.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-02 at 10:57 +0530, Arun Srinivas wrote:
> The 2 processes which I  am measuring  are parent and child processes.I want 
> both of'em to be scheduled at the same time.My code simply does the 
> following:
> 
> 1) From main(i.e., parent) create a shared memory seg. using shmget() and 
> shmat(). This is for communication between parent and child. I am trying to 
> use this as a locking mechanism to make them tightly coupled so that one 
> does not race before the other.
> 2) create child by fork() and call shmat() to attach this segment to child 
> too
> 3) In parent and child call ioctl() to pass their PID's from user space to 
> kernel space...so that I can measure when the particular PID's are scheduled 
> in the scheduler
> 
> I suppose shmget() dosent use a system call.So still confused about the 
> occasional resechedule behavior.

Uhh, yes it does:

$ vi shmget.c

i
#include <sys/ipc.h>
#include <sys/shm.h>

int main()
{
        shmget(123,123,0);
        return 0;
}
:wq

$ gcc -o shmget shmget.c
$ strace ./shmget
[snip]
  shmget(123, 123, 0)                     = -1 ENOENT (No such file or directory)
[snip]
---

So it is a system call.  

Now, I still don't know when you are using your locking (which is also a
system call) to run your code.  A child is usually added to the same run
queue as the parent.  So this means that it will be scheduled on the
same CPU as the parent. But if the other CPU scheduler notices that the
scheduling of processes on the CPUs are unbalanced, then it will pull
tasks from one CPU to the other. But once the tasks are running as
SCHED_FIFO on different CPUs, then they shouldn't be preempted.

BUT!!!

looking at the system call code for shmget:

asmlinkage long sys_shmget (key_t key, size_t size, int shmflg)
{
	struct shmid_kernel *shp;
	int err, id = 0;

	down(&shm_ids.sem);  ==========>>>>> Here we can schedule
	if (key == IPC_PRIVATE) {
		err = newseg(key, shmflg, size);
	} else if ((id = ipc_findkey(&shm_ids, key)) == -1) {
		if (!(shmflg & IPC_CREAT))
			err = -ENOENT;
		else
			err = newseg(key, shmflg, size);
	} else if ((shmflg & IPC_CREAT) && (shmflg & IPC_EXCL)) {
		err = -EEXIST;
	} else {
		shp = shm_lock(id);
		if(shp==NULL)
			BUG();
		if (shp->shm_segsz < size)
			err = -EINVAL;
		else if (ipcperms(&shp->shm_perm, shmflg))
			err = -EACCES;
		else {
			int shmid = shm_buildid(id, shp->shm_perm.seq);
			err = security_shm_associate(shp, shmflg);
			if (!err)
				err = shmid;
		}
		shm_unlock(shp);
	}
	up(&shm_ids.sem);

	return err;
}


So, if both the parent and child are going for the same shared memory,
you can cause one to schedule.

-- Steve


