Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbTAKP4Y>; Sat, 11 Jan 2003 10:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbTAKP4Y>; Sat, 11 Jan 2003 10:56:24 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:34980 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267257AbTAKP4W>;
	Sat, 11 Jan 2003 10:56:22 -0500
Date: Sat, 11 Jan 2003 17:05:04 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301111605.RAA06360@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [BUG] cardbus/hotplugging still broken in 2.5.56
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cardbus/hotplugging is still broken in 2.5.56. Inserting a
card fails due a bogus 'resource conflict', and ejecting it
oopses the kernel. It's been this way since 2.5.4x-something.

Dell Latitude, Texas PCI1131 cardbus bridge, 3c575_cb NIC.

Early boot log:

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 00:07.2
PCI: Found IRQ 11 for device 00:03.1
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:07.2
...
Yenta IRQ list 0618, PCI irq11
Socket status: 30000006
Yenta IRQ list 0618, PCI irq11
Socket status: 30000006
...
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x210-0x217 0x220-0x22f 0x378-0x37f 0x388-0x38f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

So far so good.
Now insert the 3x575_cb NIC:

cs: cb_alloc(bus 5): vendor 0x10b7, device 0x5057
PCI: Device 05:00.0 not available because of resource collisions

Now eject the NIC:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c019cd1b
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c019cd1b>]    Not tainted
EFLAGS: 00010246
EIP is at device_del+0x23/0x74
eax: 00000000   ebx: c7eff44c   ecx: c02b2048   edx: 00000000
esi: c7f6d44c   edi: c7eff400   ebp: c7ef2000   esp: c7fb7f0c
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c7fb6000 task=c1150c80)
Stack: c7eff44c 00000000 c019cd77 c7eff44c c7eff400 c01970a6 c7eff44c c7eff400 
       c01e5356 c7eff400 c7ef2000 c7ef2000 c01e72e0 c7feb7e0 c01e277a c7ef2000 
       c7ef2000 c7ef2000 c7ef200c c7ef2000 00000080 c01e72e0 c7feb7e0 c01e2aa5 
Call Trace:
 [<c019cd77>] device_unregister+0xb/0x16
 [<c01970a6>] pci_remove_device+0xe/0x38
 [<c01e5356>] cb_free+0x2a/0x60
 [<c01e72e0>] yenta_bh+0x0/0x24
 [<c01e277a>] shutdown_socket+0x76/0xe0
 [<c01e72e0>] yenta_bh+0x0/0x24
 [<c01e2aa5>] do_shutdown+0x5d/0x64
 [<c01e2ae6>] parse_events+0x3a/0xd8
 [<c01e72fe>] yenta_bh+0x1e/0x24
 [<c011fbbd>] worker_thread+0x18d/0x240
 [<c011fa30>] worker_thread+0x0/0x240
 [<c01e72e0>] yenta_bh+0x0/0x24
 [<c01136a4>] default_wake_function+0x0/0x34
 [<c01136a4>] default_wake_function+0x0/0x34
 [<c0106ddd>] kernel_thread_helper+0x5/0xc

Code: 89 50 04 89 02 89 1b 89 5b 04 ff 05 48 20 2b c0 7e 73 8d 76 

Doubleplusuncool.

/Mikael
