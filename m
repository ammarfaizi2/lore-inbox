Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbUEEGAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUEEGAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 02:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUEEGAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 02:00:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:16286 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262142AbUEEGAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 02:00:14 -0400
Date: Tue, 4 May 2004 22:59:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com, pj@sgi.com
Subject: Re: (resend) take3: Updated CPU Hotplug patches for IA64 (pj
 blessed) Patch [6/7]
Message-Id: <20040504225907.6c2fe459.akpm@osdl.org>
In-Reply-To: <20040504211755.A13286@unix-os.sc.intel.com>
References: <20040504211755.A13286@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
>  Name: cpu_present_map.patch

This does not play happily with the sched_domains patches.


Program received signal SIGEMT, Emulation trap.
task_rq_lock (p=0x0, flags=0xcff98ee8) at include/linux/sched.h:1087
1087            return p->thread_info->cpu;
(gdb) bt
#0  task_rq_lock (p=0x0, flags=0xcff98ee8) at include/linux/sched.h:1087
#1  0xc01187cd in try_to_wake_up (p=0x0, state=7, sync=0) at kernel/sched.c:844
#2  0xc0118a1d in wake_up_process (p=0x0) at kernel/sched.c:981
#3  0xc011b688 in cpu_attach_domain (sd=0xc120b060, cpu=-805728492) at kernel/sched.c:3804
#4  0xc05db60b in arch_init_sched_domains () at arch/i386/kernel/smpboot.c:1327
#5  0xc05dfb44 in sched_init_smp () at kernel/sched.c:4013
#6  0xc010045d in init (unused=0x0) at init/main.c:643
#7  0xc010428d in kernel_thread_helper () at arch/i386/kernel/process.c:246
(gdb) p cpu_online_map
$1 = 1
(gdb) f 3
#3  0xc011b688 in cpu_attach_domain (sd=0xc120b060, cpu=-805728492) at kernel/sched.c:3804
3804                    wake_up_process(rq->migration_thread);
(gdb) p cpu
$2 = -805728492
(gdb) up
#4  0xc05db60b in arch_init_sched_domains () at arch/i386/kernel/smpboot.c:1327
1327                    cpu_attach_domain(cpu_domain, i);
(gdb) p i
$3 = 1
(gdb) info thr
  5 Thread 32769 (swapper)  start_secondary (unused=0x0) at arch/i386/kernel/smpboot.c:446
* 4 Thread 32768 (swapper)  0xc0398ae1 in schedule () at kernel/sched.c:1198
  3 Thread 3 (ksoftirqd/0)  0xc0398ae1 in schedule () at kernel/sched.c:1198
  2 Thread 2 (migration/0)  migration_thread (data=0x0) at include/asm/current.h:10
  1 Thread 1 (swapper)  task_rq_lock (p=0x0, flags=0xcff98ee8) at include/linux/sched.h:1087
(gdb) 


It appears that x86's arch_init_sched_domains() is blindly assuming that
each CPU's migration thread is running and is pointed to by
rq->migration_thread.  But from the above you'll see that CPU0's migration
thread is running, but CPU1's has never been created, hence the
null-pointer deref.

I'll drop this final patch.  Please reissue it against next -mm.  Thanks.
