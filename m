Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313810AbSD3Q47>; Tue, 30 Apr 2002 12:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313817AbSD3Q46>; Tue, 30 Apr 2002 12:56:58 -0400
Received: from rancor.jedi.net ([199.233.91.1]:46218 "EHLO rancor.jedi.net")
	by vger.kernel.org with ESMTP id <S313810AbSD3Q4W>;
	Tue, 30 Apr 2002 12:56:22 -0400
Date: Tue, 30 Apr 2002 11:55:37 -0500
From: Jason Crickmer <jason@rancor.jedi.net>
To: linux-kernel@vger.kernel.org
Subject: VIA UHCI USB controller interrupt problems
Message-ID: <20020430165537.GA24479@rancor.jedi.net>
Reply-To: jason@jedi.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I have been working with a HP Pavilion zt1170 laptop for the past few
days, trying to get it to work with a PS/2 mouse and keyboard via a
USB connector (Inland "USB to PS/2 Converter").  The problem seems to
be that the devices are never heard back from once the kernel inits
them.  Windows and Grub seem to have no problem using these devices
through the USB port, but Linux is having a bear of a time.

Windows XP gives the USB hubs (which the machine has two of) IRQ 9,
along with every other PCI device, except the AGP video.  The
out-of-the-box Redhat Rawhide kernel (2.4.18-0.22) assigns it IRQ 10.
With this setting, I get a bunch of "usb_control/bulk_msg: timeout"
errors.  After searching around, I found that some people blamed these
types of errors on faulty BIOS's and ended up just hacking pci-irq.c
to force the appropriate behavior for their USB devices.

So, I have given this several tries following the suggestions made by
Jan Slupski <jslupski@email.com>
(http://www.pm.waw.pl/~jslupski/vaio/,
http://www.ussg.iu.edu/hypermail/linux/kernel/0111.3/1532.html) and
John Clemens <john@deater.net>
(http://www.ussg.iu.edu/hypermail/linux/kernel/0111.2/0005.html).

After doing this, I was able to get the kernel to "say" that IRQ 9 is
being used for the devices, but lspci -x still shows a value of 0x0a
at 0x3d (PCI_INTERRUPT_LINE).  And, I still get the
"usb_control/bulk_msg: timeout" messages, as well as "usb.c: USB
device not accepting new address=3 (error=-110)" when I plug a USB
device in.  I have tried using setpci to set the IRQ, but to no avail.

Below are the following:

  1. my most recent patch to arch/i386/kernel/pci-irq.c
  2. kernel boot messages (dmesg) (with my patch)
  3. relevant snippets from /var/log/messages (with my patch)
  4. /proc/interrupts (with my patch)
  5. lspci -x (with my patch)
  6. Windows XP Device Manager dump


I know this list is primarily for development, and my question is more
support related, so if it would be me appropraite to take this
off-line, just let me know.  Any help or suggestions would be much
appreciated!

Thanks,
Jason


1. my most recent patch to arch/i386/kernel/pci-irq.c
----------------------------------------------------------------------
--- linux/arch/i386/kernel/pci-irq.c.orig	Tue Apr 30 10:40:38 2002
+++ linux/arch/i386/kernel/pci-irq.c	Sun Apr 28 19:10:37 2002
@@ -35,7 +35,7 @@
 
 static int pirq_penalty[16] = {
 	1000000, 1000000, 1000000, 1000, 1000, 0, 1000, 1000,
-	0, 0, 0, 0, 2500, 100000, 100000, 100000
+	0, 10000, 0, 0, 2500, 100000, 100000, 100000
 };
 
 struct irq_router {
@@ -578,6 +578,7 @@
 	pin = pin - 1;
 	
 	DBG("IRQ for %s:%d", dev->slot_name, pin);
+	printk(KERN_WARNING "IRQ for %s:%d", dev->slot_name, pin);
 	info = pirq_get_info(dev);
 	if (!info) {
 		DBG(" -> not found in routing table\n");
@@ -590,12 +591,30 @@
 		return 0;
 	}
 	DBG(" -> PIRQ %02x, mask %04x, excl %04x", pirq, mask, pirq_table->exclusive_irqs);
+	printk(KERN_WARNING " -> PIRQ 0x%02x, mask 0x%04x, excl 0x%04x\n", pirq, mask, pirq_table->exclusive_irqs);
 	mask &= pcibios_irq_mask;
 
 	/* Work around broken HP Pavilion Notebooks which assign USB to
 	   IRQ 9 even though it is actually wired to IRQ 11 */
 
+	printk(KERN_WARNING "Let's see what we have...\n");
+	printk(KERN_WARNING "  Vendor:  0x%04x\n", dev->vendor);
+	printk(KERN_WARNING "  Device:  0x%04x\n", dev->device);
+	printk(KERN_WARNING "  IRQ:  %d\n", dev->irq);
+	printk(KERN_WARNING "  mask:  0x%04x\n", mask);
+	printk(KERN_WARNING "  pirq:  0x%04x\n", pirq);
+
+	if ((dev->vendor == 0x1106)
+	    && (dev->device == 0x3038)) {
+	    printk(KERN_WARNING "Looks like a faulty HP BIOS.  Setting USB hub to IRQ 9!\n");
+	    dev->irq = 9;
+	    pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 9);
+	    //r->set(pirq_router_dev, dev, pirq, 9);
+	    printk(KERN_WARNING "IRQ set to %d\n", dev->irq);
+	}
+
 	if (broken_hp_bios_irq9 && pirq == 0x59 && dev->irq == 9) {
+	  printk(KERN_WARNING "We must have a broken hp bios %d with IRQ of 9, reset to 11.\n", broken_hp_bios_irq9);
 		dev->irq = 11;
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
 		r->set(pirq_router_dev, dev, pirq, 11);
@@ -618,20 +637,28 @@
 		}
 	}
 	DBG(" -> newirq=%d", newirq);
+	printk(KERN_WARNING " -> newirq=%d\n", newirq);
 
 	/* Check if it is hardcoded */
 	if ((pirq & 0xf0) == 0xf0) {
 		irq = pirq & 0xf;
 		DBG(" -> hardcoded IRQ %d\n", irq);
+		printk(KERN_WARNING " -> hardcoded IRQ %d\n", irq);
 		msg = "Hardcoded";
-	} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq))) {
+	} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq))
+		   && !((dev->vendor == 0x1106)
+			&& (dev->device == 0x3038))) {
+	        printk(KERN_WARNING "Got IRQ %d by virtue of JSlupski's fix\n", irq);
 		DBG(" -> got IRQ %d\n", irq);
+		printk(KERN_WARNING " -> got IRQ %d\n", irq);
 		msg = "Found";
 	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
 		DBG(" -> assigning IRQ %d", newirq);
+		printk(KERN_WARNING " -> assigning IRQ %d", newirq);
 		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
 			eisa_set_level_irq(newirq);
 			DBG(" ... OK\n");
+			printk(KERN_WARNING " ... OK\n");
 			msg = "Assigned";
 			irq = newirq;
 		}
