Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbSLXH6c>; Tue, 24 Dec 2002 02:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbSLXH6c>; Tue, 24 Dec 2002 02:58:32 -0500
Received: from users.linvision.com ([62.58.92.114]:7617 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S267052AbSLXH6b>; Tue, 24 Dec 2002 02:58:31 -0500
Date: Tue, 24 Dec 2002 09:05:20 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Petr Vandrovec <vandrove@vc.cvut.cz>, lk@tantalophile.demon.co.uk,
       Ingo Molnar <mingo@elte.hu>, drepper@redhat.com,
       bart@etpmod.phys.tue.nl, davej@codemonkey.org.uk, hpa@transmeta.com,
       terje.eggestad@scali.com, matti.aarnio@zmailer.org, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021224090520.A19829@bitwizard.nl>
References: <20021224112233.00e6295d.sfr@canb.auug.org.au> <Pine.LNX.4.44.0212232005080.2328-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212232005080.2328-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 08:10:14PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 24 Dec 2002, Stephen Rothwell wrote:
> >
> > And if you change the 0x00 use for alighment to 0x90 (nop) you can
> > use gdb to disassemble that array of bytes to check any changes ...
> 
> Yeah, and I really should align the _normal_ return address (and not the
> restart address).
> 
> Something like the appended, perhaps?
> 
> 		Linus
> 
> ===== arch/i386/kernel/entry.S 1.45 vs edited =====
> --- 1.45/arch/i386/kernel/entry.S	Wed Dec 18 14:42:17 2002
> +++ edited/arch/i386/kernel/entry.S	Mon Dec 23 20:02:10 2002
> @@ -233,7 +233,7 @@
>  #endif
> 
>  /* Points to after the "sysenter" instruction in the vsyscall page */
> -#define SYSENTER_RETURN 0xffffe00a
> +#define SYSENTER_RETURN 0xffffe010
> 
>  	# sysenter call handler stub
>  	ALIGN
> ===== arch/i386/kernel/sysenter.c 1.5 vs edited =====
> --- 1.5/arch/i386/kernel/sysenter.c	Sun Dec 22 21:12:23 2002
> +++ edited/arch/i386/kernel/sysenter.c	Mon Dec 23 20:04:33 2002
> @@ -57,12 +57,17 @@
>  		0x51,			/* push %ecx */
>  		0x52,			/* push %edx */
>  		0x55,			/* push %ebp */
> +	/* 3: backjump target */
>  		0x89, 0xe5,		/* movl %esp,%ebp */
>  		0x0f, 0x34,		/* sysenter */
> -		0x00,			/* align return point */
> -	/* System call restart point is here! (SYSENTER_RETURN - 2) */
> -		0xeb, 0xfa,		/* jmp to "movl %esp,%ebp" */
> -	/* System call normal return point is here! (SYSENTER_RETURN in entry.S) */
> +
> +	/* 7: align return point with nop's to make disassembly easier */
> +		0x90, 0x90, 0x90, 0x90,
> +		0x90, 0x90, 0x90,
> +
> +	/* 14: System call restart point is here! (SYSENTER_RETURN - 2) */
> +		0xeb, 0xf3,		/* jmp to "movl %esp,%ebp" */
> +	/* 16: System call normal return point is here! (SYSENTER_RETURN in entry.S) */
>  		0x5d,			/* pop %ebp */
>  		0x5a,			/* pop %edx */
>  		0x59,			/* pop %ecx */

Ehmm, Linus, 

Why do you want to align the return point? Why are jump-targets aligned?
Because they are faster. But why are they faster? Because the
cache-line fill is more efficient: the CPU might execute those 
instructions, while it has a smaller chance of hitting  the instructions
before the target. 

In this case, I'd guess we'd have more benefit from the sysenter return
prefetching the sysenter cache line, than from prefetching the bunch
of noops just behind the return from syscall. 

Now this is very hard to prove using a benchmark: In the benchmark 
you'll quite likely run from a hot cache, and the cache line
effects are the things we would want to measure. 

			Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
