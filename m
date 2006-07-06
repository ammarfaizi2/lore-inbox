Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbWGFJTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbWGFJTa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWGFJTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:19:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:49859 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965166AbWGFJT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:19:29 -0400
Date: Thu, 6 Jul 2006 14:51:04 +0530
From: Sripathi Kodi <sripathik@in.ibm.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] Crash due to recursive locking on -rt
Message-ID: <20060706092104.GA13973@in.ibm.com>
Reply-To: sripathik@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

We are seeing a crash due to recursive locking on -rt kernels. This was seen
on 2.6.16-rt22 with some additional patches, but relevant code in 2.6.17-rt7
looks similar, hence the problem could be present there as well.

Backtrace is:
crash> bt
PID: 13306  TASK: f7c10230  CPU: 3   COMMAND: "jxeinajar"
 #0 [f69e39bc] crash_kexec at c013a9d8
 #1 [f69e3a08] die at c01039b2
 #2 [f69e3a40] do_invalid_op at c0103bc1
 #3 [f69e3afc] error_code (via invalid_op) at c0103329
    EAX: 00000020  EBX: f69e2000  ECX: f69e3b38  EDX: c0326542  EBP: 00000e20 
    DS:  007b      ESI: c90b8560  ES:  007b      EDI: 00000020 
    CS:  0060      EIP: c03106d7  ERR: ffffffff  EFLAGS: 00010086 
 #4 [f69e3b30] rt_lock_slowlock at c03106d7
 #5 [f69e3b88] __kmalloc at c01591f1
 #6 [f69e3b9c] soft_cursor at c01da620
 #7 [f69e3bcc] bit_cursor at c01da4c6
 #8 [f69e3c5c] fbcon_cursor at c01d6752
 #9 [f69e3c90] hide_cursor at c0213beb
#10 [f69e3c98] vt_console_print at c0216058
#11 [f69e3cb4] __call_console_drivers at c011d422
#12 [f69e3cc8] call_console_drivers at c011d54c
#13 [f69e3cdc] release_console_sem at c011d935
#14 [f69e3cec] vprintk at c011d850
#15 [f69e3d54] printk at c011d641
#16 [f69e3d60] check_wakeup_timing at c013d973
#17 [f69e3da4] trace_stop_sched_switched at c013daa3
#18 [f69e3db4] __schedule at c030fa64
#19 [f69e3e00] schedule at c030fb92
#20 [f69e3e0c] rt_lock_slowlock at c0310742
#20 [f69e3e0c] rt_lock_slowlock at c0310742
#21 [f69e3e58] cache_alloc_refill at c0158dff
#22 [f69e3e7c] kmem_cache_alloc at c015913a
#23 [f69e3e90] refill_pi_state_cache at c0130d8d
#24 [f69e3ea4] futex_lock_pi at c0131d0e
#25 [f69e3f78] do_futex at c013288b
#26 [f69e3f90] sys_futex at c0132918
#27 [f69e3fb8] sysenter_entry at c01027c0
    EAX: 000000f0  EBX: b7f4b924  ECX: 00000006  EDX: 00000001 
    DS:  007b      ESI: 00000000  ES:  007b      EDI: 4e18fff4 
    SS:  007b      ESP: b7728314  EBP: b7728338 
    CS:  0073      EIP: ffffe410  ERR: 000000f0  EFLAGS: 00000202 

This is what I have understood about the problem:

Crash is due to this BUG_ON in rt_lock_slowlock:

        /* Try to acquire the lock again: */
        if (try_to_take_rt_mutex(lock __IP__)) {
                spin_unlock(&lock->wait_lock);
                return;
        }

        BUG_ON(rt_mutex_owner(lock) == current);  <-- BUG is called here (Line no. 639)

At frame 22, we see kmem_cache_alloc. It holds a spinlock by going through
the following call chain:
kmem_cache_alloc -> __cache_alloc -> slab_irq_save -> slab_irq_disable -> get_cpu_var_locked. 
This holds spin_lock(&__get_cpu_lock(var, __cpu)); 
After this, it has gone on to call ____cache_alloc -> cache_alloc_refill.

Further up in the backtrace, __schedule tries to stop tracing wakeup timings
(frame 17-18) and this results in a call to printk, which eventually ends up in
__kmalloc -> __do_kmalloc -> __cache_alloc and it tries to hold the same spin lock.

It looks like this problem may not have happened if CONFIG_WAKEUP_TIMING was
not enabled in kernel config. However, that is not the root cause of the problem.

Any ideas about this problem? It is not easy to recreate this problem, but I have
a kdump from an earlier crash.

Thanks,
Sripathi Kodi.
