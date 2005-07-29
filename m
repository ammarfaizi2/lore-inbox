Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVG2DsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVG2DsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVG2DsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:48:14 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:56062 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261567AbVG2DsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:48:13 -0400
To: Pavel Machek <pavel@ucw.cz>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: swsusp works (TP 600X) 
In-Reply-To: Your message of "Thu, 28 Jul 2005 23:55:48 +0200."
             <200507282355.49356.rjw@sisk.pl> 
Date: Fri, 29 Jul 2005 04:48:10 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1DyLr0-0001aU-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, in short, problem is that if you leave prism54 card in, even
> with module removed, swsusp hangs, right?

Right, in some circumstances.  To narrow them down I spent many hours
rebooting into combinations of runlevels and loaded modules.  It is
reproducible even in single-user mode.  The various permutations, all
from booting single user with almost no modules loaded (cmdline:
idebus=66 apm=off acpi=force pci=noacpi single)

  card: prism54 card/xircom Ethernet+modem card/no card
  cardctl eject: done before the hibernate/ not done before the hibernate

The one combination that always breaks is to have the prism54 card in,
then do 'cardctl eject', which always produces:

[4295438.170000] PCMCIA: socket e233c02c: *** DANGER *** unable to
   remove socket power

If I then use a simple hibernate script (basically just unload
prism54, then echo disk > /sys/power/state), swsusp doesn't write the
pages.  These are the only modules loaded before the swsusp begins:

pcmcia                 34276  0 
crc32                   3808  1 pcmcia
intel_agp              20188  1 
firmware_class          7936  1 pcmcia
yenta_socket           23244  3 
rsrc_nonstatic         11776  1 yenta_socket
pcmcia_core            39508  3 pcmcia,yenta_socket,rsrc_nonstatic
agpgart                29800  1 intel_agp

If I don't do 'cardctl eject', or do 'cardctl eject' and 'cardctl
insert', then run the hibernate script (which unloads prism54), it
hibernates fine.

With no card in the slot, all is well.

With the xircom card in the slot, hibernation works fine if I don't do
'cardctl eject' first.  If I do 'cardctl eject' that produces the same
DANGER message as with the prism54 card.  But hibernation still works,
although it seems a bit suspect: As it is hibernating, messages appear
about it enabling eth0.

Here's the lspci for the xircom card:

0000:06:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
0000:06:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem
   (rev 03) (prog-if 02 [16550])

And lspci -vv for the prism54:

0000:06:00.0 Network controller: Intersil Corporation Intersil ISL3890
[Prism GT/Prism Duette] (rev 01)
       Subsystem: Intersil Corporation: Unknown device 0000
       Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop-
       ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
       >TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Interrupt: pin A routed to IRQ 11
       Region 0: Memory at 24800000 (32-bit, non-prefetchable)
       [size=8K]
       Capabilities: [dc] Power Management version 1
		     Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
		     PME(D0+,D1+,D2+,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-

I also noticed the familiar 'irq 9: nobody cared' messages in the
dmesg log, which may be related to the problems above:

[4296190.977000] suspend: (pages needed: 5792 + 512 free: 141637)
[4296190.977000] alloc_pagedir(): nr_pages = 5792
[4296190.977000] create_pbe_list(): initialized 5792 PBEs
[4296190.977000] copy_data_pages(): pages to copy: 5792
[4296190.977000] [nosave pfn 0x3b1]<7>[nosave pfn
0x3b2]<3>[4296242.039000] irq 9: nobody cared (try booting with the
"irqpoll" option)
[4296242.039000]  [<c013e22a>] __report_bad_irq+0x2a/0xa0
[4296242.039000]  [<c013da10>] handle_IRQ_event+0x30/0x70
[4296242.039000]  [<c013e340>] note_interrupt+0x80/0xf0
[4296242.039000]  [<c013db84>] __do_IRQ+0x134/0x140
[4296242.039000]  [<c0104c83>] do_IRQ+0x23/0x40
[4296242.039000]  [<c01033e2>] common_interrupt+0x1a/0x20
[4296242.039000]  [<c01208e3>] __do_softirq+0x43/0xb0
[4296242.039000]  [<c012097d>] do_softirq+0x2d/0x30
[4296242.039000]  [<c0120a57>] irq_exit+0x37/0x40
[4296242.039000]  [<c0104c88>] do_IRQ+0x28/0x40
[4296242.039000]  [<c01033e2>] common_interrupt+0x1a/0x20
[4296242.039000]  [<c013ba00>] swsusp_suspend+0x50/0xc0
[4296242.039000]  [<c013c7a1>] pm_suspend_disk+0x61/0xd0
[4296242.039000]  [<c013a226>] enter_state+0xa6/0xb0
[4296242.039000]  [<c013a362>] state_store+0x92/0x9e
[4296242.039000]  [<c0199fdd>] subsys_attr_store+0x3d/0x50
[4296242.039000]  [<c019a28e>] flush_write_buffer+0x3e/0x50
[4296242.039000]  [<c019a2f4>] sysfs_write_file+0x54/0x80
[4296242.039000]  [<c0160026>] vfs_write+0xb6/0x180
[4296242.039000]  [<c01601c1>] sys_write+0x51/0x80
[4296242.039000]  [<c0103225>] syscall_call+0x7/0xb
[4296242.039000] handlers:
[4296242.039000] [<c01f0789>] (acpi_irq+0x0/0x16)
[4296242.039000] Disabling IRQ #9

The lspci -vv has this, so somebody should care about irq 9!

0000:00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-
	     VGASnoop- ParErr- Stepping- SERR- FastB2B-
	     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
	     >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	     Interrupt: pin ? routed to IRQ 9

> Perhaps the patch from Daniel Ritz to free the yenta IRQ on suspend
> (attached) will help?

I will try that next.

-Sanjoy
