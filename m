Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSHLJ7l>; Mon, 12 Aug 2002 05:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317642AbSHLJ7l>; Mon, 12 Aug 2002 05:59:41 -0400
Received: from PSI.MIT.EDU ([18.77.0.154]:128 "EHLO psi.mit.edu")
	by vger.kernel.org with ESMTP id <S317641AbSHLJ7j>;
	Mon, 12 Aug 2002 05:59:39 -0400
Date: Mon, 12 Aug 2002 06:03:24 -0400 (EDT)
From: null@mit.edu
To: linux-kernel@vger.kernel.org
Subject: [bug, 2.4.18-3, dcache.c]
Message-ID: <Pine.LNX.4.44.0208120601530.2906-100000@psi.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think I found a bug in kernel 2.4.18-3 (stack RedHat 7.3 Uniproc
kernel.) It's a Pentium 4 (w/D850GB mobo) with SCSI and IDE, using NVidia
driver from nvidia. (I can't reproduce it with or without nvidia driver -
feel free to blame nvidia.)

--- o ---

I don't know if it's related, but it happened, while I was transfering
file, I started my firewall script (a bunch of iptables commands)

It froze everything (in X windows). Keyboard, seemded to be
non-responsicve to caps-lock and num-lock, but SysRq was working (I could
kill the processes, and unmount most of the partitions without seeing a
thing on the frozen X-windows). I also couldn't login remotely. I could
reboot it with SysRq keys. Only root filesystem didn't unmount cleanly
(noticed it while booting)

--- o ---

Here is the Oops message I could recover from the logs, and its ksymoops
if it does mean anything:

Aug 11 17:49:24 psi kernel: EXT2-fs error (device ide0(3,2)): ext2_free_blocks: Freeing blocks not in datazone - block = 2162120960, count = 22784
Aug 11 17:49:24 psi kernel: EXT2-fs error (device ide0(3,2)): ext2_free_blocks: Freeing blocks not in datazone - block = 14637952, count = 23296
Aug 11 17:49:24 psi kernel: EXT2-fs error (device ide0(3,2)): ext2_free_blocks: Freeing blocks not in datazone - block = 14638336, count = 23808
Aug 11 17:49:24 psi kernel: EXT2-fs error (device ide0(3,2)): ext2_free_blocks: Freeing blocks not in datazone - block = 14638848, count = 24320
Aug 11 17:49:24 psi kernel: ------------[ cut here ]------------
Aug 11 17:49:24 psi kernel: kernel BUG at dcache.c:362!
Aug 11 17:49:24 psi kernel: invalid operand: 0000
Aug 11 17:49:24 psi kernel: sr_mod cdrom i810_audio ac97_codec soundcore agpgart NVdriver 3c59x ipt_limit
Aug 11 17:49:24 psi kernel: CPU:    0
Aug 11 17:49:24 psi kernel: EIP:    0010:[<c014a66c>]    Tainted: P
Aug 11 17:49:24 psi kernel: EFLAGS: 00010282
Aug 11 17:49:24 psi kernel:
Aug 11 17:49:24 psi kernel: EIP is at prune_dcache [kernel] 0xac (2.4.18-3)
Aug 11 17:49:24 psi kernel: eax: 0000001c   ebx: c93f68b8   ecx: 00000001   edx: 00004392
Aug 11 17:49:24 psi kernel: esi: c93f68a0   edi: d7f81130   ebp: 00000062   esp: c15b9f64
Aug 11 17:49:24 psi kernel: ds: 0018   es: 0018   ss: 0018
Aug 11 17:49:24 psi kernel: Process kswapd (pid: 5, stackpage=c15b9000)
Aug 11 17:49:24 psi kernel: Stack: c0228fb9 0000016a c15b8000 00000000 00000000 ffffffff c02c4818 00000000
Aug 11 17:49:24 psi kernel:        00000000 000006a8 c01304d3 000001d0 000006a8 00000000 00000000 c014aa30
Aug 11 17:49:24 psi kernel:        000001d1 c0130c1c 00000006 000001d0 000001d0 c15b8000 00000000 00000000
Aug 11 17:49:24 psi kernel: Call Trace: [<c01304d3>] page_launder [kernel] 0x2b3
Aug 11 17:49:24 psi kernel: [<c014aa30>] shrink_dcache_memory [kernel] 0x20
Aug 11 17:49:24 psi kernel: [<c0130c1c>] do_try_to_free_pages [kernel] 0x1c
Aug 11 17:49:24 psi kernel: [<c0130f11>] kswapd [kernel] 0x101
Aug 11 17:49:24 psi kernel: [<c0105000>] stext [kernel] 0x0
Aug 11 17:49:24 psi kernel: [<c0107136>] kernel_thread [kernel] 0x26
Aug 11 17:49:24 psi kernel: [<c0130e10>] kswapd [kernel] 0x0
Aug 11 17:49:24 psi kernel:
Aug 11 17:49:24 psi kernel:
Aug 11 17:49:24 psi kernel: Code: 0f 0b 5f 58 8d 4e 10 8b 51 04 8b 46 10 89 50 04 89 02 89 4e
Aug 11 17:49:51 psi kernel:  ip_conntrack (3070 buckets, 24560 max)

