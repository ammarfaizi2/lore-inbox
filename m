Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTKILcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 06:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTKILcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 06:32:23 -0500
Received: from 82-41-35-230.cable.ubr05.edin.blueyonder.co.uk ([82.41.35.230]:12162
	"EHLO babylon.alistairphipps.com") by vger.kernel.org with ESMTP
	id S262369AbTKILbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 06:31:33 -0500
Date: Sun, 9 Nov 2003 11:30:22 +0000
From: Alistair Phipps <monster@alistairphipps.com>
To: linux-kernel@vger.kernel.org
Subject: Frequently occuring BUG in untainted 2.4.22 vmscan.c:358
Message-Id: <20031109113022.3c3b3b51.monster@alistairphipps.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-babylon-MailScanner: Found to be clean
X-babylon-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.9,
	required 5, BAYES_00 -4.90, UPPERCASE_25_50 0.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

For the past few days, I've been having problems with kernel BUGs
under load.  Looking at mailing list archives, I see I'm not the only
one hitting this particular kernel bug. Initially I was running 2.4.20 and
thought I'd upgrade to 2.4.22 to see if it fixed the problem, but it
hasn't.  I'd appreciate any help anyone can offer - this is causing my
server to lock up hard and require a hard reset.

I'm running vanilla 2.4.22, with the following patches applied:

1) NFS client seekdir patch: 06-seekdir
2) Device mapper patch: 2.4.22-dm-1
3) EVMS patch: 2.2.0-pre5
4) I2C patch: 2.4.22-i2c-2.8.1

And the following 3rd party (but open source) modules loaded:

1) ALSA emu10k1
2) DVB (www.linuxtv.org) 1.0.1

Note although I am using EVMS, most of my partitions are non-EVMS, and the
bugs are occuring when there is load on the non-EVMS partitions.

With 2.4.22, the initial BUG triggered is:

Nov  9 08:13:46 babylon kernel: kernel BUG at vmscan.c:358!
Nov  9 08:13:46 babylon kernel: invalid operand: 0000
Nov  9 08:13:46 babylon kernel: CPU:    0
Nov  9 08:13:46 babylon kernel: EIP:    0010:[shrink_cache+154/784]    Not tainted
Nov  9 08:13:46 babylon kernel: EFLAGS: 00010246
Nov  9 08:13:46 babylon kernel: eax: 00000004   ebx: 00000000   ecx: c1028728   edx: c101f838
Nov  9 08:13:46 babylon kernel: esi: c102870c   edi: 00000001   ebp: 00000200   esp: c1855f50
Nov  9 08:13:46 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 08:13:46 babylon kernel: Process kswapd (pid: 4, stackpage=c1855000)
Nov  9 08:13:46 babylon kernel: Stack: 00000020 000001d0 00000020 00000006 00000006 c1854000 000035b9 000001d0 
Nov  9 08:13:46 babylon kernel:        c0261074 c012b376 00000006 00000012 00000006 00000020 000001d0 c0261074 
Nov  9 08:13:46 babylon kernel:        c0261074 c012b3dc 00000020 c0261074 00000001 c1854000 00000000 c012b4e1 
Nov  9 08:13:46 babylon kernel: Call Trace:    [shrink_caches+86/128] [try_to_free_pages_zone+60/96] [kswapd_balance_pgdat+65/144] [kswapd_balance+22/48] [kswapd+157/192]
Nov  9 08:13:46 babylon kernel:   [arch_kernel_thread+40/64]
Nov  9 08:13:46 babylon kernel: 
Nov  9 08:13:46 babylon kernel: Code: 0f 0b 66 01 3c 94 22 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 3c 

There then follows a load more:

Nov  9 08:14:03 babylon kernel: kernel BUG at vmscan.c:358!
Nov  9 08:14:03 babylon kernel: invalid operand: 0000
Nov  9 08:14:03 babylon kernel: CPU:    0
Nov  9 08:14:03 babylon kernel: EIP:    0010:[shrink_cache+154/784]    Not tainted
Nov  9 08:14:03 babylon kernel: EFLAGS: 00010246
Nov  9 08:14:03 babylon kernel: eax: 00000004   ebx: 00000000   ecx: c1028728   edx: 0000056a
Nov  9 08:14:03 babylon kernel: esi: c102870c   edi: 00000020   ebp: 00000200   esp: d1abbe5c
Nov  9 08:14:03 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 08:14:03 babylon kernel: Process btdownloadheadl (pid: 12925, stackpage=d1abb000)
Nov  9 08:14:03 babylon kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 d1aba000 0000362c 000001d2 
Nov  9 08:14:03 babylon kernel:        c0261074 c012b376 00000006 00000011 00000006 00000020 000001d2 c0261074 
Nov  9 08:14:03 babylon kernel:        c0261074 c012b3dc 00000020 d1aba000 00000000 00000010 c0261074 c012bdd0 
Nov  9 08:14:03 babylon kernel: Call Trace:    [shrink_caches+86/128] [try_to_free_pages_zone+60/96] [balance_classzone+80/448] [__alloc_pages+274/352] [do_generic_file_write+419/1008]
Nov  9 08:14:03 babylon kernel:   [_alloc_pages+22/32] [do_generic_file_write+451/1008] [generic_file_write+259/288] [ext3_file_write+35/192] [sys_write+150/240] [system_call+51/56]
Nov  9 08:14:03 babylon kernel: 
Nov  9 08:14:03 babylon kernel: Code: 0f 0b 66 01 3c 94 22 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 3c 
Nov  9 08:14:03 babylon kernel:  kernel BUG at vmscan.c:358!
Nov  9 08:14:03 babylon kernel: invalid operand: 0000
Nov  9 08:14:03 babylon kernel: CPU:    0
Nov  9 08:14:03 babylon kernel: EIP:    0010:[shrink_cache+154/784]    Not tainted
Nov  9 08:14:03 babylon kernel: EFLAGS: 00010246
Nov  9 08:14:03 babylon kernel: eax: 00000004   ebx: 00000000   ecx: c1028728   edx: 0000056b
Nov  9 08:14:03 babylon kernel: esi: c102870c   edi: 00000020   ebp: 00000200   esp: dbc77de8
Nov  9 08:14:03 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 08:14:03 babylon kernel: Process sh (pid: 12924, stackpage=dbc77000)
Nov  9 08:14:03 babylon kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 dbc76000 00003630 000001d2 
Nov  9 08:14:03 babylon kernel:        c0261074 c012b376 00000006 00000011 00000006 00000020 000001d2 c0261074 
Nov  9 08:14:03 babylon kernel:        c0261074 c012b3dc 00000020 dbc76000 00000000 00000010 c0261074 c012bdd0 
Nov  9 08:14:03 babylon kernel: Call Trace:    [shrink_caches+86/128] [try_to_free_pages_zone+60/96] [balance_classzone+80/448] [__alloc_pages+274/352] [read_swap_cache_async+65/160]
Nov  9 08:14:03 babylon kernel:   [_alloc_pages+22/32] [read_swap_cache_async+90/160] [swapin_readahead+64/80] [do_swap_page+38/224] [handle_mm_fault+98/176] [do_page_fault+355/1156]
Nov  9 08:14:03 babylon kernel:   [do_page_fault+0/1156] [error_code+52/60] [__free_pages+27/32] [free_pages+26/32] [release_task+342/368] [sys_wait4+899/912]
Nov  9 08:14:03 babylon kernel:   [sys_waitpid+22/26] [error_code+52/60]
Nov  9 08:14:03 babylon kernel: 
Nov  9 08:14:03 babylon kernel: Code: 0f 0b 66 01 3c 94 22 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 3c 
Nov  9 08:14:03 babylon kernel:  kernel BUG at vmscan.c:358!
Nov  9 08:14:03 babylon kernel: invalid operand: 0000
Nov  9 08:14:03 babylon kernel: CPU:    0
Nov  9 08:14:03 babylon kernel: EIP:    0010:[shrink_cache+154/784]    Not tainted
Nov  9 08:14:03 babylon kernel: EFLAGS: 00010246
Nov  9 08:14:03 babylon kernel: eax: 00000004   ebx: 00000000   ecx: c1028728   edx: 0000056b
Nov  9 08:14:03 babylon kernel: esi: c102870c   edi: 00000020   ebp: 00000200   esp: c5ff1de8
Nov  9 08:14:03 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 08:14:03 babylon kernel: Process screen (pid: 12923, stackpage=c5ff1000)
Nov  9 08:14:03 babylon kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 c5ff0000 00003633 000001d2 
Nov  9 08:14:03 babylon kernel:        c0261074 c012b376 00000006 00000011 00000006 00000020 000001d2 c0261074 
Nov  9 08:14:03 babylon kernel:        c0261074 c012b3dc 00000020 c5ff0000 00000000 00000010 c0261074 c012bdd0 
Nov  9 08:14:03 babylon kernel: Call Trace:    [shrink_caches+86/128] [try_to_free_pages_zone+60/96] [balance_classzone+80/448] [__alloc_pages+274/352] [read_swap_cache_async+65/160]
Nov  9 08:14:03 babylon kernel:   [_alloc_pages+22/32] [read_swap_cache_async+90/160] [swapin_readahead+64/80] [do_swap_page+38/224] [handle_mm_fault+98/176] [do_page_fault+355/1156]
Nov  9 08:14:03 babylon kernel:   [do_page_fault+0/1156] [select_bits_free+10/16] [sys_select+1119/1136] [sys_sigreturn+182/224] [error_code+52/60]
Nov  9 08:14:03 babylon kernel: 
Nov  9 08:14:03 babylon kernel: Code: 0f 0b 66 01 3c 94 22 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 3c 
Nov  9 08:15:15 babylon kernel: kernel BUG at vmscan.c:358!
Nov  9 08:15:15 babylon kernel: invalid operand: 0000
Nov  9 08:15:15 babylon kernel: CPU:    0
Nov  9 08:15:15 babylon kernel: EIP:    0010:[shrink_cache+154/784]    Not tainted
Nov  9 08:15:15 babylon kernel: EFLAGS: 00010246
Nov  9 08:15:15 babylon kernel: eax: 00000004   ebx: 00000000   ecx: c1028728   edx: 0000055f
Nov  9 08:15:15 babylon kernel: esi: c102870c   edi: 00000020   ebp: 00000200   esp: c1cffd08
Nov  9 08:15:15 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  9 08:15:15 babylon kernel: Process btdownloadheadl (pid: 28331, stackpage=c1cff000)
Nov  9 08:15:15 babylon kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 c1cfe000 000035b6 000001d2 
Nov  9 08:15:15 babylon kernel:        c0261074 c012b376 00000006 00000012 00000006 00000020 000001d2 c0261074 
Nov  9 08:15:15 babylon kernel:        c0261074 c012b3dc 00000020 c1cfe000 00000000 00000010 c0261074 c012bdd0 

