Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTH3BnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 21:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTH3BnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 21:43:20 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8976
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261373AbTH3BnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 21:43:11 -0400
Date: Fri, 29 Aug 2003 18:43:09 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: OOps in 2.6.0-test4-mm3-1
Message-ID: <20030830014309.GA898@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030828235649.61074690.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20030828235649.61074690.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It's vanilla mm3-1 with this one patch added from Neil Brown.  I don't think
it has anything to do with it (it looks like a driver issue to me).  But it
can't hurt to mention it.

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2003-08-24 08:07:18.000000000 +1000
+++ ./drivers/md/md.c	2003-08-26 09:11:39.000000000 +1000
@@ -638,14 +638,13 @@ static void super_90_sync(mddev_t *mddev
 	/* make rdev->sb match mddev data..
 	 *
 	 * 1/ zero out disks
-	 * 2/ Add info for each disk, keeping track of highest desc_nr
-	 * 3/ any empty disks < highest become removed
+	 * 2/ Add info for each disk, keeping track of highest desc_nr (next_spare);
+	 * 3/ any empty disks < next_spare become removed
 	 *
 	 * disks[0] gets initialised to REMOVED because
 	 * we cannot be sure from other fields if it has
 	 * been initialised or not.
 	 */
-	int highest = 0;
 	int i;
 	int active=0, working=0,failed=0,spare=0,nr_disks=0;
 
@@ -716,17 +715,17 @@ static void super_90_sync(mddev_t *mddev
 			spare++;
 			working++;
 		}
-		if (rdev2->desc_nr > highest)
-			highest = rdev2->desc_nr;
 	}
 	
-	/* now set the "removed" bit on any non-trailing holes */
-	for (i=0; i<highest; i++) {
+	/* now set the "removed" and "faulty" bits on any missing devices */
+	for (i=0 ; i < mddev->raid_disks ; i++) {
 		mdp_disk_t *d = &sb->disks[i];
 		if (d->state == 0 && d->number == 0) {
 			d->number = i;
 			d->raid_disk = i;
 			d->state = (1<<MD_DISK_REMOVED);
+			d->state |= (1<<MD_DISK_FAULTY);
+			failed++;
 		}
 	}
 	sb->nr_disks = nr_disks;




Configuring Adaptec (SCSI-ID 7) at IO:230, IRQ 9, DMA priority 5
Unable to handle kernel NULL pointer dereference at virtual address 00000038
 printing eip:
c01ecf9a
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
CPU:    0
EIP:    0060:[kobject_put+6/28]    Not tainted VLI
EFLAGS: 00010206
EIP is at kobject_put+0x6/0x1c
eax: 00000024   ebx: c0459578   ecx: 00000000   edx: 00000024
esi: c9b89ed8   edi: c9b89eec   ebp: c9b89e90   esp: c9b89e90
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 73, threadinfo=c9b88000 task=c12bf2f0)
Stack: c9b89e9c c023d2eb 00000024 c9b89eec c026dccb 00000000 c04594c0 ca944dc0 
       c03e3600 c04594c0 ca902da8 00000000 c04594c0 00000000 00000001 dead4ead 
       c9b89ee4 c9b89ee4 00000000 00000001 dead4ead c9b89ee4 c9b89ee4 c9b89ef8 
Call Trace:
 [put_device+15/20] put_device+0xf/0x14
 [scsi_host_dev_release+139/160] scsi_host_dev_release+0x8b/0xa0
 [device_release+22/80] device_release+0x16/0x50
 [kobject_cleanup+40/64] kobject_cleanup+0x28/0x40
 [kobject_put+23/28] kobject_put+0x17/0x1c
 [put_device+15/20] put_device+0xf/0x14
 [scsi_host_put+17/24] scsi_host_put+0x11/0x18
 [scsi_unregister+81/88] scsi_unregister+0x51/0x58
 [_end+172423342/1068932160] aha1542_detect+0x5e6/0x608 [aha1542]
 [_end+172423451/1068932160] init_this_scsi_driver+0x4b/0x116 [aha1542]
 [sys_init_module+405/728] sys_init_module+0x195/0x2d8
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 85 c0 74 0d 8b 00 85 c0 74 07 52 ff d0 83 c4 04 90 85 db 74 09 8d 43 10 50 e8 07 00 00 00 8b 5d fc 89 ec 5d c3 55 89 e5 8b 55 08 <f0> ff 4a 14 0f 94 c0 84 c0 74 06 52 e8 a9 ff ff ff 89 ec 5d c3 

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aha1542-oops-2.6.0-test4-mm3-1-mdfail.dmesg"

