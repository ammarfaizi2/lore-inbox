Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbWHOGgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbWHOGgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbWHOGgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:36:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965216AbWHOGgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:36:50 -0400
Date: Mon, 14 Aug 2006 23:36:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: workqueue lockdep bug.
Message-Id: <20060814233626.1e3c41b2.akpm@osdl.org>
In-Reply-To: <20060814183319.GJ15569@redhat.com>
References: <20060814183319.GJ15569@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 14:33:19 -0400
Dave Jones <davej@redhat.com> wrote:

> Andrew,
>  I merged the workqueue changes from -mm into the Fedora-devel kernel to
> kill off those billion cpufreq lockdep warnings.  The bug has now mutated
> into this:
> 
> (Trimmed version of log from  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=202223)
> 

I don't get it.

> 
>  > Breaking affinity for irq 185
>  > Breaking affinity for irq 193
>  > Breaking affinity for irq 209
>  > CPU 1 is now offline
>  > lockdep: not fixing up alternatives.
>  > 
>  > =======================================================
>  > [ INFO: possible circular locking dependency detected ]
>  > 2.6.17-1.2548.fc6 #1
>  > -------------------------------------------------------
>  > pm-hibernate/4335 is trying to acquire lock:
>  >  ((cpu_chain).rwsem){..--}, at: [<c0430fa4>] blocking_notifier_call_chain+0x11/0x2d
>  > 
>  > but task is already holding lock:
>  >  (workqueue_mutex){--..}, at: [<c0612820>] mutex_lock+0x21/0x24
>  > 
>  > which lock already depends on the new lock.
>  > 
>  > 
>  > the existing dependency chain (in reverse order) is:
>  > 
>  > -> #1 (workqueue_mutex){--..}:
>  >        [<c043c08e>] lock_acquire+0x4b/0x6d
>  >        [<c06126b1>] __mutex_lock_slowpath+0xbc/0x20a
>  >        [<c0612820>] mutex_lock+0x21/0x24
>  >        [<c0433c25>] workqueue_cpu_callback+0xfd/0x1ee
>  >        [<c0614ef5>] notifier_call_chain+0x20/0x31
>  >        [<c0430fb0>] blocking_notifier_call_chain+0x1d/0x2d
>  >        [<c043f4c5>] _cpu_down+0x47/0x1c4
>  >        [<c043f805>] disable_nonboot_cpus+0x9b/0x11a
>  >        [<c0445b32>] prepare_processes+0xe/0x41
>  >        [<c0445d87>] pm_suspend_disk+0x9/0xf3
>  >        [<c0444e12>] enter_state+0x54/0x1b7
>  >        [<c0444ffb>] state_store+0x86/0x9c
>  >        [<c04a9f88>] subsys_attr_store+0x20/0x25
>  >        [<c04aa08c>] sysfs_write_file+0xab/0xd1
>  >        [<c04732cb>] vfs_write+0xab/0x157
>  >        [<c0473910>] sys_write+0x3b/0x60
>  >        [<c0403faf>] syscall_call+0x7/0xb

cpu_add_remove_lock -> cpu_chain.rwsem -> workqueue_mutex

>  > -> #0 ((cpu_chain).rwsem){..--}:
>  >        [<c043c08e>] lock_acquire+0x4b/0x6d
>  >        [<c04390a0>] down_read+0x2d/0x40
>  >        [<c0430fa4>] blocking_notifier_call_chain+0x11/0x2d
>  >        [<c043f5aa>] _cpu_down+0x12c/0x1c4
>  >        [<c043f805>] disable_nonboot_cpus+0x9b/0x11a
>  >        [<c0445b32>] prepare_processes+0xe/0x41
>  >        [<c0445d87>] pm_suspend_disk+0x9/0xf3
>  >        [<c0444e12>] enter_state+0x54/0x1b7
>  >        [<c0444ffb>] state_store+0x86/0x9c
>  >        [<c04a9f88>] subsys_attr_store+0x20/0x25
>  >        [<c04aa08c>] sysfs_write_file+0xab/0xd1
>  >        [<c04732cb>] vfs_write+0xab/0x157
>  >        [<c0473910>] sys_write+0x3b/0x60
>  >        [<c0403faf>] syscall_call+0x7/0xb

cpu_add_remove_lock -> cpu_chain.rwsem

>  > other info that might help us debug this:
>  > 
>  > 2 locks held by pm-hibernate/4335:
>  >  #0:  (cpu_add_remove_lock){--..}, at: [<c0612820>] mutex_lock+0x21/0x24
>  >  #1:  (workqueue_mutex){--..}, at: [<c0612820>] mutex_lock+0x21/0x24
>  > 
>  > stack backtrace:
>  >  [<c04051ee>] show_trace_log_lvl+0x58/0x159
>  >  [<c04057ea>] show_trace+0xd/0x10
>  >  [<c0405903>] dump_stack+0x19/0x1b
>  >  [<c043b176>] print_circular_bug_tail+0x59/0x64
>  >  [<c043b98e>] __lock_acquire+0x80d/0x99c
>  >  [<c043c08e>] lock_acquire+0x4b/0x6d
>  >  [<c04390a0>] down_read+0x2d/0x40
>  >  [<c0430fa4>] blocking_notifier_call_chain+0x11/0x2d
>  >  [<c043f5aa>] _cpu_down+0x12c/0x1c4
>  >  [<c043f805>] disable_nonboot_cpus+0x9b/0x11a
>  >  [<c0445b32>] prepare_processes+0xe/0x41
>  >  [<c0445d87>] pm_suspend_disk+0x9/0xf3
>  >  [<c0444e12>] enter_state+0x54/0x1b7
>  >  [<c0444ffb>] state_store+0x86/0x9c
>  >  [<c04a9f88>] subsys_attr_store+0x20/0x25
>  >  [<c04aa08c>] sysfs_write_file+0xab/0xd1
>  >  [<c04732cb>] vfs_write+0xab/0x157
>  >  [<c0473910>] sys_write+0x3b/0x60
>  >  [<c0403faf>] syscall_call+0x7/0xb

cpu_add_remove_lock -> cpu_chain.rwsem

I don't see anywhere where this process took workqueue_mutex.

>  > DWARF2 unwinder stuck at syscall_call+0x7/0xb

bah.