@@ -639,13 +666,14 @@
 
 	if (!irq) {
 		DBG(" ... failed\n");
+		printk(KERN_WARNING " ... failed newirq = %d and mask is 0x%04x\n", newirq, mask);
 		if (newirq && mask == (1 << newirq)) {
 			msg = "Guessed";
 			irq = newirq;
 		} else
 			return 0;
 	}
-	printk(KERN_INFO "PCI: %s IRQ %d for device %s\n", msg, irq, dev->slot_name);
+	printk(KERN_WARNING "PCI: %s IRQ %d for device %s\n", msg, irq, dev->slot_name);
 
 	/* Update IRQ for all devices with the same pirq value */
 	pci_for_each_dev(dev2) {
----------------------------------------------------------------------

2. kernel boot messages (dmesg) (with my patch)
----------------------------------------------------------------------
Linux version 2.4.18-0.22_d3 (root@legolas.agentelf.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Sun Apr 28 19:17:16 CDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
 BIOS-e820: 000000001eff0000 - 000000001effffc0 (ACPI data)
 BIOS-e820: 000000001effffc0 - 000000001f000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 126960
zone(0): 4096 pages.
zone(1): 122864 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda4 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 733.231 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1461.45 BogoMIPS
Memory: 497552k/507840k available (1172k kernel code, 9900k reserved, 784k data, 280k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xe8a54, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/8231] at 00:11.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
aio_setup: okay!
aio_setup: sizeof(struct page) = 56
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
block: 960 slots per queue, batch=240
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23CA-30, ATA DISK drive
hdc: SONY CD-RW CRX800E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63, UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3 hda4
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 325k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 280k freed
Adding Swap: 787176k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 19:44:27 Apr 28 2002
usb-uhci.c: High bandwidth mode enabled
IRQ for 00:11.2:3<4> -> PIRQ 0x05, mask 0x0ee8, excl 0x0000
Let's see what we have...
  Vendor:  0x1106
  Device:  0x3038
  IRQ:  10
  mask:  0x0ee8
  pirq:  0x0005
Looks like a faulty HP BIOS.  Setting USB hub to IRQ 9!
IRQ set to 9
 -> newirq=9
 ... failed newirq = 9 and mask is 0x0ee8
usb-uhci.c: USB UHCI at I/O 0x1200, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
IRQ for 00:11.3:3<4> -> PIRQ 0x05, mask 0x0ee8, excl 0x0000
Let's see what we have...
  Vendor:  0x1106
  Device:  0x3038
  IRQ:  10
  mask:  0x0ee8
  pirq:  0x0005
Looks like a faulty HP BIOS.  Setting USB hub to IRQ 9!
IRQ set to 9
 -> newirq=9
 ... failed newirq = 9 and mask is 0x0ee8
usb-uhci.c: USB UHCI at I/O 0x1300, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,4), internal journal
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX800E    Rev: 1.1b
  Type:   CD-ROM                             ANSI SCSI revision: 02
hdc: DMA disabled
----------------------------------------------------------------------

3. relevant snippets from /var/log/messages (with my patch)
----------------------------------------------------------------------
Apr 30 09:39:29 legolas syslogd 1.4.1: restart.
Apr 30 09:39:29 legolas syslog: syslogd startup succeeded
Apr 30 09:39:29 legolas syslog: klogd startup succeeded
Apr 30 09:39:29 legolas kernel: klogd 1.4.1, log source = /proc/kmsg started.
Apr 30 09:39:29 legolas kernel: Inspecting /boot/System.map-2.4.18-0.22_d3
Apr 30 09:39:30 legolas portmap: portmap startup succeeded
Apr 30 09:39:30 legolas kernel: Loaded 16141 symbols from /boot/System.map-2.4.18-0.22_d3.
Apr 30 09:39:30 legolas kernel: Symbols match kernel version 2.4.18.
Apr 30 09:39:30 legolas kernel: Loaded 308 symbols from 12 modules.
Apr 30 09:39:30 legolas kernel: Linux version 2.4.18-0.22_d3 (root@legolas.agentelf.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Sun Apr 28 19:17:16 CDT 2002
Apr 30 09:39:30 legolas kernel: BIOS-provided physical RAM map:
Apr 30 09:39:30 legolas kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Apr 30 09:39:30 legolas kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Apr 30 09:39:30 legolas kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Apr 30 09:39:30 legolas kernel:  BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
Apr 30 09:39:30 legolas kernel:  BIOS-e820: 000000001eff0000 - 000000001effffc0 (ACPI data)
Apr 30 09:39:30 legolas kernel:  BIOS-e820: 000000001effffc0 - 000000001f000000 (ACPI NVS)
Apr 30 09:39:30 legolas kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Apr 30 09:39:30 legolas kernel: On node 0 totalpages: 126960
Apr 30 09:39:30 legolas kernel: zone(0): 4096 pages.
Apr 30 09:39:30 legolas kernel: zone(1): 122864 pages.
Apr 30 09:39:30 legolas kernel: zone(2): 0 pages.
Apr 30 09:39:30 legolas rpc.statd[626]: Version 0.3.1 Starting
Apr 30 09:39:30 legolas kernel: Kernel command line: ro root=/dev/hda4 hdc=ide-scsi
Apr 30 09:39:30 legolas nfslock: rpc.statd startup succeeded
Apr 30 09:39:30 legolas kernel: ide_setup: hdc=ide-scsi
Apr 30 09:39:31 legolas kernel: Initializing CPU#0
Apr 30 09:39:31 legolas rpc.statd[626]: gethostbyname error for legolas.agentelf.com
Apr 30 09:39:31 legolas kernel: Detected 733.231 MHz processor.
Apr 30 09:39:31 legolas kernel: Console: colour VGA+ 80x25
Apr 30 09:39:31 legolas kernel: Calibrating delay loop... 1461.45 BogoMIPS
Apr 30 09:39:31 legolas kernel: Memory: 497552k/507840k available (1172k kernel code, 9900k reserved, 784k data, 280k init, 0k highmem)
Apr 30 09:39:31 legolas kernel: Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Apr 30 09:39:31 legolas kernel: Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Apr 30 09:39:31 legolas kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Apr 30 09:39:31 legolas kernel: Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Apr 30 09:39:31 legolas kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Apr 30 09:39:31 legolas kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Apr 30 09:39:31 legolas kernel: CPU: L2 cache: 512K
Apr 30 09:39:31 legolas kernel: Intel machine check architecture supported.
Apr 30 09:39:31 legolas kernel: Intel machine check reporting enabled on CPU#0.
Apr 30 09:39:31 legolas kernel: CPU: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
Apr 30 09:39:31 legolas kernel: Enabling fast FPU save and restore... done.
Apr 30 09:39:31 legolas kernel: Enabling unmasked SIMD FPU exception support... done.
Apr 30 09:39:31 legolas kernel: Checking 'hlt' instruction... OK.
Apr 30 09:39:31 legolas kernel: POSIX conformance testing by UNIFIX
Apr 30 09:39:31 legolas kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Apr 30 09:39:32 legolas kernel: mtrr: detected mtrr type: Intel
Apr 30 09:39:32 legolas kernel: PCI: PCI BIOS revision 2.10 entry at 0xe8a54, last bus=1
Apr 30 09:39:32 legolas kernel: PCI: Using configuration type 1
Apr 30 09:39:15 legolas rc.sysinit: Mounting proc filesystem:  succeeded 
Apr 30 09:39:32 legolas kernel: PCI: Probing PCI hardware
Apr 30 09:39:15 legolas rc.sysinit: Unmounting initrd:  succeeded 
Apr 30 09:39:32 legolas kernel: PCI: Using IRQ router default [1106/8231] at 00:11.0
Apr 30 09:39:15 legolas sysctl: net.ipv4.ip_forward = 0 
Apr 30 09:39:32 legolas kernel: isapnp: Scanning for PnP cards...
Apr 30 09:39:15 legolas sysctl: net.ipv4.conf.default.rp_filter = 1 
Apr 30 09:39:32 legolas kernel: isapnp: No Plug & Play device found
Apr 30 09:39:15 legolas sysctl: kernel.sysrq = 0 
Apr 30 09:39:32 legolas kernel: Linux NET4.0 for Linux 2.4
Apr 30 09:39:15 legolas sysctl: kernel.core_uses_pid = 1 
Apr 30 09:39:32 legolas kernel: Based upon Swansea University Computer Society NET3.039
Apr 30 09:39:15 legolas rc.sysinit: Configuring kernel parameters:  succeeded 
Apr 30 09:39:32 legolas kernel: Initializing RT netlink socket
Apr 30 09:39:32 legolas keytable: Loading keymap:  succeeded
Apr 30 09:39:15 legolas date: Tue Apr 30 09:39:09 CDT 2002 
Apr 30 09:39:32 legolas kernel: apm: BIOS not found.
Apr 30 09:39:15 legolas rc.sysinit: Setting clock  (localtime): Tue Apr 30 09:39:09 CDT 2002 succeeded 
Apr 30 09:39:32 legolas kernel: Starting kswapd
Apr 30 09:39:15 legolas rc.sysinit: Loading default keymap succeeded 
Apr 30 09:39:32 legolas kernel: VFS: Diskquotas version dquot_6.5.0 initialized
Apr 30 09:39:15 legolas rc.sysinit: Setting default font (lat0-sun16):  succeeded 
Apr 30 09:39:32 legolas keytable: Loading system font:  succeeded
Apr 30 09:39:32 legolas kernel: aio_setup: okay!
Apr 30 09:39:15 legolas rc.sysinit: Activating swap partitions:  succeeded 
Apr 30 09:39:32 legolas kernel: aio_setup: sizeof(struct page) = 56
Apr 30 09:39:15 legolas rc.sysinit: Setting hostname legolas.agentelf.com:  succeeded 
Apr 30 09:39:32 legolas kernel: pty: 2048 Unix98 ptys configured
Apr 30 09:39:15 legolas rc.sysinit: Mounting USB filesystem:  succeeded 
Apr 30 09:39:32 legolas kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Apr 30 09:39:15 legolas rc.sysinit: Initializing USB controller (usb-uhci):  succeeded 
Apr 30 09:39:32 legolas kernel: Real Time Clock Driver v1.10e
Apr 30 09:39:15 legolas fsck: /: clean, 121575/2247744 files, 628940/4492175 blocks 
Apr 30 09:39:32 legolas kernel: block: 960 slots per queue, batch=240
Apr 30 09:39:15 legolas rc.sysinit: Checking root filesystem succeeded 
Apr 30 09:39:32 legolas kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Apr 30 09:39:15 legolas rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
Apr 30 09:39:32 legolas random: Initializing random number generator:  succeeded
Apr 30 09:39:32 legolas kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Apr 30 09:39:16 legolas rc.sysinit: Finding module dependencies:  succeeded 
Apr 30 09:39:32 legolas kernel: VP_IDE: IDE controller on PCI bus 00 dev 89
Apr 30 09:39:16 legolas rc.sysinit: Checking filesystems succeeded 
Apr 30 09:39:32 legolas kernel: VP_IDE: chipset revision 6
Apr 30 09:39:16 legolas rc.sysinit: Mounting local filesystems:  succeeded 
Apr 30 09:39:32 legolas kernel: VP_IDE: not 100%% native mode: will probe irqs later
Apr 30 09:39:16 legolas rc.sysinit: Enabling local filesystem quotas:  succeeded 
Apr 30 09:39:32 legolas kernel: VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci00:11.1
Apr 30 09:39:17 legolas rc.sysinit: Enabling swap space:  succeeded 
Apr 30 09:39:32 legolas kernel:     ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
Apr 30 09:39:20 legolas init: Entering runlevel: 3 
Apr 30 09:39:32 legolas kernel:     ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
Apr 30 09:39:20 legolas modprobe: modprobe: Can't locate module block-major-2 
Apr 30 09:39:32 legolas kernel: hda: HITACHI_DK23CA-30, ATA DISK drive
Apr 30 09:39:20 legolas modprobe: modprobe: Can't locate module block-major-2 
Apr 30 09:39:32 legolas netfs: Mounting other filesystems:  succeeded
Apr 30 09:39:32 legolas kernel: hdc: SONY CD-RW CRX800E, ATAPI CD/DVD-ROM drive
Apr 30 09:39:20 legolas modprobe: modprobe: Can't locate module block-major-2 
Apr 30 09:39:32 legolas kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 30 09:39:20 legolas modprobe: modprobe: Can't locate module block-major-2 
Apr 30 09:39:32 legolas kernel: ide1 at 0x170-0x177,0x376 on irq 15
Apr 30 09:39:20 legolas kudzu: Updating /etc/fstab succeeded 
Apr 30 09:39:32 legolas kernel: hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63, UDMA(100)
Apr 30 09:39:24 legolas modprobe: modprobe: Can't locate module block-major-2 
Apr 30 09:39:33 legolas kernel: ide-floppy driver 0.99.newide
Apr 30 09:39:24 legolas modprobe: modprobe: Can't locate module block-major-2 
Apr 30 09:39:33 legolas kernel: Partition check:
Apr 30 09:39:24 legolas modprobe: modprobe: Can't locate module block-major-2 
Apr 30 09:39:33 legolas kernel:  hda: hda1 hda2 hda3 hda4
Apr 30 09:39:24 legolas modprobe: modprobe: Can't locate module block-major-2 
Apr 30 09:39:33 legolas kernel: floppy0: no floppy controllers found
[snip]
Apr 30 09:39:34 legolas kernel: usb.c: registered new driver usbdevfs
Apr 30 09:39:34 legolas kernel: usb.c: registered new driver hub
Apr 30 09:39:34 legolas kernel: usb-uhci.c: $Revision: 1.275 $ time 19:44:27 Apr 28 2002
Apr 30 09:39:34 legolas kernel: usb-uhci.c: High bandwidth mode enabled
Apr 30 09:39:34 legolas kernel: IRQ for 00:11.2:3<4> -> PIRQ 0x05, mask 0x0ee8, excl 0x0000
Apr 30 09:39:34 legolas kernel: Let's see what we have...
Apr 30 09:39:34 legolas kernel:   Vendor:  0x1106
Apr 30 09:39:34 legolas kernel:   Device:  0x3038
Apr 30 09:39:34 legolas kernel:   IRQ:  10
Apr 30 09:39:34 legolas kernel:   mask:  0x0ee8
Apr 30 09:39:34 legolas kernel:   pirq:  0x0005
Apr 30 09:39:34 legolas kernel: Looks like a faulty HP BIOS.  Setting USB hub to IRQ 9!
Apr 30 09:39:34 legolas kernel: IRQ set to 9
Apr 30 09:39:34 legolas kernel:  -> newirq=9
Apr 30 09:39:34 legolas kernel:  ... failed newirq = 9 and mask is 0x0ee8
Apr 30 09:39:34 legolas kernel: usb-uhci.c: USB UHCI at I/O 0x1200, IRQ 9
Apr 30 09:39:34 legolas kernel: usb-uhci.c: Detected 2 ports
Apr 30 09:39:34 legolas kernel: usb.c: new USB bus registered, assigned bus number 1
Apr 30 09:39:34 legolas kernel: hub.c: USB hub found
Apr 30 09:39:34 legolas kernel: hub.c: 2 ports detected
Apr 30 09:39:34 legolas kernel: IRQ for 00:11.3:3<4> -> PIRQ 0x05, mask 0x0ee8, excl 0x0000
Apr 30 09:39:34 legolas kernel: Let's see what we have...
Apr 30 09:39:34 legolas kernel:   Vendor:  0x1106
Apr 30 09:39:34 legolas kernel:   Device:  0x3038
Apr 30 09:39:34 legolas kernel:   IRQ:  10
Apr 30 09:39:34 legolas kernel:   mask:  0x0ee8
Apr 30 09:39:34 legolas kernel:   pirq:  0x0005
Apr 30 09:39:34 legolas kernel: Looks like a faulty HP BIOS.  Setting USB hub to IRQ 9!
Apr 30 09:39:34 legolas kernel: IRQ set to 9
Apr 30 09:39:34 legolas kernel:  -> newirq=9
Apr 30 09:39:34 legolas kernel:  ... failed newirq = 9 and mask is 0x0ee8
Apr 30 09:39:34 legolas kernel: usb-uhci.c: USB UHCI at I/O 0x1300, IRQ 9
Apr 30 09:39:34 legolas kernel: usb-uhci.c: Detected 2 ports
Apr 30 09:39:34 legolas kernel: usb.c: new USB bus registered, assigned bus number 2
Apr 30 09:39:34 legolas kernel: hub.c: USB hub found
Apr 30 09:39:34 legolas kernel: hub.c: 2 ports detected
Apr 30 09:39:34 legolas kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Apr 30 09:39:34 legolas kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,4), internal journal
Apr 30 09:39:34 legolas kernel: SCSI subsystem driver Revision: 1.00
Apr 30 09:39:34 legolas kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Apr 30 09:39:34 legolas kernel:   Vendor: SONY      Model: CD-RW  CRX800E    Rev: 1.1b
Apr 30 09:39:34 legolas kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Apr 30 09:39:34 legolas kernel: hdc: DMA disabled
Apr 30 09:39:34 legolas kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Apr 30 09:39:34 legolas kernel: parport0: irq 7 detected
Apr 30 09:39:34 legolas kernel: NET4: Linux IPX 0.47 for NET4.0
Apr 30 09:39:34 legolas kernel: IPX Portions Copyright (c) 1995 Caldera, Inc.
Apr 30 09:39:34 legolas kernel: IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
Apr 30 09:39:34 legolas kernel: NET4: AppleTalk 0.18a for Linux NET4.0
Apr 30 09:39:34 legolas kernel: 8139too Fast Ethernet driver 0.9.24
Apr 30 09:39:34 legolas kernel: IRQ for 00:0d.0:0<4> -> PIRQ 0x02, mask 0x0ca8, excl 0x0000
Apr 30 09:39:34 legolas kernel: Let's see what we have...
Apr 30 09:39:34 legolas kernel:   Vendor:  0x10ec
Apr 30 09:39:34 legolas kernel:   Device:  0x8139
Apr 30 09:39:34 legolas kernel:   IRQ:  10
Apr 30 09:39:34 legolas kernel:   mask:  0x0ca8
Apr 30 09:39:34 legolas kernel:   pirq:  0x0002
Apr 30 09:39:34 legolas kernel:  -> newirq=10
Apr 30 09:39:34 legolas kernel:  ... failed newirq = 10 and mask is 0x0ca8
Apr 30 09:39:34 legolas kernel: PCI: Setting latency timer of device 00:0d.0 to 64
Apr 30 09:39:34 legolas kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xdf909000, 00:02:3f:34:b5:6f, IRQ 10
Apr 30 09:39:34 legolas kernel: Linux Kernel Card Services 3.1.22
Apr 30 09:39:34 legolas kernel:   options:  [pci] [cardbus] [pm]
Apr 30 09:39:34 legolas kernel: IRQ for 00:04.0:0<4> -> PIRQ 0x01, mask 0x0ca8, excl 0x0000
Apr 30 09:39:34 legolas kernel: Let's see what we have...
Apr 30 09:39:34 legolas kernel:   Vendor:  0x1524
Apr 30 09:39:34 legolas kernel:   Device:  0x1410
Apr 30 09:39:34 legolas kernel:   IRQ:  11
Apr 30 09:39:34 legolas kernel:   mask:  0x0ca8
Apr 30 09:39:34 legolas kernel:   pirq:  0x0001
Apr 30 09:39:34 legolas kernel:  -> newirq=11
Apr 30 09:39:34 legolas kernel:  ... failed newirq = 11 and mask is 0x0ca8
Apr 30 09:39:34 legolas kernel: Yenta IRQ list 0000, PCI irq11
Apr 30 09:39:34 legolas kernel: Socket status: 30000010
Apr 30 09:39:35 legolas pcmcia:  cardmgr.
Apr 30 09:39:35 legolas cardmgr[787]: starting, version is 3.1.22
Apr 30 09:39:35 legolas rc: Starting pcmcia:  succeeded
Apr 30 09:39:35 legolas cardmgr[787]: config error, file './config.opts' line 8: no function bindings
Apr 30 09:39:35 legolas cardmgr[787]: watching 1 sockets
Apr 30 09:39:35 legolas kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Apr 30 09:39:35 legolas kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
Apr 30 09:39:35 legolas kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Apr 30 09:39:35 legolas cardmgr[787]: initializing socket 0
Apr 30 09:39:35 legolas cardmgr[787]: socket 0: Lucent Technologies WaveLAN/IEEE Adapter
Apr 30 09:39:35 legolas kernel: cs: memory probe 0xa0000000-0xa0ffffff: excluding 0xa0000000-0xa0ffffff
Apr 30 09:39:35 legolas kernel: cs: memory probe 0x60000000-0x60ffffff: clean.
Apr 30 09:39:35 legolas cardmgr[787]: executing: 'modprobe wvlan_cs'
Apr 30 09:39:35 legolas cardmgr[787]: + Warning: loading /lib/modules/2.4.18-0.22_d3/kernel/drivers/net/pcmcia/wvlan_cs.o will taint the kernel: no license
Apr 30 09:39:35 legolas kernel: wvlan_cs: WaveLAN/IEEE PCMCIA driver v1.0.6
Apr 30 09:39:35 legolas kernel: wvlan_cs: (c) Andreas Neuhaus <andy@fasta.fh-dortmund.de>
Apr 30 09:39:35 legolas kernel: wvlan_cs: index 0x01: Vcc 5.0, irq 11, io 0x0100-0x013f
Apr 30 09:39:35 legolas cardmgr[787]: executing: './network start eth1'
Apr 30 09:39:35 legolas kernel: wvlan_cs: Registered netdevice eth1
Apr 30 09:39:35 legolas kernel: wvlan_cs: MAC address on eth1 is 00 02 2d 1c 85 ac 
Apr 30 09:39:35 legolas kernel: wvlan_cs: Found firmware 0x60006 (vendor 1) - Firmware capabilities : 1-1-1-1-1
Apr 30 09:39:36 legolas kernel: wvlan_cs: MAC address on eth1 is 00 02 2d 1c 85 ac 
Apr 30 09:39:36 legolas kernel: wvlan_cs: Found firmware 0x60006 (vendor 1) - Firmware capabilities : 1-1-1-1-1
Apr 30 09:41:35 legolas kernel: hub.c: USB new device connect on bus1/2, assigned device number 2
Apr 30 09:41:39 legolas kernel: usb_control/bulk_msg: timeout
Apr 30 09:41:39 legolas kernel: usb.c: USB device not accepting new address=2 (error=-110)
Apr 30 09:41:39 legolas kernel: hub.c: USB new device connect on bus1/2, assigned device number 3
Apr 30 09:41:43 legolas kernel: usb_control/bulk_msg: timeout
Apr 30 09:41:43 legolas kernel: usb.c: USB device not accepting new address=3 (error=-110)
----------------------------------------------------------------------

4. /proc/interrupts (with my patch)
----------------------------------------------------------------------
           CPU0       
  0:     456265          XT-PIC  timer
  1:       3525          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci, usb-uhci
 11:        329          XT-PIC  PCI device 1524:1410 (ENE Technology Inc), wvlan_cs
 12:         28          XT-PIC  PS/2 Mouse
 14:      29249          XT-PIC  ide0
 15:          3          XT-PIC  ide1
NMI:          0 
ERR:          0
----------------------------------------------------------------------

5. lspci -x (with my patch)
----------------------------------------------------------------------
00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133]
00: 06 11 05 06 06 00 10 22 00 00 00 06 00 00 00 00
10: 08 00 00 a0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 20 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP]
00: 06 11 05 86 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 c0 d0 30 22
20: 00 e0 f0 ef 00 90 f0 9f 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00

