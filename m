Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbTLCKFB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 05:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTLCKFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 05:05:01 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:37039 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264527AbTLCKE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 05:04:58 -0500
Date: Wed, 3 Dec 2003 15:38:59 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lhcs-devel@lists.sourceforge.net
Subject: kernel BUG at kernel/exit.c:792!
Message-ID: <20031203153858.C14999@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I hit a kernel BUG while running some stress tests
on a SMP machine. Details are below:

Kernel	:  2.6.0-test9-bk23  + CPU Hotplug Patch
Machine	:  Intel 4-Way SMP box 

I don't think this problem is related in any way to
the CPU Hotplug patch I had applied. It could be hit
w/o that patch applied also(?)


------------[ cut here ]------------
kernel BUG at kernel/exit.c:792!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<c0124026>]    Not tainted
EFLAGS: 00010246
EIP is at next_thread+0x16/0x50
eax: 00000000   ebx: f68726b0   ecx: f68727ac   edx: f6872794
esi: 00006a4e   edi: 00000001   ebp: 00000000   esp: d6b35ed0
ds: 007b   es: 007b   ss: 0068
Process find (pid: 27213, threadinfo=d6b34000 task=ee26e080)
Stack: c0180328 f68726b0 e26a7a80 ed5a0390 00000003 00000000 c0180524 00000003 
       d6b35f14 ed5a0390 d6b35f04 00000000 00000001 00000000 32373200 6a4e3431 
       0000416d 00006a4e 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:
 [<c0180328>] get_tid_list+0x58/0x70
 [<c0180524>] proc_task_readdir+0xc4/0x17c
 [<c01658dc>] vfs_readdir+0x5c/0x70
 [<c0165be0>] filldir64+0x0/0x120
 [<c0165d64>] sys_getdents64+0x64/0xa3
 [<c0165be0>] filldir64+0x0/0x120
 [<c0109291>] sysenter_past_esp+0x52/0x71

Code: 0f 0b 18 03 68 49 38 c0 0f b6 80 04 05 00 00 84 c0 7e 14 a1 

I suspect this is because when read_lock call in 'get_tid_list'
returns, the leader_task had exited already. This
causes the NULL sighand check to fail in the subsequent call
to 'next_thread' ?

Does it make sense to check for leader_task being alive
after the tasklist lock is grabbed and return immediately
if it is not alive (as the patch below does)?



 fs/proc/base.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN fs/proc/base.c~proc-get_tid_list-fix fs/proc/base.c
--- linux-2.6.0-test11/fs/proc/base.c~proc-get_tid_list-fix	2003-12-03 14:55:53.000000000 +0530
+++ linux-2.6.0-test11-vatsa/fs/proc/base.c	2003-12-03 14:56:20.000000000 +0530
@@ -1666,6 +1666,8 @@ static int get_tid_list(int index, unsig
 
 	index -= 2;
 	read_lock(&tasklist_lock);
+	if (!pid_alive(task))
+		goto exit;
 	do {
 		int tid = task->pid;
 		if (!pid_alive(task))
@@ -1677,6 +1679,7 @@ static int get_tid_list(int index, unsig
 		if (nr_tids >= PROC_MAXPIDS)
 			break;
 	} while ((task = next_thread(task)) != leader_task);
+exit:
 	read_unlock(&tasklist_lock);
 	return nr_tids;
 }

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560033
