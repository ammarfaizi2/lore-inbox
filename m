Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTFTCHv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 22:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTFTCHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 22:07:51 -0400
Received: from fmr02.intel.com ([192.55.52.25]:13276 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262153AbTFTCH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 22:07:28 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780E040A0D@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'mochel@osdl.org'" <mochel@osdl.org>,
       "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.72] Fix boot deadlock on MTRR main.c:ipi_handler
Date: Thu, 19 Jun 2003 19:20:35 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C336D2.882257D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C336D2.882257D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi All

Stomped over this one this morning; tried to boot=20
2.5.72 (config attached) into my 2xP3 Coppermine=20
933 MHz and it would get stuck just after printing=20
the mttr banner.=20

The NMI watchdog would kick in and print a dump=20
pointing to arch/i386/kernel/cpu/mtrr/main.c:ipi_handler:

NMI Watchdog detected LOCKUP on CPU1, eip c0113b70, registers:
CPU:    1
EIP:    0060:[<c0113b70>]    Not tainted
EFLAGS: 00000082
EIP is at ipi_handler+0x60/0x80
eax: c014b2fe   ebx: c2bf5f60   ecx: 000002ff   edx: 00000000
esi: 00000086   edi: c2bf2000   ebp: c2bf3f5c   esp: c2bf3f44
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=3Dc2bf2000 task=3Dc2bf72d0)
Stack: c0464228 00000046 c0495088 00000001 c2bf2000 00000000 c2bf3f70
c0118412=20
       c2bf5f60 c01072a0 c2bf2000 c2bf3fac c010a50e c01072a0 00000000
c2bf2000=20
       c2bf2000 c2bf2000 c2bf3fac 00000000 0000007b c2bf007b fffffffb
c01072d0=20
Call Trace:
 [<c0118412>] smp_call_function_interrupt+0x42/0xa0
 [<c01072a0>] default_idle+0x0/0x40
 [<c010a50e>] call_function_interrupt+0x1a/0x20
 [<c01072a0>] default_idle+0x0/0x40
 [<c01072d0>] default_idle+0x30/0x40
 [<c010736a>] cpu_idle+0x4a/0x60
 [<c012532d>] printk+0x1dd/0x290

Code: f3 90 8b 43 04 85 c0 75 f7 56 9d 83 c4 10 5b 5e 5d c3 a1 44=20
console shuts up ...

Sooo .. decided to do the binary search thingie and tracked
it down to patch-2.5.70-bk15-bk15.gz, change set 1.28=20
(http://linux.bkbits.net:8080/linux-2.5/diffs/arch/i386/kernel/cpu/mtrr/=
main
.c@1.28?nav=3Dindex.html|tags|ChangeSet@1.1215.18.33..|cset@1.1215.114.=
28),

where mtrr_init() is changed from being a core_initcall to be a
subsys_initcall(). Reverting that changes Fixes It For Me (tm)
both in 2.5.70-bk16 and 2.5.72. No adversities seen so far.

Please apply:

--- arch/i386/kernel/cpu/mtrr/main.c~	2003-06-16 21:19:39.000000000 =
-0700
+++ arch/i386/kernel/cpu/mtrr/main.c	2003-06-19 18:52:38.000000000 =
-0700
@@ -701,5 +701,5 @@
     "write-back",               /* 6 */
 };
=20
-subsys_initcall(mtrr_init);
+core_initcall(mtrr_init);

I=F1aky P=E9rez-Gonz=E1lez -- Not speaking for Intel -- all opinions =
are my own
(and my fault)



