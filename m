Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268034AbRGVSqf>; Sun, 22 Jul 2001 14:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268033AbRGVSqb>; Sun, 22 Jul 2001 14:46:31 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:22171 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S268032AbRGVSqP>;
	Sun, 22 Jul 2001 14:46:15 -0400
Message-ID: <3B5B1F77.D8B45FFA@candelatech.com>
Date: Sun, 22 Jul 2001 11:46:15 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        Tulip Mailing List <tulip@scyld.com>, vortex@scyld.com,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [BUG REPORT]  Sony VAIO, 2.4.7:  CardBus failures with Tulip & 3c575 
 cards.
Content-Type: multipart/mixed;
 boundary="------------74C63F0DE22FFA5CBB2BF61D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------74C63F0DE22FFA5CBB2BF61D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This report contains information about my failure to get my
CardBus NICs working correctly.  Hardware involved is:

Sony VAIO PCG-FX210 laptop (800Mhz Duron...)
DFE-650 16-bit PCMCIA NIC x2
3Com Megahertz 32-bit 3CCFE575BT NIC x2
AmbiCom 32-bit 8100 NIC  (tulip) x2

Software:  RH 7.1, plus all RH updates.
PCMCIA services are disabled via ntsvc
Kernel is 2.4.7, and the kernel.config is attached.  It is basically RedHat's 2.4.3+ config.
(RH 7.1 with it's standard 2.4.2 or upgrade 2.4.3-12 kernel doesn't work either, or I wouldn't have
tried all this other stuff!)

The basic problem is that I cannot get any combination of these
cards to work in the laptop.  There are more problems with the
bottom slot (slot 1) than the top slot (slot 0).

lspci capture is attached.
kernel.config is attached.
dmesg capture is attached.

Chapter 1, AmbiCom in slot 1 hangs the sytem untill removed.  Here is insert of
the first one, it seems to work:

Jul 22 10:13:36 lanforge-ice kernel: cs: cb_alloc(bus 2): vendor 0x1011, device 0x0019
Jul 22 10:13:36 lanforge-ice kernel:   got res[2000:207f] for resource 0 of PCI device 1011:0019
Jul 22 10:13:36 lanforge-ice kernel:   got res[10800000:108003ff] for resource 1 of PCI device 1011:0019
Jul 22 10:13:36 lanforge-ice kernel:   got res[10400000:1043ffff] for resource 6 of PCI device 1011:0019
Jul 22 10:13:36 lanforge-ice kernel: PCI: Enabling device 02:00.0 (0000 -> 0003)
Jul 22 10:13:36 lanforge-ice kernel: Linux Tulip driver version 0.9.15-pre6 (July 2, 2001)
Jul 22 10:13:36 lanforge-ice kernel: PCI: Setting latency timer of device 02:00.0 to 64
Jul 22 10:13:36 lanforge-ice kernel: tulip0:  EEPROM default media type Autosense.
Jul 22 10:13:36 lanforge-ice kernel: tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Jul 22 10:13:36 lanforge-ice kernel: tulip0:  MII transceiver #1 config 1000 status 7849 advertising 01e1.
Jul 22 10:13:36 lanforge-ice kernel: eth1: Digital DS21143 Tulip rev 65 at 0x2000, 00:10:7A:18:B5:F9, IRQ 9.
Jul 22 10:13:36 lanforge-ice /etc/hotplug/net.agent: register event not handled

When I insert the second one, the machine hangs untill I remove it.  When it is removed, after about
2 seconds, this is printed to /var/log/messages:
Jul 22 10:13:59 lanforge-ice kernel: cs: socket c1244000 timed out during reset.  Try increasing setup_delay.

The machine hangs any time I place the tulip card in slot 1, regardless of what is or isn't
in slot 0.


Chapter 2, 3Com screws up too:

If the machine is booted (dmesg output attached) with both 3Com NICs inserted, the second
one in slot 1 is not detected.  If I remove and re-insert it, it fails to be detected correctly:

Jul 22 10:35:55 lanforge-ice kernel: PCI: device 06:00.0 has unknown header type 7f, ignoring.
Jul 22 10:35:55 lanforge-ice kernel: PCI: No IRQ known for interrupt pin A of device 06:00.0. Please try using pci=biosirq.
Jul 22 10:35:55 lanforge-ice kernel: PCI: device 06:00.1 has unknown header type 7f, ignoring.
Jul 22 10:35:55 lanforge-ice kernel: PCI: device 06:00.2 has unknown header type 7f, ignoring.
Jul 22 10:35:55 lanforge-ice kernel: PCI: device 06:00.3 has unknown header type 7f, ignoring.
Jul 22 10:35:55 lanforge-ice kernel: PCI: device 06:00.4 has unknown header type 7f, ignoring.
Jul 22 10:35:55 lanforge-ice kernel: PCI: device 06:00.5 has unknown header type 7f, ignoring.
Jul 22 10:35:55 lanforge-ice kernel: PCI: device 06:00.6 has unknown header type 7f, ignoring.
Jul 22 10:35:55 lanforge-ice kernel: PCI: device 06:00.7 has unknown header type 7f, ignoring.
Jul 22 10:35:55 lanforge-ice /etc/hotplug/pci.agent: ... no drivers for PCI slot 

If I remove it and re-insert it again, it is detected, but can't find MII.  If I wait
too long between removal and re-insertion, it does not work.

Jul 22 10:37:08 lanforge-ice kernel: cs: cb_alloc(bus 6): vendor 0x10b7, device 0x5157
Jul 22 10:37:08 lanforge-ice kernel:   got res[2800:287f] for resource 0 of PCI device 10b7:5157
Jul 22 10:37:08 lanforge-ice kernel:   got res[11000000:1100007f] for resource 1 of PCI device 10b7:5157
Jul 22 10:37:08 lanforge-ice kernel:   got res[11000080:110000ff] for resource 2 of PCI device 10b7:5157
Jul 22 10:37:08 lanforge-ice kernel:   got res[10c00000:10c1ffff] for resource 6 of PCI device 10b7:5157
Jul 22 10:37:08 lanforge-ice kernel: PCI: Enabling device 06:00.0 (0000 -> 0003)
Jul 22 10:37:08 lanforge-ice kernel: 06:00.0: 3Com PCI 3CCFE575BT Cyclone CardBus at 0x2800, PCI: Setting laten
cy timer of device 06:00.0 to 64
Jul 22 10:37:08 lanforge-ice kernel:  00:50:da:d2:98:bf, IRQ 10
Jul 22 10:37:08 lanforge-ice kernel:   product code 5a48 rev 07.1 date 06-20-00
Jul 22 10:37:08 lanforge-ice kernel: 06:00.0: CardBus functions mapped 11000080->c887f080
Jul 22 10:37:08 lanforge-ice kernel:   8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
Jul 22 10:37:08 lanforge-ice kernel:   ***WARNING*** No MII transceivers found!
Jul 22 10:37:08 lanforge-ice kernel:   Enabling bus-master transmits and whole-frame receives.
Jul 22 10:37:08 lanforge-ice kernel: 06:00.0: scatter/gather disabled. h/w checksums enabled
Jul 22 10:37:09 lanforge-ice /etc/hotplug/net.agent: register event not handled
Jul 22 10:37:09 lanforge-ice kernel: eth2: using default media MII

If I now attach cables to these NICs (cross-over cables, connected to eepro NICs on the
other side), then I do not get link light on the NIC in slot 1, though slot 0 has 100bt link.
If I change the cables, slot 1 is still failed and slot 0 remains good:  It is the NICs.
If I change the NICs, the problem is still on slot 1.

Chapter 3: D-LINK DFE-650 not supported in 2.4.7.

These 16-bit NICs actually work with RH 7.1, although they start dropping large
amounts of packets after running at 1Mbps after 5 minutes or so.  They also work
equally well in slot 0 or slot 1.  They do not work at all in 2.4.7, because (I imagine)
the driver is not included.

So, does anyone have any ideas?  I really want to get three ethernet NICs (one built-in) working in
some laptop.  At least two of the NICs need to be able to auto-negotiate and run at a sustained
1.54Mbps bi-directional.  I'm willing to buy any NICs that will work, and getting a new laptop is an
option too.  I can offer more debug information, up to and including letting someone log into
the laptop over it's built-in (RTL) NIC and play around...

