Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262690AbTCJCTZ>; Sun, 9 Mar 2003 21:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262691AbTCJCTZ>; Sun, 9 Mar 2003 21:19:25 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:3734 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262690AbTCJCTN>;
	Sun, 9 Mar 2003 21:19:13 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: 2.5.64-mm2->4 hangs on contest
Date: Mon, 10 Mar 2003 13:29:10 +1100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303101329.10967.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried running contest on 2.5.64-mm2 and mm4 and had the same thing happen. It 
will hang reliably during process_load. I tried not running process_load but 
it would still get stuck in one of the other loads (either a tar load or list 
load). I can simply stop contest at that stage but then the machine wont work 
well hanging at the console after a minute or so. This started at mm2 
(doesn't happen with mm1).

Here is the sysrq-p and sysrq-t output during process_load (which hangs every 
time):

SysRq : Show Regs

Pid: 3476, comm:              contest
EIP: 0060:[<c0112d5d>] CPU: 0
EIP is at do_schedule+0x2a9/0x338
 EFLAGS: 00000286    Not tainted
EAX: ffffe000 EBX: 00000000 ECX: cfbf3620 EDX: 00000000
ESI: cf939b00 EDI: cfbf3300 EBP: cfa03f0c DS: 007b ES: 007b
CR0: 8005003b CR2: 080ac328 CR3: 0fa84000 CR4: 00000690
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0147314>] pipe_write+0x1d0/0x288
 [<c013d835>] vfs_write+0xa9/0x140
 [<c013d932>] sys_write+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb


SysRq : Show State
                                               sibling
  task             PC      pid father child younger older
init          S 00C03C88     1      0     2               (NOTLB)
Call Trace:
 [<c011c568>] schedule_timeout+0x84/0xac
 [<c011c4d8>] process_timeout+0x0/0xc
 [<c014c780>] do_select+0x1cc/0x208
 [<c014c474>] __pollwait+0x0/0x98
 [<c014cb2a>] sys_select+0x346/0x480
 [<c0108b07>] syscall_call+0x7/0xb

ksoftirqd/0   R C129A000     2      1             3       (L-TLB)
Call Trace:
 [<c0118f3e>] ksoftirqd+0x5e/0x9c
 [<c0118ee0>] ksoftirqd+0x0/0x9c
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

events/0      S CFFF3768     3      1             4     2 (L-TLB)
Call Trace:
 [<c0121a9a>] worker_thread+0x102/0x274
 [<c0121998>] worker_thread+0x0/0x274
 [<c0239584>] flush_to_ldisc+0x0/0xd8
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

pdflush       S CFE21FD8     4      1             5     3 (L-TLB)
Call Trace:
 [<c012af25>] __pdflush+0x95/0x1ac
 [<c012b03c>] pdflush+0x0/0x14
 [<c012b047>] pdflush+0xb/0x14
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

pdflush       S CFE1FFD8     5      1             6     4 (L-TLB)
Call Trace:
 [<c012af25>] __pdflush+0x95/0x1ac
 [<c012b03c>] pdflush+0x0/0x14
 [<c012b047>] pdflush+0xb/0x14
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

kswapd0       S CFE0FF48     6      1             7     5 (L-TLB)
Call Trace:
 [<c012ef27>] kswapd+0xd3/0xf0
 [<c012ee54>] kswapd+0x0/0xf0
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

aio/0         S CFE0BFDC     7      1             8     6 (L-TLB)
Call Trace:
 [<c0121a9a>] worker_thread+0x102/0x274
 [<c0121998>] worker_thread+0x0/0x274
 [<c01089e6>] ret_from_fork+0x6/0x14
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

jfsIO         S 00000000     8      1             9     7 (L-TLB)
Call Trace:
 [<c01c6d8b>] jfsIOWait+0x10b/0x144
 [<c01c6c80>] jfsIOWait+0x0/0x144
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

jfsCommit     S C13B3FDC     9      1            10     8 (L-TLB)
Call Trace:
 [<c01c9985>] jfs_lazycommit+0x169/0x1a4
 [<c01c981c>] jfs_lazycommit+0x0/0x1a4
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

jfsSync       S C13B1FDC    10      1            11     9 (L-TLB)
Call Trace:
 [<c01c9e56>] jfs_sync+0x1e6/0x21c
 [<c01c9c70>] jfs_sync+0x0/0x21c
 [<c01c9c70>] jfs_sync+0x0/0x21c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

