Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUCMNpi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 08:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbUCMNpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 08:45:38 -0500
Received: from c-24-1-76-144.client.comcast.net ([24.1.76.144]:11012 "EHLO
	stoneboro.uucp.cirr.com") by vger.kernel.org with ESMTP
	id S263095AbUCMNoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 08:44:01 -0500
Date: 13 Mar 2004 07:43:59 -0600
Message-ID: <20040313134359.826.qmail@stoneboro.uucp.cirr.com>
From: Chris Smith <csmith@stoneboro.uucp.cirr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.25 OOPS freeing page in buddy system allocator
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS doesn't seem to have anybody specific for this, and I
don't know " -- wli" who signed the header comment, so off into the
void it goes...

I have been seeing sporadic OOPSes from a totally vanilla 2.4.25
kernel.  My hardware was very solid with 2.2.18 so I suspect software.

ksymoops report appended at the end.  The oops is a NULL pointer
dereference at <__free_pages_ok+280> which is here --

/usr/src/linux-2.4.25/mm/page_alloc.c line 156:

		/*
		 * Move the buddy up one level.
		 * This code is taking advantage of the identity:
		 * 	-mask = 1+~mask
		 */
		buddy1 = base + (page_idx ^ -mask);
		buddy2 = base + page_idx;

====>>		list_del(&buddy1->list);
		mask <<= 1;
		area++;
		index >>= 1;
		page_idx &= mask;

/usr/src/linux-2.4.25/include/linux/list.h line 82:

    static inline void list_del(struct list_head *entry)
    {
	    __list_del(entry->prev, entry->next);
	    entry->next = (void *) 0;
	    entry->prev = (void *) 0;
    }

    static inline void __list_del(struct list_head *prev, struct list_head *next)
    {
====>>	    next->prev = prev;
	    prev->next = next;
    }

-- i.e. buddy1->list->next is NULL.

I am running 2.4.25 with no modules, with XFS as included with 2.4.25.  
.config appended below.

The stack traces don't suggest anything to me, besides the fact that
it doesn't appear to depend on the caller of __free_pages_ok.

I have no idea how to reproduce it.

Hardware and software configs appended below.

I was not running an X server, the machine is headless.  It was running
approximately the daemons shown in the post-crash ps output below.

-- Chris Smith

 ---------- output of ksymoops ----------

Mar 12 23:46:11 foxboro kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Mar 12 23:46:11 foxboro kernel: printing eip:
Mar 12 23:46:11 foxboro kernel: c012cf30
Mar 12 23:46:11 foxboro kernel: *pde = 00000000
Mar 12 23:46:11 foxboro kernel: Oops: 0002
Mar 12 23:46:11 foxboro kernel: CPU:    0
Mar 12 23:46:11 foxboro kernel: EIP:    0010:[<c012cf30>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 12 23:46:11 foxboro kernel: EFLAGS: 00010086
Mar 12 23:46:11 foxboro kernel: eax: 00000000   ebx: c1085598   ecx: c108556c   edx: 00000000
Mar 12 23:46:11 foxboro kernel: esi: c02f275c   edi: 0000effc   ebp: 0000207c   esp: c195bedc
Mar 12 23:46:11 foxboro kernel: ds: 0018   es: 0018   ss: 0018
Mar 12 23:46:11 foxboro kernel: Process emacs (pid: 24781, stackpage=c195b000)
Mar 12 23:46:11 foxboro kernel: Stack: c02f27c8 c100001c c108556c c02f2718 c102c01c 00000257 ffffffff 00000000 
Mar 12 23:46:11 foxboro kernel: c307c008 c307c008 00000000 00000010 c014293a 00000000 c79e91c0 00000005 
Mar 12 23:46:11 foxboro kernel: c0142bff c195bf3c 00000000 00000104 c195a000 0000002e 00000000 00000000 
Mar 12 23:46:11 foxboro kernel: Call Trace:    [<c014293a>] [<c0142bff>] [<c014303d>] [<c010724f>]
Mar 12 23:46:11 foxboro kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03 00 00 00 00 d1 6c 


>>EIP; c012cf30 <__free_pages_ok+1f0/280>   <=====

>>esi; c02f275c <contig_page_data+11c/3c0>

Trace; c014293a <poll_freewait+3a/50>
Trace; c0142bff <do_select+10f/200>
Trace; c014303d <sys_select+31d/4c0>
Trace; c010724f <system_call+33/38>

Code;  c012cf30 <__free_pages_ok+1f0/280>
00000000 <_EIP>:
Code;  c012cf30 <__free_pages_ok+1f0/280>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012cf33 <__free_pages_ok+1f3/280>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012cf35 <__free_pages_ok+1f5/280>
   5:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c012cf3c <__free_pages_ok+1fc/280>
   c:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012cf42 <__free_pages_ok+202/280>
  12:   d1 6c 00 00               shrl   0x0(%eax,%eax,1)

Mar 12 23:46:11 foxboro kernel: <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Mar 12 23:46:11 foxboro kernel: printing eip:
Mar 12 23:46:11 foxboro kernel: c012cf30
Mar 12 23:46:11 foxboro kernel: *pde = 00000000
Mar 12 23:46:11 foxboro kernel: Oops: 0002
Mar 12 23:46:11 foxboro kernel: CPU:    0
Mar 12 23:46:11 foxboro kernel: EIP:    0010:[<c012cf30>]    Not tainted
Mar 12 23:46:11 foxboro kernel: EFLAGS: 00010086
Mar 12 23:46:11 foxboro kernel: eax: 00000000   ebx: c127d624   ecx: c127d650   edx: 00000000
Mar 12 23:46:11 foxboro kernel: esi: c02f275c   edi: 0000effc   ebp: 0000d7c7   esp: c195bcf8
Mar 12 23:46:11 foxboro kernel: ds: 0018   es: 0018   ss: 0018
Mar 12 23:46:11 foxboro kernel: Process emacs (pid: 24781, stackpage=c195b000)
Mar 12 23:46:11 foxboro kernel: Stack: c02f27c8 c100001c c127d650 c02f2718 c102c01c 00000257 ffffffff 00000000 
Mar 12 23:46:11 foxboro kernel: 0000c000 c06b7750 00238000 0000000d c0122f40 c127d650 0001170f c00b9220 
Mar 12 23:46:11 foxboro kernel: c02f9500 08400000 cca9a084 08400000 00000000 c0121a8b cfe27980 cca9a080 
Mar 12 23:46:11 foxboro kernel: Call Trace:    [<c0122f40>] [<c0121a8b>] [<c01243af>] [<c0112ae7>] [<c0117557>]
Mar 12 23:46:11 foxboro kernel: [<c01078f3>] [<c011087b>] [<c0279d0c>] [<c027a03e>] [<c027c52d>] [<c010da45>]
Mar 12 23:46:11 foxboro kernel: [<c01105d0>] [<c0107340>] [<c012cf30>] [<c014293a>] [<c0142bff>] [<c014303d>]
Mar 12 23:46:11 foxboro kernel: [<c010724f>]
Mar 12 23:46:11 foxboro kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03 00 00 00 00 d1 6c 


>>EIP; c012cf30 <__free_pages_ok+1f0/280>   <=====

>>esi; c02f275c <contig_page_data+11c/3c0>

Trace; c0122f40 <zap_pte_range+f0/102>
Trace; c0121a8b <zap_page_range+8b/f0>
Trace; c01243af <exit_mmap+af/130>
Trace; c0112ae7 <mmput+47/b0>
Trace; c0117557 <do_exit+77/250>
Trace; c01078f3 <die+73/80>
Trace; c011087b <do_page_fault+2ab/4e7>
Trace; c0279d0c <tcp_cwnd_restart+1c/b0>
Trace; c027a03e <tcp_transmit_skb+29e/420>
Trace; c027c52d <tcp_reset_xmit_timer+7d/e0>
Trace; c010da45 <save_i387_fxsave+55/130>
Trace; c01105d0 <do_page_fault+0/4e7>
Trace; c0107340 <error_code+34/3c>
Trace; c012cf30 <__free_pages_ok+1f0/280>
Trace; c014293a <poll_freewait+3a/50>
Trace; c0142bff <do_select+10f/200>
Trace; c014303d <sys_select+31d/4c0>
Trace; c010724f <system_call+33/38>

Code;  c012cf30 <__free_pages_ok+1f0/280>
00000000 <_EIP>:
Code;  c012cf30 <__free_pages_ok+1f0/280>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012cf33 <__free_pages_ok+1f3/280>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012cf35 <__free_pages_ok+1f5/280>
   5:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c012cf3c <__free_pages_ok+1fc/280>
   c:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012cf42 <__free_pages_ok+202/280>
  12:   d1 6c 00 00               shrl   0x0(%eax,%eax,1)

Mar 13 03:49:01 foxboro kernel: <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Mar 13 03:49:01 foxboro kernel: printing eip:
Mar 13 03:49:01 foxboro kernel: c012cf30
Mar 13 03:49:01 foxboro kernel: *pde = 00000000
Mar 13 03:49:01 foxboro kernel: Oops: 0002
Mar 13 03:49:01 foxboro kernel: CPU:    0
Mar 13 03:49:01 foxboro kernel: EIP:    0010:[<c012cf30>]    Not tainted
Mar 13 03:49:01 foxboro kernel: EFLAGS: 00010092
Mar 13 03:49:01 foxboro kernel: eax: 00000000   ebx: c113627c   ecx: c11362d4   edx: 00000000
Mar 13 03:49:01 foxboro kernel: esi: c02f2768   edi: 0000effc   ebp: 000060ca   esp: c16e9e1c
Mar 13 03:49:01 foxboro kernel: ds: 0018   es: 0018   ss: 0018
Mar 13 03:49:01 foxboro kernel: Process zcat (pid: 25551, stackpage=c16e9000)
Mar 13 03:49:01 foxboro kernel: Stack: c02f27c8 c100001c c11362d4 c02f2718 c102c01c 00000217 fffffffe 00001832 
Mar 13 03:49:01 foxboro kernel: 00047000 c24c9274 00071000 0000000e c0122f40 c1136300 00000292 c3637858 
Mar 13 03:49:01 foxboro kernel: cf0ff940 08400000 c3361084 080c7000 00000000 c0121a8b cadcb440 c3361080 
Mar 13 03:49:01 foxboro kernel: Call Trace:    [<c0122f40>] [<c0121a8b>] [<c01243af>] [<c0112ae7>] [<c0117557>]
Mar 13 03:49:01 foxboro kernel: [<c011cf8c>] [<c011d165>] [<c0106f94>] [<c011d581>] [<c013d04d>] [<c0133d09>]
Mar 13 03:49:01 foxboro kernel: [<c0107288>]
Mar 13 03:49:01 foxboro kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03 00 00 00 00 d1 6c 


>>EIP; c012cf30 <__free_pages_ok+1f0/280>   <=====

>>esi; c02f2768 <contig_page_data+128/3c0>

Trace; c0122f40 <zap_pte_range+f0/102>
Trace; c0121a8b <zap_page_range+8b/f0>
Trace; c01243af <exit_mmap+af/130>
Trace; c0112ae7 <mmput+47/b0>
Trace; c0117557 <do_exit+77/250>
Trace; c011cf8c <sig_exit+9c/a0>
Trace; c011d165 <dequeue_signal+65/d0>
Trace; c0106f94 <do_signal+1b4/2a0>
Trace; c011d581 <deliver_signal+31/70>
Trace; c013d04d <pipe_write+1fd/270>
Trace; c0133d09 <sys_write+e9/130>
Trace; c0107288 <signal_return+14/18>

Code;  c012cf30 <__free_pages_ok+1f0/280>
00000000 <_EIP>:
Code;  c012cf30 <__free_pages_ok+1f0/280>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012cf33 <__free_pages_ok+1f3/280>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012cf35 <__free_pages_ok+1f5/280>
   5:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c012cf3c <__free_pages_ok+1fc/280>
   c:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c012cf42 <__free_pages_ok+202/280>
  12:   d1 6c 00 00               shrl   0x0(%eax,%eax,1)

 ---------- ver_linux ----------

Linux foxboro 2.4.25 #1 Tue Mar 2 16:43:57 CST 2004 i686 AMD Athlon(TM) XP 2100+ AuthenticAMD GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.25
e2fsprogs              1.34
xfsprogs               2.3.9
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         

 ---------- lspci ----------

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:06.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01)
00:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
00:09.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 50)
00:09.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 50)
00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:0d.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 11)
00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 23)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200] (rev a3)

 ---------- .config ----------

