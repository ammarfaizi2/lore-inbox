Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTIDXSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTIDXSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:18:51 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:57909 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261366AbTIDXRR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:17:17 -0400
Message-ID: <3F57C8BE.50602@sbcglobal.net>
Date: Thu, 04 Sep 2003 18:20:30 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Malte_Schr=F6der?= <MalteSch@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Promise-IDE DMA-Problem on 2.6.0-test4-mm4/5
References: <200309042302.42450.MalteSch@gmx.de>
In-Reply-To: <200309042302.42450.MalteSch@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if this is related, or even a problem.  I'm using two 
PDC20269 cards with one device per channel. I've been getting this since 
at least June, so for me this isn't a recent appearance.  I might note 
that this is only a "problem" on this drive.  My DVD, CDRW, and other 
older Maxtor drive don't report any messages when I do a "hdparm -d1" on 
them during init.  The older drive is on the primary channel as well.  
One thing I noticed is that my newer maxtor drive (hde) doesn't support 
write flushing (maybe not the right term...), while the other one (hdi) 
does.  When the drives are attached to my VIA IDE controller, I don't 
get these messages and that is when I noticed that one supports write 
flushing while the other does not (reported during boot).  The promise 
driver doesn't say anything about write flushing but maybe this 
information is useful anyway.

Sometimes the dma status is 0x21, sometimes it is 0x20.  Looking back in 
my logs this has been going on since I started out with kernel 2.5.68.  
On the older 2.5 series it would sometimes cause the system to lock, but 
that disappeared somewhere in 2.5.7x, but I don't remember for sure when 
(74?) since it was not a consistent problem.

hde: set_drive_speed_status: status=0x58 { DriveReady SeekComplete 
DataRequest }
blk: queue d7d0fc00, I/O limit 4095Mb (mask 0xffffffff)
hde: dma_timer_expiry: dma status == 0x20
hde: DMA timeout retry
PDC202XX: Primary channel reset.
hde: timeout waiting for DMA

I have the same experience where I only get this when hdparm is run 
during init, otherwise it works fine.  In both cases (init vs later) DMA 
is enabled and there does not seem to be any performance difference 
using hdparm -Tt.

-Wes-

Malte Schröder wrote:

>Hi,
>starting with the -mm4-patch I get this message
>
>blk: queue efcc8000, I/O limit 4095Mb (mask 0xffffffff)
>hde: dma_timer_expiry: dma status == 0x21
>hde: DMA timeout error
>hde: dma timeout error: status=0x50 { DriveReady SeekComplete }
>
>when doing hdparm -d1 /dev/ide/host2/bus0/target0/lun0/disc during init on 
>Debian/Sid. According to hdparm -d /dev/ide/host2/bus0/target0/lun0/disc DMA 
>is activated and the system works without problems after this.
>Oddly this does not happen when I enable DMA after the system finishes 
>booting. 
>
>My pci-devices:
># lspci
>00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
>00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
>00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
>40)
>00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
>Master IDE (rev 06)
>00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
>00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
>00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
>00:04.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
>Audio Controller (rev 50)
>00:09.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
>00:09.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 
>03)
>00:09.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port
>00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
>74)
>00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
>(rev 11)
>00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
>11)
>00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 
>02)
>01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QM [Radeon 
>9100]
>
>
># hdparm -i /dev/ide/host2/bus0/target0/lun0/disc
> 
>/dev/ide/host2/bus0/target0/lun0/disc:
> 
> Model=IC35L040AVER07-0, FwRev=ER4OA46A, SerialNo=SXPTXTS3621
> Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
> BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
> CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80418240
> IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
> PIO modes:  pio0 pio1 pio2 pio3 pio4
> DMA modes:  mdma0 mdma1 mdma2
> UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
> AdvancedPM=yes: disabled (255) WriteCache=enabled
> Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:
> 
> * signifies the current active mode
>
>
>my mm5-kernel-config:
>#
># Automatically generated make config: don't edit
>#
>CONFIG_X86=y
>CONFIG_MMU=y
>CONFIG_UID16=y
>CONFIG_GENERIC_ISA_DMA=y
> 
>#
># Code maturity level options
>#
>CONFIG_EXPERIMENTAL=y
>CONFIG_CLEAN_COMPILE=y
>CONFIG_BROKEN_ON_SMP=y
> 
>#
># General setup
>#
>CONFIG_SWAP=y
>CONFIG_SYSVIPC=y
>CONFIG_BSD_PROCESS_ACCT=y
>CONFIG_SYSCTL=y
>CONFIG_LOG_BUF_SHIFT=14
>CONFIG_IKCONFIG=y
>CONFIG_IKCONFIG_PROC=y
># CONFIG_EMBEDDED is not set
>CONFIG_KALLSYMS=y
>CONFIG_FUTEX=y
>CONFIG_EPOLL=y
>CONFIG_IOSCHED_NOOP=y
>CONFIG_IOSCHED_AS=y
>CONFIG_IOSCHED_DEADLINE=y
>CONFIG_IOSCHED_CFQ=y
> 
>#
># Loadable module support
>#
>CONFIG_MODULES=y
>CONFIG_MODULE_UNLOAD=y
>CONFIG_MODULE_FORCE_UNLOAD=y
>CONFIG_OBSOLETE_MODPARM=y
>CONFIG_MODVERSIONS=y
>CONFIG_KMOD=y
> 
>#
># Processor type and features
>#
>CONFIG_X86_PC=y
># CONFIG_X86_VOYAGER is not set
># CONFIG_X86_NUMAQ is not set
># CONFIG_X86_SUMMIT is not set
># CONFIG_X86_BIGSMP is not set
># CONFIG_X86_VISWS is not set
># CONFIG_X86_GENERICARCH is not set
># CONFIG_X86_ES7000 is not set
># CONFIG_M386 is not set
># CONFIG_M486 is not set
># CONFIG_M586 is not set
># CONFIG_M586TSC is not set
># CONFIG_M586MMX is not set
># CONFIG_M686 is not set
># CONFIG_MPENTIUMII is not set
># CONFIG_MPENTIUMIII is not set
># CONFIG_MPENTIUM4 is not set
># CONFIG_MK6 is not set
>CONFIG_MK7=y
># CONFIG_MK8 is not set
># CONFIG_MELAN is not set
># CONFIG_MCRUSOE is not set
># CONFIG_MWINCHIPC6 is not set
># CONFIG_MWINCHIP2 is not set
># CONFIG_MWINCHIP3D is not set
># CONFIG_MCYRIXIII is not set
># CONFIG_MVIAC3_2 is not set
># CONFIG_X86_GENERIC is not set
>CONFIG_X86_CMPXCHG=y
>CONFIG_X86_XADD=y
>CONFIG_X86_L1_CACHE_SHIFT=6
>CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>CONFIG_X86_WP_WORKS_OK=y
>CONFIG_X86_INVLPG=y
>CONFIG_X86_BSWAP=y
>CONFIG_X86_POPAD_OK=y
>CONFIG_X86_GOOD_APIC=y
>CONFIG_X86_INTEL_USERCOPY=y
>CONFIG_X86_USE_PPRO_CHECKSUM=y
>CONFIG_X86_USE_3DNOW=y
># CONFIG_X86_4G is not set
># CONFIG_X86_SWITCH_PAGETABLES is not set
># CONFIG_X86_4G_VM_LAYOUT is not set
># CONFIG_X86_UACCESS_INDIRECT is not set
># CONFIG_X86_HIGH_ENTRY is not set
># CONFIG_HUGETLB_PAGE is not set
>CONFIG_HPET_TIMER=y
>CONFIG_HPET_EMULATE_RTC=y
># CONFIG_SMP is not set
>CONFIG_PREEMPT=y
>CONFIG_X86_UP_APIC=y
>CONFIG_X86_UP_IOAPIC=y
>CONFIG_X86_LOCAL_APIC=y
>CONFIG_X86_IO_APIC=y
>CONFIG_X86_TSC=y
>CONFIG_X86_MCE=y
>CONFIG_X86_MCE_NONFATAL=y
># CONFIG_X86_MCE_P4THERMAL is not set
># CONFIG_TOSHIBA is not set
># CONFIG_I8K is not set
># CONFIG_MICROCODE is not set
>CONFIG_X86_MSR=y
>CONFIG_X86_CPUID=y
>CONFIG_EDD=y
>CONFIG_NOHIGHMEM=y
># CONFIG_HIGHMEM4G is not set
># CONFIG_HIGHMEM64G is not set
># CONFIG_MATH_EMULATION is not set
>CONFIG_MTRR=y
>CONFIG_HAVE_DEC_LOCK=y
> 
>#
># Power management options (ACPI, APM)
>#
>CONFIG_PM=y
>CONFIG_SOFTWARE_SUSPEND=y
> 
>#
># ACPI (Advanced Configuration and Power Interface) Support
>#
>CONFIG_ACPI_HT=y
>CONFIG_ACPI=y
>CONFIG_ACPI_BOOT=y
>CONFIG_ACPI_SLEEP=y
>CONFIG_ACPI_SLEEP_PROC_FS=y
>CONFIG_ACPI_AC=y
>CONFIG_ACPI_BATTERY=y
>CONFIG_ACPI_BUTTON=y
>CONFIG_ACPI_FAN=y
>CONFIG_ACPI_PROCESSOR=y
>CONFIG_ACPI_THERMAL=y
># CONFIG_ACPI_ASUS is not set
># CONFIG_ACPI_TOSHIBA is not set
># CONFIG_ACPI_DEBUG is not set
>CONFIG_ACPI_BUS=y
>CONFIG_ACPI_INTERPRETER=y
>CONFIG_ACPI_EC=y
>CONFIG_ACPI_POWER=y
>CONFIG_ACPI_PCI=y
>CONFIG_ACPI_SYSTEM=y
> 
>#
># APM (Advanced Power Management) BIOS Support
>#
># CONFIG_APM is not set
> 
>#
># CPU Frequency scaling
>#
># CONFIG_CPU_FREQ is not set
> 
>#
># Bus options (PCI, PCMCIA, EISA, MCA, ISA)
>#
>CONFIG_PCI=y
># CONFIG_PCI_GOBIOS is not set
># CONFIG_PCI_GODIRECT is not set
>CONFIG_PCI_GOANY=y
>CONFIG_PCI_BIOS=y
>CONFIG_PCI_DIRECT=y
># CONFIG_PCI_LEGACY_PROC is not set
>CONFIG_PCI_NAMES=y
>CONFIG_ISA=y
># CONFIG_EISA is not set
># CONFIG_MCA is not set
># CONFIG_SCx200 is not set
>CONFIG_HOTPLUG=y
> 
>#
># PCMCIA/CardBus support
>#
># CONFIG_PCMCIA is not set
>CONFIG_PCMCIA_PROBE=y
> 
>#
># PCI Hotplug Support
>#
># CONFIG_HOTPLUG_PCI is not set
> 
>#
># Executable file formats
>#
>CONFIG_BINFMT_ELF=y
>CONFIG_BINFMT_AOUT=m
>CONFIG_BINFMT_MISC=m
> 
>#
># Generic Driver Options
>#
># CONFIG_FW_LOADER is not set
> 
>#
># Memory Technology Devices (MTD)
>#
># CONFIG_MTD is not set
> 
>#
># Parallel port support
>#
>CONFIG_PARPORT=m
>CONFIG_PARPORT_PC=m
>CONFIG_PARPORT_PC_CML1=m
># CONFIG_PARPORT_SERIAL is not set
>CONFIG_PARPORT_PC_FIFO=y
>CONFIG_PARPORT_PC_SUPERIO=y
># CONFIG_PARPORT_OTHER is not set
>CONFIG_PARPORT_1284=y
> 
>#
># Plug and Play support
>#
>CONFIG_PNP=y
># CONFIG_PNP_DEBUG is not set
> 
>#
># Protocols
>#
>CONFIG_ISAPNP=y
># CONFIG_PNPBIOS is not set
> 
>#
># Block devices
>#
>CONFIG_BLK_DEV_FD=y
># CONFIG_BLK_DEV_XD is not set
># CONFIG_PARIDE is not set
># CONFIG_BLK_CPQ_DA is not set
># CONFIG_BLK_CPQ_CISS_DA is not set
># CONFIG_BLK_DEV_DAC960 is not set
># CONFIG_BLK_DEV_UMEM is not set
>CONFIG_BLK_DEV_LOOP=m
>CONFIG_BLK_DEV_CRYPTOLOOP=m
>CONFIG_BLK_DEV_NBD=m
>CONFIG_BLK_DEV_RAM=y
>CONFIG_BLK_DEV_RAM_SIZE=4096
>CONFIG_BLK_DEV_INITRD=y
># CONFIG_LBD is not set
> 
>#
># ATA/ATAPI/MFM/RLL support
>#
>CONFIG_IDE=y
>CONFIG_BLK_DEV_IDE=y
> 
>#
># Please see Documentation/ide.txt for help/info on IDE drives
>#
># CONFIG_BLK_DEV_HD_IDE is not set
>CONFIG_BLK_DEV_IDEDISK=y
># CONFIG_IDEDISK_MULTI_MODE is not set
># CONFIG_IDEDISK_STROKE is not set
>CONFIG_BLK_DEV_IDECD=m
>CONFIG_BLK_DEV_IDETAPE=m
>CONFIG_BLK_DEV_IDEFLOPPY=m
>CONFIG_BLK_DEV_IDESCSI=m
>CONFIG_IDE_TASK_IOCTL=y
>CONFIG_IDE_TASKFILE_IO=y
> 
>#
># IDE chipset support/bugfixes
>#
># CONFIG_BLK_DEV_CMD640 is not set
># CONFIG_BLK_DEV_IDEPNP is not set
>CONFIG_BLK_DEV_IDEPCI=y
>CONFIG_IDEPCI_SHARE_IRQ=y
>CONFIG_BLK_DEV_OFFBOARD=y
>CONFIG_BLK_DEV_GENERIC=y
># CONFIG_BLK_DEV_OPTI621 is not set
># CONFIG_BLK_DEV_RZ1000 is not set
>CONFIG_BLK_DEV_IDEDMA_PCI=y
>CONFIG_BLK_DEV_IDE_TCQ=y
># CONFIG_BLK_DEV_IDE_TCQ_DEFAULT is not set
>CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
># CONFIG_BLK_DEV_IDEDMA_FORCED is not set
>CONFIG_IDEDMA_PCI_AUTO=y
># CONFIG_IDEDMA_ONLYDISK is not set
># CONFIG_IDEDMA_PCI_WIP is not set
>CONFIG_BLK_DEV_ADMA=y
># CONFIG_BLK_DEV_AEC62XX is not set
># CONFIG_BLK_DEV_ALI15X3 is not set
># CONFIG_BLK_DEV_AMD74XX is not set
># CONFIG_BLK_DEV_CMD64X is not set
># CONFIG_BLK_DEV_TRIFLEX is not set
># CONFIG_BLK_DEV_CY82C693 is not set
># CONFIG_BLK_DEV_CS5520 is not set
># CONFIG_BLK_DEV_CS5530 is not set
># CONFIG_BLK_DEV_HPT34X is not set
># CONFIG_BLK_DEV_HPT366 is not set
># CONFIG_BLK_DEV_SC1200 is not set
># CONFIG_BLK_DEV_PIIX is not set
># CONFIG_BLK_DEV_NS87415 is not set
>CONFIG_BLK_DEV_PDC202XX_OLD=y
>CONFIG_PDC202XX_BURST=y
>CONFIG_BLK_DEV_PDC202XX_NEW=y
>CONFIG_PDC202XX_FORCE=y
># CONFIG_BLK_DEV_SVWKS is not set
># CONFIG_BLK_DEV_SIIMAGE is not set
># CONFIG_BLK_DEV_SIS5513 is not set
># CONFIG_BLK_DEV_SLC90E66 is not set
># CONFIG_BLK_DEV_TRM290 is not set
>CONFIG_BLK_DEV_VIA82CXXX=y
># CONFIG_IDE_CHIPSETS is not set
>CONFIG_BLK_DEV_IDEDMA=y
># CONFIG_IDEDMA_IVB is not set
>CONFIG_IDEDMA_AUTO=y
># CONFIG_DMA_NONPCI is not set
># CONFIG_BLK_DEV_HD is not set
> 
>#
># SCSI device support
>#
>CONFIG_SCSI=m
> 
>#
># SCSI support type (disk, tape, CD-ROM)
>#
>CONFIG_BLK_DEV_SD=m
># CONFIG_CHR_DEV_ST is not set
># CONFIG_CHR_DEV_OSST is not set
>CONFIG_BLK_DEV_SR=m
># CONFIG_BLK_DEV_SR_VENDOR is not set
>CONFIG_CHR_DEV_SG=m
> 
>#
># Some SCSI devices (e.g. CD jukebox) support multiple LUNs
>#
>CONFIG_SCSI_MULTI_LUN=y
>CONFIG_SCSI_REPORT_LUNS=y
>CONFIG_SCSI_CONSTANTS=y
># CONFIG_SCSI_LOGGING is not set
> 
>#
># SCSI low-level drivers
>#
># CONFIG_BLK_DEV_3W_XXXX_RAID is not set
># CONFIG_SCSI_7000FASST is not set
># CONFIG_SCSI_ACARD is not set
># CONFIG_SCSI_AHA152X is not set
># CONFIG_SCSI_AHA1542 is not set
># CONFIG_SCSI_AACRAID is not set
># CONFIG_SCSI_AIC7XXX is not set
># CONFIG_SCSI_AIC7XXX_OLD is not set
># CONFIG_SCSI_AIC79XX is not set
># CONFIG_SCSI_ADVANSYS is not set
># CONFIG_SCSI_IN2000 is not set
># CONFIG_SCSI_MEGARAID is not set
># CONFIG_SCSI_BUSLOGIC is not set
># CONFIG_SCSI_CPQFCTS is not set
># CONFIG_SCSI_DMX3191D is not set
># CONFIG_SCSI_DTC3280 is not set
># CONFIG_SCSI_EATA is not set
># CONFIG_SCSI_EATA_PIO is not set
># CONFIG_SCSI_FUTURE_DOMAIN is not set
># CONFIG_SCSI_GDTH is not set
># CONFIG_SCSI_GENERIC_NCR5380 is not set
># CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
># CONFIG_SCSI_IPS is not set
># CONFIG_SCSI_INIA100 is not set
># CONFIG_SCSI_PPA is not set
># CONFIG_SCSI_IMM is not set
># CONFIG_SCSI_NCR53C406A is not set
># CONFIG_SCSI_SYM53C8XX_2 is not set
># CONFIG_SCSI_SYM53C8XX is not set
># CONFIG_SCSI_PAS16 is not set
># CONFIG_SCSI_PSI240I is not set
># CONFIG_SCSI_QLOGIC_FAS is not set
># CONFIG_SCSI_QLOGIC_ISP is not set
># CONFIG_SCSI_QLOGIC_FC is not set
># CONFIG_SCSI_QLOGIC_1280 is not set
># CONFIG_SCSI_SYM53C416 is not set
># CONFIG_SCSI_DC395x is not set
># CONFIG_SCSI_T128 is not set
># CONFIG_SCSI_U14_34F is not set
># CONFIG_SCSI_ULTRASTOR is not set
># CONFIG_SCSI_NSP32 is not set
># CONFIG_SCSI_DEBUG is not set
># CONFIG_SCSI_FERAL_ISP is not set
> 
>#
># Old CD-ROM drivers (not SCSI, not IDE)
>#
># CONFIG_CD_NO_IDESCSI is not set
> 
>#
># Multi-device support (RAID and LVM)
>#
>CONFIG_MD=y
>CONFIG_BLK_DEV_MD=m
>CONFIG_MD_LINEAR=m
>CONFIG_MD_RAID0=m
>CONFIG_MD_RAID1=m
>CONFIG_MD_RAID5=m
>CONFIG_MD_MULTIPATH=m
>CONFIG_BLK_DEV_DM=m
># CONFIG_DM_IOCTL_V4 is not set
> 
>#
># Fusion MPT device support
>#
># CONFIG_FUSION is not set
> 
>#
># IEEE 1394 (FireWire) support (EXPERIMENTAL)
>#
>CONFIG_IEEE1394=m
> 
>#
># Subsystem Options
>#
># CONFIG_IEEE1394_VERBOSEDEBUG is not set
># CONFIG_IEEE1394_OUI_DB is not set
> 
>#
># Device Drivers
>#
># CONFIG_IEEE1394_PCILYNX is not set
>CONFIG_IEEE1394_OHCI1394=m
> 
>#
># Protocol Drivers
>#
>CONFIG_IEEE1394_VIDEO1394=m
>CONFIG_IEEE1394_SBP2=m
>CONFIG_IEEE1394_SBP2_PHYS_DMA=y
>CONFIG_IEEE1394_ETH1394=m
>CONFIG_IEEE1394_DV1394=m
>CONFIG_IEEE1394_RAWIO=m
>CONFIG_IEEE1394_CMP=m
>CONFIG_IEEE1394_AMDTP=m
> 
>#
># I2O device support
>#
>CONFIG_I2O=m
>CONFIG_I2O_PCI=m
>CONFIG_I2O_BLOCK=m
>CONFIG_I2O_SCSI=m
>CONFIG_I2O_PROC=m
> 
>#
># Networking support
>#
>CONFIG_NET=y
> 
>#
># Networking options
>#
>CONFIG_PACKET=y
>CONFIG_PACKET_MMAP=y
>CONFIG_NETLINK_DEV=y
>CONFIG_UNIX=y
>CONFIG_NET_KEY=m
>CONFIG_INET=y
>CONFIG_IP_MULTICAST=y
># CONFIG_IP_ADVANCED_ROUTER is not set
># CONFIG_IP_PNP is not set
># CONFIG_NET_IPIP is not set
>CONFIG_NET_IPGRE=m
># CONFIG_NET_IPGRE_BROADCAST is not set
># CONFIG_IP_MROUTE is not set
># CONFIG_ARPD is not set
>CONFIG_INET_ECN=y
>CONFIG_SYN_COOKIES=y
>CONFIG_INET_AH=m
>CONFIG_INET_ESP=m
>CONFIG_INET_IPCOMP=m
>CONFIG_IPV6=m
>CONFIG_IPV6_PRIVACY=y
>CONFIG_INET6_AH=m
>CONFIG_INET6_ESP=m
>CONFIG_INET6_IPCOMP=m
>CONFIG_IPV6_TUNNEL=m
># CONFIG_DECNET is not set
># CONFIG_BRIDGE is not set
># CONFIG_NETFILTER is not set
>CONFIG_XFRM=y
>CONFIG_XFRM_USER=m
> 
>#
># SCTP Configuration (EXPERIMENTAL)
>#
>CONFIG_IPV6_SCTP__=m
>CONFIG_IP_SCTP=m
># CONFIG_SCTP_ADLER32 is not set
># CONFIG_SCTP_DBG_MSG is not set
># CONFIG_SCTP_DBG_OBJCNT is not set
># CONFIG_SCTP_HMAC_NONE is not set
>CONFIG_SCTP_HMAC_SHA1=y
># CONFIG_SCTP_HMAC_MD5 is not set
># CONFIG_ATM is not set
>CONFIG_VLAN_8021Q=m
># CONFIG_LLC is not set
># CONFIG_X25 is not set
># CONFIG_LAPB is not set
># CONFIG_NET_DIVERT is not set
># CONFIG_ECONET is not set
># CONFIG_WAN_ROUTER is not set
># CONFIG_NET_FASTROUTE is not set
># CONFIG_NET_HW_FLOWCONTROL is not set
> 
>#
># QoS and/or fair queueing
>#
># CONFIG_NET_SCHED is not set
> 
>#
># Network testing
>#
># CONFIG_NET_PKTGEN is not set
>CONFIG_NETDEVICES=y
> 
>#
># ARCnet devices
>#
># CONFIG_ARCNET is not set
>CONFIG_DUMMY=m
>CONFIG_BONDING=m
># CONFIG_EQUALIZER is not set
>CONFIG_TUN=m
># CONFIG_ETHERTAP is not set
># CONFIG_NET_SB1000 is not set
> 
>#
># Ethernet (10 or 100Mbit)
>#
>CONFIG_NET_ETHERNET=y
>CONFIG_MII=m
># CONFIG_HAPPYMEAL is not set
># CONFIG_SUNGEM is not set
>CONFIG_NET_VENDOR_3COM=y
># CONFIG_EL1 is not set
># CONFIG_EL2 is not set
># CONFIG_ELPLUS is not set
># CONFIG_EL16 is not set
># CONFIG_EL3 is not set
># CONFIG_3C515 is not set
>CONFIG_VORTEX=m
># CONFIG_TYPHOON is not set
># CONFIG_LANCE is not set
># CONFIG_NET_VENDOR_SMC is not set
># CONFIG_NET_VENDOR_RACAL is not set
> 
>#
># Tulip family network device support
>#
># CONFIG_NET_TULIP is not set
># CONFIG_AT1700 is not set
># CONFIG_DEPCA is not set
># CONFIG_HP100 is not set
># CONFIG_NET_ISA is not set
>CONFIG_NET_PCI=y
># CONFIG_PCNET32 is not set
># CONFIG_AMD8111_ETH is not set
># CONFIG_ADAPTEC_STARFIRE is not set
># CONFIG_AC3200 is not set
># CONFIG_APRICOT is not set
># CONFIG_B44 is not set
># CONFIG_CS89x0 is not set
># CONFIG_DGRS is not set
># CONFIG_EEPRO100 is not set
># CONFIG_E100 is not set
># CONFIG_FEALNX is not set
># CONFIG_NATSEMI is not set
># CONFIG_NE2K_PCI is not set
># CONFIG_8139CP is not set
>CONFIG_8139TOO=m
># CONFIG_8139TOO_PIO is not set
># CONFIG_8139TOO_TUNE_TWISTER is not set
># CONFIG_8139TOO_8129 is not set
># CONFIG_8139_OLD_RX_RESET is not set
>CONFIG_SIS900=m
># CONFIG_EPIC100 is not set
># CONFIG_SUNDANCE is not set
># CONFIG_TLAN is not set
>CONFIG_VIA_RHINE=m
># CONFIG_VIA_RHINE_MMIO is not set
># CONFIG_NET_POCKET is not set
> 
>#
># Ethernet (1000 Mbit)
>#
># CONFIG_ACENIC is not set
># CONFIG_DL2K is not set
># CONFIG_E1000 is not set
># CONFIG_NS83820 is not set
># CONFIG_HAMACHI is not set
># CONFIG_YELLOWFIN is not set
># CONFIG_R8169 is not set
># CONFIG_SIS190 is not set
># CONFIG_SK98LIN is not set
># CONFIG_TIGON3 is not set
> 
>#
># Ethernet (10000 Mbit)
>#
># CONFIG_IXGB is not set
># CONFIG_FDDI is not set
># CONFIG_HIPPI is not set
># CONFIG_PLIP is not set
>CONFIG_PPP=m
>CONFIG_PPP_MULTILINK=y
>CONFIG_PPP_FILTER=y
>CONFIG_PPP_ASYNC=m
>CONFIG_PPP_SYNC_TTY=m
>CONFIG_PPP_DEFLATE=m
>CONFIG_PPP_BSDCOMP=m
>CONFIG_PPPOE=m
># CONFIG_SLIP is not set
> 
>#
># Wireless LAN (non-hamradio)
>#
># CONFIG_NET_RADIO is not set
> 
>#
># Token Ring devices (depends on LLC=y)
>#
># CONFIG_NET_FC is not set
># CONFIG_RCPCI is not set
># CONFIG_SHAPER is not set
> 
>#
># Wan interfaces
>#
># CONFIG_WAN is not set
> 
>#
># Amateur Radio support
>#
># CONFIG_HAMRADIO is not set
> 
>#
># IrDA (infrared) support
>#
># CONFIG_IRDA is not set
> 
>#
># ISDN subsystem
>#
># CONFIG_ISDN_BOOL is not set
> 
>#
># Telephony Support
>#
># CONFIG_PHONE is not set
> 
>#
># Input device support
>#
>CONFIG_INPUT=y
> 
>#
># Userland interfaces
>#
>CONFIG_INPUT_MOUSEDEV=y
>CONFIG_INPUT_MOUSEDEV_PSAUX=y
>CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
>CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
>CONFIG_INPUT_JOYDEV=m
># CONFIG_INPUT_TSDEV is not set
>CONFIG_INPUT_EVDEV=m
># CONFIG_INPUT_EVBUG is not set
> 
>#
># Input I/O drivers
>#
># CONFIG_GAMEPORT is not set
>CONFIG_SOUND_GAMEPORT=y
>CONFIG_SERIO=y
>CONFIG_SERIO_I8042=y
>CONFIG_SERIO_SERPORT=y
># CONFIG_SERIO_CT82C710 is not set
># CONFIG_SERIO_PARKBD is not set
># CONFIG_SERIO_PCIPS2 is not set
> 
>#
># Input Device Drivers
>#
>CONFIG_INPUT_KEYBOARD=y
>CONFIG_KEYBOARD_ATKBD=y
># CONFIG_KEYBOARD_SUNKBD is not set
># CONFIG_KEYBOARD_XTKBD is not set
># CONFIG_KEYBOARD_NEWTON is not set
>CONFIG_INPUT_MOUSE=y
>CONFIG_MOUSE_PS2=m
># CONFIG_MOUSE_PS2_SYNAPTICS is not set
># CONFIG_MOUSE_SERIAL is not set
># CONFIG_MOUSE_INPORT is not set
># CONFIG_MOUSE_LOGIBM is not set
># CONFIG_MOUSE_PC110PAD is not set
>CONFIG_INPUT_JOYSTICK=y
>CONFIG_JOYSTICK_IFORCE=m
>CONFIG_JOYSTICK_IFORCE_USB=y
># CONFIG_JOYSTICK_IFORCE_232 is not set
># CONFIG_JOYSTICK_WARRIOR is not set
># CONFIG_JOYSTICK_MAGELLAN is not set
># CONFIG_JOYSTICK_SPACEORB is not set
># CONFIG_JOYSTICK_SPACEBALL is not set
># CONFIG_JOYSTICK_STINGER is not set
># CONFIG_JOYSTICK_TWIDDLER is not set
>CONFIG_JOYSTICK_DB9=m
># CONFIG_JOYSTICK_GAMECON is not set
># CONFIG_JOYSTICK_TURBOGRAFX is not set
># CONFIG_INPUT_JOYDUMP is not set
># CONFIG_INPUT_TOUCHSCREEN is not set
>CONFIG_INPUT_MISC=y
>CONFIG_INPUT_PCSPKR=y
>CONFIG_INPUT_UINPUT=m
> 
>#
># Character devices
>#
>CONFIG_VT=y
>CONFIG_VT_CONSOLE=y
>CONFIG_HW_CONSOLE=y
># CONFIG_SERIAL_NONSTANDARD is not set
> 
>#
># Serial drivers
>#
>CONFIG_SERIAL_8250=y
>CONFIG_SERIAL_8250_CONSOLE=y
>CONFIG_SERIAL_8250_ACPI=y
># CONFIG_SERIAL_8250_EXTENDED is not set
> 
>#
># Non-8250 serial port support
>#
>CONFIG_SERIAL_CORE=y
>CONFIG_SERIAL_CORE_CONSOLE=y
>CONFIG_UNIX98_PTYS=y
>CONFIG_UNIX98_PTY_COUNT=256
>CONFIG_PRINTER=m
># CONFIG_LP_CONSOLE is not set
>CONFIG_PPDEV=m
># CONFIG_TIPAR is not set
> 
>#
># I2C support
>#
>CONFIG_I2C=m
>CONFIG_I2C_ALGOBIT=m
># CONFIG_I2C_PROSAVAGE is not set
># CONFIG_I2C_PHILIPSPAR is not set
># CONFIG_I2C_ELV is not set
># CONFIG_I2C_VELLEMAN is not set
># CONFIG_SCx200_ACB is not set
># CONFIG_I2C_ALGOPCF is not set
>CONFIG_I2C_CHARDEV=m
> 
>#
># I2C Hardware Sensors Mainboard support
>#
># CONFIG_I2C_ALI1535 is not set
># CONFIG_I2C_ALI15X3 is not set
># CONFIG_I2C_AMD756 is not set
># CONFIG_I2C_AMD8111 is not set
># CONFIG_I2C_I801 is not set
>CONFIG_I2C_ISA=m
># CONFIG_I2C_NFORCE2 is not set
># CONFIG_I2C_PIIX4 is not set
># CONFIG_I2C_SIS96X is not set
>CONFIG_I2C_VIAPRO=m
> 
>#
># I2C Hardware Sensors Chip support
>#
># CONFIG_SENSORS_ADM1021 is not set
># CONFIG_SENSORS_IT87 is not set
># CONFIG_SENSORS_LM75 is not set
># CONFIG_SENSORS_LM85 is not set
># CONFIG_SENSORS_LM78 is not set
># CONFIG_SENSORS_VIA686A is not set
>CONFIG_SENSORS_W83781D=m
>CONFIG_I2C_SENSOR=m
> 
>#
># Mice
>#
># CONFIG_BUSMOUSE is not set
># CONFIG_QIC02_TAPE is not set
> 
>#
># IPMI
>#
>CONFIG_IPMI_HANDLER=m
>CONFIG_IPMI_PANIC_EVENT=y
>CONFIG_IPMI_DEVICE_INTERFACE=m
>CONFIG_IPMI_KCS=m
>CONFIG_IPMI_WATCHDOG=m
> 
>#
># Watchdog Cards
>#
>CONFIG_WATCHDOG=y
># CONFIG_WATCHDOG_NOWAYOUT is not set
>CONFIG_SOFT_WATCHDOG=m
># CONFIG_WDT is not set
># CONFIG_WDTPCI is not set
># CONFIG_PCWATCHDOG is not set
># CONFIG_ACQUIRE_WDT is not set
># CONFIG_ADVANTECH_WDT is not set
># CONFIG_EUROTECH_WDT is not set
># CONFIG_IB700_WDT is not set
># CONFIG_I810_TCO is not set
># CONFIG_MIXCOMWD is not set
># CONFIG_SCx200_WDT is not set
># CONFIG_60XX_WDT is not set
># CONFIG_W83877F_WDT is not set
># CONFIG_MACHZ_WDT is not set
># CONFIG_SC520_WDT is not set
># CONFIG_AMD7XX_TCO is not set
># CONFIG_ALIM7101_WDT is not set
># CONFIG_ALIM1535_WDT is not set
># CONFIG_SC1200_WDT is not set
># CONFIG_WAFER_WDT is not set
># CONFIG_CPU5_WDT is not set
>CONFIG_HW_RANDOM=y
>CONFIG_NVRAM=y
>CONFIG_RTC=y
># CONFIG_DTLK is not set
># CONFIG_R3964 is not set
># CONFIG_APPLICOM is not set
># CONFIG_SONYPI is not set
> 
>#
># Ftape, the floppy tape device driver
>#
># CONFIG_FTAPE is not set
>CONFIG_AGP=m
># CONFIG_AGP_ALI is not set
># CONFIG_AGP_ATI is not set
># CONFIG_AGP_AMD is not set
># CONFIG_AGP_AMD_8151 is not set
># CONFIG_AGP_INTEL is not set
># CONFIG_AGP_NVIDIA is not set
># CONFIG_AGP_SIS is not set
># CONFIG_AGP_SWORKS is not set
>CONFIG_AGP_VIA=m
>CONFIG_DRM=y
># CONFIG_DRM_TDFX is not set
># CONFIG_DRM_GAMMA is not set
># CONFIG_DRM_R128 is not set
>CONFIG_DRM_RADEON=m
># CONFIG_DRM_MGA is not set
># CONFIG_MWAVE is not set
># CONFIG_RAW_DRIVER is not set
>CONFIG_HANGCHECK_TIMER=m
> 
>#
># Multimedia devices
>#
>CONFIG_VIDEO_DEV=m
> 
>#
># Video For Linux
>#
> 
>#
># Video Adapters
>#
>CONFIG_VIDEO_BT848=m
># CONFIG_VIDEO_PMS is not set
># CONFIG_VIDEO_BWQCAM is not set
># CONFIG_VIDEO_CQCAM is not set
># CONFIG_VIDEO_W9966 is not set
># CONFIG_VIDEO_CPIA is not set
># CONFIG_VIDEO_SAA5249 is not set
># CONFIG_TUNER_3036 is not set
># CONFIG_VIDEO_STRADIS is not set
># CONFIG_VIDEO_ZORAN is not set
># CONFIG_VIDEO_SAA7134 is not set
># CONFIG_VIDEO_MXB is not set
># CONFIG_VIDEO_DPC is not set
># CONFIG_VIDEO_HEXIUM_ORION is not set
># CONFIG_VIDEO_HEXIUM_GEMINI is not set
> 
>#
># Radio Adapters
>#
># CONFIG_RADIO_CADET is not set
># CONFIG_RADIO_RTRACK is not set
># CONFIG_RADIO_RTRACK2 is not set
># CONFIG_RADIO_AZTECH is not set
># CONFIG_RADIO_GEMTEK is not set
># CONFIG_RADIO_GEMTEK_PCI is not set
># CONFIG_RADIO_MAXIRADIO is not set
># CONFIG_RADIO_MAESTRO is not set
># CONFIG_RADIO_SF16FMI is not set
># CONFIG_RADIO_TERRATEC is not set
># CONFIG_RADIO_TRUST is not set
># CONFIG_RADIO_TYPHOON is not set
># CONFIG_RADIO_ZOLTRIX is not set
> 
>#
># Digital Video Broadcasting Devices
>#
># CONFIG_DVB is not set
>CONFIG_VIDEO_VIDEOBUF=m
>CONFIG_VIDEO_TUNER=m
>CONFIG_VIDEO_BUF=m
>CONFIG_VIDEO_BTCX=m
> 
>#
># File systems
>#
>CONFIG_EXT2_FS=y
>CONFIG_EXT2_FS_XATTR=y
>CONFIG_EXT2_FS_POSIX_ACL=y
>CONFIG_EXT2_FS_SECURITY=y
>CONFIG_EXT3_FS=y
>CONFIG_EXT3_FS_XATTR=y
>CONFIG_EXT3_FS_POSIX_ACL=y
>CONFIG_EXT3_FS_SECURITY=y
>CONFIG_JBD=y
># CONFIG_JBD_DEBUG is not set
>CONFIG_FS_MBCACHE=y
>CONFIG_REISERFS_FS=y
># CONFIG_REISERFS_CHECK is not set
># CONFIG_REISERFS_PROC_INFO is not set
># CONFIG_JFS_FS is not set
>CONFIG_FS_POSIX_ACL=y
># CONFIG_XFS_FS is not set
>CONFIG_MINIX_FS=m
>CONFIG_ROMFS_FS=m
># CONFIG_QUOTA is not set
># CONFIG_AUTOFS_FS is not set
>CONFIG_AUTOFS4_FS=m
> 
>#
># CD-ROM/DVD Filesystems
>#
>CONFIG_ISO9660_FS=m
>CONFIG_JOLIET=y
>CONFIG_ZISOFS=y
>CONFIG_ZISOFS_FS=m
>CONFIG_UDF_FS=m
> 
>#
># DOS/FAT/NT Filesystems
>#
>CONFIG_FAT_FS=m
>CONFIG_MSDOS_FS=m
>CONFIG_VFAT_FS=m
>CONFIG_NTFS_FS=m
>CONFIG_NTFS_DEBUG=y
>CONFIG_NTFS_RW=y
> 
>#
># Pseudo filesystems
>#
>CONFIG_PROC_FS=y
>CONFIG_DEVFS_FS=y
>CONFIG_DEVFS_MOUNT=y
># CONFIG_DEVFS_DEBUG is not set
>CONFIG_DEVPTS_FS=y
>CONFIG_DEVPTS_FS_XATTR=y
>CONFIG_DEVPTS_FS_SECURITY=y
>CONFIG_TMPFS=y
>CONFIG_RAMFS=y
> 
>#
># Miscellaneous filesystems
>#
># CONFIG_ADFS_FS is not set
>CONFIG_AFFS_FS=m
># CONFIG_HFS_FS is not set
># CONFIG_BEFS_FS is not set
># CONFIG_BFS_FS is not set
># CONFIG_EFS_FS is not set
>CONFIG_CRAMFS=m
># CONFIG_VXFS_FS is not set
># CONFIG_HPFS_FS is not set
># CONFIG_QNX4FS_FS is not set
># CONFIG_SYSV_FS is not set
># CONFIG_UFS_FS is not set
> 
>#
># Network File Systems
>#
>CONFIG_NFS_FS=m
>CONFIG_NFS_V3=y
>CONFIG_NFS_V4=y
>CONFIG_NFS_DIRECTIO=y
>CONFIG_NFSD=m
>CONFIG_NFSD_V3=y
>CONFIG_NFSD_V4=y
>CONFIG_NFSD_TCP=y
>CONFIG_LOCKD=m
>CONFIG_LOCKD_V4=y
>CONFIG_EXPORTFS=m
>CONFIG_SUNRPC=m
>CONFIG_SUNRPC_GSS=m
>CONFIG_RPCSEC_GSS_KRB5=m
>CONFIG_SMB_FS=m
># CONFIG_SMB_NLS_DEFAULT is not set
>CONFIG_CIFS=m
># CONFIG_NCP_FS is not set
>CONFIG_CODA_FS=m
>CONFIG_INTERMEZZO_FS=m
>CONFIG_AFS_FS=m
>CONFIG_RXRPC=m
> 
>#
># Partition Types
>#
>CONFIG_PARTITION_ADVANCED=y
># CONFIG_ACORN_PARTITION is not set
># CONFIG_OSF_PARTITION is not set
># CONFIG_AMIGA_PARTITION is not set
># CONFIG_ATARI_PARTITION is not set
># CONFIG_MAC_PARTITION is not set
>CONFIG_MSDOS_PARTITION=y
># CONFIG_BSD_DISKLABEL is not set
># CONFIG_MINIX_SUBPARTITION is not set
># CONFIG_SOLARIS_X86_PARTITION is not set
># CONFIG_UNIXWARE_DISKLABEL is not set
>CONFIG_LDM_PARTITION=y
># CONFIG_LDM_DEBUG is not set
># CONFIG_NEC98_PARTITION is not set
># CONFIG_SGI_PARTITION is not set
># CONFIG_ULTRIX_PARTITION is not set
># CONFIG_SUN_PARTITION is not set
># CONFIG_EFI_PARTITION is not set
>CONFIG_SMB_NLS=y
>CONFIG_NLS=y
> 
>#
># Native Language Support
>#
>CONFIG_NLS_DEFAULT="utf8"
>CONFIG_NLS_CODEPAGE_437=y
># CONFIG_NLS_CODEPAGE_737 is not set
># CONFIG_NLS_CODEPAGE_775 is not set
>CONFIG_NLS_CODEPAGE_850=y
># CONFIG_NLS_CODEPAGE_852 is not set
># CONFIG_NLS_CODEPAGE_855 is not set
># CONFIG_NLS_CODEPAGE_857 is not set
># CONFIG_NLS_CODEPAGE_860 is not set
># CONFIG_NLS_CODEPAGE_861 is not set
># CONFIG_NLS_CODEPAGE_862 is not set
># CONFIG_NLS_CODEPAGE_863 is not set
># CONFIG_NLS_CODEPAGE_864 is not set
># CONFIG_NLS_CODEPAGE_865 is not set
># CONFIG_NLS_CODEPAGE_866 is not set
># CONFIG_NLS_CODEPAGE_869 is not set
># CONFIG_NLS_CODEPAGE_936 is not set
># CONFIG_NLS_CODEPAGE_950 is not set
># CONFIG_NLS_CODEPAGE_932 is not set
># CONFIG_NLS_CODEPAGE_949 is not set
># CONFIG_NLS_CODEPAGE_874 is not set
># CONFIG_NLS_ISO8859_8 is not set
># CONFIG_NLS_CODEPAGE_1250 is not set
># CONFIG_NLS_CODEPAGE_1251 is not set
>CONFIG_NLS_ISO8859_1=y
># CONFIG_NLS_ISO8859_2 is not set
># CONFIG_NLS_ISO8859_3 is not set
># CONFIG_NLS_ISO8859_4 is not set
># CONFIG_NLS_ISO8859_5 is not set
># CONFIG_NLS_ISO8859_6 is not set
># CONFIG_NLS_ISO8859_7 is not set
># CONFIG_NLS_ISO8859_9 is not set
># CONFIG_NLS_ISO8859_13 is not set
># CONFIG_NLS_ISO8859_14 is not set
>CONFIG_NLS_ISO8859_15=y
># CONFIG_NLS_KOI8_R is not set
># CONFIG_NLS_KOI8_U is not set
>CONFIG_NLS_UTF8=y
> 
>#
># Graphics support
>#
>CONFIG_FB=y
># CONFIG_FB_CYBER2000 is not set
># CONFIG_FB_ASILIANT is not set
># CONFIG_FB_IMSTT is not set
># CONFIG_FB_VGA16 is not set
>CONFIG_FB_VESA=y
>CONFIG_VIDEO_SELECT=y
># CONFIG_FB_HGA is not set
># CONFIG_FB_RIVA is not set
># CONFIG_FB_MATROX is not set
>CONFIG_FB_RADEON=y
># CONFIG_FB_ATY128 is not set
># CONFIG_FB_ATY is not set
># CONFIG_FB_SIS is not set
># CONFIG_FB_NEOMAGIC is not set
># CONFIG_FB_3DFX is not set
># CONFIG_FB_VOODOO1 is not set
># CONFIG_FB_TRIDENT is not set
># CONFIG_FB_VIRTUAL is not set
> 
>#
># Console display driver support
>#
>CONFIG_VGA_CONSOLE=y
># CONFIG_MDA_CONSOLE is not set
>CONFIG_DUMMY_CONSOLE=y
>CONFIG_FRAMEBUFFER_CONSOLE=y
>CONFIG_PCI_CONSOLE=y
># CONFIG_FONTS is not set
>CONFIG_FONT_8x8=y
>CONFIG_FONT_8x16=y
> 
>#
># Logo configuration
>#
>CONFIG_LOGO=y
>CONFIG_LOGO_LINUX_MONO=y
>CONFIG_LOGO_LINUX_VGA16=y
>CONFIG_LOGO_LINUX_CLUT224=y
> 
>#
># Sound
>#
>CONFIG_SOUND=m
> 
>#
># Advanced Linux Sound Architecture
>#
>CONFIG_SND=m
>CONFIG_SND_SEQUENCER=m
>CONFIG_SND_SEQ_DUMMY=m
>CONFIG_SND_OSSEMUL=y
>CONFIG_SND_MIXER_OSS=m
>CONFIG_SND_PCM_OSS=m
>CONFIG_SND_SEQUENCER_OSS=y
>CONFIG_SND_RTCTIMER=m
># CONFIG_SND_VERBOSE_PRINTK is not set
># CONFIG_SND_DEBUG is not set
> 
>#
># Generic devices
>#
>CONFIG_SND_DUMMY=m
>CONFIG_SND_VIRMIDI=m
># CONFIG_SND_MTPAV is not set
># CONFIG_SND_SERIAL_U16550 is not set
># CONFIG_SND_MPU401 is not set
> 
>#
># ISA devices
>#
># CONFIG_SND_AD1816A is not set
># CONFIG_SND_AD1848 is not set
># CONFIG_SND_CS4231 is not set
># CONFIG_SND_CS4232 is not set
># CONFIG_SND_CS4236 is not set
># CONFIG_SND_ES968 is not set
># CONFIG_SND_ES1688 is not set
># CONFIG_SND_ES18XX is not set
># CONFIG_SND_GUSCLASSIC is not set
># CONFIG_SND_GUSEXTREME is not set
># CONFIG_SND_GUSMAX is not set
># CONFIG_SND_INTERWAVE is not set
># CONFIG_SND_INTERWAVE_STB is not set
># CONFIG_SND_OPTI92X_AD1848 is not set
># CONFIG_SND_OPTI92X_CS4231 is not set
># CONFIG_SND_OPTI93X is not set
># CONFIG_SND_SB8 is not set
># CONFIG_SND_SB16 is not set
># CONFIG_SND_SBAWE is not set
># CONFIG_SND_WAVEFRONT is not set
># CONFIG_SND_ALS100 is not set
># CONFIG_SND_AZT2320 is not set
># CONFIG_SND_CMI8330 is not set
># CONFIG_SND_DT019X is not set
># CONFIG_SND_OPL3SA2 is not set
># CONFIG_SND_SGALAXY is not set
># CONFIG_SND_SSCAPE is not set
> 
>#
># PCI devices
>#
># CONFIG_SND_ALI5451 is not set
># CONFIG_SND_AZT3328 is not set
>CONFIG_SND_CS46XX=m
>CONFIG_SND_CS46XX_NEW_DSP=y
># CONFIG_SND_CS4281 is not set
>CONFIG_SND_EMU10K1=m
># CONFIG_SND_KORG1212 is not set
># CONFIG_SND_NM256 is not set
># CONFIG_SND_RME32 is not set
># CONFIG_SND_RME96 is not set
># CONFIG_SND_RME9652 is not set
># CONFIG_SND_HDSP is not set
># CONFIG_SND_TRIDENT is not set
># CONFIG_SND_YMFPCI is not set
># CONFIG_SND_ALS4000 is not set
># CONFIG_SND_CMIPCI is not set
># CONFIG_SND_ENS1370 is not set
># CONFIG_SND_ENS1371 is not set
># CONFIG_SND_ES1938 is not set
># CONFIG_SND_ES1968 is not set
># CONFIG_SND_MAESTRO3 is not set
># CONFIG_SND_FM801 is not set
># CONFIG_SND_ICE1712 is not set
># CONFIG_SND_ICE1724 is not set
># CONFIG_SND_INTEL8X0 is not set
># CONFIG_SND_SONICVIBES is not set
># CONFIG_SND_VIA82XX is not set
># CONFIG_SND_VX222 is not set
> 
>#
># ALSA USB devices
>#
>CONFIG_SND_USB_AUDIO=m
> 
>#
># Open Sound System
>#
># CONFIG_SOUND_PRIME is not set
> 
>#
># USB support
>#
>CONFIG_USB=m
># CONFIG_USB_DEBUG is not set
> 
>#
># Miscellaneous USB options
>#
>CONFIG_USB_DEVICEFS=y
>CONFIG_USB_BANDWIDTH=y
>CONFIG_USB_DYNAMIC_MINORS=y
> 
>#
># USB Host Controller Drivers
>#
># CONFIG_USB_EHCI_HCD is not set
># CONFIG_USB_OHCI_HCD is not set
>CONFIG_USB_UHCI_HCD=m
> 
>#
># USB Device Class drivers
>#
>CONFIG_USB_AUDIO=m
># CONFIG_USB_BLUETOOTH_TTY is not set
>CONFIG_USB_MIDI=m
>CONFIG_USB_ACM=m
>CONFIG_USB_PRINTER=m
>CONFIG_USB_STORAGE=m
># CONFIG_USB_STORAGE_DEBUG is not set
>CONFIG_USB_STORAGE_DATAFAB=y
>CONFIG_USB_STORAGE_FREECOM=y
>CONFIG_USB_STORAGE_ISD200=y
>CONFIG_USB_STORAGE_DPCM=y
>CONFIG_USB_STORAGE_HP8200e=y
>CONFIG_USB_STORAGE_SDDR09=y
>CONFIG_USB_STORAGE_SDDR55=y
>CONFIG_USB_STORAGE_JUMPSHOT=y
> 
>#
># USB Human Interface Devices (HID)
>#
>CONFIG_USB_HID=m
>CONFIG_USB_HIDINPUT=y
>CONFIG_HID_FF=y
>CONFIG_HID_PID=y
># CONFIG_LOGITECH_FF is not set
># CONFIG_THRUSTMASTER_FF is not set
>CONFIG_USB_HIDDEV=y
> 
>#
># USB HID Boot Protocol drivers
>#
>CONFIG_USB_KBD=m
>CONFIG_USB_MOUSE=m
># CONFIG_USB_AIPTEK is not set
># CONFIG_USB_WACOM is not set
># CONFIG_USB_KBTAB is not set
># CONFIG_USB_POWERMATE is not set
>CONFIG_USB_XPAD=m
> 
>#
># USB Imaging devices
>#
>CONFIG_USB_MDC800=m
>CONFIG_USB_SCANNER=m
>CONFIG_USB_MICROTEK=m
>CONFIG_USB_HPUSBSCSI=m
> 
>#
># USB Multimedia devices
>#
># CONFIG_USB_DABUSB is not set
># CONFIG_USB_VICAM is not set
># CONFIG_USB_DSBR is not set
># CONFIG_USB_IBMCAM is not set
># CONFIG_USB_KONICAWC is not set
># CONFIG_USB_OV511 is not set
>CONFIG_USB_PWC=m
># CONFIG_USB_SE401 is not set
># CONFIG_USB_STV680 is not set
> 
>#
># USB Network adaptors
>#
>CONFIG_USB_AX8817X_STANDALONE=m
>CONFIG_USB_CATC=m
>CONFIG_USB_KAWETH=m
>CONFIG_USB_PEGASUS=m
>CONFIG_USB_RTL8150=m
>CONFIG_USB_USBNET=m
> 
>#
># USB Host-to-Host Cables
>#
>CONFIG_USB_AN2720=y
>CONFIG_USB_BELKIN=y
>CONFIG_USB_GENESYS=y
>CONFIG_USB_NET1080=y
>CONFIG_USB_PL2301=y
> 
>#
># Intelligent USB Devices/Gadgets
>#
>CONFIG_USB_ARMLINUX=y
>CONFIG_USB_EPSON2888=y
>CONFIG_USB_ZAURUS=y
>CONFIG_USB_CDCETHER=y
> 
>#
># USB Network Adapters
>#
>CONFIG_USB_AX8817X=y
> 
>#
># USB port drivers
>#
>CONFIG_USB_USS720=m
> 
>#
># USB Serial Converter support
>#
>CONFIG_USB_SERIAL=m
>CONFIG_USB_SERIAL_GENERIC=y
># CONFIG_USB_SERIAL_BELKIN is not set
># CONFIG_USB_SERIAL_WHITEHEAT is not set
># CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
># CONFIG_USB_SERIAL_EMPEG is not set
># CONFIG_USB_SERIAL_FTDI_SIO is not set
>CONFIG_USB_SERIAL_VISOR=m
># CONFIG_USB_SERIAL_IPAQ is not set
>CONFIG_USB_SERIAL_IR=m
># CONFIG_USB_SERIAL_EDGEPORT is not set
># CONFIG_USB_SERIAL_EDGEPORT_TI is not set
># CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
># CONFIG_USB_SERIAL_KEYSPAN is not set
># CONFIG_USB_SERIAL_KLSI is not set
># CONFIG_USB_SERIAL_KOBIL_SCT is not set
># CONFIG_USB_SERIAL_MCT_U232 is not set
># CONFIG_USB_SERIAL_PL2303 is not set
># CONFIG_USB_SERIAL_SAFE is not set
># CONFIG_USB_SERIAL_CYBERJACK is not set
># CONFIG_USB_SERIAL_XIRCOM is not set
># CONFIG_USB_SERIAL_OMNINET is not set
> 
>#
># USB Miscellaneous drivers
>#
># CONFIG_USB_EMI26 is not set
># CONFIG_USB_TIGL is not set
># CONFIG_USB_AUERSWALD is not set
># CONFIG_USB_RIO500 is not set
># CONFIG_USB_BRLVGER is not set
># CONFIG_USB_LCD is not set
># CONFIG_USB_TEST is not set
># CONFIG_USB_GADGET is not set
> 
>#
># Bluetooth support
>#
># CONFIG_BT is not set
> 
>#
># Profiling support
>#
># CONFIG_PROFILING is not set
> 
>#
># Kernel hacking
>#
>CONFIG_DEBUG_KERNEL=y
># CONFIG_DEBUG_STACKOVERFLOW is not set
># CONFIG_DEBUG_SLAB is not set
># CONFIG_DEBUG_IOVIRT is not set
>CONFIG_MAGIC_SYSRQ=y
># CONFIG_DEBUG_SPINLOCK is not set
># CONFIG_DEBUG_PAGEALLOC is not set
># CONFIG_SPINLINE is not set
># CONFIG_DEBUG_INFO is not set
># CONFIG_DEBUG_SPINLOCK_SLEEP is not set
># CONFIG_KGDB is not set
># CONFIG_FRAME_POINTER is not set
>CONFIG_X86_EXTRA_IRQS=y
>CONFIG_X86_FIND_SMP_CONFIG=y
>CONFIG_X86_MPPARSE=y
> 
>#
># Security options
>#
># CONFIG_SECURITY is not set
> 
>#
># Cryptographic options
>#
>CONFIG_CRYPTO=y
>CONFIG_CRYPTO_HMAC=y
>CONFIG_CRYPTO_NULL=m
>CONFIG_CRYPTO_MD4=m
>CONFIG_CRYPTO_MD5=m
>CONFIG_CRYPTO_SHA1=m
>CONFIG_CRYPTO_SHA256=m
>CONFIG_CRYPTO_SHA512=m
>CONFIG_CRYPTO_DES=m
>CONFIG_CRYPTO_BLOWFISH=m
>CONFIG_CRYPTO_TWOFISH=m
>CONFIG_CRYPTO_SERPENT=m
>CONFIG_CRYPTO_AES=m
>CONFIG_CRYPTO_CAST5=m
>CONFIG_CRYPTO_CAST6=m
>CONFIG_CRYPTO_DEFLATE=m
># CONFIG_CRYPTO_TEST is not set
> 
>#
># Library routines
>#
>CONFIG_CRC32=m
>CONFIG_ZLIB_INFLATE=m
>CONFIG_ZLIB_DEFLATE=m
>CONFIG_X86_BIOS_REBOOT=y
>
>
>  
>

