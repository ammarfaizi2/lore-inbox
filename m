Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUBUQpt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 11:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUBUQpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 11:45:49 -0500
Received: from village.ehouse.ru ([193.111.92.18]:63761 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261436AbUBUQpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 11:45:30 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1 IO lockup on SMP systems
Date: Sat, 21 Feb 2004 19:45:21 +0300
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, anton@megashop.ru
References: <200401311940.28078.rathamahata@php4.ru> <20040131161729.04000e92.akpm@osdl.org>
In-Reply-To: <20040131161729.04000e92.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402211945.21837.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Sunday 01 February 2004 03:17, Andrew Morton wrote:
> "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
> >
> > I had experienced a lockups on three of my servers with 2.6.1. It doesn't
> >  look like a deadlock, the box is still pingable and all tcp ports which were
> >   in listen state before a lockup are remains in listen state, but I can't get
> >  any data from this ports. According to sar(1) systems had not been overloaded
> >  right before a lockup. And there is no log entries in all user services logs
> >  for almost 10 hours after lockup.
> 
> Please ensure that CONFIG_KALLSYMS is enabled, then generate an all-tasks
> backtrace or a locked machine with sysrq-T or `echo t >
> /proc/sysrq-trigger'.  Then send us the resulting trace.

I've just reproduced this lockup with 2.6.3.

> 
> You may need a serial console to be able to capture all the output.
> 
> Also, it would be useful to know what sort of load the machines are under,
> and what filesystems are in use.

The machine is a http server. The main applications are:
1) apache 1.3 which serves php pages (mod_php):
	 15.3 requests/sec - 111.9 kB/second - 7.3 kB/request
	 54 requests currently being processed, 19 idle servers
2) mysql:
	Threads: 19  Questions: 26922012  Slow queries: 9799  Opens: 64980
	Flush tables: 1  Open tables: 630  Queries per second avg: 143.547

This is an IO bound machine in general. All filesystems are reiserfs.

Here is a sysrq-T output obtained from a locked box via serail console:

SysRq : Show State

free                        sibling
task             PC    stack   pid father child younger older
init          D 28E916FC    24     1      0     2               (NOTLB)
c244fcf0 00000086 d8460080 28e916fc 00003243 c2422bc0 f77fbd00 00000096
d8460080 2ede4081 00003243 c02af980 00000001 2ede4181 00003243 d8460080
d84600a0 c2422bc0 000017a2 2ede43e1 00003243 c244dac8 03471525 c244fd04
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c013e6a9>] filemap_nopage+0x329/0x3d0
[<c0157728>] read_swap_cache_async+0xb8/0xd0
[<c014c903>] swapin_readahead+0x43/0x90
[<c014cb98>] do_swap_page+0x248/0x320
[<c014d4d0>] handle_mm_fault+0xe0/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c0171334>] sys_select+0x264/0x520
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38

migration/0   S 00000001    12     2      1             3       (L-TLB)
c245dfc4 00000046 c241abc0 00000001 00000003 c245df98 c02ab560 f7da6d00
69378bf7 247a42e0 00000000 e11a4de2 f77e1f58 c245c000 f77e1f50 00000292
c245dfc4 c241abc0 00001801 e11a54a6 00000001 c244ce68 c241b4ec c245c000
Call Trace:
[<c011f4af>] migration_thread+0xdf/0x160
[<c011f3d0>] migration_thread+0x0/0x160
[<c0106f79>] kernel_thread_helper+0x5/0xc

ksoftirqd/0   S 00000001    24     3      1             4     2 (L-TLB)
c245bfd8 00000046 c241abc0 00000001 00000003 f3fc8ca8 f63f62e0 c241c54c
c245bf94 c245bf94 c241c55c 00000000 cebbd940 253f991d 000019b1 f5f766d0
f5f766f0 c241abc0 0000010b 8d075105 000019ea c244c838 c245a000 c245a000
Call Trace:
[<c0126d22>] ksoftirqd+0xe2/0x100
[<c0126c40>] ksoftirqd+0x0/0x100
[<c0106f79>] kernel_thread_helper+0x5/0xc

migration/1   S 00000001     8     4      1             5     3 (L-TLB)
c2459fc4 00000046 c2422bc0 00000001 00000003 c02aeedc c02ab560 c0336c60
c012bb70 c02aeedc c02aeed8 c2458000 c0123735 00000082 c02aba30 00000008
c2458000 c2422bc0 00004b63 0295e0d2 00000000 c244c208 c24234ec c2458000
Call Trace:
[<c012bb70>] free_uid+0x20/0x90
[<c0123735>] reparent_to_init+0x105/0x1a0
[<c011f4af>] migration_thread+0xdf/0x160
[<c011f3d0>] migration_thread+0x0/0x160
[<c0106f79>] kernel_thread_helper+0x5/0xc

ksoftirqd/1   S C0134355    24     5      1             6     4 (L-TLB)
c2455fd8 00000046 c03385e0 c0134355 02002bfd cad564c8 ed2ed0e0 c242454c
c2455f94 c2455f94 c242455c 00000000 c2454000 c033759c c0126a03 eca2f350
eca2f370 c2422bc0 0000025a 31392d56 000019e4 c2457ae8 c2454000 c2454000
Call Trace:
[<c0134355>] rcu_process_callbacks+0x155/0x190
[<c0126a03>] tasklet_action+0x73/0xe0
[<c0126d22>] ksoftirqd+0xe2/0x100
[<c0126c40>] ksoftirqd+0x0/0x100
[<c0106f79>] kernel_thread_helper+0x5/0xc

events/0      S 00000001     0     6      1 14588       7     5 (L-TLB)
f7f93f70 00000046 c241abc0 00000001 00000003 0000000b f77fb8c0 c02b8124
00000246 c241b520 c0353e40 00000000 f7fcbbe4 f7f92000 f7fcbbe0 00000092
f7f93f70 c241abc0 000001c9 25a4fd1b 00003243 c24574b8 f7f92000 f7fcbbcc
Call Trace:
[<c01333e5>] worker_thread+0x285/0x2b0
[<c01e5a60>] console_callback+0x0/0xe0
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0109192>] ret_from_fork+0x6/0x14
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0133160>] worker_thread+0x0/0x2b0
[<c0106f79>] kernel_thread_helper+0x5/0xc



events/1      S ED2ED520     0     7      1             8     6 (L-TLB)
f7f91f70 00000046 00000000 ed2ed520 00000000 e07e9e88 ed2ed520 00000000
00000000 f630a080 0000007b 0000007b f630a080 f630a0a0 c2422bc0 f6258d20
f6258d40 c2422bc0 0000006b ecdabbfb 000019ef c2456e88 f7f90000 f7fcbc2c
Call Trace:
[<c01333e5>] worker_thread+0x285/0x2b0
[<c0132e00>] __call_usermodehelper+0x0/0x70
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0109192>] ret_from_fork+0x6/0x14
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0133160>] worker_thread+0x0/0x2b0
[<c0106f79>] kernel_thread_helper+0x5/0xc

kblockd/0     S 00000001    24     8      1             9     7 (L-TLB)
c2527f70 00000046 c241abc0 00000001 00000003 00000001 f776f2a0 f7fa8000
c02027ec c2772e00 f3dbde28 f7c37834 f7fcb3a4 c2526000 f7fcb3a0 00000092
c2527f70 c241abc0 0000067d 03fc798c 00002b4f c2456858 c2526000 f7fcb38c
Call Trace:
[<c02027ec>] DAC960_process_queue+0x1c/0x170
[<c01333e5>] worker_thread+0x285/0x2b0
[<c01f4670>] blk_unplug_work+0x0/0x20
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0109192>] ret_from_fork+0x6/0x14
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0133160>] worker_thread+0x0/0x2b0
[<c0106f79>] kernel_thread_helper+0x5/0xc

kblockd/1     S C2772E00     8     9      1            13     8 (L-TLB)
c2525f70 00000046 c01f29d6 c2772e00 00000003 00000003 d1a49ae0 f7fa8000
c02027ec c2772e00 ecffc5d8 c2763c60 f7fcb404 c2524000 f7fcb400 c25026b0
c25026d0 c2422bc0 00000961 ff665670 00002b4e c2456228 c2524000 f7fcb3ec
Call Trace:
[<c01f29d6>] elv_next_request+0x16/0x110
[<c02027ec>] DAC960_process_queue+0x1c/0x170
[<c01333e5>] worker_thread+0x285/0x2b0
[<c01f4670>] blk_unplug_work+0x0/0x20
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0109192>] ret_from_fork+0x6/0x14
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0133160>] worker_thread+0x0/0x2b0
[<c0106f79>] kernel_thread_helper+0x5/0xc

kswapd0       S C23FFE98     0    13      1            10     9 (L-TLB)
f7dfbf04 00000046 c23fff38 c23ffe98 000000d0 00000200 f77a06c0 c02b0280
00000002 00000000 c0149200 00000100 c02b0280 000000d0 00000200 f72ecce0
f72ecd00 c2422bc0 0000b6a2 df9ac558 00003243 c2502878 f7dfa000 f7dfbf20
Call Trace:
[<c0149200>] balance_pgdat+0x1c0/0x250
[<c014939b>] kswapd+0x10b/0x160
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0109192>] ret_from_fork+0x6/0x14
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0149290>] kswapd+0x0/0x160
[<c0106f79>] kernel_thread_helper+0x5/0xc

kirqd         S 00000001     8    10      1            14    13 (L-TLB)
c2501fa0 00000046 c2422bc0 00000001 00000003 00000000 d1a49040 00000000
c0109c28 00000000 000000d5 005d2025 c244d2d0 4926873b 03471a9a f77ac6f0
f77ac710 c2422bc0 000006fd 881c4eb1 00003243 c2503b08 03472e23 c2501fb4
Call Trace:
[<c0109c28>] common_interrupt+0x18/0x20
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c012b5b0>] process_timeout+0x0/0x10
[<c0118ee7>] balanced_irq+0x57/0x80
[<c0118e90>] balanced_irq+0x0/0x80
[<c0106f79>] kernel_thread_helper+0x5/0xc

aio/0         S 00000082     0    14      1            15    10 (L-TLB)
f7da9f70 00000046 00000001 00000082 00000001 c244ff68 c02ab560 f7da9f4c
c011d93a c244d900 00000003 00000000 c244ff68 f7da8000 00010000 c244d900
c244d920 c241abc0 000027fb 1965fa0c 00000000 c2502248 f7da8000 00000000
Call Trace:
[<c011d93a>] __wake_up_common+0x3a/0x70
[<c01333e5>] worker_thread+0x285/0x2b0
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0109192>] ret_from_fork+0x6/0x14
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0133160>] worker_thread+0x0/0x2b0
[<c0106f79>] kernel_thread_helper+0x5/0xc

aio/1         S 00000001     0    15      1            16    14 (L-TLB)
f7da5f70 00000046 c2422bc0 00000001 00000003 c244ff68 c02ab560 f7da5f4c
c011d93a c244d900 00000003 00000000 c244ff68 f7da4000 00010000 f7da7960
f7dd7c04 c2422bc0 0000241f 19668d09 00000000 f7da7b28 f7da4000 00000000
Call Trace:
[<c011d93a>] __wake_up_common+0x3a/0x70
[<c01333e5>] worker_thread+0x285/0x2b0
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0109192>] ret_from_fork+0x6/0x14
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0133160>] worker_thread+0x0/0x2b0
[<c0106f79>] kernel_thread_helper+0x5/0xc


kseriod       S 00000001  1688    16      1            17    15 (L-TLB)
c26c9fb0 00000046 c2422bc0 00000001 00000003 e2024870 f68ad760 00000002
e2024000 012aeedc e20248b0 c02be660 c02be8a0 c02be820 00000286 c021ab1a
c02be8a0 c2422bc0 018bda82 3f31580d 0000317e f7da6268 c26c8000 ffffe000
Call Trace:
[<c021ab1a>] serio_find_dev+0x6a/0x70
[<c021adb6>] serio_thread+0x146/0x180
[<c0109192>] ret_from_fork+0x6/0x14
[<c011d8e0>] default_wake_function+0x0/0x20
[<c021ac70>] serio_thread+0x0/0x180
[<c0106f79>] kernel_thread_helper+0x5/0xc

reiserfs/0    S 00000003     0    17      1            18    16 (L-TLB)
c2697f70 00000046 f880b38c 00000003 00000001 00000000 ecec66e0 f880b398
f880b34c 00000292 c01b824f f8831c20 c26dce44 c2696000 c26dce40 cdc9aca0
cdc9acc0 c241abc0 00001bcf c3d3faeb 00001a46 f7da6898 c2696000 c26dce2c
Call Trace:
[<c01b824f>] kupdate_one_transaction+0x12f/0x250
[<c01333e5>] worker_thread+0x285/0x2b0
[<c01b97c0>] reiserfs_journal_commit_task_func+0x0/0x100
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0109192>] ret_from_fork+0x6/0x14
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0133160>] worker_thread+0x0/0x2b0
[<c0106f79>] kernel_thread_helper+0x5/0xc

reiserfs/1    S 00000003     0    18      1            23    17 (L-TLB)
f77e1f70 00000046 f8a272ec 00000003 00000001 00000000 f776fb20 00000000
f8a272ac f77a11f0 c01b824f f77a11f0 c26dcea4 f77e0000 c26dcea0 f38aace0
f38aad00 c2422bc0 00000448 e234458a 00001a55 f7da6ec8 f77e0000 c26dce8c
Call Trace:
[<c01b824f>] kupdate_one_transaction+0x12f/0x250
[<c01333e5>] worker_thread+0x285/0x2b0
[<c01b97c0>] reiserfs_journal_commit_task_func+0x0/0x100
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0109192>] ret_from_fork+0x6/0x14
[<c011d8e0>] default_wake_function+0x0/0x20
[<c0133160>] worker_thread+0x0/0x2b0
[<c0106f79>] kernel_thread_helper+0x5/0xc

devfsd        D 25935C12    16    23      1           610    18 (NOTLB)
f7683bcc 00000086 f5f6b980 25935c12 00003243 c241abc0 f77fb8c0 00000096
f5f6b980 25935ac8 00003243 c02af980 00000001 25935c12 00003243 f5f6b980
f5f6b9a0 c241abc0 00002372 25935f22 00003243 f7757538 03471489 f7683be0
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c0157728>] read_swap_cache_async+0xb8/0xd0
[<c014c903>] swapin_readahead+0x43/0x90
[<c014cb98>] do_swap_page+0x248/0x320
[<c014d4d0>] handle_mm_fault+0xe0/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c0141740>] __alloc_pages+0xa0/0x350
[<c011b858>] recalc_task_prio+0xa8/0x1d0
[<c011d503>] schedule+0x373/0x700
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38
[<c01cc1f6>] __copy_to_user_ll+0x46/0x80
[<c01c161e>] devfsd_read+0x42e/0x4e0
[<c011d8e0>] default_wake_function+0x0/0x20
[<c011d8e0>] default_wake_function+0x0/0x20
[<c015c4a8>] vfs_read+0xb8/0x130
[<c015c752>] sys_read+0x42/0x70
[<c01092bb>] syscall_call+0x7/0xb

syslogd       D 00000001     0   610      1           616    23 (NOTLB)
f71cdcf0 00000086 c241abc0 00000001 00000003 c2422bc0 f77a04a0 00000096
f5f6b980 24068d22 00003243 c02af980 00000001 00000096 f71cc000 f71cc000
f71cdd04 c241abc0 00001cf0 2406959c 00003243 f7da74f8 0347146f f71cdd04
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c013e6a9>] filemap_nopage+0x329/0x3d0
[<c0157728>] read_swap_cache_async+0xb8/0xd0
[<c014c903>] swapin_readahead+0x43/0x90
[<c014cb98>] do_swap_page+0x248/0x320
[<c014d4d0>] handle_mm_fault+0xe0/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c0125b1e>] do_setitimer+0x1be/0x1f0
[<c01086c0>] sys_sigreturn+0xf0/0x110
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38

klogd         D B043E3E1     0   616      1           699   610 (NOTLB)
f7769cf0 00000086 d8460080 b6390e66 00003244 c2422bc0 f7306d60 00000096
d8460080 b6390d6f 00003244 c02af980 00000001 b6390e66 00003244 d8460080
d84600a0 c2422bc0 00001736 bc2e3c36 00003244 f7628838 03472f32 f7769d04
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c0157728>] read_swap_cache_async+0xb8/0xd0
[<c014c903>] swapin_readahead+0x43/0x90
[<c014cb98>] do_swap_page+0x248/0x320
[<c014d4d0>] handle_mm_fault+0xe0/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c011d8e0>] default_wake_function+0x0/0x20
[<c012b4b0>] do_timer+0xc0/0xd0
[<c015c4c2>] vfs_read+0xd2/0x130
[<c015c752>] sys_read+0x42/0x70
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38

ntpd          S 00000001    16   699      1           718   616 (NOTLB)
f735deb0 00000086 c2422bc0 00000001 00000003 00000000 f77a06c0 c02afe00
00000000 00000000 08098478 00000000 f72ecce0 00000010 c02b0700 00000000
000000d0 c2422bc0 00000260 ce28bcca 00003244 f72ecea8 00000000 7fffffff
Call Trace:
[<c012b67e>] schedule_timeout+0xbe/0xc0
[<c022485b>] datagram_poll+0x2b/0xca
[<c021e809>] sock_poll+0x29/0x40
[<c0170f21>] do_select+0x1a1/0x310
[<c0170bb0>] __pollwait+0x0/0xd0
[<c01713cb>] sys_select+0x2fb/0x520
[<c01092bb>] syscall_call+0x7/0xb

sshd          D EBC82985     0   718      1  1051     741   699 (NOTLB)
f77bfc84 00000082 d8460080 ebc82985 00003244 c2422bc0 f77fb040 00000082
d8460080 ebc82884 00003244 c02af980 00000001 f1bd4c48 00003244 d8460080
d84600a0 c2422bc0 00001749 f1bd4e95 00003244 f71f3b28 034732b5 f77bfc98
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c0143bc2>] do_page_cache_readahead+0x172/0x1e0
[<c013e511>] filemap_nopage+0x191/0x3d0
[<c013e380>] filemap_nopage+0x0/0x3d0
[<c014cfd3>] do_no_page+0xd3/0x3c0
[<c014acc7>] pte_alloc_map+0xc7/0x110
[<c014d4f6>] handle_mm_fault+0x106/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c0171334>] sys_select+0x264/0x520
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38



xinetd        D 00000001     0   741      1           758   718 (NOTLB)
f7627c84 00000086 c241abc0 00000001 00000003 f7626000 f77fb6a0 212e541d
00003243 f5f6b980 f5f6b9a0 c241abc0 00015dbd 212e559d 00003243 f7626000
f7627c98 c241abc0 000004c7 212e61bf 00003243 f72ff4b8 03471440 f7627c98
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c0143bc2>] do_page_cache_readahead+0x172/0x1e0
[<c01f5d56>] generic_make_request+0x106/0x190
[<c013e511>] filemap_nopage+0x191/0x3d0
[<c013e380>] filemap_nopage+0x0/0x3d0
[<c014cfd3>] do_no_page+0xd3/0x3c0
[<c014acc7>] pte_alloc_map+0xc7/0x110
[<c014d4f6>] handle_mm_fault+0x106/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c01cc1fa>] __copy_to_user_ll+0x4a/0x80
[<c0171334>] sys_select+0x264/0x520
[<c011d8e0>] default_wake_function+0x0/0x20
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38

svscan        D 00000001     0   758      1   759     785   741 (NOTLB)
f736fcf0 00000082 c241abc0 00000001 00000003 c2422bc0 f776f080 00000096
d8460080 24345b50 00003243 c02af980 00000001 00000096 f736e000 f736e000
f736fd04 c241abc0 00001e2b 24346317 00003243 f72ec878 03471472 f736fd04
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c013e6a9>] filemap_nopage+0x329/0x3d0
[<c0157728>] read_swap_cache_async+0xb8/0xd0
[<c014c903>] swapin_readahead+0x43/0x90
[<c014cb98>] do_swap_page+0x248/0x320
[<c014d4d0>] handle_mm_fault+0xe0/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c012b636>] schedule_timeout+0x76/0xc0
[<c013027e>] sys_rt_sigaction+0xfe/0x120
[<c012b5b0>] process_timeout+0x0/0x10
[<c012b85e>] sys_nanosleep+0x10e/0x1c0
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38

supervise     D 00000001     0   759    758   761     760       (NOTLB)
f6e4fcf0 00000086 c2422bc0 00000001 00000003 f6e4e000 f77a0060 606e7502
00003245 d8460080 d84600a0 c2422bc0 0000dc5d 606e7682 00003245 f6e4e000
f6e4fd04 c2422bc0 00000496 6672deb3 00003245 f72ffae8 03473a5b f6e4fd04
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c013e6a9>] filemap_nopage+0x329/0x3d0
[<c0157728>] read_swap_cache_async+0xb8/0xd0
[<c014c903>] swapin_readahead+0x43/0x90
[<c014cb98>] do_swap_page+0x248/0x320
[<c014d4d0>] handle_mm_fault+0xe0/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c0170ba4>] poll_freewait+0x44/0x50
[<c01719d2>] sys_poll+0x272/0x2c0
[<c0170bb0>] __pollwait+0x0/0xd0
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38

supervise     D 00000001     0   760    758   762           759 (NOTLB)
f6e4dc84 00000082 c241abc0 00000001 00000003 c2422bc0 f7306b40 00000082
f5f6b980 211bd57b 00003243 c02af980 00000001 00000082 f6e4c000 f5f83310
f5f83330 c241abc0 0001b8e4 211bdfd4 00003243 f72fe228 0347143e f6e4dc98
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c0143bc2>] do_page_cache_readahead+0x172/0x1e0
[<c013e511>] filemap_nopage+0x191/0x3d0
[<c013e380>] filemap_nopage+0x0/0x3d0
[<c014cfd3>] do_no_page+0xd3/0x3c0
[<c014acc7>] pte_alloc_map+0xc7/0x110
[<c014d4f6>] handle_mm_fault+0x106/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c0170ba4>] poll_freewait+0x44/0x50
[<c01719d2>] sys_poll+0x272/0x2c0
[<c0170bb0>] __pollwait+0x0/0xd0
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38

dnscache      D A631E98B     0   761    759                     (NOTLB)
f6e2bc84 00000086 d8460080 ac271597 00003245 c2422bc0 f776f2a0 00000082
d8460080 ac271452 00003245 c02af980 00000001 ac271597 00003245 d8460080
d84600a0 c2422bc0 00001661 ac27189b 00003245 f77ad518 03473f51 f6e2bc98
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c0143bc2>] do_page_cache_readahead+0x172/0x1e0
[<c013e511>] filemap_nopage+0x191/0x3d0
[<c013e380>] filemap_nopage+0x0/0x3d0
[<c014cfd3>] do_no_page+0xd3/0x3c0
[<c014acc7>] pte_alloc_map+0xc7/0x110
[<c014d4f6>] handle_mm_fault+0x106/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c0170ba4>] poll_freewait+0x44/0x50
[<c01719d2>] sys_poll+0x272/0x2c0
[<c0170bb0>] __pollwait+0x0/0xd0
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38

multilog      S 00000001  4036   762    760                     (NOTLB)
f6de9eb4 00000086 c2422bc0 00000001 00000003 c013d359 f77a0b00 00000000
f7629900 c1a5c288 c02b0e40 c1a5c288 0001b38a 0001b38a 00000292 c0157bdf
c034dac0 c2422bc0 00000d4b d73a9523 00001a38 f7629ac8 f739b66c f739b600
Call Trace:
[<c013d359>] __lock_page+0xb9/0xd0
[<c0157bdf>] swap_free+0x2f/0x50
[<c0169f8e>] pipe_wait+0x7e/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c016a19f>] pipe_readv+0x1ef/0x2f0
[<c016a2d8>] pipe_read+0x38/0x40
[<c015c4a8>] vfs_read+0xb8/0x130
[<c012f0af>] sys_rt_sigprocmask+0xbf/0x190
[<c015c752>] sys_read+0x42/0x70
[<c01092bb>] syscall_call+0x7/0xb

httpd         D 24562C9D     0   785      1  2898     828   758 (NOTLB)
f72a9c84 00000082 00000000 24562c9d 00003243 c2422bc0 f776fb20 00000082
f5f6b980 24562c9d 00003243 c02af980 00000001 00000082 f72a8000 f7756d40
f7756d60 c241abc0 000072d3 24563c20 00003243 f72fe858 03471475 f72a9c98
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c0143bc2>] do_page_cache_readahead+0x172/0x1e0
[<c013d1b5>] unlock_page+0x15/0x60
[<c013e511>] filemap_nopage+0x191/0x3d0
[<c013e380>] filemap_nopage+0x0/0x3d0
[<c014cfd3>] do_no_page+0xd3/0x3c0
[<c0157bdf>] swap_free+0x2f/0x50
[<c014acc7>] pte_alloc_map+0xc7/0x110
[<c014d4f6>] handle_mm_fault+0x106/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c0170bb0>] __pollwait+0x0/0xd0
[<c0171334>] sys_select+0x264/0x520
c0109d25>] error_code+0x2d/0x38



mysqld_safe   S 00000000     0   835      1   924     851   828 (NOTLB)
f693df50 00000086 7dda6067 00000000 f696bb60 f696bb80 f696bb60 f77acd20
c011a94c f696bb60 f69a9620 080c9f9c 00000001 00000001 080c9f9c f71f26d0
f71f26f0 c241abc0 0001663f 2f2e593c 00000008 f77acee8 fffffe00 f693c000
Call Trace:
[<c011a94c>] do_page_fault+0x33c/0x530
[<c01254ab>] sys_wait4+0x1bb/0x290
[<c011d8e0>] default_wake_function+0x0/0x20
[<c012f0f3>] sys_rt_sigprocmask+0x103/0x190
[<c011d8e0>] default_wake_function+0x0/0x20
[<c01092bb>] syscall_call+0x7/0xb

qmail-send    D 3F7BF822     0   851      1   864     900   835 (NOTLB)
f7603c84 00000086 d8460080 457110f1 00003246 c2422bc0 f696b0c0 00000082
d8460080 45710fc1 00003246 c02af980 00000001 457110f1 00003246 d8460080
d84600a0 c2422bc0 00001710 4b664525 00003246 f72ec248 0347495e f7603c98
Call Trace:
[<c012b62c>] schedule_timeout+0x6c/0xc0
[<c0142b11>] wakeup_bdflush+0x21/0x40
[<c012b5b0>] process_timeout+0x0/0x10
[<c011eb7b>] io_schedule_timeout+0x2b/0x40
[<c01f54a4>] blk_congestion_wait+0x84/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c0148f9f>] try_to_free_pages+0xef/0x190
[<c014187c>] __alloc_pages+0x1dc/0x350
[<c0143bc2>] do_page_cache_readahead+0x172/0x1e0
[<c014ca8f>] do_swap_page+0x13f/0x320
[<c013e511>] filemap_nopage+0x191/0x3d0
[<c013e380>] filemap_nopage+0x0/0x3d0
[<c014cfd3>] do_no_page+0xd3/0x3c0
[<c014acc7>] pte_alloc_map+0xc7/0x110
[<c014d4f6>] handle_mm_fault+0x106/0x1b0
[<c011a94c>] do_page_fault+0x33c/0x530
[<c0171334>] sys_select+0x264/0x520
[<c011a610>] do_page_fault+0x0/0x530
[<c0109d25>] error_code+0x2d/0x38

splogger      S 114C3021  5660   864    851           865       (NOTLB)
f684beb4 00000086 f7da7330 114c3021 02002c19 00000003 f68addc0 00000009
f684bea4 00000000 c021dd7c f684d9a0 00000000 f7140580 f684bf90 f7da7330
f7da7350 c241abc0 00000a82 c14af7c2 000019e4 f684db68 c26e038c c26e0320
Call Trace:
[<c021dd7c>] sockfd_lookup+0x1c/0x80
[<c0169f8e>] pipe_wait+0x7e/0xa0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c01790da>] update_atime+0x9a/0xe0
[<c011fda0>] autoremove_wake_function+0x0/0x50
[<c016a19f>] pipe_readv+0x1ef/0x2f0
[<c016a2d8>] pipe_read+0x38/0x40
[<c015c4a8>] vfs_read+0xb8/0x130
[<c010fa00>] do_gettimeofday+0x20/0xc0
[<c015c752>] sys_read+0x42/0x70
[<c01092bb>] syscall_call+0x7/0xb

qmail-lspawn  S 00000001     0   865    851           866   864 (NOTLB)
f685feb0 00000086 c241abc0 00000001 00000003 c138a310 f689b960 000001d5
f685ff40 00000000 c0141740 c02afe00 00000000 00000000 c14176c1 00000000
f71f2d00 c241abc0 000028b6 c141be0d 000019e4 f71f2ec8 00000000 7fffffff
Call Trace:
[<c0141740>] __alloc_pages+0xa0/0x350
[<c012b67e>] schedule_timeout+0xbe/0xc0

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
