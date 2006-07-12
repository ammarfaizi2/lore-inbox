Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWGLTI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWGLTI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWGLTI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:08:57 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:22240 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1750811AbWGLTI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:08:56 -0400
Date: Wed, 12 Jul 2006 21:08:50 +0200
From: Arne Ahrend <aahrend@web.de>
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc1-mm1 NULL pointer dereference
Message-Id: <20060712210850.74f34327.aahrend@web.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-rc1-mm1 dereferences a NULL pointer while setting up the DVB-T card and mentions sysfs.

Normally (2.6.17) it would go on loading bt878, dvb_core and a couple of frontents:
mt352 (the one I need), nxt6000, dvb_pll, sp887x, dst_ca, dst, cx24110, or51211, lgdt330x.

I applied this patch to get it to compile on the Athlon64:

--- 2.6.18-rc1-mm1-64.orig/arch/x86_64/kernel/vsyscall.c
+++ 2.6.18-rc1-mm1-64/arch/x86_64/kernel/vsyscall.c
@@ -253,13 +253,14 @@ void __cpuinit vsyscall_set_cpu(int cpu)
 #ifdef CONFIG_NUMA
 	node = cpu_to_node[cpu];
 #endif
+#ifdef CONFIG_SMP
 	if (cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP)) {
 		/* the notifier is unfortunately not executed on the
 		   target CPU */
 		void *info = (void *)((node << 12) | cpu);
 		smp_call_function_single(cpu, write_rdtscp_cb, info, 0, 1);
 	}
-
+#endif
 	/* Store cpu number in limit so that it can be loaded quickly
 	   in user space in vgetcpu.
 	   12 bits for the CPU and 8 bits for the node. */

from 

http://marc.theaimsgroup.com/?l=linux-kernel&m=115249660716416&w=4

and this to make Debians make-kpkg happy:

--- linux-2.6.18-rc1-mm1-orig/Makefile	2006-07-12 21:05:36.000000000 +0200
+++ linux-2.6.18-rc1-mm1/Makefile	2006-07-10 23:44:55.000000000 +0200
@@ -859,6 +859,7 @@
 # needs to be updated, so this check is forced on all builds
 
 uts_len := 64
+
 define filechk_utsrelease.h
 	if [ `echo -n "$(KERNELRELEASE)" | wc -c ` -gt $(uts_len) ]; then \
 	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2;    \
@@ -867,10 +868,21 @@
 	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\";)
 endef
 
+# define filechk_version.h
+# 	(echo \#define LINUX_VERSION_CODE $(shell                             \
+# 	expr $(VERSION) \* 65536 + $(PATCHLEVEL) \* 256 + $(SUBLEVEL));     \
+# 	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';)
+# endef
+
 define filechk_version.h
-	(echo \#define LINUX_VERSION_CODE $(shell                             \
-	expr $(VERSION) \* 65536 + $(PATCHLEVEL) \* 256 + $(SUBLEVEL));     \
-	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';)
+	if [ `echo -n "$(KERNELRELEASE)" | wc -c ` -gt $(uts_len) ]; then \
+	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2; \
+	  exit 1; \
+	fi; \
+	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\"; \
+	  echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)`; \
+	 echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'; \
+	)
 endef
 
 include/linux/version.h: $(srctree)/Makefile FORCE

--
Cheers,
	Arne



Bootdata ok (command line is root=/dev/sda1 ro console=ttyS1,9600e7r)
Linux version 2.6.18-rc1-mm1 (root@phoenix) (gcc version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)) #1 PREEMPT Tue Jul 11 19:10:54 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bf780000)
Built 1 zonelists.  Total pages: 256991
Kernel command line: root=/dev/sda1 ro console=ttyS1,9600e7r
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1802.318 MHz processor.
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 1120 kB
 per task-struct memory footprint: 1680 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