Any and all help will be greatly appreciated!

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
--------------74C63F0DE22FFA5CBB2BF61D
Content-Type: text/plain; charset=us-ascii;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: Sony Corporation: Unknown device 803d
	Flags: bus master, medium devsel, latency 8
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b115 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f4100000-f5ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: Sony Corporation: Unknown device 803d
	Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 0
	I/O ports at 1000 [size=16]
	Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 1020 [size=32]
	Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 1040 [size=32]
	Capabilities: [80] Power Management version 2

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel, IRQ 9
	Capabilities: [68] Power Management version 2

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
	Subsystem: Sony Corporation: Unknown device 80e3
	Flags: medium devsel, IRQ 5
	I/O ports at 1400 [size=256]
	I/O ports at 1014 [size=4]
	I/O ports at 1010 [size=4]
	Capabilities: [c0] Power Management version 2

00:07.6 Communication controller: VIA Technologies, Inc. AC97 Modem Controller (rev 20)
	Subsystem: Sony Corporation: Unknown device 80e3
	Flags: medium devsel, IRQ 5
	I/O ports at 1800 [disabled] [size=256]
	Capabilities: [d0] Power Management version 2

00:0a.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Sony Corporation: Unknown device 80e3
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00002000-000020ff
	I/O window 1: 00002400-000024ff
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Sony Corporation: Unknown device 80e3
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00002800-000028ff
	I/O window 1: 00002c00-00002cff
	Secondary status: SERR
	16-bit legacy interface ports at 0001

00:0e.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80e3
	Flags: medium devsel, IRQ 9
	Memory at f4004000 (32-bit, non-prefetchable) [disabled] [size=2K]
	Memory at f4000000 (32-bit, non-prefetchable) [disabled] [size=16K]
	Capabilities: [44] Power Management version 1

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Sony Corporation: Unknown device 80e3
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at 1c00 [size=256]
	Memory at f4004800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80e3
	Flags: bus master, stepping, medium devsel, latency 66, IRQ 5
	Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at 9000 [size=256]
	Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
	Capabilities: [5c] Power Management version 1

02:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Ambicom Inc 10/100 Ethernet CardBus PC Card
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 2000 [size=128]
	Memory at 10800000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 10400000 [size=256K]


--------------74C63F0DE22FFA5CBB2BF61D
Content-Type: text/plain; charset=us-ascii;
 name="kernel.config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel.config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
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
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_TOSHIBA=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_EISA=y
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_I82365=y
# CONFIG_TCIC is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

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
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_XD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_KHTTPD is not set
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m

#
#  
#
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DECNET=m
CONFIG_DECNET_SIOCGIFCONF=y
CONFIG_DECNET_ROUTER=y
CONFIG_DECNET_ROUTE_FWMARK=y
CONFIG_BRIDGE=m
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
CONFIG_WAN_ROUTER=m
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_CSZ=m
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Telephony Support
#
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m

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
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_ISAPNP=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_AEC62XX_TUNING=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD7409=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=4
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_7000FASST=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_AIC7XXX_OLD_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_OLD_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_OLD_PROC_STATS=y
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_IN2000=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_MEGARAID=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_CPQFCTS=m
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_DTC3280=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
# CONFIG_SCSI_EATA_LINKED_COMMANDS is not set
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_EATA_DMA=m
CONFIG_SCSI_EATA_PIO=m
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_GENERIC_NCR5380=m
# CONFIG_SCSI_GENERIC_NCR53C400 is not set
CONFIG_SCSI_G_NCR5380_PORT=y
# CONFIG_SCSI_G_NCR5380_MEM is not set
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_NCR53C406A=m
CONFIG_SCSI_NCR53C7xx=m
# CONFIG_SCSI_NCR53C7xx_sync is not set
CONFIG_SCSI_NCR53C7xx_FAST=y
CONFIG_SCSI_NCR53C7xx_DISCONNECT=y
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_PCI2000=m
CONFIG_SCSI_PCI2220I=m
CONFIG_SCSI_PSI240I=m
CONFIG_SCSI_QLOGIC_FAS=m
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_SEAGATE=m
CONFIG_SCSI_SIM710=m
CONFIG_SCSI_SYM53C416=m
CONFIG_SCSI_DC390T=m
# CONFIG_SCSI_DC390T_NOGENSUPP is not set
CONFIG_SCSI_T128=m
CONFIG_SCSI_U14_34F=m
# CONFIG_SCSI_U14_34F_LINKED_COMMANDS is not set
CONFIG_SCSI_U14_34F_MAX_TAGS=8
CONFIG_SCSI_ULTRASTOR=m
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
CONFIG_SCSI_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m

#
# Fusion MPT device support
#
CONFIG_FUSION=m
# CONFIG_FUSION_BOOT is not set

