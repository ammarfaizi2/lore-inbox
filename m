Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264598AbTLEXpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTLEXpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:45:21 -0500
Received: from palrel11.hp.com ([156.153.255.246]:15564 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264598AbTLEXpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:45:11 -0500
Date: Fri, 5 Dec 2003 15:45:10 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Thomas Bogendrfer <tsbogend@alpha.franken.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com
Subject: [BUG 2.6.0-test11] pcnet32 oops
Message-ID: <20031205234510.GA2319@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Frank,

	Would you mind having a look at the following bugs and forward
as appropriate ?
	I'm trying to get an AMD Lance going on my box. It mostly
works, but I get oops when I deconfigure the card or remove the
module. A few samples :

	At "ifdown" :
----------------------------------
Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c011ff91>] local_bh_enable+0x35/0x58
 [<c022d19a>] ip_ct_find_proto+0xd2/0xd8
 [<c022d923>] destroy_conntrack+0x13/0x19c
 [<c01e68c8>] __kfree_skb+0xc8/0xfc
 [<d085b160>] pcnet32_purge_tx_ring+0x94/0xc4 [pcnet32]
 [<d085b300>] pcnet32_restart+0x14/0x6c [pcnet32]
 [<d085c089>] pcnet32_set_multicast_list+0x7d/0x90 [pcnet32]
 [<c01ef02e>] __dev_mc_upload+0x1e/0x24
 [<c01ef05a>] dev_mc_upload+0x26/0x38
 [<c01eb585>] dev_change_flags+0x2d/0x104
 [<c0222f53>] devinet_ioctl+0x327/0x64c
 [<c0225457>] inet_ioctl+0xbb/0xf8
 [<c01e3801>] sock_ioctl+0x29d/0x2cc
 [<c015c959>] sys_ioctl+0x21d/0x264
 [<c01097ad>] error_code+0x2d/0x38
 [<c0108d43>] syscall_call+0x7/0xb

-------------------------------------------------


	At "rmmod" :
---------------------------------------------
kernel BUG at include/linux/dcache.h:274!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[sysfs_remove_dir+21/256]    Not tainted
EFLAGS: 00010246
EIP is at sysfs_remove_dir+0x15/0x100
eax: 00000000   ebx: d085e760   ecx: c02ccb2c   edx: ffff0001
esi: c1983220   edi: d085e744   ebp: 00000880   esp: c1a49f04
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 750, threadinfo=c1a48000 task=ca972060)
Stack: d085e760 c02ccb2c d085e744 00000880 c01858c3 d085e760 d085e760 c01858db 
       d085e760 c02ccae0 c01aec48 d085e760 d085e744 00000000 00000000 c01aef5c 
       d085e744 d085e720 00000000 c018b7e6 d085e744 c1875000 d085c88c d085e720 
Call Trace:
 [kobject_del+75/88] kobject_del+0x4b/0x58
 [kobject_unregister+11/24] kobject_unregister+0xb/0x18
 [bus_remove_driver+92/108] bus_remove_driver+0x5c/0x6c
 [driver_unregister+12/50] driver_unregister+0xc/0x32
 [pci_unregister_driver+14/28] pci_unregister_driver+0xe/0x1c
 [_end+273681636/1070212184] pcnet32_cleanup_module+0xac/0xc0 [pcnet32]
 [sys_delete_module+394/432] sys_delete_module+0x18a/0x1b0
 [sys_munmap+69/100] sys_munmap+0x45/0x64
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 0f 0b 12 01 c2 dd 25 c0 f0 ff 06 85 f6 0f 84 d0 00 00 00 8b 
---------------------------------------------

	Info :
	Dual PIII 550 SMP, 2.6.0-test11, many PCI cards, hotplug

02:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 36)
        Subsystem: Hewlett-Packard Company Ethernet with LAN remote power Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 18
        I/O ports at 7ce0 [size=32]
        Memory at fdfff400 (32-bit, non-prefetchable) [size=32]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [40] Power Management version 1

pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
pcnet32: PCnet/FAST+ 79C972 at 0x7ce0, 00 10 83 34 ba e5
    tx_start_pt(0x0c00):~220 bytes, BCR18(9861):BurstWrEn BurstRdEn NoUFlow 
    SRAMSIZE=0x1700, SRAM_BND=0x0800, assigned IRQ 18.
eth0: registered as PCnet/FAST+ 79C972
pcnet32: 1 cards_found.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

	Good luck...

	Jean
