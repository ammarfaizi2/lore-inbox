Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTDGNwF (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbTDGNwF (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:52:05 -0400
Received: from unknown.Level3.net ([63.210.233.185]:19165 "EHLO
	cinshrexc03.shermfin.com") by vger.kernel.org with ESMTP
	id S263444AbTDGNwB (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 09:52:01 -0400
Subject: [BUG] vmalloc.c:253 with highmem, LVM, and snapshots
From: Andrew Rechenberg <arechenberg@shermfin.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Infrastrucutre Team, Sherman Financial Group
Message-Id: <1049724171.12884.88.camel@cinshrlnxws01.shermfin.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Apr 2003 10:02:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A thread on the LVM mailing list
(http://marc.theaimsgroup.com/?l=linux-lvm&m=103577962720526&w=2)
indicated that there may a problem
with the kernel highmem support so I'm posting here to see if anyone
can help me fix it.  I have a Dell PowerEdge 6600 with 8GB RAM and
when trying to create a snapshot of a logical volume the lvcreate
command fails with a segmentation fault.

The workaround I used was to limit the system memory to ~6GB (used
mem=6000M on the kernel command line in grub.conf).  The lvcreate
command did not fail with mem=6000M.  I would like to use the entire
8GB (and actually more as I would like to make a 1GB ramdisk for some
temp space).  Turning off hyperThreading and/or SMP did not prevent
the seg fault for me when creating the snapshot

Below are the specs for my machine and the output from ksymoops for
the segmentation fault.  This machine is currently in production, but
I have a test box with 4GB and RAM and I should be able to grab an
additional 4GB for testing purposes.

If anyone has any suggestions or possible patches to fix this issues
please CC: me on any responses.

Thanks in adavance,
Andy.

------------------------------------------

Dell PowerEdge 6600
Quad Xeon 1.4GHz with HT enabled
8GB RAM (currently limited to 6GB with mem=6000M)
RH 7.3
Kernel 2.4.18-27.SHRbigmem
  - custom RPM based on RH kernel 2.4.18-27.7.x source
  - LVM 1.0.7 patch
  - MegaRAID 2.00.2 patch
  - md-seq_file patch
52 disk software RAID10 with 4 hotspares - ~440GB
1 440GB Volume Group on top of above SW RAID array
360GB LV for data
Remaining 80GB for snapshots

Command used when getting segmentation fault:

lvcreate -L75G -c 128 -s -nlvsnap /dev/cubsvg00/cubslv00


Apr  6 16:05:46 cinshrcub01 kernel: kernel BUG at vmalloc.c:253!
Apr  6 16:05:46 cinshrcub01 kernel: invalid operand: 0000
Apr  6 16:05:46 cinshrcub01 kernel: CPU:    1
Apr  6 16:05:46 cinshrcub01 kernel: EIP:    0010:[<c0136a67>]    Not
tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr  6 16:05:46 cinshrcub01 kernel: EFLAGS: 00010246
Apr  6 16:05:46 cinshrcub01 kernel: eax: 00000fff   ebx: 00000000  
ecx: 51eb851f   edx: 00000000
Apr  6 16:05:46 cinshrcub01 kernel: esi: 00000000   edi: f5e68400  
ebp: fffffff4   esp: c9879ce4
Apr  6 16:05:46 cinshrcub01 kernel: ds: 0018   es: 0018   ss: 0018
Apr  6 16:05:46 cinshrcub01 kernel: Process lvcreate (pid: 1778,
stackpage=c9879000)
Apr  6 16:05:46 cinshrcub01 kernel: Stack: c0303a64 00000000 c0302a24
00000000 c0304bf0 00000000 00000500 c013bfeb
Apr  6 16:05:46 cinshrcub01 kernel:        00000001 00000000 00000000
f5e68400 fffffff4 f8872735 00000000 000001f2
Apr  6 16:05:46 cinshrcub01 kernel:        00000163 00000000 f5e68400
f5e6856c f5e68400 f88727ec f5e68400 4013f008
Apr  6 16:05:46 cinshrcub01 kernel: Call Trace: [<c013bfeb>]
__alloc_pages [kernel] 0x6b (0xc9879d00))
Apr  6 16:05:46 cinshrcub01 kernel: [<f8872735>]
lvm_snapshot_alloc_hash_table [lvm-mod] 0x45 (0xc9879d18))
Apr  6 16:05:46 cinshrcub01 kernel: [<f88727ec>] lvm_snapshot_alloc
[lvm-mod] 0x6c (0xc9879d38))
Apr  6 16:05:46 cinshrcub01 kernel: [<f88701c7>] lvm_do_lv_create
[lvm-mod] 0x507 (0xc9879d4c))
Apr  6 16:05:46 cinshrcub01 kernel: [<f886d9d5>] lvm_chr_ioctl
[lvm-mod] 0x6d5 (0xc9879d80))
Apr  6 16:05:46 cinshrcub01 kernel: [<f8877220>] lv_req [lvm-mod] 0x0
(0xc9879d88))
Apr  6 16:05:46 cinshrcub01 kernel: [<c014124a>] page_add_rmap
[kernel] 0x3a (0xc9879dc0))
Apr  6 16:05:46 cinshrcub01 kernel: [<c012eb56>] do_no_page [kernel]
0x226 (0xc9879dd0))
Apr  6 16:05:46 cinshrcub01 kernel: [<c01537d7>] sys_ioctl [kernel]
0x257 (0xc9879f94))
Apr  6 16:05:46 cinshrcub01 kernel: [<c0143af7>] sys_open [kernel]
0x57 (0xc9879fac))
Apr  6 16:05:46 cinshrcub01 kernel: [<c0108c93>] system_call [kernel]
0x33 (0xc9879fc0))
Apr  6 16:05:46 cinshrcub01 kernel: Code: 0f 0b fd 00 44 e8 24 c0 31
c0 e9 1e 02 00 00 6a 02 53 e8 e2