#
# (ability to boot linux kernel from Fusion device is DISABLED!)
#
# CONFIG_FUSION_ISENSE is not set
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m
CONFIG_NET_FC=y

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=m
# CONFIG_IEEE1394_PCILYNX_LOCALRAM is not set
CONFIG_IEEE1394_PCILYNX_PORTS=y
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
# CONFIG_IEEE1394_SBP2 is not set
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Appletalk devices
#
CONFIG_APPLETALK=y
CONFIG_LTPC=m
CONFIG_COPS=m
CONFIG_COPS_DAYNA=y
CONFIG_COPS_TANGENT=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
CONFIG_NET_SB1000=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_ARM_AM79C961A is not set
CONFIG_HAPPYMEAL=m
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
CONFIG_VORTEX=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
CONFIG_ULTRA=m
CONFIG_ULTRA32=m
# CONFIG_SMC9194 is not set
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI5010=m
CONFIG_NI52=m
CONFIG_NI65=m
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
CONFIG_NET_ISA=y
CONFIG_E2100=m
CONFIG_EWRK3=m
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
CONFIG_DE4X5=m
CONFIG_DGRS=m
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=m
CONFIG_LNE390=m
# CONFIG_FEALNX is not set
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_NE3210=m
CONFIG_ES3210=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
CONFIG_WINBOND_840=m
CONFIG_NET_POCKET=y
CONFIG_ATP=m
CONFIG_DE600=m
CONFIG_DE620=m

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
# CONFIG_DL2K is not set
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_SK98LIN=m
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
CONFIG_STRIP=m
CONFIG_WAVELAN=m
CONFIG_ARLAN=m
CONFIG_AIRONET4500=m
CONFIG_AIRONET4500_NONCS=m
CONFIG_AIRONET4500_PNP=y
CONFIG_AIRONET4500_PCI=y
CONFIG_AIRONET4500_ISA=y
CONFIG_AIRONET4500_I365=y
CONFIG_AIRONET4500_PROC=m
# CONFIG_AIRO is not set

#
# Wireless Pcmcia cards support
#
CONFIG_PCMCIA_HERMES=m
# CONFIG_AIRO_CS is not set
CONFIG_NET_WIRELESS=y

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_TMSISA=m
CONFIG_ABYSS=m
CONFIG_SMCTR=m
CONFIG_NET_FC=y
CONFIG_IPHASE5526=m
CONFIG_RCPCI=m
CONFIG_SHAPER=m

#
# Wan interfaces
#
CONFIG_WAN=y
CONFIG_HOSTESS_SV11=m
CONFIG_COSA=m
# CONFIG_COMX is not set
# CONFIG_DSCC4 is not set
# CONFIG_LANMEDIA is not set
CONFIG_SEALEVEL_4021=m
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_HDLC is not set
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_SDLA=m
CONFIG_WAN_ROUTER_DRIVERS=y
CONFIG_VENDOR_SANGOMA=m
CONFIG_WANPIPE_CHDLC=y
CONFIG_WANPIPE_FR=y
CONFIG_WANPIPE_X25=y
CONFIG_WANPIPE_PPP=y
CONFIG_WANPIPE_MULTPPP=y
CONFIG_CYCLADES_SYNC=m
CONFIG_CYCLOMX_X25=y
CONFIG_SBNI=m

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_IBMTR=m
CONFIG_PCMCIA_XIRTULIP=m
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_NETWAVE=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_AIRONET4500_CS=m

#
# ATM drivers
#
CONFIG_ATM_TCP=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_ZATM_EXACT_TS=y
CONFIG_ATM_NICSTAR=m
CONFIG_ATM_NICSTAR_USE_SUNI=y
CONFIG_ATM_NICSTAR_USE_IDT77105=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=m
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=m
CONFIG_ATM_FORE200E_PCA=y
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=y
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_FORE200E=m

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_OPTIONS=y

#
#   IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
# CONFIG_ALI_FIR is not set

#
# ISDN subsystem
#
CONFIG_ISDN=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_PPP_BSDCOMP=m
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DRV_LOOP=m
# CONFIG_ISDN_DIVERSION is not set

#
# low-level hardware drivers
#

#
# Passive ISDN cards
#
CONFIG_ISDN_DRV_HISAX=m

#
#   D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
CONFIG_HISAX_1TR6=y
CONFIG_HISAX_NI1=y

