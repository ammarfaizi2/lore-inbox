Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281572AbRKPW2D>; Fri, 16 Nov 2001 17:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281573AbRKPW1o>; Fri, 16 Nov 2001 17:27:44 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:4518 "HELO postfix2-1.free.fr")
	by vger.kernel.org with SMTP id <S281572AbRKPW1j> convert rfc822-to-8bit;
	Fri, 16 Nov 2001 17:27:39 -0500
Date: Fri, 16 Nov 2001 20:42:12 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <Pine.LNX.4.30.0111162219170.22827-100000@Appserv.suse.de>
Message-ID: <20011116202003.Y1909-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Nov 2001, Dave Jones wrote:

> In the wake of the recent fallout of "are Athlon XP's SMP capable or not",
> the following patch adds some sanity checking to the SMP boot up code.
> This code is based upon information from the folks at AMD. There are
> no exceptions to these rules.

Hmmm.... What about odd CPUs replacement?

I have had years ago my Intel Pentium 90 that wasn't suitable:) for FDIV
replaced for free by Intel and they didn't ask me if I needed FDIV to give
suitable results or not.

'Not certified', 'not suitable for', ..., why such precious wording for
just 'bug' or 'erratum' that is the wording used since years for such kind
of misses. If we want to used wording targetted to idiots, we should use
it equally for each parties, in particular not write that CPU A is not
'suitable for something' in some place but write that CPU B is 'bogus
regarding something' in some other place.

Just my 0.02 euros.

Btw, my 2 athlons 1.2GBHz costed me much more, and I will know soon if I
paid that much just for sand. :-)

  Gérard.

