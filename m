Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVLTUpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVLTUpe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVLTUpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:45:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:59038 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932088AbVLTUpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:45:33 -0500
Date: Tue, 20 Dec 2005 21:45:30 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: console on POWER4 not working with 2.6.15
Message-ID: <20051220204530.GA26351@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The connection of ttyS0 to /dev/console doesnt seem to work anymore mit
2.6.15-rc5+6 on a POWER4 p630 in fullsystempartition mode, no HMC
connected. It works with 2.6.14.4.
I tested 2.6.15-rc6 arch/powerpc/configs/ppc64_defconfig.
Our SLES9 /init script in initramfs doesnt print anything with 2.6.15
after 'Freeing unused kernel memory: 360k freed'. But it does print its
banner with 2.6.14.4.  Other system with hvc console appear to work,
like JS20 or some POWER5 boxes.
So this regression seems to be local to ttyS0. The bootlog shows that
the firmware stdout device is properly detected at "COM1".
I will try older rc kernels now, but I may lose remote control of the
system.

The system appears to boot a bit into the init scripts, as the (unknown)
TIOCGDEV ioctl indicates. sysrq is not recognized. Forcing the system
into xmon shows all cpus are idle. Triggering a sysrq t via PS/2
keyboard shows this:

boot          S 000000000fe3637c  9680  2288   2287  2301               (NOTLB)
Call Trace:
[C00000003FE7F950] [C00000000061D850] nfs_v2_clientops+0x90/0x118 (unreliable)
[C00000003FE7FB20] [C0000000000242C0] .__switch_to+0x140/0x164
[C00000003FE7FBB0] [C00000000049C3C4] .schedule+0x664/0x7ac
[C00000003FE7FC80] [C00000000005C284] .do_wait+0xecc/0x10a0
[C00000003FE7FDC0] [C000000000012468] .compat_sys_waitpid+0x18/0x2c
[C00000003FE7FE30] [C000000000008600] syscall_exit+0x0/0x18
stty          S 000000000ff6f520 12512  2301   2288                     (NOTLB)
Call Trace:
[C0000001FEF0B480] [C0000000000242C0] .__switch_to+0x140/0x164
[C0000001FEF0B510] [C00000000049C3C4] .schedule+0x664/0x7ac
[C0000001FEF0B5E0] [C00000000049CC14] .schedule_timeout+0x40/0xec
[C0000001FEF0B6B0] [C000000000264D00] .tty_wait_until_sent+0x114/0x198
[C0000001FEF0B7A0] [C000000000264FF4] .set_termios+0x270/0x2b8
[C0000001FEF0B860] [C0000000002657F8] .n_tty_ioctl+0x7bc/0xc88
[C0000001FEF0B940] [C000000000261460] .tty_ioctl+0x11b8/0x1214
[C0000001FEF0BB70] [C0000000000CCC84] .do_ioctl+0xd4/0x108
[C0000001FEF0BC00] [C0000000000CD134] .vfs_ioctl+0x47c/0x4b0
[C0000001FEF0BCB0] [C0000000000CD1BC] .sys_ioctl+0x54/0x94
[C0000001FEF0BD60] [C0000000000EE10C] .compat_sys_ioctl+0x338/0x3bc
[C0000001FEF0BE30] [C000000000008600] syscall_exit+0x0/0x18



....
Elapsed time since release of system processors: 1 mins 37 secs