#
#   HiSax supported cards
#
CONFIG_HISAX_16_0=y
CONFIG_HISAX_16_3=y
CONFIG_HISAX_TELESPCI=y
CONFIG_HISAX_S0BOX=y
CONFIG_HISAX_AVM_A1=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
CONFIG_HISAX_IX1MICROR2=y
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_ASUSCOM=y
CONFIG_HISAX_TELEINT=y
CONFIG_HISAX_HFCS=y
CONFIG_HISAX_SEDLBAUER=y
CONFIG_HISAX_SPORTSTER=y
CONFIG_HISAX_MIC=y
CONFIG_HISAX_NETJET=y
CONFIG_HISAX_NETJET_U=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_ISURF=y
CONFIG_HISAX_HSTSAPHIR=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
CONFIG_HISAX_GAZEL=y
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
CONFIG_HISAX_HFC_SX=y
CONFIG_HISAX_SEDLBAUER_CS=m
CONFIG_HISAX_ELSA_CS=m

#
# Active ISDN cards
#
CONFIG_ISDN_DRV_ICN=m
CONFIG_ISDN_DRV_PCBIT=m
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
# CONFIG_ISDN_DRV_EICON is not set
# CONFIG_ISDN_DRV_TPAM is not set
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m
CONFIG_ISDN_CAPI_CAPIDRV=m
CONFIG_ISDN_DRV_AVMB1_B1ISA=m
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1ISA=m
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=m
CONFIG_ISDN_DRV_AVMB1_AVM_CS=m
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
CONFIG_CD_NO_IDESCSI=y
CONFIG_AZTCD=m
CONFIG_GSCD=m
CONFIG_SBPCD=m
CONFIG_MCD=m
CONFIG_MCD_IRQ=11
CONFIG_MCD_BASE=300
CONFIG_MCDX=m
CONFIG_OPTCD=m
CONFIG_CM206=m
CONFIG_SJCD=m
CONFIG_ISP16_CDI=m
CONFIG_CDU31A=m
CONFIG_CDU535=m

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
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
CONFIG_SERIAL_MULTIPORT=y
# CONFIG_HUB6 is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
CONFIG_ESPSERIAL=m
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_ISI=m
CONFIG_SYNCLINK=m
CONFIG_N_HDLC=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
CONFIG_SPECIALIX_RTSCTS=y
CONFIG_SX=m
# CONFIG_RIO is not set
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m

#
# Mice
#
CONFIG_BUSMOUSE=m
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m

#
# Joysticks
#
CONFIG_JOYSTICK=y

#
# Game port support
#
CONFIG_INPUT_NS558=m
CONFIG_INPUT_LIGHTNING=m
CONFIG_INPUT_PCIGAME=m
CONFIG_INPUT_CS461X=m

#
# Gameport joysticks
#
CONFIG_INPUT_ANALOG=m
CONFIG_INPUT_A3D=m
CONFIG_INPUT_ADI=m
CONFIG_INPUT_COBRA=m
CONFIG_INPUT_GF2K=m
CONFIG_INPUT_GRIP=m
CONFIG_INPUT_INTERACT=m
CONFIG_INPUT_TMDC=m
CONFIG_INPUT_SIDEWINDER=m

#
# Serial port support
#
CONFIG_INPUT_SERPORT=m

#
# Serial port joysticks
#
CONFIG_INPUT_WARRIOR=m
CONFIG_INPUT_MAGELLAN=m
CONFIG_INPUT_SPACEORB=m
CONFIG_INPUT_SPACEBALL=m
CONFIG_INPUT_STINGER=m
CONFIG_INPUT_IFORCE_232=m
CONFIG_INPUT_IFORCE_USB=m

#
# Parallel port joysticks
#
CONFIG_INPUT_DB9=m
CONFIG_INPUT_GAMECON=m
CONFIG_INPUT_TURBOGRAFX=m
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDT=m
CONFIG_WDTPCI=m
# CONFIG_WDT_501 is not set
CONFIG_PCWATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MIXCOMWD is not set
CONFIG_I810_TCO=m
CONFIG_MACHZ_WDT=m
# CONFIG_INTEL_RNG is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
CONFIG_R3964=m
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240

#
#   The compressor will be built as a module only!
#
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
# CONFIG_FT_PROC_FS is not set
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_MGA=m

#
# PCMCIA character devices
#
CONFIG_PCMCIA_SERIAL_CS=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
CONFIG_I2C_PARPORT=m

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_W9966=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZR36120=m

