Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbTFVDug (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 23:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbTFVDuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 23:50:35 -0400
Received: from moraine.clusterfs.com ([216.138.243.178]:44764 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265499AbTFVDuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 23:50:24 -0400
Date: Sat, 21 Jun 2003 22:06:44 -0600
From: Peter Braam <braam@clusterfs.com>
To: linux-kernel@vger.kernel.org, akpm@digeo.com
Cc: Alex Tomas <bzzz@tmi.comex.ru>
Subject: 2.5.72 kgdb woes
Message-ID: <20030622040644.GF32265@peter.cfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to use kgdb with vmware 3.2.  VMware is configured with:
 
serial.v2=False
serial0.yieldOnMsrRead = "TRUE"
serial0.present= "TRUE"
serial0.fileName = "/dev/ptys0"
serial0.tryNoRxLoss = "true"
serial0.fileType = "tty"

I run linux as: 

        append="kgdb gdbttyS=0 gdbbaud=115200 console=kgdb"

and kgdb as:

gdb vmlinux 
   shell echo -e "\003" >/dev/ttys0
   set remotebaud 115200
   target remote /dev/ttys0

-------------------------------------
Everything starts fine, but it hangs soon after: 

POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd980, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Cannot allocate resource region 4 of device 00:07.1
pty: 512 Unix98 ptys configured
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Limiting direct PCI/PCI transfers.

-------------------------

Here the systems hangs. The stack is then:

Program received signal SIGTRAP, Trace/breakpoint trap.
gdb_interrupt (irq=-1070914560, dev_id=0x0, regs=0xc12afe6c)
    at arch/i386/lib/kgdb_serial.c:195
195                             continue;
(gdb) bt
#0  gdb_interrupt (irq=-1070914560, dev_id=0x0, regs=0xc12afe6c)
    at arch/i386/lib/kgdb_serial.c:195
#1  0xc010c453 in handle_IRQ_event (irq=4, regs=0xc12afe6c, action=0x3)
    at arch/i386/kernel/irq.c:222
#2  0xc010c6f2 in do_IRQ (regs=
      {ebx = 642, ecx = 1016, edx = -1, esi = 71, edi = 4099, ebp = -1054146908, eax = -1070914560, xds = 123, xes = 123, orig_eax = -252, eip = -1071999793, xcs = 96, eflags = 642, esp = 0, xss = -1054146880})
    at arch/i386/kernel/irq.c:485
#3  0xc010ae08 in common_interrupt () at arch/i386/kernel/entry.S:426
#4  0xc01a980c in getDebugChar () at arch/i386/lib/kgdb_serial.c:363
#5  0xc011433d in putpacket (
    buffer=0xc0314ea0 "O4c696d6974696e6720646972656374205043492f504349207472616e73666572732e0a") at arch/i386/kernel/kgdb_stub.c:463
#6  0xc01158d4 in kgdb_gdb_message (s=0xc03166f3 "", count=0)
    at arch/i386/kernel/kgdb_stub.c:1969
#7  0xc011a7a5 in __call_console_drivers (start=1016, end=3224456935)
    at kernel/printk.c:294
#8  0xc011a893 in call_console_drivers (start=1016, end=2771)
    at kernel/printk.c:355
#9  0xc011ab31 in release_console_sem () at kernel/printk.c:509
#10 0xc011aa82 in printk (
    fmt=0xc0292f40 "<6>Limiting direct PCI/PCI transfers.\n")
    at kernel/printk.c:449
#11 0xc02d3b3a in quirk_natoma (dev=0xc12ea400) at drivers/pci/quirks.c:196
#12 0xc01aba60 in pci_do_fixups (dev=0xc12ea400, pass=2, f=0xc02e48dc)
    at drivers/pci/quirks.c:857
#13 0xc01aba93 in pci_fixup_device (pass=2, dev=0xc12ea400)
    at drivers/pci/quirks.c:866
#14 0xc02d3811 in pci_init () at drivers/pci/pci.c:720
#15 0xc02c872b in do_initcalls () at init/main.c:494
#16 0xc0105055 in init (unused=0x0) at init/main.c:572

The kernel boots fine with kgdb not enabled. Any ideas what is wrong
here?

Thanks.

- Peter -