Config file read, 384 bytes
Welcome to yaboot version 1.3.11.SuSE
Enter "help" to get some basic usage information
boot: sysrq 
Please wait, loading kernel...
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded at 04400000, size: 1228 Kbytes
OF stdout device is: /pci@400000000110/isa@3/serial@i3f8
command line: root=/dev/sda4 xmon=on debug 
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000004533000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000200000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000200000000
Looking for displays
found display   : /pci@400000000112/pci@2,6/pci@1/display@0, opening ... done
opening PHB /pci@400000000110... done
opening PHB /pci@400000000112... done
instantiating rtas at 0x000000002fd0d000 ... done
0000000000000000 : boot cpu     0000000000000000
0000000000000001 : starting cpu hw idx 0000000000000001... done
0000000000000002 : starting cpu hw idx 0000000000000002... done
0000000000000003 : starting cpu hw idx 0000000000000003... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000004834000 -> 0x00000000048353ac
Device tree struct  0x0000000004836000 -> 0x0000000004841000
Calling quiesce ...
returning from prom_init
Page orders: linear mapping = 24, others = 12
Found initrd at 0xc000000004400000:0xc000000004533000
trying to initialize btext ...
boot stdout isn't a display !
trying /pci@400000000112/pci@2,6/pci@1/display@0 ...
result: 0
Starting Linux PPC64 #3 SMP Tue Dec 20 13:32:44 CET 2005
-----------------------------------------------------
ppc64_pft_size                = 0x0
ppc64_interrupt_controller    = 0x2
platform                      = 0x100
physicalMemorySize            = 0x200000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0xc0000001f0000000
htab_hash_mask                = 0xfffff
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Linux version 2.6.15-rc6 (olaf@sweetie) (gcc version 3.3.3 (SuSE Linux)) #3 SMP Tue Dec 20 13:32:44 CET 2005
[boot]0012 Setup Arch
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 81920 bytes
Using default idle loop
Top of RAM: 0x200000000, Total RAM: 0x200000000
Memory hole size: 0MB
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line: root=/dev/sda4 xmon=on debug 
[boot]0020 XICS Init
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 131072 bytes)
time_init: decrementer frequency = 181.701671 MHz
time_init: processor frequency   = 1453.000000 MHz
Page orders: linear mapping = 24, others = 12
Found initrd at 0xc000000004400000:0xc000000004533000
trying to initialize btext ...
boot stdout isn't a display !
trying /pci@400000000112/pci@2,6/pci@1/display@0 ...
result: 0
Starting Linux PPC64 #3 SMP Tue Dec 20 13:32:44 CET 2005
-----------------------------------------------------
ppc64_pft_size                = 0x0
ppc64_interrupt_controller    = 0x2
platform                      = 0x100
physicalMemorySize            = 0x200000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0xc0000001f0000000
htab_hash_mask                = 0xfffff
-----------------------------------------------------
[boot]0100 MM Init
[boot]0100 MM Init Done
Linux version 2.6.15-rc6 (olaf@sweetie) (gcc version 3.3.3 (SuSE Linux)) #3 SMP Tue Dec 20 13:32:44 CET 2005
[boot]0012 Setup Arch
EEH: PCI Enhanced I/O Error Handling Enabled
PPC64 nvram contains 81920 bytes
Using default idle loop
Top of RAM: 0x200000000, Total RAM: 0x200000000
Memory hole size: 0MB
On node 0 totalpages: 2097152
  DMA zone: 2097152 pages, LIFO batch:31
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
[boot]0015 Setup Done
Built 1 zonelists
Kernel command line: root=/dev/sda4 xmon=on debug 
[boot]0020 XICS Init
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 131072 bytes)
time_init: decrementer frequency = 181.701671 MHz
time_init: processor frequency   = 1453.000000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Memory: 8087032k/8388608k available (5824k kernel code, 300928k reserved, 2028k data, 499k bss, 360k init)
Calibrating delay loop... 362.49 BogoMIPS (lpj=724992)
Mount-cache hash table entries: 256
Processor 1 found.
Processor 2 found.
Processor 3 found.
Brought up 4 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 1228k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
Failed to request PCI IO region on PCI domain 0000
Using INTC for W82c105 IDE controller.
IOMMU table initialized, virtual merging enabled
ISA bridge at 0000:00:03.0
mapping IO 3fd30000000 -> d000080000000000, size: 100000
mapping IO 3fd50000000 -> d000080000100000, size: 100000
PCI: Probing PCI hardware done
Registering pmac pic with sysfs...
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
RTAS daemon started
RTAS: event: 99, Type: Internal Device Failure, Severity: 2
Total HugeTLB memory allocated, 0
JFS: nTxBlock = 8192, nTxLock = 65536
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
matroxfb: Matrox G450 detected
PInS data found at offset 31168
PInS memtype = 4
matroxfb: 640x480x8bpp (virtual: 640x26214)
matroxfb: framebuffer at 0x3FDEC000000, mapped to 0xd000080080054000, size 16777216
Console: switching to colour frame buffer device 80x30
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
vio_register_driver: driver hvc_console registering
HVSI: registered 0 devices
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250.0: ttyS2 at I/O 0x898 (irq = 10) is a 16550A
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
Copyright (c) 1999-2005 Intel Corporation.
pcnet32.c:v1.31c 01.Nov.2005 tsbogend@alpha.franken.de
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
PCI: Enabling device: (0000:21:01.0), cmd 143
e100: eth0: e100_probe: addr 0x3fd88030000, irq 101, MAC addr 00:02:55:4F:05:C7
PCI: Enabling device: (0001:21:01.0), cmd 143
e100: eth1: e100_probe: addr 0x3fde8030000, irq 133, MAC addr 00:02:55:4F:05:D7
acenic.c: v0.92 08/05/2002  Jes Sorensen, linux-acenic@SunSITE.dk
                            http://home.cern.ch/~jes/gige/acenic.html
PCI: Enabling device: (0000:01:01.0), cmd 142
0000:01:01.0: Alteon AceNIC Gigabit Ethernet at 0x3fd80000000, irq 99
  Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:04:ac:7c:84:ad
  PCI bus width: 64 bits, speed: 66MHz, latency: 72 clks
0000:01:01.0: Firmware up and running
PCI: Enabling device: (0000:61:01.0), cmd 142
0000:61:01.0: Alteon AceNIC Gigabit Ethernet at 0x3fd90000000, irq 105
  Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:06:29:6b:17:1d
  PCI bus width: 64 bits, speed: 66MHz, latency: 72 clks
