Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUBKW4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUBKW4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:56:09 -0500
Received: from mail.tmr.com ([216.238.38.203]:17170 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266237AbUBKWys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:54:48 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
Date: 11 Feb 2004 22:54:03 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <c0ebqb$6cn$1@gatekeeper.tmr.com>
References: <402A4B52.1080800@centrum.cz>
X-Trace: gatekeeper.tmr.com 1076540043 6551 192.168.12.62 (11 Feb 2004 22:54:03 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <402A4B52.1080800@centrum.cz>,
Michal Kwolek  <miho@centrum.cz> wrote:

| I've got a reproducible oops when using cryptoloop on vanilla 2.6.0,
| 2.6.1 and 2.6.2 (2.4.* works fine).
| 
| Way to reproduce:
| dd if=/dev/urandom of=crypto bs=1024 count=some_size
| losetup -e some_cipher /dev/loop0 crypto
| #Any of those commands causes oops and hard lockup:
| cp /dev/loop0 /dev/null
| mkreiserfs /dev/loop0
| mkfs.ext2 /dev/loop0
| 
| Loop without cryptoapi works fine:
| dd if=/dev/urandom of=crypto bs=1024 count=some_size
| losetup /dev/loop0 crypto
| cp /dev/loop0 /dev/null
| #ok, no oops

You have something else going on here (hardware?), I do this on a
regular basis, although I call it mke2fs when I make the f/s. No
problem yet, using aes, and doing it to create a nice device I can save
and use without overmuch worry.

| Sometimes it writes 10KB sometimes 10MB before it oopses. It may be just
| coincidence but without HT enabled it lived longer. As it locks hard 
| after oops I don't have oops messages in log. I have written down some:
| 
| 1.
| init: panic: Segmentation violation at 0x40126A83! Sleeping for 30 sec...
| 
| 2.
| Unable to handle kernel paging request at virtual address 87550c8a
| EIP is at cleanup_bitmap_list +0x48/0x68
| ...
| 
| 3.
| Unable to handle kernel paging request at virtual address
| EIP IS AT get_cnode +0x61/0x94
| ...
| 
| 4.
| Unable to handle kernel paging request at virtual address faad7260
| EIP is at journal_mark_dirty +0x1b5
| Calltrace:
| flush_old_commits +0x113/0x16f
| reiserfs_write_super +0x98/0x9a
| sync_supers +0xd0/0xea
| do_sync
| sys_sync
| syscall_call
| 
| 5.
| syncing...(after mkfs so it was almost done)
| Unable to handle kernel paging request at virtual address 9756a996
| EIP is at cleanup_bitmap_list +0xb/0xd4
| Calltrace:
| autoremove_wake_function
| cleanup_freed_for_journal_list
| ...
| 
| 6.
| attempted to kill init
| bad: schedulling while atomic
| EIP is at add_wait_queue
| 
| And much more (mostly in FS code)
| 
| Tested ciphers: aes, blowfish (both as module and compiled in)
| 
| Filesystems with crypto file: ReiserFS, FAT
| 
| Tested sizes of crypto file: 50MB, 10GB
| 
| Tested disk drives and controllers:
| ICH5 with WD120JB (pata), external
| CMD649 (Kouwell 671A) with 80GB Seagate barracuda IV
| 
| Tested chipsets:
| I865 (Asus P4P800), I875 (Abit IC7 G)
| 
| Other hardware: P4 2.6 (HT, SMP kernel), 1GB RAM (High memory support 
| 4GB). Thoroughly tested with memtest and mprime95.
| 
| See lspci and config in attachment.
| 
| Kernel is not tainted.
| 
| Write me please if additional information is need.
| 
| miho
| 
| PS. Excuse my poor english.
| 
| --------------000303030500070207010703
| Content-Type: text/plain;
|  name="lspci.txt"
| Content-Transfer-Encoding: 7bit
| Content-Disposition: inline;
|  filename="lspci.txt"
| 
| 0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
| 0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
| 0000:00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02)
| 0000:00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02)
| 0000:00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02)
| 0000:00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02)
| 0000:00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02)
| 0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
| 0000:00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
| 0000:00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02)
| 0000:00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
| 0000:01:00.0 VGA compatible controller: nVidia Corporation NV35 [GeForce FX 5900] (rev a1)
| 0000:02:05.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
| 0000:02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
| 0000:02:07.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
| 0000:02:07.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 03)
| 0000:02:07.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port
| 
| --------------000303030500070207010703
| Content-Type: text/plain;
|  name="config.txt"
| Content-Transfer-Encoding: 7bit
| Content-Disposition: inline;
|  filename="config.txt"
| 
| #
| # Automatically generated make config: don't edit
| #
| CONFIG_X86=y
| CONFIG_MMU=y
| CONFIG_UID16=y
| CONFIG_GENERIC_ISA_DMA=y
| 
| #
| # Code maturity level options
| #
| CONFIG_EXPERIMENTAL=y
| CONFIG_CLEAN_COMPILE=y
| CONFIG_STANDALONE=y
| 
| #
| # General setup
| #
| CONFIG_SWAP=y
| CONFIG_SYSVIPC=y
| CONFIG_BSD_PROCESS_ACCT=y
| CONFIG_SYSCTL=y
| CONFIG_LOG_BUF_SHIFT=15
| # CONFIG_IKCONFIG is not set
| # CONFIG_EMBEDDED is not set
| CONFIG_KALLSYMS=y
| CONFIG_FUTEX=y
| CONFIG_EPOLL=y
| CONFIG_IOSCHED_NOOP=y
| CONFIG_IOSCHED_AS=y
| CONFIG_IOSCHED_DEADLINE=y
| # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
| 
| #
| # Loadable module support
| #
| CONFIG_MODULES=y
| # CONFIG_MODULE_UNLOAD is not set
| CONFIG_OBSOLETE_MODPARM=y
| # CONFIG_MODVERSIONS is not set
| CONFIG_KMOD=y
| 
| #
| # Processor type and features
| #
| CONFIG_X86_PC=y
| # CONFIG_X86_VOYAGER is not set
| # CONFIG_X86_NUMAQ is not set
| # CONFIG_X86_SUMMIT is not set
| # CONFIG_X86_BIGSMP is not set
| # CONFIG_X86_VISWS is not set
| # CONFIG_X86_GENERICARCH is not set
| # CONFIG_X86_ES7000 is not set
| # CONFIG_M386 is not set
| # CONFIG_M486 is not set
| # CONFIG_M586 is not set
| # CONFIG_M586TSC is not set
| # CONFIG_M586MMX is not set
| # CONFIG_M686 is not set
| # CONFIG_MPENTIUMII is not set
| # CONFIG_MPENTIUMIII is not set
| CONFIG_MPENTIUM4=y
| # CONFIG_MK6 is not set
| # CONFIG_MK7 is not set
| # CONFIG_MK8 is not set
| # CONFIG_MELAN is not set
| # CONFIG_MCRUSOE is not set
| # CONFIG_MWINCHIPC6 is not set
| # CONFIG_MWINCHIP2 is not set
| # CONFIG_MWINCHIP3D is not set
| # CONFIG_MCYRIXIII is not set
| # CONFIG_MVIAC3_2 is not set
| # CONFIG_X86_GENERIC is not set
| CONFIG_X86_CMPXCHG=y
| CONFIG_X86_XADD=y
| CONFIG_X86_L1_CACHE_SHIFT=7
| CONFIG_RWSEM_XCHGADD_ALGORITHM=y
| CONFIG_X86_WP_WORKS_OK=y
| CONFIG_X86_INVLPG=y
| CONFIG_X86_BSWAP=y
| CONFIG_X86_POPAD_OK=y
| CONFIG_X86_GOOD_APIC=y
| CONFIG_X86_INTEL_USERCOPY=y
| CONFIG_X86_USE_PPRO_CHECKSUM=y
| # CONFIG_HPET_TIMER is not set
| # CONFIG_HPET_EMULATE_RTC is not set
| CONFIG_SMP=y
| CONFIG_NR_CPUS=2
| CONFIG_PREEMPT=y
| CONFIG_X86_LOCAL_APIC=y
| CONFIG_X86_IO_APIC=y
| CONFIG_X86_TSC=y
| # CONFIG_X86_MCE is not set
| # CONFIG_TOSHIBA is not set
| # CONFIG_I8K is not set
| # CONFIG_MICROCODE is not set
| # CONFIG_X86_MSR is not set
| # CONFIG_X86_CPUID is not set
| # CONFIG_EDD is not set
| # CONFIG_NOHIGHMEM is not set
| CONFIG_HIGHMEM4G=y
| # CONFIG_HIGHMEM64G is not set
| CONFIG_HIGHMEM=y
| # CONFIG_HIGHPTE is not set
| # CONFIG_MATH_EMULATION is not set
| CONFIG_MTRR=y
| CONFIG_HAVE_DEC_LOCK=y
| 
| #
| # Power management options (ACPI, APM)
| #
| CONFIG_PM=y
| # CONFIG_SOFTWARE_SUSPEND is not set
| # CONFIG_PM_DISK is not set
| 
| #
| # ACPI (Advanced Configuration and Power Interface) Support
| #
| # CONFIG_ACPI is not set
| CONFIG_ACPI_BOOT=y
| 
| #
| # APM (Advanced Power Management) BIOS Support
| #
| CONFIG_APM=y
| # CONFIG_APM_IGNORE_USER_SUSPEND is not set
| # CONFIG_APM_DO_ENABLE is not set
| # CONFIG_APM_CPU_IDLE is not set
| # CONFIG_APM_DISPLAY_BLANK is not set
| # CONFIG_APM_RTC_IS_GMT is not set
| # CONFIG_APM_ALLOW_INTS is not set
| CONFIG_APM_REAL_MODE_POWER_OFF=y
| 
| #
| # CPU Frequency scaling
| #
| # CONFIG_CPU_FREQ is not set
| 
| #
| # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
| #
| CONFIG_PCI=y
| # CONFIG_PCI_GOBIOS is not set
| # CONFIG_PCI_GODIRECT is not set
| CONFIG_PCI_GOANY=y
| CONFIG_PCI_BIOS=y
| CONFIG_PCI_DIRECT=y
| # CONFIG_PCI_USE_VECTOR is not set
| # CONFIG_PCI_LEGACY_PROC is not set
| CONFIG_PCI_NAMES=y
| # CONFIG_ISA is not set
| # CONFIG_MCA is not set
| # CONFIG_SCx200 is not set
| # CONFIG_HOTPLUG is not set
| 
| #
| # Executable file formats
| #
| CONFIG_BINFMT_ELF=y
| CONFIG_BINFMT_AOUT=m
| CONFIG_BINFMT_MISC=m
| 
| #
| # Device Drivers
| #
| 
| #
| # Generic Driver Options
| #
| 
| #
| # Memory Technology Devices (MTD)
| #
| # CONFIG_MTD is not set
| 
| #
| # Parallel port support
| #
| # CONFIG_PARPORT is not set
| 
| #
| # Plug and Play support
| #
| 
| #
| # Block devices
| #
| # CONFIG_BLK_DEV_FD is not set
| # CONFIG_BLK_CPQ_DA is not set
| # CONFIG_BLK_CPQ_CISS_DA is not set
| # CONFIG_BLK_DEV_DAC960 is not set
| # CONFIG_BLK_DEV_UMEM is not set
| CONFIG_BLK_DEV_LOOP=y
| CONFIG_BLK_DEV_CRYPTOLOOP=y
| CONFIG_BLK_DEV_NBD=m
| # CONFIG_BLK_DEV_RAM is not set
| # CONFIG_BLK_DEV_INITRD is not set
| # CONFIG_LBD is not set
| 
| #
| # ATA/ATAPI/MFM/RLL support
| #
| CONFIG_IDE=y
| CONFIG_BLK_DEV_IDE=y
| 
| #
| # Please see Documentation/ide.txt for help/info on IDE drives
| #
| # CONFIG_BLK_DEV_HD_IDE is not set
| CONFIG_BLK_DEV_IDEDISK=y
| CONFIG_IDEDISK_MULTI_MODE=y
| # CONFIG_IDEDISK_STROKE is not set
| CONFIG_BLK_DEV_IDECD=y
| # CONFIG_BLK_DEV_IDETAPE is not set
| # CONFIG_BLK_DEV_IDEFLOPPY is not set
| # CONFIG_BLK_DEV_IDESCSI is not set
| # CONFIG_IDE_TASK_IOCTL is not set
| CONFIG_IDE_TASKFILE_IO=y
| 
| #
| # IDE chipset support/bugfixes
| #
| CONFIG_IDE_GENERIC=y
| # CONFIG_BLK_DEV_CMD640 is not set
| CONFIG_BLK_DEV_IDEPCI=y
| CONFIG_IDEPCI_SHARE_IRQ=y
| # CONFIG_BLK_DEV_OFFBOARD is not set
| CONFIG_BLK_DEV_GENERIC=y
| # CONFIG_BLK_DEV_OPTI621 is not set
| # CONFIG_BLK_DEV_RZ1000 is not set
| CONFIG_BLK_DEV_IDEDMA_PCI=y
| # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
| CONFIG_IDEDMA_PCI_AUTO=y
| # CONFIG_IDEDMA_ONLYDISK is not set
| # CONFIG_IDEDMA_PCI_WIP is not set
| CONFIG_BLK_DEV_ADMA=y
| # CONFIG_BLK_DEV_AEC62XX is not set
| # CONFIG_BLK_DEV_ALI15X3 is not set
| # CONFIG_BLK_DEV_AMD74XX is not set
| CONFIG_BLK_DEV_CMD64X=y
| # CONFIG_BLK_DEV_TRIFLEX is not set
| # CONFIG_BLK_DEV_CY82C693 is not set
| # CONFIG_BLK_DEV_CS5520 is not set
| # CONFIG_BLK_DEV_CS5530 is not set
| # CONFIG_BLK_DEV_HPT34X is not set
| # CONFIG_BLK_DEV_HPT366 is not set
| # CONFIG_BLK_DEV_SC1200 is not set
| CONFIG_BLK_DEV_PIIX=y
| # CONFIG_BLK_DEV_NS87415 is not set
| # CONFIG_BLK_DEV_PDC202XX_OLD is not set
| # CONFIG_BLK_DEV_PDC202XX_NEW is not set
| # CONFIG_BLK_DEV_SVWKS is not set
| # CONFIG_BLK_DEV_SIIMAGE is not set
| # CONFIG_BLK_DEV_SIS5513 is not set
| # CONFIG_BLK_DEV_SLC90E66 is not set
| # CONFIG_BLK_DEV_TRM290 is not set
| # CONFIG_BLK_DEV_VIA82CXXX is not set
| CONFIG_BLK_DEV_IDEDMA=y
| # CONFIG_IDEDMA_IVB is not set
| CONFIG_IDEDMA_AUTO=y
| # CONFIG_DMA_NONPCI is not set
| # CONFIG_BLK_DEV_HD is not set
| 
| #
| # SCSI device support
| #
| CONFIG_SCSI=y
| # CONFIG_SCSI_PROC_FS is not set
| 
| #
| # SCSI support type (disk, tape, CD-ROM)
| #
| # CONFIG_BLK_DEV_SD is not set
| # CONFIG_CHR_DEV_ST is not set
| # CONFIG_CHR_DEV_OSST is not set
| # CONFIG_BLK_DEV_SR is not set
| # CONFIG_CHR_DEV_SG is not set
| 
| #
| # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
| #
| # CONFIG_SCSI_MULTI_LUN is not set
| # CONFIG_SCSI_REPORT_LUNS is not set
| # CONFIG_SCSI_CONSTANTS is not set
| # CONFIG_SCSI_LOGGING is not set
| 
| #
| # SCSI low-level drivers
| #
| # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
| # CONFIG_SCSI_ACARD is not set
| # CONFIG_SCSI_AACRAID is not set
| # CONFIG_SCSI_AIC7XXX is not set
| # CONFIG_SCSI_AIC7XXX_OLD is not set
| # CONFIG_SCSI_AIC79XX is not set
| # CONFIG_SCSI_ADVANSYS is not set
| # CONFIG_SCSI_MEGARAID is not set
| # CONFIG_SCSI_SATA is not set
| # CONFIG_SCSI_BUSLOGIC is not set
| # CONFIG_SCSI_CPQFCTS is not set
| # CONFIG_SCSI_DMX3191D is not set
| # CONFIG_SCSI_EATA is not set
| # CONFIG_SCSI_EATA_PIO is not set
| # CONFIG_SCSI_FUTURE_DOMAIN is not set
| # CONFIG_SCSI_GDTH is not set
| # CONFIG_SCSI_IPS is not set
| # CONFIG_SCSI_INIA100 is not set
| # CONFIG_SCSI_SYM53C8XX_2 is not set
| # CONFIG_SCSI_QLOGIC_ISP is not set
| # CONFIG_SCSI_QLOGIC_FC is not set
| # CONFIG_SCSI_QLOGIC_1280 is not set
| CONFIG_SCSI_QLA2XXX_CONFIG=y
| # CONFIG_SCSI_QLA21XX is not set
| # CONFIG_SCSI_QLA22XX is not set
| # CONFIG_SCSI_QLA23XX is not set
| # CONFIG_SCSI_DC395x is not set
| # CONFIG_SCSI_DC390T is not set
| # CONFIG_SCSI_NSP32 is not set
| # CONFIG_SCSI_DEBUG is not set
| 
| #
| # Multi-device support (RAID and LVM)
| #
| # CONFIG_MD is not set
| 
| #
| # Fusion MPT device support
| #
| 
| #
| # IEEE 1394 (FireWire) support (EXPERIMENTAL)
| #
| # CONFIG_IEEE1394 is not set
| 
| #
| # I2O device support
| #
| # CONFIG_I2O is not set
| 
| #
| # Networking support
| #
| CONFIG_NET=y
| 
| #
| # Networking options
| #
| CONFIG_PACKET=y
| # CONFIG_PACKET_MMAP is not set
| # CONFIG_NETLINK_DEV is not set
| CONFIG_UNIX=y
| # CONFIG_NET_KEY is not set
| CONFIG_INET=y
| CONFIG_IP_MULTICAST=y
| # CONFIG_IP_ADVANCED_ROUTER is not set
| # CONFIG_IP_PNP is not set
| # CONFIG_NET_IPIP is not set
| # CONFIG_NET_IPGRE is not set
| # CONFIG_IP_MROUTE is not set
| # CONFIG_ARPD is not set
| # CONFIG_INET_ECN is not set
| # CONFIG_SYN_COOKIES is not set
| # CONFIG_INET_AH is not set
| # CONFIG_INET_ESP is not set
| # CONFIG_INET_IPCOMP is not set
| 
| #
| # IP: Virtual Server Configuration
| #
| # CONFIG_IP_VS is not set
| # CONFIG_IPV6 is not set
| # CONFIG_DECNET is not set
| # CONFIG_BRIDGE is not set
| CONFIG_NETFILTER=y
| # CONFIG_NETFILTER_DEBUG is not set
| 
| #
| # IP: Netfilter Configuration
| #
| CONFIG_IP_NF_CONNTRACK=y
| CONFIG_IP_NF_FTP=y
| # CONFIG_IP_NF_IRC is not set
| # CONFIG_IP_NF_TFTP is not set
| # CONFIG_IP_NF_AMANDA is not set
| # CONFIG_IP_NF_QUEUE is not set
| CONFIG_IP_NF_IPTABLES=y
| CONFIG_IP_NF_MATCH_LIMIT=y
| CONFIG_IP_NF_MATCH_IPRANGE=y
| CONFIG_IP_NF_MATCH_MAC=y
| CONFIG_IP_NF_MATCH_PKTTYPE=y
| CONFIG_IP_NF_MATCH_MARK=y
| CONFIG_IP_NF_MATCH_MULTIPORT=y
| CONFIG_IP_NF_MATCH_TOS=y
| CONFIG_IP_NF_MATCH_RECENT=y
| CONFIG_IP_NF_MATCH_ECN=y
| CONFIG_IP_NF_MATCH_DSCP=y
| CONFIG_IP_NF_MATCH_AH_ESP=y
| CONFIG_IP_NF_MATCH_LENGTH=y
| CONFIG_IP_NF_MATCH_TTL=y
| CONFIG_IP_NF_MATCH_TCPMSS=y
| CONFIG_IP_NF_MATCH_HELPER=y
| CONFIG_IP_NF_MATCH_STATE=y
| CONFIG_IP_NF_MATCH_CONNTRACK=y
| CONFIG_IP_NF_MATCH_OWNER=y
| CONFIG_IP_NF_FILTER=y
| CONFIG_IP_NF_TARGET_REJECT=y
| # CONFIG_IP_NF_NAT is not set
| # CONFIG_IP_NF_MANGLE is not set
| CONFIG_IP_NF_TARGET_LOG=y
| # CONFIG_IP_NF_TARGET_ULOG is not set
| # CONFIG_IP_NF_TARGET_TCPMSS is not set
| # CONFIG_IP_NF_ARPTABLES is not set
| 
| #
| # SCTP Configuration (EXPERIMENTAL)
| #
| CONFIG_IPV6_SCTP__=y
| # CONFIG_IP_SCTP is not set
| # CONFIG_ATM is not set
| # CONFIG_VLAN_8021Q is not set
| # CONFIG_LLC2 is not set
| # CONFIG_IPX is not set
| # CONFIG_ATALK is not set
| # CONFIG_X25 is not set
| # CONFIG_LAPB is not set
| # CONFIG_NET_DIVERT is not set
| # CONFIG_ECONET is not set
| # CONFIG_WAN_ROUTER is not set
| # CONFIG_NET_FASTROUTE is not set
| # CONFIG_NET_HW_FLOWCONTROL is not set
| 
| #
| # QoS and/or fair queueing
| #
| # CONFIG_NET_SCHED is not set
| 
| #
| # Network testing
| #
| # CONFIG_NET_PKTGEN is not set
| CONFIG_NETDEVICES=y
| 
| #
| # ARCnet devices
| #
| # CONFIG_ARCNET is not set
| CONFIG_DUMMY=m
| # CONFIG_BONDING is not set
| # CONFIG_EQUALIZER is not set
| # CONFIG_TUN is not set
| 
| #
| # Ethernet (10 or 100Mbit)
| #
| CONFIG_NET_ETHERNET=y
| CONFIG_MII=y
| # CONFIG_HAPPYMEAL is not set
| # CONFIG_SUNGEM is not set
| # CONFIG_NET_VENDOR_3COM is not set
| 
| #
| # Tulip family network device support
| #
| # CONFIG_NET_TULIP is not set
| # CONFIG_HP100 is not set
| CONFIG_NET_PCI=y
| # CONFIG_PCNET32 is not set
| # CONFIG_AMD8111_ETH is not set
| # CONFIG_ADAPTEC_STARFIRE is not set
| # CONFIG_B44 is not set
| # CONFIG_FORCEDETH is not set
| # CONFIG_DGRS is not set
| # CONFIG_EEPRO100 is not set
| # CONFIG_E100 is not set
| # CONFIG_FEALNX is not set
| # CONFIG_NATSEMI is not set
| # CONFIG_NE2K_PCI is not set
| # CONFIG_8139CP is not set
| CONFIG_8139TOO=y
| # CONFIG_8139TOO_PIO is not set
| # CONFIG_8139TOO_TUNE_TWISTER is not set
| # CONFIG_8139TOO_8129 is not set
| # CONFIG_8139_OLD_RX_RESET is not set
| # CONFIG_SIS900 is not set
| # CONFIG_EPIC100 is not set
| # CONFIG_SUNDANCE is not set
| # CONFIG_TLAN is not set
| # CONFIG_VIA_RHINE is not set
| 
| #
| # Ethernet (1000 Mbit)
| #
| # CONFIG_ACENIC is not set
| # CONFIG_DL2K is not set
| # CONFIG_E1000 is not set
| # CONFIG_NS83820 is not set
| # CONFIG_HAMACHI is not set
| # CONFIG_YELLOWFIN is not set
| # CONFIG_R8169 is not set
| # CONFIG_SIS190 is not set
| # CONFIG_SK98LIN is not set
| # CONFIG_TIGON3 is not set
| 
| #
| # Ethernet (10000 Mbit)
| #
| # CONFIG_IXGB is not set
| # CONFIG_FDDI is not set
| # CONFIG_HIPPI is not set
| CONFIG_PPP=y
| # CONFIG_PPP_MULTILINK is not set
| CONFIG_PPP_FILTER=y
| CONFIG_PPP_ASYNC=y
| CONFIG_PPP_SYNC_TTY=y
| CONFIG_PPP_DEFLATE=y
| CONFIG_PPP_BSDCOMP=y
| # CONFIG_PPPOE is not set
| # CONFIG_SLIP is not set
| 
| #
| # Wireless LAN (non-hamradio)
| #
| # CONFIG_NET_RADIO is not set
| 
| #
| # Token Ring devices
| #
| # CONFIG_TR is not set
| # CONFIG_NET_FC is not set
| # CONFIG_RCPCI is not set
| # CONFIG_SHAPER is not set
| 
| #
| # Wan interfaces
| #
| # CONFIG_WAN is not set
| 
| #
| # Amateur Radio support
| #
| # CONFIG_HAMRADIO is not set
| 
| #
| # IrDA (infrared) support
| #
| # CONFIG_IRDA is not set
| 
| #
| # Bluetooth support
| #
| # CONFIG_BT is not set
| 
| #
| # ISDN subsystem
| #
| # CONFIG_ISDN_BOOL is not set
| 
| #
| # Telephony Support
| #
| # CONFIG_PHONE is not set
| 
| #
| # Input device support
| #
| CONFIG_INPUT=y
| 
| #
| # Userland interfaces
| #
| CONFIG_INPUT_MOUSEDEV=y
| CONFIG_INPUT_MOUSEDEV_PSAUX=y
| CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
| CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
| # CONFIG_INPUT_JOYDEV is not set
| # CONFIG_INPUT_TSDEV is not set
| # CONFIG_INPUT_EVDEV is not set
| # CONFIG_INPUT_EVBUG is not set
| 
| #
| # Input I/O drivers
| #
| # CONFIG_GAMEPORT is not set
| CONFIG_SOUND_GAMEPORT=y
| CONFIG_SERIO=y
| CONFIG_SERIO_I8042=y
| # CONFIG_SERIO_SERPORT is not set
| # CONFIG_SERIO_CT82C710 is not set
| # CONFIG_SERIO_PCIPS2 is not set
| 
| #
| # Input Device Drivers
| #
| CONFIG_INPUT_KEYBOARD=y
| CONFIG_KEYBOARD_ATKBD=y
| # CONFIG_KEYBOARD_SUNKBD is not set
| # CONFIG_KEYBOARD_XTKBD is not set
| # CONFIG_KEYBOARD_NEWTON is not set
| CONFIG_INPUT_MOUSE=y
| CONFIG_MOUSE_PS2=y
| # CONFIG_MOUSE_SERIAL is not set
| # CONFIG_INPUT_JOYSTICK is not set
| # CONFIG_INPUT_TOUCHSCREEN is not set
| # CONFIG_INPUT_MISC is not set
| 
| #
| # Character devices
| #
| CONFIG_VT=y
| CONFIG_VT_CONSOLE=y
| CONFIG_HW_CONSOLE=y
| # CONFIG_SERIAL_NONSTANDARD is not set
| 
| #
| # Serial drivers
| #
| CONFIG_SERIAL_8250=y
| # CONFIG_SERIAL_8250_CONSOLE is not set
| CONFIG_SERIAL_8250_NR_UARTS=4
| # CONFIG_SERIAL_8250_EXTENDED is not set
| 
| #
| # Non-8250 serial port support
| #
| CONFIG_SERIAL_CORE=y
| CONFIG_UNIX98_PTYS=y
| CONFIG_UNIX98_PTY_COUNT=256
| 
| #
| # Mice
| #
| # CONFIG_BUSMOUSE is not set
| # CONFIG_QIC02_TAPE is not set
| 
| #
| # IPMI
| #
| # CONFIG_IPMI_HANDLER is not set
| 
| #
| # Watchdog Cards
| #
| # CONFIG_WATCHDOG is not set
| # CONFIG_HW_RANDOM is not set
| # CONFIG_NVRAM is not set
| CONFIG_RTC=y
| # CONFIG_DTLK is not set
| # CONFIG_R3964 is not set
| # CONFIG_APPLICOM is not set
| # CONFIG_SONYPI is not set
| 
| #
| # Ftape, the floppy tape device driver
| #
| # CONFIG_AGP is not set
| # CONFIG_DRM is not set
| # CONFIG_MWAVE is not set
| # CONFIG_RAW_DRIVER is not set
| # CONFIG_HANGCHECK_TIMER is not set
| 
| #
| # I2C support
| #
| CONFIG_I2C=m
| CONFIG_I2C_CHARDEV=m
| 
| #
| # I2C Algorithms
| #
| CONFIG_I2C_ALGOBIT=m
| CONFIG_I2C_ALGOPCF=m
| 
| #
| # I2C Hardware Bus support
| #
| CONFIG_I2C_ALI1535=m
| CONFIG_I2C_ALI15X3=m
| CONFIG_I2C_AMD756=m
| CONFIG_I2C_AMD8111=m
| # CONFIG_I2C_ELV is not set
| CONFIG_I2C_I801=m
| CONFIG_I2C_I810=m
| CONFIG_I2C_ISA=m
| CONFIG_I2C_NFORCE2=m
| # CONFIG_I2C_PARPORT_LIGHT is not set
| CONFIG_I2C_PIIX4=m
| CONFIG_I2C_PROSAVAGE=m
| CONFIG_I2C_SAVAGE4=m
| CONFIG_SCx200_ACB=m
| CONFIG_I2C_SIS5595=m
| CONFIG_I2C_SIS630=m
| CONFIG_I2C_SIS96X=m
| # CONFIG_I2C_VELLEMAN is not set
| CONFIG_I2C_VIA=m
| CONFIG_I2C_VIAPRO=m
| CONFIG_I2C_VOODOO3=m
| 
| #
| # I2C Hardware Sensors Chip support
| #
| CONFIG_I2C_SENSOR=m
| CONFIG_SENSORS_ADM1021=m
| # CONFIG_SENSORS_ASB100 is not set
| CONFIG_SENSORS_EEPROM=m
| CONFIG_SENSORS_IT87=m
| CONFIG_SENSORS_LM75=m
| CONFIG_SENSORS_LM78=m
| CONFIG_SENSORS_LM83=m
| CONFIG_SENSORS_LM85=m
| CONFIG_SENSORS_LM90=m
| CONFIG_SENSORS_VIA686A=m
| CONFIG_SENSORS_W83781D=m
| CONFIG_SENSORS_W83L785TS=m
| # CONFIG_I2C_DEBUG_CORE is not set
| # CONFIG_I2C_DEBUG_BUS is not set
| # CONFIG_I2C_DEBUG_CHIP is not set
| 
| #
| # Multimedia devices
| #
| # CONFIG_VIDEO_DEV is not set
| 
| #
| # Digital Video Broadcasting Devices
| #
| # CONFIG_DVB is not set
| 
| #
| # Graphics support
| #
| # CONFIG_FB is not set
| # CONFIG_VIDEO_SELECT is not set
| 
| #
| # Console display driver support
| #
| CONFIG_VGA_CONSOLE=y
| # CONFIG_MDA_CONSOLE is not set
| CONFIG_DUMMY_CONSOLE=y
| 
| #
| # Sound
| #
| CONFIG_SOUND=y
| 
| #
| # Advanced Linux Sound Architecture
| #
| CONFIG_SND=y
| # CONFIG_SND_SEQUENCER is not set
| CONFIG_SND_OSSEMUL=y
| CONFIG_SND_MIXER_OSS=y
| CONFIG_SND_PCM_OSS=y
| # CONFIG_SND_RTCTIMER is not set
| # CONFIG_SND_VERBOSE_PRINTK is not set
| # CONFIG_SND_DEBUG is not set
| 
| #
| # Generic devices
| #
| # CONFIG_SND_DUMMY is not set
| # CONFIG_SND_MTPAV is not set
| # CONFIG_SND_SERIAL_U16550 is not set
| # CONFIG_SND_MPU401 is not set
| 
| #
| # PCI devices
| #
| # CONFIG_SND_ALI5451 is not set
| # CONFIG_SND_AZT3328 is not set
| # CONFIG_SND_CS46XX is not set
| # CONFIG_SND_CS4281 is not set
| CONFIG_SND_EMU10K1=y
| # CONFIG_SND_KORG1212 is not set
| # CONFIG_SND_NM256 is not set
| # CONFIG_SND_RME32 is not set
| # CONFIG_SND_RME96 is not set
| # CONFIG_SND_RME9652 is not set
| # CONFIG_SND_HDSP is not set
| # CONFIG_SND_TRIDENT is not set
| # CONFIG_SND_YMFPCI is not set
| # CONFIG_SND_ALS4000 is not set
| # CONFIG_SND_CMIPCI is not set
| # CONFIG_SND_ENS1370 is not set
| # CONFIG_SND_ENS1371 is not set
| # CONFIG_SND_ES1938 is not set
| # CONFIG_SND_ES1968 is not set
| # CONFIG_SND_MAESTRO3 is not set
| # CONFIG_SND_FM801 is not set
| # CONFIG_SND_ICE1712 is not set
| # CONFIG_SND_ICE1724 is not set
| # CONFIG_SND_INTEL8X0 is not set
| # CONFIG_SND_SONICVIBES is not set
| # CONFIG_SND_VIA82XX is not set
| # CONFIG_SND_VX222 is not set
| 
| #
| # ALSA USB devices
| #
| # CONFIG_SND_USB_AUDIO is not set
| 
| #
| # Open Sound System
| #
| # CONFIG_SOUND_PRIME is not set
| 
| #
| # USB support
| #
| CONFIG_USB=y
| # CONFIG_USB_DEBUG is not set
| 
| #
| # Miscellaneous USB options
| #
| CONFIG_USB_DEVICEFS=y
| # CONFIG_USB_BANDWIDTH is not set
| # CONFIG_USB_DYNAMIC_MINORS is not set
| 
| #
| # USB Host Controller Drivers
| #
| CONFIG_USB_EHCI_HCD=y
| # CONFIG_USB_OHCI_HCD is not set
| CONFIG_USB_UHCI_HCD=y
| 
| #
| # USB Device Class drivers
| #
| # CONFIG_USB_AUDIO is not set
| # CONFIG_USB_BLUETOOTH_TTY is not set
| # CONFIG_USB_MIDI is not set
| # CONFIG_USB_ACM is not set
| CONFIG_USB_PRINTER=y
| CONFIG_USB_STORAGE=y
| # CONFIG_USB_STORAGE_DEBUG is not set
| # CONFIG_USB_STORAGE_DATAFAB is not set
| # CONFIG_USB_STORAGE_FREECOM is not set
| # CONFIG_USB_STORAGE_ISD200 is not set
| # CONFIG_USB_STORAGE_DPCM is not set
| # CONFIG_USB_STORAGE_HP8200e is not set
| # CONFIG_USB_STORAGE_SDDR09 is not set
| # CONFIG_USB_STORAGE_SDDR55 is not set
| # CONFIG_USB_STORAGE_JUMPSHOT is not set
| 
| #
| # USB Human Interface Devices (HID)
| #
| CONFIG_USB_HID=y
| CONFIG_USB_HIDINPUT=y
| # CONFIG_HID_FF is not set
| # CONFIG_USB_HIDDEV is not set
| # CONFIG_USB_AIPTEK is not set
| # CONFIG_USB_WACOM is not set
| # CONFIG_USB_KBTAB is not set
| # CONFIG_USB_POWERMATE is not set
| # CONFIG_USB_XPAD is not set
| 
| #
| # USB Imaging devices
| #
| # CONFIG_USB_MDC800 is not set
| # CONFIG_USB_SCANNER is not set
| # CONFIG_USB_MICROTEK is not set
| # CONFIG_USB_HPUSBSCSI is not set
| 
| #
| # USB Multimedia devices
| #
| # CONFIG_USB_DABUSB is not set
| 
| #
| # Video4Linux support is needed for USB Multimedia device support
| #
| 
| #
| # USB Network adaptors
| #
| # CONFIG_USB_CATC is not set
| # CONFIG_USB_KAWETH is not set
| # CONFIG_USB_PEGASUS is not set
| # CONFIG_USB_RTL8150 is not set
| # CONFIG_USB_USBNET is not set
| 
| #
| # USB port drivers
| #
| 
| #
| # USB Serial Converter support
| #
| # CONFIG_USB_SERIAL is not set
| 
| #
| # USB Miscellaneous drivers
| #
| # CONFIG_USB_EMI62 is not set
| # CONFIG_USB_EMI26 is not set
| # CONFIG_USB_TIGL is not set
| # CONFIG_USB_AUERSWALD is not set
| # CONFIG_USB_RIO500 is not set
| # CONFIG_USB_LEGOTOWER is not set
| # CONFIG_USB_BRLVGER is not set
| # CONFIG_USB_LCD is not set
| # CONFIG_USB_LED is not set
| # CONFIG_USB_TEST is not set
| 
| #
| # USB Gadget Support
| #
| # CONFIG_USB_GADGET is not set
| 
| #
| # File systems
| #
| # CONFIG_EXT2_FS is not set
| # CONFIG_EXT3_FS is not set
| # CONFIG_JBD is not set
| CONFIG_REISERFS_FS=y
| # CONFIG_REISERFS_CHECK is not set
| # CONFIG_REISERFS_PROC_INFO is not set
| # CONFIG_JFS_FS is not set
| # CONFIG_XFS_FS is not set
| # CONFIG_MINIX_FS is not set
| # CONFIG_ROMFS_FS is not set
| # CONFIG_QUOTA is not set
| # CONFIG_AUTOFS_FS is not set
| # CONFIG_AUTOFS4_FS is not set
| 
| #
| # CD-ROM/DVD Filesystems
| #
| CONFIG_ISO9660_FS=y
| CONFIG_JOLIET=y
| # CONFIG_ZISOFS is not set
| CONFIG_UDF_FS=y
| 
| #
| # DOS/FAT/NT Filesystems
| #
| CONFIG_FAT_FS=y
| CONFIG_MSDOS_FS=y
| CONFIG_VFAT_FS=y
| CONFIG_NTFS_FS=y
| # CONFIG_NTFS_DEBUG is not set
| # CONFIG_NTFS_RW is not set
| 
| #
| # Pseudo filesystems
| #
| CONFIG_PROC_FS=y
| CONFIG_PROC_KCORE=y
| CONFIG_DEVFS_FS=y
| CONFIG_DEVFS_MOUNT=y
| # CONFIG_DEVFS_DEBUG is not set
| CONFIG_DEVPTS_FS=y
| CONFIG_DEVPTS_FS_XATTR=y
| # CONFIG_DEVPTS_FS_SECURITY is not set
| CONFIG_TMPFS=y
| # CONFIG_HUGETLBFS is not set
| # CONFIG_HUGETLB_PAGE is not set
| CONFIG_RAMFS=y
| 
| #
| # Miscellaneous filesystems
| #
| # CONFIG_ADFS_FS is not set
| # CONFIG_AFFS_FS is not set
| # CONFIG_HFS_FS is not set
| # CONFIG_BEFS_FS is not set
| # CONFIG_BFS_FS is not set
| # CONFIG_EFS_FS is not set
| # CONFIG_CRAMFS is not set
| # CONFIG_VXFS_FS is not set
| # CONFIG_HPFS_FS is not set
| # CONFIG_QNX4FS_FS is not set
| # CONFIG_SYSV_FS is not set
| # CONFIG_UFS_FS is not set
| 
| #
| # Network File Systems
| #
| # CONFIG_NFS_FS is not set
| # CONFIG_NFSD is not set
| # CONFIG_EXPORTFS is not set
| # CONFIG_SMB_FS is not set
| # CONFIG_CIFS is not set
| # CONFIG_NCP_FS is not set
| # CONFIG_CODA_FS is not set
| # CONFIG_INTERMEZZO_FS is not set
| # CONFIG_AFS_FS is not set
| 
| #
| # Partition Types
| #
| # CONFIG_PARTITION_ADVANCED is not set
| CONFIG_MSDOS_PARTITION=y
| 
| #
| # Native Language Support
| #
| CONFIG_NLS=y
| CONFIG_NLS_DEFAULT="iso8859-2"
| CONFIG_NLS_CODEPAGE_437=y
| # CONFIG_NLS_CODEPAGE_737 is not set
| # CONFIG_NLS_CODEPAGE_775 is not set
| # CONFIG_NLS_CODEPAGE_850 is not set
| CONFIG_NLS_CODEPAGE_852=m
| # CONFIG_NLS_CODEPAGE_855 is not set
| # CONFIG_NLS_CODEPAGE_857 is not set
| # CONFIG_NLS_CODEPAGE_860 is not set
| # CONFIG_NLS_CODEPAGE_861 is not set
| # CONFIG_NLS_CODEPAGE_862 is not set
| # CONFIG_NLS_CODEPAGE_863 is not set
| # CONFIG_NLS_CODEPAGE_864 is not set
| # CONFIG_NLS_CODEPAGE_865 is not set
| # CONFIG_NLS_CODEPAGE_866 is not set
| # CONFIG_NLS_CODEPAGE_869 is not set
| # CONFIG_NLS_CODEPAGE_936 is not set
| # CONFIG_NLS_CODEPAGE_950 is not set
| # CONFIG_NLS_CODEPAGE_932 is not set
| # CONFIG_NLS_CODEPAGE_949 is not set
| # CONFIG_NLS_CODEPAGE_874 is not set
| # CONFIG_NLS_ISO8859_8 is not set
| CONFIG_NLS_CODEPAGE_1250=m
| # CONFIG_NLS_CODEPAGE_1251 is not set
| CONFIG_NLS_ISO8859_1=y
| CONFIG_NLS_ISO8859_2=y
| # CONFIG_NLS_ISO8859_3 is not set
| # CONFIG_NLS_ISO8859_4 is not set
| # CONFIG_NLS_ISO8859_5 is not set
| # CONFIG_NLS_ISO8859_6 is not set
| # CONFIG_NLS_ISO8859_7 is not set
| # CONFIG_NLS_ISO8859_9 is not set
| # CONFIG_NLS_ISO8859_13 is not set
| # CONFIG_NLS_ISO8859_14 is not set
| # CONFIG_NLS_ISO8859_15 is not set
| # CONFIG_NLS_KOI8_R is not set
| # CONFIG_NLS_KOI8_U is not set
| CONFIG_NLS_UTF8=m
| 
| #
| # Profiling support
| #
| # CONFIG_PROFILING is not set
| 
| #
| # Kernel hacking
| #
| # CONFIG_DEBUG_KERNEL is not set
| # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
| CONFIG_FRAME_POINTER=y
| CONFIG_X86_FIND_SMP_CONFIG=y
| CONFIG_X86_MPPARSE=y
| 
| #
| # Security options
| #
| # CONFIG_SECURITY is not set
| 
| #
| # Cryptographic options
| #
| CONFIG_CRYPTO=y
| # CONFIG_CRYPTO_HMAC is not set
| CONFIG_CRYPTO_NULL=m
| CONFIG_CRYPTO_MD4=m
| CONFIG_CRYPTO_MD5=m
| CONFIG_CRYPTO_SHA1=m
| CONFIG_CRYPTO_SHA256=m
| CONFIG_CRYPTO_SHA512=m
| CONFIG_CRYPTO_DES=m
| CONFIG_CRYPTO_BLOWFISH=y
| CONFIG_CRYPTO_TWOFISH=m
| CONFIG_CRYPTO_SERPENT=m
| CONFIG_CRYPTO_AES=y
| CONFIG_CRYPTO_CAST5=m
| CONFIG_CRYPTO_CAST6=m
| CONFIG_CRYPTO_DEFLATE=m
| # CONFIG_CRYPTO_TEST is not set
| 
| #
| # Library routines
| #
| CONFIG_CRC32=y
| CONFIG_ZLIB_INFLATE=y
| CONFIG_ZLIB_DEFLATE=y
| CONFIG_X86_SMP=y
| CONFIG_X86_HT=y
| CONFIG_X86_BIOS_REBOOT=y
| CONFIG_X86_TRAMPOLINE=y
| CONFIG_PC=y
| 
| --------------000303030500070207010703--
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
| 


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