pagebuf/0     S C13AFFDC    11      1            12    10 (L-TLB)
Call Trace:
 [<c0121a9a>] worker_thread+0x102/0x274
 [<c0121998>] worker_thread+0x0/0x274
 [<c01089e6>] ret_from_fork+0x6/0x14
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

pagebufd      S 00000286    12      1            13    11 (L-TLB)
Call Trace:
 [<c01130d5>] interruptible_sleep_on+0x5d/0x84
 [<c021b450>] pagebuf_daemon+0x0/0x1f0
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c021b4d3>] pagebuf_daemon+0x83/0x1f0
 [<c021b450>] pagebuf_daemon+0x0/0x1f0
 [<c021b424>] pagebuf_daemon_wakeup+0x0/0x2c
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

kseriod       S CFDBA000    13      1            14    12 (L-TLB)
Call Trace:
 [<c02729a7>] serio_thread+0x9b/0x124
 [<c027290c>] serio_thread+0x0/0x124
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

kjournald     D 00000286    14      1           148    13 (L-TLB)
Call Trace:
 [<c01131e7>] sleep_on+0x5b/0x84
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0177d84>] journal_commit_transaction+0x154/0xe2d
 [<c0112d40>] do_schedule+0x28c/0x338
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c017a5c6>] kjournald+0x106/0x1ec
 [<c017a4c0>] kjournald+0x0/0x1ec
 [<c017a4b0>] commit_timeout+0x0/0xc
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

devfsd        S C03050EC   148      1           313    14 (NOTLB)
Call Trace:
 [<c0184f07>] devfsd_read+0xe7/0x414
 [<c014fe26>] dput+0x1a/0x1a0
 [<c0147e51>] path_release+0xd/0x2c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

kjournald     S 00000286   313      1           314   148 (L-TLB)
Call Trace:
 [<c0108c74>] common_interrupt+0x18/0x20
 [<c01130d5>] interruptible_sleep_on+0x5d/0x84
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c017a5fb>] kjournald+0x13b/0x1ec
 [<c017a4c0>] kjournald+0x0/0x1ec
 [<c017a4b0>] commit_timeout+0x0/0xc
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

kjournald     S 00000286   314      1           315   313 (L-TLB)
Call Trace:
 [<c01130d5>] interruptible_sleep_on+0x5d/0x84
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c017a5fb>] kjournald+0x13b/0x1ec
 [<c017a4c0>] kjournald+0x0/0x1ec
 [<c017a4b0>] commit_timeout+0x0/0xc
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

reiserfs/0    S CF0E5FDC   315      1           655   314 (L-TLB)
Call Trace:
 [<c0121a9a>] worker_thread+0x102/0x274
 [<c0121998>] worker_thread+0x0/0x274
 [<c01089e6>] ret_from_fork+0x6/0x14
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0106f1d>] kernel_thread_helper+0x5/0xc

dhcpcd        S 05224927   655      1           736   315 (NOTLB)
Call Trace:
 [<c012518b>] do_clock_nanosleep+0x1cb/0x2c0
 [<c0124dd8>] nanosleep_wake_up+0x0/0xc
 [<c0124e9a>] sys_nanosleep+0x62/0xb4
 [<c0108b07>] syscall_call+0x7/0xb

syslogd       D 00000286   736      1           744   655 (NOTLB)
Call Trace:
 [<c01131e7>] sleep_on+0x5b/0x84
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0175d36>] start_this_handle+0xfa/0x1a0
 [<c0175eb0>] journal_start+0x8c/0xb8
 [<c016e9a0>] ext3_dirty_inode+0x68/0x10c
 [<c01574e1>] __mark_inode_dirty+0x31/0xdc
 [<c0152a89>] inode_update_time+0x85/0x90
 [<c012812c>] generic_file_aio_write_nolock+0x360/0x994
 [<c0274fd2>] __sock_recvmsg+0x56/0xc8
 [<c0112d40>] do_schedule+0x28c/0x338
 [<c01287cf>] generic_file_write_nolock+0x6f/0x8c
 [<c027613d>] sys_recvfrom+0xad/0x104
 [<c0276183>] sys_recvfrom+0xf3/0x104
 [<c0112d40>] do_schedule+0x28c/0x338
 [<c0128985>] generic_file_writev+0x31/0x44
 [<c013d6dc>] do_sync_write+0x0/0xb0
 [<c013dbe3>] do_readv_writev+0x1bf/0x2dc
 [<c0276864>] sys_socketcall+0x174/0x218
 [<c013dd97>] vfs_writev+0x4b/0x50
 [<c013de02>] sys_writev+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