At this point the system is essentially locked up - I have to hit reset.

Running ksymoops on the first BUG triggered gives:

>>ecx; c1028728 <_end+d4fc78/305295b0>
>>edx; c101f838 <_end+d46d88/305295b0>
>>esi; c102870c <_end+d4fc5c/305295b0>
>>esp; c1855f50 <_end+157d4a0/305295b0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   66 01 3c 94               add    %di,(%esp,%edx,4)
Code;  00000006 Before first symbol
   6:   22 c0                     and    %al,%al
Code;  00000008 Before first symbol
   8:   8b 41 fc                  mov    0xfffffffc(%ecx),%eax
Code;  0000000b Before first symbol
   b:   a8 80                     test   $0x80,%al
Code;  0000000d Before first symbol
   d:   74 08                     je     17 <_EIP+0x17>
Code;  0000000f Before first symbol
   f:   0f 0b                     ud2a   
Code;  00000011 Before first symbol
  11:   67 01 3c                  addr16 add %edi,(%si)

The BUG line reported is in mm/vmscan.c, which reads:

BUG_ON(!PageLRU(page));

Here's my .config:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
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
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
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
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=m
CONFIG_ISAPNP=m

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_MD_MULTIPATH=y
CONFIG_BLK_DEV_LVM=y
CONFIG_BLK_DEV_DM=y
CONFIG_BLK_DEV_DM_MIRROR=y
CONFIG_BLK_DEV_DM_BBR=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_TFTP is not set
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
# CONFIG_IP_NF_MATCH_MARK is not set
CONFIG_IP_NF_MATCH_MULTIPORT=m
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_HELPER is not set
CONFIG_IP_NF_MATCH_STATE=m
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_TOS is not set
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
# CONFIG_IP_NF_TARGET_MARK is not set
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
# CONFIG_IP6_NF_MATCH_RT is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_HL is not set
CONFIG_IP6_NF_MATCH_MULTIPORT=m
# CONFIG_IP6_NF_MATCH_OWNER is not set
# CONFIG_IP6_NF_MATCH_MARK is not set
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
# CONFIG_IP6_NF_MATCH_AHESP is not set
# CONFIG_IP6_NF_MATCH_LENGTH is not set
# CONFIG_IP6_NF_MATCH_EUI64 is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
# CONFIG_IP6_NF_TARGET_MARK is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
# CONFIG_NET_SCH_CSZ is not set
CONFIG_NET_SCH_PRIO=m
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFQ=m
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

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
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
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
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
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
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
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
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
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
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
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
# CONFIG_RCPCI is not set
CONFIG_SHAPER=m

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
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_PPORT is not set
# CONFIG_SCx200_I2C is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
CONFIG_INPUT_EMU10K1=m
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set