ksymoops 2.4.4 on i686 2.4.18-3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-3/ (default)
     -m /boot/System.map-2.4.18-3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01bd130, System.map says c015abe0.  Ignoring ksyms_base entry
Aug 11 17:49:24 psi kernel: kernel BUG at dcache.c:362!
Aug 11 17:49:24 psi kernel: invalid operand: 0000
Aug 11 17:49:24 psi kernel: CPU:    0
Aug 11 17:49:24 psi kernel: EIP:    0010:[<c014a66c>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 11 17:49:24 psi kernel: EFLAGS: 00010282
Aug 11 17:49:24 psi kernel: eax: 0000001c   ebx: c93f68b8   ecx: 00000001   edx: 00004392
Aug 11 17:49:24 psi kernel: esi: c93f68a0   edi: d7f81130   ebp: 00000062   esp: c15b9f64
Aug 11 17:49:24 psi kernel: ds: 0018   es: 0018   ss: 0018
Aug 11 17:49:24 psi kernel: Process kswapd (pid: 5, stackpage=c15b9000)
Aug 11 17:49:24 psi kernel: Stack: c0228fb9 0000016a c15b8000 00000000 00000000 ffffffff c02c4818 00000000
Aug 11 17:49:24 psi kernel:        00000000 000006a8 c01304d3 000001d0 000006a8 00000000 00000000 c014aa30
Aug 11 17:49:24 psi kernel:        000001d1 c0130c1c 00000006 000001d0 000001d0 c15b8000 00000000 00000000
Aug 11 17:49:24 psi kernel: Call Trace: [<c01304d3>] page_launder [kernel] 0x2b3
Aug 11 17:49:24 psi kernel: [<c014aa30>] shrink_dcache_memory [kernel] 0x20
Aug 11 17:49:24 psi kernel: [<c0130c1c>] do_try_to_free_pages [kernel] 0x1c
Aug 11 17:49:24 psi kernel: [<c0130f11>] kswapd [kernel] 0x101
Aug 11 17:49:24 psi kernel: [<c0105000>] stext [kernel] 0x0
Aug 11 17:49:24 psi kernel: [<c0107136>] kernel_thread [kernel] 0x26
Aug 11 17:49:24 psi kernel: [<c0130e10>] kswapd [kernel] 0x0
Aug 11 17:49:24 psi kernel: Code: 0f 0b 5f 58 8d 4e 10 8b 51 04 8b 46 10 89 50 04 89 02 89 4e

>>EIP; c014a66c <prune_dcache+ac/180>   <=====
Trace; c01304d3 <page_launder+2b3/300>
Trace; c014aa30 <shrink_dcache_memory+20/30>
Trace; c0130c1c <do_try_to_free_pages+1c/180>
Trace; c0130f11 <kswapd+101/2d0>
Trace; c0105000 <_stext+0/0>
Trace; c0107136 <kernel_thread+26/30>
Trace; c0130e10 <kswapd+0/2d0>
Code;  c014a66c <prune_dcache+ac/180>
00000000 <_EIP>:
Code;  c014a66c <prune_dcache+ac/180>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014a66e <prune_dcache+ae/180>
   2:   5f                        pop    %edi
Code;  c014a66f <prune_dcache+af/180>
   3:   58                        pop    %eax
Code;  c014a670 <prune_dcache+b0/180>
   4:   8d 4e 10                  lea    0x10(%esi),%ecx
Code;  c014a673 <prune_dcache+b3/180>
   7:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c014a676 <prune_dcache+b6/180>
   a:   8b 46 10                  mov    0x10(%esi),%eax
Code;  c014a679 <prune_dcache+b9/180>
   d:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c014a67c <prune_dcache+bc/180>
  10:   89 02                     mov    %eax,(%edx)
Code;  c014a67e <prune_dcache+be/180>
  12:   89 4e 00                  mov    %ecx,0x0(%esi)


2 warnings and 3 errors issued.  Results may not be reliable.

=======================================================================

>From address of this mail is fake.
My real electronic mail is 'akdogan at mit dot edu', if you need more
info...

Regards,
Taylan


