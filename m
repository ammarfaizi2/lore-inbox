Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264246AbTCXPZ2>; Mon, 24 Mar 2003 10:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264247AbTCXPZ2>; Mon, 24 Mar 2003 10:25:28 -0500
Received: from [81.80.245.157] ([81.80.245.157]:58798 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id <S264246AbTCXPZZ>;
	Mon, 24 Mar 2003 10:25:25 -0500
Date: Mon, 24 Mar 2003 16:36:59 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux@brodo.de
Subject: pcmcia_bus_type changes cause oops...
Message-ID: <20030324153659.GA32044@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux@brodo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The recent changes in 2.5.65-BK broke my pcmcia network driver.
It smells like a synchronisation and locking issue between the
pcmcia / ds / pcnet_cs modules loading and initialisation.

This is reproducible 99%, in 1% of the cases timing gets slightly
modified and I get a succesful loading, see below.

I've enabled debugging in lib/kobject.c and here is what I get:

---------8<---------------------------------------8<-----------
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
subsystem pcmcia_socket: registering
kobject pcmcia_socket: registering. parent: <NULL>, set: class
kobject devices: registering. parent: pcmcia_socket, set: <NULL>
kobject drivers: registering. parent: pcmcia_socket, set: <NULL>
subsystem pcmcia: registering
kobject pcmcia: registering. parent: <NULL>, set: bus
kobject devices: registering. parent: pcmcia, set: <NULL>
kobject drivers: registering. parent: pcmcia, set: <NULL>
ds: no socket drivers loaded!
pcnet_cs: Unknown symbol pcmcia_unregister_driver
pcnet_cs: Unknown symbol pcmcia_register_driver
kobject cardbus: registering. parent: <NULL>, set: drivers
Yenta IRQ list 0cb8, PCI irq9
Socket status: 30000006
subsystem pcmcia: registering
kobject pcmcia: registering. parent: <NULL>, set: bus
Unable to handle kernel paging request at virtual address c7980928
 printing eip:
c01b8748
*pde = 01171067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01b8748>]    Not tainted
EFLAGS: 00010282
EIP is at kobject_add+0x108/0x120
eax: c03123a8   ebx: c03123a0   ecx: c7980928   edx: c797b928
esi: c03123dc   edi: c797b914   ebp: c6397f50   esp: c6397f30
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 682, threadinfo=c6396000 task=c6ab06c0)
Stack: c029b6f4 00000042 c02ac63a c03123b0 00000000 c797b904 c797b904 c797b924 
       c6397f64 c01b8aff c797b914 c797b914 c797b900 c6397f84 c0212909 c797b904 
       0000001d 0000000d c797b9e0 c02debd8 c02debd8 c6397f90 c7951012 c797b900 
Call Trace:
 [<c797b904>] pcmcia_bus_type+0x4/0xe0 [ds]
 [<c797b904>] pcmcia_bus_type+0x4/0xe0 [ds]
 [<c797b924>] pcmcia_bus_type+0x24/0xe0 [ds]
 [<c01b8aff>] subsystem_register+0x2f/0x50
 [<c797b914>] pcmcia_bus_type+0x14/0xe0 [ds]
 [<c797b914>] pcmcia_bus_type+0x14/0xe0 [ds]
 [<c797b900>] pcmcia_bus_type+0x0/0xe0 [ds]
 [<c0212909>] bus_register+0x39/0xb0
 [<c797b904>] pcmcia_bus_type+0x4/0xe0 [ds]
 [<c797b9e0>] +0x0/0x100 [ds]
 [<c7951012>] +0x12/0x20 [ds]
 [<c797b900>] pcmcia_bus_type+0x0/0xe0 [ds]
 [<c7951248>] init_pcmcia_module+0x8/0xe [ds]
 [<c0135c5a>] sys_init_module+0x15a/0x240
 [<c010b25b>] syscall_call+0x7/0xb

Code: 89 11 89 4a 04 8b 47 20 83 c0 10 89 04 24 e8 e5 00 00 00 89 
---------8<---------------------------------------8<-----------

Under some circumstances modifying slightly the timings (here it
was a forced fsck on /), all loads corectly, as shown below:

---------8<---------------------------------------8<-----------
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
subsystem pcmcia_socket: registering
kobject pcmcia_socket: registering. parent: <NULL>, set: class
kobject devices: registering. parent: pcmcia_socket, set: <NULL>
kobject drivers: registering. parent: pcmcia_socket, set: <NULL>
subsystem pcmcia: registering
kobject pcmcia: registering. parent: <NULL>, set: bus
kobject devices: registering. parent: pcmcia, set: <NULL>
kobject drivers: registering. parent: pcmcia, set: <NULL>
ds: no socket drivers loaded!
pcnet_cs: Unknown symbol pcmcia_unregister_driver
pcnet_cs: Unknown symbol pcmcia_register_driver
kobject cardbus: registering. parent: <NULL>, set: drivers
Yenta IRQ list 0cb8, PCI irq9
Socket status: 30000419
subsystem pcmcia: registering
kobject pcmcia: registering. parent: <NULL>, set: bus
kobject devices: registering. parent: pcmcia, set: <NULL>
kobject drivers: registering. parent: pcmcia, set: <NULL>
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
kobject pcnet_cs: registering. parent: <NULL>, set: drivers
kobject eth0: registering. parent: <NULL>, set: net
eth0: NE2000 Compatible: io 0x300, irq 3, hw_addr 00:50:01:00:38:DE
Module pcnet_cs cannot be unloaded due to unsafe usage in include/linux/module.h:432
---------8<---------------------------------------8<-----------

Need more details ?

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
