Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbTBOMF3>; Sat, 15 Feb 2003 07:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTBOMF3>; Sat, 15 Feb 2003 07:05:29 -0500
Received: from h001.c000.snv.cp.net ([209.228.32.65]:412 "HELO c000.snv.cp.net")
	by vger.kernel.org with SMTP id <S261733AbTBOMF1>;
	Sat, 15 Feb 2003 07:05:27 -0500
X-Sent: 15 Feb 2003 12:15:21 GMT
Subject: Re: Fix stack handling in acpi_wakeup.S
From: "Alfred E. Heggestad" <linuxedmund@home.no>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030211184452.GA24966@elf.ucw.cz>
References: <20030211184452.GA24966@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1045311319.14740.25.camel@tellus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Feb 2003 13:15:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel

I applied this patch to 2.5.60 and when doing the
software suspend it did manage to start the freezing
process (process X into refrigerator etc...) but crashed
once in ide.c - apologies I do not have any more details
and I cannot reproduce that one.

Doing software suspend now will freeze all procs and
hang on the last one:

# echo 4 > /proc/acpi/sleep

...
=<proc> entered refrigerator
=| entered refrigerator

-> hang

This happens both with 2.5.60 plus Pavel acpi_wakeup.S patch
and vanilla 2.5.61, also with or withour X running.

My machine is a Sony Vaio VX71P, details can be found here:

http://lamis.wyrdweb.com/~alfredh/vaio_vx71p/

/alfred

On Tue, 2003-02-11 at 19:44, Pavel Machek wrote:
> Hi!
> 
> This fixes stack handling in acpi_wakeup.S, and makes stack smaller so
> that wakeup code actually fits inside memory allocated for it. Plus
> someone renamed .L1432 to something meaningfull. Please apply,
> 								Pavel
> 
> --- clean/arch/i386/kernel/acpi_wakeup.S	2003-02-11 17:40:33.000000000 +0100
> +++ linux/arch/i386/kernel/acpi_wakeup.S	2003-02-11 12:51:03.000000000 +0100
> @@ -31,7 +31,7 @@
>  	movw	%cs, %ax
>  	movw	%ax, %ds					# Make ds:0 point to wakeup_start
>  	movw	%ax, %ss
> -	mov	wakeup_stack - wakeup_code, %sp			# Private stack is needed for ASUS board
> +	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
>  	movw	$0x0e00 + 'S', %fs:(0x12)
>  
>  	pushl	$0						# Kill any dangerous flags
> @@ -159,12 +159,14 @@
>  	.code32
>  	ALIGN
>  
> +.org	0x800
> +wakeup_stack_begin:	# Stack grows down
>  
> -.org	0x2000
> +.org	0xff0		# Just below end of page
>  wakeup_stack:
> -.org	0x3000
>  ENTRY(wakeup_end)
> -.org	0x4000
> +	
> +.org	0x1000
>  
>  wakeup_pmode_return:
>  	movl	$__KERNEL_DS, %eax
> @@ -274,7 +276,7 @@
>  
>  ENTRY(do_suspend_lowlevel)
>  	cmpl $0,4(%esp)
> -	jne .L1432
> +	jne ret_point
>  	call save_processor_state
>  
>  	movl %esp, saved_context_esp
> @@ -287,7 +289,7 @@
>  	movl %edi, saved_context_edi
>  	pushfl ; popl saved_context_eflags
>  
> -	movl $.L1432,saved_eip
> +	movl $ret_point,saved_eip
>  	movl %esp,saved_esp
>  	movl %ebp,saved_ebp
>  	movl %ebx,saved_ebx
> @@ -299,7 +301,7 @@
>  	addl $4,%esp
>  	ret
>  	.p2align 4,,7
> -.L1432:
> +ret_point:
>  	movl $__KERNEL_DS,%eax
>  	movw %ax, %ds
>  	movl saved_context_esp, %esp
-- 
Alfred E. Heggestad <linuxedmund@home.no>