0000:61:01.0: Firmware up and running
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI: Enabling device: (0000:41:01.0), cmd 143
sym0: <1010-66> rev 0x1 at pci 0000:41:01.0 irq 103
sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.1
  Vendor: IBM       Model: IC35L036UCD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:8: tagged command queuing enabled, command queue depth 16.
 target0:0:8: Beginning Domain Validation
 target0:0:8: asynchronous.
 target0:0:8: wide asynchronous.
 target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:8: Ending Domain Validation
  Vendor: IBM       Model: IC35L036UCD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:9: tagged command queuing enabled, command queue depth 16.
 target0:0:9: Beginning Domain Validation
 target0:0:9: asynchronous.
 target0:0:9: wide asynchronous.
 target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:9: Ending Domain Validation
  Vendor: IBM       Model: HSBPD4E  PU3SCSI  Rev: 0011
  Type:   Enclosure                          ANSI SCSI revision: 02
 target0:0:15: Beginning Domain Validation
 0:0:15:0: phase change 6-7 6@400503a8 resid=4.
 target0:0:15: asynchronous.
 target0:0:15: Ending Domain Validation
PCI: Enabling device: (0000:41:01.1), cmd 143
sym1: <1010-66> rev 0x1 at pci 0000:41:01.1 irq 104
sym1: No NVRAM, ID 7, Fast-80, SE, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.1
 target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
  Vendor: HP        Model: IBM-C568303030!D  Rev: C209
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target1:0:0: Beginning Domain Validation
 target1:0:0: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 31)
 target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
 1:0:0:0: ABORT operation started.
 1:0:0:0: ABORT operation timed-out.
 1:0:0:0: DEVICE RESET operation started.
 1:0:0:0: DEVICE RESET operation complete.
 target1:0:0: control msgout: c.
sym1: TARGET 0 has been reset.
 1:0:0:0: ABORT operation started.
 1:0:0:0: ABORT operation complete.
 1:0:0:0: BUS RESET operation started.
 1:0:0:0: BUS RESET operation complete.
sym1: SCSI BUS reset detected.
sym1: SCSI BUS has been reset.
 target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
 target1:0:0: Wide Transfers Fail
 target1:0:0: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 31)
 target1:0:0: Domain Validation skipping write tests
 target1:0:0: Ending Domain Validation
ipr: IBM Power RAID SCSI Device Driver version: 2.1.0 (October 31, 2005)
vio_register_driver: driver ibmvscsi registering
libata version 1.20 loaded.
st: Version 20050830, fixed bufsize 32768, s/g segs 256
st 1:0:0:0: Attached scsi tape st0<4>st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 2097152
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sda: drive cache: write through
 sda: sda2 sda3 sda4
sd 0:0:8:0: Attached scsi disk sda
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
sd 0:0:9:0: Attached scsi disk sdb
sd 0:0:8:0: Attached scsi generic sg0 type 0
sd 0:0:9:0: Attached scsi generic sg1 type 0
 0:0:15:0: Attached scsi generic sg2 type 13
st 1:0:0:0: Attached scsi generic sg3 type 1
ieee1394: Initialized config rom entry `ip1394'
ieee1394: raw1394: /dev/raw1394 device initialized
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0001:01:01.0: OHCI Host Controller
ohci_hcd 0001:01:01.0: new USB bus registered, assigned bus number 1
ohci_hcd 0001:01:01.0: irq 131, io mem 0x3fde0003000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ohci_hcd 0001:01:01.1: OHCI Host Controller
ohci_hcd 0001:01:01.1: new USB bus registered, assigned bus number 2
ohci_hcd 0001:01:01.1: irq 132, io mem 0x3fde0002000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
ohci_hcd 0001:01:01.2: OHCI Host Controller
ohci_hcd 0001:01:01.2: new USB bus registered, assigned bus number 3
ohci_hcd 0001:01:01.2: irq 131, io mem 0x3fde0001000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
ohci_hcd 0001:01:01.3: OHCI Host Controller
ohci_hcd 0001:01:01.3: new USB bus registered, assigned bus number 4
ohci_hcd 0001:01:01.3: irq 132, io mem 0x3fde0000000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
/home/olaf/kernel/bugs/96313/linux-2.6.15-rc6-olh/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
atkbd.c: keyboard reset failed on isa0060/serio1
md: raid1 personality registered as nr 3
md: raid10 personality registered as nr 9
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  3777.000 MB/sec
   8regs_prefetch:  3726.000 MB/sec
   32regs    :  4717.000 MB/sec
   32regs_prefetch:  3839.000 MB/sec
raid5: using function: 32regs (4717.000 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
oprofile: using ppc64/power4 performance monitoring.
Netfilter messages via NETLINK v0.30.
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
TCP established hash table entries: 1048576 (order: 12, 16777216 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 1048576 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
input: AT Raw Set 2 keyboard as /class/input/input0
Freeing unused kernel memory: 360k freed
st0: Block limits 1 - 16777215 bytes.
ReiserFS: sda4: found reiserfs format "3.6" with standard journal
ReiserFS: sda4: using ordered data mode
ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda4: checking transaction log (sda4)
ReiserFS: sda4: Using r5 hash to sort names
ioctl32(showconsole:2292): Unknown cmd fd(0) cmd(40045432){00} arg(ffe05a88) on /dev/console


-- 
short story of a lazy sysadmin:
 alias appserv=wotan