klogd         S 00000001   744      1           781   736 (NOTLB)
Call Trace:
 [<c011c4f8>] schedule_timeout+0x14/0xac
 [<c02b6a7c>] unix_wait_for_peer+0xac/0xc8
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c02b74af>] unix_dgram_sendmsg+0x2ff/0x400
 [<c0274ec0>] __sock_sendmsg+0xb0/0xdc
 [<c0275226>] sock_aio_write+0xae/0xb8
 [<c013d75d>] do_sync_write+0x81/0xb0
 [<c01319f5>] handle_mm_fault+0x6d/0x124
 [<c0111550>] do_page_fault+0x0/0x404
 [<c013d848>] vfs_write+0xbc/0x140
 [<c013d932>] sys_write+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

sshd          S CFDEB8A0   781      1   916     907   744 (NOTLB)
Call Trace:
 [<c028e4d5>] tcp_poll+0x2d/0x154
 [<c011c4f8>] schedule_timeout+0x14/0xac
 [<c02755d9>] sock_poll+0x1d/0x24
 [<c014c6b2>] do_select+0xfe/0x208
 [<c014c780>] do_select+0x1cc/0x208
 [<c014c474>] __pollwait+0x0/0x98
 [<c014cb2a>] sys_select+0x346/0x480
 [<c0108b07>] syscall_call+0x7/0xb

mingetty      S CFDEBD20   907      1           908   781 (NOTLB)
Call Trace:
 [<c026fe97>] vgacon_cursor+0x1cf/0x1d8
 [<c011c4f8>] schedule_timeout+0x14/0xac
 [<c023bc14>] read_chan+0x3b4/0x82c
 [<c023bc64>] read_chan+0x404/0x82c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0237784>] tty_read+0xd0/0x138
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

mingetty      S CFDEBF20   908      1           909   907 (NOTLB)
Call Trace:
 [<c01318a6>] do_no_page+0x2ea/0x2f8
 [<c011c4f8>] schedule_timeout+0x14/0xac
 [<c023bc14>] read_chan+0x3b4/0x82c
 [<c023bc64>] read_chan+0x404/0x82c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0237784>] tty_read+0xd0/0x138
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

mingetty      S CFDEBE20   909      1           910   908 (NOTLB)
Call Trace:
 [<c01318a6>] do_no_page+0x2ea/0x2f8
 [<c011c4f8>] schedule_timeout+0x14/0xac
 [<c023bc14>] read_chan+0x3b4/0x82c
 [<c023bc64>] read_chan+0x404/0x82c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0237784>] tty_read+0xd0/0x138
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

mingetty      S CFDEB820   910      1           911   909 (NOTLB)
Call Trace:
 [<c01318a6>] do_no_page+0x2ea/0x2f8
 [<c011c4f8>] schedule_timeout+0x14/0xac
 [<c023bc14>] read_chan+0x3b4/0x82c
 [<c023bc64>] read_chan+0x404/0x82c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0237784>] tty_read+0xd0/0x138
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

mingetty      S CFDEB320   911      1           912   910 (NOTLB)
Call Trace:
 [<c01318a6>] do_no_page+0x2ea/0x2f8
 [<c011c4f8>] schedule_timeout+0x14/0xac
 [<c023bc14>] read_chan+0x3b4/0x82c
 [<c023bc64>] read_chan+0x404/0x82c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0237784>] tty_read+0xd0/0x138
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

mingetty      S CFA781C0   912      1          3431   911 (NOTLB)
Call Trace:
 [<c01318a6>] do_no_page+0x2ea/0x2f8
 [<c011c4f8>] schedule_timeout+0x14/0xac
 [<c023bc14>] read_chan+0x3b4/0x82c
 [<c023bc64>] read_chan+0x404/0x82c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0237784>] tty_read+0xd0/0x138
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

sshd          S CFDEB3A0   916    781   918               (NOTLB)
Call Trace:
 [<c011c4f8>] schedule_timeout+0x14/0xac
 [<c0147455>] pipe_poll+0x25/0x64
 [<c014c6b2>] do_select+0xfe/0x208
 [<c014c780>] do_select+0x1cc/0x208
 [<c014c474>] __pollwait+0x0/0x98
 [<c014cb2a>] sys_select+0x346/0x480
 [<c0108b07>] syscall_call+0x7/0xb

bash          S CEEB67BC   918    916  3435               (NOTLB)
Call Trace:
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c0117f7d>] sys_wait4+0x201/0x234
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0108b07>] syscall_call+0x7/0xb

