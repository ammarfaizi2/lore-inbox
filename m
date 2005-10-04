Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVJDUFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVJDUFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVJDUFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:05:52 -0400
Received: from spirit.analogic.com ([204.178.40.4]:58375 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964951AbVJDUFv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:05:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <94e67edf0510041223x2dca3215tee29b80c5f9738cf@mail.gmail.com>
References: <94e67edf0510041223x2dca3215tee29b80c5f9738cf@mail.gmail.com>
X-OriginalArrivalTime: 04 Oct 2005 20:05:49.0887 (UTC) FILETIME=[040A24F0:01C5C91F]
Content-class: urn:content-classes:message
Subject: Re: Linker Problem
Date: Tue, 4 Oct 2005 16:05:49 -0400
Message-ID: <Pine.LNX.4.61.0510041538220.30786@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linker Problem
Thread-Index: AcXJHwQRBNCfUzeGTfmmA/rILiZ4UQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Sreeni" <sreeni.pulichi@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Oct 2005, Sreeni wrote:

> Hi,
> I have been strugling with this linker script problem. Any help
> towards this is highly appreciate.
>
> My static kernel module demands the text/data to be placed at an
> absolute address. For this I have tried to modify the kernel  linker
> script (arch/arm/vmlinux.lds).
>
>
>   /**** MY KERNEL MODULE - START ***?
>    . = 0xc024c000; /* c0280000 */
>    .text5 : {
>        sree/sree.o(.text)
>    }
> /**** MY KERNEL MODULE - END ***?
>

It's not a linker-script problem. As previously explained, it's
an attempt by you to do the impossible. When the kernel is loaded
at it's correct one-megabyte address, the page-tables are set
so that there is a fixed offset between the bus address and
the virtual address. You can't just change the load address
without modifying the whole scheme and have the kernel work.
With the ix86 machines, there must be unity-address mapping
existing at any time a transition is made from linear address-
mode to paged mode (or else the CPU will fetch bogus code).
That means that for the first few megabytes, the tables are
set so that a fetch from address 0xnnnnnnnn in linear
address-mode and 0xnnnnnnnn | PAGE_OFFSET in paged mode
will fetch the same instructions.

That fixed offset becomes PAGE_OFFSET (look that up in the
kernel headers). You are attempting to load the kernel right
on top of 0xc0000000, the PAGE_OFFSET. Also, the "spaces"
inside the linked module are filled because it is the final
relocation. That's why the result gets so big. The physical
to virtual mapping will fail because the resulting address
would be 0xc0000000 * 2 = 0x180000000, outside of the 32-bit
address space and wrapped back around to 0x80000000.

As previously explained; "My application demands that I
place the kernel at some fixed address....." Means that
the demand is invalid, bogus, bad, incomprehensible,
wrong, and otherwise defective. Tell your hardware
designers that memory must be addressable and valid
for at least the first 8 megabytes of address-space.

In the unlikely event that you attempt to perform
EIP (execute in place) from some NVRAM in high memory,
that's not how you do it. You make a "boot-loader"
that copies the data from such a place to the
correct 1 megabyte offset and then you jump to the
relocated code. The code has already been linked
(relocated) to run at the correct address, you do
not link it to run at the PROM or NVRAM storage
address.

> The System.map shows that the kernel is occupying the address space
> till c024_bfff. when i add this code to the linker script and force it
> to place the text at c024_c000, the System.map shows that the
> placement is correct. But the kernel image grows from 1.8MB(without my
> module) to 2.6 MB. My kernel module size is just 10 bytes (testing
> purpose). And this newly created kernel doesn't boot up.
>
> I am new to this linker script. Any help is highly appreciated.
> The complete linker script is given below...
>
> Thanks
> Sreeni
>
> ========================================
> / * Based on arch/arm/vmlinux-armv.lds.in
> *
> * taken from the i386 version by Russell King
> * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
> */
> OUTPUT_ARCH(arm)
> ENTRY(stext)
> SECTIONS
> {
>
>   /**** MY KERNEL MODULE - START ***?
>    . = 0xc024c000; /* c0280000 */
>    .text5 : {
>        sree/sree.o(.text)
>    }
> /**** MY KERNEL MODULE - END ***?
>
> /**** KERNEL IMAGE - START ***/
>    . = 0xc0010000;
>    .init : {           /* Init code and data       */
>        _stext = .;
>        __init_begin = .;
>            *(.text.init)
>        __proc_info_begin = .;
>            *(.proc.info)
>        __proc_info_end = .;
>        __arch_info_begin = .;
>            *(.arch.info)
>        __arch_info_end = .;
>        __tagtable_begin = .;
>            *(.taglist)
>        __tagtable_end = .;
>        . = ALIGN(16);
>        __setup_start = .;
>            *(.setup.init)
>        __setup_end = .;
>        __initcall_start = .;
>            *(.initcall.init)
>       __tagtable_begin = .;
>            *(.taglist)
>        __tagtable_end = .;
>        . = ALIGN(16);
>        __setup_start = .;
>            *(.setup.init)
>        __setup_end = .;
>        __initcall_start = .;
>            *(.initcall.init)
>        __initcall_end = .;
>        . = ALIGN(4096);
>        __init_end = .;
>    }
>
>    /DISCARD/ : {           /* Exit code and data       */
>        *(.text.exit)
>        *(.data.exit)
>        *(.exitcall.exit)
>    }
>
>
>    .text : {           /* Real text segment        */
>        _text = .;      /* Text and read-only data  */
>            KEEP (*(EXCLUDE_FILE (*sree.o) .text))
>            *(.text)
>            *(.fixup)
>            *(.gnu.warning)
>            *(.text.lock)   /* out-of-line lock text */
>            *(.rodata)
>            *(.rodata.*)
>            *(.glue_7)
>            *(.glue_7t)
>            *(.kstrtab)
>        *(.got)         /* Global offset table      */
>        *(.got.plt)
>
>        _etext = .;     /* End of text section      */
>    }
>
>    . = ALIGN(16);
>    __ex_table : {          /* Exception table      */
>        __start___ex_table = .;
>            *(__ex_table)
>        __stop___ex_table = .;
>    }
>
>    __ksymtab : {           /* Kernel symbol table      */
>        __start___ksymtab = .;
>            *(__ksymtab)
>        __stop___ksymtab = .;
>    }
>
>  .....
> .....
> .....
> ====================================
> On 9/23/05, Sreeni <sreeni.pulichi@gmail.com> wrote:
>> Hi,
>>
>> I have a kernel module on Montavista Linux (ARM-MontavistaLinux-XIP). My
>> application demands me placing/running this kernel module at a known fixed
>> virtual/physical address. I can make this module a static one.  For this I
>> need the following -
>>
>> ***** Placing text,data, heap, stack at a known fixed address *****
>>
>> May I know the possible ways of achieving this. I have tried playing around
>> arch/arm/vmlinux.lds linker script file. But when i try to force the linker
>> to place my module at a particular address, the System.map shows me the
>> correct address but the kernel image size is getting very large (when add 10
>> words of my module, kernel image size is getting increased by 800KB).
>>
>> Any help in this is highly appreciated.
>>
>> Thanks
>> Sreeni
>>
>
>
> --
> ~Sreeni
>       -iDream
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