> Before sending this to Linus, I want to make sure I didn't do something
> dumb, like misplace a bracket, isolating a valid config.
> It works on systems I've tested it on so far, but obviously there are
> some combinations that are not tested.
>
> Any "But my system is fine in SMP and isn't in the list" whinges won't
> get it added to the list. The list is compiled from AMD approved
> valid systems, added to by any system which reports itself as
> multiprocessor capable in its cpu flags.
>
> Note, this code will not stop you from continuing to use unsupported
> configurations, but will..
> a. Print a boot time warning.
> b. Taint any oopses so that SMP problem oopses can be isolated easily.
>
> I repeat, there is *no* loss of functionality.
>
> Patch against 2.4.15pre5 follows.
>
> regards,
>
> Dave.
>
>
> --
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
>
> diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15-pre5/arch/i386/kernel/setup.c linux-2.4.15-pre5-dj/arch/i386/kernel/setup.c
> --- linux-2.4.15-pre5/arch/i386/kernel/setup.c	Fri Nov 16 18:14:11 2001
> +++ linux-2.4.15-pre5-dj/arch/i386/kernel/setup.c	Fri Nov 16 18:30:29 2001
> @@ -2707,7 +2707,7 @@
>  		/* AMD-defined */
>  		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
>  		NULL, NULL, NULL, "syscall", NULL, NULL, NULL, NULL,
> -		NULL, NULL, NULL, NULL, NULL, NULL, "mmxext", NULL,
> +		NULL, NULL, NULL, "mp", NULL, NULL, "mmxext", NULL,
>  		NULL, NULL, NULL, NULL, NULL, "lm", "3dnowext", "3dnow",
>
>  		/* Transmeta-defined */
> diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15-pre5/arch/i386/kernel/smpboot.c linux-2.4.15-pre5-dj/arch/i386/kernel/smpboot.c
> --- linux-2.4.15-pre5/arch/i386/kernel/smpboot.c	Fri Oct  5 01:42:54 2001
> +++ linux-2.4.15-pre5-dj/arch/i386/kernel/smpboot.c	Fri Nov 16 21:09:33 2001
> @@ -30,10 +30,12 @@
>   *		Tigran Aivazian	:	fixed "0.00 in /proc/uptime on SMP" bug.
>   *	Maciej W. Rozycki	:	Bits for genuine 82489DX APICs
>   *		Martin J. Bligh	: 	Added support for multi-quad systems
> + *		Dave Jones	:	Report invalid combinations of Athlon CPUs.
>   */
>
>  #include <linux/config.h>
>  #include <linux/init.h>
> +#include <linux/kernel.h>
>
>  #include <linux/mm.h>
>  #include <linux/kernel_stat.h>
> @@ -156,6 +158,35 @@
>  		 * Remember we have B step Pentia with bugs
>  		 */
>  		smp_b_stepping = 1;
> +
> +	/*
> +	 * Certain Athlons might work (for various values of 'work') in SMP
> +	 * but they are not certified as MP capable.
> +	 */
> +	if ((c->x86_vendor == X86_VENDOR_AMD) && (c->x86 == 6)) {
> +
> +		/* Athlon 660/661 is valid. */
> +		if ((c->x86_model==6) && ((c->x86_mask==0) || (c->x86_mask==1)))
> +			goto valid_athlon;
> +
> +		/* Duron 670 is valid */
> +		if ((c->x86_model==7) && (c->x86_mask==0))
> +			goto valid_athlon;
> +
> +		/* Athlon 662, Duron 671, and Athlon >model 7 have capability bit */
> +		if (((c->x86_model==6) && (c->x86_mask>=2)) ||
> +			((c->x86_model==7) && (c->x86_mask>=1)) ||
> +			 (c->x86_model> 7))
> +			if (cpu_has_mp)
> +				goto valid_athlon;
> +
> +		/* If we get here, it's not a certified SMP capable AMD system. */
> +		printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
> +		tainted |= (1<<2);
> +
> +	}
> +valid_athlon:
> +
>  }
>
>  /*
> diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15-pre5/include/asm-i386/cpufeature.h linux-2.4.15-pre5-dj/include/asm-i386/cpufeature.h
> --- linux-2.4.15-pre5/include/asm-i386/cpufeature.h	Mon Nov 13 05:55:50 2000
> +++ linux-2.4.15-pre5-dj/include/asm-i386/cpufeature.h	Fri Nov 16 18:29:24 2001
> @@ -46,6 +46,7 @@
>  /* AMD-defined CPU features, CPUID level 0x80000001, word 1 */
>  /* Don't duplicate feature flags which are redundant with Intel! */
>  #define X86_FEATURE_SYSCALL	(1*32+11) /* SYSCALL/SYSRET */
> +#define X86_FEATURE_MP		(1*32+19) /* MP Capable. */
>  #define X86_FEATURE_MMXEXT	(1*32+22) /* AMD MMX extensions */
>  #define X86_FEATURE_LM		(1*32+29) /* Long Mode (x86-64) */
>  #define X86_FEATURE_3DNOWEXT	(1*32+30) /* AMD 3DNow! extensions */
> diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15-pre5/include/asm-i386/processor.h linux-2.4.15-pre5-dj/include/asm-i386/processor.h
> --- linux-2.4.15-pre5/include/asm-i386/processor.h	Fri Nov 16 18:14:14 2001
> +++ linux-2.4.15-pre5-dj/include/asm-i386/processor.h	Fri Nov 16 19:08:34 2001
> @@ -90,6 +90,7 @@
>  #define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  boot_cpu_data.x86_capability))
>  #define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  boot_cpu_data.x86_capability))
>  #define cpu_has_apic	(test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
> +#define cpu_has_mp (test_bit(X86_FEATURE_MP, boot_cpu_data.x86_capability))
>
>  extern char ignore_irq13;
>
> diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15-pre5/kernel/panic.c linux-2.4.15-pre5-dj/kernel/panic.c
> --- linux-2.4.15-pre5/kernel/panic.c	Sun Sep 30 19:26:08 2001
> +++ linux-2.4.15-pre5-dj/kernel/panic.c	Fri Nov 16 20:46:17 2001
> @@ -103,6 +103,10 @@
>  /**
>   *	print_tainted - return a string to represent the kernel taint state.
>   *
> + *  'P' - Proprietory module has been loaded.
> + *  'F' - Module has been forcibly loaded.
> + *  'S' - SMP with CPUs not designed for SMP.
> + *
>   *	The string is overwritten by the next call to print_taint().
>   */
>
> @@ -112,7 +116,8 @@
>  	if (tainted) {
>  		snprintf(buf, sizeof(buf), "Tainted: %c%c",
>  			tainted & 1 ? 'P' : 'G',
> -			tainted & 2 ? 'F' : ' ');
> +			tainted & 2 ? 'F' : ' ',
> +			tainted & 4 ? 'S' : ' ');
>  	}
>  	else
>  		snprintf(buf, sizeof(buf), "Not tainted");
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