agetty        S CCA37000  3431      1                 912 (NOTLB)
Call Trace:
 [<c011c4f8>] schedule_timeout+0x14/0xac
 [<c023bc14>] read_chan+0x3b4/0x82c
 [<c023bc64>] read_chan+0x404/0x82c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0237784>] tty_read+0xd0/0x138
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

contest       S CEEB73FC  3435    918  3475               (NOTLB)
Call Trace:
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c0117f7d>] sys_wait4+0x201/0x234
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0108b07>] syscall_call+0x7/0xb

contest       S CEEB6DDC  3475   3435  3476    3480       (NOTLB)
Call Trace:
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c0117f7d>] sys_wait4+0x201/0x234
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0108b07>] syscall_call+0x7/0xb

contest       S CF77210C  3476   3475  3477               (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

contest       S CF77268C  3477   3476          3478       (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

contest       S CF7723CC  3478   3476          3479  3477 (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0147314>] pipe_write+0x1d0/0x288
 [<c013d835>] vfs_write+0xa9/0x140
 [<c013d932>] sys_write+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

contest       R current   3479   3476                3478 (NOTLB)
Call Trace:
 [<c0112e14>] preempt_schedule+0x28/0x44
 [<c0112ef1>] __wake_up+0x55/0x60
 [<c0147379>] pipe_write+0x235/0x288
 [<c013d835>] vfs_write+0xa9/0x140
 [<c013d932>] sys_write+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

make          S CF735E8C  3480   3435  3498          3475 (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

make          S CC9261DC  3498   3480  3505    3508       (NOTLB)
Call Trace:
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c0117f7d>] sys_wait4+0x201/0x234
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0108b07>] syscall_call+0x7/0xb

make          S CF735E8C  3505   3498  3570               (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

make          S CF735E8C  3508   3480  3513    3519  3498 (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

make          S C4C9871C  3513   3508  3514               (NOTLB)
Call Trace:
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c0117f7d>] sys_wait4+0x201/0x234
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0108b07>] syscall_call+0x7/0xb

make          S C4C980FC  3514   3513  3564               (NOTLB)
Call Trace:
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c0117f7d>] sys_wait4+0x201/0x234
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0108b07>] syscall_call+0x7/0xb

make          S CEA127DC  3519   3480  3520    3527  3508 (NOTLB)
Call Trace:
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c0117f7d>] sys_wait4+0x201/0x234
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0108b07>] syscall_call+0x7/0xb

make          S CF735E8C  3520   3519  3574               (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

make          S CF735E8C  3527   3480  3533          3519 (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

make          S CF210D5C  3533   3527  3539               (NOTLB)
Call Trace:
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c0117f7d>] sys_wait4+0x201/0x234
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0108b07>] syscall_call+0x7/0xb

make          S CF735E8C  3539   3533  3540               (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

gcc           S C45199BC  3540   3539  3541               (NOTLB)
Call Trace:
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c0117f7d>] sys_wait4+0x201/0x234
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0108b07>] syscall_call+0x7/0xb

cpp0          R C911BE18  3541   3540          3542       (NOTLB)
Call Trace:
 [<c0113a7a>] io_schedule+0xe/0x18
 [<c01269b4>] __lock_page+0x90/0xac
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0126e2e>] do_generic_mapping_read+0x132/0x328
 [<c01272ad>] __generic_file_aio_read+0x195/0x1b0
 [<c0127024>] file_read_actor+0x0/0xf4
 [<c012730d>] generic_file_aio_read+0x45/0x50
 [<c013d569>] do_sync_read+0x81/0xb4
 [<c0145121>] sys_fstat64+0x25/0x30
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

cc1           S CF728A6C  3542   3540          3543  3541 (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

as            S CF728BCC  3543   3540                3542 (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

gcc           S CF21199C  3564   3514  3565               (NOTLB)
Call Trace:
 [<c0117e27>] sys_wait4+0xab/0x234
 [<c0117f7d>] sys_wait4+0x201/0x234
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0108b07>] syscall_call+0x7/0xb

cpp0          S CFDE93AC  3565   3564          3566       (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0147314>] pipe_write+0x1d0/0x288
 [<c013d835>] vfs_write+0xa9/0x140
 [<c013d932>] sys_write+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

cc1           R BFFFEA40  3566   3564          3567  3565 (NOTLB)
Call Trace:
 [<c0112fa4>] user_schedule+0x8/0xc
 [<c0108b2e>] work_resched+0x5/0x16

as            S CFDE90EC  3567   3564                3566 (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01470e0>] pipe_read+0x1a0/0x204
 [<c013d645>] vfs_read+0xa9/0x140
 [<c013d8f6>] sys_read+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

gcc           D CDBCBF68  3570   3505  3571               (NOTLB)
Call Trace:
 [<c0113035>] wait_for_completion+0x8d/0xd0
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c011568f>] do_fork+0x10f/0x14c
 [<c0107627>] sys_vfork+0x1b/0x2c
 [<c0108b07>] syscall_call+0x7/0xb

