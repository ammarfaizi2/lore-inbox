Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319147AbSH2JDT>; Thu, 29 Aug 2002 05:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319149AbSH2JDT>; Thu, 29 Aug 2002 05:03:19 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:48364 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S319147AbSH2JDS>; Thu, 29 Aug 2002 05:03:18 -0400
Message-ID: <20020829090739.18655.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Thu, 29 Aug 2002 11:07:39 +0200
To: Burton Windle <bwindle@fint.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kpreempt-tech@lists.sourceforge.net, mingo@elte.hu, rml@tech9.net
Subject: Re: 2.5.32: DEBUG_SLAB and PREEMPT = constant oops in schedule()
References: <Pine.LNX.4.43.0208280944080.1736-100000@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0208280944080.1736-100000@morpheus>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wed, Aug 28, 2002 at 10:16:23AM -0400, Burton Windle wrote:
> When running the Linux Test Project's process_stress test on 2.5.32 that
> is compiled with DEBUG_SLAB and PREEMPT, I am able to easily reproduce
> this oops. Undef either of the above kernel options, and the system is
> stable again.

This looks like the following is happening:

Task 1 (do_exit)                  Task 2 (parent of task 1, sys_wait4)
set task state to TASK_ZOMBIE
preempt before the final schedule
                                  Picks up exit status and finally calls
                                  release_task this effectivly frees the
                                  task structure of task 1 (while it
                                  is still on the runqueue.

                                  schedule (); tries to switch back to
                                  task 1 -> BOOM

Note that this is not preempt-only, it can happen on plain SMP as
well.

There are other paths that do suspicious things with task struct
accounting, e.g.

sys_sched_setaffinity, lines:
   1571         get_task_struct(p);
   1572         read_unlock(&tasklist_lock);
   1573 
   1574         retval = -EPERM;
   1575         if ((current->euid != p->euid) && (current->euid != p->uid) &&
   1576                         !capable(CAP_SYS_NICE))
   1577                 goto out_unlock;
   1578 
   1579         retval = 0;
   1580         set_cpus_allowed(p, new_mask);
   1581 
   1582 out_unlock:
   1583         put_task_struct(p);

Line 1571 calls get_task_struct because the task might exit during
the syscall. Suppose that this is exactly what happens. This means
that line 1583 will effectivly free the task. But set_cpus_allowed
stuffed a pointer to the task into a request struct without incrementing
the usage count of the task struct.

> Unable to handle kernel paging request at virtual address 5a5a5ace
> c010ecaf
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0060:[<c010ecaf>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010817
> eax: c9a92000   ebx: c9fd3760   ecx: c9b81288   edx: 5a5a5a5a
> esi: c9b863ec   edi: c9fd31e0   ebp: c9a93ee0   esp: c9a93ec8
> ds: 0068   es: 0068   ss: 0068
> Stack: 7fffffff c9b863ec c9a93f60 c9fd31e0 00000282 c9a92000 c405d000 c0117e10
>        00000008 c9b863ec 080dc050 00000246 c405d980 c9b863ec c01b51e4 c01b5234
>        c405d000 c9b863ec c9d8c5ec c9b8640c c405d980 c405dbfc 00000000 7fffffff
> Call Trace: [<c0117e10>] [<c01b51e4>] [<c01b5234>] [<c010ee2c>] [<c010ee2c>]
>    [<c01b1294>] [<c0132a1b>] [<c0132bf6>] [<c010725f>]
> Code: 0f ba 6a 74 00 8b 42 0c 05 00 00 00 40 0f 22 d8 8b 82 98 00
> 
> 
> >>EIP; c010ecaf <schedule+18f/2a8>   <=====
> 
> Trace; c0117e10 <schedule_timeout+14/a4>
> Trace; c01b51e4 <read_chan+354/74c>
> Trace; c01b5234 <read_chan+3a4/74c>
> Trace; c010ee2c <default_wake_function+0/34>
> Trace; c010ee2c <default_wake_function+0/34>
> Trace; c01b1294 <tty_read+d0/128>
> Trace; c0132a1b <vfs_read+b7/138>
> Trace; c0132bf6 <sys_read+2a/3c>
> Trace; c010725f <syscall_call+7/b>
> 
> Code;  c010ecaf <schedule+18f/2a8>
> 00000000 <_EIP>:
> Code;  c010ecaf <schedule+18f/2a8>   <=====
>    0:   0f ba 6a 74 00            btsl   $0x0,0x74(%edx)   <=====
> Code;  c010ecb4 <schedule+194/2a8>
>    5:   8b 42 0c                  mov    0xc(%edx),%eax
> Code;  c010ecb7 <schedule+197/2a8>
>    8:   05 00 00 00 40            add    $0x40000000,%eax
> Code;  c010ecbc <schedule+19c/2a8>
>    d:   0f 22 d8                  mov    %eax,%cr3
> Code;  c010ecbf <schedule+19f/2a8>
>   10:   8b 82 98 00 00 00         mov    0x98(%edx),%eax
> 
> Linux razor 2.5.32 #5 Wed Aug 28 09:21:53 EST 2002 i686 unknown unknown GNU/Linux

    regards   Christian