#
# Automatically generated by make menuconfig: don't edit
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
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

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
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
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
# CONFIG_ISA is not set
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
# CONFIG_OOM_KILLER is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

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
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_TFTP is not set
CONFIG_IP_NF_IRC=y
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_HELPER is not set
CONFIG_IP_NF_MATCH_STATE=y
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_TARGET_LOG=y
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
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
# CONFIG_NET_SCHED is not set

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
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
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
CONFIG_IDEDMA_ONLYDISK=y
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
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

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
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

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
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
CONFIG_DE4X5=y
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
# CONFIG_8139TOO is not set
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
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

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
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_UNIX98_PTYS is not set

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
# CONFIG_SCx200 is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_OBMOUSE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
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
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_TRACE is not set
# CONFIG_XFS_DEBUG is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
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
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set

 ---------- ps, only approximate ----------

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:03 init [3]  
    2 ?        SW     0:00 [keventd]
    3 ?        SWN    0:00 [ksoftirqd_CPU0]
    4 ?        SW     0:00 [kswapd]
    5 ?        SW     0:00 [bdflush]
    6 ?        SW     0:00 [kupdated]
    7 ?        SW     0:00 [pagebufd]
    8 ?        SW     0:00 [xfslogd/0]
    9 ?        SW     0:00 [xfsdatad/0]
   10 ?        SW     0:00 [xfssyncd]
  154 ?        S      0:00 /sbin/devfsd /dev
  373 ?        SW     0:00 [xfssyncd]
  374 ?        SW     0:00 [xfssyncd]
  375 ?        SW     0:00 [xfssyncd]
  376 ?        SW     0:00 [xfssyncd]
  987 ?        S      0:00 /sbin/dhcpcd -d -R -Y -N eth1
  999 ?        S      0:00 /usr/sbin/syslog-ng
 1034 ?        S      0:00 /usr/sbin/cupsd
 1336 ?        S      0:00 /sbin/portmap
 1374 ?        S      0:00 /sbin/rpc.statd
 1382 ?        SW     0:00 [nfsd]
 1383 ?        SW     0:00 [lockd]
 1384 ?        SW     0:00 [rpciod]
 1385 ?        SW     0:00 [nfsd]
 1386 ?        SW     0:00 [nfsd]
 1387 ?        SW     0:00 [nfsd]
 1388 ?        SW     0:00 [nfsd]
 1389 ?        SW     0:00 [nfsd]
 1390 ?        SW     0:00 [nfsd]
 1391 ?        SW     0:00 [nfsd]
 1395 ?        S      0:00 /usr/sbin/rpc.mountd --no-nfs-version 3
 1514 ?        S      0:00 /usr/bin/svscan /service
 1522 ?        S      0:00 supervise dnscache
 1523 ?        S      0:00 supervise log
 1524 ?        S      0:00 supervise qmail-send
 1525 ?        S      0:00 supervise log
 1526 ?        S      0:00 supervise qmail-smtpd
 1527 ?        S      0:00 supervise log
 1528 ?        S      0:00 qmail-send
 1529 ?        S      0:00 /usr/bin/dnscache
 1530 ?        S      0:00 /usr/bin/multilog t s2500000 /var/log/qmail/qmail-sen
 1531 ?        S      0:00 multilog t ./main
 1532 ?        S      0:00 /usr/bin/tcpserver -p -v -R -x /etc/tcp.smtp.cdb -c 4
 1533 ?        S      0:00 /usr/bin/multilog t s2500000 /var/log/qmail/qmail-smt
 1537 ?        SL     0:00 /usr/bin/ntpd -p /var/run/ntpd.pid -U ntp
 1578 ?        S      0:00 qmail-lspawn ./.maildir/
 1579 ?        S      0:00 qmail-rspawn
 1580 ?        S      0:00 qmail-clean
 1583 ?        S      0:00 /usr/sbin/sshd
 1607 ?        S      0:00 /usr/sbin/cron
 1779 ?        S      0:00 /usr/X11R6/bin/xfs -daemon -config /etc/X11/fs/config
 1808 ?        S      0:00 /usr/sbin/xinetd -pidfile /var/run/xinetd.pid -stayal
 1814 ?        S      0:00 /sbin/genpowerd /dev/ttyS0 backups-pro
 1822 vc/1     S      0:00 /sbin/agetty 38400 tty1 linux
 1823 vc/2     S      0:00 /sbin/agetty 38400 tty2 linux
 1824 vc/3     S      0:00 /sbin/agetty 38400 tty3 linux
 1825 vc/4     S      0:00 /sbin/agetty 38400 tty4 linux
 1826 vc/5     S      0:00 /sbin/agetty 38400 tty5 linux
 1827 vc/6     S      0:00 /sbin/agetty 38400 tty6 linux
 1840 ?        R      0:08 emacs
 1857 ?        S      0:00 xterm -bg #302010 -fg white
 1859 pty/s1   S      0:00 bash
 1860 pty/s1   S      0:00 .s
 1861 pty/s1   S      0:00 bash
 2684 pty/s2   S      0:00 /bin/bash --noediting -i
 2687 pty/s2   R      0:00 ps xa