cpp0          Z CFFF9820  3571   3570          3572       (L-TLB)
Call Trace:
 [<c01178d1>] do_exit+0x331/0x344
 [<c011790a>] sys_exit+0xe/0x10
 [<c0108b07>] syscall_call+0x7/0xb

cc1           S CF72EACC  3572   3570          3573  3571 (NOTLB)
Call Trace:
 [<c0146f1f>] pipe_wait+0x6f/0x90
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0147314>] pipe_write+0x1d0/0x288
 [<c013d835>] vfs_write+0xa9/0x140
 [<c013d932>] sys_write+0x2a/0x3c
 [<c0108b07>] syscall_call+0x7/0xb

gcc           R CD859B60  3573   3570                3572 (NOTLB)
Call Trace:
 [<c0113a7a>] io_schedule+0xe/0x18
 [<c013e754>] __wait_on_buffer+0x78/0x94
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c0114114>] autoremove_wake_function+0x0/0x38
 [<c01761ec>] do_get_write_access+0x68/0x5a4
 [<c013f8a0>] __bread+0x14/0x30
 [<c0176760>] journal_get_write_access+0x38/0x58
 [<c016e88a>] ext3_reserve_inode_write+0x32/0xac
 [<c0175d93>] start_this_handle+0x157/0x1a0
 [<c016e91e>] ext3_mark_inode_dirty+0x1a/0x34
 [<c016e9cf>] ext3_dirty_inode+0x97/0x10c
 [<c01574e1>] __mark_inode_dirty+0x31/0xdc
 [<c01529c8>] update_atime+0x88/0xc4
 [<c0127016>] do_generic_mapping_read+0x31a/0x328
 [<c01272ad>] __generic_file_aio_read+0x195/0x1b0
 [<c0127024>] file_read_actor+0x0/0xf4
 [<c012730d>] generic_file_aio_read+0x45/0x50
 [<c013d569>] do_sync_read+0x81/0xb4
 [<c012c0b6>] cache_grow+0x156/0x200
 [<c012c297>] cache_alloc_refill+0x137/0x174
 [<c013d645>] vfs_read+0xa9/0x140
 [<c0145aac>] kernel_read+0x40/0x4c
 [<c014643d>] prepare_binprm+0xa5/0xb0
 [<c0146809>] do_execve+0x125/0x208
 [<c0107667>] sys_execve+0x2f/0x68
 [<c0108b07>] syscall_call+0x7/0xb

make          D 00000286  3574   3520                     (NOTLB)
Call Trace:
 [<c01131e7>] sleep_on+0x5b/0x84
 [<c0112e30>] default_wake_function+0x0/0x1c
 [<c0175d36>] start_this_handle+0xfa/0x1a0
 [<c0175eb0>] journal_start+0x8c/0xb8
 [<c016e9a0>] ext3_dirty_inode+0x68/0x10c
 [<c01574e1>] __mark_inode_dirty+0x31/0xdc
 [<c01529c8>] update_atime+0x88/0xc4
 [<c0148841>] link_path_walk+0x601/0x7fc
 [<c0148d25>] path_lookup+0x139/0x140
 [<c01459cf>] open_exec+0x1b/0xb8
 [<c0146702>] do_execve+0x1e/0x208
 [<c0129a5d>] buffered_rmqueue+0xe9/0xf4
 [<c0129aea>] __alloc_pages+0x82/0x274
 [<c012dc41>] invalidate_vcache+0x19/0x88
 [<c0130e91>] do_wp_page+0x325/0x330
 [<c0131a4d>] handle_mm_fault+0xc5/0x124
 [<c0111682>] do_page_fault+0x132/0x404
 [<c0111550>] do_page_fault+0x0/0x404
 [<c0129967>] free_hot_page+0x7/0x8
 [<c014fe26>] dput+0x1a/0x1a0
 [<c011f652>] sys_rt_sigaction+0x7a/0xd4
 [<c0147c2d>] getname+0x5d/0x9c
 [<c0107667>] sys_execve+0x2f/0x68
 [<c0108b07>] syscall_call+0x7/0xb

Con
