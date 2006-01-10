Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWAJPZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWAJPZB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWAJPZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:25:01 -0500
Received: from aun.it.uu.se ([130.238.12.36]:43406 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751123AbWAJPZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:25:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17347.53668.266546.344752@alkaid.it.uu.se>
Date: Tue, 10 Jan 2006 16:24:20 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Byron Stanoszek <gandalf@winds.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Address space split configuration
In-Reply-To: <20060110150331.GN3389@suse.de>
References: <20060110125852.GA3389@suse.de>
	<20060110132957.GA28666@elte.hu>
	<20060110133728.GB3389@suse.de>
	<Pine.LNX.4.63.0601100840400.9511@winds.org>
	<20060110143931.GM3389@suse.de>
	<20060110144412.GA9295@elte.hu>
	<20060110150331.GN3389@suse.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
 > Thanks! Updated patch below.
 > 
 > ---
 > 
 > Add option for configuring the page offset, to better optimize the
 > kernel for higher memory machines. Enables users to get rid of high
 > memory for eg a 1GiB machine.
 > 
 > Signed-off-by: Jens Axboe <axboe@suse.de>
 > Acked-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Mikael Pettersson <mikpe@csd.uu.se>

 > diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
 > index d849c68..20d1423 100644
 > --- a/arch/i386/Kconfig
 > +++ b/arch/i386/Kconfig
 > @@ -444,6 +464,35 @@ config HIGHMEM64G
 >  
 >  endchoice
 >  
 > +choice
 > +	depends on NOHIGHMEM && EXPERIMENTAL
 > +	prompt "Memory split"
 > +	default DEFAULT_3G
 > +	help
 > +	  Select the wanted split between kernel and user memory.
 > +
 > +	  If the address range available to the kernel is less than the
 > +	  physical memory installed, the remaining memory will be available
 > +	  as "high memory". Accessing high memory is a little more costly
 > +	  than low memory, as it needs to be mapped into the kernel first.
 > +	  Note that increasing the kernel address space limits the range
 > +	  available to user programs, making the address space there
 > +	  tighter.
 > +
 > +	  If you are not absolutely sure what you are doing, leave this
 > +	  option alone!
 > +
 > +	config DEFAULT_3G
 > +		bool "3G/1G user/kernel split"
 > +	config DEFAULT_3G_OPT
 > +		bool "3G/1G user/kernel split (for full 1G low memory)"
 > +	config DEFAULT_2G
 > +		bool "2G/2G user/kernel split"
 > +	config DEFAULT_1G
 > +		bool "1G/3G user/kernel split"
 > +
 > +endchoice
 > +
 >  config HIGHMEM
 >  	bool
 >  	depends on HIGHMEM64G || HIGHMEM4G
 > diff --git a/arch/i386/mm/init.c b/arch/i386/mm/init.c
 > index 7df494b..67f1da0 100644
 > --- a/arch/i386/mm/init.c
 > +++ b/arch/i386/mm/init.c
 > @@ -597,6 +597,12 @@ void __init mem_init(void)
 >  	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
 >  #endif
 >  
 > +#if !defined(CONFIG_DEFAULT_3G)
 > +	/* if the user has less than 960MB of RAM, he should use the default */
 > +	if (max_low_pfn < (960 * 1024 * 1024 / PAGE_SIZE))
 > +		printk(KERN_INFO "Memory: less than 960MiB of RAM, you should use the default memory split setting\n");
 > +#endif
 > +
 >  	/* this will put all low memory onto the freelists */
 >  	totalram_pages += free_all_bootmem();
 >  
 > diff --git a/include/asm-i386/page.h b/include/asm-i386/page.h
 > index 73296d9..7da50a1 100644
 > --- a/include/asm-i386/page.h
 > +++ b/include/asm-i386/page.h
 > @@ -109,11 +109,23 @@ extern int page_is_ram(unsigned long pag
 >  
 >  #endif /* __ASSEMBLY__ */
 >  
 > +#if defined(CONFIG_DEFAULT_3G)
 > +#define __PAGE_OFFSET_RAW	(0xC0000000)
 > +#elif defined(CONFIG_DEFAULT_3G_OPT)
 > +#define	__PAGE_OFFSET_RAW	(0xB0000000)
 > +#elif defined(CONFIG_DEFAULT_2G)
 > +#define __PAGE_OFFSET_RAW	(0x78000000)
 > +#elif defined(CONFIG_DEFAULT_1G)
 > +#define __PAGE_OFFSET_RAW	(0x40000000)
 > +#else
 > +#error "Bad user/kernel offset"
 > +#endif
 > +
 >  #ifdef __ASSEMBLY__
 > -#define __PAGE_OFFSET		(0xC0000000)
 > +#define __PAGE_OFFSET		__PAGE_OFFSET_RAW
 >  #define __PHYSICAL_START	CONFIG_PHYSICAL_START
 >  #else
 > -#define __PAGE_OFFSET		(0xC0000000UL)
 > +#define __PAGE_OFFSET		((unsigned long)__PAGE_OFFSET_RAW)
 >  #define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
 >  #endif
 >  #define __KERNEL_START		(__PAGE_OFFSET + __PHYSICAL_START)
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
