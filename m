Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269516AbUI3VXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269516AbUI3VXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269530AbUI3VXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:23:06 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:7364 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S269516AbUI3VWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:22:41 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.9rc2-mm4 oops
Date: Thu, 30 Sep 2004 15:22:29 -0600
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net,
       Bernhard Rosenkraenzer <bero@arklinux.org>
References: <1096571653.11298.163.camel@cmn37.stanford.edu> <20040930124937.5942fd64.akpm@osdl.org>
In-Reply-To: <20040930124937.5942fd64.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409301522.29198.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> inserting floppy driver for 2.6.8.1-1.520.1nov.rhfc2.ccrma
> Unable to handle kernel paging request at virtual address f8881920
>  printing eip:
> c0251d3d
> *pde = 37f5f067
> Oops: 0002 [#1]
> PREEMPT 
> Modules linked in: floppy(U) sg(U) dm_mod(U) uhci_hcd(U) ehci_hcd(U)
> button(U) battery(U) asus_acpi(U) ac(U) ext3(U) jbd(U) raid5(U) xor(U)
> sata_via(U) sata_promise(U) libata(U) sd_mod(U) scsi_mod(U)
> CPU:    0
> EIP:    0060:[<c0251d3d>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.8.1-1.520.1nov.rhfc2.ccrma) 
> EIP is at acpi_bus_register_driver+0xd2/0x165

Can you reproduce this oops with CONFIG_PREEMPT turned off?  I found
a few reports of similar problems, and they all seem to have PREEMPT
turned on:

 http://sourceforge.net/mailarchive/message.php?msg_id=9308735
 http://lkml.org/lkml/2004/6/5/92
 http://lkml.org/lkml/2004/9/23/71
 http://lkml.org/lkml/2004/9/30/175 (yours)

Pierre reported that the oops seemed to be related to DEBUG_PAGEALLOC,
not PREEMPT.  But you don't seem to have DEBUG_PAGEALLOC turned on,
so I still wonder if there's some connection with PREEMPT.

> eax: f8881920   ebx: f88eefe0   ecx: c03d6b40   edx: f88ebd30
> esi: ffffffed   edi: f6ed4000   ebp: c03d9460   esp: f6ed4f5c
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 2119, threadinfo=f6ed4000 task=f6e71870)
> Stack: c03d94a0 f88e9126 00000015 00000014 f8870bc1 c03d94a0 f88ef280
> f6ed4000 
>        c0129ef7 c03d94a0 f88ef280 f6ed4000 c03d9460 c014dd52 00000246
> f62f29ac 
>        f6e1fc40 f6d8b8ac f6de4380 f6de43ac 00000000 b7fde008 0807a1a0
> 006a809d 
> Call Trace:
>  [<f88e9126>] acpi_floppy_init+0x16/0x50 [floppy]
>  [<f8870bc1>] floppy_init+0x11/0x600 [floppy]
>  [<c0129ef7>] printk+0x17/0x20
>  [<c014dd52>] sys_init_module+0x252/0x3b0
>  [<c0106afd>] sysenter_past_esp+0x52/0x71
> Code: 00 00 00 a1 ec 67 3e c0 c7 05 78 67 3e c0 a0 7b 3a c0 c7 05 7c 67
> 3e c0 bd 01 00 00 89 1d ec 67 3e c0 c7 03 e8 67 3e c0 89 43 04 <89> 18
> 81 3d 68 67 3e c0 3c 4b 24 1d 74 1c 68 68 67 3e c0 68 bf 
>  <6>note: modprobe[2119] exited with preempt_count 1
> Debug: sleeping function called from invalid context at
> include/linux/rwsem.h:43
> in_atomic():1, irqs_disabled():0
>  [<c0125652>] __might_sleep+0xa2/0xb0
>  [<c012d222>] do_exit+0xa2/0x980
>  [<c010775f>] die+0x2bf/0x2c0
>  [<c012a0b6>] vprintk+0x1b6/0x340
>  [<c011e1e4>] do_page_fault+0x314/0x56c
>  [<c01d8155>] sysfs_new_dirent+0x25/0x80
>  [<c01d81cd>] sysfs_make_dirent+0x1d/0x90
>  [<c0172a29>] unmap_area_pmd+0x49/0x60
>  [<c01d7d84>] sysfs_add_file+0x74/0xa0
>  [<c0172bb0>] unmap_vm_area+0x30/0x80
>  [<c0173136>] __vunmap+0xb6/0xf0
>  [<c0129cf0>] call_console_drivers+0x80/0x110
>  [<c011ded0>] do_page_fault+0x0/0x56c
>  [<c0106cf9>] error_code+0x2d/0x38
>  [<c0251d3d>] acpi_bus_register_driver+0xd2/0x165
>  [<f88e9126>] acpi_floppy_init+0x16/0x50 [floppy]
>  [<f8870bc1>] floppy_init+0x11/0x600 [floppy]
>  [<c0129ef7>] printk+0x17/0x20
>  [<c014dd52>] sys_init_module+0x252/0x3b0
>  [<c0106afd>] sysenter_past_esp+0x52/0x71
> ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>

