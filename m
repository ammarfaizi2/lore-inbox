Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUHWWrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUHWWrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUHWWol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:44:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37799 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S267620AbUHWWOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:14:44 -0400
Subject: Re: 2.6.8.1-mm4 - more cpu hotplug breakage
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20040822013402.5917b991.akpm@osdl.org>
References: <20040822013402.5917b991.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1093299523.5284.70.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 17:18:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

In both 2.6.8.1-mm3 and -mm4, a task which tries to offline a cpu
becomes permanently hung, seemingly because the high-priority per-cpu
kernel threads which __stop_machine_run starts never get to run.  I did
a bisection search on the 2.6.8.1-mm4 patch series and narrowed it down
to one of these three patches, listed below along with their behavior
when trying to offline a cpu:

191: sched-smt-fixes.patch     - panic
192: sched-smt-fixes-fix.patch - panic
193: nicksched.patch           - process hangs

The panics are of the sort:
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

...without any other information, except I do know that the cpu has been
taken offline.

At 190 (sched-self-reap-fix) and before in the patch series, offlining a
cpu just works.  For 193 and after, the task hangs.  Inserting printk's
I managed to determine that stop_machine() never gets out of this loop:

        /* Wait for them all to come to life. */
        while (atomic_read(&stopmachine_thread_ack) != stopmachine_num_threads)
                yield();

The task hang happens regardless of the setting of CONFIG_PREEMPT.

SysRq-t output and .config follow:

SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 0000000000000000  7944     1      0     2               (NOTLB)
Call Trace:
[c00000027ff03710] [0000000000000010] 0x10 (unreliable)
[c00000027ff038e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027ff03970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027ff03a90] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027ff03b70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027ff03cb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027ff03dc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027ff03e30] [c000000000011e00] syscall_exit+0x0/0x18
migration/0   S 0000000000000000 14096     2      1             3       (L-TLB)
Call Trace:
[c00000027ff2fa90] [c00000027ff2fab0] 0xc00000027ff2fab0 (unreliable)
[c00000027ff2fc60] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027ff2fcf0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027ff2fe10] [c00000000004d8b0] .migration_thread+0x13c/0x33c
[c00000027ff2fed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027ff2ff90] [c0000000000194c4] .kernel_thread+0x4c/0x68
ksoftirqd/0   S 0000000000000000 14752     3      1             4     2 (L-TLB)
Call Trace:
[c00000027ff37c70] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027ff37d00] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027ff37e20] [c00000000005aa08] .ksoftirqd+0x1f8/0x200
[c00000027ff37ed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027ff37f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
migration/1   S 0000000000000000 13848     4      1             5     3 (L-TLB)
Call Trace:
[c00000027ff3ba90] [c00000027ff3bab0] 0xc00000027ff3bab0 (unreliable)
[c00000027ff3bc60] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027ff3bcf0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027ff3be10] [c00000000004d8b0] .migration_thread+0x13c/0x33c
[c00000027ff3bed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027ff3bf90] [c0000000000194c4] .kernel_thread+0x4c/0x68
ksoftirqd/1   S 0000000000000000 14848     5      1             6     4 (L-TLB)
Call Trace:
[c00000027ff6fc70] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027ff6fd00] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027ff6fe20] [c00000000005aa08] .ksoftirqd+0x1f8/0x200
[c00000027ff6fed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027ff6ff90] [c0000000000194c4] .kernel_thread+0x4c/0x68
migration/2   R  running task   14288     6      1             7     5 (L-TLB)
ksoftirqd/2   S 0000000000000000 14928     7      1             8     6 (L-TLB)
Call Trace:
[c00000027fe2bc70] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fe2bd00] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fe2be20] [c00000000005aa08] .ksoftirqd+0x1f8/0x200
[c00000027fe2bed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fe2bf90] [c0000000000194c4] .kernel_thread+0x4c/0x68
migration/3   S 0000000000000000 14912     8      1             9     7 (L-TLB)
Call Trace:
[c00000027fe2fc60] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fe2fcf0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fe2fe10] [c00000000004d8b0] .migration_thread+0x13c/0x33c
[c00000027fe2fed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fe2ff90] [c0000000000194c4] .kernel_thread+0x4c/0x68
ksoftirqd/3   S 0000000000000000 14848     9      1            10     8 (L-TLB)
Call Trace:
[c00000027fe67c70] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fe67d00] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fe67e20] [c00000000005aa08] .ksoftirqd+0x1f8/0x200
[c00000027fe67ed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fe67f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
events/0      S 0000000000000000 11520    10      1    14      11     9 (L-TLB)
Call Trace:
[c00000027fe6ba10] [c00000027fe6baa0] 0xc00000027fe6baa0 (unreliable)
[c00000027fe6bbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fe6bc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fe6bd90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fe6bed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fe6bf90] [c0000000000194c4] .kernel_thread+0x4c/0x68
events/1      S 0000000000000000 12608    11      1  4695      12    10 (L-TLB)
Call Trace:
[c00000027fe7ba10] [0000000028000022] 0x28000022 (unreliable)
[c00000027fe7bbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fe7bc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fe7bd90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fe7bed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fe7bf90] [c0000000000194c4] .kernel_thread+0x4c/0x68
events/2      R  running task   14144    12      1            13    11 (L-TLB)
events/3      S 0000000000000000 14144    13      1            45    12 (L-TLB)
Call Trace:
[c00000027fe87a10] [c00000027fe87aa0] 0xc00000027fe87aa0 (unreliable)
[c00000027fe87be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fe87c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fe87d90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fe87ed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fe87f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
khelper       S 0000000000000000 11376    14     10            27       (L-TLB)
Call Trace:
[c00000027fe93a10] [0000000000000078] 0x78 (unreliable)
[c00000027fe93be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fe93c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fe93d90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fe93ed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fe93f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
kblockd/0     S 0000000000000000 13416    27     10            28    14 (L-TLB)
Call Trace:
[c00000027fc3fa10] [c00000027fc3faa0] 0xc00000027fc3faa0 (unreliable)
[c00000027fc3fbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fc3fc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fc3fd90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fc3fed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fc3ff90] [c0000000000194c4] .kernel_thread+0x4c/0x68
kblockd/1     S 0000000000000000 13072    28     10            29    27 (L-TLB)
Call Trace:
[c00000027fc4ba10] [c00000027fc4baa0] 0xc00000027fc4baa0 (unreliable)
[c00000027fc4bbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fc4bc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fc4bd90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fc4bed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fc4bf90] [c0000000000194c4] .kernel_thread+0x4c/0x68
kblockd/2     S 0000000000000000 13416    29     10            30    28 (L-TLB)
Call Trace:
[c00000027fc53a10] [c00000027fc53aa0] 0xc00000027fc53aa0 (unreliable)
[c00000027fc53be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fc53c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fc53d90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fc53ed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fc53f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
kblockd/3     S 0000000000000000 13008    30     10            46    29 (L-TLB)
Call Trace:
[c00000027fc57a10] [c00000003f9118b0] 0xc00000003f9118b0 (unreliable)
[c00000027fc57be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fc57c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fc57d90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fc57ed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fc57f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
rtasd         D 0000000000000000 12880    45      1            48    13 (L-TLB)
Call Trace:
[c00000027fcefa80] [8000000000009032] 0x8000000000009032 (unreliable)
[c00000027fcefc50] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fcefce0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fcefe00] [c000000000355b94] .__down+0xe8/0x11c
[c00000027fcefed0] [c000000000032a00] .rtasd+0x38c/0x40c
[c00000027fceff90] [c0000000000194c4] .kernel_thread+0x4c/0x68
pdflush       S 0000000000000000 10400    46     10            47    30 (L-TLB)
Call Trace:
[c00000027fd17a00] [c00000027fd17aa0] 0xc00000027fd17aa0 (unreliable)
[c00000027fd17bd0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fd17c60] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fd17d80] [c00000000008695c] .__pdflush+0x118/0x38c
[c00000027fd17e20] [c000000000086bf4] .pdflush+0x24/0x34
[c00000027fd17ed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fd17f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
pdflush       S 0000000000000000 14624    47     10            49    46 (L-TLB)
Call Trace:
[c00000027fd1bbd0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fd1bc60] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fd1bd80] [c00000000008695c] .__pdflush+0x118/0x38c
[c00000027fd1be20] [c000000000086bf4] .pdflush+0x24/0x34
[c00000027fd1bed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fd1bf90] [c0000000000194c4] .kernel_thread+0x4c/0x68
kswapd0       S 0000000000000000 15040    48      1           635    45 (L-TLB)
Call Trace:
[c00000027fd1fce0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fd1fd70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fd1fe90] [c000000000092868] .kswapd+0xec/0x128
[c00000027fd1ff90] [c0000000000194c4] .kernel_thread+0x4c/0x68
aio/0         S 0000000000000000 14784    49     10            50    47 (L-TLB)
Call Trace:
[c00000027fd47be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fd47c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fd47d90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fd47ed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fd47f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
aio/1         S 0000000000000000 14784    50     10            51    49 (L-TLB)
Call Trace:
[c00000027fd57be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fd57c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fd57d90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fd57ed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fd57f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
aio/2         S 0000000000000000 14784    51     10            52    50 (L-TLB)
Call Trace:
[c00000027fd5bbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fd5bc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fd5bd90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fd5bed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fd5bf90] [c0000000000194c4] .kernel_thread+0x4c/0x68
aio/3         S 0000000000000000 14784    52     10                  51 (L-TLB)
Call Trace:
[c00000027fd5fbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027fd5fc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027fd5fd90] [c00000000006ae9c] .worker_thread+0x358/0x3b0
[c00000027fd5fed0] [c000000000071d80] .kthread+0x11c/0x128
[c00000027fd5ff90] [c0000000000194c4] .kernel_thread+0x4c/0x68
khvcd         R  running task   13512   635      1           637    48 (L-TLB)
kseriod       S 0000000000000000 15056   637      1           800   635 (L-TLB)
Call Trace:
[c00000000b263cf0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000b263d80] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000b263ea0] [c0000000001eaf40] .serio_thread+0x1d8/0x1f0
[c00000000b263f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
scsi_eh_0     S 0000000000000000 14896   800      1           820   637 (L-TLB)
Call Trace:
[c00000003f8ebc50] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000003f8ebce0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000003f8ebe00] [c000000000355ce0] .__down_interruptible+0x118/0x16c
[c00000003f8ebee0] [c000000000258444] .scsi_error_handler+0x1b0/0x1f8
[c00000003f8ebf90] [c0000000000194c4] .kernel_thread+0x4c/0x68
scsi_eh_1     S 0000000000000000 14896   820      1           846   800 (L-TLB)
Call Trace:
[c00000003f953c50] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000003f953ce0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000003f953e00] [c000000000355ce0] .__down_interruptible+0x118/0x16c
[c00000003f953ee0] [c000000000258444] .scsi_error_handler+0x1b0/0x1f8
[c00000003f953f90] [c0000000000194c4] .kernel_thread+0x4c/0x68
kjournald     S 0000000000000000 11840   846      1          1109   820 (L-TLB)
Call Trace:
[c00000000b71fab0] [c00000000b71fe30] 0xc00000000b71fe30 (unreliable)
[c00000000b71fc80] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000b71fd10] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000b71fe30] [c000000000167a48] .kjournald+0x3b0/0x414
[c00000000b71ff90] [c0000000000194c4] .kernel_thread+0x4c/0x68
srcmstr       S 000000000fdfbeb4  8488  1109      1  1307    1246   846 (NOTLB)
Call Trace:
[c00000027f087710] [c00000000008c98c] .kfree+0x98/0x128 (unreliable)
[c00000027f0878e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f087970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f087a90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027f087b70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027f087cb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027f087dc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027f087e30] [c000000000011e00] syscall_exit+0x0/0x18
syslogd       S 0000008000167c94  9320  1246      1          1263  1109 (NOTLB)
Call Trace:
[c00000003f397780] [c0000000002c4038] .memcpy_toiovec+0x68/0xcc (unreliable)
[c00000003f397950] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000003f3979e0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000003f397b00] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000003f397be0] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000003f397d20] [c0000000000ca71c] .sys_select+0x348/0x4e8
[c00000003f397e30] [c000000000011e00] syscall_exit+0x0/0x18
klogd         R  running task   11104  1263      1          1320  1246 (NOTLB)
rmcd          S 000000000f555eb4  8488  1307   1109  1334    1369       (NOTLB)
Call Trace:
[c00000027f4bf710] [c00000003f480870] 0xc00000003f480870 (unreliable)
[c00000027f4bf8e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f4bf970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f4bfa90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027f4bfb70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027f4bfcb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027f4bfdc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027f4bfe30] [c000000000011e00] syscall_exit+0x0/0x18
portmap       S 000000000ff66884 11776  1320      1          1383  1263 (NOTLB)
Call Trace:
[c00000027f553850] [c0000000000834d8] .buffered_rmqueue+0x1b8/0x31c (unreliable)
[c00000027f553a20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f553ab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f553bd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027f553cb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000027f553d50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000027f553e30] [c000000000011e00] syscall_exit+0x0/0x18
rmcd          S 000000000f55c884 13432  1334   1307  1335               (NOTLB)
Call Trace:
[c00000027f4e7850] [c00000027f4e78f0] 0xc00000027f4e78f0 (unreliable)
[c00000027f4e7a20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f4e7ab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f4e7bd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027f4e7cb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000027f4e7d50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000027f4e7e30] [c000000000011e00] syscall_exit+0x0/0x18
rmcd          S 000000000f4c2600  9504  1335   1334                     (NOTLB)
Call Trace:
[c00000003f53fa10] [c00000003f53fad0] 0xc00000003f53fad0 (unreliable)
[c00000003f53fbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000003f53fc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000003f53fd90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000003f53fe30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.CSMAgentR S 000000000f996eb4  8672  1369   1109  1400    1399  1307 (NOTLB)
Call Trace:
[c00000000b7bf710] [c00000000b7bf7b0] 0xc00000000b7bf7b0 (unreliable)
[c00000000b7bf8e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000b7bf970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000b7bfa90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000000b7bfb70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000000b7bfcb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000000b7bfdc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000000b7bfe30] [c000000000011e00] syscall_exit+0x0/0x18
sshd          S 000000000fc39eb4 11104  1383      1  4636    4563  1320 (NOTLB)
Call Trace:
[c00000000b91b710] [c00000000b91b7a0] 0xc00000000b91b7a0 (unreliable)
[c00000000b91b8e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000b91b970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000b91ba90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000000b91bb70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000000b91bcb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000000b91bdc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000000b91be30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.ERrmd     S 000000000f986eb4  8960  1399   1109  1406    1427  1369 (NOTLB)
Call Trace:
[c00000027f47b710] [c00000027f478000] 0xc00000027f478000 (unreliable)
[c00000027f47b8e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f47b970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f47ba90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027f47bb70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027f47bcb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027f47bdc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027f47be30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.CSMAgentR S 000000000f99d884 12848  1400   1369  1401               (NOTLB)
Call Trace:
[c00000027f587850] [c00000027f5878a0] 0xc00000027f5878a0 (unreliable)
[c00000027f587a20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f587ab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f587bd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027f587cb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000027f587d50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000027f587e30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.CSMAgentR S 000000000f903600 13008  1401   1400          1402       (NOTLB)
Call Trace:
[c00000027f4d3a10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000027f4d3be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f4d3c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f4d3d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027f4d3e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.CSMAgentR S 000000000f996eb4 12064  1402   1400          1403  1401 (NOTLB)
Call Trace:
[c00000000b8af710] [c00000000b8af840] 0xc00000000b8af840 (unreliable)
[c00000000b8af8e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000b8af970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000b8afa90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000000b8afb70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000000b8afcb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000000b8afdc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000000b8afe30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.CSMAgentR S 000000000f903600 12528  1403   1400          1404  1402 (NOTLB)
Call Trace:
[c00000027f517a10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000027f517be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f517c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f517d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027f517e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.CSMAgentR S 000000000f9902e8 13120  1404   1400          1405  1403 (NOTLB)
Call Trace:
[c00000027f5af5a0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f5af630] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f5af750] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027f5af830] [c000000000337c28] .unix_stream_data_wait+0x14c/0x20c
[c00000027f5af940] [c0000000003381ec] .unix_stream_recvmsg+0x504/0x5ac
[c00000027f5afa50] [c0000000002bbf78] .sock_aio_read+0x124/0x14c
[c00000027f5afb80] [c0000000000abe28] .do_sync_read+0xb0/0x100
[c00000027f5afcf0] [c0000000000abfc0] .vfs_read+0x148/0x164
[c00000027f5afd90] [c0000000000ac298] .sys_read+0x58/0xa4
[c00000027f5afe30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.CSMAgentR S 000000000f96ef00 11760  1405   1400          1411  1404 (NOTLB)
Call Trace:
[c00000000bf8f930] [00000000bed60713] 0xbed60713 (unreliable)
[c00000000bf8fb00] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000bf8fb90] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000bf8fcb0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000000bf8fd90] [c00000000007aa0c] .compat_sys_nanosleep+0xc4/0x174
[c00000000bf8fe30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.ERrmd     S 000000000f98d884 12944  1406   1399  1407               (NOTLB)
Call Trace:
[c00000027d013850] [c00000027d0138a0] 0xc00000027d0138a0 (unreliable)
[c00000027d013a20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d013ab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d013bd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027d013cb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000027d013d50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000027d013e30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.ERrmd     S 000000000f8f3600 13136  1407   1406          1408       (NOTLB)
Call Trace:
[c00000027d017a10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000027d017be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d017c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d017d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027d017e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.ERrmd     S 000000000f986eb4 12848  1408   1406          1409  1407 (NOTLB)
Call Trace:
[c00000027d01b710] [c00000027d01b840] 0xc00000027d01b840 (unreliable)
[c00000027d01b8e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d01b970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d01ba90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027d01bb70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027d01bcb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027d01bdc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027d01be30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.ERrmd     S 000000000f8f3600 13040  1409   1406          1410  1408 (NOTLB)
Call Trace:
[c00000027d023a10] [4000000000000000] 0x4000000000000000 (unreliable)
[c00000027d023be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d023c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d023d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027d023e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.ERrmd     S 000000000f9802e8 13120  1410   1406          1412  1409 (NOTLB)
Call Trace:
[c00000000bf175a0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000bf17630] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000bf17750] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000000bf17830] [c000000000337c28] .unix_stream_data_wait+0x14c/0x20c
[c00000000bf17940] [c0000000003381ec] .unix_stream_recvmsg+0x504/0x5ac
[c00000000bf17a50] [c0000000002bbf78] .sock_aio_read+0x124/0x14c
[c00000000bf17b80] [c0000000000abe28] .do_sync_read+0xb0/0x100
[c00000000bf17cf0] [c0000000000abfc0] .vfs_read+0x148/0x164
[c00000000bf17d90] [c0000000000ac298] .sys_read+0x58/0xa4
[c00000000bf17e30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.CSMAgentR S 000000000f96ef00 14016  1411   1400          1439  1405 (NOTLB)
Call Trace:
[c00000027d33b930] [00000000bf9c0713] 0xbf9c0713 (unreliable)
[c00000027d33bb00] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d33bb90] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d33bcb0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027d33bd90] [c00000000007aa0c] .compat_sys_nanosleep+0xc4/0x174
[c00000027d33be30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.ERrmd     S 000000000f8f3600 14152  1412   1406          1413  1410 (NOTLB)
Call Trace:
[c00000000bf27a10] [4000000000000000] 0x4000000000000000 (unreliable)
[c00000000bf27be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000bf27c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000bf27d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000000bf27e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.ERrmd     S 000000000f8f3600 14784  1413   1406          1414  1412 (NOTLB)
Call Trace:
[c00000000bf2bbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000bf2bc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000bf2bd90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000000bf2be30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.ERrmd     S 000000000f8f3600 14784  1414   1406          1415  1413 (NOTLB)
Call Trace:
[c00000027d3a7be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d3a7c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d3a7d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027d3a7e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.ERrmd     S 000000000f8f3600 14784  1415   1406          1418  1414 (NOTLB)
Call Trace:
[c00000027d1a7be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d1a7c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d1a7d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027d1a7e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.ERrmd     S 000000000f8f3600 11808  1418   1406          1419  1415 (NOTLB)
Call Trace:
[c00000027d353a10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000027d353be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d353c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d353d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027d353e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.ERrmd     S 000000000f98d9c4 12720  1419   1406          1437  1418 (NOTLB)
Call Trace:
[c00000027d50b420] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d50b4b0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d50b5d0] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027d50b6b0] [c000000000337c28] .unix_stream_data_wait+0x14c/0x20c
[c00000027d50b7c0] [c0000000003381ec] .unix_stream_recvmsg+0x504/0x5ac
[c00000027d50b8d0] [c0000000002bbd70] .sock_recvmsg+0xe8/0x13c
[c00000027d50baf0] [c0000000002bc204] .sock_readv_writev+0x98/0x9c
[c00000027d50bbb0] [c0000000002bc254] .sock_readv+0x4c/0x5c
[c00000027d50bc30] [c0000000000ec400] .compat_do_readv_writev+0x324/0x388
[c00000027d50bda0] [c0000000000ec4f8] .compat_sys_readv+0x94/0xc8
[c00000027d50be30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.AuditRMd  S 000000000f986eb4  8960  1427   1109  1428    1465  1399 (NOTLB)
Call Trace:
[c00000027f07f710] [c0000000093a8760] 0xc0000000093a8760 (unreliable)
[c00000027f07f8e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f07f970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f07fa90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027f07fb70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027f07fcb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027f07fdc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027f07fe30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.AuditRMd  S 000000000f98d884 12944  1428   1427  1429               (NOTLB)
Call Trace:
[c00000027d333850] [c00000027d3338a0] 0xc00000027d3338a0 (unreliable)
[c00000027d333a20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d333ab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d333bd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027d333cb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000027d333d50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000027d333e30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.AuditRMd  S 000000000f8f3600 13136  1429   1428          1430       (NOTLB)
Call Trace:
[c00000027d9eba10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000027d9ebbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d9ebc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d9ebd90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027d9ebe30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.AuditRMd  S 000000000f986eb4 12848  1430   1428          1431  1429 (NOTLB)
Call Trace:
[c00000027d933710] [c00000027d933840] 0xc00000027d933840 (unreliable)
[c00000027d9338e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d933970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d933a90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027d933b70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027d933cb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027d933dc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027d933e30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.AuditRMd  S 000000000f8f3600 11696  1431   1428          1432  1430 (NOTLB)
Call Trace:
[c00000027d92fa10] [000000000fc5b5ac] 0xfc5b5ac (unreliable)
[c00000027d92fbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d92fc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d92fd90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027d92fe30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.AuditRMd  S 000000000f9802e8 13104  1432   1428          1433  1431 (NOTLB)
Call Trace:
[c00000027d83b5a0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d83b630] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d83b750] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027d83b830] [c000000000337c28] .unix_stream_data_wait+0x14c/0x20c
[c00000027d83b940] [c0000000003381ec] .unix_stream_recvmsg+0x504/0x5ac
[c00000027d83ba50] [c0000000002bbf78] .sock_aio_read+0x124/0x14c
[c00000027d83bb80] [c0000000000abe28] .do_sync_read+0xb0/0x100
[c00000027d83bcf0] [c0000000000abfc0] .vfs_read+0x148/0x164
[c00000027d83bd90] [c0000000000ac298] .sys_read+0x58/0xa4
[c00000027d83be30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.AuditRMd  S 000000000f8f3600 13800  1433   1428          1434  1432 (NOTLB)
Call Trace:
[c00000027d6c3a10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000027d6c3be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d6c3c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d6c3d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027d6c3e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.AuditRMd  S 000000000f8f3600 12712  1434   1428          1435  1433 (NOTLB)
Call Trace:
[c00000027dc43a10] [c00000027dc43ab0] 0xc00000027dc43ab0 (unreliable)
[c00000027dc43be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027dc43c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027dc43d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027dc43e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.AuditRMd  S 000000000f8f3600 11776  1435   1428          1436  1434 (NOTLB)
Call Trace:
[c00000027dfbfa10] [0000000000000001] 0x1 (unreliable)
[c00000027dfbfbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027dfbfc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027dfbfd90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027dfbfe30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.AuditRMd  S 000000000f8f3600 14224  1436   1428                1435 (NOTLB)
Call Trace:
[c00000003f3f3a10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000003f3f3be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000003f3f3c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000003f3f3d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000003f3f3e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.ERrmd     S 000000000f95ef00 14384  1437   1406          1438  1419 (NOTLB)
Call Trace:
[c00000000b7c3b00] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000b7c3b90] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000b7c3cb0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000000b7c3d90] [c00000000007aa0c] .compat_sys_nanosleep+0xc4/0x174
[c00000000b7c3e30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.ERrmd     S 000000000f8f3600 14240  1438   1406                1437 (NOTLB)
Call Trace:
[c00000000b92fa10] [c00000000b92fab0] 0xc00000000b92fab0 (unreliable)
[c00000000b92fbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000b92fc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000b92fd90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000000b92fe30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.CSMAgentR S 000000000f96ef00 14560  1439   1400          1451  1411 (NOTLB)
Call Trace:
[c00000027d5f3b00] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d5f3b90] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d5f3cb0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027d5f3d90] [c00000000007aa0c] .compat_sys_nanosleep+0xc4/0x174
[c00000027d5f3e30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.CSMAgentR S 000000000f903600 11776  1451   1400                1439 (NOTLB)
Call Trace:
[c00000027f477a10] [c00000027f631340] 0xc00000027f631340 (unreliable)
[c00000027f477be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f477c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f477d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027f477e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.HostRMd   S 000000000fa4aeb4  8488  1465   1109  1468    1485  1427 (NOTLB)
Call Trace:
[c00000027c45f710] [c00000027c45f7b0] 0xc00000027c45f7b0 (unreliable)
[c00000027c45f8e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c45f970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c45fa90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027c45fb70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027c45fcb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027c45fdc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027c45fe30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.HostRMd   S 000000000fa51884 12944  1468   1465  1469               (NOTLB)
Call Trace:
[c00000000ba2b850] [c00000000ba2b8a0] 0xc00000000ba2b8a0 (unreliable)
[c00000000ba2ba20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000ba2bab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000ba2bbd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000000ba2bcb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000000ba2bd50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000000ba2be30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.HostRMd   S 000000000f9b7600 13136  1469   1468          1470       (NOTLB)
Call Trace:
[c00000000b953a10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000000b953be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000b953c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000b953d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000000b953e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.HostRMd   S 000000000fa4aeb4 12848  1470   1468          1471  1469 (NOTLB)
Call Trace:
[c00000027d60b710] [00000000000000d0] 0xd0 (unreliable)
[c00000027d60b8e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027d60b970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027d60ba90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027d60bb70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027d60bcb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027d60bdc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027d60be30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.HostRMd   S 000000000f9b7600 11696  1471   1468          1472  1470 (NOTLB)
Call Trace:
[c00000027f46fa10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000027f46fbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f46fc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f46fd90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027f46fe30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.HostRMd   S 000000000fa442e8 13120  1472   1468          1473  1471 (NOTLB)
Call Trace:
[c00000027f5975a0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f597630] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f597750] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027f597830] [c000000000337c28] .unix_stream_data_wait+0x14c/0x20c
[c00000027f597940] [c0000000003381ec] .unix_stream_recvmsg+0x504/0x5ac
[c00000027f597a50] [c0000000002bbf78] .sock_aio_read+0x124/0x14c
[c00000027f597b80] [c0000000000abe28] .do_sync_read+0xb0/0x100
[c00000027f597cf0] [c0000000000abfc0] .vfs_read+0x148/0x164
[c00000027f597d90] [c0000000000ac298] .sys_read+0x58/0xa4
[c00000027f597e30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.HostRMd   S 000000000fa22f00 14152  1473   1468          1474  1472 (NOTLB)
Call Trace:
[c00000027c19f930] [0000000004020713] 0x4020713 (unreliable)
[c00000027c19fb00] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c19fb90] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c19fcb0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027c19fd90] [c00000000007aa0c] .compat_sys_nanosleep+0xc4/0x174
[c00000027c19fe30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.HostRMd   S 000000000f9b7600 10848  1474   1468          1476  1473 (NOTLB)
Call Trace:
[c00000027c1b3a10] [c00000027c1b3ab0] 0xc00000027c1b3ab0 (unreliable)
[c00000027c1b3be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c1b3c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c1b3d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027c1b3e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.HostRMd   S 000000000fa22f00 14360  1476   1468                1474 (NOTLB)
Call Trace:
[c00000027c68b930] [00000000bf9c0713] 0xbf9c0713 (unreliable)
[c00000027c68bb00] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c68bb90] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c68bcb0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027c68bd90] [c00000000007aa0c] .compat_sys_nanosleep+0xc4/0x174
[c00000027c68be30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.DRMd      S 000000000fb40eb4  8488  1485   1109  1518          1465 (NOTLB)
Call Trace:
[c00000027c6a7710] [c00000000068d8c0] 0xc00000000068d8c0 (unreliable)
[c00000027c6a78e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c6a7970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c6a7a90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027c6a7b70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027c6a7cb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027c6a7dc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027c6a7e30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.DRMd      S 000000000fb47884 12736  1518   1485  1519               (NOTLB)
Call Trace:
[c00000027c68f850] [c00000027c68f8a0] 0xc00000027c68f8a0 (unreliable)
[c00000027c68fa20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c68fab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c68fbd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027c68fcb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000027c68fd50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000027c68fe30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.DRMd      S 000000000faad600 13136  1519   1518          1520       (NOTLB)
Call Trace:
[c00000003f95fa10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000003f95fbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000003f95fc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000003f95fd90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000003f95fe30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.DRMd      S 000000000fb40eb4 12848  1520   1518          1521  1519 (NOTLB)
Call Trace:
[c00000027c7a3710] [00000000000000d0] 0xd0 (unreliable)
[c00000027c7a38e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c7a3970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c7a3a90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027c7a3b70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027c7a3cb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027c7a3dc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027c7a3e30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.DRMd      S 000000000faad600 13040  1521   1518          1522  1520 (NOTLB)
Call Trace:
[c00000027c8d7a10] [c0000000004f63b8] 0xc0000000004f63b8 (unreliable)
[c00000027c8d7be0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c8d7c70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c8d7d90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027c8d7e30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.DRMd      S 000000000fb3a2e8 13104  1522   1518          1523  1521 (NOTLB)
Call Trace:
[c00000000b79b5a0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000000b79b630] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000000b79b750] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000000b79b830] [c000000000337c28] .unix_stream_data_wait+0x14c/0x20c
[c00000000b79b940] [c0000000003381ec] .unix_stream_recvmsg+0x504/0x5ac
[c00000000b79ba50] [c0000000002bbf78] .sock_aio_read+0x124/0x14c
[c00000000b79bb80] [c0000000000abe28] .do_sync_read+0xb0/0x100
[c00000000b79bcf0] [c0000000000abfc0] .vfs_read+0x148/0x164
[c00000000b79bd90] [c0000000000ac298] .sys_read+0x58/0xa4
[c00000000b79be30] [c000000000011e00] syscall_exit+0x0/0x18
IBM.DRMd      S 000000000faad600 10848  1523   1518          1524  1522 (NOTLB)
Call Trace:
[c00000027c82fa10] [c00000027c82fab0] 0xc00000027c82fab0 (unreliable)
[c00000027c82fbe0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c82fc70] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c82fd90] [c000000000028968] .sys32_rt_sigsuspend+0x11c/0x164
[c00000027c82fe30] [c000000000011fe4] .ppc32_rt_sigsuspend+0x8/0xc
IBM.DRMd      S 000000000fb18f00 14360  1524   1518                1523 (NOTLB)
Call Trace:
[c00000027c87b930] [0000000004020713] 0x4020713 (unreliable)
[c00000027c87bb00] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c87bb90] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c87bcb0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027c87bd90] [c00000000007aa0c] .compat_sys_nanosleep+0xc4/0x174
[c00000027c87be30] [c000000000011e00] syscall_exit+0x0/0x18
atd           S 000000000ff59f00 11104  4563      1          4578  1383 (NOTLB)
Call Trace:
[c00000027c483930] [0000000000000001] 0x1 (unreliable)
[c00000027c483b00] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c483b90] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c483cb0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027c483d90] [c00000000007aa0c] .compat_sys_nanosleep+0xc4/0x174
[c00000027c483e30] [c000000000011e00] syscall_exit+0x0/0x18
cron          S 000000000ff59f00 11248  4578      1          4594  4563 (NOTLB)
Call Trace:
[c00000003f3df930] [0000000000000001] 0x1 (unreliable)
[c00000003f3dfb00] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000003f3dfb90] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000003f3dfcb0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000003f3dfd90] [c00000000007aa0c] .compat_sys_nanosleep+0xc4/0x174
[c00000003f3dfe30] [c000000000011e00] syscall_exit+0x0/0x18
nscd          S 000000000ff1cd9c 11104  4594      1  4595    4622  4578 (NOTLB)
Call Trace:
[c00000027cb2f590] [c000000000513ad8] 0xc000000000513ad8 (unreliable)
[c00000027cb2f760] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027cb2f7f0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027cb2f910] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027cb2f9f0] [c0000000002c473c] .wait_for_packet+0x18c/0x1d0
[c00000027cb2faf0] [c0000000002c48bc] .skb_recv_datagram+0x13c/0x1a0
[c00000027cb2fbb0] [c00000000033666c] .unix_accept+0xc0/0x21c
[c00000027cb2fc60] [c0000000002bd82c] .sys_accept+0x168/0x258
[c00000027cb2fd90] [c0000000002d8584] .compat_sys_socketcall+0x144/0x26c
[c00000027cb2fe30] [c000000000011e00] syscall_exit+0x0/0x18
nscd          S 000000000ff1c884 13120  4595   4594  4596               (NOTLB)
Call Trace:
[c00000027c933850] [c00000027c9338a0] 0xc00000027c9338a0 (unreliable)
[c00000027c933a20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c933ab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c933bd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027c933cb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000027c933d50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000027c933e30] [c000000000011e00] syscall_exit+0x0/0x18
nscd          S 000000000ff1c884 11848  4596   4595          4597       (NOTLB)
Call Trace:
[c00000027c813850] [c0000000000834d8] .buffered_rmqueue+0x1b8/0x31c (unreliable)
[c00000027c813a20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c813ab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c813bd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027c813cb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000027c813d50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000027c813e30] [c000000000011e00] syscall_exit+0x0/0x18
nscd          S 000000000ff1c884 13008  4597   4595          4598  4596 (NOTLB)
Call Trace:
[c00000027cc63850] [c0000000000834d8] .buffered_rmqueue+0x1b8/0x31c (unreliable)
[c00000027cc63a20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027cc63ab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027cc63bd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027cc63cb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000027cc63d50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000027cc63e30] [c000000000011e00] syscall_exit+0x0/0x18
nscd          S 000000000ff1cd9c 11848  4598   4595          4599  4597 (NOTLB)
Call Trace:
[c00000027cc6b590] [c00000027cc6b630] 0xc00000027cc6b630 (unreliable)
[c00000027cc6b760] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027cc6b7f0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027cc6b910] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027cc6b9f0] [c0000000002c473c] .wait_for_packet+0x18c/0x1d0
[c00000027cc6baf0] [c0000000002c48bc] .skb_recv_datagram+0x13c/0x1a0
[c00000027cc6bbb0] [c00000000033666c] .unix_accept+0xc0/0x21c
[c00000027cc6bc60] [c0000000002bd82c] .sys_accept+0x168/0x258
[c00000027cc6bd90] [c0000000002d8584] .compat_sys_socketcall+0x144/0x26c
[c00000027cc6be30] [c000000000011e00] syscall_exit+0x0/0x18
nscd          S 000000000ff1c884 13008  4599   4595          4600  4598 (NOTLB)
Call Trace:
[c00000027cb33850] [c0000000000834d8] .buffered_rmqueue+0x1b8/0x31c (unreliable)
[c00000027cb33a20] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027cb33ab0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027cb33bd0] [c0000000003574e0] .schedule_timeout+0x94/0x110
[c00000027cb33cb0] [c0000000000caabc] .do_poll+0xc4/0x134
[c00000027cb33d50] [c0000000000cacb8] .sys_poll+0x18c/0x294
[c00000027cb33e30] [c000000000011e00] syscall_exit+0x0/0x18
nscd          S 000000000ff1cd9c 13104  4600   4595                4599 (NOTLB)
Call Trace:
[c00000027ccaf590] [c00000027ccaf630] 0xc00000027ccaf630 (unreliable)
[c00000027ccaf760] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027ccaf7f0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027ccaf910] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027ccaf9f0] [c0000000002c473c] .wait_for_packet+0x18c/0x1d0
[c00000027ccafaf0] [c0000000002c48bc] .skb_recv_datagram+0x13c/0x1a0
[c00000027ccafbb0] [c00000000033666c] .unix_accept+0xc0/0x21c
[c00000027ccafc60] [c0000000002bd82c] .sys_accept+0x168/0x258
[c00000027ccafd90] [c0000000002d8584] .compat_sys_socketcall+0x144/0x26c
[c00000027ccafe30] [c000000000011e00] syscall_exit+0x0/0x18
inetd         S 000000000ff81eb4 11104  4622      1          4635  4594 (NOTLB)
Call Trace:
[c00000027cac3710] [c00000027cac37c0] 0xc00000027cac37c0 (unreliable)
[c00000027cac38e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027cac3970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027cac3a90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027cac3b70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027cac3cb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027cac3dc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027cac3e30] [c000000000011e00] syscall_exit+0x0/0x18
login         S 000000000fee8bb4  9320  4635      1  4673          4622 (NOTLB)
Call Trace:
[c00000027f50f840] [c00000027fffc100] 0xc00000027fffc100 (unreliable)
[c00000027f50fa10] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027f50faa0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027f50fbc0] [c000000000058a58] .do_wait+0x214/0x4e0
[c00000027f50fd00] [c00000000007b73c] .compat_sys_wait4+0x108/0x114
[c00000027f50fe30] [c000000000011e00] syscall_exit+0x0/0x18
sshd          S 000000000fc332e8  9320  4636   1383  4638               (NOTLB)
Call Trace:
[c00000027ca773d0] [c00000027ca77470] 0xc00000027ca77470 (unreliable)
[c00000027ca775a0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027ca77630] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027ca77750] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027ca77830] [c000000000337c28] .unix_stream_data_wait+0x14c/0x20c
[c00000027ca77940] [c0000000003381ec] .unix_stream_recvmsg+0x504/0x5ac
[c00000027ca77a50] [c0000000002bbf78] .sock_aio_read+0x124/0x14c
[c00000027ca77b80] [c0000000000abe28] .do_sync_read+0xb0/0x100
[c00000027ca77cf0] [c0000000000abfc0] .vfs_read+0x148/0x164
[c00000027ca77d90] [c0000000000ac298] .sys_read+0x58/0xa4
[c00000027ca77e30] [c000000000011e00] syscall_exit+0x0/0x18
sshd          S 000000000fc39eb4  8592  4638   4636  4641               (NOTLB)
Call Trace:
[c00000027c94f8e0] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c94f970] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c94fa90] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027c94fb70] [c0000000000ca180] .do_select+0x1ec/0x3e4
[c00000027c94fcb0] [c0000000000ed104] .compat_sys_select+0x438/0x660
[c00000027c94fdc0] [c00000000001f5ac] .ppc32_select+0x14/0x28
[c00000027c94fe30] [c000000000011e00] syscall_exit+0x0/0x18
bash          S 000000000fe3cbb4  9848  4641   4638  4699               (NOTLB)
Call Trace:
[c00000027c9f3840] [c00000027c9f38d0] 0xc00000027c9f38d0 (unreliable)
[c00000027c9f3a10] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027c9f3aa0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027c9f3bc0] [c000000000058a58] .do_wait+0x214/0x4e0
[c00000027c9f3d00] [c00000000007b73c] .compat_sys_wait4+0x108/0x114
[c00000027c9f3e30] [c000000000011e00] syscall_exit+0x0/0x18
bash          S 000000000fe3cbb4 10848  4673   4635  4694               (NOTLB)
Call Trace:
[c00000027cb27840] [c00000027cb278d0] 0xc00000027cb278d0 (unreliable)
[c00000027cb27a10] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027cb27aa0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027cb27bc0] [c000000000058a58] .do_wait+0x214/0x4e0
[c00000027cb27d00] [c00000000007b73c] .compat_sys_wait4+0x108/0x114
[c00000027cb27e30] [c000000000011e00] syscall_exit+0x0/0x18
cpuonoff.pl   D 000000000fe562f8 10416  4694   4673                     (NOTLB)
Call Trace:
[c00000027ca534c0] [c000000000016f7c] .__switch_to+0x90/0xd8 (unreliable)
[c00000027ca53690] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027ca53720] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027ca53840] [c000000000356930] .wait_for_completion+0x10c/0x21c
[c00000027ca53940] [c00000000007c390] .__stop_machine_run+0xc0/0x130
[c00000027ca53a00] [c000000000073e6c] .cpu_down+0x160/0x364
[c00000027ca53ae0] [c0000000001fc548] .store_online+0x68/0x70
[c00000027ca53b60] [c0000000001f7ec8] .sysdev_store+0x54/0x60
[c00000027ca53be0] [c0000000000fe9b4] .flush_write_buffer+0x48/0x60
[c00000027ca53c60] [c0000000000fea2c] .sysfs_write_file+0x60/0x78
[c00000027ca53cf0] [c0000000000ac1e8] .vfs_write+0x10c/0x164
[c00000027ca53d90] [c0000000000ac33c] .sys_write+0x58/0xa4
[c00000027ca53e30] [c000000000011e00] syscall_exit+0x0/0x18
kstopmachine  R  running task   12144  4695     11  4696               (L-TLB)
kstopmachine  R  running task   15744  4696   4695          4697       (L-TLB)
kstopmachine  R  running task   15744  4697   4695          4698  4696 (L-TLB)
kstopmachine  R  running task   15744  4698   4695                4697 (L-TLB)
su            S 000000000febbbb4 10288  4699   4641  4700               (NOTLB)
Call Trace:
[c00000027ce37840] [c00000027ce378d0] 0xc00000027ce378d0 (unreliable)
[c00000027ce37a10] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027ce37aa0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027ce37bc0] [c000000000058a58] .do_wait+0x214/0x4e0
[c00000027ce37d00] [c00000000007b73c] .compat_sys_wait4+0x108/0x114
[c00000027ce37e30] [c000000000011e00] syscall_exit+0x0/0x18
bash          S 000000000fe5e2e8 11472  4700   4699                     (NOTLB)
Call Trace:
[c00000027cf6f650] [0000000000000001] 0x1 (unreliable)
[c00000027cf6f820] [c000000000016f7c] .__switch_to+0x90/0xd8
[c00000027cf6f8b0] [c0000000003561ac] .schedule+0x478/0xa6c
[c00000027cf6f9d0] [c000000000357554] .schedule_timeout+0x108/0x110
[c00000027cf6fab0] [c0000000001d4988] .read_chan+0x958/0xb10
[c00000027cf6fc40] [c0000000001cd0c4] .tty_read+0x1b4/0x1dc
[c00000027cf6fcf0] [c0000000000abf84] .vfs_read+0x10c/0x164
[c00000027cf6fd90] [c0000000000ac298] .sys_read+0x58/0xa4
[c00000027cf6fe30] [c000000000011e00] syscall_exit+0x0/0x18

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.8.1-mm4
# Mon Aug 23 16:54:54 2004
#
CONFIG_64BIT=y
CONFIG_MMU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_EARLY_PRINTK=y
CONFIG_COMPAT=y
CONFIG_FRAME_POINTER=y
CONFIG_FORCE_MAX_ZONEORDER=13

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=19
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_SYSVIPC_COMPAT=y