#
# Radio Adapters
#
CONFIG_RADIO_CADET=m
CONFIG_RADIO_RTRACK=m
CONFIG_RADIO_RTRACK2=m
CONFIG_RADIO_AZTECH=m
CONFIG_RADIO_GEMTEK=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_MAESTRO=m
CONFIG_RADIO_MIROPCM20=m
# CONFIG_RADIO_MIROPCM20_RDS is not set
CONFIG_RADIO_SF16FMI=m
CONFIG_RADIO_TERRATEC=m
CONFIG_RADIO_TRUST=m
CONFIG_RADIO_TYPHOON=m
CONFIG_RADIO_TYPHOON_PROC_FS=y
CONFIG_RADIO_ZOLTRIX=m

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_BFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MDA_CONSOLE=m

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=m
CONFIG_FB_CLGEN=m
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_PM2_PCI=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_HGA=m
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_PVR2 is not set
# CONFIG_FB_E1355 is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
# CONFIG_FB_MATROX_MAVEN is not set
# CONFIG_FB_MATROX_G450 is not set
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_ATY=m
CONFIG_FB_ATY128=m
CONFIG_FB_3DFX=m
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_HGA=m
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=m
CONFIG_SOUND_CMPCI=m
# CONFIG_SOUND_CMPCI_FM is not set
# CONFIG_SOUND_CMPCI_MIDI is not set
# CONFIG_SOUND_CMPCI_JOYSTICK is not set
# CONFIG_SOUND_CMPCI_CM8738 is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
CONFIG_SOUND_MSNDCLAS=m
# CONFIG_MSNDCLAS_HAVE_BOOT is not set
CONFIG_MSNDCLAS_INIT_FILE="/etc/sound/msndinit.bin"
CONFIG_MSNDCLAS_PERM_FILE="/etc/sound/msndperm.bin"
CONFIG_SOUND_MSNDPIN=m
# CONFIG_MSNDPIN_HAVE_BOOT is not set
CONFIG_MSNDPIN_INIT_FILE="/etc/sound/pndspini.bin"
CONFIG_MSNDPIN_PERM_FILE="/etc/sound/pndsperm.bin"
CONFIG_SOUND_VIA82CXXX=m
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUS16=y
CONFIG_SOUND_GUSMAX=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
CONFIG_MAD16_OLDCARD=y
CONFIG_SOUND_PAS=m
CONFIG_SOUND_PSS=m
# CONFIG_PSS_MIXER is not set
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_WAVEFRONT=m
CONFIG_SOUND_MAUI=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
CONFIG_SOUND_YMFPCI_LEGACY=y
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
CONFIG_SC6600=y
CONFIG_SC6600_JOY=y
CONFIG_SC6600_CDROM=4
CONFIG_SC6600_CDROMBASE=0
CONFIG_AEDSP16_SBPRO=y
CONFIG_AEDSP16_MPU401=y
CONFIG_SOUND_TVMIXER=m

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
# USB Controllers
#
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_FREECOM=y
# CONFIG_USB_STORAGE_DPCM is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_KBD=m
# CONFIG_USB_MOUSE is not set
CONFIG_USB_WACOM=m

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m

#
# USB Multimedia devices
#
CONFIG_USB_IBMCAM=m
CONFIG_USB_OV511=m
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
CONFIG_USB_DSBR=m
CONFIG_USB_DABUSB=m

#
# USB Network adaptors
#
CONFIG_USB_PLUSB=m
CONFIG_USB_PEGASUS=m
# CONFIG_USB_CATC is not set
CONFIG_USB_NET1080=m

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_OMNINET=m

#
# USB misc drivers
#
CONFIG_USB_RIO500=m

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

--------------74C63F0DE22FFA5CBB2BF61D
Content-Type: text/plain; charset=us-ascii;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.4.7 (root@lanforge-ice) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #2 Sun Jul 22 09:01:40 MST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007fffc00 (ACPI data)
 BIOS-e820: 0000000007fffc00 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009f800 for 4096 bytes.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01221000)
