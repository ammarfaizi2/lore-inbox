Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWAJS3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWAJS3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWAJS3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:29:11 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:58292 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932538AbWAJS3K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:29:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E3RJkIAqe60qbbDZQ715knsQnLuJG4OapTm68sZlcTyEPlyfo29/KElMnOVzndfLTXH88ESRljJDOjgFLt/oOeaZwRiDSmQH2Bm20r7AuwOZmXqgO/0/UXGXsFoG3E6oZzg+EIMfKLtYcZ9jAFmiSyX2/mMeFp3MZwl8FtyJruI=
Message-ID: <2cd57c900601101028qfe81785r@mail.gmail.com>
Date: Tue, 10 Jan 2006 18:28:02 +0000
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2G memory split
Cc: Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060110143931.GM3389@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>
	 <20060110133728.GB3389@suse.de>
	 <Pine.LNX.4.63.0601100840400.9511@winds.org>
	 <20060110143931.GM3389@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/10, Jens Axboe <axboe@suse.de>:
> On Tue, Jan 10 2006, Byron Stanoszek wrote:
> > On Tue, 10 Jan 2006, Jens Axboe wrote:
> >
> > >>yes, i made it totally configurable in 2.4 days: 1:3, 2/2 and 3:1 splits
> > >>were possible. It was a larger patch to enable all this across x86, but
> > >>the Kconfig portion was removed a bit later because people _frequently_
> > >>misconfigured their kernels and then complained about the results.
> > >
> > >How is this different than all other sorts of misconfigurations? As far
> > >as I can tell, the biggest "problem" for some is if they depend on some
> > >binary module that will of course break with a different page offset.
> > >
> > >For simplicity, I didn't add more than the 2/2 split, where we could add
> > >even a 3/1 kernel/user or a 0.5/3.5 (I think sles8 had this).
> >
> > I prefer setting __PAGE_OFFSET to (0x78000000) on machines with 2GB of RAM.
> > This seems to let the kernel use the full 2GB of memory, rather than just
> > 1920-1984 MB (at least back in 2.4 days).
>
> A newer version, trying to cater to the various comments in here.
> Changes:
>
> - Add 1G_OPT split, meant for 1GiB machines. Uses 0xB0000000
> - Add 1G/3G split
> - Move the 2G/2G a little, so the full 2GiB of ram can be mapped.
> - Improve help text (I hope :)
> - Make option depend on EXPERIMENTAL.
> - Make the page.h a lot more readable.
>
> ---
>
> Add option for configuring the page offset, to better optimize the
> kernel for higher memory machines. Enables users to get rid of high
> memory for eg a 1GiB machine.
>
> Signed-off-by: Jens Axboe <axboe@suse.de>
>
> diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
> index d849c68..fcad8f7 100644
> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -444,6 +464,32 @@ config HIGHMEM64G
>
>  endchoice
>
> +choice
> +       depends on NOHIGHMEM && EXPERIMENTAL
> +       prompt "Memory split"
> +       default DEFAULT_3G
> +       help
> +         Select the wanted split between kernel and user memory.
> +
> +         If the address range available to the kernel is less than the
> +         physical memory installed, the remaining memory will be available
> +         as "high memory". Accessing high memory is a little more costly
> +         than low memory, as it needs to be mapped into the kernel first.
> +
> +         Note that selecting anything but the default 3G/1G split will make
> +         your kernel incompatible with binary only modules.
> +
> +       config DEFAULT_3G
> +               bool "3G/1G user/kernel split"
> +       config DEFAULT_3G_OPT
> +               bool "3G/1G user/kernel split (for full 1G low memory)"
> +       config DEFAULT_2G
> +               bool "2G/2G user/kernel split"
> +       config DEFAULT_1G
> +               bool "1G/3G user/kernel split"

I don't like these names. Can't your invent better ones?
Having multiple defaults seems odd. See these maybe:

MEMSPLIT_U3_K1
MEMSPLIT_U11_K5
MEMSPLIT_U39_K44
MEMSPLIT_U1_K3

odd too? midnight here. |-)

> +
> +endchoice
> +
>  config HIGHMEM
>         bool
>         depends on HIGHMEM64G || HIGHMEM4G
> diff --git a/include/asm-i386/page.h b/include/asm-i386/page.h
> index 73296d9..7da50a1 100644
> --- a/include/asm-i386/page.h
> +++ b/include/asm-i386/page.h
> @@ -109,11 +109,23 @@ extern int page_is_ram(unsigned long pag
>
>  #endif /* __ASSEMBLY__ */
>
> +#if defined(CONFIG_DEFAULT_3G)
> +#define __PAGE_OFFSET_RAW      (0xC0000000)
> +#elif defined(CONFIG_DEFAULT_3G_OPT)
> +#define        __PAGE_OFFSET_RAW       (0xB0000000)
> +#elif defined(CONFIG_DEFAULT_2G)
> +#define __PAGE_OFFSET_RAW      (0x78000000)
> +#elif defined(CONFIG_DEFAULT_1G)
> +#define __PAGE_OFFSET_RAW      (0x40000000)
> +#else
> +#error "Bad user/kernel offset"
> +#endif
> +
>  #ifdef __ASSEMBLY__
> -#define __PAGE_OFFSET          (0xC0000000)
> +#define __PAGE_OFFSET          __PAGE_OFFSET_RAW
>  #define __PHYSICAL_START       CONFIG_PHYSICAL_START
>  #else
> -#define __PAGE_OFFSET          (0xC0000000UL)
> +#define __PAGE_OFFSET          ((unsigned long)__PAGE_OFFSET_RAW)
>  #define __PHYSICAL_START       ((unsigned long)CONFIG_PHYSICAL_START)
>  #endif
>  #define __KERNEL_START         (__PAGE_OFFSET + __PHYSICAL_START)
>
> --
> Jens Axboe
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Coywolf Qi Hunt
