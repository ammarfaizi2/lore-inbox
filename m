Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTGASJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTGASJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:09:34 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:51863 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S263212AbTGASIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:08:50 -0400
Date: Tue, 1 Jul 2003 20:23:11 +0200
From: Bruno Cornec <Bruno.Cornec@hp.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: sophie.pasquier@hp.com, linux-kernel@vger.kernel.org
Subject: SUMMARY: DL760 G2 issue with Hyper-Threading: Problem Solved !
Message-ID: <20030701202311.A31535@morley.grenoble.hp.com>
References: <20030630182610.H2120@morley.grenoble.hp.com> <C8C38546F90ABF408A5961FC01FDBF1901048896@fmsmsx405.fm.intel.com> <20030627092711.Q9969@morley.grenoble.hp.com> <C8C38546F90ABF408A5961FC01FDBF1901048859@fmsmsx405.fm.intel.com> <20030626161021.E9969@morley.grenoble.hp.com> <20030617192457.Q9969@morley.grenoble.hp.com> <20030626160755.D9969@morley.grenoble.hp.com> <C8C38546F90ABF408A5961FC01FDBF1901048859@fmsmsx405.fm.intel.com> <20030624190315.T9969@morley.grenoble.hp.com> <20030617192457.Q9969@morley.grenoble.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030617192457.Q9969@morley.grenoble.hp.com>
X-Humor: Linux is to Windows what early music is to military music
X-Operating-System: Linux morley.grenoble.hp.com 2.4.20-18.7
X-Current-Uptime: 5:47pm  up 4 days, 39 min,  2 users,  load average: 0.11, 0.16, 0.11
X-HP-HOWTO-URL: http://www.HyPer-Linux.org/HP-HOWTO/current
X-eurolinux: http://eurolinux.grenoble.hp.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

Here is an attempt to summarize all the actions done around that issue
to try and help solve the problem.

PROBLEM: DL760 G2 issue with Hyper-Threading (HT)

When activating HT on the machine in the BIOS, the system boots correctly
as it seems (detecting the 16 CPUs it should detect) but then it hangs 
during the remaining phases of the boot. The base distribution is SLES 8.

On my machine, I made the following tests, with the following results:
In every case HT is selected in the BIOS, CONFIG_HIGHMEM64G=y, CONFIG_HIGHMEM=y,
CONFIG_X86_PAE=y (The machine has 16GB of RAM)

The latest BIOS has been put on the system (P44 - 2003-02-18)

Kernel				config						Status
======				======						======
k_smp-2.4.19-113	apm=off acpi=off noapic		Unstable => Hang (no message)
k_smp-2.4.19-257	apm=off acpi=off noapic		Unstable => Hang (no message)
2.4.20-18.9bigmem	apm=off acpi=off noapic		Unstable => Hang (no message)
2.4.21				apm=off acpi=off noapic		Unstable => Hang (no message)
k_smp-2.4.19-113	apm=off acpi=off 			Kernel Panic during boot (*)
k_smp-2.4.19-257	apm=off acpi=off 			Kernel Panic during boot (*)
2.4.20-18.9bigmem	apm=off acpi=off 			Kernel Panic during boot (*)
2.4.21				apm=off acpi=off 			Kernel Panic during boot (*)
2.4.21-ac2			CONFIG_ACPI=n				Stable with only 8 CPUs detected
					CONFIG_X86_CLUSTERED_APIC=y
2.4.21-ac2			+CONFIG_ACPI=y alone		print kernel boots (1 line on screen)
2.4.21-ac2			CONFIG_PM=y         		Kernel Panic during boot (*)
2.4.21-ac3/4+bruno	CONFIG_PM=y         		Kernel Panic during boot (*)
                    Every ACPI MPS table in Bios gives the same
2.4.21-ac4+bruno	With attached .config		No problem !!


So it seems that to have a working system, you need:

2.4.21-ac4 + the patch sent by Venkatesh Pallipadi (attached again) + a right .config 
(attached as well) containing at least:

CONFIG_SMP=y
CONFIG_X86_CLUSTERED_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_ACPI=y
CONFIG_ACPI_HT_ONLY=y
CONFIG_ACPI_BOOT=y

And no CONFIG_PM set.

The proof:
linux:~ # cat /proc/cpuinfo | grep processor |wc -l
     16
:-))
The full boot trace is attached (trace.ok)


BTW, without your latest patch, the system is hanging as before, and as I was
able to connect another machine on the serial port, I now have a trace in 
case you were interested (attached as trace.nok).