#
# Joysticks
#
CONFIG_INPUT_ANALOG=m
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_NVIDIA is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set

#
# DRM 4.1 drivers
#
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=m
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_I2C_PARPORT is not set

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZORAN_BUZ is not set
# CONFIG_VIDEO_ZORAN_DC10 is not set
# CONFIG_VIDEO_ZORAN_LML33 is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
CONFIG_RADIO_RTRACK=m
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=m

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
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI=m
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
CONFIG_USB_PWC=m
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set

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
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

And loaded modules:

Module                  Size  Used by    Not tainted
nfsd                   68240   8  (autoclean)
lockd                  48976   1  (autoclean) [nfsd]
sunrpc                 62364   1  (autoclean) [nfsd lockd]
snd-pcm-oss            36644   0  (autoclean)
snd-mixer-oss          11224   0  (autoclean) [snd-pcm-oss]
parport_pc             21320   1  (autoclean)
lp                      6496   0  (autoclean)
parport                24960   1  (autoclean) [parport_pc lp]
ipt_state                600   6  (autoclean)
ipt_MASQUERADE          1208   1  (autoclean)
ip6t_LOG                3576   2  (autoclean)
ipt_REJECT              3256   1  (autoclean)
ipt_LOG                 3192   2  (autoclean)
ip6table_filter         1796   1  (autoclean)
ip6_tables             11864   2  [ip6t_LOG ip6table_filter]
iptable_filter          1700   1  (autoclean)
ip_nat_irc              2192   0  (unused)
ip_nat_ftp              2800   0  (unused)
iptable_nat            15448   3  [ipt_MASQUERADE ip_nat_irc ip_nat_ftp]
ip_tables              11224   8  [ipt_state ipt_MASQUERADE ipt_REJECT ipt_LOG iptable_filter iptable_nat]
ip_conntrack_irc        2960   1 
ip_conntrack_ftp        3696   1 
ip_conntrack           17256   4  [ipt_state ipt_MASQUERADE ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_ftp]
af_packet              11976   1  (autoclean)
serial                 43812   0  (autoclean)
isa-pnp                28676   0  (autoclean) [serial]
i2c-dev                 3584   0  (unused)
i2c-isa                  756   0  (unused)
via686a                 7948   0  (unused)
adm1021                 5416   0  (unused)
eeprom                  3336   0  (unused)
i2c-proc                5972   0  [via686a adm1021 eeprom]
i2c-viapro              3360   0  (unused)
i2c-core               14180   0  [i2c-dev i2c-isa via686a adm1021 eeprom i2c-proc i2c-viapro]
evdev                   4160   0  (unused)
dvb-ttpci             301716   0  (unused)
grundig_29504-401       3656   1 
dvb-core               38052   3  [dvb-ttpci grundig_29504-401]
radio-aimslab           3932   0  (unused)
videodev                5568   1  [dvb-ttpci radio-aimslab]
usb-storage            22808   0 
sd_mod                 10284   0 
scsi_mod               54668   2  [usb-storage sd_mod]
snd-emu10k1            59956   0 
snd-pcm                55744   0  [snd-pcm-oss snd-emu10k1]
snd-timer              14084   0  [snd-pcm]
snd-hwdep               4384   0  [snd-emu10k1]
snd-util-mem            1136   0  [snd-emu10k1]
snd-page-alloc          5360   0  [snd-emu10k1 snd-pcm]
snd-rawmidi            12352   0  [snd-emu10k1]
snd-seq-device          3796   0  [snd-emu10k1 snd-rawmidi]
snd-ac97-codec         35000   0  [snd-emu10k1]
snd                    27716   0  [snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer snd-hwdep snd-util-mem snd-rawmidi snd-seq-device snd-ac97-codec]
soundcore               3524   6  [snd]
emu10k1-gp              1224   0  (unused)
gameport                1516   0  [emu10k1-gp]
tdfx                   35840   0  (unused)
agpgart                12912   0  (unused)
hid                    14184   0  (unused)
mousedev                3864   0  (unused)
keybdev                 1728   0  (unused)
input                   3360   0  [evdev dvb-ttpci hid mousedev keybdev]
tun                     3808   3 
usb-uhci               21676   0  (unused)
usbcore                57056   0  [usb-storage hid usb-uhci]
8139too                15368   2 
mii                     2400   0  [8139too]
crc32                   2848   0  [8139too]
floppy                 47036   0 
apm                     9184   0 
ipv6                  150932  -1 
rtc                     5916   0  (autoclean)
unix                   14120  91  (autoclean)