CPU 0: aperture @ d0000000 size 256 MB
Memory: 1025976k/1048256k available (1867k kernel code, 21584k reserved, 955k data, 192k init)
Calibrating delay using timer specific routine.. 3607.87 BogoMIPS (lpj=1803936)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 02
ACPI: Core revision 20060623
Using local APIC timer interrupts.
result 12516106
Detected 12.516 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: enabled onboard AC97/MC97 devices
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14<7>Losing some ticks... checking if CPU frequency changed.
 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: fbd00000-fbffffff
  PREFETCH window: e8000000-faffffff
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 32768 (order: 9, 2359296 bytes)
TCP bind hash table entries: 16384 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 32768 bind 16384)
TCP reno registered
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.25 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type CRT found
radeonfb: EDID probed
Console: switching to colour frame buffer device 240x75
radeonfb (0000:01:00.0): ATI Radeon Ya 
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
PCI: VIA IRQ fixup for 0000:00:0f.0, from 10 to 4
sata_via 0000:00:0f.0: routed to hard irq line 4
ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB000 irq 20
ata2: SATA max UDMA/133 cmd 0xB800 ctl 0xB402 bmdma 0xB008 irq 20
scsi0 : sata_via
ata1: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xC407
scsi1 : sata_via
ata2: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xB807
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 4
ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
scsi2 : pata_via
ata3.00: ATA-7, max UDMA/100, 312581808 sectors: LBA48 
ata3.00: ata3: dev 0 multi count 16
ata3.01: ATAPI, max UDMA/33
ata3.00: configured for UDMA/100
ata3.01: configured for UDMA/33
  Vendor: ATA       Model: SAMSUNG SP1614N   Rev: TM10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: X004
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
scsi3 : pata_via
ata4.00: ATAPI, max UDMA/33
ata4.01: ATAPI, max UDMA/33
ata4.00: configured for UDMA/33
ata4.01: configured for UDMA/33
  Vendor: PLEXTOR   Model: CD-R   PX-W4012A  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4163B  Rev: A103
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
sd 2:0:0:0: Attached scsi disk sda
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
EDAC MC: Ver: 2.0.1 Jul 11 2006
TCP bic registered
NET: Registered protocol family 1
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 192k freed
  argc == 4
input: AT Translated Set 2 keyboard as /class/input/input0
  argv[0]: "/init"
  argv[1]: "root=/dev/sda1"
  argv[2]: "ro"
  argv[3]: "console=ttyS1,9600e7r"