Thanks a lot to Venkatesh Pallipadi for the time taken to solve the issue.

Bruno. 
-- 
Linux Solution Consultant         Tél: +33 476 143 278 - Fax: +33 476 146 105
HP/Intel Solution Center http://hpintelco.net Hewlett-Packard Grenoble/France
Des infos sur Linux?  http://www.HyPer-Linux.org      http://www.hp.com/linux
La musique ancienne?  http://www.musique-ancienne.org http://www.medieval.org

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bruno.patch"

--- linux-2.4.21-ac2/arch/i386/kernel/mpparse.c.org	2003-06-30 12:52:21.000000000 -0700
+++ linux-2.4.21-ac2/arch/i386/kernel/mpparse.c	2003-06-30 12:54:40.000000000 -0700
@@ -987,7 +987,10 @@
 {
 	struct mpc_config_processor processor;
 	int			boot_cpu = 0;
-	
+
+	static unsigned long apic_ver;
+	static int first_time = 1;
+
 	if (id >= MAX_APICS) {
 		printk(KERN_WARNING "Processor #%d invalid (max %d)\n",
 			id, MAX_APICS);
@@ -999,7 +1002,18 @@
 
 	processor.mpc_type = MP_PROCESSOR;
 	processor.mpc_apicid = id;
-	processor.mpc_apicver = 0x10; /* TBD: lapic version */
+
+	if (first_time) {
+		first_time = 0;
+		set_fixmap(FIX_APIC_BASE, APIC_DEFAULT_PHYS_BASE);
+		Dprintk("Local APIC ID %lx\n", apic_read(APIC_ID));
+		apic_ver = apic_read(APIC_LVR);
+		Dprintk("Local APIC Version %lx\n", apic_ver);
+		if (APIC_XAPIC_SUPPORT(apic_ver))
+			xapic_support = 1;
+	}
+	processor.mpc_apicver = apic_ver;
+	
 	processor.mpc_cpuflag = (enabled ? CPU_ENABLED : 0);
 	processor.mpc_cpuflag |= (boot_cpu ? CPU_BOOTPROCESSOR : 0);
 	processor.mpc_cpufeature = (boot_cpu_data.x86 << 8) | 

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_X86_CLUSTERED_APIC=y
# CONFIG_X86_NUMA is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_ISA is not set
# CONFIG_SCx200 is not set
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_IKCONFIG is not set
# CONFIG_PM is not set
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_HT_ONLY=y
CONFIG_ACPI_BOOT=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
CONFIG_BLK_CPQ_CISS_DA=y
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_IDEDISK is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_MEGARAID2 is not set
# CONFIG_SCSI_ATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=y
# CONFIG_FDDI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Input core support
#
# CONFIG_INPUT is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_HVC_CONSOLE is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_EXT3_FS=m
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_XFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
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
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
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
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_PANIC_MORSE is not set
# CONFIG_DEBUG_SPINLOCK is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace.ok"

Linux version 2.4.21-ac4 (root@linux) (gcc version 3.2) #5 SMP Tue Jul 1 19:34:42 CEST 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 00000000efff0000 (usable)
BIOS-e820: 00000000efff0000 - 00000000f0000000 (ACPI data)
BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
BIOS-e820: 0000000100000000 - 000000040ffff000 (usable)
15743MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4fd0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
On node 0 totalpages: 4259839
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 4030463 pages.
ACPI: RSDP (v000 HP                         ) @ 0x000f4f70
ACPI: RSDT (v001 HP     P44      00000.00001) @ 0xefff0000
ACPI: FADT (v001 HP     P44      00000.00001) @ 0xefff0040
ACPI: MADT (v001 HP     P44      00000.00001) @ 0xefff0100
ACPI: SRAT (v001 HP     P44      00000.00003) @ 0xefff01e0
ACPI: SPCR (v001 HP     P44      00000.00001) @ 0xefff0238
ACPI: DSDT (v001 HP     P44      00000.00001) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
Processor #4 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x08] enabled)
Processor #8 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x0a] enabled)
Processor #10 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x0c] enabled)
Processor #12 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x0e] enabled)
Processor #14 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x03] enabled)
Processor #3 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x05] enabled)
Processor #5 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x07] enabled)
Processor #7 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x09] enabled)
Processor #9 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0b] enabled)
Processor #11 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0d] enabled)
Processor #13 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x10] lapic_id[0x0f] enabled)
Processor #15 Pentium 4(tm) XEON(tm) APIC version 20
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
I/O APIC #8 Version 17 at 0xFEC00000.
I/O APIC #9 Version 17 at 0xFEC01000.
I/O APIC #10 Version 17 at 0xFEC02000.
Processors: 16
xAPIC support is present
Enabling APIC mode: Physical.   Using 3 I/O APICs
Kernel command line: root=/dev/cciss/c0d0p1  ide=nodma console=tty0 console=ttyS0
ide_setup: ide=nodma : Prevented DMA
Initializing CPU#0
Detected 1999.279 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 16573584k/17039356k available (1533k kernel code, 203176k reserved, 392k data, 288k init, 15859644k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 524288 (order: 9, 2097152 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU0: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
per-CPU timeslice cutoff: 1462.74 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 1
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 2/4 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 2
Intel machine check reporting enabled on CPU#2.
CPU2: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 3/6 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#3.
CPU3: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 4/8 eip 2000
Initializing CPU#4
masked ExtINT on CPU#4
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 4
Intel machine check reporting enabled on CPU#4.
CPU4: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 5/10 eip 2000
Initializing CPU#5
masked ExtINT on CPU#5
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 5
Intel machine check reporting enabled on CPU#5.
CPU5: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 6/12 eip 2000
Initializing CPU#6
masked ExtINT on CPU#6
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 6
Intel machine check reporting enabled on CPU#6.
CPU6: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 7/14 eip 2000
Initializing CPU#7
masked ExtINT on CPU#7
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 7
Intel machine check reporting enabled on CPU#7.
CPU7: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 8/1 eip 2000
Initializing CPU#8
masked ExtINT on CPU#8
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#8.
CPU8: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 9/3 eip 2000
Initializing CPU#9
masked ExtINT on CPU#9
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 1
Intel machine check reporting enabled on CPU#9.
CPU9: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 10/5 eip 2000
Initializing CPU#10
masked ExtINT on CPU#10
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 2
Intel machine check reporting enabled on CPU#10.
CPU10: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 11/7 eip 2000
Initializing CPU#11
masked ExtINT on CPU#11
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#11.
CPU11: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 12/9 eip 2000
Initializing CPU#12
masked ExtINT on CPU#12
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 4
Intel machine check reporting enabled on CPU#12.
CPU12: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 13/11 eip 2000
Initializing CPU#13
masked ExtINT on CPU#13
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 5
Intel machine check reporting enabled on CPU#13.
CPU13: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 14/13 eip 2000
Initializing CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 6
Intel machine check reporting enabled on CPU#14.
CPU14: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 15/15 eip 2000
Initializing CPU#15
masked ExtINT on CPU#15
Leaving ESR disabled.
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 7
Intel machine check reporting enabled on CPU#15.
CPU15: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Total of 16 processors activated (63950.02 BogoMIPS).
cpu_sibling_map[0] = 8
cpu_sibling_map[1] = 9
cpu_sibling_map[2] = 10
cpu_sibling_map[3] = 11
cpu_sibling_map[4] = 12
cpu_sibling_map[5] = 13
cpu_sibling_map[6] = 14
cpu_sibling_map[7] = 15
cpu_sibling_map[8] = 0
cpu_sibling_map[9] = 1
cpu_sibling_map[10] = 2
cpu_sibling_map[11] = 3
cpu_sibling_map[12] = 4
cpu_sibling_map[13] = 5
cpu_sibling_map[14] = 6
cpu_sibling_map[15] = 7
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
Setting 9 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 9 ... ok.
Setting 10 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 10 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................



.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1999.2734 MHz.
..... host bus clock speed is 99.9635 MHz.
cpu: 0, clocks: 999635, slice: 58802
CPU0<T0:999632,T1:940816,D:14,S:58802,C:999635>
cpu: 1, clocks: 999635, slice: 58802
cpu: 8, clocks: 999635, slice: 58802
cpu: 3, clocks: 999635, slice: 58802
cpu: 10, clocks: 999635, slice: 58802
cpu: 11, clocks: 999635, slice: 58802
cpu: 2, clocks: 999635, slice: 58802
cpu: 9, clocks: 999635, slice: 58802
cpu: 15, clocks: 999635, slice: 58802
cpu: 13, clocks: 999635, slice: 58802
cpu: 4, clocks: 999635, slice: 58802
cpu: 5, clocks: 999635, slice: 58802
cpu: 14, clocks: 999635, slice: 58802
cpu: 7, clocks: 999635, slice: 58802
cpu: 12, clocks: 999635, slice: 58802
cpu: 6, clocks: 999635, slice: 58802
CPU3<T0:999632,T1:764416,D:8,S:58802,C:999635>
CPU8<T0:999632,T1:470400,D:14,S:58802,C:999635>
CPU9<T0:999632,T1:411600,D:12,S:58802,C:999635>
CPU10<T0:999632,T1:352752,D:58,S:58802,C:999635>
CPU11<T0:999632,T1:294000,D:8,S:58802,C:999635>
CPU15<T0:999632,T1:58800,D:0,S:58802,C:999635>
CPU2<T0:999632,T1:823216,D:10,S:58802,C:999635>
CPU7<T0:999632,T1:529216,D:0,S:58802,C:999635>
CPU14<T0:999632,T1:117600,D:2,S:58802,C:999635>
CPU4<T0:999632,T1:705616,D:6,S:58802,C:999635>
CPU6<T0:999632,T1:588016,D:2,S:58802,C:999635>
CPU13<T0:999632,T1:176400,D:4,S:58802,C:999635>
CPU5<T0:999632,T1:646816,D:4,S:58802,C:999635>
CPU12<T0:999632,T1:235200,D:6,S:58802,C:999635>
CPU1<T0:999632,T1:882016,D:12,S:58802,C:999635>
migration_task 0 on cpu=0
migration_task 1 on cpu=1
migration_task 2 on cpu=2
migration_task 3 on cpu=3
migration_task 4 on cpu=4
migration_task 5 on cpu=5
migration_task 6 on cpu=6
migration_task 7 on cpu=7
migration_task 8 on cpu=8
migration_task 9 on cpu=9
migration_task 10 on cpu=10
migration_task 11 on cpu=11
migration_task 12 on cpu=12
migration_task 13 on cpu=13
migration_task 14 on cpu=14
migration_task 15 on cpu=15
PCI: PCI BIOS revision 2.10 entry at 0xf1135, last bus=22
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
PCI: Discovered primary peer bus 03 [IRQ]
PCI: Discovered primary peer bus 07 [IRQ]
PCI: Discovered primary peer bus 0b [IRQ]
PCI: Discovered primary peer bus 0f [IRQ]
PCI: Discovered primary peer bus 13 [IRQ]
PCI->APIC IRQ transform: (B0,I12,P0) -> 37
PCI->APIC IRQ transform: (B0,I13,P0) -> 41
PCI->APIC IRQ transform: (B0,I14,P0) -> 40
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B0,I16,P0) -> 39
PCI->APIC IRQ transform: (B0,I16,P1) -> 32
PCI->APIC IRQ transform: (B0,I16,P2) -> 38
PCI->APIC IRQ transform: (B0,I30,P0) -> 35
PCI->APIC IRQ transform: (B3,I2,P0) -> 43
PCI->APIC IRQ transform: (B3,I30,P0) -> 35
PCI->APIC IRQ transform: (B7,I30,P0) -> 35
PCI->APIC IRQ transform: (B11,I30,P0) -> 35
PCI->APIC IRQ transform: (B15,I30,P0) -> 35
PCI->APIC IRQ transform: (B19,I30,P0) -> 35
PCI: Device 00:78 not found by BIOS
PCI: Device 00:7b not found by BIOS
PCI: Device 00:b8 not found by BIOS
PCI: Device 00:c0 not found by BIOS
PCI: Device 00:c2 not found by BIOS
PCI: Device 00:c4 not found by BIOS
PCI: Device 00:c6 not found by BIOS
PCI: Device 00:c8 not found by BIOS
PCI: Device 00:ca not found by BIOS


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace.nok"

Linux version 2.4.21-ac4 (root@linux) (gcc version 3.2) #7 SMP Tue Jul 1 19:46:47 CEST 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 00000000efff0000 (usable)
BIOS-e820: 00000000efff0000 - 00000000f0000000 (ACPI data)
BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
BIOS-e820: 0000000100000000 - 000000040ffff000 (usable)
15743MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4fd0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
On node 0 totalpages: 4259839
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 4030463 pages.
ACPI: RSDP (v000 HP                         ) @ 0x000f4f70
ACPI: RSDT (v001 HP     P44      00000.00001) @ 0xefff0000
ACPI: FADT (v001 HP     P44      00000.00001) @ 0xefff0040
ACPI: MADT (v001 HP     P44      00000.00001) @ 0xefff0100
ACPI: SRAT (v001 HP     P44      00000.00003) @ 0xefff01e0
ACPI: SPCR (v001 HP     P44      00000.00001) @ 0xefff0238
ACPI: DSDT (v001 HP     P44      00000.00001) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
Processor #4 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
Processor #6 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x08] enabled)
Processor #8 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x0a] enabled)
Processor #10 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x0c] enabled)
Processor #12 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x0e] enabled)
Processor #14 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x03] enabled)
Processor #3 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x05] enabled)
Processor #5 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x07] enabled)
Processor #7 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x09] enabled)
Processor #9 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0b] enabled)
Processor #11 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0d] enabled)
Processor #13 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x10] lapic_id[0x0f] enabled)
Processor #15 Pentium 4(tm) XEON(tm) APIC version 16
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
I/O APIC #8 Version 17 at 0xFEC00000.
I/O APIC #9 Version 17 at 0xFEC01000.
I/O APIC #10 Version 17 at 0xFEC02000.
Processors: 16
xAPIC support is not present
Enabling APIC mode: Flat.       Using 3 I/O APICs
Kernel command line: root=/dev/cciss/c0d0p1  ide=nodma console=tty0 console=ttyS0
ide_setup: ide=nodma : Prevented DMA
Initializing CPU#0
Detected 1999.319 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 16573584k/17039356k available (1533k kernel code, 203176k reserved, 392k data, 288k init, 15859644k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 524288 (order: 9, 2097152 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU0: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
per-CPU timeslice cutoff: 1462.74 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 2/2 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 1
Intel machine check reporting enabled on CPU#2.
CPU2: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 3/3 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 1
Intel machine check reporting enabled on CPU#3.
CPU3: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 4/4 eip 2000
Initializing CPU#4
masked ExtINT on CPU#4
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 2
Intel machine check reporting enabled on CPU#4.
CPU4: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 5/5 eip 2000
Initializing CPU#5
masked ExtINT on CPU#5
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 2
Intel machine check reporting enabled on CPU#5.
CPU5: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 6/6 eip 2000
Initializing CPU#6
masked ExtINT on CPU#6
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#6.
CPU6: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 7/7 eip 2000
Initializing CPU#7
masked ExtINT on CPU#7
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#7.
CPU7: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 8/8 eip 2000
Initializing CPU#8
masked ExtINT on CPU#8
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 4
Intel machine check reporting enabled on CPU#8.
CPU8: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 9/9 eip 2000
Initializing CPU#9
masked ExtINT on CPU#9
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3984.58 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 4
Intel machine check reporting enabled on CPU#9.
CPU9: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 10/10 eip 2000
Initializing CPU#10
masked ExtINT on CPU#10
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 5
Intel machine check reporting enabled on CPU#10.
CPU10: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 11/11 eip 2000
Initializing CPU#11
masked ExtINT on CPU#11
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 5
Intel machine check reporting enabled on CPU#11.
CPU11: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 12/12 eip 2000
Initializing CPU#12
masked ExtINT on CPU#12
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 6
Intel machine check reporting enabled on CPU#12.
CPU12: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 13/13 eip 2000
Initializing CPU#13
masked ExtINT on CPU#13
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 6
Intel machine check reporting enabled on CPU#13.
CPU13: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 14/14 eip 2000
Initializing CPU#14
masked ExtINT on CPU#14
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 7
Intel machine check reporting enabled on CPU#14.
CPU14: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Booting processor 15/15 eip 2000
Initializing CPU#15
masked ExtINT on CPU#15
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 7
Intel machine check reporting enabled on CPU#15.
CPU15: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Total of 16 processors activated (63936.92 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
cpu_sibling_map[4] = 5
cpu_sibling_map[5] = 4
cpu_sibling_map[6] = 7
cpu_sibling_map[7] = 6
cpu_sibling_map[8] = 9
cpu_sibling_map[9] = 8
cpu_sibling_map[10] = 11
cpu_sibling_map[11] = 10
cpu_sibling_map[12] = 13
cpu_sibling_map[13] = 12
cpu_sibling_map[14] = 15
cpu_sibling_map[15] = 14
ENABLING IO-APIC IRQs
BIOS bug, IO-APIC#0 ID 8 is already used!...
Kernel panic: Max APIC ID exceeded!

In idle task - not syncing


--YiEDa0DAkWCtVeE4--
