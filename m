Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTDGJ0E (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 05:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTDGJ0E (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 05:26:04 -0400
Received: from [12.47.58.191] ([12.47.58.191]:54249 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263359AbTDGJ0D (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 05:26:03 -0400
Date: Mon, 7 Apr 2003 02:37:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, maneesh@in.ibm.com,
       dipankar@in.ibm.com, viro@math.psu.edu
Subject: Re: [PATCH, RFC] tasklist_lock/dcache_lock race bugfix
Message-Id: <20030407023734.02b99056.akpm@digeo.com>
In-Reply-To: <3E9086BB.4080403@colorfullife.com>
References: <3E9086BB.4080403@colorfullife.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 09:37:31.0600 (UTC) FILETIME=[4FC9CD00:01C2FCE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> __unhash_process acquires the dcache_lock while holding the 
> tasklist_lock for writing. This can deadlock. While trying to fix that 
> race, I found further races with proc_dentry.
> The attached patch (hopefully) fixes all these races.
> 
> Changes:
> - fs/proc/base.c assumed that p->pid is reset to 0 during exit. This is 
> not the case anymore. I now look at the count of the pid structure for 
> PIDTYPE_PID.
> - pid_delete_dentry and pid_revalidate removed. The implementation 
> didn't work, and noone complained.
> - only d_add the new proc entry if the task is still valid: d_add+d_drop 
> is a race, if a lookup happens between both calls.
> - add a new spinlock that protects proc_dentry.

Did you send the correct patch?

kernel/exit.c: In function `release_task':
kernel/exit.c:59: warning: implicit declaration of function `proc_pid_unhash'
kernel/exit.c:59: warning: assignment makes pointer from integer without a cast
kernel/exit.c:86: warning: implicit declaration of function `proc_pid_flush'
kernel/exit.c: In function `unhash_process':
kernel/exit.c:95: warning: `proc_dentry' might be used uninitialized in this function
fs/exec.c: In function `de_thread':
fs/exec.c:641: warning: implicit declaration of function `proc_pid_unhash'
fs/exec.c:641: warning: assignment makes pointer from integer without a cast
fs/exec.c:642: warning: assignment makes pointer from integer without a cast
fs/exec.c:685: warning: implicit declaration of function `proc_pid_flush'

and an oops at boot:

Program received signal SIGEMT, Emulation trap.
select_parent (parent=0x1) at fs/dcache.c:540
540                     next = tmp->next;
(gdb) p tmp
No symbol "tmp" in current context.
(gdb) p next
$1 = (struct list_head *) 0x87f000fe
(gdb) bt
#0  select_parent (parent=0x1) at fs/dcache.c:540
#1  0xc01624e0 in shrink_dcache_parent (parent=0x1) at fs/dcache.c:590
#2  0xc017a8bd in proc_pid_flush (proc_dentry=0x1) at fs/proc/base.c:1129
#3  0xc0120a53 in unhash_process (p=0xc8db6660) at kernel/exit.c:102
#4  0xc03d188f in do_boot_cpu (apicid=0) at arch/i386/kernel/smpboot.c:805
#5  0xc03d1b53 in smp_boot_cpus (max_cpus=4) at arch/i386/kernel/smpboot.c:1040
#6  0xc03d1d58 in smp_prepare_cpus (max_cpus=4) at arch/i386/kernel/smpboot.c:1125
#7  0xc0105098 in init (unused=0x0) at init/main.c:563

