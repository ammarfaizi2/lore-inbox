Return-Path: <linux-kernel-owner+willy=40w.ods.org-S278548AbUKBBZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S278548AbUKBBZB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S390395AbUKBBZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 20:25:01 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:4992 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S278548AbUKBBXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 20:23:45 -0500
Date: Tue, 2 Nov 2004 02:23:44 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: x86-64 numa: accessing memnodemap[] beyond its end
Message-ID: <20041102012344.GA18027@vana.vc.cvut.cz>
References: <20041101183631.GA24023@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101183631.GA24023@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 07:36:31PM +0100, Petr Vandrovec wrote:
> Hello,
>    what prevents function below (arch/x86_64/mm/numa.c) from accessing
> memnodemap[] beyond its end?  NODEMAPSIZE is 0xFF, so for first attempted
> bit shift 24 it attempts to access field 0x100000000 >> 24 = 0x100.
> Fortunately it survives as memnodemap[256] fortunately contains zero and
> not 0xFF or 0x01, but still it seems to me that some test for index
> overflow is missing here. 

And one more, slightly related... ioremap_nocache() does:

if (phys_addr + size < virt_to_phys(high_memory)) {
   struct *ppage = virt_to_page(__va(phys_addr));
   ...
}

But high_memory covers ALL memory in the box, including one after 
hole left for PCI I/O, and as this memory does not belong to any 
node, bad things happen when virt_to_page -> pfn_to_page calls
phys_to_nid.  phys_to_nid returns 0xFF (VIRTUAL_BUG_ON is disabled
and 0xFF is filler for memnodemap), and when later node_mem_map(nid) 
and node_start_pfn(nid) occur, they find that NODE_DATA(0xFF) 
returned NULL, and oopses are here when it is dereferenced :-(

Falls this into "you broke it by your strange discontigmem machine,
you should fix it" category, or may I hope for help from someone?
Andi's comment above pfn_to_page is quite clear :-( 
					Thanks,
						Petr Vandrovec


Nov  2 01:15:17 vana kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Nov  2 01:15:17 vana kernel: Unable to handle kernel paging request at 00000000000015f0 RIP: 
Nov  2 01:15:17 vana kernel: <ffffffff80120ae5>{ioremap_nocache+197}
Nov  2 01:15:17 vana kernel: PML4 13e45f067 PGD 13f780067 PMD 0 
Nov  2 01:15:17 vana kernel: Oops: 0000 [1] SMP 
Nov  2 01:15:17 vana kernel: CPU 1 
Nov  2 01:15:17 vana kernel: Modules linked in: ohci_hcd usbcore tg3 tda1004x firmware_class budget_ci budget_core dvb_core crc32 saa7146 ttpci_eeprom hw_random i2c_amd8111 amd74xx ide_core
Nov  2 01:15:17 vana kernel: Pid: 2785, comm: modprobe Not tainted 2.6.10-rc1-c2424
Nov  2 01:15:17 vana kernel: RIP: 0010:[<ffffffff80120ae5>] <ffffffff80120ae5>{ioremap_nocache+197}
Nov  2 01:15:17 vana kernel: RSP: 0000:000001003f0fbdf8  EFLAGS: 00010213
Nov  2 01:15:17 vana kernel: RAX: 00000100ff3fd000 RBX: 00000000ff3fd000 RCX: 0000000000000019
Nov  2 01:15:17 vana kernel: RDX: ffffffff7fffffff RSI: 0000010140000000 RDI: 0000000000000000
Nov  2 01:15:17 vana kernel: RBP: 0000000000001000 R08: 00000000ff3fe000 R09: 0000000000000000
Nov  2 01:15:17 vana kernel: R10: 0000000000000000 R11: 000000000000007d R12: ffffff00003c6000
Nov  2 01:15:17 vana kernel: R13: 00000000ff3fd000 R14: 0000000000000000 R15: 0000000000000000
Nov  2 01:15:17 vana kernel: FS:  0000000000000000(0000) GS:ffffffff80567c00(005b) knlGS:00000000556c72a0
Nov  2 01:15:17 vana kernel: CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
Nov  2 01:15:17 vana kernel: CR2: 00000000000015f0 CR3: 000000003ff94000 CR4: 00000000000006e0
Nov  2 01:15:17 vana kernel: Process modprobe (pid: 2785, threadinfo 000001003f0fa000, task 00000101016e4130)
Nov  2 01:15:17 vana kernel: Stack: ffffffffa00af3c0 000001003fe20638 ffffffffa00af320 ffffffffa009026c 
Nov  2 01:15:17 vana kernel:        0000010100000000 0000000000001000 0000000000000356 ffffffffa00b2180 
Nov  2 01:15:17 vana kernel:        000001003fe20638 00000000ffffffed 
Nov  2 01:15:17 vana kernel: Call Trace:<ffffffffa009026c>{:usbcore:usb_hcd_pci_probe+268} 
Nov  2 01:15:17 vana kernel:        <ffffffff80207d9d>{pci_device_probe_static+61} <ffffffff80207df9>{__pci_device_probe+41} 
Nov  2 01:15:17 vana kernel:        <ffffffff80207e50>{pci_device_probe+48} <ffffffff80281fb7>{bus_match+71} 
Nov  2 01:15:17 vana kernel:        <ffffffff802820d6>{driver_attach+70} <ffffffff80282621>{bus_add_driver+161} 
Nov  2 01:15:17 vana kernel:        <ffffffff8020816b>{pci_register_driver+139} <ffffffff80151e4f>{sys_init_module+319} 
Nov  2 01:15:17 vana kernel:        <ffffffff80121fc1>{ia32_sysret+0} 
Nov  2 01:15:17 vana kernel: 
Nov  2 01:15:17 vana kernel: Code: 48 8b 8f f0 15 00 00 76 2a 48 b8 00 00 00 80 00 01 00 00 48 
Nov  2 01:15:17 vana kernel: RIP <ffffffff80120ae5>{ioremap_nocache+197} RSP <000001003f0fbdf8>
Nov  2 01:15:17 vana kernel: CR2: 00000000000015f0

> Bootdata ok (command line is BOOT_IMAGE=2.6.10-1-424-64 ro root=801 ramdisk=0 video=matroxfb:vesa:0x11E,left:16,right:8,hslen:48,xres:1920,upper:2,vslen:4,lowe)
> Linux version 2.6.10-rc1-c2424 (root@vana) (gcc version 3.3.3 (Debian 20040401)) #2 SMP Mon Nov 1 15:43:42 CET 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
>  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
> Scanning NUMA topology in Northbridge 24
> Number of nodes 2 (10010)
> Node 0 MemBase 0000000000000000 Limit 000000003fffffff
> Node 1 MemBase 0000000100000000 Limit 000000013fffffff
> node 1 shift 24 addr 100000000 conflict 0
> Using node hash shift of 25
> Bootmem setup node 0 0000000000000000-000000003fffffff
> Bootmem setup node 1 0000000100000000-000000013fffffff
