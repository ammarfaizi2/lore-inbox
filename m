Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267407AbSLRWQ0>; Wed, 18 Dec 2002 17:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267416AbSLRWQD>; Wed, 18 Dec 2002 17:16:03 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:29407 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267407AbSLRWPq>;
	Wed, 18 Dec 2002 17:15:46 -0500
Date: Wed, 18 Dec 2002 23:23:44 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212182223.XAA22858@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.5.52: ejecting 3c575 Cardbus nic oopses pci_remove_device
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dell Latitude with a 3c575 Cardbus nic. Kernel 2.5.52.
User-space is RedHat 8.0 with hotplug-2002_04_01.

Inserting the card fails to enable it due to a bogus resource collision:

Dec 18 20:58:22 ??? kernel: cs: cb_alloc(bus 5): vendor 0x10b7, device 0x5057
Dec 18 20:58:22 ??? kernel: PCI: Device 05:00.0 not available because of resource collisions

Ejecting the card then immediately oopses pci_remove_device():

Dec 18 20:58:28 ??? kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Dec 18 20:58:28 ??? kernel: c01967df
Dec 18 20:58:28 ??? kernel: *pde = 00000000
Dec 18 20:58:28 ??? kernel: Oops: 0002
Dec 18 20:58:28 ??? kernel: CPU:    0
Dec 18 20:58:28 ??? kernel: EIP:    0060:[<c01967df>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 18 20:58:28 ??? kernel: EFLAGS: 00010286
Dec 18 20:58:28 ??? kernel: eax: 00000000   ebx: c7edc000   ecx: 05c00558   edx: 00000000
Dec 18 20:58:28 ??? kernel: esi: 00000000   edi: c7edc000   ebp: c7ecf800   esp: c7f93f28
Dec 18 20:58:28 ??? kernel: ds: 0068   es: 0068   ss: 0068
Dec 18 20:58:28 ??? kernel: Stack: c7edc000 c01e4c36 c7edc000 c7ecf800 c7ecf800 c01e6bc0 c7feb820 c01e205a 
Dec 18 20:58:28 ??? kernel:        c7ecf800 c7ecf800 c7ecf800 c7ecf80c c7ecf800 00000080 c01e6bc0 c7feb820 
Dec 18 20:58:28 ??? kernel:        c01e2385 c7ecf800 00000003 c7ecf800 c01e23c6 c7ecf800 c033059c c0330558 
Dec 18 20:58:28 ??? kernel:  [<c01e4c36>] cb_free+0x2a/0x60
Dec 18 20:58:28 ??? kernel:  [<c01e6bc0>] yenta_bh+0x0/0x24
Dec 18 20:58:28 ??? kernel:  [<c01e205a>] shutdown_socket+0x76/0xe0
Dec 18 20:58:28 ??? kernel:  [<c01e6bc0>] yenta_bh+0x0/0x24
Dec 18 20:58:28 ??? kernel:  [<c01e2385>] do_shutdown+0x5d/0x64
Dec 18 20:58:28 ??? kernel:  [<c01e23c6>] parse_events+0x3a/0xd8
Dec 18 20:58:28 ??? kernel:  [<c01e6bde>] yenta_bh+0x1e/0x24
Dec 18 20:58:28 ??? kernel:  [<c011fc3d>] worker_thread+0x18d/0x240
Dec 18 20:58:28 ??? kernel:  [<c011fab0>] worker_thread+0x0/0x240
Dec 18 20:58:28 ??? kernel:  [<c01e6bc0>] yenta_bh+0x0/0x24
Dec 18 20:58:28 ??? kernel:  [<c0113710>] default_wake_function+0x0/0x34
Dec 18 20:58:28 ??? kernel:  [<c0113710>] default_wake_function+0x0/0x34
Dec 18 20:58:28 ??? kernel:  [<c0106ddd>] kernel_thread_helper+0x5/0xc
Dec 18 20:58:28 ??? kernel: Code: 89 50 04 89 02 8b 53 04 8b 03 89 50 04 89 02 53 e8 a4 ff ff 


>>EIP; c01967df <pci_remove_device+17/38>   <=====

>>ebx; c7edc000 <END_OF_CODE+7ba2b28/????>
>>ecx; 05c00558 Before first symbol
>>edi; c7edc000 <END_OF_CODE+7ba2b28/????>
>>ebp; c7ecf800 <END_OF_CODE+7b96328/????>
>>esp; c7f93f28 <END_OF_CODE+7c5aa50/????>

Code;  c01967df <pci_remove_device+17/38>
00000000 <_EIP>:
Code;  c01967df <pci_remove_device+17/38>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c01967e2 <pci_remove_device+1a/38>
   3:   89 02                     mov    %eax,(%edx)
Code;  c01967e4 <pci_remove_device+1c/38>
   5:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c01967e7 <pci_remove_device+1f/38>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c01967e9 <pci_remove_device+21/38>
   a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c01967ec <pci_remove_device+24/38>
   d:   89 02                     mov    %eax,(%edx)
Code;  c01967ee <pci_remove_device+26/38>
   f:   53                        push   %ebx
Code;  c01967ef <pci_remove_device+27/38>
  10:   e8 a4 ff ff 00            call   ffffb9 <_EIP+0xffffb9>

This all works fine in 2.4 kernels.
It used to work in 2.5 kernels, up to early-mid 2.5.4x or so.

UP, no preemption, no modules. HOTPLUG, CARDBUS, and VORTEX enabled.

/Mikael