#
# Platform support
#
# CONFIG_PPC_ISERIES is not set
CONFIG_PPC_PSERIES=y
CONFIG_PPC=y
CONFIG_PPC64=y
CONFIG_PPC_OF=y
CONFIG_ALTIVEC=y
# CONFIG_PPC_PMAC is not set
CONFIG_PPC_SPLPAR=y
# CONFIG_BOOTX_TEXT is not set
# CONFIG_POWER4_ONLY is not set
# CONFIG_IOMMU_VMERGE is not set
CONFIG_SMP=y
CONFIG_IRQ_ALL_CPUS=y
CONFIG_NR_CPUS=128
CONFIG_HMT=y
# CONFIG_DISCONTIGMEM is not set
CONFIG_SCHED_SMT=y
# CONFIG_PREEMPT is not set
CONFIG_PPC_RTAS=y
# CONFIG_RTAS_FLASH is not set
CONFIG_SCANLOG=y
CONFIG_LPARCFG=y

#
# General setup
#
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG_CPU=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
CONFIG_PROC_DEVICETREE=y
# CONFIG_CMDLINE_BOOL is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_IBMVSCSI is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
CONFIG_SCSI_IPR=y
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
# CONFIG_MD_RAID6 is not set
# CONFIG_MD_MULTIPATH is not set
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Macintosh device drivers
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_IBMVETH is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_E100_NAPI is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=y
CONFIG_ACENIC_OMIT_TIGON_I=y
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_PMACZILOG is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_HVC_CONSOLE=y
# CONFIG_HVCS is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=y
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUGGER=y
CONFIG_XMON=y
CONFIG_XMON_DEFAULT=y
# CONFIG_PPCDBG is not set
CONFIG_IRQSTACKS=y
CONFIG_SCHEDSTATS=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set


