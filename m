Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbRERTYp>; Fri, 18 May 2001 15:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbRERTYf>; Fri, 18 May 2001 15:24:35 -0400
Received: from ns.tasking.nl ([195.193.207.2]:530 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S261482AbRERTYY>;
	Fri, 18 May 2001 15:24:24 -0400
Date: Fri, 18 May 2001 21:22:53 +0200
From: Frank van Maarseveen <fvm@tasking.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x: Bogus ARP packets containing NFS file data
Message-ID: <20010518212252.A1209@espoo.tasking.nl>
Reply-To: frank_van_maarseveen@tasking.com
In-Reply-To: <20010515175212.A31058@espoo.tasking.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
In-Reply-To: <20010515175212.A31058@espoo.tasking.nl>; from fvm on Tue, May 15, 2001 at 05:52:12PM +0200
Organization: TASKING, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To recap:

The machine is an NFSv3 client. The header of outgoing NFS UDP/IP packets
is sometimes corrupted, such that network sniffers on unrelated systems
report bogus ARP packets. AFAIK there is no data corruption on the
file level because the request is no longer recognized by the NFS
server. The symptom is also recorded in /var/log/messages on the client:

May 18 20:24:21 espoo kernel: nfs: server xxx not responding, still trying 
May 18 20:24:21 espoo kernel: nfs: server xxx OK 

In userland a short stall is experienced by the program which caused the
NFS traffic.

At most the first 196 bytes of a packet are corrupted (maybe some link
layer header must be added -- I'm not sure). In one incident the file
data of what was most likely an NFSv3 WRITE request was not altered but
a lot of the packaging was (not investigated any further but see earlier
mails). The bogus ARP packet contained the first 1304 bytes of a VIM swap
file just made by VIM, completely intact including the magic header "b0VIM".

A sniffer on the system itself is able to see the modified outgoing packets.

This problem is present in at least the following kernels:

2.4.0
2.4.2
2.4.4
2.4.5-pre1
2.4.5-pre2

This kernel configuration makes the difference:

no problem			problem
---------------------------------------
CONFIG_X86=y                    CONFIG_X86=y
CONFIG_ISA=y                    CONFIG_ISA=y
CONFIG_UID16=y                  CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y           CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y                CONFIG_MODULES=y
CONFIG_M586TSC=y                CONFIG_M586TSC=y
CONFIG_X86_WP_WORKS_OK=y        CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y             CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y            CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y              CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y           CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5     CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y     CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y       CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y                CONFIG_X86_TSC=y
CONFIG_NOHIGHMEM=y              CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y                   CONFIG_MTRR=y
CONFIG_NET=y                    CONFIG_NET=y
CONFIG_PCI=y                    CONFIG_PCI=y
CONFIG_PCI_GOANY=y              CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y               CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y             CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y              CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y                CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y                CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y                 CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y              CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y            CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y             CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y            CONFIG_BINFMT_MISC=y
CONFIG_PM=y                     CONFIG_PM=y
CONFIG_ACPI=y                   CONFIG_ACPI=y
CONFIG_PNP=y                    CONFIG_PNP=y
CONFIG_ISAPNP=y                 CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y             CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y           CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y            CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=409     CONFIG_BLK_DEV_RAM_SIZE=409
CONFIG_BLK_DEV_INITRD=y         CONFIG_BLK_DEV_INITRD=y
CONFIG_MD=y                     CONFIG_MD=y
CONFIG_BLK_DEV_LVM=y            CONFIG_BLK_DEV_LVM=y
CONFIG_LVM_PROC_FS=y            CONFIG_LVM_PROC_FS=y
CONFIG_PACKET=y                 CONFIG_PACKET=y
CONFIG_NETLINK=y                CONFIG_NETLINK=y
CONFIG_RTNETLINK=y              CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y            CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y              CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y        CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y                 CONFIG_FILTER=y
CONFIG_UNIX=y                   CONFIG_UNIX=y
CONFIG_INET=y                   CONFIG_INET=y
CONFIG_IP_MULTICAST=y           CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y     CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y              CONFIG_RTNETLINK=y
CONFIG_NETLINK=y                CONFIG_NETLINK=y
CONFIG_IP_MULTIPLE_TABLES=y     CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y        CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y     CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y           CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y       CONFIG_IP_ROUTE_VERBOSE=y
                             >  CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_IPTABLES=y         CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y      CONFIG_IP_NF_MATCH_LIMIT=y
                             >  CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_FILTER=y           CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=     CONFIG_IP_NF_TARGET_REJECT=
                             >  CONFIG_IP_NF_NAT=y
                             >  CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_LOG=y       CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IDE=y                    CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y            CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y        CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y          CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y         CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y         CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y         CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y       CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDE_MODES=y      CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y                   CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y             CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40         CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y             CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y             CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y      CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2          CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y             CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y      CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y         CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y         CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y           CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=y           CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEV     CONFIG_AIC7XXX_CMDS_PER_DEV
CONFIG_AIC7XXX_RESET_DELAY=     CONFIG_AIC7XXX_RESET_DELAY=
CONFIG_SCSI_SYM53C8XX=y         CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAU     CONFIG_SCSI_NCR53C8XX_DEFAU
CONFIG_SCSI_NCR53C8XX_MAX_T     CONFIG_SCSI_NCR53C8XX_MAX_T
CONFIG_SCSI_NCR53C8XX_SYNC=     CONFIG_SCSI_NCR53C8XX_SYNC=
CONFIG_NETDEVICES=y             CONFIG_NETDEVICES=y
CONFIG_DUMMY=y                  CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y           CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y        CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=y                    CONFIG_EL3=y
CONFIG_VORTEX=y                 CONFIG_VORTEX=y
CONFIG_NET_PCI=y                CONFIG_NET_PCI=y
CONFIG_EEPRO100=y               CONFIG_EEPRO100=y
CONFIG_PPP=y                    CONFIG_PPP=y
CONFIG_PPP_ASYNC=y              CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y            CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y            CONFIG_PPP_BSDCOMP=y
CONFIG_VT=y                     CONFIG_VT=y
CONFIG_VT_CONSOLE=y             CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y                 CONFIG_SERIAL=y
CONFIG_SERIAL_EXTENDED=y        CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y      CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y       CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y            CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256     CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y                  CONFIG_MOUSE=y
CONFIG_PSMOUSE=y                CONFIG_PSMOUSE=y
CONFIG_NVRAM=y                  CONFIG_NVRAM=y
CONFIG_AGP=y                    CONFIG_AGP=y
CONFIG_AGP_I810=y               CONFIG_AGP_I810=y
CONFIG_DRM=y                    CONFIG_DRM=y
CONFIG_DRM_I810=y               CONFIG_DRM_I810=y
CONFIG_AUTOFS4_FS=y             CONFIG_AUTOFS4_FS=y
CONFIG_FAT_FS=y                 CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y               CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y                CONFIG_VFAT_FS=y
                             >  CONFIG_JFFS_FS_VERBOSE=0
CONFIG_RAMFS=y                  CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y             CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y                 CONFIG_JOLIET=y
CONFIG_PROC_FS=y                CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y              CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y                CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y                 CONFIG_NFS_FS=y
CONFIG_NFS_V3=y                 CONFIG_NFS_V3=y
CONFIG_NFSD=y                   CONFIG_NFSD=y
CONFIG_NFSD_V3=y                CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y                 CONFIG_SUNRPC=y
CONFIG_LOCKD=y                  CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y               CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y        CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y                    CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859     CONFIG_NLS_DEFAULT="iso8859
CONFIG_NLS_CODEPAGE_437=y       CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y          CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y            CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y           CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y                  CONFIG_SOUND=y
CONFIG_SOUND_OSS=y              CONFIG_SOUND_OSS=y
CONFIG_SOUND_ICH=y              CONFIG_SOUND_ICH=y
CONFIG_SOUND_SB=y               CONFIG_SOUND_SB=y
CONFIG_USB=y                    CONFIG_USB=y
CONFIG_USB_DEVICEFS=y           CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=y               CONFIG_USB_UHCI=y
CONFIG_USB_OHCI=y               CONFIG_USB_OHCI=y
CONFIG_USB_STORAGE=y            CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y      CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_PRINTER=y            CONFIG_USB_PRINTER=y
CONFIG_USB_SCANNER=y            CONFIG_USB_SCANNER=y
CONFIG_MAGIC_SYSRQ=y            CONFIG_MAGIC_SYSRQ=y

It is probably possible to reduce the differences but I thought
this is interesting enough to mail it already. A second precondition
_might_ be the simple presence of the following iptables entry:

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 DROP       udp  --  ppp+   any     anywhere             anywhere           udp dpt:route 


The NIC might be a third precondition. Speed is 10Mbps. For the curious here
are all the bootmessages:

May 18 20:18:41 espoo kernel: klogd 1.3-3, log source = /proc/kmsg started.
May 18 20:18:41 espoo kernel: Linux version 2.4.0-t3 (fvm@espoo) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Fri May 18 20:09:45 MEST 2001 
May 18 20:18:41 espoo kernel: BIOS-provided physical RAM map: 
May 18 20:18:41 espoo kernel:  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable) 
May 18 20:18:41 espoo kernel:  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved) 
May 18 20:18:41 espoo kernel:  BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved) 
May 18 20:18:41 espoo kernel:  BIOS-e820: 0000000003e00000 @ 0000000000100000 (usable) 
May 18 20:18:41 espoo kernel:  BIOS-e820: 0000000001160000 @ 00000000feea0000 (reserved) 
May 18 20:18:41 espoo kernel: On node 0 totalpages: 16128 
May 18 20:18:41 espoo kernel: zone(0): 4096 pages. 
May 18 20:18:41 espoo kernel: zone(1): 12032 pages. 
May 18 20:18:41 espoo kernel: zone(2): 0 pages. 
May 18 20:18:41 espoo kernel: Kernel command line: auto BOOT_IMAGE=linux-2.4.0-t3 ro root=302 BOOT_FILE=/boot/linux-2.4.0-t3 nomodules 
May 18 20:18:41 espoo kernel: Initializing CPU#0 
May 18 20:18:41 espoo kernel: Detected 664.518 MHz processor. 
May 18 20:18:41 espoo kernel: Console: colour VGA+ 80x25 
May 18 20:18:41 espoo kernel: Calibrating delay loop... 1327.10 BogoMIPS 
May 18 20:18:41 espoo kernel: Memory: 60216k/64512k available (1729k kernel code, 3908k reserved, 631k data, 220k init, 0k highmem) 
May 18 20:18:41 espoo kernel: Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes) 
May 18 20:18:41 espoo kernel: Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes) 
May 18 20:18:41 espoo kernel: Page-cache hash table entries: 16384 (order: 4, 65536 bytes) 
May 18 20:18:41 espoo kernel: Inode-cache hash table entries: 4096 (order: 3, 32768 bytes) 
May 18 20:18:41 espoo kernel: CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0 
May 18 20:18:41 espoo kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
May 18 20:18:41 espoo kernel: CPU: L2 cache: 256K 
May 18 20:18:41 espoo kernel: Intel machine check architecture supported. 
May 18 20:18:41 espoo kernel: Intel machine check reporting enabled on CPU#0. 
May 18 20:18:41 espoo kernel: CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000 
May 18 20:18:42 espoo kernel: CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000 
May 18 20:18:42 espoo kernel: CPU: Common caps: 0383f9ff 00000000 00000000 00000000 
May 18 20:18:42 espoo kernel: CPU: Intel Pentium III (Coppermine) stepping 03 
May 18 20:18:42 espoo kernel: Checking 'hlt' instruction... OK. 
May 18 20:18:42 espoo kernel: POSIX conformance testing by UNIFIX 
May 18 20:18:42 espoo kernel: mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au) 
May 18 20:18:42 espoo kernel: mtrr: detected mtrr type: Intel 
May 18 20:18:42 espoo kernel: PCI: PCI BIOS revision 2.10 entry at 0xecb91, last bus=1 
May 18 20:18:42 espoo kernel: PCI: Using configuration type 1 
May 18 20:18:42 espoo kernel: PCI: Probing PCI hardware 
May 18 20:18:42 espoo kernel: Unknown bridge resource 1: assuming transparent 
May 18 20:18:42 espoo kernel: Unknown bridge resource 2: assuming transparent 
May 18 20:18:42 espoo kernel: PCI: Using IRQ router default [8086/2410] at 00:1f.0 
May 18 20:18:42 espoo kernel: isapnp: Scanning for Pnp cards... 
May 18 20:18:42 espoo kernel: isapnp: No Plug & Play device found 
May 18 20:18:42 espoo kernel: Linux NET4.0 for Linux 2.4 
May 18 20:18:42 espoo kernel: Based upon Swansea University Computer Society NET3.039 
May 18 20:18:42 espoo kernel: Initializing RT netlink socket 
May 18 20:18:42 espoo kernel: DMI 2.3 present. 
May 18 20:18:42 espoo kernel: 42 structures occupying 1358 bytes. 
May 18 20:18:42 espoo kernel: DMI table at 0x000FD97B. 
May 18 20:18:42 espoo kernel: BIOS Vendor: Compaq 
May 18 20:18:42 espoo kernel: BIOS Version: 686J1 v3.08 
May 18 20:18:42 espoo kernel: BIOS Release: 03/15/2000 
May 18 20:18:42 espoo kernel: System Vendor: Compaq. 
May 18 20:18:42 espoo kernel: Product Name: Deskpro EP Series. 
May 18 20:18:42 espoo kernel: Version . 
May 18 20:18:42 espoo kernel: Serial Number 8032FQX41510    . 
May 18 20:18:42 espoo kernel: Board Vendor: Compaq. 
May 18 20:18:42 espoo kernel: Board Name: 0664h. 
May 18 20:18:42 espoo kernel: Board Version: . 
May 18 20:18:42 espoo kernel: Asset Tag: 8032FQX41510    . 
May 18 20:18:42 espoo kernel: Starting kswapd v1.8 
May 18 20:18:42 espoo kernel: pty: 256 Unix98 ptys configured 
May 18 20:18:42 espoo kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize 
May 18 20:18:42 espoo kernel: loop: enabling 8 loop devices 
May 18 20:18:42 espoo kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31 
May 18 20:18:42 espoo kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
May 18 20:18:42 espoo kernel: PIIX4: IDE controller on PCI bus 00 dev f9 
May 18 20:18:42 espoo kernel: PIIX4: chipset revision 2 
May 18 20:18:42 espoo kernel: PIIX4: not 100%% native mode: will probe irqs later 
May 18 20:18:42 espoo kernel: hda: FUJITSU MPF3102AT, ATA DISK drive 
May 18 20:18:42 espoo kernel: hdc: CD-ROM 52X/AKH, ATAPI CDROM drive 
May 18 20:18:42 espoo kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
May 18 20:18:42 espoo kernel: ide1 at 0x170-0x177,0x376 on irq 15 
May 18 20:18:42 espoo kernel: hda: 19541088 sectors (10005 MB) w/512KiB Cache, CHS=1292/240/63 
May 18 20:18:42 espoo kernel: hdc: ATAPI 52X CD-ROM drive, 192kB Cache 
May 18 20:18:42 espoo kernel: Uniform CD-ROM driver Revision: 3.12 
May 18 20:18:42 espoo kernel: Partition check: 
May 18 20:18:42 espoo kernel:  hda: hda1 hda2 hda4 
May 18 20:18:42 espoo kernel: Floppy drive(s): fd0 is 1.44M 
May 18 20:18:42 espoo kernel: FDC 0 is a post-1991 82077 
May 18 20:18:42 espoo kernel: LVM version 0.9  by Heinz Mauelshagen  (13/11/2000) 
May 18 20:18:42 espoo kernel: lvm -- Driver successfully initialized 
May 18 20:18:42 espoo kernel: Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled 
May 18 20:18:42 espoo kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
May 18 20:18:42 espoo kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A 
May 18 20:18:42 espoo kernel: Non-volatile memory driver v1.1 
May 18 20:18:42 espoo kernel: 3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $ 
May 18 20:18:42 espoo kernel: See Documentation/networking/vortex.txt 
May 18 20:18:42 espoo kernel: eth0: 3Com PCI 3c905 Boomerang 100baseTx at 0x1000,  00:60:97:ba:b4:f5, IRQ 11 
May 18 20:18:42 espoo kernel:   8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface. 
May 18 20:18:42 espoo kernel:   MII transceiver found at address 24, status 786d. 
May 18 20:18:42 espoo kernel:   Enabling bus-master transmits and whole-frame receives. 
May 18 20:18:42 espoo kernel: PPP generic driver version 2.4.1 
May 18 20:18:42 espoo kernel: PPP Deflate Compression module registered 
May 18 20:18:42 espoo kernel: PPP BSD Compression module registered 
May 18 20:18:42 espoo kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann 
May 18 20:18:42 espoo kernel: agpgart: Maximum main memory to use for agp memory: 27M 
May 18 20:18:42 espoo kernel: agpgart: Detected an Intel i810 E Chipset. 
May 18 20:18:42 espoo kernel: agpgart: detected 4MB dedicated video ram. 
May 18 20:18:42 espoo kernel: agpgart: AGP aperture is 64M @ 0x44000000 
May 18 20:18:42 espoo kernel: [drm] AGP 0.99 on Intel i810 @ 0x44000000 64MB 
May 18 20:18:42 espoo kernel: [drm] Initialized i810 1.1.0 20000928 on minor 63 
May 18 20:18:42 espoo kernel: SCSI subsystem driver Revision: 1.00 
May 18 20:18:42 espoo kernel: Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996 
May 18 20:18:42 espoo kernel: sb: No ISAPnP cards found, trying standard ones... 
May 18 20:18:42 espoo kernel: sb: I/O, IRQ, and DMA are mandatory 
May 18 20:18:42 espoo kernel: Intel 810 + AC97 Audio, version 0.01, 20:12:36 May 18 2001 
May 18 20:18:42 espoo kernel: PCI: Setting latency timer of device 00:1f.5 to 64 
May 18 20:18:42 espoo kernel: i810: Intel ICH 82801AA found at IO 0x2400 and 0x2000, IRQ 11 
May 18 20:18:42 espoo kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5340 (Analog Devices AD1881) 
May 18 20:18:42 espoo kernel: usb.c: registered new driver usbdevfs 
May 18 20:18:42 espoo kernel: usb.c: registered new driver hub 
May 18 20:18:42 espoo kernel: usb-uhci.c: $Revision: 1.251 $ time 20:12:49 May 18 2001 
May 18 20:18:42 espoo kernel: usb-uhci.c: High bandwidth mode enabled 
May 18 20:18:42 espoo kernel: PCI: Setting latency timer of device 00:1f.2 to 64 
May 18 20:18:42 espoo kernel: usb-uhci.c: USB UHCI at I/O 0x2440, IRQ 11 
May 18 20:18:42 espoo kernel: usb-uhci.c: Detected 2 ports 
May 18 20:18:42 espoo kernel: usb.c: new USB bus registered, assigned bus number 1 
May 18 20:18:42 espoo kernel: hub.c: USB hub found 
May 18 20:18:42 espoo kernel: hub.c: 2 ports detected 
May 18 20:18:42 espoo kernel: usb.c: registered new driver usbscanner 
May 18 20:18:42 espoo kernel: scanner.c: USB Scanner support registered. 
May 18 20:18:42 espoo kernel: usb.c: registered new driver usblp 
May 18 20:18:42 espoo kernel: usb.c: registered new driver usb-storage 
May 18 20:18:42 espoo kernel: USB Mass Storage support registered. 
May 18 20:18:42 espoo kernel: ACPI: System description tables found 
May 18 20:18:42 espoo kernel: ACPI: System description tables loaded 
May 18 20:18:42 espoo kernel: ACPI: Subsystem enabled 
May 18 20:18:42 espoo kernel: ACPI: System firmware supports: C2 
May 18 20:18:42 espoo kernel: ACPI: System firmware supports: S0 S1 S4 S5 
May 18 20:18:42 espoo kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
May 18 20:18:42 espoo kernel: IP Protocols: ICMP, UDP, TCP, IGMP 
May 18 20:18:42 espoo kernel: IP: routing cache hash table of 512 buckets, 4Kbytes 
May 18 20:18:42 espoo kernel: TCP: Hash tables configured (established 4096 bind 4096) 
May 18 20:18:42 espoo kernel: ip_conntrack (504 buckets, 4032 max) 
May 18 20:18:42 espoo kernel: ip_tables: (c)2000 Netfilter core team 
May 18 20:18:43 espoo kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0. 
May 18 20:18:43 espoo kernel: VFS: Mounted root (ext2 filesystem) readonly. 
May 18 20:18:43 espoo kernel: Freeing unused kernel memory: 220k freed 
May 18 20:18:43 espoo kernel: Adding Swap: 264560k swap-space (priority -1) 
May 18 20:18:43 espoo kernel: eth0: first available media type: MII 

About 10 bad ARP packets have been sent right now.

# cat /proc/net/dev
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
    lo:   10222      92    0    0    0     0          0         0    10222      92    0    0    0     0       0          0
  eth0:77979804   37889    1    0    3     1          0         0  4638884   10414    0    0    0   280       0          0
dummy0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0



-- 
Frank
