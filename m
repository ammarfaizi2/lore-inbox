Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292918AbSCMVan>; Wed, 13 Mar 2002 16:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311378AbSCMVa0>; Wed, 13 Mar 2002 16:30:26 -0500
Received: from egil.codesourcery.com ([66.92.14.122]:1152 "EHLO
	taltos.codesourcery.com") by vger.kernel.org with ESMTP
	id <S292918AbSCMVaJ>; Wed, 13 Mar 2002 16:30:09 -0500
Date: Wed, 13 Mar 2002 13:30:06 -0800
From: Zack Weinberg <zack@codesourcery.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre3 hangs after enabling machine check; 2.2.20 was fine
Message-ID: <20020313211803.GA2930@codesourcery.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On my system, 2.4.19pre3 hangs to hard reset just after it prints
"Intel machine check architecture supported."  If I pass "nomce" on the
command line, it boots fine. 2.2.20 did not have a problem enabling
machine checks.  I instrumented 2.4's bluesmoke.c and determined that
it hangs trying to clear the second of five IA32_MC0_CTL banks
(i.e. the second iteration of the loop

        for(i=0;i<banks;i++)
        {
                wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
        }

in intel_mcheck_init())

This is an older P-III CPU (stepping 3, 500MHz) and a 440BX/ZX chipset.
Compiler used was 2.95.4.  dmesg (from a nomce boot), lspci -v, and
.config are attached to the message.  Please let me know if you need
more information.

I'm not subscribed to linux-kernel, please cc: me directly on replies.

zw

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=lspci

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 64
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: cc000000-cddfffff
	Prefetchable memory behind bridge: cdf00000-cfffffff

00:04.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:04.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
	Flags: medium devsel, IRQ 9

00:09.0 Ethernet controller: 3Com Corporation 3c900 10BaseT [Boomerang]
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d000 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Kingston Technologies: Unknown device f002
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at b800 [size=256]
	Memory at cb800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation: Unknown device 0017
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at cc000000 (32-bit, non-prefetchable) [size=16M]
	Memory at ce000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at cdff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=dmesg

Linux version 2.4.19-pre3 (zack@taltos) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Wed Mar 13 11:58:32 PST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffc000 (usable)
 BIOS-e820: 000000000fffc000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65532
zone(0): 4096 pages.
zone(1): 61436 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: nomce hdc=ide-scsi parport=0x278,5,3 sb=220,7,1,5
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 501.149 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 257116k/262128k available (1149k kernel code, 4624k reserved, 285k data, 124k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 501.1421 MHz.
..... host bus clock speed is 100.2283 MHz.
cpu: 0, clocks: 1002283, slice: 501141
CPU0<T0:1002272,T1:501120,D:11,S:501141,C:1002283>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
PCI: Found IRQ 9 for device 00:04.2
PCI: Sharing IRQ 9 with 00:09.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
parport0: PC-style at 0x278 (0x678), irq 5, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (interrupt-driven).
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD300BB-00AUA1, ATA DISK drive
hdc: CD-W58E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=3649/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
PCI: Found IRQ 10 for device 00:0a.0
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xd0800000, 00:C0:F0:56:E3:29, IRQ 10.
PCI: Found IRQ 9 for device 00:09.0
PCI: Sharing IRQ 9 with 00:04.2
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c900 Boomerang 10baseT at 0xd000. Vers LK1.1.16
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: CD-W58E           Rev: 1.0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: No ISAPnP cards found, trying standard ones...
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 124k freed
Adding Swap: 999896k swap-space (priority -1)

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=config

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y
CONFIG_TULIP_MMIO=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_REISERFS_FS=y
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_SB=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

--pWyiEgJYm5f9v55/--
