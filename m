Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUH1TLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUH1TLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUH1TLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:11:08 -0400
Received: from gprs214-47.eurotel.cz ([160.218.214.47]:43905 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267561AbUH1TKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:10:54 -0400
Date: Sat, 28 Aug 2004 21:10:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>, JBeulich@novell.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: x86 build issue with software suspend code
Message-ID: <20040828191033.GA14816@elf.ucw.cz>
References: <20040826191217.4b9b31f1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826191217.4b9b31f1.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> A piece of code most like "copy-and-paste"d from x86_64 to i386 caused
> the section named .data.nosave in arch/i386/power/swsusp.S to become
> named .data.nosave.1 in arch/i386/power/built-in.o (due to an attribute
> collision with an identically named section from
> arch/i386/power/cpu.c),

I can't find anything about nosave section in cpu.c... Can you quote it?

> which finally ends up in no-where land (because it doesn't have even the
> alloc bit set, and the linker script doesn't know about such a section
> either), resulting in the two variables being accessed at (absolute)
> addresses 0 and 8 (which shouldn't normally be accessible at all, but
> perhaps are mapped for whatever reason at the point execution gets
> there, since otherwise problems with this code path should have been
> observed much earlier).
> 
> The below (also attached for the inline variant most certainly getting
> incorrectly line wrapped) patch changes the attributes of the section to
> match those of other instances of the section, so the renaming doesn't
> happen anymore. It also adds alignment, decreases the fields from 8 to 4
> bytes and applies these additional changes also to the appearant
> original x86_64 code.

I do not know that much about linker, but patch looks okay.
								Pavel

> diff -Napru linux-2.6.8.1/arch/i386/power/swsusp.S
> 2.6.8.1/arch/i386/power/swsusp.S
> --- linux-2.6.8.1/arch/i386/power/swsusp.S	2004-08-14
> 12:55:19.000000000 +0200
> +++ 2.6.8.1/arch/i386/power/swsusp.S	2004-08-26 15:54:35.420154440
> +0200
> @@ -89,9 +89,10 @@ copy_done:
>  	popl %ebx
>  	ret
>  
> -       .section .data.nosave
> +       .section .data.nosave, "aw"
> +       .align 4
>  loop:
> -       .quad 0
> +       .long 0
>  loop2:
> -       .quad 0
> +       .long 0
>         .previous
> diff -Napru linux-2.6.8.1/arch/x86_64/kernel/suspend_asm.S
> 2.6.8.1/arch/x86_64/kernel/suspend_asm.S
> --- linux-2.6.8.1/arch/x86_64/kernel/suspend_asm.S	2004-08-14
> 12:56:22.000000000 +0200
> +++ 2.6.8.1/arch/x86_64/kernel/suspend_asm.S	2004-08-26
> 15:54:56.446957880 +0200
> @@ -117,7 +117,8 @@ ENTRY(do_magic)
>  	addq	$8, %rsp
>  	jmp	do_magic_resume_2
>  
> -	.section .data.nosave
> +	.section .data.nosave, "aw"
> +	.align 8
>  loop:
>  	.quad 0
>  loop2:	
> 
> 



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
