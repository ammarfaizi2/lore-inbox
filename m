Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbTAJXi4>; Fri, 10 Jan 2003 18:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbTAJXi4>; Fri, 10 Jan 2003 18:38:56 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:27658
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266627AbTAJXiz>; Fri, 10 Jan 2003 18:38:55 -0500
Date: Fri, 10 Jan 2003 18:48:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [patch][2.5] setup default dma_mask for cardbus devices
Message-ID: <Pine.LNX.4.50.0301101841210.9169-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Devices hanging off a cardbus bridge don't get a default dma mask which
causes problems later when doing pci_alloc_consistent. Patch has been
tested with tulip based ethernet.

Linux Tulip driver version 1.1.13 (May 11, 2002)
Unable to handle kernel NULL pointer dereference at virtual address
00000004
 printing eip:
c011100c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c011100c>]    Not tainted
EFLAGS: 00010282
EIP is at dma_alloc_coherent+0x1c/0x90
eax: 00000000   ebx: 0000003c   ecx: 00000020   edx: c767a9e0
esi: 00000300   edi: c767bc00   ebp: c113da6c   esp: c113da5c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c113c000 task=c778e040)
Stack: c767bc4c 0000003c 00000080 c767bc00 c113dacc c02b0365 c767bc4c
00000300
       c767a9f0 c01922cc c767bc4c c769c78c 00000000 00000003 c800f000
c767a800
       c113dab4 00000009 c767a9e0 4167c694 c767c93c c769c89c c113dacc
c0192450
Call Trace:
 [<c02b0365>] tulip_init_one+0x1f5/0xde0
 [<c01922cc>] sysfs_get_inode+0x5c/0x110
 [<c0192450>] sysfs_create+0x20/0x30
 [<c0248ec5>] pci_device_probe+0x45/0x60
 [<c025fde5>] bus_match+0x35/0x60
 [<c025fe5a>] device_attach+0x4a/0x60
 [<c025ffde>] bus_add_device+0x6e/0xb0
 [<c025f2ac>] device_add+0xec/0x150
 [<c032eb6e>] cb_alloc+0x2ae/0x310
 [<c032b2d4>] get_socket_status+0x14/0x20
 [<c032b976>] unreset_socket+0x86/0x100
 [<c032b848>] setup_socket+0xa8/0xf0
 [<c032cf34>] pcmcia_register_client+0x254/0x280
 [<c01454c7>] cache_alloc_debugcheck_after+0x97/0xb0
 [<c0144418>] kmalloc+0x98/0xe0
 [<c032c11c>] pcmcia_bind_device+0x6c/0xe0
 [<c011c3b6>] edd_create_symlink_to_scsidev+0x16/0xb0
 [<c032f1e0>] ds_event+0x0/0xb0
 [<c011c546>] edd_device_register+0x76/0x80
 [<c01050c4>] init+0x84/0x1a0
 [<c0105040>] init+0x0/0x1a0
 [<c0105040>] init+0x0/0x1a0
 [<c0105040>] init+0x0/0x1a0
 [<c0107375>] kernel_thread_helper+0x5/0x10

Code: 8b 50 04 8b 00 83 fa 00 77 0a 83 f8 fe 77 05 b9 21 00 00 00
 <0>Kernel panic: Attempted to kill init!

Index: linux-2.5.56/drivers/pcmcia/cardbus.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.56/drivers/pcmcia/cardbus.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cardbus.c
--- linux-2.5.56/drivers/pcmcia/cardbus.c	10 Jan 2003 21:22:48 -0000	1.1.1.1
+++ linux-2.5.56/drivers/pcmcia/cardbus.c	10 Jan 2003 23:38:24 -0000
@@ -281,6 +281,8 @@
 		dev->vendor = vend;
 		pci_readw(dev, PCI_DEVICE_ID, &dev->device);
 		dev->hdr_type = hdr & 0x7f;
+		dev->dma_mask = 0xffffffff;
+		dev->dev.dma_mask = &dev->dma_mask;

 		pci_setup_device(dev);
 		if (pci_enable_device(dev))
-- 
function.linuxpower.ca
