Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424510AbWKPUxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424510AbWKPUxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424554AbWKPUxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:53:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1424510AbWKPUxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:53:42 -0500
Date: Thu, 16 Nov 2006 21:53:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       rjw@sisk.pl, ebiederm@xmission.com, hpa@zytor.com,
       magnus.damm@gmail.com, Reloc Kernel List <fastboot@lists.osdl.org>,
       ak@suse.de
Subject: Re: [Fastboot] [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061116205313.GB5596@elf.ucw.cz>
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <20061115212411.GF9039@in.ibm.com> <20061116002836.GG9039@in.ibm.com> <20061116200933.GE13069@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116200933.GE13069@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ok. In the new code NX bit protection feature is not being enabled and that
> > seems to be causing the problem. I checked and enabled the NX bit feature
> > in EFER in wakeup.S and it starts working.
> > 
> > I think my new machine supports NX bit protection feature and if while
> > resuming if I don't enable that feature back probably it must have caused
> > a GPF while loading the page tables which have got NX bit set. (A guess).
> > 
> > I know that previous machine I was testing on does not support NX bit
> > feature and that could be the reason that previous machine did not run into
> > the problems.
> 
> Fixed the resume problem happening on my second box which supported NX
> protection bit. Please find attached the regenerated patch.
> 
> - Killed lots of dead code

Cleanup. (a)

> - Improve the cpu sanity checks to verify long mode
>   is enabled when we wake up.

Change. (b). I'm not sure if we really need this one. I do not think
replacing cpu while suspended is supported operation.

> - Removed the need for modifying any existing kernel page table.

Unrelated change, probably good one. (c).

> - Moved wakeup_level4_pgt into the wakeup routine so we can
>   run the kernel above 4G.

The change you really wanted to do in the first place. (d).

> - Increased the size of the wakeup routine to 8K.

You want bigger stack or what? (e)

> - Renamed the variables to use the 64bit register names.

Cleanup. (a)

> - Lots of misc cleanups to match trampoline.S

More cleanups. (a).

Can we at least get (a) (b) (c) (d) and (e) separated?

Oh and please drop the whitespace changes.

> I don't have a configuration I can test this but it compiles cleanly
> and it should work, the code is very similar to the SMP trampoline,

I assume you have configuration for test now?

> @@ -60,17 +60,6 @@ extern char wakeup_start, wakeup_end;
>  
>  extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));
>  
> -static pgd_t low_ptr;
> -
> -static void init_low_mapping(void)
> -{
> -	pgd_t *slot0 = pgd_offset(current->mm, 0UL);
> -	low_ptr = *slot0;
> -	set_pgd(slot0, *pgd_offset(current->mm, PAGE_OFFSET));
> -	WARN_ON(num_online_cpus() != 1);
> -	local_flush_tlb();
> -}
> -

So you no longer need identity mapping? Is not it specified that when
you transition between modes, you should do that while in identity
mapping?

> @@ -15,7 +16,6 @@
>  # cs = 0x1234, eip = 0x05
>  #
>  
> -
>  ALIGN
>  	.align	16
>  ENTRY(wakeup_start)

Whitespace changes.

> @@ -30,22 +30,25 @@ wakeup_code:
>  	cld
>  	# setup data segment
>  	movw	%cs, %ax
> -	movw	%ax, %ds					# Make ds:0 point to wakeup_start
> +	movw	%ax, %ds			# Make ds:0 point to wakeup_start
>  	movw	%ax, %ss
> -	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
> +						# Private stack is needed for ASUS board
> +	mov	$(wakeup_stack - wakeup_code), %sp
>  
> -	pushl	$0						# Kill any dangerous flags
> +	pushl	$0				# Kill any dangerous flags
>  	popfl

More whitespace changes.


>  	movl	real_magic - wakeup_code, %eax
>  	cmpl	$0x12345678, %eax
>  	jne	bogus_real_magic
>  
> +	call	verify_cpu			# Verify the cpu supports long mode
> +

Check if cpu supports long mode... but we suspended when running long
mode, why checking again?

>  	testl	$1, video_flags - wakeup_code
>  	jz	1f
>  	lcall   $0xc000,$3
>  	movw	%cs, %ax
> -	movw	%ax, %ds					# Bios might have played with that
> +	movw	%ax, %ds			# Bios might have played with that
>  	movw	%ax, %ss
>  1:

More whitespace changes.

> @@ -228,25 +206,10 @@ wakeup_long64:
>  	.align	64	
>  gdta:
>  	.word	0, 0, 0, 0			# dummy
> -
> -	.word	0, 0, 0, 0			# unused
> -
> -	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
> -	.word	0				# base address = 0
> -	.word	0x9B00				# code read/exec. ??? Why I need 0x9B00 (as opposed to 0x9A00 in order for this to work?)
> -	.word	0x00CF				# granularity = 4096, 386
> -						#  (+5th nibble of limit)
> -
> -	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
> -	.word	0				# base address = 0
> -	.word	0x9200				# data read/write
> -	.word	0x00CF				# granularity = 4096, 386
> -						#  (+5th nibble of limit)
> -# this is 64bit descriptor for code
> -	.word	0xFFFF
> -	.word	0
> -	.word	0x9A00				# code read/exec
> -	.word	0x00AF				# as above, but it is long mode and with D=0
> +	/* ??? Why I need the accessed bit set in order for this to work? */
> +	.quad	0x00cf9b000000ffff		# __KERNEL32_CS
> +	.quad	0x00af9b000000ffff		# __KERNEL_CS
> +	.quad	0x00cf93000000ffff		# __KERNEL_DS

Why this change, why did you change the values in here, and why you
did not tell me about it in the changelog?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