------_=_NextPart_000_01C336D2.882257D0
Content-Type: application/octet-stream;
	name="config-2.5.72"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config-2.5.72"

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_LOG_BUF_SHIFT=3D17=0A=
# CONFIG_EMBEDDED is not set=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
# CONFIG_MODULE_FORCE_UNLOAD is not set=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
CONFIG_X86_PC=3Dy=0A=
# CONFIG_X86_VOYAGER is not set=0A=
# CONFIG_X86_NUMAQ is not set=0A=
# CONFIG_X86_SUMMIT is not set=0A=
# CONFIG_X86_BIGSMP is not set=0A=
# CONFIG_X86_VISWS is not set=0A=
# CONFIG_X86_GENERICARCH is not set=0A=
# CONFIG_X86_ES7000 is not set=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
# CONFIG_M686 is not set=0A=
# CONFIG_MPENTIUMII is not set=0A=
CONFIG_MPENTIUMIII=3Dy=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
# CONFIG_MK7 is not set=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MELAN is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
# CONFIG_MVIAC3_2 is not set=0A=
# CONFIG_X86_GENERIC is not set=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D5=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_INTEL_USERCOPY=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
CONFIG_HUGETLB_PAGE=3Dy=0A=
CONFIG_SMP=3Dy=0A=
CONFIG_NR_CPUS=3D2=0A=
CONFIG_PREEMPT=3Dy=0A=
CONFIG_X86_LOCAL_APIC=3Dy=0A=
CONFIG_X86_IO_APIC=3Dy=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_X86_MCE_NONFATAL is not set=0A=
# CONFIG_X86_MCE_P4THERMAL is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
CONFIG_MICROCODE=3Dy=0A=
CONFIG_X86_MSR=3Dy=0A=
CONFIG_X86_CPUID=3Dy=0A=
# CONFIG_EDD is not set=0A=
# CONFIG_NOHIGHMEM is not set=0A=
CONFIG_HIGHMEM4G=3Dy=0A=
# CONFIG_HIGHMEM64G is not set=0A=
CONFIG_HIGHMEM=3Dy=0A=
CONFIG_HIGHPTE=3Dy=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
CONFIG_PM=3Dy=0A=
# CONFIG_SOFTWARE_SUSPEND is not set=0A=
=0A=
#=0A=
# ACPI Support=0A=
#=0A=
CONFIG_ACPI=3Dy=0A=
# CONFIG_ACPI_HT_ONLY is not set=0A=
CONFIG_ACPI_BOOT=3Dy=0A=
CONFIG_ACPI_AC=3Dy=0A=
CONFIG_ACPI_BATTERY=3Dy=0A=
CONFIG_ACPI_BUTTON=3Dy=0A=
CONFIG_ACPI_FAN=3Dy=0A=
CONFIG_ACPI_PROCESSOR=3Dy=0A=
CONFIG_ACPI_THERMAL=3Dy=0A=
# CONFIG_ACPI_TOSHIBA is not set=0A=
# CONFIG_ACPI_DEBUG is not set=0A=
CONFIG_ACPI_BUS=3Dy=0A=
CONFIG_ACPI_INTERPRETER=3Dy=0A=
CONFIG_ACPI_EC=3Dy=0A=
CONFIG_ACPI_POWER=3Dy=0A=
CONFIG_ACPI_PCI=3Dy=0A=
CONFIG_ACPI_SYSTEM=3Dy=0A=
# CONFIG_APM is not set=0A=
=0A=
#=0A=
# CPU Frequency scaling=0A=
#=0A=
# CONFIG_CPU_FREQ is not set=0A=
=0A=
#=0A=
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)=0A=
#=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_LEGACY_PROC=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
CONFIG_ISA=3Dy=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_SCx200 is not set=0A=
CONFIG_HOTPLUG=3Dy=0A=
=0A=
#=0A=
# PCMCIA/CardBus support=0A=
#=0A=
# CONFIG_PCMCIA is not set=0A=
CONFIG_PCMCIA_PROBE=3Dy=0A=
=0A=
#=0A=
# PCI Hotplug Support=0A=
#=0A=
# CONFIG_HOTPLUG_PCI is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_KCORE_ELF=3Dy=0A=
# CONFIG_KCORE_AOUT is not set=0A=
CONFIG_BINFMT_AOUT=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
CONFIG_PARPORT=3Dm=0A=
CONFIG_PARPORT_PC=3Dm=0A=
CONFIG_PARPORT_PC_CML1=3Dm=0A=
CONFIG_PARPORT_SERIAL=3Dm=0A=
CONFIG_PARPORT_PC_FIFO=3Dy=0A=
CONFIG_PARPORT_PC_SUPERIO=3Dy=0A=
# CONFIG_PARPORT_OTHER is not set=0A=
CONFIG_PARPORT_1284=3Dy=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
# CONFIG_PNP_NAMES is not set=0A=
# CONFIG_PNP_DEBUG is not set=0A=
=0A=
#=0A=
# Protocols=0A=
#=0A=
# CONFIG_ISAPNP is not set=0A=
# CONFIG_PNPBIOS is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dm=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
# CONFIG_BLK_DEV_LOOP is not set=0A=
CONFIG_BLK_DEV_NBD=3Dm=0A=
# CONFIG_BLK_DEV_RAM is not set=0A=
# CONFIG_BLK_DEV_INITRD is not set=0A=
# CONFIG_LBD is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
=0A=
#=0A=
# IDE, ATA and ATAPI Block devices=0A=
#=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_IDEDISK_MULTI_MODE=3Dy=0A=
# CONFIG_IDEDISK_STROKE is not set=0A=
CONFIG_BLK_DEV_IDECD=3Dy=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
# CONFIG_BLK_DEV_IDESCSI is not set=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
CONFIG_IDE_TASKFILE_IO=3Dy=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
# CONFIG_BLK_DEV_CMD640 is not set=0A=
# CONFIG_BLK_DEV_IDEPNP is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_BLK_DEV_GENERIC=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDE_TCQ is not set=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
CONFIG_BLK_DEV_IDEDMA_FORCED=3Dy=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
CONFIG_IDEDMA_PCI_WIP=3Dy=0A=
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set=0A=
CONFIG_BLK_DEV_ADMA=3Dy=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5520 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
CONFIG_BLK_DEV_PIIX=3Dy=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
# CONFIG_BLK_DEV_RZ1000 is not set=0A=
CONFIG_BLK_DEV_SVWKS=3Dy=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_IDE_CHIPSETS is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_BLK_DEV_IDE_MODES=3Dy=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
CONFIG_SCSI=3Dy=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dy=0A=
CONFIG_CHR_DEV_ST=3Dm=0A=
CONFIG_CHR_DEV_OSST=3Dm=0A=
CONFIG_BLK_DEV_SR=3Dy=0A=
CONFIG_BLK_DEV_SR_VENDOR=3Dy=0A=
CONFIG_CHR_DEV_SG=3Dm=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
CONFIG_SCSI_MULTI_LUN=3Dy=0A=
# CONFIG_SCSI_REPORT_LUNS is not set=0A=
CONFIG_SCSI_CONSTANTS=3Dy=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_7000FASST is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AHA152X is not set=0A=
# CONFIG_SCSI_AHA1542 is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
CONFIG_SCSI_AIC7XXX=3Dy=0A=
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D253=0A=
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000=0A=
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set=0A=
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set=0A=
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set=0A=
CONFIG_AIC7XXX_DEBUG_MASK=3D0=0A=
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_AIC79XX is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_IN2000 is not set=0A=
# CONFIG_SCSI_AM53C974 is not set=0A=
# CONFIG_SCSI_MEGARAID is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_CPQFCTS is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_DTC3280 is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380 is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_PPA is not set=0A=
# CONFIG_SCSI_IMM is not set=0A=
# CONFIG_SCSI_NCR53C406A is not set=0A=
# CONFIG_SCSI_NCR53C7xx is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_NCR53C8XX is not set=0A=
CONFIG_SCSI_SYM53C8XX=3Dy=0A=
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=3D4=0A=
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=3D32=0A=
CONFIG_SCSI_NCR53C8XX_SYNC=3D20=0A=
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set=0A=
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set=0A=
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set=0A=
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set=0A=
# CONFIG_SCSI_PAS16 is not set=0A=
# CONFIG_SCSI_PCI2000 is not set=0A=
# CONFIG_SCSI_PCI2220I is not set=0A=
# CONFIG_SCSI_PSI240I is not set=0A=
# CONFIG_SCSI_QLOGIC_FAS is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
# CONFIG_SCSI_SEAGATE is not set=0A=
# CONFIG_SCSI_SYM53C416 is not set=0A=
# CONFIG_SCSI_DC395x is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_T128 is not set=0A=
# CONFIG_SCSI_U14_34F is not set=0A=
# CONFIG_SCSI_ULTRASTOR is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Networking support=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
CONFIG_NETLINK_DEV=3Dm=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
CONFIG_UNIX=3Dy=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
CONFIG_INET_ECN=3Dy=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
# CONFIG_INET_IPCOMP is not set=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
# CONFIG_IP_NF_CONNTRACK is not set=0A=
# CONFIG_IP_NF_QUEUE is not set=0A=
# CONFIG_IP_NF_IPTABLES is not set=0A=
# CONFIG_IP_NF_ARPTABLES is not set=0A=
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set=0A=
# CONFIG_IP_NF_COMPAT_IPFWADM is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_XFRM_USER is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
CONFIG_IPV6_SCTP__=3Dy=0A=
CONFIG_IP_SCTP=3Dm=0A=
# CONFIG_SCTP_ADLER32 is not set=0A=
CONFIG_SCTP_DBG_MSG=3Dy=0A=
CONFIG_SCTP_DBG_OBJCNT=3Dy=0A=
CONFIG_SCTP_HMAC_NONE=3Dy=0A=
# CONFIG_SCTP_HMAC_SHA1 is not set=0A=
# CONFIG_SCTP_HMAC_MD5 is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
CONFIG_DUMMY=3Dm=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dy=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
# CONFIG_NET_TULIP is not set=0A=
# CONFIG_AT1700 is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_ISA is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_AMD8111_ETH is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_AC3200 is not set=0A=
# CONFIG_APRICOT is not set=0A=
# CONFIG_B44 is not set=0A=
# CONFIG_CS89x0 is not set=0A=
# CONFIG_DGRS is not set=0A=
CONFIG_EEPRO100=3Dy=0A=
# CONFIG_EEPRO100_PIO is not set=0A=
# CONFIG_E100 is not set=0A=
# CONFIG_FEALNX is not set=0A=
# CONFIG_NATSEMI is not set=0A=
# CONFIG_NE2K_PCI is not set=0A=
# CONFIG_8139CP is not set=0A=
# CONFIG_8139TOO is not set=0A=
# CONFIG_SIS900 is not set=0A=
# CONFIG_EPIC100 is not set=0A=
# CONFIG_SUNDANCE is not set=0A=
# CONFIG_TLAN is not set=0A=
# CONFIG_VIA_RHINE is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PLIP is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices (depends on LLC=3Dy)=0A=
#=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN_BOOL is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
# CONFIG_INPUT_EVDEV is not set=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input I/O drivers=0A=
#=0A=
# CONFIG_GAMEPORT is not set=0A=
CONFIG_SOUND_GAMEPORT=3Dy=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_SERIO_I8042=3Dy=0A=
CONFIG_SERIO_SERPORT=3Dy=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_PARKBD is not set=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dy=0A=
# CONFIG_MOUSE_PS2_SYNAPTICS is not set=0A=
# CONFIG_MOUSE_SERIAL is not set=0A=
# CONFIG_MOUSE_INPORT is not set=0A=
# CONFIG_MOUSE_LOGIBM is not set=0A=
# CONFIG_MOUSE_PC110PAD is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
CONFIG_INPUT_MISC=3Dy=0A=
CONFIG_INPUT_PCSPKR=3Dy=0A=
# CONFIG_INPUT_UINPUT is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_HW_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dy=0A=
CONFIG_SERIAL_8250_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_SERIAL_CORE_CONSOLE=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
# CONFIG_PRINTER is not set=0A=
# CONFIG_PPDEV is not set=0A=
# CONFIG_TIPAR is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
CONFIG_I2C=3Dy=0A=
CONFIG_I2C_ALGOBIT=3Dy=0A=
# CONFIG_I2C_PHILIPSPAR is not set=0A=
CONFIG_I2C_ELV=3Dy=0A=
CONFIG_I2C_VELLEMAN=3Dy=0A=
# CONFIG_SCx200_ACB is not set=0A=
CONFIG_I2C_ALGOPCF=3Dy=0A=
# CONFIG_I2C_ELEKTOR is not set=0A=
CONFIG_I2C_CHARDEV=3Dy=0A=
=0A=
#=0A=
# I2C Hardware Sensors Mainboard support=0A=
#=0A=
# CONFIG_I2C_ALI15X3 is not set=0A=
# CONFIG_I2C_AMD756 is not set=0A=
# CONFIG_I2C_AMD8111 is not set=0A=
# CONFIG_I2C_I801 is not set=0A=
# CONFIG_I2C_ISA is not set=0A=
# CONFIG_I2C_PIIX4 is not set=0A=
CONFIG_I2C_SIS96X=3Dm=0A=
CONFIG_I2C_VIAPRO=3Dm=0A=
=0A=
#=0A=
# I2C Hardware Sensors Chip support=0A=
#=0A=
# CONFIG_SENSORS_ADM1021 is not set=0A=
CONFIG_SENSORS_IT87=3Dm=0A=
# CONFIG_SENSORS_LM75 is not set=0A=
CONFIG_SENSORS_LM85=3Dm=0A=
# CONFIG_SENSORS_VIA686A is not set=0A=
# CONFIG_SENSORS_W83781D is not set=0A=
CONFIG_I2C_SENSOR=3Dm=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
CONFIG_HW_RANDOM=3Dy=0A=
CONFIG_NVRAM=3Dy=0A=
CONFIG_RTC=3Dy=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
CONFIG_AGP=3Dy=0A=
# CONFIG_AGP_ALI is not set=0A=
# CONFIG_AGP_AMD is not set=0A=
# CONFIG_AGP_AMD_8151 is not set=0A=
# CONFIG_AGP_INTEL is not set=0A=
# CONFIG_AGP_NVIDIA is not set=0A=
# CONFIG_AGP_SIS is not set=0A=
CONFIG_AGP_SWORKS=3Dy=0A=
# CONFIG_AGP_VIA is not set=0A=
CONFIG_DRM=3Dy=0A=
# CONFIG_DRM_TDFX is not set=0A=
# CONFIG_DRM_GAMMA is not set=0A=
CONFIG_DRM_R128=3Dy=0A=
# CONFIG_DRM_RADEON is not set=0A=
# CONFIG_DRM_MGA is not set=0A=
# CONFIG_MWAVE is not set=0A=
CONFIG_RAW_DRIVER=3Dy=0A=
CONFIG_HANGCHECK_TIMER=3Dy=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dy=0A=
CONFIG_EXT2_FS_XATTR=3Dy=0A=
CONFIG_EXT2_FS_POSIX_ACL=3Dy=0A=
# CONFIG_EXT2_FS_SECURITY is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_EXT3_FS_XATTR=3Dy=0A=
CONFIG_EXT3_FS_POSIX_ACL=3Dy=0A=
# CONFIG_EXT3_FS_SECURITY is not set=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
CONFIG_FS_POSIX_ACL=3Dy=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
CONFIG_AUTOFS4_FS=3Dy=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
CONFIG_ZISOFS=3Dy=0A=
CONFIG_ZISOFS_FS=3Dy=0A=
CONFIG_UDF_FS=3Dy=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dm=0A=
CONFIG_MSDOS_FS=3Dm=0A=
CONFIG_VFAT_FS=3Dm=0A=
# CONFIG_NTFS_FS is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_DEVFS_FS=3Dy=0A=
# CONFIG_DEVFS_MOUNT is not set=0A=
# CONFIG_DEVFS_DEBUG is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_DEVPTS_FS_XATTR is not set=0A=
CONFIG_TMPFS=3Dy=0A=
# CONFIG_HUGETLBFS is not set=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dy=0A=
CONFIG_NFS_V3=3Dy=0A=
# CONFIG_NFS_V4 is not set=0A=
CONFIG_NFSD=3Dy=0A=
CONFIG_NFSD_V3=3Dy=0A=
# CONFIG_NFSD_V4 is not set=0A=
# CONFIG_NFSD_TCP is not set=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_LOCKD_V4=3Dy=0A=
CONFIG_EXPORTFS=3Dy=0A=
CONFIG_SUNRPC=3Dy=0A=
# CONFIG_SUNRPC_GSS is not set=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
# CONFIG_NLS_CODEPAGE_437 is not set=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
# CONFIG_NLS_ISO8859_1 is not set=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
# CONFIG_NLS_ISO8859_15 is not set=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
# CONFIG_NLS_UTF8 is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
# CONFIG_VIDEO_SELECT is not set=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
# CONFIG_MDA_CONSOLE is not set=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
# CONFIG_USB is not set=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BT is not set=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
CONFIG_PROFILING=3Dy=0A=
CONFIG_OPROFILE=3Dy=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
CONFIG_DEBUG_STACKOVERFLOW=3Dy=0A=
CONFIG_DEBUG_SLAB=3Dy=0A=
# CONFIG_DEBUG_IOVIRT is not set=0A=
CONFIG_MAGIC_SYSRQ=3Dy=0A=
CONFIG_DEBUG_SPINLOCK=3Dy=0A=
CONFIG_DEBUG_HIGHMEM=3Dy=0A=
CONFIG_KALLSYMS=3Dy=0A=
CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy=0A=
CONFIG_FRAME_POINTER=3Dy=0A=
CONFIG_X86_EXTRA_IRQS=3Dy=0A=
CONFIG_X86_FIND_SMP_CONFIG=3Dy=0A=
CONFIG_X86_MPPARSE=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
# CONFIG_CRYPTO_HMAC is not set=0A=
# CONFIG_CRYPTO_NULL is not set=0A=
# CONFIG_CRYPTO_MD4 is not set=0A=
# CONFIG_CRYPTO_MD5 is not set=0A=
# CONFIG_CRYPTO_SHA1 is not set=0A=
# CONFIG_CRYPTO_SHA256 is not set=0A=
# CONFIG_CRYPTO_SHA512 is not set=0A=
# CONFIG_CRYPTO_DES is not set=0A=
# CONFIG_CRYPTO_BLOWFISH is not set=0A=
# CONFIG_CRYPTO_TWOFISH is not set=0A=
# CONFIG_CRYPTO_SERPENT is not set=0A=
# CONFIG_CRYPTO_AES is not set=0A=
CONFIG_CRYPTO_DEFLATE=3Dm=0A=
# CONFIG_CRYPTO_TEST is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC32=3Dy=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dm=0A=
CONFIG_X86_SMP=3Dy=0A=
CONFIG_X86_HT=3Dy=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=
CONFIG_X86_TRAMPOLINE=3Dy=0A=

------_=_NextPart_000_01C336D2.882257D0--
