Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUHARER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUHARER (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 13:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUHARER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 13:04:17 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:30346 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S266034AbUHARDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 13:03:52 -0400
Date: Sun, 1 Aug 2004 19:03:51 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc2 ext3 + nfsv3 fails assertion in __journal_drop_transaction()
Message-ID: <20040801170351.GA28294@MAIL.13thfloor.at>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings!

first, the kernel in question is not a vanilla kernel,
it contains the linux-vserver patches + the namespace
fix (which didn't make it into 2.6.8-rc2), nevertheless
the issue seems not linux-vserver related (though I 
might be completely wrong here ;)

patches used (aside from 2.6.8-rc2):
  
  http://vserver.13thfloor.at/Experimental/patch-2.6.8-rc2-vs1.9.2.14.diff
  http://vserver.13thfloor.at/Experimental/delta-2.6.8-rc2-vs1.9.2.14-vs1.9.2.15.diff
  http://vserver.13thfloor.at/Experimental/namespace-fix-2.6.8-rc2.diff


the issue happens after some time of heavy load, where
the box running this kernel only acts as nfs server for
several clients ...

the failing assertion is always the same, so I would
rule out memory or hardware issues (this is on a dual
PIII machine, 2GB memory, dell Perc/DC raid card)

it was observed with and without PREEMPT and HIGHMEM
it usually happens after 1-4 hours, sometimes it hangs.
a sysrq dump for this case is attached ...
(maybe both issues are totally unrelated, maybe not)

mount options for the ext3 are:  rw,tagxid,data=journal
and for the nfs:  rw,tagxid,intr,tcp,nfsvers=3

any hints would be appreciated ...

TIA,
Herbert

----------

Assertion failure in __journal_drop_transaction() at fs/jbd/checkpoint.c:613: "transaction->t_forget == NULL"
------------[ cut here ]------------
kernel BUG at fs/jbd/checkpoint.c:613!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: megaraid
CPU:	0
EIP:	0060:[__journal_drop_transaction+848/1015]    Not tainted
EFLAGS: 00010286   (2.6.8-rc2-vs1.9.2.15+namespace-fix-filer)
EIP is at __journal_drop_transaction+0x350/0x3f7
eax: 00000071	ebx: dfe41e00	ecx: c03faf64	edx: c03faf64
esi: f7fc3200	edi: d089462c	ebp: dfe41e00	esp: f6c1dd58
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 127, threadinfo=f6c1c000 task=f7899340)
Stack: c03b1c00 c0395d20 c03a8e6e 00000265 c03a8ebe dfe41e00 f7fc3200 c01eb43a
       f7fc3200 dfe41e00 dd5f883c 00000000 c01ea816 d089462c d089462c f6c1c000
       c01eb3e8 d089462c d089462c 00000000 ebf9f300 c0cad300 f6c1c000 00000000
Call Trace:
 [__journal_remove_checkpoint+74/160] __journal_remove_checkpoint+0x4a/0xa0
 [__try_to_free_cp_buf+118/192] __try_to_free_cp_buf+0x76/0xc0
 [__journal_clean_checkpoint_list+168/176] __journal_clean_checkpoint_list+0xa8/0xb0
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [journal_commit_transaction+700/5760] journal_commit_transaction+0x2bc/0x1680
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [kfree_skbmem+36/48] kfree_skbmem+0x24/0x30
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [net_tx_action+90/368] net_tx_action+0x5a/0x170
 [move_tasks+371/608] move_tasks+0x173/0x260
 [recalc_task_prio+168/416] recalc_task_prio+0xa8/0x1a0
 [schedule+767/1616] schedule+0x2ff/0x650
 [del_timer_sync+170/224] del_timer_sync+0xaa/0xe0
 [kjournald+241/736] kjournald+0xf1/0x2e0
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [commit_timeout+0/16] commit_timeout+0x0/0x10
 [kjournald+0/736] kjournald+0x0/0x2e0
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Code: 0f 0b 65 02 6e 8e 3a c0 e9 6e fd ff ff 8d 76 00 c7 04 24 00
 <6>note: kjournald[127] exited with preempt_count 3


--------

Assertion failure in __journal_drop_transaction() at fs/jbd/checkpoint.c:613: "transaction->t_forget == NULL"
------------[ cut here ]------------
kernel BUG at fs/jbd/checkpoint.c:613!
invalid operand: 0000 [#1]
SMP
Modules linked in: megaraid
CPU:    1
EIP:    0060:[<c01df970>]    Not tainted
EFLAGS: 00010282   (2.6.8-rc2-vs1.9.2.15+namespace-fix+disabled-preempt-filer)
EIP is at __journal_drop_transaction+0x350/0x3f7
eax: 00000071   ebx: d51d1e00   ecx: c03e1f64   edx: c03e1f64
esi: f7fcbc00   edi: d487b0bc   ebp: d51d1e00   esp: f5711d80
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 127, threadinfo=f5710000 task=c23cc5e0)
Stack: c0398a40 c037ca80 c038fcae 00000265 c038fcfe d51d1e00 f7fcbc00 c01df4ea
       f7fcbc00 d51d1e00 d48245fc d487b0bc c01debea d487b0bc d487b0bc c01df490
       d487b0bc 00000000 e38bed80 f4fafb00 00000000 00000000 f6cb2f80 f6cb2f80
Call Trace:
 [<c01df4ea>] __journal_remove_checkpoint+0x4a/0xa0
 [<c01debea>] __try_to_free_cp_buf+0x5a/0x90
 [<c01df490>] __journal_clean_checkpoint_list+0x80/0x90
 [<c01dd11e>] journal_commit_transaction+0x1be/0x1235
 [<c011d160>] autoremove_wake_function+0x0/0x60
 [<c0311123>] netif_receive_skb+0x173/0x1b0
 [<c011d160>] autoremove_wake_function+0x0/0x60
 [<c0295286>] tg3_rx+0x2a6/0x3f0
 [<c011aba6>] find_busiest_group+0x2a6/0x340
 [<c011ace0>] find_busiest_queue+0xa0/0xb0
 [<c011aef2>] load_balance_newidle+0x82/0xa0
 [<c0375f3f>] schedule+0x2ef/0x5f0
 [<c01271aa>] del_timer_sync+0xaa/0xc0
 [<c01e07b8>] kjournald+0xd8/0x240
 [<c011d160>] autoremove_wake_function+0x0/0x60
 [<c011d160>] autoremove_wake_function+0x0/0x60
 [<c0106062>] ret_from_fork+0x6/0x14
 [<c01e06c0>] commit_timeout+0x0/0x10
 [<c01e06e0>] kjournald+0x0/0x240
 [<c01042c5>] kernel_thread_helper+0x5/0x10
Code: 0f 0b 65 02 ae fc 38 c0 e9 6e fd ff ff 8d 76 00 c7 04 24 40


>>EIP; c01df970 <__journal_drop_transaction+350/3f7>   <=====

>>ebx; d51d1e00 <pg0+14ce4e00/3fb11000>
>>ecx; c03e1f64 <log_wait+4/c>
>>edx; c03e1f64 <log_wait+4/c>
>>esi; f7fcbc00 <pg0+37adec00/3fb11000>
>>edi; d487b0bc <pg0+1438e0bc/3fb11000>
>>ebp; d51d1e00 <pg0+14ce4e00/3fb11000>
>>esp; f5711d80 <pg0+35224d80/3fb11000>

Trace; c01df4ea <__journal_remove_checkpoint+4a/a0>
Trace; c01debea <__try_to_free_cp_buf+5a/90>
Trace; c01df490 <__journal_clean_checkpoint_list+80/90>
Trace; c01dd11e <journal_commit_transaction+1be/1235>
Trace; c011d160 <autoremove_wake_function+0/60>
Trace; c0311123 <netif_receive_skb+173/1b0>
Trace; c011d160 <autoremove_wake_function+0/60>
Trace; c0295286 <tg3_rx+2a6/3f0>
Trace; c011aba6 <find_busiest_group+2a6/340>
Trace; c011ace0 <find_busiest_queue+a0/b0>
Trace; c011aef2 <load_balance_newidle+82/a0>
Trace; c0375f3f <schedule+2ef/5f0>
Trace; c01271aa <del_timer_sync+aa/c0>
Trace; c01e07b8 <kjournald+d8/240>
Trace; c011d160 <autoremove_wake_function+0/60>
Trace; c011d160 <autoremove_wake_function+0/60>
Trace; c0106062 <ret_from_fork+6/14>
Trace; c01e06c0 <commit_timeout+0/10>
Trace; c01e06e0 <kjournald+0/240>
Trace; c01042c5 <kernel_thread_helper+5/10>

Code;  c01df970 <__journal_drop_transaction+350/3f7>
00000000 <_EIP>:
Code;  c01df970 <__journal_drop_transaction+350/3f7>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01df972 <__journal_drop_transaction+352/3f7>
   2:   65 02 ae fc 38 c0 e9      add    %gs:0xe9c038fc(%esi),%ch
Code;  c01df979 <__journal_drop_transaction+359/3f7>
   9:   6e                        outsb  %ds:(%esi),(%dx)
Code;  c01df97a <__journal_drop_transaction+35a/3f7>
   a:   fd                        std
Code;  c01df97b <__journal_drop_transaction+35b/3f7>
   b:   ff                        (bad)
Code;  c01df97c <__journal_drop_transaction+35c/3f7>
   c:   ff 8d 76 00 c7 04         decl   0x4c70076(%ebp)
Code;  c01df982 <__journal_drop_transaction+362/3f7>
  12:   24 40                     and    $0x40,%al

 
-------

SysRq : Show Regs

Pid: 388, comm:                 nfsd
EIP: 0060:[<c01dcce6>] CPU: 0
EIP is at .text.lock.transaction+0x2/0x18c
 EFLAGS: 00000282    Not tainted  (2.6.8-rc2-vs1.9.2.15+namespace-fix+disabled-preempt-filer)
EAX: f7fcbc00 EBX: f6cb2f80 ECX: f7fcbc00 EDX: 00000800
ESI: 00000000 EDI: f7fcbc00 EBP: c1808a60 DS: 007b ES: 007b
CR0: 8005003b CR2: 4015ea00 CR3: 34cdb000 CR4: 000006d0
 [<c020f048>] find_exported_dentry+0x98/0x650
 [<c027f5e4>] __make_request+0x2c4/0x520
 [<c01da74d>] journal_start+0xad/0xe0
 [<c023170f>] radix_tree_node_alloc+0x1f/0x70
 [<c01cc5d0>] ext3_prepare_write+0x40/0x140
 [<c0140400>] add_to_page_cache+0x60/0xc0
 [<c0142710>] generic_file_aio_write_nolock+0x3d0/0xba0
 [<c030b434>] kfree_skbmem+0x24/0x30
 [<c033273d>] tcp_recvmsg+0x30d/0x760
 [<c0142f50>] generic_file_write_nolock+0x70/0x90
 [<c0143166>] generic_file_writev+0x46/0x60
 [<c01601ec>] do_readv_writev+0x22c/0x280
 [<c0211d50>] nfsd_acceptable+0x0/0x100
 [<c015fbc0>] do_sync_write+0x0/0xb0
 [<c0211d50>] nfsd_acceptable+0x0/0x100
 [<c0160a8d>] open_private_file+0x9d/0xa0
 [<c0160308>] vfs_writev+0x58/0x70
 [<c021418f>] nfsd_write+0x11f/0x360
 [<c036c5cf>] svc_sock_enqueue+0x14f/0x2c0
 [<c021b798>] nfsd3_proc_write+0xb8/0x120
 [<c02100f7>] nfsd_dispatch+0xd7/0x1d5
 [<c0210020>] nfsd_dispatch+0x0/0x1d5
 [<c036c2fa>] svc_process+0x4aa/0x60d
 [<c020fe72>] nfsd+0x1f2/0x3a0
 [<c020fc80>] nfsd+0x0/0x3a0
 [<c01042c5>] kernel_thread_helper+0x5/0x10


