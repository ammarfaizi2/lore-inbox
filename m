Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269142AbUIXUyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269142AbUIXUyz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269139AbUIXUyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:54:55 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:61361 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S269142AbUIXUyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:54:47 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: 2.6.9-rc2-mm2 oops on bootup on Acer Aspire 1501LMi (Athlon64) in 32 bit mode
Date: Fri, 24 Sep 2004 14:54:38 -0600
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040923174134.6a1514ba.akpm@osdl.org>
In-Reply-To: <20040923174134.6a1514ba.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409241454.38448.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> inserting floppy driver for 2.6.9-0.rc2.1ark
> Unable to handle kernel paging request at virtual address e082ed20
> ...
> EIP:    0060:[<c0218c13>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.9-0.rc2.1ark)
> EIP is at acpi_bus_register_driver+0x34/0x54
> eax: ded1b000   ebx: e0d13ba0   ecx: c0334b44   edx: e082ed20
> esi: e0d13e00   edi: ffffffed   ebp: c03361e0   esp: ded1bf5c
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 1183, threadinfo=ded1b000 task=df22e1f0)
> Stack: c03361f8 e0d0d278 e0d13ba0 c03361e0 e0c8f871 0000000a 00000400 e0d0f670
>        ded1bfa0 c03361f8 e0d13e00 ded1b000 c01216d7 c03361f8 e0d13e00 ded1b000
>        c03361e0 c013ad12 c03f7f88 00000001 e0d13e00 b7fec000 0804f8e8 00000001
> Call Trace:
>  [<e0d0d278>] acpi_floppy_init+0x18/0x50 [floppy]
>  [<e0c8f871>] floppy_init+0x11/0x650 [floppy]
>  [<c01216d7>] printk+0x17/0x20
>  [<c013ad12>] sys_init_module+0x172/0x250
>  [<c010624b>] syscall_call+0x7/0xb
> Code: ed ff ff ff 8b 5c 24 08 75 3f 85 db b0 ea 74 39 66 b8 00 f0 21 e0 ff 40 
> 14 8b 15 2c 56 37 c0 c7 03 28 56 37 c0 89 1d 2c 56 37 c0 <89> 1a 89 53 04 ff 
> 48 14 8b 40 08 a8 08 74 05 e8 79 6b 0d 00 89

Disassembling your code, I get this:
 mov    0xc037562c,%edx
 movl   $0xc0375628,(%ebx)
 mov    %ebx,0xc037562c
 mov    %ebx,(%edx)  <== oops occurred here
 mov    %edx,0x4(%ebx)

This is the "list_add_tail(&driver->node, &acpi_bus_drivers);" in
acpi_bus_register_driver().  0xc0375628 should be acpi_bus_drivers,
and 0xe082ed20 looks like &acpi_floppy_driver.node.

Your acpi_floppy_driver address is a long ways from the floppy code
addresses:
 0xe0c8f871 (floppy_init).
 0xe082ed20 (&acpi_floppy_driver)
I.e., they're about 4.5M apart.  I suppose module text and data
sections are allocated separately so maybe this isn't a problem.

FWIW, on my box, /proc/kallsyms says:
 f881c7d0 t floppy_init  [floppy]
 f8819d00 d acpi_floppy_driver   [floppy]
so they're about 10K apart (the whole floppy module is about 75K).

I am curious about why load_module appears in the backtrace:
>  [<e0d06000>] floppy_hardint+0x0/0x130 [floppy]
>  [<c0156e22>] __vunmap+0xc2/0x100
>  [<c0156e87>] vfree+0x27/0x40
>  [<c013aa96>] load_module+0xa46/0xb50
>  [<c0118990>] do_page_fault+0x0/0x5de
>  [<c0106ce5>] error_code+0x2d/0x38
>  [<c0218c13>] acpi_bus_register_driver+0x34/0x54

Is the oops reproducible, or could this be some sort of race in
module loading or something?
