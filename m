Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSFNSat>; Fri, 14 Jun 2002 14:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSFNSas>; Fri, 14 Jun 2002 14:30:48 -0400
Received: from maila.telia.com ([194.22.194.231]:55776 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S311898AbSFNSaq>;
	Fri, 14 Jun 2002 14:30:46 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206141038020.2576-100000@home.transmeta.com>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jun 2002 20:30:34 +0200
Message-ID: <m2r8j9af1x.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> However, it _looks_ like the lack of resource allocation is simply because
> we never bothered to even try to allocate them.
> 
> Pat, your change to use "pci_do_scan_bus()" seems to have dropped the:
> 
>                 /* FIXME: Do we need to enable the expansion ROM? */
>                 for (r = 0; r < 7; r++) {
>                         struct resource *res = dev->resource + r;
>                         if (res->flags)
>                                 pci_assign_resource(dev, r);
>                 }
> 
> thing completely, which is the thing that actually _allocates_ and assigns
> the resources.
> 
> Peter, mind adding that resource allocation loop to the "cb_alloc()"
> function, inside the "list_for_each(node,&bus->devices) {" loop? Just
> before the "Does this function have an interrupt at all?" line..

OK, with the patch below I get a little further. The kernel no longer
complains about resource collisions, bringing up eth0 works, but the
network card is still not usable:

        eth0: Transmit timed out, status ffffffff, CSR12 ffffffff, resetting...
        eth0: Out-of-sync dirty pointer, 0 vs. 17.


--- linux/drivers/pcmcia/cardbus.c.old	Fri Jun 14 20:04:45 2002
+++ linux/drivers/pcmcia/cardbus.c	Fri Jun 14 20:06:39 2002
@@ -262,9 +262,17 @@
 	 */
 	irq = s->cap.pci_irq;
 	list_for_each(node,&bus->devices) {
+		int r;
 		u8 irq_pin;
 		pdev = list_entry(node,struct pci_dev, bus_list);
 
+		/* FIXME: Do we need to enable the expansion ROM? */
+		for (r = 0; r < 7; r++) {
+			struct resource *res = pdev->resource + r;
+			if (res->flags)
+				pci_assign_resource(pdev, r);
+		}
+
 		/* Does this function have an interrupt at all? */
 		pci_readb(pdev, PCI_INTERRUPT_PIN, &irq_pin);
 		if (irq_pin) {


Linux version 2.5.21-packet (petero@p4.localdomain) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #18 Fri Jun 14 20:06:47 CEST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000004000000 (usable)
64MB LOWMEM available.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=test ro root=304 BOOT_FILE=/vmlinuz console=ttyS0,115200n8
Initializing CPU#0
Detected 233.868 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 466.94 BogoMIPS
Memory: 62696k/65536k available (1152k kernel code, 2452k reserved, 287k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: BIOS32 Service Directory structure at 0xc00e8050
PCI: BIOS32 Service Directory entry at 0xeaf90
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=02
PCI: PCI BIOS revision 2.10 entry at 0xeafd0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Scanning bus 00
Found 00:00 [8086/7100] 000600 00
PCI: Calling quirk c01d56a0 for 00:00.0
Found 00:38 [8086/7110] 000680 00
PCI: Calling quirk c01d56a0 for 00:07.0
Found 00:39 [8086/7111] 000101 00
PCI: Calling quirk c01d56a0 for 00:07.1
PCI: IDE base address fixup for 00:07.1
Found 00:3a [8086/7112] 000c03 00
PCI: Calling quirk c01d56a0 for 00:07.2
PCI: Calling quirk c0273da0 for 00:07.2
Found 00:3b [8086/7113] 000680 00
PCI: Calling quirk c01d56a0 for 00:07.3
PCI: Calling quirk c01d5770 for 00:07.3
PCI: Calling quirk c0273be0 for 00:07.3
Found 00:40 [5333/8c01] 000300 00
PCI: Calling quirk c01d56a0 for 00:08.0
Found 00:50 [104c/ac17] 000607 02
PCI: Calling quirk c01d56a0 for 00:0a.0
Found 00:51 [104c/ac17] 000607 02
PCI: Calling quirk c01d56a0 for 00:0a.1
Fixups for bus 00
PCI: Scanning for ghost devices on bus 0
Scanning behind PCI bridge 00:0a.0, config 000000, pass 0
Scanning behind PCI bridge 00:0a.1, config 000000, pass 0
Scanning behind PCI bridge 00:0a.0, config 000000, pass 1
Scanning behind PCI bridge 00:0a.1, config 000000, pass 1
Bus scan for 00 returning with max=08
PCI: Peer bridge fixup
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fe840
00:07 slot=00 0:00/1eb8 1:00/1eb8 2:00/1eb8 3:63/0400
00:0a slot=00 0:60/0400 1:61/0400 2:00/0400 3:00/0400
00:0c slot=00 0:60/1eb8 1:00/1eb8 2:00/1eb8 3:00/1eb8
PCI: Attempting to find IRQ router for 8086:122e
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: IRQ fixup
00:0a.0: ignoring bogus IRQ 255
00:0a.1: ignoring bogus IRQ 255
IRQ for 00:0a.0:0 -> PIRQ 60, mask 0400, excl 0000<4>PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=0 ... failed
IRQ for 00:0a.1:1 -> PIRQ 61, mask 0400, excl 0000<4>PCI: IRQ 0 for device 00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=0 ... failed
PCI: Allocating resources
PCI: Resource 00001100-0000110f (f=101, d=0, p=0)
PCI: Resource 0000f300-0000f31f (f=101, d=0, p=0)
PCI: Resource c0000000-c3ffffff (f=200, d=0, p=0)
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1220
  got res[10001000:10001fff] for resource 0 of Texas Instruments PCI1220 (#2)
PCI: Sorting device list...
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
PCI: Calling quirk c0273950 for 00:00.0
Limiting direct PCI/PCI transfers.
PCI: Calling quirk c0273e10 for 00:00.0
PCI: Calling quirk c0273e10 for 00:07.0
PCI: Calling quirk c0273e10 for 00:07.1
PCI: Calling quirk c0273e10 for 00:07.2
PCI: Calling quirk c0273e10 for 00:07.3
PCI: Calling quirk c0273e10 for 00:08.0
PCI: Calling quirk c0273e10 for 00:0a.0
PCI: Calling quirk c0273e10 for 00:0a.1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 224 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: unknown interface: Intel Corp. 82371AB PIIX4 IDE, PCI slot 00:07.1
hda: TOSHIBA MK4006MAV, DISK drive
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 8007552 sectors, CHS=7944/16/63
 hda: [PTBL] [993/128/63] hda1 hda2 hda3 hda4
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for ATAPI devices
scsi: device set offline - command error recover failed: host 0 channel 0 id 0 lun 0
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
IRQ for 00:0a.0:0 -> PIRQ 60, mask 0400, excl 0000<4>PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=10 -> assigning IRQ 10 -> edge ... OK
PCI: Assigned IRQ 10 for device 00:0a.0
IRQ for 00:0a.1:1 -> PIRQ 61, mask 0400, excl 0000<4>PCI: IRQ 0 for device 00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=10 -> assigning IRQ 10 ... OK
PCI: Assigned IRQ 10 for device 00:0a.1
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
ip_conntrack version 2.0 (512 buckets, 4096 max) - 292 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0a98, PCI irq10
Socket status: 30000068
Yenta IRQ list 0a98, PCI irq10
Socket status: 30000006
cs: cb_alloc(bus 1): vendor 0x13d1, device 0xab02
Scanning bus 01
Found 01:00 [13d1/ab02] 000200 00
PCI: Calling quirk c01d56a0 for 01:00.0
Fixups for bus 01
PCI: Scanning for ghost devices on bus 1
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Bus scan for 01 returning with max=01
  got res[1800:18ff] for resource 0 of PCI device 13d1:ab02 (Abocom Systems Inc)
  got res[10002000:100023ff] for resource 1 of PCI device 13d1:ab02 (Abocom Systems Inc)
  got res[10020000:1003ffff] for resource 6 of PCI device 13d1:ab02 (Abocom Systems Inc)
PCI: Enabling device 01:00.0 (0000 -> 0003)
IRQ for 01:00.0:0 -> not found in routing table
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 200k freed
INIT: version 2.78 booting
			Welcome to Red Hat Linux
		Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
modprobe: modprobe: cannot create /var/log/ksymoops/20020614.log Read-only file system
modprobe: modprobe: cannot create /var/log/ksymoops/20020614.log Read-only file system
Setting clock  (utc): Fri Jun 14 20:09:35 CEST 2002 [  OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname pengo.localdomain:  [  OK  ]
modprobe: cannot create /var/log/ksymoops/20020614.log Read-only file system
/lib/modules/2.5.21-packet/kernel/drivers/usb/core/usbcore.o: cannot create /var/log/ksymoops/20020614200935.ksyms Read-only file system
/lib/modules/2.5.21-packet/kernel/drivers/usb/core/usbcore.o: cannot create /var/log/ksymoops/20020614.log Read-only file system
Mounting USB filesystem:  [  OK  ]
Initializing USB controller (usb-uhci-hcd):  [  OK  ]
Checking root filesystem
/dev/hda4: clean, 133078/759808 files, 2827438/3032064 blocks
[/sbin/fsck.ext2 -- /] fsck.ext2 -a /dev/hda4 
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Finding module dependencies:  [  OK  ]
Checking filesystems
Checking all file systems.
[  OK  ]
Mounting local filesystems:  [  OK  ]
Turning on user and group quotas for local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting up APM daemon: [  OK  ]
apmd[198]: Charge: * * * (-1% unknown)
Setting network parameters:  [  OK  ]
Bringing up interface lo:  [  OK  ]
Bringing up interface eth0:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting portmapper: [  OK  ]
Starting NFS file locking services: 
Starting NFS statd: [  OK  ]
Starting automount:[  OK  ]
Initializing random number generator:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting identd: [  OK  ]
Starting atd: [  OK  ]
Starting pcmcia:  [  OK  ]
Starting xinetd: [  OK  ]
Starting named: [  OK  ]
Starting lpd: [  OK  ]
Starting NFS services:  eth0: Transmit timed out, status ffffffff, CSR12 ffffffff, resetting...
eth0: Transmit timed out, status ffffffff, CSR12 ffffffff, resetting...
eth0: Out-of-sync dirty pointer, 0 vs. 17.
eth0: Transmit timed out, status ffffffff, CSR12 ffffffff, resetting...
[  OK  ]
Starting NFS quotas: [  OK  ]
Starting NFS mountd: eth0: Transmit timed out, status ffffffff, CSR12 ffffffff, resetting...
eth0: Out-of-sync dirty pointer, 16 vs. 33.
INIT: Switching to runlevel: 6
INIT: Sending processes the TERM signal
Stopping named: [  OK  ]
Stopping xinetd: [  OK  ]
Stopping atd: [  OK  ]
Stopping lpd: [  OK  ]
Stopping identd: [  OK  ]
Shutting down NFS file locking services: 
Shutting down NFS statd: [  OK  ]
Saving random seed:  [  OK  ]
Stopping automount:[  OK  ]
Stopping portmapper: [  OK  ]
Shutting down kernel logger: [  OK  ]
Shutting down system logger: [  OK  ]
Shutting down interface eth0:  [  OK  ]
Shutting down APM daemon: [  OK  ]
Starting killall:  [  OK  ]
Sending all processes the TERM signal... 
Sending all processes the KILL signal... 
Syncing hardware clock to system time 
Turning off swap:  
Turning off quotas:  
Unmounting file systems:  
Unmounting proc file system:  
Please stand by while rebooting the system...
flushing ide devices: hda <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c017aea3
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c017aea3>]    Not tainted
EFLAGS: 00010202
eax: c02c6d24   ebx: c37bc000   ecx: 00000000   edx: 00000000
esi: c02c6d0c   edi: c02622a0   ebp: 00000000   esp: c37bde50
ds: 0018   es: 0018   ss: 0018
Process reboot (pid: 924, threadinfo=c37bc000 task=c11d3760)
Stack: c02c6d0c c02c6bb4 00000001 c017b21d c02c6d0c c02c6bb0 c01b03ac c02c6d0c 
       c02c6bb0 c01a9ac6 c02c6bb0 c0261ddc 00000000 00000001 bffffcc8 c011e27c 
       c0261ddc 00000001 00000000 00000001 c37bc000 fee1dead c011e64e c02a8b88 
Call Trace: [<c017b21d>] [<c01b03ac>] [<c01a9ac6>] [<c011e27c>] [<c011e64e>] 
   [<c01241ec>] [<c01de9a6>] [<c01d9187>] [<c0138f7b>] [<c014ac2e>] [<c01d69d4>] 
   [<c01490ec>] [<c01380ea>] [<c0136bc0>] [<c0136c31>] [<c0106ee7>] 

Code: 89 4a 04 89 11 89 46 18 89 40 04 8b 43 10 48 89 43 10 8b 43 
 <6>note: reboot[924] exited with preempt_count 2
/etc/rc6.d/S01reboot: line 1:   924 Segmentation fault      reboot -i -d -p
INIT: no more processes left in this runlevel

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
