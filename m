Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVFIQX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVFIQX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVFIQX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:23:27 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:21206 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id S262388AbVFIQRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:17:52 -0400
Date: Thu, 9 Jun 2005 18:17:47 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Adaptec RAID 2010S hang-up under heavy load
Message-ID: <20050609161747.GB21111@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello lkml's,

I have server on Supermicro board with Xenon processor and Adaptec RAID
controller 2010S.

I'm using for this controller aacraid driver.

Version of kernel is 2.6.11.7, but problem can be reproducted on
2.6.11.11 too.

lspci:
0000:00:00.0 Host bridge: Intel Corp. E7500 Memory Controller Hub (rev 02)
0000:00:00.1 ff00: Intel Corp. E7500/E7501 Host RASUM Controller (rev 02)
0000:00:02.0 PCI bridge: Intel Corp. E7500/E7501 Hub Interface B PCI-to-PCI Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
0000:01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
0000:01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
0000:01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
0000:01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
0000:02:03.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller (LOM) (rev 02)
0000:03:01.0 RAID bus controller: Adaptec AAC-RAID (rev 01)
0000:04:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:04:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)

Part of dmesg:
Red Hat/Adaptec aacraid driver (1.1.2-lk2 Jun  7 2005)
AAC0: kernel 4.0.4 build 6011
AAC0: monitor 4.0.4 build 6011
AAC0: bios 4.0.0 build 6011
AAC0: serial b81168fafaf001
AAC0: Non-DASD support enabled.
scsi0 : aacraid
  Vendor: ADAPTEC   Model: Adaptec Volume    Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ADAPTEC   Model: Volume0           Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 71677440 512-byte hdwr sectors (36699 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
SCSI device sda: drive cache: write through
SCSI device sda: 71677440 512-byte hdwr sectors (36699 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
SCSI device sda: drive cache: write through
 sda: sda1 sda2 < sda5 >
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 716785920 512-byte hdwr sectors (366994 MB)
sdb: Write Protect is off
sdb: Mode Sense: 03 00 00 00
SCSI device sdb: drive cache: write through
SCSI device sdb: 716785920 512-byte hdwr sectors (366994 MB)
sdb: Write Protect is off
sdb: Mode Sense: 03 00 00 00
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
Attached scsi removable disk sdb at scsi0, channel 0, id 1, lun 0

sda: one disk
sdb: RAID5 volume

In the adapter is (probably) newest firmware, I had updated firmware on
the disks in the RAID5 volume too to the newest version (they are
Seagate drives).

Description of the problem:

If I have not very loaded this server, everythink goes OK. I want do
some backups to the sdb2 device.

But if I have on this server CPU under load (I can reproducted it by
distributed.net client) and I want to intensively access RAID volume (I
make on sdb2 backups from another machine via rdiff-backup tool), sdb
hung-up and is innacessible. aaccli tool didn't report any problem with
this volume. To repair this problem, I must restart server.

When I stop distributed.net client, backup goes OK and volume is
operational without any problems.

This problem is reproductible.

Part of kern.log, when this problem occurs:
Jun  7 01:31:30 afs1 kernel: aacraid: Host adapter reset request. SCSI hang ?
Jun  7 01:32:30 afs1 kernel: aacraid: SCSI bus appears hung
Jun  7 01:32:31 afs1 kernel: scsi: Device offlined - not ready after error recovery: host0 channel 0 id 1 lun 0
Jun  7 01:32:31 afs1 kernel: SCSI error : <0 0 1 0> return code = 0x6000000
Jun  7 01:32:31 afs1 kernel: end_request: I/O error, dev sdb, sector 324337614
Jun  7 01:32:31 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
Jun  7 01:32:31 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3899
Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3900
Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3901
Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3902
Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3903
Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3904
Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3905
Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3906
Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3907
Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
Jun  7 01:32:31 afs1 kernel: Buffer I/O error on device sdb2, logical block 3908
Jun  7 01:32:31 afs1 kernel: lost page write due to I/O error on sdb2
Jun  7 01:32:31 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
Jun  7 01:32:31 afs1 kernel: REISERFS: abort (device sdb2): Journal write error in flush_commit_list
Jun  7 01:32:31 afs1 kernel: REISERFS: Aborting journal for filesystem on sdb2
Jun  7 01:32:31 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
Jun  7 01:32:31 afs1 last message repeated 53 times
Jun  7 01:32:31 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
Jun  7 01:32:31 afs1 last message repeated 1295 times
Jun  7 01:32:31 afs1 kernel: ------------[ cut here ]------------
Jun  7 01:32:31 afs1 kernel: kernel BUG at fs/buffer.c:2891!
Jun  7 01:32:31 afs1 kernel: invalid operand: 0000 [#1]
Jun  7 01:32:31 afs1 kernel: PREEMPT SMP
Jun  7 01:32:31 afs1 kernel: Modules linked in: evdev piix e100 e1000 ide_cd ide_core cdrom unix
Jun  7 01:32:31 afs1 kernel: CPU:    0
Jun  7 01:32:31 afs1 kernel: EIP:    0060:[try_to_free_buffers+156/176]
Not tainted VLI
Jun  7 01:32:31 afs1 kernel: EFLAGS: 00010246   (2.6.11.7)
Jun  7 01:32:31 afs1 kernel: EIP is at try_to_free_buffers+0x9c/0xb0
Jun  7 01:32:31 afs1 kernel: eax: 20000000   ebx: c14b3fe0   ecx: cec37cec   edx: f4c52530
Jun  7 01:32:31 afs1 kernel: esi: 00000000   edi: e2097ee4   ebp: 00000001   esp: e2097e0c
Jun  7 01:32:31 afs1 kernel: ds: 007b   es: 007b   ss: 0068
Jun  7 01:32:31 afs1 kernel: Process rdiff-backup (pid: 20207, threadinfo=e2096000 task=f4c52530)
Jun  7 01:32:31 afs1 kernel: Stack: 000019c2 000019c3 00000000 c14b3fe0 00000000 e2097ee4c019aa5b c14b3fe0
Jun  7 01:32:31 afs1 kernel:        0000005a 00000001 fffffffb cec37c34 c019c1a6 e2097ee400000001 0000312e
Jun  7 01:32:31 afs1 kernel:        00000000 00000001 0000005a e2097ee4 fffffffb 00000000f3c1b680 00000001
Jun  7 01:32:31 afs1 kernel: Call Trace:
Jun  7 01:32:31 afs1 kernel:  [reiserfs_unprepare_pages+43/112] reiserfs_unprepare_pages+0x2b/0x70
Jun  7 01:32:31 afs1 kernel:  [reiserfs_file_write+1638/1744] reiserfs_file_write+0x666/0x6d0
Jun  7 01:32:31 afs1 kernel:  [ip_rcv+859/1264] ip_rcv+0x35b/0x4f0
Jun  7 01:32:31 afs1 kernel:  [pg0+946460271/1070216192] e1000_clean_rx_irq+0x1bf/0x4c0 [e1000]
Jun  7 01:32:31 afs1 kernel:  [handle_IRQ_event+91/112] handle_IRQ_event+0x5b/0x70
Jun  7 01:32:31 afs1 kernel:  [mark_offset_tsc+473/720] mark_offset_tsc+0x1d9/0x2d0
Jun  7 01:32:31 afs1 kernel:  [update_wall_time+21/64] update_wall_time+0x15/0x40
Jun  7 01:32:31 afs1 kernel:  [do_timer+192/208] do_timer+0xc0/0xd0
Jun  7 01:32:31 afs1 kernel:  [timer_interrupt+192/304] timer_interrupt+0xc0/0x130
Jun  7 01:32:31 afs1 kernel:  [vfs_write+174/304] vfs_write+0xae/0x130
Jun  7 01:32:31 afs1 kernel:  [sys_write+81/128] sys_write+0x51/0x80
Jun  7 01:32:31 afs1 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun  7 01:32:31 afs1 kernel: Code: 75 ed 89 f2 83 c4 0c 89 d0 5b 5e 5f
c3 89 1c 24 e8 5a 29 fe ff eb c2 89 1c 24 8d 44 24 08 89 44 24 04 e8 c8
fe ff ff 89 c6 eb b5 <0f> 0b 4b 0b e6 18 28 c0 e9 74 ff ff ff 8d b4 26
00 00 00 00 83
Jun  7 04:12:01 afs1 kernel:  <3>scsi0 (1:0): rejecting I/O to offline device
Jun  7 04:12:01 afs1 kernel: ReiserFS: sdb1: warning: zam-7001: io error in reiserfs_find_entry
Jun  7 06:25:04 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device
Jun  7 06:25:04 afs1 kernel: scsi0 (1:0): rejecting I/O to offline device

Kernel .config is attached.

Have you any suggestions?

If you will need any additional information, please send me an e-mail.

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config-afs1

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11.7
# Tue May 10 08:34:58 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_IDEDISK is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA_FORCED=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=m
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID5=m
# CONFIG_MD_RAID6 is not set
CONFIG_MD_MULTIPATH=m
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_CRYPT is not set
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
# CONFIG_DM_ZERO is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_CONFIG=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_IP_TCPDIAG is not set
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
# CONFIG_IP_NF_MATCH_IPRANGE is not set
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_OWNER=m
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
# CONFIG_IP_NF_TARGET_CLASSIFY is not set
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=m
CONFIG_E100_NAPI=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-2"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=m
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

--v9Ux+11Zm5mwPlX6--
