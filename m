Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbUJZS2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbUJZS2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbUJZS2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:28:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:26848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261342AbUJZS2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:28:32 -0400
Date: Tue, 26 Oct 2004 11:28:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Lincoln D. Durey" <durey@EmperorLinux.com>
cc: LKML <linux-kernel@vger.kernel.org>, David Hinds <dhinds@sonic.net>,
       Emperor Research <research@EmperorLinux.com>
Subject: Re: Sony S170 + 1GB ram => Yenta: ISA IRQ mask 0x0000
In-Reply-To: <200410261342.33924.durey@EmperorLinux.com>
Message-ID: <Pine.LNX.4.58.0410261117530.28839@ppc970.osdl.org>
References: <200410261342.33924.durey@EmperorLinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Oct 2004, Lincoln D. Durey wrote:
> 
> So, now we have a new Sony S170 (spiffy ultra-portable laptop) with a 
> failure to recognize cards when it has 1GB ram installed.  And I'm 
> wondering if anyone wants to tackle having the kernel PCI system remap this 
> pcmcia socket's memory so it can see cards ?
> 
>         booting with 1GB ram:
> 
> kernel: Linux Kernel Card Services 3.1.22
> kernel:   options:  [pci] [cardbus] [pm]
> kernel: Yenta IRQ list 0000, PCI irq9
> kernel: Socket status: 00000000
> 
>         revert to 512MB or 768MB ram, and you get a happy PCMCIA slot:

Judging by your /proc/iomem, which looks like this:

	00100000-3ff6ffff : System RAM
	  00100000-002ac223 : Kernel code
	  002ac224-003ab5ff : Kernel data
	3ff70000-3ff703ff : 0000:00:1f.1		[ ed: IDE controller ]
	3ff71000-3ff71fff : 0000:02:04.0		[ ed: cardbus ]
	  3ff71000-3ff71fff : yenta_socket

the 1GB case should have problem with the IDE controller too, if it has 
problems with yenta-socket.

But maybe you only use PIO mode, in which case I guess it doesn't matter 
if the MMIO regions are scrogged.

Anyway, the problem seems to be that you are doing something bad with the 
user-defined RAM map, for some reason that is not obvious at all. Your 
bootup clearly shows:

	 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
	 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
	 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
	 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
	 BIOS-e820: 0000000000100000 - 000000003ff70000 (usable)
	 BIOS-e820: 000000003ff70000 - 000000003ff7c000 (ACPI data)
	 BIOS-e820: 000000003ff7c000 - 000000003ff80000 (ACPI NVS)
	 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
	 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
	 BIOS-e820: 00000000fffff000 - 0000000100000000 (reserved)

which means that the BIOS marks the 0x000000003ff70000 - 0000000040000000 
region properly reserved, but you bave overridden this (incorrectly) with:

	user-defined physical RAM map:
	 user: 0000000000000000 - 000000000009f800 (usable)
	 user: 000000000009f800 - 00000000000a0000 (reserved)
	 user: 00000000000d8000 - 00000000000e0000 (reserved)
	 user: 00000000000e4000 - 0000000000100000 (reserved)
	 user: 0000000000100000 - 000000003ff70000 (usable)

where your manual user-defined RAM map is crap, because it doesn't mark 
the ACPI region as being reserved.

As a result, the kernel doesn't know that there is something there, and 
will allocate the Cardbus controller (and IDE MMIO) range in that unusable 
range.

So the question is: 
 - why have you done any user override at all
 - and having done so, why aren't the ACPI regions there, marked reserved?

It looks like the BIOS is doing everything right, and the problem is 
entirely with the user-defined values..

		Linus
