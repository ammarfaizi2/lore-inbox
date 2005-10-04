Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVJDTY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVJDTY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVJDTY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:24:26 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:64535 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964928AbVJDTY0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:24:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n/V3bmxg0fqbwwBhDodqULSGTP9uNhzskCwJjvgiDgfgb3pe00QytbSjbQBWE3K3ZI1RRFsptlrOHY6IwGXvyKEl05IIKpsVRnxXSZH8bUHsruKWQwlYV9ukTlR4Z7aSD4ncsvUim8BsTRKeKtuxCAz6kES7gzREIMWQX9fZERw=
Message-ID: <94e67edf0510041224m6017ce8o19d993f7baf80ab8@mail.gmail.com>
Date: Tue, 4 Oct 2005 15:24:24 -0400
From: Sreeni <sreeni.pulichi@gmail.com>
Reply-To: Sreeni <sreeni.pulichi@gmail.com>
To: linux-os@analogic.com, linux-kernel@vger.kernel.org
Subject: Linker Problem
In-Reply-To: <94e67edf0510041223x2dca3215tee29b80c5f9738cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <94e67edf0510041223x2dca3215tee29b80c5f9738cf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have been strugling with this linker script problem. Any help
towards this is highly appreciate.

My static kernel module demands the text/data to be placed at an
absolute address. For this I have tried to modify the kernel  linker
script (arch/arm/vmlinux.lds).


  /**** MY KERNEL MODULE - START ***?
   . = 0xc024c000; /* c0280000 */
   .text5 : {
       sree/sree.o(.text)
   }
/**** MY KERNEL MODULE - END ***?

The System.map shows that the kernel is occupying the address space
till c024_bfff. when i add this code to the linker script and force it
to place the text at c024_c000, the System.map shows that the
placement is correct. But the kernel image grows from 1.8MB(without my
module) to 2.6 MB. My kernel module size is just 10 bytes (testing
purpose). And this newly created kernel doesn't boot up.

I am new to this linker script. Any help is highly appreciated.
The complete linker script is given below...

Thanks
Sreeni

========================================
/ * Based on arch/arm/vmlinux-armv.lds.in
 *
 * taken from the i386 version by Russell King
 * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
 */
OUTPUT_ARCH(arm)
ENTRY(stext)
SECTIONS
{

  /**** MY KERNEL MODULE - START ***?
   . = 0xc024c000; /* c0280000 */
   .text5 : {
       sree/sree.o(.text)
   }
/**** MY KERNEL MODULE - END ***?

/**** KERNEL IMAGE - START ***/
   . = 0xc0010000;
   .init : {           /* Init code and data       */
       _stext = .;
       __init_begin = .;
           *(.text.init)
       __proc_info_begin = .;
           *(.proc.info)
       __proc_info_end = .;
       __arch_info_begin = .;
           *(.arch.info)
       __arch_info_end = .;
       __tagtable_begin = .;
           *(.taglist)
       __tagtable_end = .;
       . = ALIGN(16);
       __setup_start = .;
           *(.setup.init)
       __setup_end = .;
       __initcall_start = .;
           *(.initcall.init)
      __tagtable_begin = .;
           *(.taglist)
       __tagtable_end = .;
       . = ALIGN(16);
       __setup_start = .;
           *(.setup.init)
       __setup_end = .;
       __initcall_start = .;
           *(.initcall.init)
       __initcall_end = .;
       . = ALIGN(4096);
       __init_end = .;
   }

   /DISCARD/ : {           /* Exit code and data       */
       *(.text.exit)
       *(.data.exit)
       *(.exitcall.exit)
   }


   .text : {           /* Real text segment        */
       _text = .;      /* Text and read-only data  */
           KEEP (*(EXCLUDE_FILE (*sree.o) .text))
           *(.text)
           *(.fixup)
           *(.gnu.warning)
           *(.text.lock)   /* out-of-line lock text */
           *(.rodata)
           *(.rodata.*)
           *(.glue_7)
           *(.glue_7t)
           *(.kstrtab)
       *(.got)         /* Global offset table      */
       *(.got.plt)

       _etext = .;     /* End of text section      */
   }

   . = ALIGN(16);
   __ex_table : {          /* Exception table      */
       __start___ex_table = .;
           *(__ex_table)
       __stop___ex_table = .;
   }

   __ksymtab : {           /* Kernel symbol table      */
       __start___ksymtab = .;
           *(__ksymtab)
       __stop___ksymtab = .;
   }

 .....
.....
.....
====================================
On 9/23/05, Sreeni <sreeni.pulichi@gmail.com> wrote:
> Hi,
>
> I have a kernel module on Montavista Linux (ARM-MontavistaLinux-XIP). My
> application demands me placing/running this kernel module at a known fixed
> virtual/physical address. I can make this module a static one.  For this I
> need the following -
>
> ***** Placing text,data, heap, stack at a known fixed address *****
>
> May I know the possible ways of achieving this. I have tried playing around
> arch/arm/vmlinux.lds linker script file. But when i try to force the linker
> to place my module at a particular address, the System.map shows me the
> correct address but the kernel image size is getting very large (when add 10
> words of my module, kernel image size is getting increased by 800KB).
>
> Any help in this is highly appreciated.
>
> Thanks
> Sreeni
>


--
~Sreeni
      -iDream


--
~Sreeni
       -iDream
