Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVJDVmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVJDVmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVJDVmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:42:52 -0400
Received: from yzis.org ([82.233.104.105]:29579 "EHLO moria.freenux.org")
	by vger.kernel.org with ESMTP id S964991AbVJDVmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:42:50 -0400
Message-ID: <4342F755.6050508@freenux.org>
Date: Tue, 04 Oct 2005 23:42:45 +0200
From: Mickael Marchand <mikmak@freenux.org>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: reiserfs-dev@namesys.com
Subject: Re: 2.6.14-rc2-mm2
References: <20050929143732.59d22569.akpm@osdl.org> <433D93C4.4040508@freenux.org>
In-Reply-To: <433D93C4.4040508@freenux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got it to give me a backtrace using the softlockup thingy

here it is (kernel 2.6.14-rc3 + reiser4 patch from 
ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.13/reiser4-for-2.6.13-2.broken-out.tar.gz)

from memory I got the same backtrace using stock -mm2 (was not able to 
dump it to disk at that time)

Cheers,
Mik

Oct  4 21:31:38 localhost kernel: BUG: soft lockup detected on CPU#1!
Oct  4 21:31:38 localhost kernel: CPU 1:
Oct  4 21:31:38 localhost kernel: Modules linked in:
Oct  4 21:31:38 localhost kernel: Pid: 2513, comm: apt-get Not tainted 
2.6.14-rc3 #1
Oct  4 21:31:38 localhost kernel: RIP: 0010:[<ffffffff80210c3a>] 
<ffffffff80210c3a>{writepages_unix_file+1226}
Oct  4 21:31:38 localhost kernel: RSP: 0018:ffff81005d165d58  EFLAGS: 
00000286
Oct  4 21:31:38 localhost kernel: RAX: ffff81005d4d69e0 RBX: 
ffff81005cd23158 RCX: ffff81005d165e78
Oct  4 21:31:38 localhost kernel: RDX: 0000000000000000 RSI: 
ffffffffffffffc0 RDI: ffff81005cd23290
Oct  4 21:31:38 localhost kernel: RBP: ffff81005d165cc0 R08: 
0000000000000006 R09: 0000000000000040
Oct  4 21:31:38 localhost kernel: R10: 0000000000000040 R11: 
0000000000000040 R12: ffff81005d165cc0
Oct  4 21:31:38 localhost kernel: R13: ffff81005d165cb0 R14: 
ffff81005d165cb0 R15: 0000000000000000
Oct  4 21:31:38 localhost kernel: FS:  00002aaaab46f0b0(0000) 
GS:ffffffff806be880(0000) knlGS:0000000000000000
Oct  4 21:31:38 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Oct  4 21:31:38 localhost kernel: CR2: 00007fffff86dff8 CR3: 
000000005de98000 CR4: 00000000000006e0
Oct  4 21:31:38 localhost kernel:
Oct  4 21:31:38 localhost kernel: Call 
Trace:<ffffffff80210957>{writepages_unix_file+487} 
<ffffffff802fef51>{__up_read+33}
Oct  4 21:31:38 localhost kernel: 
<ffffffff801582f2>{__filemap_fdatawrite_range+82} 
<ffffffff80171622>{msync_interval+802}
Oct  4 21:31:38 localhost kernel: 
<ffffffff80171846>{sys_msync+262} <ffffffff8010dc8e>{system_call+126}
Oct  4 21:31:38 localhost kernel:




Mickael Marchand wrote:
> Hi all,
> 
> I am getting a recurrent locking bug with reiser4 on a dual core 64 bits 
> machine, running debian unstable amd64
> (MB : ASUS A8V, SATA drive)
> 
> whenever I apt-get update, the process locks up when apt-get tries to 
> msync on the /var/lib/dpkg/status file (according to strace)
> The machine is still usable for some minutes, then everything slowly 
> starts to get frozen.
> After rebooting the FS is corrupted and needs a --build-fs to get 
> corrected (btw, there is still this old bug where
> when you --build-fs the filesystem is still marked as corrupted and you 
> need to rerun a fsck.reiser4 to unmark it  and be able to mount it 
> read-write  ...)
> 
> well,
> this is fully and always reproducible on mm2 and mm1,
> I also tried a 2.6.14-rc1 with just reiser4 patches and 2.6.13 with 
> reiser4 patch (the one posted yesterday by Hans iirc), and it's also 
> reproducible there.
> 
> I tried to get more infos but it does not look much helpful :
> 
> Sep 30 21:10:35 alhya kernel: bash          S 0000002733277f96     0  
> 5488   5432  5495               (NOTLB)
> Sep 30 21:10:35 alhya kernel: ffff810053a29eb8 0000000000000082 
> ffff810053a29f58 ffffffff804e6df3
> Sep 30 21:10:35 alhya kernel:        0000000000002569 ffff81005efb2540 
> ffff81005efb2320 ffffffff8058cb40
> Sep 30 21:10:35 alhya kernel:        ffff810053a29ea8 00000000ffffffff
> Sep 30 21:10:35 alhya kernel: Call 
> Trace:<ffffffff804e6df3>{_spin_unlock_irqrestore+19} 
> <ffffffff8013a94f>{do_wait+2767}
> Sep 30 21:10:35 alhya kernel:        
> <ffffffff80132720>{default_wake_function+0} 
> <ffffffff80195f79>{sys_ioctl+73}
> Sep 30 21:10:35 alhya kernel:        <ffffffff8010dd6e>{system_call+126}
> Sep 30 21:10:35 alhya kernel: apt-get       R  running task       0  
> 5495   5488                     (NOTLB)
> Sep 30 21:10:35 alhya kernel: SysRq : Show State
> 
> it just does not show anything for apt :/
> 
> tell me if I can give more infos,
> 
> Cheers,
> Mik
> 
> 
> ------------------------------------------------------------------------
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.14-rc2-mm2
> # Fri Sep 30 20:06:21 2005
> #
> CONFIG_X86_64=y
> CONFIG_64BIT=y
> CONFIG_X86=y
> CONFIG_SEMAPHORE_SLEEPERS=y
> CONFIG_MMU=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> # CONFIG_CLEAN_COMPILE is not set
> CONFIG_BROKEN=y
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_LOCK_KERNEL=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> 
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_HOTPLUG=y
> CONFIG_KOBJECT_UEVENT=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_CPUSETS is not set
> CONFIG_INITRAMFS_SOURCE=""
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SHMEM=y
> CONFIG_CC_ALIGN_FUNCTIONS=0
> CONFIG_CC_ALIGN_LABELS=0
> CONFIG_CC_ALIGN_LOOPS=0
> CONFIG_CC_ALIGN_JUMPS=0
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=0
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> CONFIG_OBSOLETE_MODPARM=y
> CONFIG_MODVERSIONS=y
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_KMOD=y
> CONFIG_STOP_MACHINE=y
> 
> #
> # Processor type and features
> #
> CONFIG_MK8=y
> # CONFIG_MPSC is not set
> # CONFIG_GENERIC_CPU is not set
> CONFIG_X86_L1_CACHE_BYTES=64
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_MTRR=y
> CONFIG_SMP=y
> # CONFIG_SCHED_SMT is not set
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_BKL=y
> CONFIG_K8_NUMA=y
> # CONFIG_NUMA_EMU is not set
> CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
> CONFIG_NUMA=y
> CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_SELECT_MEMORY_MODEL=y
> # CONFIG_FLATMEM_MANUAL is not set
> CONFIG_DISCONTIGMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_DISCONTIGMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_NEED_MULTIPLE_NODES=y
> # CONFIG_SPARSEMEM_STATIC is not set
> CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
> CONFIG_NR_CPUS=2
> # CONFIG_HOTPLUG_CPU is not set
> CONFIG_HPET_TIMER=y
> CONFIG_X86_PM_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_GART_IOMMU=y
> CONFIG_SWIOTLB=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_INTEL is not set
> CONFIG_X86_MCE_AMD=y
> CONFIG_PHYSICAL_START=0x100000
> # CONFIG_KEXEC is not set
> CONFIG_SECCOMP=y
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> CONFIG_GENERIC_HARDIRQS=y
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_ISA_DMA_API=y
> CONFIG_GENERIC_PENDING_IRQ=y
> 
> #
> # Power management options
> #
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> # CONFIG_ACPI_HOTKEY is not set
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_NUMA is not set
> # CONFIG_ACPI_ASUS is not set
> CONFIG_ACPI_IBM=m
> CONFIG_ACPI_TOSHIBA=y
> CONFIG_ACPI_BLACKLIST_YEAR=0
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_ACPI_CONTAINER is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> # CONFIG_UNORDERED_IO is not set
> CONFIG_PCIEPORTBUS=y
> CONFIG_PCI_MSI=y
> CONFIG_PCI_LEGACY_PROC=y
> # CONFIG_PCI_DEBUG is not set
> 
> #
> # PCCARD (PCMCIA/CardBus) support
> #
> # CONFIG_PCCARD is not set
> 
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # Executable file formats / Emulations
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=y
> CONFIG_IA32_EMULATION=y
> CONFIG_IA32_AOUT=y
> CONFIG_COMPAT=y
> CONFIG_SYSVIPC_COMPAT=y
> CONFIG_UID16=y
> 
> #
> # Networking
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_UNIX=y
> CONFIG_XFRM=y
> CONFIG_XFRM_USER=m
> CONFIG_NET_KEY=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_FIB_HASH=y
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE=m
> CONFIG_NET_IPGRE_BROADCAST=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> # CONFIG_ARPD is not set
> CONFIG_SYN_COOKIES=y
> CONFIG_INET_AH=m
> CONFIG_INET_ESP=m
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_TUNNEL=m
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_BIC=y
> 
> #
> # IP: Virtual Server Configuration
> #
> # CONFIG_IP_VS is not set
> CONFIG_IPV6=m
> CONFIG_IPV6_PRIVACY=y
> CONFIG_INET6_AH=m
> CONFIG_INET6_ESP=m
> CONFIG_INET6_IPCOMP=m
> CONFIG_INET6_TUNNEL=m
> CONFIG_IPV6_TUNNEL=m
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_NETFILTER_NETLINK=m
> CONFIG_NETFILTER_NETLINK_QUEUE=m
> CONFIG_NETFILTER_NETLINK_LOG=m
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=m
> # CONFIG_IP_NF_CT_ACCT is not set
> # CONFIG_IP_NF_CONNTRACK_MARK is not set
> # CONFIG_IP_NF_CONNTRACK_EVENTS is not set
> # CONFIG_IP_NF_CONNTRACK_NETLINK is not set
> # CONFIG_IP_NF_CT_PROTO_SCTP is not set
> CONFIG_IP_NF_FTP=m
> CONFIG_IP_NF_IRC=m
> # CONFIG_IP_NF_NETBIOS_NS is not set
> CONFIG_IP_NF_TFTP=m
> CONFIG_IP_NF_AMANDA=m
> # CONFIG_IP_NF_PPTP is not set
> CONFIG_IP_NF_QUEUE=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_LIMIT=m
> CONFIG_IP_NF_MATCH_IPRANGE=m
> CONFIG_IP_NF_MATCH_MAC=m
> CONFIG_IP_NF_MATCH_PKTTYPE=m
> CONFIG_IP_NF_MATCH_MARK=m
> CONFIG_IP_NF_MATCH_MULTIPORT=m
> CONFIG_IP_NF_MATCH_TOS=m
> CONFIG_IP_NF_MATCH_RECENT=m
> CONFIG_IP_NF_MATCH_ECN=m
> CONFIG_IP_NF_MATCH_DSCP=m
> CONFIG_IP_NF_MATCH_AH_ESP=m
> CONFIG_IP_NF_MATCH_LENGTH=m
> CONFIG_IP_NF_MATCH_TTL=m
> CONFIG_IP_NF_MATCH_TCPMSS=m
> CONFIG_IP_NF_MATCH_HELPER=m
> CONFIG_IP_NF_MATCH_STATE=m
> CONFIG_IP_NF_MATCH_CONNTRACK=m
> CONFIG_IP_NF_MATCH_OWNER=m
> CONFIG_IP_NF_MATCH_ADDRTYPE=m
> CONFIG_IP_NF_MATCH_REALM=m
> # CONFIG_IP_NF_MATCH_SCTP is not set
> # CONFIG_IP_NF_MATCH_DCCP is not set
> # CONFIG_IP_NF_MATCH_COMMENT is not set
> # CONFIG_IP_NF_MATCH_HASHLIMIT is not set
> # CONFIG_IP_NF_MATCH_STRING is not set
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_LOG=m
> CONFIG_IP_NF_TARGET_ULOG=m
> CONFIG_IP_NF_TARGET_TCPMSS=m
> CONFIG_IP_NF_TARGET_NFQUEUE=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> CONFIG_IP_NF_TARGET_NETMAP=m
> CONFIG_IP_NF_TARGET_SAME=m
> CONFIG_IP_NF_NAT_SNMP_BASIC=m
> CONFIG_IP_NF_NAT_IRC=m
> CONFIG_IP_NF_NAT_FTP=m
> CONFIG_IP_NF_NAT_TFTP=m
> CONFIG_IP_NF_NAT_AMANDA=m
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_TARGET_TOS=m
> CONFIG_IP_NF_TARGET_ECN=m
> CONFIG_IP_NF_TARGET_DSCP=m
> CONFIG_IP_NF_TARGET_MARK=m
> CONFIG_IP_NF_TARGET_CLASSIFY=m
> # CONFIG_IP_NF_TARGET_TTL is not set
> CONFIG_IP_NF_RAW=m
> CONFIG_IP_NF_TARGET_NOTRACK=m
> CONFIG_IP_NF_ARPTABLES=m
> CONFIG_IP_NF_ARPFILTER=m
> CONFIG_IP_NF_ARP_MANGLE=m
> 
> #
> # IPv6: Netfilter Configuration (EXPERIMENTAL)
> #
> CONFIG_IP6_NF_QUEUE=m
> CONFIG_IP6_NF_IPTABLES=m
> CONFIG_IP6_NF_MATCH_LIMIT=m
> CONFIG_IP6_NF_MATCH_MAC=m
> CONFIG_IP6_NF_MATCH_RT=m
> CONFIG_IP6_NF_MATCH_OPTS=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> CONFIG_IP6_NF_MATCH_HL=m
> CONFIG_IP6_NF_MATCH_MULTIPORT=m
> CONFIG_IP6_NF_MATCH_OWNER=m
> CONFIG_IP6_NF_MATCH_MARK=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_MATCH_AHESP=m
> CONFIG_IP6_NF_MATCH_LENGTH=m
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_LOG=m
> CONFIG_IP6_NF_TARGET_REJECT=m
> CONFIG_IP6_NF_TARGET_NFQUEUE=m
> CONFIG_IP6_NF_MANGLE=m
> CONFIG_IP6_NF_TARGET_MARK=m
> # CONFIG_IP6_NF_TARGET_HL is not set
> CONFIG_IP6_NF_RAW=m
> 
> #
> # DCCP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_DCCP is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IP_SCTP=m
> CONFIG_SCTP_DBG_MSG=y
> CONFIG_SCTP_DBG_OBJCNT=y
> CONFIG_SCTP_HMAC_NONE=y
> # CONFIG_SCTP_HMAC_SHA1 is not set
> # CONFIG_SCTP_HMAC_MD5 is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> CONFIG_LLC=m
> # CONFIG_LLC2 is not set
> CONFIG_IPX=m
> CONFIG_IPX_INTERN=y
> CONFIG_ATALK=m
> CONFIG_DEV_APPLETALK=y
> CONFIG_IPDDP=m
> CONFIG_IPDDP_ENCAP=y
> CONFIG_IPDDP_DECAP=y
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_SCHED is not set
> CONFIG_NET_CLS_ROUTE=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> CONFIG_IEEE80211=m
> # CONFIG_IEEE80211_DEBUG is not set
> CONFIG_IEEE80211_CRYPT_WEP=m
> CONFIG_IEEE80211_CRYPT_CCMP=m
> CONFIG_IEEE80211_CRYPT_TKIP=m
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> # CONFIG_DEBUG_DRIVER is not set
> 
> #
> # Connector - unified userspace <-> kernelspace linker
> #
> CONFIG_CONNECTOR=m
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_SERIAL=m
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_PC_SUPERIO=y
> CONFIG_PARPORT_NOT_PC=y
> # CONFIG_PARPORT_GSC is not set
> CONFIG_PARPORT_1284=y
> 
> #
> # Plug and Play support
> #
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> CONFIG_PARIDE=m
> CONFIG_PARIDE_PARPORT=m
> 
> #
> # Parallel IDE high-level drivers
> #
> CONFIG_PARIDE_PD=m
> CONFIG_PARIDE_PCD=m
> CONFIG_PARIDE_PF=m
> CONFIG_PARIDE_PT=m
> CONFIG_PARIDE_PG=m
> 
> #
> # Parallel IDE protocol modules
> #
> CONFIG_PARIDE_ATEN=m
> CONFIG_PARIDE_BPCK=m
> CONFIG_PARIDE_COMM=m
> CONFIG_PARIDE_DSTR=m
> CONFIG_PARIDE_FIT2=m
> CONFIG_PARIDE_FIT3=m
> CONFIG_PARIDE_EPAT=m
> CONFIG_PARIDE_EPATC8=y
> CONFIG_PARIDE_EPIA=m
> CONFIG_PARIDE_FRIQ=m
> CONFIG_PARIDE_FRPW=m
> CONFIG_PARIDE_KBIC=m
> CONFIG_PARIDE_KTTI=m
> CONFIG_PARIDE_ON20=m
> CONFIG_PARIDE_ON26=m
> CONFIG_BLK_CPQ_DA=m
> CONFIG_BLK_CPQ_CISS_DA=m
> CONFIG_CISS_SCSI_TAPE=y
> CONFIG_BLK_DEV_DAC960=m
> CONFIG_BLK_DEV_UMEM=m
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_CRYPTOLOOP=m
> CONFIG_BLK_DEV_NBD=m
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_UB is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_LBD=y
> CONFIG_CDROM_PKTCDVD=y
> CONFIG_CDROM_PKTCDVD_BUFFERS=8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_DEFAULT_AS=y
> # CONFIG_DEFAULT_DEADLINE is not set
> # CONFIG_DEFAULT_CFQ is not set
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="anticipatory"
> # CONFIG_ATA_OVER_ETH is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> CONFIG_BLK_DEV_IDESCSI=m
> # CONFIG_IDE_TASK_IOCTL is not set
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_IDE_GENERIC=y
> CONFIG_BLK_DEV_CMD640=y
> CONFIG_BLK_DEV_CMD640_ENHANCED=y
> CONFIG_BLK_DEV_IDEPNP=y
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_IDEPCI_SHARE_IRQ is not set
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=y
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_AEC62XX=m
> CONFIG_BLK_DEV_ALI15X3=m
> CONFIG_WDC_ALI15X3=y
> CONFIG_BLK_DEV_AMD74XX=y
> # CONFIG_BLK_DEV_ATIIXP is not set
> CONFIG_BLK_DEV_CMD64X=y
> CONFIG_BLK_DEV_TRIFLEX=m
> CONFIG_BLK_DEV_CY82C693=m
> CONFIG_BLK_DEV_CS5520=m
> CONFIG_BLK_DEV_CS5530=m
> CONFIG_BLK_DEV_HPT34X=m
> CONFIG_HPT34X_AUTODMA=y
> CONFIG_BLK_DEV_HPT366=m
> CONFIG_BLK_DEV_SC1200=m
> CONFIG_BLK_DEV_PIIX=m
> # CONFIG_BLK_DEV_IT821X is not set
> CONFIG_BLK_DEV_NS87415=m
> CONFIG_BLK_DEV_PDC202XX_OLD=m
> # CONFIG_PDC202XX_BURST is not set
> CONFIG_BLK_DEV_PDC202XX_NEW=m
> # CONFIG_PDC202XX_FORCE is not set
> CONFIG_BLK_DEV_SVWKS=m
> CONFIG_BLK_DEV_SIIMAGE=m
> CONFIG_BLK_DEV_SIS5513=m
> CONFIG_BLK_DEV_SLC90E66=m
> CONFIG_BLK_DEV_TRM290=m
> CONFIG_BLK_DEV_VIA82CXXX=y
> # CONFIG_IDE_ARM is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_CHR_DEV_ST=y
> CONFIG_CHR_DEV_OSST=y
> CONFIG_BLK_DEV_SR=m
> CONFIG_BLK_DEV_SR_VENDOR=y
> CONFIG_CHR_DEV_SG=y
> # CONFIG_CHR_DEV_SCH is not set
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_MULTI_LUN=y
> # CONFIG_SCSI_CONSTANTS is not set
> CONFIG_SCSI_LOGGING=y
> 
> #
> # SCSI Transport Attributes
> #
> CONFIG_SCSI_SPI_ATTRS=y
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> # CONFIG_SCSI_SAS_ATTRS is not set
> 
> #
> # SCSI Transport Layers
> #
> # CONFIG_SAS_CLASS is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_SCSI_ARCMSR is not set
> CONFIG_BLK_DEV_3W_XXXX_RAID=y
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
> CONFIG_AIC7XXX_RESET_DELAY_MS=15000
> # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
> CONFIG_AIC7XXX_DEBUG_MASK=0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> CONFIG_SCSI_AIC79XX=y
> CONFIG_AIC79XX_CMDS_PER_DEVICE=32
> CONFIG_AIC79XX_RESET_DELAY_MS=15000
> # CONFIG_AIC79XX_ENABLE_RD_STRM is not set
> # CONFIG_AIC79XX_DEBUG_ENABLE is not set
> CONFIG_AIC79XX_DEBUG_MASK=0
> CONFIG_AIC79XX_REG_PRETTY_PRINT=y
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> CONFIG_SCSI_SATA=y
> # CONFIG_SCSI_ATA_ADMA is not set
> # CONFIG_SCSI_SATA_AHCI is not set
> # CONFIG_SCSI_SATA_SVW is not set
> # CONFIG_SCSI_ATA_PIIX is not set
> # CONFIG_SCSI_SATA_MV is not set
> # CONFIG_SCSI_SATA_NV is not set
> # CONFIG_SCSI_SATA_PROMISE is not set
> # CONFIG_SCSI_SATA_QSTOR is not set
> # CONFIG_SCSI_SATA_SX4 is not set
> # CONFIG_SCSI_SATA_SIL is not set
> # CONFIG_SCSI_SATA_SIL24 is not set
> # CONFIG_SCSI_SATA_SIS is not set
> # CONFIG_SCSI_SATA_ULI is not set
> CONFIG_SCSI_SATA_VIA=y
> # CONFIG_SCSI_SATA_VITESSE is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> CONFIG_SCSI_IMM=m
> # CONFIG_SCSI_IZIP_EPP16 is not set
> # CONFIG_SCSI_IZIP_SLOW_CTR is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> CONFIG_SCSI_QLA2XXX=y
> # CONFIG_SCSI_QLA21XX is not set
> # CONFIG_SCSI_QLA22XX is not set
> # CONFIG_SCSI_QLA2300 is not set
> # CONFIG_SCSI_QLA2322 is not set
> # CONFIG_SCSI_QLA6312 is not set
> # CONFIG_SCSI_QLA24XX is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_LINEAR=y
> CONFIG_MD_RAID0=y
> CONFIG_MD_RAID1=y
> CONFIG_MD_RAID10=y
> CONFIG_MD_RAID5=y
> CONFIG_MD_RAID6=y
> CONFIG_MD_MULTIPATH=y
> # CONFIG_MD_FAULTY is not set
> CONFIG_BLK_DEV_DM=y
> CONFIG_DM_CRYPT=y
> CONFIG_DM_SNAPSHOT=y
> CONFIG_DM_MIRROR=y
> CONFIG_DM_ZERO=y
> CONFIG_DM_MULTIPATH=y
> CONFIG_DM_MULTIPATH_EMC=y
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> # CONFIG_FUSION_SPI is not set
> # CONFIG_FUSION_FC is not set
> # CONFIG_FUSION_SAS is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_IEEE1394=m
> 
> #
> # Subsystem Options
> #
> # CONFIG_IEEE1394_VERBOSEDEBUG is not set
> CONFIG_IEEE1394_OUI_DB=y
> CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
> CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
> # CONFIG_IEEE1394_EXPORT_FULL_API is not set
> 
> #
> # Device Drivers
> #
> # CONFIG_IEEE1394_PCILYNX is not set
> CONFIG_IEEE1394_OHCI1394=m
> 
> #
> # Protocol Drivers
> #
> CONFIG_IEEE1394_VIDEO1394=m
> CONFIG_IEEE1394_SBP2=m
> CONFIG_IEEE1394_SBP2_PHYS_DMA=y
> CONFIG_IEEE1394_ETH1394=m
> CONFIG_IEEE1394_DV1394=m
> CONFIG_IEEE1394_RAWIO=m
> CONFIG_IEEE1394_CMP=m
> CONFIG_IEEE1394_AMDTP=m
> 
> #
> # I2O device support
> #
> CONFIG_I2O=m
> # CONFIG_I2O_EXT_ADAPTEC is not set
> CONFIG_I2O_CONFIG=m
> # CONFIG_I2O_CONFIG_OLD_IOCTL is not set
> # CONFIG_I2O_BUS is not set
> CONFIG_I2O_BLOCK=m
> CONFIG_I2O_SCSI=m
> CONFIG_I2O_PROC=m
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_TUN=m
> # CONFIG_NET_SB1000 is not set
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> 
> #
> # PHY device support
> #
> CONFIG_PHYLIB=m
> 
> #
> # MII PHY device drivers
> #
> CONFIG_MARVELL_PHY=m
> CONFIG_DAVICOM_PHY=m
> CONFIG_QSEMI_PHY=m
> CONFIG_LXT_PHY=m
> # CONFIG_CICADA_PHY is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> CONFIG_HAPPYMEAL=m
> CONFIG_SUNGEM=m
> CONFIG_NET_VENDOR_3COM=y
> CONFIG_VORTEX=m
> CONFIG_TYPHOON=m
> 
> #
> # Tulip family network device support
> #
> CONFIG_NET_TULIP=y
> CONFIG_DE2104X=m
> CONFIG_TULIP=m
> CONFIG_TULIP_MWI=y
> CONFIG_TULIP_MMIO=y
> CONFIG_TULIP_NAPI=y
> CONFIG_TULIP_NAPI_HW_MITIGATION=y
> CONFIG_DE4X5=m
> CONFIG_WINBOND_840=m
> CONFIG_DM9102=m
> CONFIG_ULI526X=m
> CONFIG_HP100=m
> CONFIG_NET_PCI=y
> CONFIG_PCNET32=m
> CONFIG_AMD8111_ETH=y
> CONFIG_AMD8111E_NAPI=y
> CONFIG_ADAPTEC_STARFIRE=m
> # CONFIG_ADAPTEC_STARFIRE_NAPI is not set
> CONFIG_B44=m
> CONFIG_FORCEDETH=m
> CONFIG_DGRS=m
> CONFIG_EEPRO100=m
> CONFIG_E100=m
> CONFIG_FEALNX=m
> CONFIG_NATSEMI=m
> CONFIG_NE2K_PCI=m
> CONFIG_8139CP=m
> CONFIG_8139TOO=m
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
> CONFIG_SIS900=m
> CONFIG_EPIC100=m
> CONFIG_SUNDANCE=m
> CONFIG_SUNDANCE_MMIO=y
> CONFIG_VIA_RHINE=m
> CONFIG_VIA_RHINE_MMIO=y
> 
> #
> # Ethernet (1000 Mbit)
> #
> CONFIG_ACENIC=m
> # CONFIG_ACENIC_OMIT_TIGON_I is not set
> CONFIG_DL2K=m
> CONFIG_E1000=m
> # CONFIG_E1000_NAPI is not set
> CONFIG_NS83820=m
> CONFIG_HAMACHI=m
> CONFIG_YELLOWFIN=m
> CONFIG_R8169=m
> # CONFIG_R8169_NAPI is not set
> CONFIG_SIS190=m
> CONFIG_SKGE=m
> CONFIG_SKY2=m
> CONFIG_SKY2_EC_A1=y
> CONFIG_SK98LIN=m
> CONFIG_VIA_VELOCITY=m
> CONFIG_TIGON3=m
> CONFIG_BNX2=m
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> # CONFIG_IPW2200 is not set
> # CONFIG_HOSTAP is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PLIP=m
> CONFIG_PPP=m
> CONFIG_PPP_MULTILINK=y
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_SYNC_TTY=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> # CONFIG_PPP_MPPE is not set
> CONFIG_PPPOE=m
> CONFIG_SLIP=m
> CONFIG_SLIP_COMPRESSED=y
> CONFIG_SLIP_SMART=y
> CONFIG_SLIP_MODE_SLIP6=y
> # CONFIG_NET_FC is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_KGDBOE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NETPOLL_RX is not set
> # CONFIG_NETPOLL_TRAP is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=m
> CONFIG_SERIO_CT82C710=y
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> CONFIG_GAMEPORT=m
> # CONFIG_GAMEPORT_NS558 is not set
> # CONFIG_GAMEPORT_L4 is not set
> # CONFIG_GAMEPORT_EMU10K1 is not set
> # CONFIG_GAMEPORT_FM801 is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_ACPI=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_PRINTER=m
> CONFIG_LP_CONSOLE=y
> CONFIG_PPDEV=m
> CONFIG_TIPAR=m
> 
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> CONFIG_HW_RANDOM=y
> CONFIG_NVRAM=y
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=y
> CONFIG_AGP_AMD64=y
> # CONFIG_AGP_INTEL is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> CONFIG_RAW_DRIVER=y
> # CONFIG_HPET is not set
> CONFIG_MAX_RAW_DEVS=256
> CONFIG_HANGCHECK_TIMER=y
> 
> #
> # TPM devices
> #
> # CONFIG_TCG_TPM is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=m
> CONFIG_I2C_CHARDEV=m
> 
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=m
> CONFIG_I2C_ALGOPCF=m
> # CONFIG_I2C_ALGOPCA is not set
> 
> #
> # I2C Hardware Bus support
> #
> CONFIG_I2C_ALI1535=m
> CONFIG_I2C_ALI1563=m
> CONFIG_I2C_ALI15X3=m
> CONFIG_I2C_AMD756=m
> # CONFIG_I2C_AMD756_S4882 is not set
> CONFIG_I2C_AMD8111=m
> CONFIG_I2C_I801=m
> CONFIG_I2C_I810=m
> # CONFIG_I2C_PIIX4 is not set
> CONFIG_I2C_ISA=m
> CONFIG_I2C_NFORCE2=m
> CONFIG_I2C_PARPORT=m
> CONFIG_I2C_PARPORT_LIGHT=m
> CONFIG_I2C_PROSAVAGE=m
> CONFIG_I2C_SAVAGE4=m
> CONFIG_SCx200_ACB=m
> CONFIG_I2C_SIS5595=m
> CONFIG_I2C_SIS630=m
> CONFIG_I2C_SIS96X=m
> # CONFIG_I2C_STUB is not set
> CONFIG_I2C_VIA=m
> CONFIG_I2C_VIAPRO=m
> CONFIG_I2C_VOODOO3=m
> # CONFIG_I2C_PCA_ISA is not set
> 
> #
> # Miscellaneous I2C Chip support
> #
> # CONFIG_SENSORS_DS1337 is not set
> # CONFIG_SENSORS_DS1374 is not set
> CONFIG_SENSORS_EEPROM=m
> CONFIG_SENSORS_PCF8574=m
> # CONFIG_SENSORS_PCA9539 is not set
> CONFIG_SENSORS_PCF8591=m
> CONFIG_SENSORS_RTC8564=m
> # CONFIG_SENSORS_MAX6875 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
> 
> #
> # Dallas's 1-wire bus
> #
> # CONFIG_W1 is not set
> 
> #
> # Hardware Monitoring support
> #
> CONFIG_HWMON=m
> CONFIG_HWMON_VID=m
> CONFIG_SENSORS_ADM1021=m
> CONFIG_SENSORS_ADM1025=m
> CONFIG_SENSORS_ADM1026=m
> CONFIG_SENSORS_ADM1031=m
> CONFIG_SENSORS_ADM9240=m
> CONFIG_SENSORS_ASB100=m
> CONFIG_SENSORS_ATXP1=m
> CONFIG_SENSORS_DS1621=m
> CONFIG_SENSORS_FSCHER=m
> # CONFIG_SENSORS_FSCPOS is not set
> CONFIG_SENSORS_GL518SM=m
> # CONFIG_SENSORS_GL520SM is not set
> CONFIG_SENSORS_IT87=m
> CONFIG_SENSORS_LM63=m
> CONFIG_SENSORS_LM75=m
> CONFIG_SENSORS_LM77=m
> CONFIG_SENSORS_LM78=m
> CONFIG_SENSORS_LM80=m
> CONFIG_SENSORS_LM83=m
> CONFIG_SENSORS_LM85=m
> CONFIG_SENSORS_LM87=m
> CONFIG_SENSORS_LM90=m
> # CONFIG_SENSORS_LM92 is not set
> CONFIG_SENSORS_MAX1619=m
> CONFIG_SENSORS_PC87360=m
> # CONFIG_SENSORS_SIS5595 is not set
> CONFIG_SENSORS_SMSC47M1=m
> CONFIG_SENSORS_SMSC47B397=m
> CONFIG_SENSORS_VIA686A=m
> CONFIG_SENSORS_W83781D=m
> CONFIG_SENSORS_W83792D=m
> CONFIG_SENSORS_W83L785TS=m
> CONFIG_SENSORS_W83627HF=m
> CONFIG_SENSORS_W83627EHF=m
> CONFIG_SENSORS_HDAPS=m
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Misc devices
> #
> # CONFIG_IBM_ASM is not set
> 
> #
> # Multimedia Capabilities Port drivers
> #
> 
> #
> # Multimedia devices
> #
> CONFIG_VIDEO_DEV=m
> 
> #
> # Video For Linux
> #
> 
> #
> # Video Adapters
> #
> CONFIG_VIDEO_BT848=m
> # CONFIG_VIDEO_SAA6588 is not set
> # CONFIG_VIDEO_BWQCAM is not set
> # CONFIG_VIDEO_CQCAM is not set
> # CONFIG_VIDEO_W9966 is not set
> # CONFIG_VIDEO_CPIA is not set
> # CONFIG_VIDEO_SAA5246A is not set
> # CONFIG_VIDEO_SAA5249 is not set
> # CONFIG_TUNER_3036 is not set
> # CONFIG_VIDEO_STRADIS is not set
> # CONFIG_VIDEO_ZORAN is not set
> # CONFIG_VIDEO_ZR36120 is not set
> # CONFIG_VIDEO_SAA7134 is not set
> # CONFIG_VIDEO_MXB is not set
> # CONFIG_VIDEO_DPC is not set
> # CONFIG_VIDEO_HEXIUM_ORION is not set
> # CONFIG_VIDEO_HEXIUM_GEMINI is not set
> # CONFIG_VIDEO_CX88 is not set
> # CONFIG_VIDEO_OVCAMCHIP is not set
> 
> #
> # Radio Adapters
> #
> # CONFIG_RADIO_GEMTEK_PCI is not set
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_MAESTRO is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
> CONFIG_VIDEO_TUNER=m
> CONFIG_VIDEO_BUF=m
> CONFIG_VIDEO_BTCX=m
> CONFIG_VIDEO_IR=m
> CONFIG_VIDEO_TVEEPROM=m
> 
> #
> # Graphics support
> #
> CONFIG_FB=y
> CONFIG_FB_CFB_FILLRECT=m
> CONFIG_FB_CFB_COPYAREA=m
> CONFIG_FB_CFB_IMAGEBLIT=m
> CONFIG_FB_SOFT_CURSOR=m
> # CONFIG_FB_MACMODES is not set
> CONFIG_FB_MODE_HELPERS=y
> # CONFIG_FB_TILEBLITTING is not set
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_VESA is not set
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_S1D13XXX is not set
> CONFIG_FB_NVIDIA=m
> CONFIG_FB_NVIDIA_I2C=y
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON_OLD is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_CYBLA is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_GEODE is not set
> # CONFIG_FB_VIRTUAL is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> 
> #
> # Logo configuration
> #
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
> #
> # Speakup console speech
> #
> # CONFIG_SPEAKUP is not set
> 
> #
> # Sound
> #
> CONFIG_SOUND=y
> 
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=m
> CONFIG_SND_TIMER=m
> CONFIG_SND_PCM=m
> CONFIG_SND_HWDEP=m
> CONFIG_SND_RAWMIDI=m
> CONFIG_SND_SEQUENCER=m
> CONFIG_SND_SEQ_DUMMY=m
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=m
> CONFIG_SND_PCM_OSS=m
> CONFIG_SND_SEQUENCER_OSS=y
> CONFIG_SND_RTCTIMER=m
> CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
> CONFIG_SND_VERBOSE_PRINTK=y
> # CONFIG_SND_DEBUG is not set
> CONFIG_SND_GENERIC_DRIVER=y
> 
> #
> # Generic devices
> #
> CONFIG_SND_MPU401_UART=m
> CONFIG_SND_OPL3_LIB=m
> CONFIG_SND_VX_LIB=m
> CONFIG_SND_DUMMY=m
> CONFIG_SND_VIRMIDI=m
> CONFIG_SND_MTPAV=m
> CONFIG_SND_SERIAL_U16550=m
> CONFIG_SND_MPU401=m
> CONFIG_SND_AC97_CODEC=m
> 
> CONFIG_SND_AC97_BUS=m
> 
> #
> # PCI devices
> #
> CONFIG_SND_ALI5451=m
> CONFIG_SND_ATIIXP=m
> CONFIG_SND_ATIIXP_MODEM=m
> CONFIG_SND_AU8810=m
> CONFIG_SND_AU8820=m
> CONFIG_SND_AU8830=m
> CONFIG_SND_AZT3328=m
> CONFIG_SND_BT87X=m
> # CONFIG_SND_BT87X_OVERCLOCK is not set
> CONFIG_SND_CS46XX=m
> CONFIG_SND_CS46XX_NEW_DSP=y
> CONFIG_SND_CS4281=m
> CONFIG_SND_EMU10K1=m
> CONFIG_SND_EMU10K1X=m
> CONFIG_SND_CA0106=m
> CONFIG_SND_KORG1212=m
> CONFIG_SND_MIXART=m
> CONFIG_SND_NM256=m
> CONFIG_SND_RME32=m
> CONFIG_SND_RME96=m
> CONFIG_SND_RME9652=m
> CONFIG_SND_HDSP=m
> # CONFIG_SND_HDSPM is not set
> CONFIG_SND_TRIDENT=m
> CONFIG_SND_YMFPCI=m
> CONFIG_SND_AD1889=m
> CONFIG_SND_ALS4000=m
> CONFIG_SND_CMIPCI=m
> CONFIG_SND_ENS1370=m
> CONFIG_SND_ENS1371=m
> CONFIG_SND_ES1938=m
> CONFIG_SND_ES1968=m
> CONFIG_SND_MAESTRO3=m
> CONFIG_SND_FM801=m
> CONFIG_SND_FM801_TEA575X=m
> CONFIG_SND_ICE1712=m
> CONFIG_SND_ICE1724=m
> CONFIG_SND_INTEL8X0=m
> CONFIG_SND_INTEL8X0M=m
> CONFIG_SND_SONICVIBES=m
> CONFIG_SND_VIA82XX=m
> CONFIG_SND_VIA82XX_MODEM=m
> CONFIG_SND_VX222=m
> CONFIG_SND_HDA_INTEL=m
> 
> #
> # USB devices
> #
> CONFIG_SND_USB_AUDIO=m
> CONFIG_SND_USB_USX2Y=m
> 
> #
> # Open Sound System
> #
> # CONFIG_SOUND_PRIME is not set
> 
> #
> # USB support
> #
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB_ARCH_HAS_OHCI=y
> CONFIG_USB=m
> # CONFIG_USB_DEBUG is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_SUSPEND is not set
> # CONFIG_USB_OTG is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=m
> # CONFIG_USB_EHCI_SPLIT_ISO is not set
> # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> # CONFIG_USB_ISP116X_HCD is not set
> CONFIG_USB_OHCI_HCD=m
> # CONFIG_USB_OHCI_BIG_ENDIAN is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_UHCI_HCD=m
> # CONFIG_USB_SL811_HCD is not set
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
> CONFIG_USB_BLUETOOTH_TTY=m
> CONFIG_USB_ACM=m
> CONFIG_USB_PRINTER=m
> 
> #
> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
> #
> CONFIG_USB_STORAGE=m
> CONFIG_USB_STORAGE_DEBUG=y
> CONFIG_USB_STORAGE_DATAFAB=y
> CONFIG_USB_STORAGE_FREECOM=y
> CONFIG_USB_STORAGE_ISD200=y
> CONFIG_USB_STORAGE_DPCM=y
> # CONFIG_USB_STORAGE_USBAT is not set
> CONFIG_USB_STORAGE_SDDR09=y
> CONFIG_USB_STORAGE_SDDR55=y
> CONFIG_USB_STORAGE_JUMPSHOT=y
> # CONFIG_USB_STORAGE_ONETOUCH is not set
> 
> #
> # USB Input Devices
> #
> CONFIG_USB_HID=m
> CONFIG_USB_HIDINPUT=y
> # CONFIG_HID_FF is not set
> CONFIG_USB_HIDDEV=y
> 
> #
> # USB HID Boot Protocol drivers
> #
> CONFIG_USB_KBD=m
> CONFIG_USB_MOUSE=m
> CONFIG_USB_AIPTEK=m
> CONFIG_USB_WACOM=m
> # CONFIG_USB_ACECAD is not set
> CONFIG_USB_KBTAB=m
> CONFIG_USB_POWERMATE=m
> # CONFIG_USB_MTOUCH is not set
> # CONFIG_USB_ITMTOUCH is not set
> # CONFIG_USB_EGALAX is not set
> # CONFIG_USB_YEALINK is not set
> CONFIG_USB_XPAD=m
> # CONFIG_USB_ATI_REMOTE is not set
> # CONFIG_USB_KEYSPAN_REMOTE is not set
> # CONFIG_USB_APPLETOUCH is not set
> 
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=m
> CONFIG_USB_MICROTEK=m
> 
> #
> # USB Multimedia devices
> #
> CONFIG_USB_DABUSB=m
> CONFIG_USB_VICAM=m
> CONFIG_USB_DSBR=m
> CONFIG_USB_IBMCAM=m
> CONFIG_USB_KONICAWC=m
> CONFIG_USB_OV511=m
> CONFIG_USB_SE401=m
> CONFIG_USB_SN9C102=m
> CONFIG_USB_STV680=m
> CONFIG_USB_PWC=m
> 
> #
> # USB Network Adapters
> #
> CONFIG_USB_CATC=m
> CONFIG_USB_KAWETH=m
> CONFIG_USB_PEGASUS=m
> CONFIG_USB_RTL8150=m
> CONFIG_USB_USBNET=m
> # CONFIG_USB_NET_AX8817X is not set
> CONFIG_USB_NET_CDCETHER=m
> # CONFIG_USB_NET_GL620A is not set
> # CONFIG_USB_NET_NET1080 is not set
> # CONFIG_USB_NET_PLUSB is not set
> # CONFIG_USB_NET_RNDIS_HOST is not set
> # CONFIG_USB_NET_CDC_SUBSET is not set
> CONFIG_USB_NET_ZAURUS=m
> # CONFIG_USB_MON is not set
> 
> #
> # USB port drivers
> #
> CONFIG_USB_USS720=m
> 
> #
> # USB Serial Converter support
> #
> # CONFIG_USB_SERIAL is not set
> 
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=m
> CONFIG_USB_EMI26=m
> CONFIG_USB_AUERSWALD=m
> CONFIG_USB_RIO500=m
> CONFIG_USB_LEGOTOWER=m
> CONFIG_USB_LCD=m
> CONFIG_USB_LED=m
> CONFIG_USB_CYTHERM=m
> # CONFIG_USB_GOTEMP is not set
> CONFIG_USB_PHIDGETKIT=m
> CONFIG_USB_PHIDGETSERVO=m
> CONFIG_USB_IDMOUSE=m
> CONFIG_USB_SISUSBVGA=m
> # CONFIG_USB_SISUSBVGA_CON is not set
> # CONFIG_USB_LD is not set
> CONFIG_USB_TEST=m
> 
> #
> # USB DSL modem support
> #
> 
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
> 
> #
> # MMC/SD Card support
> #
> # CONFIG_MMC is not set
> 
> #
> # InfiniBand support
> #
> # CONFIG_INFINIBAND is not set
> 
> #
> # SN Devices
> #
> 
> #
> # Distributed Lock Manager
> #
> # CONFIG_DLM is not set
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> # CONFIG_DELL_RBU is not set
> # CONFIG_DCDBAS is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> # CONFIG_EXT2_FS_XIP is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISER4_FS=y
> # CONFIG_REISER4_DEBUG is not set
> CONFIG_REISERFS_FS=y
> # CONFIG_REISERFS_CHECK is not set
> CONFIG_REISERFS_PROC_INFO=y
> # CONFIG_REISERFS_FS_XATTR is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_XFS_FS=y
> CONFIG_XFS_EXPORT=y
> CONFIG_XFS_QUOTA=y
> # CONFIG_XFS_SECURITY is not set
> CONFIG_XFS_POSIX_ACL=y
> # CONFIG_XFS_RT is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_MINIX_FS is not set
> CONFIG_ROMFS_FS=m
> CONFIG_INOTIFY=y
> CONFIG_QUOTA=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=m
> CONFIG_QUOTACTL=y
> CONFIG_DNOTIFY=y
> CONFIG_AUTOFS_FS=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_FUSE_FS=m
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_ZISOFS_FS=m
> CONFIG_UDF_FS=m
> CONFIG_UDF_NLS=y
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> # CONFIG_MSDOS_FS is not set
> CONFIG_VFAT_FS=m
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> CONFIG_NTFS_FS=m
> # CONFIG_NTFS_DEBUG is not set
> CONFIG_NTFS_RW=y
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_RAMFS=y
> # CONFIG_RELAYFS_FS is not set
> # CONFIG_CONFIGFS_FS is not set
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ASFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> CONFIG_UFS_FS=m
> # CONFIG_UFS_FS_WRITE is not set
> 
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=y
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_V3_ACL is not set
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_TCP=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=y
> CONFIG_RPCSEC_GSS_KRB5=y
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> CONFIG_SMB_FS=m
> # CONFIG_SMB_NLS_DEFAULT is not set
> CONFIG_CIFS=m
> # CONFIG_CIFS_STATS is not set
> # CONFIG_CIFS_XATTR is not set
> # CONFIG_CIFS_EXPERIMENTAL is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> CONFIG_AFS_FS=m
> CONFIG_RXRPC=m
> # CONFIG_9P_FS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-15"
> CONFIG_NLS_CODEPAGE_437=m
> CONFIG_NLS_CODEPAGE_737=m
> CONFIG_NLS_CODEPAGE_775=m
> CONFIG_NLS_CODEPAGE_850=m
> CONFIG_NLS_CODEPAGE_852=m
> CONFIG_NLS_CODEPAGE_855=m
> CONFIG_NLS_CODEPAGE_857=m
> CONFIG_NLS_CODEPAGE_860=m
> CONFIG_NLS_CODEPAGE_861=m
> CONFIG_NLS_CODEPAGE_862=m
> CONFIG_NLS_CODEPAGE_863=m
> CONFIG_NLS_CODEPAGE_864=m
> CONFIG_NLS_CODEPAGE_865=m
> CONFIG_NLS_CODEPAGE_866=m
> CONFIG_NLS_CODEPAGE_869=m
> CONFIG_NLS_CODEPAGE_936=m
> CONFIG_NLS_CODEPAGE_950=m
> CONFIG_NLS_CODEPAGE_932=m
> CONFIG_NLS_CODEPAGE_949=m
> CONFIG_NLS_CODEPAGE_874=m
> CONFIG_NLS_ISO8859_8=m
> CONFIG_NLS_CODEPAGE_1250=m
> CONFIG_NLS_CODEPAGE_1251=m
> CONFIG_NLS_ASCII=m
> CONFIG_NLS_ISO8859_1=m
> CONFIG_NLS_ISO8859_2=m
> CONFIG_NLS_ISO8859_3=m
> CONFIG_NLS_ISO8859_4=m
> CONFIG_NLS_ISO8859_5=m
> CONFIG_NLS_ISO8859_6=m
> CONFIG_NLS_ISO8859_7=m
> CONFIG_NLS_ISO8859_9=m
> CONFIG_NLS_ISO8859_13=m
> CONFIG_NLS_ISO8859_14=m
> CONFIG_NLS_ISO8859_15=m
> CONFIG_NLS_KOI8_R=m
> CONFIG_NLS_KOI8_U=m
> CONFIG_NLS_UTF8=m
> 
> #
> # Instrumentation Support
> #
> # CONFIG_PROFILING is not set
> # CONFIG_KPROBES is not set
> 
> #
> # Kernel hacking
> #
> # CONFIG_PRINTK_TIME is not set
> CONFIG_DEBUG_KERNEL=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_LOG_BUF_SHIFT=18
> CONFIG_DETECT_SOFTLOCKUP=y
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_DEBUG_PREEMPT=y
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_KOBJECT is not set
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_DEBUG_FS is not set
> # CONFIG_FRAME_POINTER is not set
> # CONFIG_INIT_DEBUG is not set
> # CONFIG_IOMMU_DEBUG is not set
> # CONFIG_KGDB is not set
> 
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_NULL is not set
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_SHA1=m
> # CONFIG_CRYPTO_SHA256 is not set
> # CONFIG_CRYPTO_SHA512 is not set
> # CONFIG_CRYPTO_WP512 is not set
> # CONFIG_CRYPTO_TGR192 is not set
> CONFIG_CRYPTO_DES=y
> # CONFIG_CRYPTO_BLOWFISH is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_SERPENT is not set
> CONFIG_CRYPTO_AES=m
> # CONFIG_CRYPTO_AES_X86_64 is not set
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set
> # CONFIG_CRYPTO_TEA is not set
> CONFIG_CRYPTO_ARC4=m
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_MICHAEL_MIC=m
> CONFIG_CRYPTO_CRC32C=m
> # CONFIG_CRYPTO_TEST is not set
> 
> #
> # Hardware crypto devices
> #
> 
> #
> # Library routines
> #
> CONFIG_CRC_CCITT=m
> # CONFIG_CRC16 is not set
> CONFIG_CRC32=y
> CONFIG_LIBCRC32C=m
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y