00:04.0 CardBus bridge: ENE Technology Inc: Unknown device 1410
00: 24 15 10 14 07 00 10 02 00 00 07 06 08 a8 02 00
10: 00 00 00 1f a0 00 00 02 00 02 05 b0 00 00 40 1f
20: 00 f0 7f 1f 00 00 80 1f 00 f0 bf 1f 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 0b 01 40 05
40: 3c 10 20 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 40 00 00
10: 01 e2 00 00 00 00 00 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 20 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 20 40

00:0e.0 FireWire (IEEE 1394): VIA Technologies, Inc. OHCI Compliant IEEE 1394 Host Controller (rev 46)
00: 06 11 44 30 87 00 10 02 46 10 00 0c 04 00 00 00
10: 00 08 00 f0 01 e3 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 44 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 00 20

00:10.0 Communication controller: ESS Technology ES2838/2839 SuperLink Modem (rev 01)
00: 5d 12 38 28 01 00 10 00 01 00 80 07 00 00 00 00
10: 81 e3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 20 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 01 00 00

00:11.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 10)
00: 06 11 31 82 8f 00 10 02 10 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 20 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 11 00 00 00 00 00 00 00 00 00 00 3c 10 20 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1e)
00: 06 11 38 30 07 00 10 02 1e 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 12 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1e)
00: 06 11 38 30 07 00 10 02 1e 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 13 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00

