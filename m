Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263982AbUDNI5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbUDNI5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:57:34 -0400
Received: from village.ehouse.ru ([193.111.92.18]:6151 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S263982AbUDNI5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:57:23 -0400
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-aa3: kernel BUG at mm/objrmap.c:137!
Date: Wed, 14 Apr 2004 12:57:16 +0400
User-Agent: KMail/1.6.1
Cc: Andrea Arcangeli <andrea@suse.de>, admin@list.net.ru
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141257.16731.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'Day,

I've got a bug on 2.6.5-aa3 today

System: Dual P4 Xeon 2.4GHz, 4G ECC RAM - (production web-server) pretty
	heavy loaded at most time, but i've got it approximately 
	at 02:00 (MSD) when no serious load should be.
	System remained accessible all the time but operations
	with proclist from userspace (i.e. ps, w) appears to be locked. 

Here is a trace:

kernel BUG at mm/objrmap.c:137!
invalid operand: 0000 [#1]
PREEMPT SMP
CPU:    1
EIP:    0060:[<c0148ebb>]    Not tainted
EFLAGS: 00010282   (2.6.5-aa3)
EIP is at page_referenced_one+0x8c/0x96
eax: dafaaae0   ebx: dafaaae0   ecx: 00000000   edx: c19ef4a0
esi: 00000000   edi: dade48c4   ebp: c19ef4a0   esp: e9049c0c
ds: 007b   es: 007b   ss: 0068
Process apache2 (pid: 29070, threadinfo=e9048000 task=cf0e8630)
Stack: dafaaae0 f4531e30 00000000 f4531e2c c0149073 c19ef4a0 00000001 c02d2d00
       e9048000 00000166 c0149103 c19ef4a0 c013ff58 00000000 00000000 c02d2e04
       00000001 00000000 00000000 e9049d30 00000166 c1a59890 c1841cd0 e9049c68
Call Trace:
 [<c0149073>] page_referenced_anon+0x45/0x94
 [<c0149103>] page_referenced+0x41/0x4d
 [<c013ff58>] refill_inactive_zone+0x56c/0x678
 [<c0140123>] shrink_zone+0xbf/0xc1
 [<c014019d>] shrink_caches+0x78/0x7c
 [<c014023b>] try_to_free_pages+0x9a/0x141
 [<c0138f68>] __alloc_pages+0x1cb/0x30a
 [<c0144594>] do_anonymous_page+0x82/0x246
 [<c027fbe2>] inet_recvmsg+0x4a/0x69
 [<c01447b5>] do_no_page+0x5d/0x58c
 [<c0144ed8>] handle_mm_fault+0xe2/0x17b
 [<c0115752>] do_page_fault+0x2eb/0x4d2
 [<c015384d>] vfs_read+0xbc/0xf5
 [<c0115467>] do_page_fault+0x0/0x4d2
 [<c0107789>] error_code+0x2d/0x38

Code: 0f 0b 89 00 a9 20 2a c0 eb e1 55 31 ed 57 89 c7 56 53 83 ec
 <6>note: apache2[29070] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c01182a4>] schedule+0x6a1/0x6a6
 [<c012c2be>] rcu_process_callbacks+0x13a/0x169
 [<c012c2be>] rcu_process_callbacks+0x13a/0x169
 [<c01208f8>] tasklet_action+0x5f/0xa5
 [<c01c9261>] rwsem_down_read_failed+0xa5/0x155
 [<c012f5d4>] .text.lock.futex+0x7/0xb3
 [<c0111b86>] delay_tsc+0xb/0x15
 [<c012f4a5>] do_futex+0x6b/0x6d
 [<c012f5a1>] sys_futex+0xfa/0x112
 [<c011cc90>] call_console_drivers+0x77/0xfc
 [<c011a872>] mm_release+0x96/0xa6
 [<c011ea17>] do_exit+0x84/0x4d9
 [<c029007b>] packet_ioctl+0x1f/0x192
 [<c0107de2>] do_divide_error+0x0/0xd3
 [<c010805c>] do_invalid_op+0x0/0xaa
 [<c0108104>] do_invalid_op+0xa8/0xaa
 [<c0148ebb>] page_referenced_one+0x8c/0x96
 [<c0117642>] scheduler_tick+0x3b/0x5f7
 [<c0116451>] recalc_task_prio+0x8c/0x1a6
 [<c0107789>] error_code+0x2d/0x38
 [<c014007b>] shrink_zone+0x17/0xc1
 [<c0148ebb>] page_referenced_one+0x8c/0x96
 [<c0149073>] page_referenced_anon+0x45/0x94
 [<c0149103>] page_referenced+0x41/0x4d
 [<c013ff58>] refill_inactive_zone+0x56c/0x678
 [<c0140123>] shrink_zone+0xbf/0xc1
 [<c014019d>] shrink_caches+0x78/0x7c
 [<c014023b>] try_to_free_pages+0x9a/0x141
 [<c0138f68>] __alloc_pages+0x1cb/0x30a
 [<c0144594>] do_anonymous_page+0x82/0x246
 [<c027fbe2>] inet_recvmsg+0x4a/0x69
 [<c01447b5>] do_no_page+0x5d/0x58c
 [<c0144ed8>] handle_mm_fault+0xe2/0x17b
 [<c0115752>] do_page_fault+0x2eb/0x4d2
 [<c015384d>] vfs_read+0xbc/0xf5
 [<c0115467>] do_page_fault+0x0/0x4d2
 [<c0107789>] error_code+0x2d/0x38
	
& some (probably) useful info:

cpuinfo: 	http://sysadminday.org.ru/objrmap_bug/cpuinfo
lspci:		http://sysadminday.org.ru/objrmap_bug/lspci 
lspci -vvn	http://sysadminday.org.ru/objrmap_bug/lspci-vvn
full_trace (including initial boot,SysRq-[M,P,T])
		http://sysadminday.org.ru/objrmap_bug/full_trace

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
