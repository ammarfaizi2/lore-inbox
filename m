Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030591AbWAGVba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030591AbWAGVba (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbWAGVba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:31:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752587AbWAGVb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:31:29 -0500
Date: Sat, 7 Jan 2006 13:31:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.15-mm2
Message-Id: <20060107133103.530eb889.akpm@osdl.org>
In-Reply-To: <43BFD8C1.9030404@reub.net>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43BFD8C1.9030404@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> ...
> QLogic Fibre Channel HBA Driver
> ahci: probe of 0000:00:1f.2 failed with error -12

It's odd that the ahci driver returned -EBUSY.  Maybe this is due to "we
have legacy mode, but all ports are unavailable" in ata_pci_init_one().

> ata1: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x0 irq 0
> ata2: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x8 irq 0
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   printing eip:
> c0234702
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> last sysfs file:
> Modules linked in:
> CPU:    1
> EIP:    0060:[<c0234702>]    Not tainted VLI
> EFLAGS: 00010206   (2.6.15-mm2)
> EIP is at make_class_name+0x28/0x8d
> eax: 00000000   ebx: ffffffff   ecx: ffffffff   edx: c19d9224
> esi: 00000009   edi: 00000000   ebp: 00000000   esp: c1921d9c
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=c1921000 task=c1920a70)
> Stack: <0>c19d9224 c03a9158 c19d9224 c03a9158 c03a9160 c0234925 c03a90e0 00000000
>         <0>00000246 c19d9224 c19d9000 c19d9030 00000002 c02349db c19d90e4 c0253218
>         <0>c19d92c0 00000000 00000000 c0276693 00000000 c0279391 c035749f c1961640
> Call Trace:
>   [<c0234925>] class_device_del+0x9f/0x14d
>   [<c02349db>] class_device_unregister+0x8/0x10
>   [<c0253218>] scsi_remove_host+0xb8/0xf8
>   [<c0276693>] ata_host_remove+0xe/0x18
>   [<c0279391>] ata_device_add+0x2d3/0xb99
>   [<c02b6fb0>] pci_mmcfg_write+0xd3/0x103
>   [<c01eb713>] pci_bus_write_config_byte+0x4e/0x58
>   [<c02b67d3>] pcibios_set_master+0x74/0x8c
>   [<c027a2e5>] ata_pci_init_one+0x32c/0x38e
>   [<c01eb7ea>] pci_bus_read_config_word+0x62/0x6c
>   [<c01ef8bd>] pci_get_subsys+0x6c/0xe0
>   [<c027e334>] piix_init_one+0x18e/0x33a
>   [<c01ef259>] pci_device_probe+0x40/0x5b
>   [<c0233ed7>] driver_probe_device+0x35/0x98
>   [<c0234038>] __driver_attach+0x8a/0x8c
>   [<c02339a7>] bus_for_each_dev+0x39/0x57
>   [<c0233e4c>] driver_attach+0x16/0x1a
>   [<c0233fae>] __driver_attach+0x0/0x8c
>   [<c023365b>] bus_add_driver+0x6f/0x126
>   [<c01ef3f1>] __pci_register_driver+0x7d/0xac
>   [<c04023e9>] piix_init+0xc/0x1e
>   [<c01003c8>] init+0xff/0x324
>   [<c01002c9>] init+0x0/0x324
>   [<c0100d35>] kernel_thread_helper+0x5/0xb
> Code: 89 c8 c3 55 57 56 53 83 ec 04 89 04 24 89 c2 8b 40 48 8b 38 31 ed bb ff ff 
> ff ff 89 d9 89 e8 f2 ae f7 d1 49 89 ce 8b 7a 08 89 d9 <f2> ae f7 d1 49 89 ca 8d 
> 4e 02 8d 04 0a ba d0 00 00 00 e8 22 cf

ata_device_add() has given up, has called ata_host_remove() and then we
presumably oopsed over incompletely initialised class stuff.  It's likely
that this oops is a second bug - a consequence of the -EBUSY.

> 
> 
> 2. Notice above how the sky2 driver is being bailed out:
> 
> ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 177
> sky2 Cannot find PowerManagement capability, aborting.
> sky2: probe of 0000:04:00.0 failed with error -5
>
> This has happened a number of times in the last few days, and I suspect is 
> unrelated to the oops that followed above.
> 
> This driver worked fine in 2.6.15-rc5-mm3, and seems to work OK when built as a 
> module.  But most of the time (not all the time) it doesn't like being 
> statically built in and fails with the above error.  Changes to this driver have 
> been fairly small lately so I'm not sure if it's the driver or something else 
> like ACPI that is the root cause.

Could be acpi, yes.

Parenthetically, I wouldn't have thought that this error should be fatal
for the driver.

> 3.  The boot up process with -mm2 was pretty lengthy, I had two periods of time 
> when the whole system just came to a crawl, first time was when starting cups, 
> and it came back to life and continued booting about 30s later.  Next when 
> starting hpijs it didn't come to life at all and I had to reboot.  No output to 
> the console for either, unfortunately.

Don't know, sorry.  But this kernel had oopsed, hadn't it?

