Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTJTSRY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbTJTSRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:17:24 -0400
Received: from [65.172.181.6] ([65.172.181.6]:2542 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262703AbTJTSRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:17:21 -0400
Date: Mon, 20 Oct 2003 11:26:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Strange cleanups in -test8 kernel/acpi/wakeup.S
In-Reply-To: <20031018201214.GA12037@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310201115270.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Some more changes landed in -test8. I have not seen them
> before. Patrick, please, if you change something, can you post patch
> somewhere for review before merging with Linus?

Pavel, I wrote the code in the first place, before you littered your
'debug hacks' throughout it. I have merely been trying to simplify it for 
debugging on other processors that are known not to work. While I 
understand your generic plea for review, I fail to see how it would help 
with this assembly.. 

> bkcvs info is:
> BitKeeper to RCS/CVS export
> ----------------------------
> revision 1.5
> date: 2003/10/08 22:55:45;  author: mochel;  state: Exp;  lines: +37
> -89
> [power] Clean up ACPI STR assembly.

It might help if you read the full changeset comments. 

> diff -Nru a/arch/i386/kernel/acpi/wakeup.S
> b/arch/i386/kernel/acpi/wakeup.S
> --- a/arch/i386/kernel/acpi/wakeup.S    Fri Oct 17 14:43:50 2003
> +++ b/arch/i386/kernel/acpi/wakeup.S    Fri Oct 17 14:43:50 2003
> @@ -172,14 +172,13 @@
>  .org   0x1000
> 
>  wakeup_pmode_return:
> -       movl    $__KERNEL_DS, %eax
> -       movl    %eax, %ds
> -       movw    $0x0e00 + 'u', %ds:(0xb8016)
> -
> -       # restore other segment registers
> -       xorl    %eax, %eax
> +       movw    $__KERNEL_DS, %ax
> +       movw    %ax, %ss
> +       movw    %ax, %ds
> +       movw    %ax, %es
>         movw    %ax, %fs
>         movw    %ax, %gs
> +       movw    $0x0e00 + 'u', 0xb8016
> 
>         # reload the gdt, as we need the full 32 bit address
>         lgdt    saved_gdt
> 	~~~~~~~~~~~~~~~~~
> 
> Notice lgdt here. You have moved setup of segment registers before
> loading gdt. This is actually okay, if you can be sure that all such
> registers are in gdt (and not in ldt, for example).

All segments are in the GDT, as we use the same GDT in real mode as we do 
in protected mode. However, you must reload the GDT in protected mode 
because the GDTR is only 24 bits in real mode, but 32 in protected mode. 

>         # and restore the stack ... but you need gdt for this to work
> -       movl    $__KERNEL_DS, %eax
> -       movw    %ax, %ss
> -       movw    %ax, %ds
> -       movw    %ax, %es
> -       movw    %ax, %fs
> -       movw    %ax, %gs
> -       movl    saved_esp, %esp
> +       movl    saved_context_esp, %esp
> 
> ...
> 
> -       movw    $0x0e00 + 'W', %ds:(0xb8018)
> -       movl    $(1024*1024*3), %ecx
> -       movl    $0, %esi
> -       rep     lodsb
> -       movw    $0x0e00 + 'O', %ds:(0xb8018)
> +       movw    $0x0e00 + 'W', 0xb8018
> +       outl    %eax, $0x80
> +       outl    %eax, $0x80
> +       movw    $0x0e00 + 'O', 0xb8018
> 
> What are these outl-s? I do not see %ax being initialized... Some kind
> of debugging hack? If you are trying to emulate delays, those are not
> needed, what you killed were debugging hacks.

Debugging hacks that did what? AFAICT, it only implemented a small delay 
by loading %eax with 0 a few million times. 

That's better done by writing to port 0x80. It's a debug port that the
BIOS uses to report progress. It can also be used for delay. There are
systems and PCI cards that have LEDs that report what is written to port
0x80.

> You no longer save %eax, %ecx, %edx, %esp, %ebp, %edi, %esi. This
> means you probably need to add asmlinkage somewhere...

Uh, first read save_registers() near the end of the file. Next, please
understand, as I've told you before, that %eax, %ecx, and %edx are
caller-savable registers. They're not expected to be saved. 


	Pat

