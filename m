Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTEYKJV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 06:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTEYKJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 06:09:21 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:27777
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261702AbTEYKJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 06:09:18 -0400
Date: Sun, 25 May 2003 06:11:54 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Manfred Spraul <manfred@colorfullife.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>
Subject: [RFC][PATCH][2.5] Possible race in wait_task_zombie and finish_task_switch
Message-ID: <Pine.LNX.4.50.0305250541550.19617-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a race between callers of wait_task_zombie and a 
processor carrying out a fork, the end result is that the loser ends up 
accessing a freed task_struct. The following scenario has been 
reconstructed based on various oopses and slab debugging messages. Patch 
prepended.

thread of execution 1:
wait_task_zombie() {
	tsk->state = TASK_DEAD;
	/* now assume no other thread will reap this task */
	...
	...
	free_task_struct_memory()
}

thread of execution 2:
ret_from_fork
schedule_tail
finish_task_struct {
	if (prev->state & (TASK_DEAD | TASK_ZOMBIE))
		put_task_struct(prev);
}

Finally, why did the if (prev->state & TASK...) get put there?

debugging messages:
===================================================================================
kernel BUG at kernel/sched.c:746!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c011adbd>]    Not tainted VLI
EFLAGS: 00000246
EIP is at schedule_tail+0xdd/0x130
eax: 00000008   ebx: 00000000   ecx: c5af0180   edx: c5758000
esi: c5af3580   edi: c5ad9d14   ebp: c5759fb8   esp: c5759fb0
ds: 007b   es: 007b   ss: 0068
Process minilogd (pid: 112, threadinfo=c5758000 task=c5f32180)
Stack: c5af3580 c5f32180 c575dfbc c0109c26 c5af3580 01200011 00000000 00000000
       00000000 40016a28 bffffd88 00000000 0000007b 0000007b 00000078 ffffe402
       00000073 00000206 bffffd38 0000007b
Call Trace:
 [<c0109c26>] ret_from_fork+0x6/0x20

Code: 00 85 d2 74 16 89 d6 83 c6 04 19 c9 39 70 18 83 d9 00 85 c9 75 05 8b 
43 7c 89 02 8d 65 f8 5b 5e 5d c3 56 e8 b6 31
 00 00 5a eb c7 <0f> 0b ea 02 ed be 49 c0 eb b3 89 d8 e8 02 60 00 00 eb 97 
e8 9b

Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c0134de6
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0134de6>]    Not tainted VLI
EFLAGS: 00010046
EIP is at detach_pid+0x16/0x170
eax: cb42d360   ebx: 6b6b6b6b   ecx: cb42d410   edx: 0000000a
esi: 6b6b6b6b   edi: cb42d90c   ebp: 00000000   esp: cad47f00
ds: 007b   es: 007b   ss: 0068
Process gkrellmd (pid: 1657, threadinfo=cad46000 task=c9e746b0)
Stack: cb42d310 00000000 cb42d90c 00000000 c012476c cb42d310 c0124871 cb42d310 
       cb42d310 cb42d8d4 cb42d310 000049b7 08057978 00000000 c01268c4 cb42d310 
       08057978 08057978 cb42d3b4 cb42d310 c9e746b0 c9e7474c c0126dd9 cb42d310 
Call Trace:
 [<c012476c>] __unhash_process+0x5c/0xb0
 [<c0124871>] release_task+0xb1/0x290
 [<c01268c4>] wait_task_zombie+0x154/0x1c0
 [<c0126dd9>] sys_wait4+0x259/0x2b0
 [<c011dce0>] default_wake_function+0x0/0x20
 [<c0108931>] sys_sigreturn+0x101/0x170
 [<c011dce0>] default_wake_function+0x0/0x20
 [<c01095d7>] syscall_call+0x7/0xb

Code: be 2b 47 c0 e9 71 ff ff ff 8d b6 00 00 00 00 8d bf 00 00 00 00 8d 14 
92 55 57 8d 04 d0 56 53 8d  

Slab corruption: start=cba072d0, expend=cba078ff, problemat=cba072d8
Data: ********6A 
********************************************************************************** 
Next: 00 00 00 00 00 E0 D4 C6 06 00 00 00 00 01 00 00 00 00 00 00 FF FF FF 
FF 7B 00 00 00 78 00 00  
slab error in check_poison_obj(): cache `task_struct': object was modified after freeing
Call Trace:
 [<c014432c>] check_poison_obj+0x12c/0x170
 [<c01463e7>] kmem_cache_alloc+0x127/0x170
 [<c012042e>] dup_task_struct+0x9e/0xc0
 [<c012042e>] dup_task_struct+0x9e/0xc0
 [<c01212ab>] copy_process+0x7b/0xe30
 [<c012209f>] do_fork+0x3f/0x170
 [<c015dd9f>] sys_llseek+0xcf/0xe0
 [<c01077f7>] sys_fork+0x17/0x20
 [<c0109547>] syscall_call+0x7/0xb

Index: linux-2.5/kernel/sched.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/sched.c,v
retrieving revision 1.175
diff -u -p -B -r1.175 sched.c
--- linux-2.5/kernel/sched.c	19 May 2003 17:46:39 -0000	1.175
+++ linux-2.5/kernel/sched.c	25 May 2003 09:11:38 -0000
@@ -610,8 +610,6 @@ static inline void finish_task_switch(ta
 	finish_arch_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
-	if (prev->state & (TASK_DEAD | TASK_ZOMBIE))
-		put_task_struct(prev);
 }
 
 /**
-- 
function.linuxpower.ca
