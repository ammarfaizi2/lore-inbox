Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbQKFEbM>; Sun, 5 Nov 2000 23:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130175AbQKFEbC>; Sun, 5 Nov 2000 23:31:02 -0500
Received: from getafix.lostland.net ([216.29.29.27]:35437 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S130170AbQKFEat>; Sun, 5 Nov 2000 23:30:49 -0500
Date: Sun, 5 Nov 2000 23:30:48 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Bug in page_alloc.c
Message-ID: <Pine.BSO.4.21.0011052212160.30593-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello folks,

   I got these oopses after mounting an NFS share and copying ~1.3GB from
it to a local partition.  The oopses happened 44 hours after the copy,
during which time the system ran setiathome exclusively.  Previously,
without first doing this copy, the system ran for a week doing setiathome,
at which time I rebooted, did this copy, and left for the weekend.

Here are the goods:

I found this on the console:

kernel BUG at page_alloc.c:82!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012965d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001f   ebx: c145cca8   ecx: 00000000   edx: 0000001c
esi: 00000000   edi: cd74e404   ebp: 00000000   esp: cd60de60
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 1662, stackpage=cd60d000)
Stack: c0233305 c02334d3 00000052 c145cca8 00000000 cd74e404 d1aff214 c1044010 
       c0280520 00000216 ffffffff 0000a569 c0129fc3 c012a43d 0000037b 00000000 
       c011eb86 c145cca8 d7e586c0 4014b000 d7306900 00c66000 00000084 00000000 
Call Trace: [<c0233305>] [<c02334d3>] [<c0129fc3>] [<c012a43d>] [<c011eb86>] [<c01210e8>] [<c0115a85>] 
       [<c0119669>] [<c010a4c7>] [<c0110be0>] [<c01e2c98>] [<c011d96e>] [<c011db77>] [<c010e952>] [<c010a76c>] 
       [<c010a698>] [<c01e2c98>] [<c01e2c98>] 
Code: 0f 0b 83 c4 0c 89 f6 83 7b 08 00 74 16 6a 54 68 d3 34 23 c0 

>>EIP; c012965d <__free_pages_ok+2d/340>   <=====
Trace; c0233305 <tvecs+1cdd/1a9d8>
Trace; c02334d3 <tvecs+1eab/1a9d8>
Trace; c0129fc3 <__free_pages+13/20>
Trace; c012a43d <free_page_and_swap_cache+7d/80>
Trace; c011eb86 <zap_page_range+186/220>
Trace; c01210e8 <exit_mmap+b8/110>
Trace; c0115a85 <mmput+15/30>
Trace; c0119669 <do_exit+a9/200>
Trace; c010a4c7 <do_signal+207/2a4>
Trace; c0110be0 <do_page_fault+0/3f0>
Trace; c01e2c98 <isapnp_set_irq+8/c0>
Trace; c011d96e <update_wall_time+e/40>
Trace; c011db77 <timer_bh+27/260>
Trace; c010e952 <timer_interrupt+72/120>
Trace; c010a76c <error_code+34/3c>
Trace; c010a698 <signal_return+14/18>
Trace; c01e2c98 <isapnp_set_irq+8/c0>
Trace; c01e2c98 <isapnp_set_irq+8/c0>
Code;  c012965d <__free_pages_ok+2d/340>
00000000 <_EIP>:
Code;  c012965d <__free_pages_ok+2d/340>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012965f <__free_pages_ok+2f/340>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0129662 <__free_pages_ok+32/340>
   5:   89 f6                     mov    %esi,%esi
Code;  c0129664 <__free_pages_ok+34/340>
   7:   83 7b 08 00               cmpl   $0x0,0x8(%ebx)
Code;  c0129668 <__free_pages_ok+38/340>
   b:   74 16                     je     23 <_EIP+0x23> c0129680 <__free_pages_ok+50/340>
Code;  c012966a <__free_pages_ok+3a/340>
   d:   6a 54                     push   $0x54
Code;  c012966c <__free_pages_ok+3c/340>
   f:   68 d3 34 23 c0            push   $0xc02334d3

I then tried an alt+sysrq+s, which gave:

Syncing device 03:01 ... <1>Unable to handle kernel paging request at virtual address 080a5960
c012e410
*pde = 171db067
Oops: 0000
CPU:    0
EIP:    0010:[<c012e410>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 080a5940   ebx: 080a5940   ecx: 0005a416   edx: d1195e40
esi: 00000301   edi: 00000000   ebp: 00000001   esp: c167ff88
ds: 0018   es: 0018   ss: 0018
Process kflushd (pid: 4, stackpage=c167f000)
Stack: 00000301 00000000 c02f5740 0008e000 d1195e40 00000000 030110bf 080a5940 
       c012e5de 00000301 00000000 d7e90400 c019943a 00000301 d7e90400 00000000 
       c167e000 c0199490 d7e90400 00000000 00000000 c167e000 c01312c2 00010f00 
Call Trace: [<c012e5de>] [<c019943a>] [<c0199490>] [<c01312c2>] [<c0108c03>] 
Code: 8b 58 20 83 3d 30 74 2d c0 00 74 5b 66 83 7c 24 1a 00 74 0b 

>>EIP; c012e410 <sync_buffers+30/1c0>   <=====
Trace; c012e5de <fsync_dev+e/40>
Trace; c019943a <go_sync+10a/120>
Trace; c0199490 <do_emergency_sync+40/a0>
Trace; c01312c2 <bdflush+72/110>
Trace; c0108c03 <kernel_thread+23/30>
Code;  c012e410 <sync_buffers+30/1c0>
00000000 <_EIP>:
Code;  c012e410 <sync_buffers+30/1c0>   <=====
   0:   8b 58 20                  mov    0x20(%eax),%ebx   <=====
Code;  c012e413 <sync_buffers+33/1c0>
   3:   83 3d 30 74 2d c0 00      cmpl   $0x0,0xc02d7430
Code;  c012e41a <sync_buffers+3a/1c0>
   a:   74 5b                     je     67 <_EIP+0x67> c012e477 <sync_buffers+97/1c0>
Code;  c012e41c <sync_buffers+3c/1c0>
   c:   66 83 7c 24 1a 00         cmpw   $0x0,0x1a(%esp,1)
Code;  c012e422 <sync_buffers+42/1c0>
  12:   74 0b                     je     1f <_EIP+0x1f> c012e42f <sync_buffers+4f/1c0>


Then I tried a manual umount, resulting in:

Unable to handle kernel NULL pointer dereference at virtual address 00000032
c012e410
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012e410>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000012   ebx: 00000012   ecx: 0005a4a9   edx: d00592c0
esi: 00000341   edi: 00000000   ebp: 00000000   esp: d5b8df34
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 2317, stackpage=d5b8d000)
Stack: 00000341 d7bae000 00000000 08051fa8 d00592c0 00000000 03411fa8 00000012 
       c012e5de 00000341 00000000 d7e685c0 c0132c40 00000341 d7bae000 ffffffff 
       d7c36a40 d5b8df98 c0132db2 d7e685c0 00000000 00000000 d5b8c000 08051fa9 
Call Trace: [<c012e5de>] [<c0132c40>] [<c0132db2>] [<c0132dec>] [<c010a64f>] 
Code: 8b 58 20 83 3d 30 74 2d c0 00 74 5b 66 83 7c 24 1a 00 74 0b 

>>EIP; c012e410 <sync_buffers+30/1c0>   <=====
Trace; c012e5de <fsync_dev+e/40>
Trace; c0132c40 <do_umount+130/1e0>
Trace; c0132db2 <sys_umount+c2/f0>
Trace; c0132dec <sys_oldumount+c/10>
Trace; c010a64f <system_call+33/38>
Code;  c012e410 <sync_buffers+30/1c0>
00000000 <_EIP>:
Code;  c012e410 <sync_buffers+30/1c0>   <=====
   0:   8b 58 20                  mov    0x20(%eax),%ebx   <=====
Code;  c012e413 <sync_buffers+33/1c0>
   3:   83 3d 30 74 2d c0 00      cmpl   $0x0,0xc02d7430
Code;  c012e41a <sync_buffers+3a/1c0>
   a:   74 5b                     je     67 <_EIP+0x67> c012e477 <sync_buffers+97/1c0>
Code;  c012e41c <sync_buffers+3c/1c0>
   c:   66 83 7c 24 1a 00         cmpw   $0x0,0x1a(%esp,1)
Code;  c012e422 <sync_buffers+42/1c0>
  12:   74 0b                     je     1f <_EIP+0x1f> c012e42f <sync_buffers+4f/1c0>


System is:

Linux dogmatix 2.4.0-test10 #5 Sat Nov 4 01:10:07 EST 2000 i686 unknown
Kernel modules         2.3.19
Gnu C                  egcs-2.91.66
Gnu Make               3.77
Binutils               2.10
Linux C Library        2.1.2
Dynamic linker         ldd: version 1.9.9
Procps                 2.0.2
Mount                  2.10o
Net-tools              1.52
Kbd                    0.99
Sh-utils               1.16
Modules Loaded         NVdriver

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0cf8-0cff : PCI conf1
8000-8fff : PCI Bus #01
cc00-cc1f : Creative Labs SB Live! EMU10000
  cc00-cc1f : EMU10K1
d000-d07f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  d000-d07f : eth0
d400-d403 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller
d800-d8ff : Symbios Logic Inc. (formerly NCR) 53c895
  d800-d87f : sym53c8xx
dc00-dc07 : Creative Labs SB Live!
ffa0-ffaf : VIA Technologies, Inc. Bus Master IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

I'm not using the VIA IDE drivers, or DMA support.  I'm also not using the
Irongate AGP driver, or USB.

Since this all took place today, I haven't reproduced it, but I'm working
on that right now.  With < test10, doing the copy over NFS alone would
result in a complete lockup, so I'm fairly sure this'll repeat itself.

Regards,
Adrian


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