Aug 29 14:29:55 srv-copyroom kernel: Linux version 2.6.0-test4-mm3-1-mdfail (root@srv-lr2600) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Fri Aug 29 13:33:26 PDT 2003
Aug 29 14:29:55 srv-copyroom kernel: Video mode to be used for restore is f01
Aug 29 14:29:55 srv-copyroom kernel: BIOS-provided physical RAM map:
Aug 29 14:29:55 srv-copyroom kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 29 14:29:55 srv-copyroom kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 29 14:29:55 srv-copyroom kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 29 14:29:55 srv-copyroom kernel:  BIOS-e820: 0000000000100000 - 000000000a000000 (usable)
Aug 29 14:29:55 srv-copyroom kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 29 14:29:55 srv-copyroom kernel: 0MB HIGHMEM available.
Aug 29 14:29:55 srv-copyroom kernel: 160MB LOWMEM available.
Aug 29 14:29:55 srv-copyroom kernel: On node 0 totalpages: 40960
Aug 29 14:29:55 srv-copyroom kernel:   DMA zone: 4096 pages, LIFO batch:1
Aug 29 14:29:55 srv-copyroom kernel:   Normal zone: 36864 pages, LIFO batch:9
Aug 29 14:29:55 srv-copyroom kernel:   HighMem zone: 0 pages, LIFO batch:1
Aug 29 14:29:55 srv-copyroom kernel: DMI 2.0 present.
Aug 29 14:29:55 srv-copyroom kernel: ACPI disabled because your bios is from 97 and too old
Aug 29 14:29:55 srv-copyroom kernel: You can enable it with acpi=force
Aug 29 14:29:55 srv-copyroom kernel: ACPI: Unable to locate RSDP
Aug 29 14:29:55 srv-copyroom kernel: Building zonelist for node : 0
Aug 29 14:29:55 srv-copyroom kernel: Kernel command line: root=/dev/hda1 ro vga=extended hdc=ide-scsi nmi_watchdog=2
Aug 29 14:29:55 srv-copyroom kernel: ide_setup: hdc=ide-scsi
Aug 29 14:29:55 srv-copyroom kernel: Local APIC disabled by BIOS -- reenabling.
Aug 29 14:29:55 srv-copyroom kernel: Found and enabled local APIC!
Aug 29 14:29:55 srv-copyroom kernel: current: c03a9b40
Aug 29 14:29:55 srv-copyroom kernel: current->thread_info: c0430000
Aug 29 14:29:55 srv-copyroom kernel: Initializing CPU#0
Aug 29 14:29:55 srv-copyroom kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Aug 29 14:29:55 srv-copyroom kernel: Detected 300.692 MHz processor.
Aug 29 14:29:55 srv-copyroom kernel: Console: colour VGA+ 80x50
Aug 29 14:29:55 srv-copyroom kernel: Calibrating delay loop... 591.87 BogoMIPS
Aug 29 14:29:55 srv-copyroom kernel: Memory: 157792k/163840k available (2180k kernel code, 5420k reserved, 1082k data, 188k init, 0k highmem)
Aug 29 14:29:55 srv-copyroom kernel: Security Scaffold v1.0.0 initialized
Aug 29 14:29:55 srv-copyroom kernel: Capability LSM initialized
Aug 29 14:29:55 srv-copyroom kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Aug 29 14:29:55 srv-copyroom kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Aug 29 14:29:55 srv-copyroom kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 29 14:29:55 srv-copyroom kernel: -> /dev
Aug 29 14:29:55 srv-copyroom kernel: -> /dev/console
Aug 29 14:29:55 srv-copyroom kernel: -> /root
Aug 29 14:29:55 srv-copyroom kernel: CPU:     After generic identify, caps: 0080fbff 00000000 00000000 00000000
Aug 29 14:29:55 srv-copyroom kernel: CPU:     After vendor identify, caps: 0080fbff 00000000 00000000 00000000
Aug 29 14:29:55 srv-copyroom kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 29 14:29:55 srv-copyroom kernel: CPU: L2 cache: 512K
Aug 29 14:29:55 srv-copyroom kernel: CPU:     After all inits, caps: 0080fbff 00000000 00000000 00000040
Aug 29 14:29:55 srv-copyroom kernel: Intel machine check architecture supported.
Aug 29 14:29:55 srv-copyroom kernel: Intel machine check reporting enabled on CPU#0.
Aug 29 14:29:55 srv-copyroom kernel: Checking 'hlt' instruction... OK.
Aug 29 14:29:55 srv-copyroom kernel: POSIX conformance testing by UNIFIX
Aug 29 14:29:55 srv-copyroom kernel: CPU0: Intel Pentium II (Klamath) stepping 03
Aug 29 14:29:55 srv-copyroom kernel: per-CPU timeslice cutoff: 1463.01 usecs.
Aug 29 14:29:55 srv-copyroom kernel: task migration cache decay timeout: 2 msecs.
Aug 29 14:29:55 srv-copyroom kernel: SMP motherboard not detected.
Aug 29 14:29:55 srv-copyroom kernel: enabled ExtINT on CPU#0
Aug 29 14:29:55 srv-copyroom kernel: ESR value before enabling vector: 00000000
Aug 29 14:29:55 srv-copyroom kernel: ESR value after enabling vector: 00000000
Aug 29 14:29:55 srv-copyroom kernel: testing NMI watchdog ... OK.
Aug 29 14:29:55 srv-copyroom kernel: Using local APIC timer interrupts.
Aug 29 14:29:55 srv-copyroom kernel: calibrating APIC timer ...
Aug 29 14:29:55 srv-copyroom kernel: ..... CPU clock speed is 300.0632 MHz.
Aug 29 14:29:55 srv-copyroom kernel: ..... host bus clock speed is 66.0807 MHz.
Aug 29 14:29:55 srv-copyroom kernel: Starting migration thread for cpu 0
Aug 29 14:29:55 srv-copyroom kernel: CPUS done 2
Aug 29 14:29:55 srv-copyroom kernel: zapping low mappings.
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for No Bus:legacy
Aug 29 14:29:55 srv-copyroom kernel: Initializing RT netlink socket
Aug 29 14:29:55 srv-copyroom kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb0a0, last bus=0
Aug 29 14:29:55 srv-copyroom kernel: PCI: Using configuration type 1
Aug 29 14:29:55 srv-copyroom kernel: mtrr: v2.0 (20020519)
Aug 29 14:29:55 srv-copyroom kernel: ACPI: Subsystem revision 20030813
Aug 29 14:29:55 srv-copyroom kernel: ACPI: Interpreter disabled.
Aug 29 14:29:55 srv-copyroom kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 29 14:29:55 srv-copyroom kernel: PnPBIOS: Scanning system for PnP BIOS support...
Aug 29 14:29:55 srv-copyroom kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd70
Aug 29 14:29:55 srv-copyroom kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbd98, dseg 0xf0000
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for No Bus:pnp0
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:00
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:01
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:02
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:03
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:04
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:05
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:06
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:07
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:08
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:09
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:0a
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:0b
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:0c
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pnp:00:0d
Aug 29 14:29:55 srv-copyroom kernel: PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
Aug 29 14:29:55 srv-copyroom kernel: SCSI subsystem initialized
Aug 29 14:29:55 srv-copyroom kernel: ACPI: ACPI tables contain no PCI IRQ routing entries
Aug 29 14:29:55 srv-copyroom kernel: PCI: Invalid ACPI-PCI IRQ routing table
Aug 29 14:29:55 srv-copyroom kernel: PCI: Probing PCI hardware
Aug 29 14:29:55 srv-copyroom kernel: PCI: Probing PCI hardware (bus 00)
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for No Bus:pci0000:00
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pci:0000:00:00.0
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pci:0000:00:07.0
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pci:0000:00:07.1
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pci:0000:00:07.2
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pci:0000:00:08.0
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pci:0000:00:0a.0
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pci:0000:00:0a.1
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pci:0000:00:0a.2
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for pci:0000:00:0c.0
Aug 29 14:29:55 srv-copyroom kernel: pty: 256 Unix98 ptys configured
Aug 29 14:29:55 srv-copyroom kernel: Machine check exception polling timer started.
Aug 29 14:29:55 srv-copyroom kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Aug 29 14:29:55 srv-copyroom kernel: VFS: Disk quotas dquot_6.5.1
Aug 29 14:29:55 srv-copyroom kernel: Initializing Cryptographic API
Aug 29 14:29:55 srv-copyroom kernel: Limiting direct PCI/PCI transfers.
Aug 29 14:29:55 srv-copyroom kernel: Activating ISA DMA hang workarounds.
Aug 29 14:29:55 srv-copyroom kernel:         -0420: *** Error: Could not allocate an object descriptor
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for No Bus:pnp1
Aug 29 14:29:55 srv-copyroom kernel: isapnp: Scanning for PnP cards...
Aug 29 14:29:55 srv-copyroom kernel: isapnp: No Plug & Play device found
Aug 29 14:29:55 srv-copyroom kernel: Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Aug 29 14:29:55 srv-copyroom kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
Aug 29 14:29:55 srv-copyroom kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 29 14:29:55 srv-copyroom kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug 29 14:29:55 srv-copyroom kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 29 14:29:55 srv-copyroom kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 29 14:29:55 srv-copyroom kernel: PIIX3: IDE controller at PCI slot 0000:00:07.1
Aug 29 14:29:55 srv-copyroom kernel: PIIX3: chipset revision 0
Aug 29 14:29:55 srv-copyroom kernel: PIIX3: not 100%% native mode: will probe irqs later
Aug 29 14:29:55 srv-copyroom kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
Aug 29 14:29:55 srv-copyroom kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Aug 29 14:29:55 srv-copyroom kernel: hda: WDC AC34300L, ATA DISK drive
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for No Bus:ide0
Aug 29 14:29:55 srv-copyroom kernel: Using anticipatory scheduling elevator
Aug 29 14:29:55 srv-copyroom kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for ide:0.0
Aug 29 14:29:55 srv-copyroom kernel: hdc: _NEC CD-RW NR-7900A, ATAPI CD/DVD-ROM drive
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for No Bus:ide1
Aug 29 14:29:55 srv-copyroom kernel: hdd: WDC WD1200JB-00CRA1, ATA DISK drive
Aug 29 14:29:55 srv-copyroom kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for ide:1.0
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for ide:1.1
Aug 29 14:29:55 srv-copyroom kernel: hda: max request size: 128KiB
Aug 29 14:29:55 srv-copyroom kernel: hda: 8406720 sectors (4304 MB) w/256KiB Cache, CHS=8896/15/63, (U)DMA
Aug 29 14:29:55 srv-copyroom kernel:  hda: hda1 hda2
Aug 29 14:29:55 srv-copyroom kernel: hdd: max request size: 128KiB
Aug 29 14:29:55 srv-copyroom kernel: hdd: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, (U)DMA
Aug 29 14:29:55 srv-copyroom kernel:  hdd: hdd1
Aug 29 14:29:55 srv-copyroom kernel: mice: PS/2 mouse device common for all mice
Aug 29 14:29:55 srv-copyroom kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 29 14:29:55 srv-copyroom kernel: input: AT Set 2 keyboard on isa0060/serio0
Aug 29 14:29:55 srv-copyroom kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 29 14:29:55 srv-copyroom kernel: md: linear personality registered as nr 1
Aug 29 14:29:55 srv-copyroom kernel: md: raid0 personality registered as nr 2
Aug 29 14:29:55 srv-copyroom kernel: md: raid1 personality registered as nr 3
Aug 29 14:29:55 srv-copyroom kernel: md: raid5 personality registered as nr 4
Aug 29 14:29:55 srv-copyroom kernel: raid5: measuring checksumming speed
Aug 29 14:29:55 srv-copyroom kernel:    8regs     :   512.000 MB/sec
Aug 29 14:29:55 srv-copyroom kernel:    8regs_prefetch:   444.000 MB/sec
Aug 29 14:29:55 srv-copyroom kernel:    32regs    :   348.000 MB/sec
Aug 29 14:29:55 srv-copyroom kernel:    32regs_prefetch:   288.000 MB/sec
Aug 29 14:29:55 srv-copyroom kernel:    pII_mmx   :   744.000 MB/sec
Aug 29 14:29:55 srv-copyroom kernel:    p5_mmx    :   768.000 MB/sec
Aug 29 14:29:55 srv-copyroom kernel: raid5: using function: p5_mmx (768.000 MB/sec)
Aug 29 14:29:55 srv-copyroom kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug 29 14:29:55 srv-copyroom kernel: device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
Aug 29 14:29:55 srv-copyroom kernel: NET4: Frame Diverter 0.46
Aug 29 14:29:55 srv-copyroom kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 29 14:29:55 srv-copyroom kernel: IP: routing cache hash table of 512 buckets, 8Kbytes
Aug 29 14:29:55 srv-copyroom kernel: TCP: Hash tables configured (established 8192 bind 10922)
Aug 29 14:29:55 srv-copyroom kernel: BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
Aug 29 14:29:55 srv-copyroom kernel: md: Autodetecting RAID arrays.
Aug 29 14:29:55 srv-copyroom kernel: md: autorun ...
Aug 29 14:29:55 srv-copyroom kernel: md: ... autorun DONE.
Aug 29 14:29:55 srv-copyroom kernel: found reiserfs format "3.6" with standard journal
Aug 29 14:29:55 srv-copyroom kernel: Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Aug 29 14:29:55 srv-copyroom kernel: reiserfs: checking transaction log (hda1) for (hda1)
Aug 29 14:29:55 srv-copyroom kernel: Using r5 hash to sort names
Aug 29 14:29:55 srv-copyroom kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Aug 29 14:29:55 srv-copyroom kernel: Freeing unused kernel memory: 188k freed
Aug 29 14:29:55 srv-copyroom kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Aug 29 14:29:55 srv-copyroom kernel: Adding 297192k swap on /dev/hda2.  Priority:-1 extents:1
Aug 29 14:29:55 srv-copyroom kernel: Real Time Clock Driver v1.11a
Aug 29 14:29:55 srv-copyroom kernel: drivers/usb/core/usb.c: registered new driver usbfs
Aug 29 14:29:55 srv-copyroom kernel: drivers/usb/core/usb.c: registered new driver hub
Aug 29 14:29:55 srv-copyroom kernel: drivers/usb/core/usb.c: registered new driver usbscanner
Aug 29 14:29:55 srv-copyroom kernel: drivers/usb/image/scanner.c: 0.4.14:USB Scanner Driver
Aug 29 14:29:55 srv-copyroom kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Aug 29 14:29:55 srv-copyroom kernel: uhci-hcd 0000:00:07.2: UHCI Host Controller
Aug 29 14:29:55 srv-copyroom kernel: uhci-hcd 0000:00:07.2: irq 11, io base 00009000
Aug 29 14:29:55 srv-copyroom kernel: uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for usb:usb1
Aug 29 14:29:55 srv-copyroom kernel: hub 1-0:0: USB hub found
Aug 29 14:29:55 srv-copyroom kernel: hub 1-0:0: 2 ports detected
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for usb:1-0:0
Aug 29 14:29:55 srv-copyroom kernel: uhci-hcd 0000:00:0a.0: UHCI Host Controller
Aug 29 14:29:55 srv-copyroom kernel: uhci-hcd 0000:00:0a.0: irq 5, io base 00009100
Aug 29 14:29:55 srv-copyroom kernel: uhci-hcd 0000:00:0a.0: new USB bus registered, assigned bus number 2
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for usb:usb2
Aug 29 14:29:55 srv-copyroom kernel: hub 2-0:0: USB hub found
Aug 29 14:29:55 srv-copyroom kernel: hub 2-0:0: 2 ports detected
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for usb:2-0:0
Aug 29 14:29:55 srv-copyroom kernel: uhci-hcd 0000:00:0a.1: UHCI Host Controller
Aug 29 14:29:55 srv-copyroom kernel: uhci-hcd 0000:00:0a.1: irq 11, io base 00009200
Aug 29 14:29:55 srv-copyroom kernel: uhci-hcd 0000:00:0a.1: new USB bus registered, assigned bus number 3
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for usb:usb3
Aug 29 14:29:55 srv-copyroom kernel: hub 3-0:0: USB hub found
Aug 29 14:29:55 srv-copyroom kernel: hub 3-0:0: 2 ports detected
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for usb:3-0:0
Aug 29 14:29:55 srv-copyroom kernel: PCI: Enabling device 0000:00:0c.0 (0000 -> 0003)
Aug 29 14:29:55 srv-copyroom kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Aug 29 14:29:55 srv-copyroom kernel: 0000:00:0c.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x9300. Vers LK1.1.19
Aug 29 14:29:55 srv-copyroom kernel: PCI: Setting latency timer of device 0000:00:0c.0 to 64
Aug 29 14:29:55 srv-copyroom kernel:   ***WARNING*** No MII transceivers found!
Aug 29 14:29:55 srv-copyroom kernel: divert: allocating divert_blk for eth0
Aug 29 14:29:55 srv-copyroom kernel: hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
Aug 29 14:29:55 srv-copyroom kernel: Configuring Adaptec (SCSI-ID 7) at IO:230, IRQ 9, DMA priority 5
Aug 29 14:29:55 srv-copyroom kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000038
Aug 29 14:29:55 srv-copyroom kernel:  printing eip:
Aug 29 14:29:55 srv-copyroom kernel: c01ecf9a
Aug 29 14:29:55 srv-copyroom kernel: *pde = 00000000
Aug 29 14:29:55 srv-copyroom kernel: Oops: 0002 [#1]
Aug 29 14:29:55 srv-copyroom kernel: PREEMPT SMP 
Aug 29 14:29:55 srv-copyroom kernel: CPU:    0
Aug 29 14:29:55 srv-copyroom kernel: EIP:    0060:[kobject_put+6/28]    Not tainted VLI
Aug 29 14:29:55 srv-copyroom kernel: EFLAGS: 00010206
Aug 29 14:29:55 srv-copyroom kernel: EIP is at kobject_put+0x6/0x1c
Aug 29 14:29:55 srv-copyroom kernel: eax: 00000024   ebx: c0459578   ecx: 00000000   edx: 00000024
Aug 29 14:29:55 srv-copyroom kernel: esi: c9b89ed8   edi: c9b89eec   ebp: c9b89e90   esp: c9b89e90
Aug 29 14:29:55 srv-copyroom kernel: ds: 007b   es: 007b   ss: 0068
Aug 29 14:29:55 srv-copyroom kernel: Process modprobe (pid: 73, threadinfo=c9b88000 task=c12bf2f0)
Aug 29 14:29:55 srv-copyroom kernel: Stack: c9b89e9c c023d2eb 00000024 c9b89eec c026dccb 00000000 c04594c0 ca944dc0 
Aug 29 14:29:55 srv-copyroom kernel:        c03e3600 c04594c0 ca902da8 00000000 c04594c0 00000000 00000001 dead4ead 
Aug 29 14:29:55 srv-copyroom kernel:        c9b89ee4 c9b89ee4 00000000 00000001 dead4ead c9b89ee4 c9b89ee4 c9b89ef8 
Aug 29 14:29:55 srv-copyroom kernel: Call Trace:
Aug 29 14:29:55 srv-copyroom kernel:  [put_device+15/20] put_device+0xf/0x14
Aug 29 14:29:55 srv-copyroom kernel:  [scsi_host_dev_release+139/160] scsi_host_dev_release+0x8b/0xa0
Aug 29 14:29:55 srv-copyroom kernel:  [device_release+22/80] device_release+0x16/0x50
Aug 29 14:29:55 srv-copyroom kernel:  [kobject_cleanup+40/64] kobject_cleanup+0x28/0x40
Aug 29 14:29:55 srv-copyroom kernel:  [kobject_put+23/28] kobject_put+0x17/0x1c
Aug 29 14:29:55 srv-copyroom kernel:  [put_device+15/20] put_device+0xf/0x14
Aug 29 14:29:55 srv-copyroom kernel:  [scsi_host_put+17/24] scsi_host_put+0x11/0x18
Aug 29 14:29:55 srv-copyroom kernel:  [scsi_unregister+81/88] scsi_unregister+0x51/0x58
Aug 29 14:29:55 srv-copyroom kernel:  [_end+172423342/1068932160] aha1542_detect+0x5e6/0x608 [aha1542]
Aug 29 14:29:55 srv-copyroom kernel:  [_end+172423451/1068932160] init_this_scsi_driver+0x4b/0x116 [aha1542]
Aug 29 14:29:55 srv-copyroom kernel:  [sys_init_module+405/728] sys_init_module+0x195/0x2d8
Aug 29 14:29:55 srv-copyroom kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 29 14:29:55 srv-copyroom kernel: 
Aug 29 14:29:55 srv-copyroom kernel: Code: 85 c0 74 0d 8b 00 85 c0 74 07 52 ff d0 83 c4 04 90 85 db 74 09 8d 43 10 50 e8 07 00 00 00 8b 5d fc 89 ec 5d c3 55 89 e5 8b 55 08 <f0> ff 4a 14 0f 94 c0 84 c0 74 06 52 e8 a9 ff ff ff 89 ec 5d c3 
Aug 29 14:29:55 srv-copyroom kernel:  <6>hub 2-0:0: new USB device on port 1, assigned address 2
Aug 29 14:29:55 srv-copyroom kernel: PM: Adding info for usb:2-1
Aug 29 14:29:55 srv-copyroom kernel: drivers/usb/image/scanner.c: USB scanner device (0x1606/0x0060) now attached to usb/scanner0

--9jxsPFA5p3P2qPhR--
