Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319574AbSH3Opx>; Fri, 30 Aug 2002 10:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319575AbSH3Opx>; Fri, 30 Aug 2002 10:45:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2254 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319574AbSH3Opw>;
	Fri, 30 Aug 2002 10:45:52 -0400
Date: Fri, 30 Aug 2002 09:48:03 +0000
From: Amos Waterland <apw@us.ibm.com>
To: pwaechtler@mac.com
Cc: golbi@mat.uni.torun.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues
Message-ID: <20020830094803.A8283@kvasir.austin.ibm.com>
References: <CDB36B91-BB99-11D6-B9F3-00039387C942@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <CDB36B91-BB99-11D6-B9F3-00039387C942@mac.com>; from pwaechtler@mac.com on Thu, Aug 29, 2002 at 11:53:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 11:53:50PM +0200, pwaechtler@mac.com wrote:
> some comments as asked for:
> 
> I know that it's nowhere stated, but POSIX mqueues are perfectly
> designed to be implemented in userspace with locking facilities
> provided by the system.

I am not sure if this is correct.  You can achieve proper locking in
userspace, but I do not think you achieve proper security. 

I assume you are proposing an implementation based on shared memory:
which means that at least some pages of the shared memory must be
writable.  If the processes cooperate and only write to the shared pages
through library routines which use sychronization, things are ok, but a
malicious process could forge messages or perform DOS attacks etc. by
bypassing the mq_*() functions and using write().

> With PROCESS_SHARED mutexes and condvars in NGPT we have that - and I
> am in the process in converting the mmap() based implementation of
> Richard Stevens in UNPv2 onto Linux.
> 
> The messages are stored in shmem and the library routines access the
> structures with proper locking. I am not very happy about the fact,
> that with futexes the whole cooperating system get stuck when 1
> process crashes inside a critical region (yes, then your system is
> screwed anyway).  BUT the messages are not copied between user- and
> kernelspace like they are in SysV  msgsnd.
> 
> POSIX mqueues have "kernel persistence", i.e. they live until
> mq_unlink() is called.  They do not vanish with the creator on exit().
> Without rlimits you can easily consume all available kernel memory
> (DoS) by creating a mqueue and filling it with garbage.

The mq_maxmsg and mq_msgsize members of the mq_attr structure required
if O_CREAT is passed to mq_open() ensure that an implementation can
prevent the kernel memory DoS you mention: a malicious application can
only fill up the MQ memory.

> When implemented in kernel space, you have to create a thread with the
> brand new sys_clone_startup (or whatever name it gets) as notification
> (SIGEV_THREAD) - which is SCOPE_SYSTEM, no control about this and not
> always what is desired.