00:11.4 Bridge: VIA Technologies, Inc. VT8235 Power Management (rev 10)
00: 06 11 35 82 00 00 90 02 10 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 20 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 40)
00: 06 11 58 30 01 00 10 02 40 00 01 04 00 00 00 00
10: 01 e0 00 00 01 e1 00 00 05 e1 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 20 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 09 03 00 00

01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d01 (rev 02)
00: 33 53 01 8d 07 00 30 02 02 00 00 03 04 40 00 00
10: 00 00 00 e0 08 00 00 90 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 20 00
30: 00 00 0c 00 dc 00 00 00 00 00 00 00 0b 01 04 ff
----------------------------------------------------------------------

6. Windows XP Device Manager dump
----------------------------------------------------------------------
       ******************** SYSTEM SUMMARY ********************

       Windows Version: Windows 5.1 (Build 2600)
       Registered Owner:  
       Registered Organization: 
       Computer Name: LEGOLAS
       Machine Type: AT/AT COMPATIBLE
       System BIOS Version: INSYDE - 1
       System BIOS Date: 12/20/01
       Processor Type: x86 Family 6 Model 11 Stepping 1
       Processor Vendor: GenuineIntel
       Number of Processors: 1
       Physical Memory: 496 MB 

       ******************** DISK DRIVE INFO ********************

         Drive C:
           Type: Fixed disk drive 
           Total Space: 10,742,214,656 bytes
           Free Space: 6,951,845,888 bytes
           Heads: 255 
           Cylinders: 3648
           Sectors Per Track: 63
           Bytes Per Sector: 512

       ******************** IRQ SUMMARY ********************

       IRQ Usage Summary:
         (ISA)  0    System timer
         (ISA)  1    Standard 101/102-Key or Microsoft Natural PS/2 Keyboard
         (ISA)  3    VIA Fast Infrared Controller
         (ISA)  5    ORiNOCO Wireless LAN PC Card (5 volt)
         (ISA)  8    System CMOS/real time clock
         (ISA)  9    Microsoft ACPI-Compliant System
         (PCI)  9    Realtek RTL8139/810X Family PCI Fast Ethernet NIC
         (PCI)  9    VIA OHCI Compliant IEEE 1394 Host Controller
         (PCI)  9    ESS SuperLink-M Data Fax Voice Modem
         (PCI)  9    VIA Rev 5 or later USB Universal Host Controller
         (PCI)  9    VIA Rev 5 or later USB Universal Host Controller
         (PCI)  9    VIA AC'97 Audio Controller (WDM)
         (PCI) 11    ENE CB1410 CARDBUS CONTROLLER
         (ISA) 12    Synaptics PS/2 Port TouchPad
         (ISA) 13    Numeric data processor
         (ISA) 14    Primary IDE Channel
         (ISA) 15    Secondary IDE Channel

       ******************** DMA USAGE SUMMARY ********************

       DMA Usage Summary:
          0    VIA Fast Infrared Controller
          3    ECP Printer Port (LPT1)
          4    Direct memory access controller

       ******************** MEMORY SUMMARY ********************

       Memory Usage Summary:
         [000A0000 - 000BFFFF]  PCI bus
           [000A0000 - 000BFFFF]  VIA Tech CPU to AGP Controller
             [000A0000 - 000BFFFF]  S3 Graphics Twister HP
         [000D0000 - 000DFFFF]  PCI bus
           [000DF000 - 000DFFFF]  ENE CB1410 CARDBUS CONTROLLER
         [1F000000 - FEDFFFFF]  PCI bus
           [90000000 - 9FFFFFFF]  VIA Tech CPU to AGP Controller
             [90000000 - 97FFFFFF]  S3 Graphics Twister HP
           [A0000000 - A3FFFFFF]  VIA Tech CPU to AGP Controller
           [E0000000 - EFFFFFFF]  VIA Tech CPU to AGP Controller
             [E0000000 - E007FFFF]  S3 Graphics Twister HP
           [F0000000 - F00000FF]  Realtek RTL8139/810X Family PCI Fast Ethernet NIC
           [F0000800 - F0000FFF]  VIA OHCI Compliant IEEE 1394 Host Controller
           [FAE00000 - FEDFFFFF]  ENE CB1410 CARDBUS CONTROLLER
             [FEC00000 - FEC00FFF]  PCI bus
         [FFE00000 - FFF61FFF]  PCI bus
           [FFEFE000 - FFEFEFFF]  ENE CB1410 CARDBUS CONTROLLER
           [FFEFF000 - FFEFFFFF]  ENE CB1410 CARDBUS CONTROLLER
         [FFF74000 - FFF77FFF]  PCI bus
         [FFF7C000 - FFF7FFFF]  PCI bus
         [FFF80000 - FFFFFFFF]  System board
           [FFFC0000 - FFFFFFFF]  PCI bus

       ******************** IO PORT SUMMARY ********************

       I/O Ports Usage Summary:
         [00000000 - 00000CF7]  PCI bus
           [00000000 - 0000000F]  Direct memory access controller
           [00000020 - 00000021]  Programmable interrupt controller
           [00000040 - 00000043]  System timer
           [00000048 - 0000004B]  System timer
           [00000060 - 00000060]  Standard 101/102-Key or Microsoft Natural PS/2 Keyb
           [00000061 - 00000061]  System speaker
           [00000062 - 00000062]  Microsoft ACPI-Compliant Embedded Controller
           [00000064 - 00000064]  Standard 101/102-Key or Microsoft Natural PS/2 Keyb
           [00000066 - 00000066]  Microsoft ACPI-Compliant Embedded Controller
           [00000070 - 00000073]  System CMOS/real time clock
           [00000080 - 00000090]  Direct memory access controller
           [00000092 - 00000092]  Motherboard resources
           [00000094 - 0000009F]  Direct memory access controller
           [000000A0 - 000000A1]  Programmable interrupt controller
           [000000C0 - 000000DF]  Direct memory access controller
           [000000F0 - 000000FF]  Numeric data processor
           [00000170 - 00000177]  Secondary IDE Channel
           [000001F0 - 000001F7]  Primary IDE Channel
           [00000274 - 00000277]  ISAPNP Read Data Port
           [00000279 - 00000279]  ISAPNP Read Data Port
           [00000376 - 00000376]  Secondary IDE Channel
           [00000378 - 0000037F]  ECP Printer Port (LPT1)
           [000003B0 - 000003BB]  VIA Tech CPU to AGP Controller
             [000003B0 - 000003BB]  S3 Graphics Twister HP
           [000003C0 - 000003DF]  VIA Tech CPU to AGP Controller
             [000003C0 - 000003DF]  S3 Graphics Twister HP
           [000003F0 - 000003F1]  Motherboard resources
           [000003F6 - 000003F6]  Primary IDE Channel
           [000004D0 - 000004D1]  Motherboard resources
           [00000778 - 0000077B]  ECP Printer Port (LPT1)
           [00000A79 - 00000A79]  ISAPNP Read Data Port
         [00000D00 - 0000FFFF]  PCI bus
           [00001000 - 0000107F]  Motherboard resources
           [00001100 - 0000110F]  VIA Bus Master IDE Controller
           [00001200 - 0000121F]  VIA Rev 5 or later USB Universal Host Controller
           [00001300 - 0000131F]  VIA Rev 5 or later USB Universal Host Controller
           [00001400 - 0000147F]  Motherboard resources
           [00001600 - 0000167F]  Motherboard resources
           [00002200 - 0000227F]  VIA Fast Infrared Controller
           [0000C000 - 0000DFFF]  VIA Tech CPU to AGP Controller
           [0000E000 - 0000E0FF]  VIA AC'97 Audio Controller (WDM)
           [0000E100 - 0000E103]  VIA AC'97 Audio Controller (WDM)
           [0000E104 - 0000E107]  VIA AC'97 Audio Controller (WDM)
           [0000E200 - 0000E2FF]  Realtek RTL8139/810X Family PCI Fast Ethernet NIC
           [0000E300 - 0000E37F]  VIA OHCI Compliant IEEE 1394 Host Controller
           [0000E380 - 0000E38F]  ESS SuperLink-M Data Fax Voice Modem
           [0000FD00 - 0000FDFF]  ENE CB1410 CARDBUS CONTROLLER
           [0000FE00 - 0000FEFF]  ENE CB1410 CARDBUS CONTROLLER
           [0000FF40 - 0000FF7F]  ORiNOCO Wireless LAN PC Card (5 volt)
----------------------------------------------------------------------

