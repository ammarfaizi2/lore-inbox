Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUGUAA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUGUAA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 20:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUGUAA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 20:00:26 -0400
Received: from mail.tdb.com ([216.99.214.4]:33181 "HELO mail.tdb.com")
	by vger.kernel.org with SMTP id S265974AbUGUAAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 20:00:14 -0400
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Oops 2.6.8-rc1 doing an rsync to USB mass storage
From: Russell Senior <seniorr@aracnet.com>
Date: 20 Jul 2004 17:00:07 -0700
Message-ID: <861xj62prs.fsf@coulee.tdb.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am rsyncing from over a network to a locally attached USB2 Mass
Storage external 200gig IDE drive in an ADS Technologies enclosure.
Locks up the box solid, can't ping, can't SysRq anything.  I've seen
this on two different IDE drives and enclosures, and also a similar
but uncaptured Oops under 2.6.7 (whereupon I tried 2.6.8-rc1).  It
doesn't *always* happen, but about 5 out of 6 attempts so far if the
rsync is big enough.

This is on a dual P3-1GHz with a gig of RAM on a debian box with a
custom compiled kernel, config available at:

  <http://www.aracnet.com/~seniorr/config-2.6.8-rc1>

  $ uname -a
  Linux celilo 2.6.8-rc1 #2 SMP Tue Jul 20 13:37:13 PDT 2004 i686 GNU/Linux


Here is the ksymoops report:

   ksymoops 2.4.9 on i686 2.6.8-rc1.  Options used
        -V (default)
        -k /proc/ksyms (default)
        -l /proc/modules (default)
        -o /lib/modules/2.6.8-rc1/ (default)
        -m /boot/System.map-2.6.8-rc1 (default)

   Warning: You did not tell me where to find symbol information.  I will
   assume that the log matches the kernel and modules that are running
   right now and I'll use the default options above for symbol resolution.
   If the current kernel and/or modules do not match the log, you can get
   more accurate output by telling me the kernel version and where to find
   map, modules, ksyms etc.  ksymoops -h explains the options.

   Error (regular_file): read_ksyms stat /proc/ksyms failed
   No modules in ksyms, skipping objects
   No ksyms, skipping lsmod
   Unable to handle kernel paging request at virtual address 00100104
   f8be21e5
   *pde = 00000000
   Oops: 0002 [#1]
   CPU:    1
   EIP:    0060:[<f8be21e5>]    Not tainted
   Using defaults from ksymoops -t elf32-i386 -a i386
   EFLAGS: 00010246   (2.6.8-rc1) 
   eax: 00100100   ebx: 00001c00   ecx: f719c1b8   edx: 00200200
   esi: f719c180   edi: f77eb500   ebp: f7f85ea0   esp: f7f85e60
   ds: 007b   es: 007b   ss: 0068
   Stack: f7196800 f77eb500 00001000 00001c00 f7f84000 f7b5814c 01000000 00000000 
          00000001 00000000 f719c218 f719c5a0 00000000 f7b5814c f7f85f80 f7b58100 
          f7f85ed0 f8be30b5 f7196800 f7b58100 f7f85f80 f7b58160 00000000 f7f85f80 
   Call Trace:
    [<c010538f>] show_stack+0x7f/0xa0
    [<c010553f>] show_registers+0x15f/0x1c0
    [<c0105702>] die+0xa2/0x120
    [<c0115216>] do_page_fault+0x1f6/0x5ac
    [<c0105009>] error_code+0x2d/0x38
    [<f8be30b5>] scan_async+0xa5/0x170 [ehci_hcd]
    [<f8be55c5>] ehci_work+0x35/0xd0 [ehci_hcd]
    [<f8be5790>] ehci_irq+0x130/0x1c0 [ehci_hcd]
    [<c02dd3f5>] usb_hcd_irq+0x35/0x70
    [<c010696b>] handle_IRQ_event+0x3b/0x70
    [<c0106d3d>] do_IRQ+0xbd/0x1a0
    [<c0104f0c>] common_interrupt+0x18/0x20
    [<c01024cb>] cpu_idle+0x3b/0x50
    [<f7f82000>] 0xf7f82000
    [<f7f85fbc>] 0xf7f85fbc
   Code: 89 50 04 89 02 c7 41 04 00 02 20 00 c7 46 38 00 01 10 00 89 


   >>EIP; f8be21e5 <__crc_fput+c379f/60892c>   <=====

   >>ecx; f719c1b8 <__crc_net_ratelimit+2e017d/4bc3a6>
   >>edx; 00200200 <__crc_smp_call_function+b422f/4c2795>
   >>esi; f719c180 <__crc_net_ratelimit+2e0145/4bc3a6>
   >>edi; f77eb500 <__crc_redraw_screen+47311f/4ea33e>
   >>ebp; f7f85ea0 <__crc_unregister_netdev+1a44b8/260378>
   >>esp; f7f85e60 <__crc_unregister_netdev+1a4478/260378>

   Trace; c010538f <show_stack+7f/a0>
   Trace; c010553f <show_registers+15f/1c0>
   Trace; c0105702 <die+a2/120>
   Trace; c0115216 <do_page_fault+1f6/5ac>
   Trace; c0105009 <error_code+2d/38>
   Trace; f8be30b5 <__crc_fput+c466f/60892c>
   Trace; f8be55c5 <__crc_fput+c6b7f/60892c>
   Trace; f8be5790 <__crc_fput+c6d4a/60892c>
   Trace; c02dd3f5 <usb_hcd_irq+35/70>
   Trace; c010696b <handle_IRQ_event+3b/70>
   Trace; c0106d3d <do_IRQ+bd/1a0>
   Trace; c0104f0c <common_interrupt+18/20>
   Trace; c01024cb <cpu_idle+3b/50>
   Trace; f7f82000 <__crc_unregister_netdev+1a0618/260378>
   Trace; f7f85fbc <__crc_unregister_netdev+1a45d4/260378>

   Code;  f8be21e5 <__crc_fput+c379f/60892c>
   00000000 <_EIP>:
   Code;  f8be21e5 <__crc_fput+c379f/60892c>   <=====
      0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
   Code;  f8be21e8 <__crc_fput+c37a2/60892c>
      3:   89 02                     mov    %eax,(%edx)
   Code;  f8be21ea <__crc_fput+c37a4/60892c>
      5:   c7 41 04 00 02 20 00      movl   $0x200200,0x4(%ecx)
   Code;  f8be21f1 <__crc_fput+c37ab/60892c>
      c:   c7 46 38 00 01 10 00      movl   $0x100100,0x38(%esi)
   Code;  f8be21f8 <__crc_fput+c37b2/60892c>
     13:   89 00                     mov    %eax,(%eax)

    <0>Kernel panic: Fatal exception in interrupt

   1 warning and 1 error issued.  Results may not be reliable.


-- 
Russell Senior         ``I have nine fingers; you have ten.''
seniorr@aracnet.com
