Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUFWBKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUFWBKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 21:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265750AbUFWBKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 21:10:04 -0400
Received: from mail.icsmail.net ([69.5.139.6]:40589 "EHLO mail.icsmail.net")
	by vger.kernel.org with ESMTP id S264897AbUFWBJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 21:09:44 -0400
Subject: x86-64 general protection fault in ioremap_nocache() possibly
	related to memory beyond 4GB
From: Steve Holland <sdh4_no_spammers_throwaway_acct@cornell.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087952903.4010.132.camel@gavroche>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 22 Jun 2004 20:08:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a memory/io mapping related problem with the 2.6 kernel
(as shipped with Fedora Core 2, tested with kernel-2.6.5-1.358
and kernel-2.6.6-1.435).

My system has a dual Opteron Tyan K8W with 4 GB of ram. Half of that
memory is mapped by the BIOS beyond 4GB, leaving plenty of address space
between 2GB and 4GB for pci devices. 

If I tell the kernel (via mem=0x80000000) to only use the first 2GB, all
of these problems go away. There were also no problems doing any of
these things under a previous installation 2.4 x86-64 kernel. 

Hence the problem seems to be related to the presence of memory beyond
the 4GB boundary. 

I have seen three different symptoms of this one problem. These all
appear independent of each other:
   1. Oops in ioremap_nocache() during modprobe of ohci-hcd.ko during
rc.sysinit.
   2. X locks up on startup (Radeon driver) with general protection
fault (even with dri, etc. disabled):

Jun 22 17:28:41 eponine kernel: general protection fault: 0000 [1] SMP 
Jun 22 17:28:41 eponine kernel: CPU 0 
Jun 22 17:28:41 eponine kernel: Modules linked in: ipv6 parport_pc lp parport autofs4 tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod ext3 jbd sata_sil libata sd_mod scsi_mod
Jun 22 17:28:41 eponine kernel: Pid: 2658, comm: X Not tainted 2.6.6-1.435smp
Jun 22 17:28:41 eponine kernel: RIP: 0010:[<ffffffff8015f3c8>] <ffffffff8015f3c8>{remap_page_range+407}
Jun 22 17:28:41 eponine kernel: Call Trace:<ffffffff801f85bc>{mmap_mem+224} <ffffffff80161f3f>{do_mmap_pgoff+1186} 
Jun 22 17:28:41 eponine kernel:        <ffffffff80117849>{sys_mmap+135} <ffffffff801112c6>{system_call+126} 
Jun 22 17:28:41 eponine kernel: Code: 48 2b 82 f0 18 00 00 48 6b c0 38 48 03 82 e0 18 00 00 8b 00 

   3. A driver (with which I am very familiar with the internals) gets a general protection fault
during insmod. This driver starts by calling  pci_set_dma_mask(), then calls request_mem_region() for several smallish
(a few kb or less) chunks found with pci_resource_start() and pci_resource_len().  It then calls 
ioremap_nocache() on  one of these chunks, but ioremap_nocache() fails with a general protection fault:

Jun 22 17:37:04 eponine kernel: general protection fault: 0000 [1] SMP 
Jun 22 17:37:04 eponine kernel: CPU 0 
Jun 22 17:37:04 eponine kernel: Modules linked in: pci_das4020_12 ipv6 parport_pc lp parport autofs4 tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod ext3 jbd sata_sil libata sd_mod scsi_mod
Jun 22 17:37:04 eponine kernel: Pid: 2655, comm: insmod Not tainted 2.6.6-1.435smp
Jun 22 17:37:04 eponine kernel: RIP: 0010:[<ffffffff80122e38>] <ffffffff80122e38>{ioremap_nocache+197}
Jun 22 17:37:04 eponine kernel: Call Trace:<ffffffffa01081c5>{:pci_das4020_12:das4020_init_one+453} 
Jun 22 17:37:04 eponine kernel:        <ffffffff801d5a73>{pci_device_probe_static+47} <ffffffff801d5aa7>{__pci_device_probe+30} 
Jun 22 17:37:04 eponine kernel:        <ffffffff801d5ae1>{pci_device_probe+37} <ffffffff801d5abc>{pci_device_probe+0} 
Jun 22 17:37:04 eponine kernel:        <ffffffff80218831>{bus_match+57} <ffffffff80218938>{driver_attach+68} 
Jun 22 17:37:04 eponine kernel:        <ffffffff80218b7d>{bus_add_driver+112} <ffffffff80176590>{exact_match+0} 
Jun 22 17:37:04 eponine kernel:        <ffffffff801d5cd2>{pci_register_driver+111} <ffffffffa011004f>{:pci_das4020_12:das4020_init+79} 
Jun 22 17:37:04 eponine kernel:        <ffffffff8014ad48>{sys_init_module+264} <ffffffff801112c6>{system_call+126} 
Jun 22 17:37:04 eponine kernel: Code: 48 8b 8f f0 18 00 00 76 10 48 b8 00 00 00 80 00 01 00 00 48 

As I mentioned above, the problems only occur when using the 2GB of memory above 4GB. 
Jun 22 20:05:40 eponine kernel: BIOS-provided physical RAM map:
Jun 22 20:05:40 eponine kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jun 22 20:05:40 eponine kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jun 22 20:05:40 eponine kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Jun 22 20:05:40 eponine kernel:  BIOS-e820: 0000000000100000 - 0000000080000000 (usable)
Jun 22 20:05:40 eponine kernel:  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Jun 22 20:05:40 eponine kernel:  BIOS-e820: 0000000100000000 - 0000000180000000 (usable)

All these things worked normally under the 2.4 kernel of Fedora Core 1

	Thanks,
	Steve

ess dee h 4 at cornell dot edu