>>EIP; c0136a67 <__vmalloc+27/260>   <=====
Trace; c013bfeb <__alloc_pages+6b/2f0>
Trace; f8872735 <[lvm-mod]lvm_snapshot_alloc_hash_table+45/90>
Trace; f88727ec <[lvm-mod]lvm_snapshot_alloc+6c/e0>
Trace; f88701c7 <[lvm-mod]lvm_do_lv_create+507/830>
Trace; f886d9d5 <[lvm-mod]lvm_chr_ioctl+6d5/7d0>
Trace; f8877220 <[lvm-mod]lv_req+0/a0>
Trace; c014124a <page_add_rmap+3a/90>
Trace; c012eb56 <do_no_page+226/260>
Trace; c01537d7 <sys_ioctl+257/291>
Trace; c0143af7 <sys_open+57/a0>
Trace; c0108c93 <system_call+33/38>
Code;  c0136a67 <__vmalloc+27/260>
00000000 <_EIP>:
Code;  c0136a67 <__vmalloc+27/260>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0136a69 <__vmalloc+29/260>
   2:   fd                        std
Code;  c0136a6a <__vmalloc+2a/260>
   3:   00 44 e8 24               add    %al,0x24(%eax,%ebp,8)
Code;  c0136a6e <__vmalloc+2e/260>
   7:   c0                        (bad)
Code;  c0136a6f <__vmalloc+2f/260>
   8:   31 c0                     xor    %eax,%eax
Code;  c0136a71 <__vmalloc+31/260>
   a:   e9 1e 02 00 00            jmp    22d <_EIP+0x22d> c0136c94
<__vmalloc+254/260>
Code;  c0136a76 <__vmalloc+36/260>
   f:   6a 02                     push   $0x2
Code;  c0136a78 <__vmalloc+38/260>
  11:   53                        push   %ebx
Code;  c0136a79 <__vmalloc+39/260>
  12:   e8 e2 00 00 00            call   f9 <_EIP+0xf9> c0136b60
<__vmalloc+120/260>



-- 
Andrew Rechenberg <arechenberg@shermfin.com>
Infrastrucutre Team, Sherman Financial Group