Memtest86 has been run for a long time on the machine without giving any
errors.

I mentioned that I was having a similar problem under 2.4.20.  That was the
Debian 2.4.20 (quite heavily patched) kernel with a similar set of patches
applied.  The bug occurred in a different place then:

Nov  4 16:55:45 babylon kernel: kernel BUG at page_alloc.c:102!
Nov  4 16:55:45 babylon kernel: invalid operand: 0000
Nov  4 16:55:45 babylon kernel: CPU:    0
Nov  4 16:55:45 babylon kernel: EIP:    0010:[__free_pages_ok+68/656]    Not tainted
Nov  4 16:55:45 babylon kernel: EFLAGS: 00010286
Nov  4 16:55:45 babylon kernel: eax: 01000009   ebx: c1441d2c   ecx: c1441d2c   edx: 00000000
Nov  4 16:55:45 babylon kernel: esi: 00000000   edi: c65407c0   ebp: 0002df7c   esp: ed80dde8
Nov  4 16:55:45 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  4 16:55:45 babylon kernel: Process nfsd (pid: 21625, stackpage=ed80d000)
Nov  4 16:55:45 babylon kernel: Stack: c1441d2c 00001000 c65407c0 0002df7c edef6000 f138f200 e1b24000 c4ef9a14 
Nov  4 16:55:45 babylon kernel:        c1441d2c c1441d2c c1960518 c65407c0 0002df7b c012c02b c01253b3 ed80de8c 
Nov  4 16:55:45 babylon kernel:        c1441d2c 00000000 00001000 ed80c000 c0000000 ca6d521c ed80df30 00001000 
Nov  4 16:55:45 babylon kernel: Call Trace:    [<f138f200>] [__free_pages+27/32] [do_generic_file_read+499/1024] [generic_file_read+147/400] [file_read_actor+0/144]
Nov  4 16:55:45 babylon kernel:   [<f1390f49>] [<f1396330>] [<f139d1b8>] [<f138d573>] [<f139d1b8>] [<f13763e5>]
Nov  4 16:55:45 babylon kernel:   [<f139ca98>] [<f139cab8>] [<f138d34b>] [arch_kernel_thread+40/64]
Nov  4 16:55:45 babylon kernel: 
Nov  4 16:55:45 babylon kernel: Code: 0f 0b 66 00 53 27 21 c0 89 d8 2b 05 d0 14 29 c0 69 c0 a3 8b 
Nov  4 16:55:45 babylon kernel:  kernel BUG at page_alloc.c:102!
Nov  4 16:55:45 babylon kernel: invalid operand: 0000
Nov  4 16:55:45 babylon kernel: CPU:    0
Nov  4 16:55:45 babylon kernel: EIP:    0010:[__free_pages_ok+68/656]    Not tainted
Nov  4 16:55:45 babylon kernel: EFLAGS: 00010286
Nov  4 16:55:45 babylon kernel: eax: 0100000d   ebx: c1441d2c   ecx: c1441d2c   edx: 00000000
Nov  4 16:55:45 babylon kernel: esi: 00000000   edi: c65407c0   ebp: 0002df7c   esp: dec01de8
Nov  4 16:55:45 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  4 16:55:45 babylon kernel: Process nfsd (pid: 21628, stackpage=dec01000)
Nov  4 16:55:45 babylon kernel: Stack: c1441d2c 00001000 c65407c0 0002df7c 0002df7b 00000003 dec01ec8 c0125155 
Nov  4 16:55:45 babylon kernel:        c1441d2c c1441d2c c1960518 c65407c0 0002df7b c012c02b c01253b3 dec01e8c 
Nov  4 16:55:45 babylon kernel:        c1441d2c 00000000 00001000 dec00000 c0000000 ca6d521c dec01f30 00001000 
Nov  4 16:55:45 babylon kernel: Call Trace:    [generic_file_readahead+261/320] [__free_pages+27/32] [do_generic_file_read+499/1024] [generic_file_read+147/400] [file_read_actor+0/144]
Nov  4 16:55:45 babylon kernel:   [<f1390f49>] [<f1396330>] [<f139d1b8>] [<f138d573>] [<f139d1b8>] [<f13763e5>]
Nov  4 16:55:45 babylon kernel:   [<f139ca98>] [<f139cab8>] [<f138d34b>] [<f139ca80>] [arch_kernel_thread+40/64]
Nov  4 16:55:45 babylon kernel: 
Nov  4 16:55:45 babylon kernel: Code: 0f 0b 66 00 53 27 21 c0 89 d8 2b 05 d0 14 29 c0 69 c0 a3 8b 
Nov  4 16:55:45 babylon kernel:  kernel BUG at page_alloc.c:102!
Nov  4 16:55:45 babylon kernel: invalid operand: 0000
Nov  4 16:55:45 babylon kernel: CPU:    0
Nov  4 16:55:45 babylon kernel: EIP:    0010:[__free_pages_ok+68/656]    Not tainted
Nov  4 16:55:45 babylon kernel: EFLAGS: 00010286
Nov  4 16:55:45 babylon kernel: eax: 01000009   ebx: c1441d2c   ecx: c1441d2c   edx: 00000000
Nov  4 16:55:45 babylon kernel: esi: 00000000   edi: c65407c0   ebp: 0002df7c   esp: edb2dde8
Nov  4 16:55:45 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  4 16:55:45 babylon kernel: Process nfsd (pid: 21624, stackpage=edb2d000)
Nov  4 16:55:45 babylon kernel: Stack: c1441d2c 00001000 c65407c0 0002df7c 0002df7b 00000003 edb2dec8 c0125155 
Nov  4 16:55:45 babylon kernel:        c1441d2c c1441d2c c1960518 c65407c0 0002df7b c012c02b c01253b3 edb2de8c 
Nov  4 16:55:45 babylon kernel:        c1441d2c 00000000 00001000 edb2c000 c0000000 ca6d521c edb2df30 00001000 
Nov  4 16:55:45 babylon kernel: Call Trace:    [generic_file_readahead+261/320] [__free_pages+27/32] [do_generic_file_read+499/1024] [generic_file_read+147/400] [file_read_actor+0/144]
Nov  4 16:55:45 babylon kernel:   [<f1390f49>] [<f1396330>] [<f139d1b8>] [<f138d573>] [<f139d1b8>] [<f13763e5>]
Nov  4 16:55:45 babylon kernel:   [<f139ca98>] [<f139cab8>] [<f138d34b>] [arch_kernel_thread+40/64]
Nov  4 16:55:45 babylon kernel: 
Nov  4 16:55:45 babylon kernel: Code: 0f 0b 66 00 53 27 21 c0 89 d8 2b 05 d0 14 29 c0 69 c0 a3 8b 
Nov  4 16:55:46 babylon kernel:  kernel BUG at page_alloc.c:102!
Nov  4 16:55:46 babylon kernel: invalid operand: 0000
Nov  4 16:55:46 babylon kernel: CPU:    0
Nov  4 16:55:46 babylon kernel: EIP:    0010:[__free_pages_ok+68/656]    Not tainted
Nov  4 16:55:46 babylon kernel: EFLAGS: 00010286
Nov  4 16:55:46 babylon kernel: eax: 0100000d   ebx: c1441d2c   ecx: c1441d2c   edx: 00000000
Nov  4 16:55:46 babylon kernel: esi: 00000000   edi: c65407c0   ebp: 0002df7c   esp: d30d3de8
Nov  4 16:55:46 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  4 16:55:46 babylon kernel: Process nfsd (pid: 21627, stackpage=d30d3000)
Nov  4 16:55:46 babylon kernel: Stack: c1441d2c 00001000 c65407c0 0002df7c 0002df7b 00000003 d30d3ec8 c0125155 
Nov  4 16:55:46 babylon kernel:        c1441d2c c1441d2c c1960518 c65407c0 0002df7b c012c02b c01253b3 d30d3e8c 
Nov  4 16:55:46 babylon kernel:        c1441d2c 00000000 00001000 d30d2000 c0000000 ca6d521c d30d3f30 00001000 
Nov  4 16:55:46 babylon kernel: Call Trace:    [generic_file_readahead+261/320] [__free_pages+27/32] [do_generic_file_read+499/1024] [generic_file_read+147/400] [file_read_actor+0/144]
Nov  4 16:55:46 babylon kernel:   [<f1390f49>] [<f1396330>] [<f139d1b8>] [<f138d573>] [<f139d1b8>] [<f13763e5>]
Nov  4 16:55:46 babylon kernel:   [<f139ca98>] [<f139cab8>] [<f138d34b>] [arch_kernel_thread+40/64]
Nov  4 16:55:46 babylon kernel: 
Nov  4 16:55:46 babylon kernel: Code: 0f 0b 66 00 53 27 21 c0 89 d8 2b 05 d0 14 29 c0 69 c0 a3 8b 
Nov  4 16:55:46 babylon kernel:  kernel BUG at page_alloc.c:102!
Nov  4 16:55:46 babylon kernel: invalid operand: 0000
Nov  4 16:55:46 babylon kernel: CPU:    0
Nov  4 16:55:46 babylon kernel: EIP:    0010:[__free_pages_ok+68/656]    Not tainted
Nov  4 16:55:46 babylon kernel: EFLAGS: 00010286
Nov  4 16:55:46 babylon kernel: eax: 01000009   ebx: c1441d2c   ecx: c1441d2c   edx: 00000000
Nov  4 16:55:46 babylon kernel: esi: 00000000   edi: c65407c0   ebp: 0002df7c   esp: cb419de8
Nov  4 16:55:46 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  4 16:55:46 babylon kernel: Process nfsd (pid: 21626, stackpage=cb419000)
Nov  4 16:55:46 babylon kernel: Stack: c1441d2c 00001000 c65407c0 0002df7c 0002df7b 00000003 cb419ec8 c0125155 
Nov  4 16:55:46 babylon kernel:        c1441d2c c1441d2c c1960518 c65407c0 0002df7b c012c02b c01253b3 cb419e8c 
Nov  4 16:55:46 babylon kernel:        c1441d2c 00000000 00001000 cb418000 c0000000 ca6d521c cb419f30 00001000 
Nov  4 16:55:46 babylon kernel: Call Trace:    [generic_file_readahead+261/320] [__free_pages+27/32] [do_generic_file_read+499/1024] [generic_file_read+147/400] [file_read_actor+0/144]
Nov  4 16:55:46 babylon kernel:   [<f1390f49>] [<f1396330>] [<f139d1b8>] [<f138d573>] [<f139d1b8>] [<f13763e5>]
Nov  4 16:55:46 babylon kernel:   [<f139ca98>] [<f139cab8>] [<f138d34b>] [arch_kernel_thread+40/64]
Nov  4 16:55:46 babylon kernel: 
Nov  4 16:55:46 babylon kernel: Code: 0f 0b 66 00 53 27 21 c0 89 d8 2b 05 d0 14 29 c0 69 c0 a3 8b 
Nov  4 16:55:46 babylon kernel:  kernel BUG at page_alloc.c:102!
Nov  4 16:55:46 babylon kernel: invalid operand: 0000
Nov  4 16:55:46 babylon kernel: CPU:    0
Nov  4 16:55:46 babylon kernel: EIP:    0010:[__free_pages_ok+68/656]    Not tainted
Nov  4 16:55:46 babylon kernel: EFLAGS: 00010286
Nov  4 16:55:46 babylon kernel: eax: 0100000d   ebx: c1441d2c   ecx: c1441d2c   edx: 00000000
Nov  4 16:55:46 babylon kernel: esi: 00000000   edi: c65407c0   ebp: 0002df7c   esp: de521de8
Nov  4 16:55:46 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  4 16:55:46 babylon kernel: Process nfsd (pid: 21619, stackpage=de521000)
Nov  4 16:55:46 babylon kernel: Stack: c1441d2c 00001000 c65407c0 0002df7c 0002df7b 00000003 de521ec8 c0125155 
Nov  4 16:55:46 babylon kernel:        c1441d2c c1441d2c c1960518 c65407c0 0002df7b c012c02b c01253b3 de521e8c 
Nov  4 16:55:46 babylon kernel:        c1441d2c 00000000 00001000 de520000 c0000000 ca6d521c de521f30 00001000 
Nov  4 16:55:46 babylon kernel: Call Trace:    [generic_file_readahead+261/320] [__free_pages+27/32] [do_generic_file_read+499/1024] [generic_file_read+147/400] [file_read_actor+0/144]
Nov  4 16:55:46 babylon kernel:   [<f1390f49>] [<f1396330>] [<f139d1b8>] [<f138d573>] [<f139d1b8>] [<f13763e5>]
Nov  4 16:55:46 babylon kernel:   [<f139ca98>] [<f139cab8>] [<f138d34b>] [<f139ca80>] [arch_kernel_thread+40/64]
Nov  4 16:55:46 babylon kernel: 
Nov  4 16:55:46 babylon kernel: Code: 0f 0b 66 00 53 27 21 c0 89 d8 2b 05 d0 14 29 c0 69 c0 a3 8b 
Nov  4 16:55:46 babylon kernel:  kernel BUG at page_alloc.c:102!
Nov  4 16:55:46 babylon kernel: invalid operand: 0000
Nov  4 16:55:46 babylon kernel: CPU:    0
Nov  4 16:55:46 babylon kernel: EIP:    0010:[__free_pages_ok+68/656]    Not tainted
Nov  4 16:55:46 babylon kernel: EFLAGS: 00010286
Nov  4 16:55:46 babylon kernel: eax: 01000009   ebx: c1441d2c   ecx: c1441d2c   edx: 00000000
Nov  4 16:55:46 babylon kernel: esi: 00000000   edi: c65407c0   ebp: 0002df7c   esp: c6d39de8
Nov  4 16:55:46 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  4 16:55:46 babylon kernel: Process nfsd (pid: 21622, stackpage=c6d39000)
Nov  4 16:55:46 babylon kernel: Stack: c1441d2c 00001000 c65407c0 0002df7c 0002df7b 00000003 c6d39ec8 c0125155 
Nov  4 16:55:46 babylon kernel:        c1441d2c c1441d2c c1960518 c65407c0 0002df7b c012c02b c01253b3 c6d39e8c 
Nov  4 16:55:46 babylon kernel:        c1441d2c 00000000 00001000 c6d38000 c0000000 ca6d521c c6d39f30 00001000 
Nov  4 16:55:46 babylon kernel: Call Trace:    [generic_file_readahead+261/320] [__free_pages+27/32] [do_generic_file_read+499/1024] [generic_file_read+147/400] [file_read_actor+0/144]
Nov  4 16:55:46 babylon kernel:   [<f1390f49>] [<f1396330>] [<f139d1b8>] [<f138d573>] [<f139d1b8>] [<f13763e5>]
Nov  4 16:55:46 babylon kernel:   [<f139ca98>] [<f139cab8>] [<f138d34b>] [arch_kernel_thread+40/64]
Nov  4 16:55:46 babylon kernel: 
Nov  4 16:55:46 babylon kernel: Code: 0f 0b 66 00 53 27 21 c0 89 d8 2b 05 d0 14 29 c0 69 c0 a3 8b 
Nov  4 16:55:46 babylon kernel:  kernel BUG at page_alloc.c:102!
Nov  4 16:55:46 babylon kernel: invalid operand: 0000
Nov  4 16:55:46 babylon kernel: CPU:    0
Nov  4 16:55:46 babylon kernel: EIP:    0010:[__free_pages_ok+68/656]    Not tainted
Nov  4 16:55:46 babylon kernel: EFLAGS: 00010286
Nov  4 16:55:46 babylon kernel: eax: 0100000d   ebx: c1441d2c   ecx: c1441d2c   edx: 00000000
Nov  4 16:55:46 babylon kernel: esi: 00000000   edi: c65407c0   ebp: 0002df7c   esp: cbc7bde8
Nov  4 16:55:46 babylon kernel: ds: 0018   es: 0018   ss: 0018
Nov  4 16:55:46 babylon kernel: Process nfsd (pid: 21623, stackpage=cbc7b000)
Nov  4 16:55:46 babylon kernel: Stack: c1441d2c 00001000 c65407c0 0002df7c 0002df7b 00000003 cbc7bec8 c0125155 
Nov  4 16:55:46 babylon kernel:        c1441d2c c1441d2c c1960518 c65407c0 0002df7b c012c02b c01253b3 cbc7be8c 
Nov  4 16:55:46 babylon kernel:        c1441d2c 00000000 00001000 cbc7a000 c0000000 ca6d521c cbc7bf30 00001000 
Nov  4 16:55:46 babylon kernel: Call Trace:    [generic_file_readahead+261/320] [__free_pages+27/32] [do_generic_file_read+499/1024] [generic_file_read+147/400] [file_read_actor+0/144]
Nov  4 16:55:46 babylon kernel:   [<f1390f49>] [<f1396330>] [<f139d1b8>] [<f138d573>] [<f139d1b8>] [<f13763e5>]
Nov  4 16:55:46 babylon kernel:   [<f139ca98>] [<f139cab8>] [<f138d34b>] [arch_kernel_thread+40/64]
Nov  4 16:55:46 babylon kernel: 
Nov  4 16:55:46 babylon kernel: Code: 0f 0b 66 00 53 27 21 c0 89 d8 2b 05 d0 14 29 c0 69 c0 a3 8b 

I believe this bug was occurring here:

if (PageLocked(page))
    BUG();

If anyone has any suggestions at all for things I can try (patches
included), I'd be quite happy to test them, as the current situation is
pretty much unworkable.  Also if there's any more information needed, let
me know.

I'm not subscribed to the list, so please CC me directly.

Thanks in advance,

Alistair Phipps
