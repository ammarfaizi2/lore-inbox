Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUFYMiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUFYMiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265813AbUFYMiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:38:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:21384 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265792AbUFYMiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:38:04 -0400
Date: Fri, 25 Jun 2004 08:37:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: swsusp.S: meaningfull assembly labels
In-Reply-To: <20040625115936.GA2849@elf.ucw.cz>
Message-ID: <Pine.LNX.4.53.0406250827250.28070@chaos>
References: <20040625115936.GA2849@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, Pavel Machek wrote:

> Hi!
>
> This introduces meaningfull labels instead of .L1234, meaning code is
> readable, kills alignment where unneccessary, and kills TLB flush that
> was only pure paranoia (and slows it down a lot on emulated
> systems). Please apply,
>
> 								Pavel
>
> --- linux-cvs//arch/i386/power/swsusp.S	2004-05-25 17:41:18.000000000 +0200
> +++ linux/arch/i386/power/swsusp.S	2004-06-24 14:39:01.000000000 +0200
> @@ -18,7 +18,7 @@
>  ENTRY(do_magic)
>  	pushl %ebx
>  	cmpl $0,8(%esp)
> -	jne .L1450
> +	jne resume
>  	call do_magic_suspend_1
>  	call save_processor_state
>
> @@ -33,21 +33,21 @@
>  	pushfl ; popl saved_context_eflags
>
>  	call do_magic_suspend_2
> -	jmp .L1449
> -	.p2align 4,,7
> -.L1450:
> +	popl %ebx
> +	ret
> +
> +resume:
>  	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
>  	movl %ecx,%cr3
>
>  	call do_magic_resume_1
>  	movl $0,loop
>  	cmpl $0,nr_copy_pages
> -	je .L1453
> -	.p2align 4,,7
> -.L1455:
> +	je copy_done
> +copy_loop:
>  	movl $0,loop2
>  	.p2align 4,,7
> -.L1459:
> +copy_one_page:
>  	movl pagedir_nosave,%ecx
>  	movl loop,%eax
>  	movl loop2,%edx
> @@ -56,23 +56,21 @@
>  	movl (%ecx,%eax),%eax
>  	movb (%edx,%eax),%al
>  	movb %al,(%edx,%ebx)
> -	movl %cr3, %eax;
> -	movl %eax, %cr3;  # flush TLB
>
>  	movl loop2,%eax
>  	leal 1(%eax),%edx
>  	movl %edx,loop2
>  	movl %edx,%eax
>  	cmpl $4095,%eax
> -	jbe .L1459
> +	jbe copy_one_page
>  	movl loop,%eax
>  	leal 1(%eax),%edx
>  	movl %edx,loop
>  	movl %edx,%eax
>  	cmpl nr_copy_pages,%eax
> -	jb .L1455
> -	.p2align 4,,7
> -.L1453:
> +	jb copy_loop
> +
> +copy_done:
>  	movl $__USER_DS,%eax
>
>  	movw %ax, %ds
> @@ -88,7 +86,6 @@
>  	call restore_processor_state
>  	pushl saved_context_eflags ; popfl
>  	call do_magic_resume_2
> -.L1449:
>  	popl %ebx
>  	ret
>
>
> --

NO! You just made those labels public! The LOCAL symbols need to
begin with ".L".  Now, if you have a 'copy_loop' in another module,
linked with this, anywhere in the kernel, they will share the
same address -- not what you expected, I'm sure! The assembler
has some strange rules you need to understand. Use `nm` and you
will find that your new labels are in the object file!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


