Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272584AbRHaB4C>; Thu, 30 Aug 2001 21:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272585AbRHaBzx>; Thu, 30 Aug 2001 21:55:53 -0400
Received: from mout1.freenet.de ([194.97.50.132]:1423 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S272584AbRHaBzj>;
	Thu, 30 Aug 2001 21:55:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Franck <afranck@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Messages "ACPI attempting to access kernel owned memory"?
Date: Fri, 31 Aug 2001 03:56:00 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15cZ5F-0001qR-00@the-village.bc.nu>
In-Reply-To: <E15cZ5F-0001qR-00@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01083103560000.00925@dg1kfa>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan and linux-kernel audience,

> Thanks for the traces.
>
> > 	 BIOS-e820: 00000000040fdc00 - 00000000040ff800 (ACPI data)
> > 	 BIOS-e820: 00000000040ff800 - 00000000040ffc00 (ACPI NVS)
>
> Ok the code I use for debug checks assumes that the memory in question is
> has been marked as reserved. I need to review the code since that seems
> not to have happened in this case.

> I'll investigate - seems the trap is buggy 8)

No, your code is all right, I have found the cause of this behaviour: it's 
because I boot with GRUB and not with LILO. So, you might say "What the hell 
does the bootloader matter", and this is what I also thought in the first 
hours, until I noticed that GRUB was adding a "mem=524288K" entry to my 
kernel commandline, why ever (it's right, I have 512MB of RAM, but the kernel 
could find that by itself, without being told by GRUB...)

The consequences of this mem=... are quite extreme, which is what I have 
found out now (and should be fixed, or at least documented, IMHO!):

>From arch/i386/kernel/setup.c (parse_mem_cmdline):

[...]
        for (;;) {
                /*
                 * "mem=nopentium" disables the 4MB page tables.
                 * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
                 * to <mem>, overriding the bios size.
                 * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
                 * <start> to <start>+<mem>, overriding the bios size.
                 */
                if (c == ' ' && !memcmp(from, "memx=", 4)) {
[...]
                        } else {
                                /* If the user specifies memory size, we
                                 * blow away any automatically generated
                                 * size
                                 */
                                unsigned long long start_at, mem_size;
 
                                if (usermem == 0) {
                                        /* first time in: zap the whitelist
                                         * and reinitialize it with the
                                         * standard low-memory region.
                                         */
                                        e820.nr_map = 0;
			    ^^^^^^^^^^^^^^^^^ <- Here the complete E820 map is 
					cleaned without any further notice!!!
                                        usermem = 1;

[...]

So when specifying a mem=... on the command line, all the information from 
the E820 tables is lost, and the ACPI memory ranges are not allocated as 
iomem resources. With a mem=... option, they do not show up in /proc/iomem, 
without it they do nicely, and your check keeps quiet:

from /proc/iomem (without mem=... on the commandline)
	00000000-0009f7ff : System RAM
	0009f800-0009ffff : reserved
	000a0000-000bffff : Video RAM area
	000c0000-000c7fff : Video ROM
	000f0000-000fffff : System ROM
	00100000-040fdbff : System RAM
	  00100000-0025ea7b : Kernel code
	  0025ea7c-002ecb4b : Kernel data
	040fdc00-040ff7ff : ACPI Tables
	040ff800-040ffbff : ACPI Non-volatile Storage
	040ffc00-1fffffff : System RAM
	f4000000-f48fffff : PCI Bus #01
[...]

from dmesg, without mem=...:
[...]
	allocated 32 pages and 32 bhs reserved for the highmem bounces
	VFS: Diskquotas version dquot_6.5.0 initialized
	devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
	devfs: boot_options: 0x0
	ACPI: Core Subsystem version [20010615]
	ACPI: Subsystem enabled
	ACPI: System firmware supports S0 S1 S5
	Processor[0]: C0 C1 C2
	Power Button: found
	PCI: Found IRQ 10 for device 01:00.0
	matroxfb: Matrox Millennium G400 MAX (AGP) detected
[...]

So the solution was not to use a mem commandline. I have not found a way to 
tell GRUB it should not pass this option, so this should be fixed in GRUB.

Futhermore, one should discuss if the current kernel behaviour is right 
(clearing the E820 table completely when specifying mem=...) -- I think the 
"reserved" and ACPI ranges should be kept and merged into the faked tables, 
so we do not get in risk of overwriting this memory by accident.

Greetings,
Andreas
