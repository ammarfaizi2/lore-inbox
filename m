Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTKSGYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 01:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbTKSGYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 01:24:24 -0500
Received: from yate.wa.csiro.au ([130.116.131.40]:30474 "EHLO
	yate.nexus.csiro.au") by vger.kernel.org with ESMTP id S263857AbTKSGYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 01:24:21 -0500
Subject: [Oops] 2.4.23-rc1 usb-storage ehci-hcd
From: Frank Horowitz <frank.horowitz@csiro.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069223057.21354.11.camel@bonzo.ned.dem.csiro.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 19 Nov 2003 14:24:18 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the nmi-watchdog and a serial console, I've managed to capture an
Oops (attached below). 

Config: SMP. Modularized everything relevant to USB.
Chipset: Intel E7505 (ICH4 controlling USB2)
Dual Xeon 2.4GHz, 2 Gig RAM (CONFIG_HIGHMEM4G=y)

Sure fire recipe to recreate problem:
Modprobe usb-storage with ehci-hcd already loaded. IDE drive in external
USB2 case shows up as /dev/sda. Try running "hdparm -Tt /dev/sda" and no
text comes back before lockup (about 10 seconds later or so) which
generates following oops:

ksymoops bonzo_console_log.TXT
ksymoops 2.4.9 on i686 2.4.23-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-rc1/ (default)
     -m /boot/System.map-2.4.23-rc1 (default)
 
Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.
 
NMI Watchdog detected LOCKUP on CPU0, eip c01df0ed, registers:
CPU:    0
EIP:    0010:[<c01df0ed>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00003086
eax: 00000080   ebx: f6301f80   ecx: 00001601   edx: f7b69800
esi: f6301f80   edi: c036b554   ebp: 00000008   esp: f7b21de0
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 9, stackpage=f7b21000)
Stack: 00001601 f6301f80 0001a4f8 005b8dd8 00003097 00000200 00000000
00000000
       c036b55c c030c000 00000080 00000000 0001a4f8 00000000 c01deb3c
c036b52c
       00000001 f6301f80 f6301f80 00000008 00000001 00000001 c01deba2
00000001
Call Trace:    [<c01deb3c>] [<c01deba2>] [<c01ded67>] [<c016bf4a>]
[<f8a6fde0>]
  [<c01167b2>] [<c016e8c6>] [<c016e770>] [<c0107144>]
Code: 7e f5 e9 1a f3 ff ff 80 3d 68 80 2d c0 00 f3 90 7e f5 e9 e9
 
 
>>EIP; c01df0ed <.text.lock.ll_rw_blk+59/7c>   <=====
 
>>ebx; f6301f80 <_end+35f8e6dc/384e57bc>
>>edx; f7b69800 <_end+377f5f5c/384e57bc>
>>esi; f6301f80 <_end+35f8e6dc/384e57bc>
>>edi; c036b554 <ide_hwifs+554/2c38>
>>esp; f7b21de0 <_end+377ae53c/384e57bc>
 
Trace; c01deb3c <generic_make_request+120/130>
Trace; c01deba2 <submit_bh+56/e0>
Trace; c01ded67 <ll_rw_block+13b/1a4>
Trace; c016bf4a <journal_commit_transaction+386/fcb>
Trace; f8a6fde0 <[nvidia]nv_linux_devices+0/5c0>
Trace; c01167b2 <schedule+45a/520>
Trace; c016e8c6 <kjournald+146/21c>
Trace; c016e770 <commit_timeout+0/c>
Trace; c0107144 <arch_kernel_thread+28/38>
 
Code;  c01df0ed <.text.lock.ll_rw_blk+59/7c>
00000000 <_EIP>:
Code;  c01df0ed <.text.lock.ll_rw_blk+59/7c>   <=====
   0:   7e f5                     jle    fffffff7 <_EIP+0xfffffff7>  
<=====
Code;  c01df0ef <.text.lock.ll_rw_blk+5b/7c>
   2:   e9 1a f3 ff ff            jmp    fffff321 <_EIP+0xfffff321>
Code;  c01df0f4 <.text.lock.ll_rw_blk+60/7c>
   7:   80 3d 68 80 2d c0 00      cmpb   $0x0,0xc02d8068
Code;  c01df0fb <.text.lock.ll_rw_blk+67/7c>
   e:   f3 90                     repz nop
Code;  c01df0fd <.text.lock.ll_rw_blk+69/7c>
  10:   7e f5                     jle    7 <_EIP+0x7>
Code;  c01df0ff <.text.lock.ll_rw_blk+6b/7c>
  12:   e9 e9 00 00 00            jmp    100 <_EIP+0x100>
 
1 warning issued.  Results may not be reliable.





