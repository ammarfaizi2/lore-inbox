Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946015AbWGOKfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946015AbWGOKfe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 06:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWGOKfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 06:35:34 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60327 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932510AbWGOKfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 06:35:31 -0400
Message-ID: <44B8C506.1000009@free.fr>
Date: Sat, 15 Jul 2006 12:35:50 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Arjan van de Ven <arjan@linux.intel.com>
CC: Peter Osterlund <petero2@telia.com>, mingo@elte.hu, akpm@osdl.org,
       Kernel development list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [patch] lockdep: annotate pktcdvd natural device hierarchy
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>	 <m3sllxtfbf.fsf@telia.com> <1151000451.3120.56.camel@laptopd505.fenrus.org>	 <m3u05kqvla.fsf@telia.com> <1152884770.3159.37.camel@laptopd505.fenrus.org>	 <m3odvrc2vo.fsf@telia.com> <1152947098.3114.9.camel@laptopd505.fenrus.org>
In-Reply-To: <1152947098.3114.9.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------020600070806020000040007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020600070806020000040007
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Le 15.07.2006 09:04, Arjan van de Ven a écrit :
>> So the claim from the lockdep code, "BUG: possible circular locking
>> deadlock detected!", is a false alarm.
> 
> ok this patch ought to kill the false positive:
> 
> 
> the pkt_*_dev functions operate on not-this-blockdevice, and that is
> sufficiently checked at setup time. As a result there is a natural
> hierarchy, which needs nesting annotations
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> Index: linux-2.6.18-rc1/drivers/block/pktcdvd.c
> ===================================================================
> --- linux-2.6.18-rc1.orig/drivers/block/pktcdvd.c
> +++ linux-2.6.18-rc1/drivers/block/pktcdvd.c
> @@ -2577,19 +2577,19 @@ static int pkt_ctl_ioctl(struct inode *i
>  	case PKT_CTRL_CMD_SETUP:
>  		if (!capable(CAP_SYS_ADMIN))
>  			return -EPERM;
> -		mutex_lock(&ctl_mutex);
> +		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>  		ret = pkt_setup_dev(&ctrl_cmd);
>  		mutex_unlock(&ctl_mutex);
>  		break;
>  	case PKT_CTRL_CMD_TEARDOWN:
>  		if (!capable(CAP_SYS_ADMIN))
>  			return -EPERM;
> -		mutex_lock(&ctl_mutex);
> +		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>  		ret = pkt_remove_dev(&ctrl_cmd);
>  		mutex_unlock(&ctl_mutex);
>  		break;
>  	case PKT_CTRL_CMD_STATUS:
> -		mutex_lock(&ctl_mutex);
> +		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>  		pkt_get_status(&ctrl_cmd);
>  		mutex_unlock(&ctl_mutex);
>  		break;
> 

Thanks Arjan, this seems to solve the initial issue of this thread, 
which was "possible circular locking deadlock detected!" while 
doing "pktsetup dvd /dev/dvd".

So here is the next step :-(. I'm now running 2.6.18-rc1-mm2 and I was able 
to successfully run:
- modprobe ptkcdvd
- pktsetup dvd /dev/dvd

Then I inserted a UDF-formatted CD-RW in the CD/DVD burner and I typed 
this command :
- mount -oro -tauto /dev/pktcdvd/dvd /mnt/cdrom 
The following happened :

pktcdvd: writer pktcdvd0 mapped to hdc

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
mount/1176 is trying to acquire lock:
 (&bdev->bd_mutex){--..}, at: [do_open+107/957] do_open+0x6b/0x3bd
 (&bdev->bd_mutex){--..}, at: [<c0159c10>] do_open+0x6b/0x3bd

but task is already holding lock:
 (&bdev->bd_mutex){--..}, at: [do_open+107/957] do_open+0x6b/0x3bd
 (&bdev->bd_mutex){--..}, at: [<c0159c10>] do_open+0x6b/0x3bd

other info that might help us debug this:
2 locks held by mount/1176:
 #0:  (&bdev->bd_mutex){--..}, at: [do_open+107/957] do_open+0x6b/0x3bd
 #0:  (&bdev->bd_mutex){--..}, at: [<c0159c10>] do_open+0x6b/0x3bd
 #1:  (&ctl_mutex#2){--..}, at: [mutex_lock+33/36] mutex_lock+0x21/0x24
 #1:  (&ctl_mutex#2){--..}, at: [<c0290dca>] mutex_lock+0x21/0x24

stack backtrace:
 [show_trace+13/16] show_trace+0xd/0x10
 [<c0104db5>] show_trace+0xd/0x10
 [dump_stack+25/28] dump_stack+0x19/0x1c
 [<c0104dd1>] dump_stack+0x19/0x1c
 [__lock_acquire+1916/2469] __lock_acquire+0x77c/0x9a5
 [<c012c95a>] __lock_acquire+0x77c/0x9a5
 [lock_acquire+96/128] lock_acquire+0x60/0x80
 [<c012cbe3>] lock_acquire+0x60/0x80
 [mutex_lock_nested+191/512] mutex_lock_nested+0xbf/0x200
 [<c0290e8c>] mutex_lock_nested+0xbf/0x200
 [do_open+107/957] do_open+0x6b/0x3bd
 [<c0159c10>] do_open+0x6b/0x3bd
 [blkdev_get+110/121] blkdev_get+0x6e/0x79
 [<c0159fd0>] blkdev_get+0x6e/0x79
 [<e1138345>] pkt_open+0x99/0xbf4 [pktcdvd]
 [do_open+161/957] do_open+0xa1/0x3bd
 [<c0159c46>] do_open+0xa1/0x3bd
 [blkdev_open+31/72] blkdev_open+0x1f/0x48
 [<c015a10d>] blkdev_open+0x1f/0x48
 [__dentry_open+184/390] __dentry_open+0xb8/0x186
 [<c0151c8f>] __dentry_open+0xb8/0x186
 [nameidata_to_filp+28/46] nameidata_to_filp+0x1c/0x2e
 [<c0151dcb>] nameidata_to_filp+0x1c/0x2e
 [do_filp_open+46/53] do_filp_open+0x2e/0x35
 [<c0151e0b>] do_filp_open+0x2e/0x35
 [do_sys_open+64/187] do_sys_open+0x40/0xbb
 [<c0152ce9>] do_sys_open+0x40/0xbb
 [sys_open+22/24] sys_open+0x16/0x18
 [<c0152d90>] sys_open+0x16/0x18
 [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
 [<c0102c2d>] sysenter_past_esp+0x56/0x8d
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'flexbackup', timestamp 2006/03/17 15:29 (1078)

At this point, I must say that something doesn't play nicely with 4K-STACK 
(Lockdep ? UDF ? pktcdvd ?). A 4K-stack kernel got multiple oops after this
message. Only a 8K-STACK kernel is able to survive this info. 

.config and syslog attached.
-- 
laurent

--------------020600070806020000040007
Content-Type: text/plain;
 name="config-2.6.18-rc1-mm2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.6.18-rc1-mm2"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.18-rc1-mm2
# Sat Jul 15 11:18:25 2006
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SWAP_PREFETCH=y
CONFIG_SYSVIPC=y
# CONFIG_IPC_NS is not set
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_SYSCTL=y
# CONFIG_SYSCTL_SYSCALL is not set
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_KLIBC_ERRLIST=y
CONFIG_KLIBC_ZLIB=y
CONFIG_UID16=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_RT_MUTEXES=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"

#
# Processor type and features
#
# CONFIG_SMP is not set
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
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=m
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ADAPTIVE_READAHEAD=y
CONFIG_READAHEAD_ALLOW_OVERHEADS=y
# CONFIG_DEBUG_READAHEAD is not set
# CONFIG_READAHEAD_HIT_FEEDBACK is not set
# CONFIG_READAHEAD_SMOOTH_AGING is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
# CONFIG_SECCOMP_DISABLE_TSC is not set
# CONFIG_VGA_NOPROBE is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x100000
# CONFIG_COMPAT_VDSO is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/hdb6"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_ATLAS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_SONY is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

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
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_NETBIOS_NS is not set
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
# CONFIG_IP_NF_PPTP is not set
# CONFIG_IP_NF_H323 is not set
# CONFIG_IP_NF_SIP is not set
CONFIG_IP_NF_QUEUE=m

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
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
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_INGRESS=m

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_ESTIMATOR=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set
CONFIG_WIRELESS_EXT=y

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
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_UB=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_IDE_MAX_HWIFS=2
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
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
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=m
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
# CONFIG_SCSI_TGT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_DOMAIN_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
# CONFIG_MD_RAID10 is not set
# CONFIG_MD_RAID456 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
# CONFIG_DM_SNAPSHOT is not set
CONFIG_DM_MIRROR=m
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set
# CONFIG_IEEE1394_EXPORT_FULL_API is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
# CONFIG_IEEE1394_SBP2 is not set
# CONFIG_IEEE1394_ETH1394 is not set
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
# CONFIG_NET_WIRELESS_RTNETLINK is not set

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=m
# CONFIG_USB_ZD1201 is not set
# CONFIG_HOSTAP is not set
# CONFIG_ACX is not set
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPP_MPPE is not set
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

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
# CONFIG_INPUT_FF_EFFECTS is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

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
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=m
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=m
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L1 is not set
CONFIG_VIDEO_V4L1_COMPAT=y
CONFIG_VIDEO_V4L2=y

#
# Video Capture Adapters
#

#
# Video Capture Adapters
#
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_VIVI is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_CPIA2 is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_CX88 is not set

#
# Encoders and Decoders
#
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_CX2341X is not set
# CONFIG_VIDEO_CX25840 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set

#
# V4L USB devices
#
# CONFIG_VIDEO_PVRUSB2 is not set
# CONFIG_USB_QUICKCAM_MESSENGER is not set

#
# Radio Adapters
#

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=y
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_IMAC is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_DYNAMIC_MINORS=y
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_VERBOSE_PROCFS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_ADLIB is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_MIRO is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_WAVEFRONT is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_GOTEMP is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
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
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
CONFIG_EDAC=m

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=m
CONFIG_EDAC_AMD76X=m
CONFIG_EDAC_E7XXX=m
# CONFIG_EDAC_E752X is not set
CONFIG_EDAC_I82875P=m
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_K8 is not set
CONFIG_EDAC_R82600=m
CONFIG_EDAC_POLL=y

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
CONFIG_DMA_ENGINE=y

#
# DMA Clients
#
CONFIG_NET_DMA=y

#
# DMA Devices
#
# CONFIG_INTEL_IOATDMA is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISER4_FS=m
CONFIG_REISER4_DEBUG=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=850
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m

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
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_STATS2 is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
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
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Distributed Lock Manager
#

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SHIRQ=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
CONFIG_FRAME_POINTER=y
CONFIG_UNWIND_INFO=y
# CONFIG_STACK_UNWIND is not set
# CONFIG_PROFILE_LIKELY is not set
CONFIG_FORCED_INLINING=y
# CONFIG_DEBUG_SYNCHRO_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y

#
# Page alloc debug is incompatible with Software Suspend on i386
#
CONFIG_DEBUG_RODATA=y
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_MANAGER=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_586=m
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_PLIST=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y

--------------020600070806020000040007
Content-Type: text/plain;
 name="syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog"

Jul 15 12:01:13 antares kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 15 12:01:13 antares kernel: Inspecting /boot/System.map-2.6.18-rc1-mm2
Jul 15 12:01:13 antares kernel: Loaded 19828 symbols from /boot/System.map-2.6.18-rc1-mm2.
Jul 15 12:01:13 antares kernel: Symbols match kernel version 2.6.18.
Jul 15 12:01:13 antares kernel: No module symbols loaded - kernel modules not enabled. 
Jul 15 12:01:13 antares kernel: Linux version 2.6.18-rc1-mm2 (laurent@antares.localdomain) (gcc version 4.1.1 20060330 (prerelease)) #71 Sat Jul 15 11:52:30 CEST 2006
Jul 15 12:01:13 antares kernel: BIOS-provided physical RAM map:
Jul 15 12:01:13 antares kernel: sanitize start
Jul 15 12:01:13 antares kernel: sanitize end
Jul 15 12:01:13 antares kernel: copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
Jul 15 12:01:13 antares kernel: copy_e820_map() type is E820_RAM
Jul 15 12:01:13 antares kernel: add_memory_region(0000000000000000, 000000000009fc00, 1)
Jul 15 12:01:13 antares kernel: copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
Jul 15 12:01:13 antares kernel: add_memory_region(000000000009fc00, 0000000000000400, 2)
Jul 15 12:01:13 antares kernel: copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
Jul 15 12:01:13 antares kernel: add_memory_region(00000000000f0000, 0000000000010000, 2)
Jul 15 12:01:13 antares kernel: copy_e820_map() start: 0000000000100000 size: 000000001feec000 end: 000000001ffec000 type: 1
Jul 15 12:01:13 antares kernel: copy_e820_map() type is E820_RAM
Jul 15 12:01:13 antares kernel: add_memory_region(0000000000100000, 000000001feec000, 1)
Jul 15 12:01:13 antares kernel: copy_e820_map() start: 000000001ffec000 size: 0000000000003000 end: 000000001ffef000 type: 3
Jul 15 12:01:14 antares kernel: add_memory_region(000000001ffec000, 0000000000003000, 3)
Jul 15 12:01:14 antares kernel: copy_e820_map() start: 000000001ffef000 size: 0000000000010000 end: 000000001ffff000 type: 2
Jul 15 12:01:14 antares kernel: add_memory_region(000000001ffef000, 0000000000010000, 2)
Jul 15 12:01:14 antares kernel: copy_e820_map() start: 000000001ffff000 size: 0000000000001000 end: 0000000020000000 type: 4
Jul 15 12:01:14 antares kernel: add_memory_region(000000001ffff000, 0000000000001000, 4)
Jul 15 12:01:14 antares kernel: copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end: 0000000100000000 type: 2
Jul 15 12:01:14 antares kernel: add_memory_region(00000000ffff0000, 0000000000010000, 2)
Jul 15 12:01:14 antares kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jul 15 12:01:14 antares kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jul 15 12:01:14 antares kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 15 12:01:14 antares kernel:  BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
Jul 15 12:01:14 antares kernel:  BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
Jul 15 12:01:14 antares kernel:  BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
Jul 15 12:01:14 antares kernel:  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
Jul 15 12:01:14 antares kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jul 15 12:01:14 antares kernel: 511MB LOWMEM available.
Jul 15 12:01:14 antares kernel: On node 0 totalpages: 131052
Jul 15 12:01:14 antares kernel:   DMA zone: 4096 pages, LIFO batch:0
Jul 15 12:01:14 antares kernel:   Normal zone: 126956 pages, LIFO batch:31
Jul 15 12:01:14 antares kernel: DMI 2.3 present.
Jul 15 12:01:14 antares kernel: ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a80
Jul 15 12:01:14 antares kernel: ACPI: RSDT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec000
Jul 15 12:01:14 antares kernel: ACPI: FADT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec080
Jul 15 12:01:14 antares kernel: ACPI: BOOT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec040
Jul 15 12:01:14 antares kernel: ACPI: DSDT (v001   ASUS A7V133-C 0x00001000 MSFT 0x0100000b) @ 0x00000000
Jul 15 12:01:14 antares kernel: ACPI: PM-Timer IO Port: 0xe408
Jul 15 12:01:14 antares kernel: Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
Jul 15 12:01:14 antares kernel: Detected 1410.227 MHz processor.
Jul 15 12:01:14 antares kernel: Built 1 zonelists.  Total pages: 131052
Jul 15 12:01:14 antares kernel: Kernel command line: root=/dev/vglinux1/lvroot video=vesafb:ywrap,mtrr splash=silent resume=/dev/hdb6 vga=791 init 1
Jul 15 12:01:14 antares kernel: Local APIC disabled by BIOS -- you can enable it with "lapic"
Jul 15 12:01:14 antares kernel: mapped APIC to ffffd000 (01407000)
Jul 15 12:01:14 antares kernel: Enabling fast FPU save and restore... done.
Jul 15 12:01:14 antares kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 15 12:01:14 antares kernel: Initializing CPU#0
Jul 15 12:01:14 antares kernel: PID hash table entries: 2048 (order: 11, 8192 bytes)
Jul 15 12:01:14 antares kernel: Console: colour dummy device 80x25
Jul 15 12:01:14 antares kernel: Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
Jul 15 12:01:14 antares kernel: ... MAX_LOCKDEP_SUBCLASSES:    8
Jul 15 12:01:14 antares kernel: ... MAX_LOCK_DEPTH:          30
Jul 15 12:01:14 antares kernel: ... MAX_LOCKDEP_KEYS:        2048
Jul 15 12:01:14 antares kernel: ... CLASSHASH_SIZE:           1024
Jul 15 12:01:14 antares kernel: ... MAX_LOCKDEP_ENTRIES:     8192
Jul 15 12:01:14 antares kernel: ... MAX_LOCKDEP_CHAINS:      8192
Jul 15 12:01:14 antares kernel: ... CHAINHASH_SIZE:          4096
Jul 15 12:01:14 antares kernel:  memory used by lock dependency info: 696 kB
Jul 15 12:01:14 antares kernel:  per task-struct memory footprint: 1200 bytes
Jul 15 12:01:14 antares kernel: ------------------------
Jul 15 12:01:14 antares kernel: | Locking API testsuite:
Jul 15 12:01:14 antares kernel: ----------------------------------------------------------------------------
Jul 15 12:01:14 antares kernel:                                  | spin |wlock |rlock |mutex | wsem | rsem |
Jul 15 12:01:14 antares kernel:   --------------------------------------------------------------------------
Jul 15 12:01:14 antares kernel:                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:   --------------------------------------------------------------------------
Jul 15 12:01:14 antares kernel:               recursive read-lock:             |  ok  |             |  ok  |
Jul 15 12:01:14 antares kernel:            recursive read-lock #2:             |  ok  |             |  ok  |
Jul 15 12:01:14 antares kernel:             mixed read-write-lock:             |  ok  |             |  ok  |
Jul 15 12:01:14 antares kernel:             mixed write-read-lock:             |  ok  |             |  ok  |
Jul 15 12:01:14 antares kernel:   --------------------------------------------------------------------------
Jul 15 12:01:14 antares kernel:      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq read-recursion/123:  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq read-recursion/123:  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq read-recursion/132:  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq read-recursion/132:  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq read-recursion/213:  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq read-recursion/213:  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq read-recursion/231:  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq read-recursion/231:  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq read-recursion/312:  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq read-recursion/312:  ok  |
Jul 15 12:01:14 antares kernel:       hard-irq read-recursion/321:  ok  |
Jul 15 12:01:14 antares kernel:       soft-irq read-recursion/321:  ok  |
Jul 15 12:01:14 antares kernel: -------------------------------------------------------
Jul 15 12:01:14 antares kernel: Good, all 218 testcases passed! |
Jul 15 12:01:14 antares kernel: ---------------------------------
Jul 15 12:01:14 antares kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 15 12:01:14 antares kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Jul 15 12:01:14 antares kernel: Memory: 514492k/524208k available (1611k kernel code, 9176k reserved, 1176k data, 180k init, 0k highmem)
Jul 15 12:01:14 antares kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jul 15 12:01:14 antares kernel: Calibrating delay using timer specific routine.. 2824.53 BogoMIPS (lpj=5649067)
Jul 15 12:01:14 antares kernel: Mount-cache hash table entries: 512
Jul 15 12:01:14 antares kernel: CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
Jul 15 12:01:14 antares kernel: CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
Jul 15 12:01:14 antares kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 15 12:01:14 antares kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jul 15 12:01:14 antares kernel: CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000420 00000000 00000000 00000000
Jul 15 12:01:14 antares kernel: Intel machine check architecture supported.
Jul 15 12:01:14 antares kernel: Intel machine check reporting enabled on CPU#0.
Jul 15 12:01:14 antares kernel: CPU: AMD Athlon(TM) XP 1600+ stepping 02
Jul 15 12:01:14 antares kernel: Checking 'hlt' instruction... OK.
Jul 15 12:01:14 antares kernel: ACPI: Core revision 20060707
Jul 15 12:01:14 antares kernel:  tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Jul 15 12:01:14 antares kernel: Parsing all Control Methods:
Jul 15 12:01:14 antares kernel: Table [DSDT](id 0005) - 356 Objects with 38 Devices 115 Methods 24 Regions
Jul 15 12:01:14 antares kernel: ACPI Namespace successfully loaded at root c053c630
Jul 15 12:01:14 antares kernel: ACPI: setting ELCR to 0200 (from 0c20)
Jul 15 12:01:14 antares kernel: evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
Jul 15 12:01:14 antares kernel: checking if image is initramfs... it is
Jul 15 12:01:14 antares kernel: Freeing initrd memory: 224k freed
Jul 15 12:01:14 antares kernel: NET: Registered protocol family 16
Jul 15 12:01:14 antares kernel: ACPI: bus type pci registered
Jul 15 12:01:14 antares kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
Jul 15 12:01:14 antares kernel: Setting up standard PCI resources
Jul 15 12:01:14 antares kernel: evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
Jul 15 12:01:14 antares kernel: evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 4 Wake, Enabled 0 Runtime GPEs in this block
Jul 15 12:01:14 antares kernel: Completing Region/Field/Buffer/Package initialization:.......................................................
Jul 15 12:01:14 antares kernel: Initialized 23/24 Regions 2/2 Fields 19/19 Buffers 11/14 Packages (365 nodes)
Jul 15 12:01:14 antares kernel: Initializing Device/Processor/Thermal objects by executing _INI methods:
Jul 15 12:01:14 antares kernel: Executed 0 _INI methods requiring 0 _STA executions (examined 41 objects)
Jul 15 12:01:14 antares kernel: ACPI: Interpreter enabled
Jul 15 12:01:14 antares kernel: ACPI: Using PIC for interrupt routing
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Jul 15 12:01:14 antares kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jul 15 12:01:14 antares kernel: PCI: Probing PCI hardware (bus 00)
Jul 15 12:01:14 antares kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Jul 15 12:01:14 antares kernel: PCI quirk: region e200-e27f claimed by vt82c686 HW-mon
Jul 15 12:01:14 antares kernel: PCI quirk: region e800-e80f claimed by vt82c686 SMB
Jul 15 12:01:14 antares kernel: Boot video device is 0000:01:00.0
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jul 15 12:01:14 antares kernel: PCI: Using ACPI for IRQ routing
Jul 15 12:01:14 antares kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jul 15 12:01:14 antares kernel: PCI: Bridge: 0000:00:01.0
Jul 15 12:01:14 antares kernel:   IO window: disabled.
Jul 15 12:01:14 antares kernel:   MEM window: c6000000-c7efffff
Jul 15 12:01:14 antares kernel:   PREFETCH window: c7f00000-cfffffff
Jul 15 12:01:14 antares kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Jul 15 12:01:14 antares kernel: NET: Registered protocol family 2
Jul 15 12:01:14 antares kernel: IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
Jul 15 12:01:14 antares kernel: TCP established hash table entries: 16384 (order: 7, 655360 bytes)
Jul 15 12:01:14 antares kernel: TCP bind hash table entries: 8192 (order: 6, 360448 bytes)
Jul 15 12:01:14 antares kernel: TCP: Hash tables configured (established 16384 bind 8192)
Jul 15 12:01:14 antares kernel: TCP reno registered
Jul 15 12:01:14 antares kernel: Simple Boot Flag at 0x3a set to 0x1
Jul 15 12:01:14 antares kernel: Initializing Cryptographic API
Jul 15 12:01:14 antares kernel: io scheduler noop registered
Jul 15 12:01:14 antares kernel: io scheduler anticipatory registered
Jul 15 12:01:14 antares kernel: io scheduler deadline registered
Jul 15 12:01:14 antares kernel: io scheduler cfq registered (default)
Jul 15 12:01:14 antares kernel: Applying VIA southbridge workaround.
Jul 15 12:01:14 antares kernel: PCI: Disabling Via external APIC routing
Jul 15 12:01:14 antares kernel: vesafb: framebuffer at 0xc8000000, mapped to 0xe0880000, using 3072k, total 65536k
Jul 15 12:01:14 antares kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=0
Jul 15 12:01:14 antares kernel: vesafb: protected mode interface info at c000:0eb9
Jul 15 12:01:14 antares kernel: vesafb: pmi: set display start = c00c0ef2, set palette = c00c0f68
Jul 15 12:01:14 antares kernel: vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
Jul 15 12:01:14 antares kernel: vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
Jul 15 12:01:14 antares kernel: vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Jul 15 12:01:14 antares kernel: Console: switching to colour frame buffer device 128x48
Jul 15 12:01:14 antares kernel: fb0: VESA VGA frame buffer device
Jul 15 12:01:14 antares kernel: ACPI: Power Button (FF) [PWRF]
Jul 15 12:01:14 antares kernel: ACPI: Power Button (CM) [PWRB]
Jul 15 12:01:14 antares kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
Jul 15 12:01:14 antares kernel: ACPI: Processor [CPU0] (supports 16 throttling states)
Jul 15 12:01:14 antares kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Jul 15 12:01:14 antares kernel: ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
Jul 15 12:01:14 antares kernel:   http://www.scyld.com/network/ne2k-pci.html
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Jul 15 12:01:14 antares kernel: PCI: setting IRQ 10 as level-triggered
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Jul 15 12:01:14 antares kernel: eth0: RealTek RTL-8029 found at 0xa400, IRQ 10, 00:40:95:46:6E:2D.
Jul 15 12:01:14 antares kernel: netconsole: not configured, aborting
Jul 15 12:01:14 antares kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul 15 12:01:14 antares kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 15 12:01:14 antares kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 15 12:01:14 antares kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 15 12:01:14 antares kernel: mice: PS/2 mouse device common for all mice
Jul 15 12:01:14 antares kernel: TCP bic registered
Jul 15 12:01:14 antares kernel: NET: Registered protocol family 1
Jul 15 12:01:14 antares kernel: Using IPI Shortcut mode
Jul 15 12:01:14 antares kernel: ACPI: (supports S0 S1<6>Time: tsc clocksource has been installed.
Jul 15 12:01:14 antares kernel:  S3 S4 S5)
Jul 15 12:01:14 antares kernel: BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
Jul 15 12:01:14 antares kernel: Freeing unused kernel memory: 180k freed
Jul 15 12:01:14 antares kernel: Write protecting the kernel read-only data: 702k
Jul 15 12:01:14 antares kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Jul 15 12:01:14 antares kernel: VP_IDE: IDE controller at PCI slot 0000:00:04.1
Jul 15 12:01:14 antares kernel: VP_IDE: chipset revision 6
Jul 15 12:01:14 antares kernel: VP_IDE: not 100% native mode: will probe irqs later
Jul 15 12:01:14 antares kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
Jul 15 12:01:14 antares kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
Jul 15 12:01:14 antares kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Jul 15 12:01:14 antares kernel: Probing IDE interface ide0...
Jul 15 12:01:14 antares kernel: Time: acpi_pm clocksource has been installed.
Jul 15 12:01:14 antares kernel: input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
Jul 15 12:01:14 antares kernel: hda: ST340016A, ATA DISK drive
Jul 15 12:01:14 antares kernel: hdb: Maxtor 6Y080L0, ATA DISK drive
Jul 15 12:01:14 antares kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 15 12:01:14 antares kernel: hda: max request size: 128KiB
Jul 15 12:01:14 antares kernel: hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jul 15 12:01:14 antares kernel: hda: cache flushes not supported
Jul 15 12:01:14 antares kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
Jul 15 12:01:14 antares kernel: hdb: max request size: 128KiB
Jul 15 12:01:14 antares kernel: hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jul 15 12:01:14 antares kernel: hdb: cache flushes supported
Jul 15 12:01:14 antares kernel:  hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 hdb9 >
Jul 15 12:01:14 antares kernel: Probing IDE interface ide1...
Jul 15 12:01:14 antares kernel: hdc: HL-DT-ST DVDRAM GSA-4165B, ATAPI CD/DVD-ROM drive
Jul 15 12:01:14 antares kernel: hdd: CD-950E/AKU, ATAPI CD/DVD-ROM drive
Jul 15 12:01:14 antares kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 15 12:01:14 antares kernel: device-mapper: ioctl: 4.8.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
Jul 15 12:01:14 antares kernel: kjournald starting.  Commit interval 5 seconds
Jul 15 12:01:14 antares kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 15 12:01:14 antares kernel: usbcore: registered new interface driver usbfs
Jul 15 12:01:14 antares kernel: usbcore: registered new interface driver hub
Jul 15 12:01:14 antares kernel: usbcore: registered new device driver usb
Jul 15 12:01:14 antares kernel: USB Universal Host Controller Interface driver v3.0
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
Jul 15 12:01:14 antares kernel: PCI: setting IRQ 5 as level-triggered
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
Jul 15 12:01:14 antares kernel: uhci_hcd 0000:00:04.2: UHCI Host Controller
Jul 15 12:01:14 antares kernel: uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
Jul 15 12:01:14 antares kernel: uhci_hcd 0000:00:04.2: irq 5, io base 0x0000d400
Jul 15 12:01:14 antares kernel: usb usb1: new device found, idVendor=0000, idProduct=0000
Jul 15 12:01:14 antares kernel: usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
Jul 15 12:01:14 antares kernel: usb usb1: Product: UHCI Host Controller
Jul 15 12:01:14 antares kernel: usb usb1: Manufacturer: Linux 2.6.18-rc1-mm2 uhci_hcd
Jul 15 12:01:14 antares kernel: usb usb1: SerialNumber: 0000:00:04.2
Jul 15 12:01:14 antares kernel: usb usb1: configuration #1 chosen from 1 choice
Jul 15 12:01:14 antares kernel: hub 1-0:1.0: USB hub found
Jul 15 12:01:14 antares kernel: hub 1-0:1.0: 2 ports detected
Jul 15 12:01:14 antares kernel: warning: process `sleep' used the removed sysctl system call
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
Jul 15 12:01:14 antares kernel: uhci_hcd 0000:00:04.3: UHCI Host Controller
Jul 15 12:01:14 antares kernel: uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
Jul 15 12:01:14 antares kernel: uhci_hcd 0000:00:04.3: irq 5, io base 0x0000d000
Jul 15 12:01:14 antares kernel: usb usb2: new device found, idVendor=0000, idProduct=0000
Jul 15 12:01:14 antares kernel: usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
Jul 15 12:01:14 antares kernel: usb usb2: Product: UHCI Host Controller
Jul 15 12:01:14 antares kernel: usb usb2: Manufacturer: Linux 2.6.18-rc1-mm2 uhci_hcd
Jul 15 12:01:14 antares kernel: usb usb2: SerialNumber: 0000:00:04.3
Jul 15 12:01:14 antares kernel: usb usb2: configuration #1 chosen from 1 choice
Jul 15 12:01:14 antares kernel: hub 2-0:1.0: USB hub found
Jul 15 12:01:14 antares kernel: hub 2-0:1.0: 2 ports detected
Jul 15 12:01:14 antares kernel: usb 1-2: new low speed USB device using uhci_hcd and address 2
Jul 15 12:01:14 antares kernel: ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
Jul 15 12:01:14 antares kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[c5800000-c58007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
Jul 15 12:01:14 antares kernel: usb 1-2: new device found, idVendor=044f, idProduct=b303
Jul 15 12:01:14 antares kernel: usb 1-2: new device strings: Mfr=4, Product=30, SerialNumber=0
Jul 15 12:01:14 antares kernel: usb 1-2: Product: FireStorm Dual Analog 2
Jul 15 12:01:14 antares kernel: usb 1-2: Manufacturer: THRUSTMASTER
Jul 15 12:01:14 antares kernel: usb 1-2: configuration #1 chosen from 1 choice
Jul 15 12:01:14 antares kernel: ohci1394: fw-host0: Running dma failed because Node ID is not valid
Jul 15 12:01:14 antares kernel: input: THRUSTMASTER FireStorm Dual Analog 2 as /class/input/input2
Jul 15 12:01:14 antares kernel: input: USB HID v1.10 Gamepad [THRUSTMASTER FireStorm Dual Analog 2] on usb-0000:00:04.2-2
Jul 15 12:01:14 antares kernel: usbcore: registered new interface driver usbhid
Jul 15 12:01:14 antares kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Jul 15 12:01:14 antares kernel: warning: process `date' used the removed sysctl system call
Jul 15 12:01:14 antares kernel: ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
Jul 15 12:01:14 antares kernel: ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
Jul 15 12:01:14 antares kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jul 15 12:01:14 antares kernel: agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
Jul 15 12:01:14 antares kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Jul 15 12:01:14 antares kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00308d0120e085ca]
Jul 15 12:01:14 antares kernel: input: PC Speaker as /class/input/input3
Jul 15 12:01:14 antares kernel: Using specific hotkey driver
Jul 15 12:01:14 antares kernel: EXT3 FS on dm-4, internal journal
Jul 15 12:01:14 antares kernel: Adding 257000k swap on /dev/hdb6.  Priority:1 extents:1 across:257000k
Jul 15 12:01:14 antares kernel: Adding 64220k swap on /dev/hda5.  Priority:2 extents:1 across:64220k
Jul 15 12:01:14 antares kernel: Adding 795208k swap on /dev/hdb7.  Priority:2 extents:1 across:795208k
Jul 15 12:01:14 antares kernel: ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
Jul 15 12:01:14 antares kernel: ReiserFS: dm-1: using ordered data mode
Jul 15 12:01:14 antares kernel: ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jul 15 12:01:14 antares kernel: ReiserFS: dm-1: checking transaction log (dm-1)
Jul 15 12:01:14 antares kernel: ReiserFS: dm-1: Using r5 hash to sort names
Jul 15 12:01:14 antares kernel: Loading Reiser4. See www.namesys.com for a description of Reiser4.
Jul 15 12:01:14 antares kernel: ps_hash_table: 32 buckets
Jul 15 12:01:14 antares kernel: d_cursor_hash_table: 256 buckets
Jul 15 12:01:14 antares kernel: z_hash_table: 8192 buckets
Jul 15 12:01:14 antares kernel: z_hash_table: 8192 buckets
Jul 15 12:01:14 antares kernel: j_hash_table: 16384 buckets
Jul 15 12:01:14 antares kernel: loading reiser4 bitmap......done (33 jiffies)
Jul 15 12:01:14 antares kernel: ReiserFS: hda7: found reiserfs format "3.6" with standard journal
Jul 15 12:01:14 antares kernel: ReiserFS: hda7: using ordered data mode
Jul 15 12:01:14 antares kernel: ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jul 15 12:01:14 antares kernel: ReiserFS: hda7: checking transaction log (hda7)
Jul 15 12:01:14 antares kernel: ReiserFS: hda7: Using r5 hash to sort names
Jul 15 12:01:14 antares kernel: ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
Jul 15 12:01:14 antares kernel: ReiserFS: dm-0: using ordered data mode
Jul 15 12:01:14 antares kernel: ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jul 15 12:01:14 antares kernel: ReiserFS: dm-0: checking transaction log (dm-0)
Jul 15 12:01:14 antares kernel: ReiserFS: dm-0: Using r5 hash to sort names
Jul 15 12:01:14 antares kernel: kjournald starting.  Commit interval 5 seconds
Jul 15 12:01:14 antares kernel: EXT3 FS on dm-2, internal journal
Jul 15 12:01:14 antares kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 15 12:01:14 antares kernel: ReiserFS: dm-6: found reiserfs format "3.6" with standard journal
Jul 15 12:01:14 antares kernel: ReiserFS: dm-6: using ordered data mode
Jul 15 12:01:14 antares kernel: ReiserFS: dm-6: journal params: device dm-6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jul 15 12:01:14 antares kernel: ReiserFS: dm-6: checking transaction log (dm-6)
Jul 15 12:01:14 antares kernel: ReiserFS: dm-6: Using r5 hash to sort names
Jul 15 12:01:14 antares kernel: loop: loaded (max 8 devices)
Jul 15 12:01:14 antares kernel: hdc: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Jul 15 12:01:14 antares kernel: Uniform CD-ROM driver Revision: 3.20
Jul 15 12:01:14 antares kernel: hdd: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
Jul 15 12:01:14 antares kernel: hda: cache flushes not supported
Jul 15 12:01:14 antares kernel: warning: process `ls' used the removed sysctl system call
Jul 15 12:01:14 antares kernel: warning: process `prcsys' used the removed sysctl system call
Jul 15 12:01:14 antares kernel: warning: process `sleep' used the removed sysctl system call
Jul 15 12:01:24 antares INIT: Loading pktcdvd module successfull
Jul 15 12:01:24 antares kernel: pktcdvd: writer pktcdvd0 mapped to hdc
Jul 15 12:01:59 antares kernel: 
Jul 15 12:01:59 antares kernel: =============================================
Jul 15 12:01:59 antares kernel: [ INFO: possible recursive locking detected ]
Jul 15 12:01:59 antares kernel: ---------------------------------------------
Jul 15 12:01:59 antares kernel: mount/1176 is trying to acquire lock:
Jul 15 12:01:59 antares kernel:  (&bdev->bd_mutex){--..}, at: [do_open+107/957] do_open+0x6b/0x3bd
Jul 15 12:01:59 antares kernel:  (&bdev->bd_mutex){--..}, at: [<c0159c10>] do_open+0x6b/0x3bd
Jul 15 12:01:59 antares kernel: 
Jul 15 12:01:59 antares kernel: but task is already holding lock:
Jul 15 12:01:59 antares kernel:  (&bdev->bd_mutex){--..}, at: [do_open+107/957] do_open+0x6b/0x3bd
Jul 15 12:01:59 antares kernel:  (&bdev->bd_mutex){--..}, at: [<c0159c10>] do_open+0x6b/0x3bd
Jul 15 12:01:59 antares kernel: 
Jul 15 12:01:59 antares kernel: other info that might help us debug this:
Jul 15 12:01:59 antares kernel: 2 locks held by mount/1176:
Jul 15 12:01:59 antares kernel:  #0:  (&bdev->bd_mutex){--..}, at: [do_open+107/957] do_open+0x6b/0x3bd
Jul 15 12:01:59 antares kernel:  #0:  (&bdev->bd_mutex){--..}, at: [<c0159c10>] do_open+0x6b/0x3bd
Jul 15 12:01:59 antares kernel:  #1:  (&ctl_mutex#2){--..}, at: [mutex_lock+33/36] mutex_lock+0x21/0x24
Jul 15 12:01:59 antares kernel:  #1:  (&ctl_mutex#2){--..}, at: [<c0290dca>] mutex_lock+0x21/0x24
Jul 15 12:01:59 antares kernel: 
Jul 15 12:01:59 antares kernel: stack backtrace:
Jul 15 12:01:59 antares kernel:  [show_trace+13/16] show_trace+0xd/0x10
Jul 15 12:01:59 antares kernel:  [<c0104db5>] show_trace+0xd/0x10
Jul 15 12:01:59 antares kernel:  [dump_stack+25/28] dump_stack+0x19/0x1c
Jul 15 12:01:59 antares kernel:  [<c0104dd1>] dump_stack+0x19/0x1c
Jul 15 12:01:59 antares kernel:  [__lock_acquire+1916/2469] __lock_acquire+0x77c/0x9a5
Jul 15 12:01:59 antares kernel:  [<c012c95a>] __lock_acquire+0x77c/0x9a5
Jul 15 12:01:59 antares kernel:  [lock_acquire+96/128] lock_acquire+0x60/0x80
Jul 15 12:01:59 antares kernel:  [<c012cbe3>] lock_acquire+0x60/0x80
Jul 15 12:01:59 antares kernel:  [mutex_lock_nested+191/512] mutex_lock_nested+0xbf/0x200
Jul 15 12:01:59 antares kernel:  [<c0290e8c>] mutex_lock_nested+0xbf/0x200
Jul 15 12:01:59 antares kernel:  [do_open+107/957] do_open+0x6b/0x3bd
Jul 15 12:01:59 antares kernel:  [<c0159c10>] do_open+0x6b/0x3bd
Jul 15 12:01:59 antares kernel:  [blkdev_get+110/121] blkdev_get+0x6e/0x79
Jul 15 12:01:59 antares kernel:  [<c0159fd0>] blkdev_get+0x6e/0x79
Jul 15 12:01:59 antares kernel:  [<e1138345>] pkt_open+0x99/0xbf4 [pktcdvd]
Jul 15 12:01:59 antares kernel:  [do_open+161/957] do_open+0xa1/0x3bd
Jul 15 12:01:59 antares kernel:  [<c0159c46>] do_open+0xa1/0x3bd
Jul 15 12:01:59 antares kernel:  [blkdev_open+31/72] blkdev_open+0x1f/0x48
Jul 15 12:01:59 antares kernel:  [<c015a10d>] blkdev_open+0x1f/0x48
Jul 15 12:01:59 antares kernel:  [__dentry_open+184/390] __dentry_open+0xb8/0x186
Jul 15 12:01:59 antares kernel:  [<c0151c8f>] __dentry_open+0xb8/0x186
Jul 15 12:01:59 antares kernel:  [nameidata_to_filp+28/46] nameidata_to_filp+0x1c/0x2e
Jul 15 12:01:59 antares kernel:  [<c0151dcb>] nameidata_to_filp+0x1c/0x2e
Jul 15 12:01:59 antares kernel:  [do_filp_open+46/53] do_filp_open+0x2e/0x35
Jul 15 12:01:59 antares kernel:  [<c0151e0b>] do_filp_open+0x2e/0x35
Jul 15 12:01:59 antares kernel:  [do_sys_open+64/187] do_sys_open+0x40/0xbb
Jul 15 12:01:59 antares kernel:  [<c0152ce9>] do_sys_open+0x40/0xbb
Jul 15 12:01:59 antares kernel:  [sys_open+22/24] sys_open+0x16/0x18
Jul 15 12:01:59 antares kernel:  [<c0152d90>] sys_open+0x16/0x18
Jul 15 12:01:59 antares kernel:  [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
Jul 15 12:01:59 antares kernel:  [<c0102c2d>] sysenter_past_esp+0x56/0x8d
Jul 15 12:02:01 antares kernel: UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'flexbackup', timestamp 2006/03/17 15:29 (1078)
Jul 15 12:04:22 antares shutdown[1183]: shutting down for system reboot
Jul 15 12:04:22 antares init: Switching to runlevel: 6


--------------020600070806020000040007--
