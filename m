Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265897AbUHFM5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUHFM5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 08:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUHFM5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 08:57:52 -0400
Received: from village.ehouse.ru ([193.111.92.18]:34316 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S265897AbUHFM5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 08:57:45 -0400
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc3: Oops: scheduling while atomic under memory pressure
Date: Fri, 6 Aug 2004 16:57:43 +0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408061657.43471.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

following two oopses has occured a few minutes after booting
with latest 2.6.8-rc3 on production web server
(unfortunately, for some reason i had no occasion to test it elsewhere) 
[2xPIII 1GHz, RAM 2G, Red Hat Linux release 7.3 (Valhalla)]
against background of high memory pressure (probably caused 
by multiple apache processes) and very likely irqs
activity (related to some form of syn-flood DDOS attack)


kswapd0: page allocation failure. order:0, mode:0x20
Stack pointer is garbage, not printing trace
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16

Free pages:     1009476kB (828928kB HighMem)
Active:82819 inactive:2229 dirty:0 writeback:0 unstable:0 free:256753 
slab:175625 mapped:82804 pagetables:980
DMA free:44kB min:16kB low:32kB high:48kB active:0kB inactive:0kB 
present:16384kB
protections[]: 8 476 732
Normal free:228376kB min:936kB low:1872kB high:2808kB active:1336kB 
inactive:1288kB present:901120kB
protections[]: 0 468 724
HighMem free:828928kB min:512kB low:1024kB high:1536kB active:329940kB 
inactive:7628kB present:1171392kB
protections[]: 0 0 256
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB = 44kB
Normal: 13220*4kB 9109*8kB 5064*16kB 1737*32kB 324*64kB 42*128kB 8*256kB 
3*512kB 1*1024kB 0*2048kB 0*4096kB = 293080kB
HighMem: 458*4kB 267*8kB 180*16kB 112*32kB 75*64kB 33*128kB 12*256kB 1*512kB 
1*1024kB 1*2048kB 196*4096kB = 828928kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Out of Memory: Killed process 1549 (mysqld).
Out of Memory: Killed process 1698 (mysqld).
Out of Memory: Killed process 1699 (mysqld).
Out of Memory: Killed process 1700 (mysqld).
Out of Memory: Killed process 1701 (mysqld).
Out of Memory: Killed process 1702 (mysqld).
Unable to handle kernel paging request at virtual address 0200f4d8
printing eip:
c0118d01
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter
CPU:    1
EIP:    0060:[<c0118d01>]    Not tainted
EFLAGS: 00010002   (2.6.8-rc3)
EIP is at remove_wait_queue+0x11/0x50
eax: 0200f4d8   ebx: e6413008   ecx: f55ee000   edx: e641300c
esi: e6413000   edi: 00000292   ebp: 00000000   esp: f55eee78
ds: 007b   es: 007b   ss: 0068
Process httpd (pid: 1337, threadinfo=f55ee000 task=f5cf2e70)
Stack: e6413008 e6413000 e6413008 00000000 c016547e 00000000 00000000 00000000
c0165901 f55eeee8 00000000 00000000 00000000 00000004 00000008 00000000
00000000 00000008 f55ee000 e1b3d80c e1b3d808 e1b3d804 e1b3d818 e1b3d814
Call Trace:
[<c016547e>] poll_freewait+0x2e/0x50
[<c0165901>] do_select+0x2e1/0x300
[<c01654a0>] __pollwait+0x0/0xa0
[<c0165937>] select_bits_alloc+0x17/0x20
[<c0165cc8>] sys_select+0x378/0x530
[<c016980d>] dput+0x1d/0x240
[<c0209c55>] release_sock+0x75/0x80
[<c024a8a9>] inet_shutdown+0xb9/0xd0
[<c0207b38>] sys_shutdown+0x38/0x40
[<c010404f>]<1>Unable to handle kernel paging request at virtual address 
a0202e74
printing eip:
c01150ea
*pde = 00000000
syscall_call+0x7/0xb
Code: f0 fe 08 0f 88 cd 1b 00 00 8d 6a 0c 8b 75 04 8b 5a 0c 89 73
<1>Oops: 0000 [#2]
note: httpd[1337] exited with preempt_count 1
bad: scheduling while atomic!
[<c025b3fd>] schedule+0x3d/0x580
[<c014e5ef>] free_pages_and_swap_cache+0x8f/0xb0
[<c01108fc>] flush_tlb_mm+0x9c/0xb0
[<c01436e5>] unmap_vmas+0x1a5/0x240
[<c013f034>] __pagevec_lru_add+0x104/0x120
[<c014785b>] exit_mmap+0x8b/0x170
[<c0103082>] __down_trylock+0x52/0x70
[<c025b31b>] __down_failed_trylock+0x7/0xc
[<c0119136>] mmput+0x66/0x90
[<c011d7c2>] do_exit+0x1d2/0x450
[<c01064d4>] do_IRQ+0x1d4/0x200
[<c01049bc>] common_interrupt+0x18/0x20
[<c011007b>] do_release+0xb/0xf0
[<c01050e2>] die+0xb2/0x110
[<c0114425>] do_page_fault+0x3d5/0x547
[<c01aaf51>] journal_end+0x91/0xa0
[<c0138e31>] buffered_rmqueue+0x1e1/0x1f0
[<c0106453>] do_IRQ+0x153/0x200
[<c0106491>] do_IRQ+0x191/0x200
[<c0115471>] deactivate_task+0x21/0x30
[<c0122ae4>] del_timer_sync+0x94/0xc0
[<c0114050>] do_page_fault+0x0/0x547
[<c0104ab9>] error_code+0x2d/0x38
[<c012007b>] __release_region+0xdb/0x105
[<c0118d01>] remove_wait_queue+0x11/0x50
[<c016547e>] poll_freewait+0x2e/0x50
[<c0165901>] do_select+0x2e1/0x300
[<c01654a0>] __pollwait+0x0/0xa0
[<c0165937>] select_bits_alloc+0x17/0x20
[<c0165cc8>] sys_select+0x378/0x530
[<c016980d>] dput+0x1d/0x240
[<c0209c55>] release_sock+0x75/0x80
[<c024a8a9>] inet_shutdown+0xb9/0xd0
[<c0207b38>] sys_shutdown+0x38/0x40
[<c010404f>] syscall_call+0x7/0xb
PREEMPT SMP
Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter
CPU:    0
EIP:    0060:[<c01150ea>]    Not tainted
EFLAGS: 00010086   (2.6.8-rc3)
EIP is at task_rq_lock+0x1a/0x80
eax: c032eab4   ebx: c0329c80   ecx: 00000001   edx: a0202e70
esi: 00000000   edi: c0332004   ebp: c032ea78   esp: c032ea6c
ds: 007b   es: 007b   ss: 0068
Process httpd (pid: 792, threadinfo=c032e000 task=f7455770)
Stack: 00000000 00000000 f0f0f4dc c032eac4 c0115670 a0202e70 c032eab4 c032eab4
00000001 da99d6ed e696fb20 da99d6ed 0000010e 00000001 c023082f 00000000
da99d6ed 00000001 00000086 00000000 00000000 f0f0f4dc c032eae8 c01174c4
Call Trace:
Stack pointer is garbage, not printing trace
Code: 8b 42 04 8b 40 10 8b 14 87 01 d3 be 00 f0 ff ff 21 e6 ff 46
<0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
 

full trace: 	http://sysadminday.org.ru/white-2.6.8-rc3-Oops/trace
config:         http://sysadminday.org.ru/white-2.6.8-rc3-Oops/config

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
