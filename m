Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130650AbRBWWNd>; Fri, 23 Feb 2001 17:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130624AbRBWWNV>; Fri, 23 Feb 2001 17:13:21 -0500
Received: from citadel.myri.com ([199.120.212.1]:43775 "EHLO myri.com")
	by vger.kernel.org with ESMTP id <S130620AbRBWWNK>;
	Fri, 23 Feb 2001 17:13:10 -0500
Date: Fri, 23 Feb 2001 14:13:08 -0800 (PST)
From: Bob Felderman <feldy@myri.com>
Message-Id: <200102232213.OAA20842@myri.com>
To: linux-kernel@vger.kernel.org
Subject: possible bug x86 2.4.2 SMP in IP receive stack
Cc: feldy@myri.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With dual x86 processors running 2.4.2, if I blast a UDP
stream at the machine using netperf, I can easily
cause the kernel to panic with the message below.

Feb 23 12:42:30 rcc2 kernel: Warning: kfree_skb passed an skb still on a list (from c01f58dc).

I'm going to pop out one processor on the receiver
and see if that makes the problem go away.

Note that this is using a Myrinet network that is able to 
get more than 1.5Gigabit/sec UDP transfers on 
single-processor x86 2.4.0 linux. Perhaps this is reproducible 
with good GigE cards with jumbo MTU turned on.

I'm also upping the socket limits
echo "1048576" > /proc/sys/net/core/rmem_max
echo "1048576" > /proc/sys/net/core/wmem_max
echo "1048576" > /proc/sys/net/core/wmem_default
echo "1048576" > /proc/sys/net/core/rmem_default
echo "1048576" > /proc/sys/net/core/optmem_max



Feb 23 12:42:30 rcc2 kernel: Warning: kfree_skb passed an skb still on a list (from c01f58dc).

Looking up the "from c01f58dc" in the ksyms shows that
	ip_rcv
is the caller.


c01f3d38 ip_route_input_Rsmp_0a99f032
c01f44f8 ip_route_output_key_Rsmp_4ce6fe49
c01f5170 inet_add_protocol_Rsmp_a27098bd
c01f51f0 inet_del_protocol_Rsmp_0c8ae503
c01f5538 ip_rcv_Rsmp_587335e5
c01f58dc ERROR LOCATION (kfree_skb passed an skb still on a list (from c01f58dc))
c01f61dc ip_defrag_Rsmp_5532f3a2
c01f6b34 ip_options_compile_Rsmp_b8621391
c01f70ec ip_options_undo_Rsmp_9721f12f
c01f8650 ip_fragment_Rsmp_41bc67d3
c01f8bb0 ip_send_check_Rsmp_a37b7441
c01f8bf8 ip_finish_output_Rsmp_5b565e28



On a different machine I have seen this.

Feb 23 12:32:20 rcc kernel: KERNEL: assertion (del_timer(&qp->timer) == 0) failed at ip_fragment.c(163):ip_frag_destroy



CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_VGA_CONSOLE=y


------------------------------------------------------------------
Bob Felderman                                 (626) 821-5555
Director of Software Development              (626) 821-5316 fax
Myricom Inc.                                  feldy@myri.com
325 N. Santa Anita Ave.                       http://www.myri.com
Arcadia, CA 91006
------------------------------------------------------------------
