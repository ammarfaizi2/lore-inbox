Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUABXvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 18:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUABXvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 18:51:51 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:13029 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265682AbUABXvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 18:51:49 -0500
Date: Fri, 02 Jan 2004 15:51:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <3390000.1073087505@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bug is on "BUG_ON(!cpus_equal(cpumask, tmp));" in flush_tlb_others
This was from 2.6.1-rc1-mjb1, and seems to be a race on shutdown
(prints after "Power Down"), but I've no reason to believe it's specific
to the patchset I have - it's not an area I'm touching, I think.

I presume we've got a race between taking CPUs offline and the 
tlbflush code ... tlb_flush_mm reads the value from mm->cpu_vm_mask,
and then presumably some other cpu changes cpu_online_map before it
gets to calling flush_tlb_others ... does that sound about right?

M.

------------[ cut here ]------------
kernel BUG at smp.c:361!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0115242>]    Not tainted VLI
EFLAGS: 00010202
EIP is at flush_tlb_others+0x22/0xd0
eax: 00000000   ebx: c3932020   ecx: eca6bd60   edx: 00000004
esi: 00000000   edi: eca6bd80   ebp: eca6bd60   esp: ee4f3e58
ds: 007b   es: 007b   ss: 0068
Process halt (pid: 25304, threadinfo=ee4f2000 task=ee765330)
Stack: c0115366 00000004 eca6bd60 ffffffff 00000004 c01461ab eca6bd60 eca6bd60 
       ee765330 eca6bd80 00000000 c3932020 0000000b c011e1f4 eca6bd60 eca6bd60 
       c0121e8d eca6bd60 fee1dead ee4f2000 bffffe24 ee4f2000 c012c16a 00000000 
       fee1dead 08049960 00000092 ee4f3ed8 c011a4b8 f0191980 00000001 00000000 
Call Trace:
 [<c0115366>] flush_tlb_mm+0x76/0x7c
 [<c01461ab>] exit_mmap+0x11f/0x1cc
 [<c011e1f4>] mmput+0x50/0x70
 [<c0121e8d>] do_exit+0x1b9/0x330
 [<c012c16a>] sys_reboot+0x1f2/0x2f8
 [<c011a4b8>] wake_up_state+0xc/0x10
 [<c0129057>] kill_proc_info+0x37/0x4c
 [<c0129150>] kill_something_info+0xe4/0xec
 [<c012ae18>] sys_kill+0x54/0x5c
 [<c0150a43>] filp_open+0x3b/0x5c
 [<c0150e09>] sys_open+0x59/0x74
 [<c02609ff>] syscall_call+0x7/0xb

Code: f0 0f b3 0d e4 04 36 c0 c3 8b 4c 24 08 8b 44 24 04 89 c2 85 d2 75 08 0f 0b 66 01 e7 a0 26 c0 89 d0 23 05 08 05 36 c0 39 c2 74 0e <0f> 0b 69 01 e7 a0 26 c0 8d b6 00 00 00 00 b8 00 e0 ff ff 21 e0 

