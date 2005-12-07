Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbVLGWh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbVLGWh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbVLGWhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:37:25 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:40611 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751806AbVLGWhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:37:23 -0500
Subject: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andy Whitcroft <andyw@uk.ibm.com>, haveblue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 14:37:40 -0800
Message-Id: <1133995060.21841.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I getting a panic while doing "cat /proc/<pid>/smaps" on
a process. I debugged a little to find out that faulting
IP is in _nr_to_section() - seems to be getting somehow
called by  pte_offset_map_lock() from smaps_pte_range
(which show_smaps) calls.

Any ideas on why or how to debug further ? 

Thanks,
Badari


> dis -l 0xc000000000108380 20

/usr/src/linux-2.6.15-rc4/fs/proc/task_mmu.c: 210 <<<<<<<<<<<<<<
0xc000000000108390 <.show_smap+344>:    rldicr  r0,r0,32,31
0xc000000000108394 <.show_smap+348>:    add     r0,r10,r0
include/linux/mmzone.h: 529
0xc000000000108398 <.show_smap+352>:    rldicl  r9,r0,31,33
/usr/src/linux-2.6.15-rc4/fs/proc/task_mmu.c: 210
0xc00000000010839c <.show_smap+356>:    rldicl  r8,r0,52,12
include/linux/mmzone.h: 528
0xc0000000001083a0 <.show_smap+360>:    rldicl  r0,r0,40,24
include/linux/mmzone.h: 529  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
0xc0000000001083a4 <.show_smap+364>:    rldicr  r9,r9,3,60
0xc0000000001083a8 <.show_smap+368>:    ldx     r11,r9,r11  <<<<<<

 <1>Unable to handle kernel paging request for data at address
0xc0000001006d3698
Faulting instruction address: 0xc0000000001083a8
Oops: Kernel access of bad area, sig: 11 [#3]
SMP NR_CPUS=128 NUMA PSERIES LPAR
Modules linked in: evdev joydev st usbserial ehci_hcd ohci_hcd ipv6
usbcore dm_mod
NIP: C0000000001083A8 LR: C0000000001082A8 CTR: 0000000000000000
REGS: c0000000e17a7860 TRAP: 0300   Not tainted  (2.6.15-rc4)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24000424  XER: 20000010
DAR: C0000001006D3698, DSISR: 0000000040010000
TASK = c0000000d92c07e0[11538] 'cat' THREAD: c0000000e17a4000 CPU: 0
GPR00: 0000004000000600 C0000000E17A7AE0 C000000000635AF8
C0000000E17A7B50
GPR04: 0000000000000000 0000000000000000 C0000000E17A7B78
0000000000000000
GPR08: 0004000000600000 0000000100000018 0000000600000793
C0000000006D3680
GPR12: 0000000022000428 C0000000004DD000 000001003FFFFFFF
C00000000F5FECC0
GPR16: C0000000DA912E00 0000010040000000 000001003FFFFFFF
C0000000D984E100
GPR20: 0000000000000038 0000010040000000 000001000FFFFFFF
C0000000E2A68000
GPR24: 000000001001740A 0000010010000000 C0000000E17A7B50
C0000000E2A68400
GPR28: 0000010000200000 0000010000000000 C00000000055ED50
0000010000000000
NIP [C0000000001083A8] .show_smap+0x170/0x39c
LR [C0000000001082A8] .show_smap+0x70/0x39c
Call Trace:
[C0000000E17A7AE0] [C000000000108544] .show_smap+0x30c/0x39c
(unreliable)
[C0000000E17A7C10] [C0000000000EC2BC] .seq_read+0x4bc/0x510
[C0000000E17A7CF0] [C0000000000BB400] .vfs_read+0x174/0x254
[C0000000E17A7D90] [C0000000000BB5F0] .sys_read+0x54/0x9c
[C0000000E17A7E30] [C000000000008600] syscall_exit+0x0/0x18
Instruction dump:
2faa0000 419e0188 3c004000 e97e8038 7fbfeb78 38e00000 780007c6 7c0a0214
7809f860 7808a302 78004602 79291f24 <7d69582a> 2fab0000 419e000c
78001d28



