Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422967AbWBAWXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422967AbWBAWXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422979AbWBAWXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:23:16 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:13805 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1422967AbWBAWXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:23:15 -0500
Date: Wed, 1 Feb 2006 23:23:14 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Mark Lord <lkml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
Message-ID: <20060201222314.GA26081@MAIL.13thfloor.at>
Mail-Followup-To: Mark Lord <lkml@rtr.ca>,
	Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
	Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com> <43C40803.2000106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C40803.2000106@rtr.ca>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 02:16:19PM -0500, Mark Lord wrote:
> Okay, fixed the ordering of the "default" lines
> so that the Kconfig actually works correctly.
> 
> Best for Andrew to soak this one in -mm.

glad to see that the linux kernel is now ready for
the 'idea' I submitted a patch[1] for, more than a 
year ago -- which unfortunately went unnoticed back
then ...

cheers to Jens and Mark!

best,
Herbert

[1] http://lkml.org/lkml/2004/10/9/126

> Signed-off-by:  Mark Lord <mlord@pobox.com>
> 
> diff -u --recursive --new-file --exclude='.*' 
> linux-2.6.15/arch/i386/Kconfig linux/arch/i386/Kconfig
> --- linux-2.6.15/arch/i386/Kconfig	2006-01-02 22:21:10.000000000 -0500
> +++ linux/arch/i386/Kconfig	2006-01-10 12:02:40.000000000 -0500
> @@ -448,6 +448,43 @@
> 
>  endchoice
> 
> +choice
> +	depends on EXPERIMENTAL && !X86_PAE
> +	prompt "Memory split"
> +	default VMSPLIT_3G
> +	help
> +	  Select the desired split between kernel and user memory.
> +
> +	  If the address range available to the kernel is less than the
> +	  physical memory installed, the remaining memory will be available
> +	  as "high memory". Accessing high memory is a little more costly
> +	  than low memory, as it needs to be mapped into the kernel first.
> +	  Note that increasing the kernel address space limits the range
> +	  available to user programs, making the address space there
> +	  tighter.  Selecting anything other than the default 3G/1G split
> +	  will also likely make your kernel incompatible with binary-only
> +	  kernel modules.
> +
> +	  If you are not absolutely sure what you are doing, leave this
> +	  option alone!
> +
> +	config VMSPLIT_3G
> +		bool "3G/1G user/kernel split"
> +	config VMSPLIT_3G_OPT
> +		bool "3G/1G user/kernel split (for full 1G low memory)"
> +	config VMSPLIT_2G
> +		bool "2G/2G user/kernel split"
> +	config VMSPLIT_1G
> +		bool "1G/3G user/kernel split"
> +endchoice
> +
> +config PAGE_OFFSET
> +	hex
> +	default 0xB0000000 if VMSPLIT_3G_OPT
> +	default 0x78000000 if VMSPLIT_2G
> +	default 0x40000000 if VMSPLIT_1G
> +	default 0xC0000000
> +
>  config HIGHMEM
>  	bool
>  	depends on HIGHMEM64G || HIGHMEM4G
> diff -u --recursive --new-file --exclude='.*' 
> linux-2.6.15/include/asm-i386/page.h linux/include/asm-i386/page.h
> --- linux-2.6.15/include/asm-i386/page.h	2006-01-02 
> 22:21:10.000000000 -0500
> +++ linux/include/asm-i386/page.h	2006-01-10 12:04:56.000000000 -0500
> @@ -110,10 +110,10 @@
>  #endif /* __ASSEMBLY__ */
> 
>  #ifdef __ASSEMBLY__
> -#define __PAGE_OFFSET		(0xC0000000)
> +#define __PAGE_OFFSET		CONFIG_PAGE_OFFSET
>  #define __PHYSICAL_START	CONFIG_PHYSICAL_START
>  #else
> -#define __PAGE_OFFSET		(0xC0000000UL)
> +#define __PAGE_OFFSET		((unsigned long)CONFIG_PAGE_OFFSET)
>  #define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
>  #endif
>  #define __KERNEL_START		(__PAGE_OFFSET + __PHYSICAL_START)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