Running ipconfig
kinit: do_mounts
kinit: try_name sda,1 = sda1(8,1)
kinit: name_to_dev_t(/dev/sda1) = sda1(8,1)
kinit: root_dev = sda1(8,1)
kinit: /dev/root appears to be a ext2 filesystem
kinit: trying to mount /dev/root on /root with type ext2
kinit: Mounted root (ext2 filesystem) readonly.
Checking for init: /sbin/init
INIT: version 2.86 booting
Starting the hotplug events dispatcher: udevdudevd[359]: udev_rules_init: could not read '/etc/udev/rules.d/025_libsane.rules': No such file or directory
.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...input: PC Speaker as /class/input/input1
EDAC MC0: Giving out device to k8_edac Athlon64/Opteron: DEV 0000:00:18.2
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse as /class/input/input2
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: VIA IRQ fixup for 0000:00:07.0, from 11 to 0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[fb700000-fb7007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 21, io mem 0xfbc00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-rc1-mm1 ehci_hcd
usb usb1: SerialNumber: 0000:00:10.4
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
8139too Fast Ethernet driver 0.9.27
Linux video capture interface: v2.00
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 18
eth0: RealTek RTL8139 at 0xffffc20000032000, 00:30:84:0a:47:6f, IRQ 18
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
sk98lin: Asus mainboard with buggy VPD? Correcting data.
eth1: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 5
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000c800
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-rc1-mm1 uhci_hcd
usb usb2: SerialNumber: 0000:00:10.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
PCI: VIA IRQ fixup for 0000:00:10.1, from 11 to 5
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000d000
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.18-rc1-mm1 uhci_hcd
usb usb3: SerialNumber: 0000:00:10.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
PCI: VIA IRQ fixup for 0000:00:10.2, from 10 to 5
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000d400
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.18-rc1-mm1 uhci_hcd
usb usb4: SerialNumber: 0000:00:10.2
usb usb4: configuration #1 chosen from 1 choice
usb 3-2: new full speed USB device using uhci_hcd and address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
sr2: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
PCI: VIA IRQ fixup for 0000:00:10.3, from 10 to 5
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 21, io base 0x0000d800
usb usb5: new device found, idVendor=0000, idProduct=0000
usb 3-2: new device found, idVendor=04f9, idProduct=0002
usb 3-2: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 3-2: configuration #1 chosen from 1 choice
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.18-rc1-mm1 uhci_hcd
usb usb5: SerialNumber: 0000:00:10.3
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 16, latency: 64, mmio: 0xe7e00000
bttv0: detected: AVermedia AverTV DVB-T 771 [card=123], PCI subsystem ID is 1461:0771
bttv0: using: AVerMedia AVerTV DVB-T 771 [card=123,autodetected]
bttv0: using tuner=4
bttv0: registered device video0
Unable to handle kernel NULL pointer dereference at 00000000000000d9 RIP: 
 [<ffffffff801cb377>] sysfs_add_file+0x20/0x88
PGD 3ee37067 PUD 3edec067 PMD 0 
Oops: 0000 [1] PREEMPT 
last sysfs file: /devices/pci0000:00/0000:00:10.4/usb1/idVendor
CPU 0 
Modules linked in: tuner snd_via82xx snd_ice17xx_ak4xxx snd_via82xx_modem snd_ak4xxx_adda snd_cs8427 snd_ac97_codec snd_ac97_bus snd_i2c snd_mpu401_uart snd_pcm snd_timer bttv video_buf firmware_class snd_rawmidi snd_seq_device ir_common uhci_hcd sr_mod sk98lin compat_ioctl32 btcx_risc tveeprom videodev v4l2_common snd_page_alloc 8139too mii ehci_hcd usbcore snd soundcore ohci1394 ieee1394 cdrom psmouse k8_edac pcspkr
Pid: 545, comm: modprobe Not tainted 2.6.18-rc1-mm1 #1
RIP: 0010:[<ffffffff801cb377>]  [<ffffffff801cb377>] sysfs_add_file+0x20/0x88
RSP: 0018:ffff81003ee3fd48  EFLAGS: 00010296
RAX: 00000000ffffff00 RBX: ffffffff881106a0 RCX: ffff81003fde37f0
RDX: 0000000000000004 RSI: ffffffff88107d20 RDI: 0000000000000001
RBP: ffff81003ee3fd78 R08: 0000000000008040 R09: 0000000000000000
R10: ffffffff8015c243 R11: ffffffff8015c243 R12: ffffffff88107d20
R13: 0000000000000001 R14: 00000000ffffffef R15: 0000000000000000
FS:  00002ad53d5b96d0(0000) GS:ffffffff80628000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000000d9 CR3: 000000003ebd2000 CR4: 00000000000006a0
Process modprobe (pid: 545, threadinfo ffff81003ee3e000, task ffff81003fde30c0)
Stack:  000000043ee3fd58 ffffffff881106a0 0000000000000000 ffff81003ff78000
 ffffffff88110e68 0000000000000000 ffff81003ee3fd88 ffffffff801cb414
 ffff81003ee3fd98 ffffffff80265b91 ffff81003ee3fdd8 ffffffff880f2c90
Call Trace:
 [<ffffffff801cb414>] sysfs_create_file+0x35/0x37
 [<ffffffff80265b91>] class_device_create_file+0x17/0x19
 [<ffffffff880f2c90>] :bttv:bttv_probe+0x5c2/0x7a1
 [<ffffffff801fd9b8>] pci_device_probe+0x4c/0x74
 [<ffffffff8026501b>] driver_probe_device+0x5c/0xb7
 [<ffffffff802650e9>] __driver_attach+0x0/0x98
 [<ffffffff80265138>] __driver_attach+0x4f/0x98
 [<ffffffff80264a34>] bus_for_each_dev+0x49/0x7a
 [<ffffffff80264f45>] driver_attach+0x1c/0x1e
 [<ffffffff80264648>] bus_add_driver+0x89/0x138
 [<ffffffff80265391>] driver_register+0x8f/0x93
 [<ffffffff801fdb96>] __pci_register_driver+0x63/0x86
 [<ffffffff880f1ac8>] :bttv:bttv_init_module+0xb3/0xb5
 [<ffffffff801909aa>] sys_init_module+0xb0/0x203
 [<ffffffff8015854e>] system_call+0x7e/0x83


Code: 4c 8b bf d8 00 00 00 48 8b 7f 50 8b 5e 10 48 81 c7 00 01 00 
RIP  [<ffffffff801cb377>] sysfs_add_file+0x20/0x88
 RSP <ffff81003ee3fd48>
CR2: 00000000000000d9
 udevd-event[535]: run_program: '/sbin/modprobe' abnormal exit