Kernel command line: auto BOOT_IMAGE=linux-ct ro root=305 BOOT_FILE=/ct.img
Initializing CPU#0
Detected 800.052 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 126384k/131008k available (1081k kernel code, 4236k reserved, 385k data, 236k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd83d, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Cannot allocate resource region 0 of device 00:07.5
  got res[1400:14ff] for resource 0 of VIA Technologies, Inc. AC97 Audio Controller
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1420
  got res[10001000:10001fff] for resource 0 of Texas Instruments PCI1420 (#2)
Found VT82C686A, not applying VIA latency patch.
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
block: queued sectors max/low 83821kB/27940kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHM2100AT, ATA DISK drive
hdc: HITACHI DVD-ROM GD-S200, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19640880 sectors (10056 MB) w/2048KiB Cache, CHS=1222/255/63, UDMA(66)
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 9 for device 00:0a.0
PCI: Assigned IRQ 10 for device 00:0a.1
IRQ routing conflict for 00:07.5, have irq 5, want irq 10
IRQ routing conflict for 00:07.6, have irq 5, want irq 10
PCI: Sharing IRQ 10 with 00:10.0
Intel PCIC probe: not found.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Yenta IRQ list 0808, PCI irq9
Socket status: 30000020
Yenta IRQ list 0808, PCI irq10
Socket status: 30000020
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cs: cb_alloc(bus 2): vendor 0x10b7, device 0x5157
  got res[2000:207f] for resource 0 of PCI device 10b7:5157
  got res[10800000:1080007f] for resource 1 of PCI device 10b7:5157
  got res[10800080:108000ff] for resource 2 of PCI device 10b7:5157
  got res[10400000:1041ffff] for resource 6 of PCI device 10b7:5157
PCI: Enabling device 02:00.0 (0000 -> 0003)
cs: cb_alloc(bus 6): vendor 0x0109, device 0x8006
PCI: device 06:00.0 has unknown header type 06, ignoring.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 236k freed
Adding Swap: 265032k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.259 $ time 09:22:01 Jul 22 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Enabling device 00:07.2 (0010 -> 0011)
PCI: Assigned IRQ 9 for device 00:07.2
PCI: Sharing IRQ 9 with 00:07.3
PCI: Sharing IRQ 9 with 00:0e.0
PCI: Setting latency timer of device 00:07.2 to 64
usb-uhci.c: USB UHCI at I/O 0x1020, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 00:07.3 (0010 -> 0011)
PCI: Found IRQ 9 for device 00:07.3
PCI: Sharing IRQ 9 with 00:07.2
PCI: Sharing IRQ 9 with 00:0e.0
PCI: Setting latency timer of device 00:07.3 to 64
usb-uhci.c: USB UHCI at I/O 0x1040, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.251:USB Universal Host Controller Interface driver
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
ip_conntrack (1023 buckets, 8184 max)
8139too Fast Ethernet driver 0.9.18
PCI: Enabling device 00:10.0 (0000 -> 0003)
PCI: Found IRQ 10 for device 00:10.0
IRQ routing conflict for 00:07.5, have irq 5, want irq 10
IRQ routing conflict for 00:07.6, have irq 5, want irq 10
PCI: Sharing IRQ 10 with 00:0a.1
PCI: Setting latency timer of device 00:10.0 to 64
eth0: RealTek RTL8139 Fast Ethernet at 0xc8852800, 08:00:46:1d:7b:d8, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
Linux Tulip driver version 0.9.15-pre6 (July 2, 2001)
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:00.0: 3Com PCI 3CCFE575BT Cyclone CardBus at 0x2000, PCI: Setting latency timer of device 02:00.0 to 64
 00:50:da:d2:7a:21, IRQ 9
  product code 5a48 rev 07.1 date 06-21-00
02:00.0: CardBus functions mapped 10800080->c885c080
  8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
  MII transceiver found at address 0, status 282d.
  Enabling bus-master transmits and whole-frame receives.
02:00.0: scatter/gather disabled. h/w checksums enabled
eth1: using default media MII
Via 686a audio driver 1.1.14b
PCI: Found IRQ 10 for device 00:07.5
IRQ routing conflict for 00:07.5, have irq 5, want irq 10
IRQ routing conflict for 00:07.6, have irq 5, want irq 10
PCI: Sharing IRQ 10 with 00:0a.1
PCI: Sharing IRQ 10 with 00:10.0
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: Codec rate locked at 48Khz
via82cxxx: timeout while reading AC97 codec (0x800000)
ac97_codec: AC97  codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
via82cxxx: board #1 at 0x1400, IRQ 5
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
eth1: using default media MII
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)

--------------74C63F0DE22FFA5CBB2BF61D--

