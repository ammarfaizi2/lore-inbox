Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbTD1JEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 05:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbTD1JEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 05:04:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26866 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263037AbTD1JEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 05:04:05 -0400
Date: Mon, 28 Apr 2003 11:16:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support worst case cache line sizes as config option
Message-ID: <20030428091616.GA27064@fs.tum.de>
References: <20030427022346.GA27933@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030427022346.GA27933@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 04:23:46AM +0200, Andi Kleen wrote:
> 
> This mirrors a change that has been in the SuSE/aa 2.4 kernel for a long time.
> 
> For a generic binary kernel you really want to assume the worst case
> cache line size.  That's the P4's 128 byte currently.
> 
> The overhead of having the cache line size bigger on other CPUs is not
> that bad, but if it is too small it will cost you dearly on SMP and
> even a bit on UP in device drivers. 
> 
> This patch adds a new CONFIG_X86_GENERIC option for this. It currently
> only forces 128byte cache lines, but could be used for more in the future.
> 
> diff -u linux-gencpu/arch/i386/Kconfig-o linux-gencpu/arch/i386/Kconfig
> --- linux-gencpu/arch/i386/Kconfig-o	2003-04-27 02:40:32.000000000 +0200
> +++ linux-gencpu/arch/i386/Kconfig	2003-04-27 03:50:08.000000000 +0200
> @@ -273,6 +273,13 @@
>  
>  endchoice
>  
> +config X86_GENERIC
> +       bool "Generic x86 support" 
> +       help
> +       	  Include some tuning for non selected x86 CPUs too.
> +	  when it has moderate overhead. This is intended for generic 
> +	  distributions kernels.
> +
>  #
>  # Define implied options from the CPU selection here
>  #


Your X86_GENERIC is semantically equivalent to M386.



> @@ -288,10 +295,10 @@
>  
>  config X86_L1_CACHE_SHIFT
>  	int
> +	default "7" if MPENTIUM4 || X86_GENERIC
>  	default "4" if MELAN || M486 || M386
>  	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
>  	default "6" if MK7 || MK8
> -	default "7" if MPENTIUM4
>  
>  config RWSEM_GENERIC_SPINLOCK
>  	bool


This doesn't work. E.g. MPENTIUMIII has the semantics of "support 
Pentium-III and above". If you want to compile a kernel that runs on 
both a Pentium-III and a Pentium-4 you choose MPENTIUMIII which implies 
X86_L1_CACHE_SHIFT=5 ...


I'm currently working on changing the "Processor family" options from
the current "select the minimum processor you want to support" to 
"select all processors you want to support:
  [ ] 386
  [ ] 486
  ...
  [ ] VIA C3-2"
with the possibility to select one or more processors from the list.

X86_L1_CACHE_SHIFT will simply work with the following (using the 
Kconfig feature that the first "default" with fulfilled "if" is used):

config X86_L1_CACHE_SHIFT
        int
        default "7" if MPENTIUM4
        default "6" if MK7 || MK8
        default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
        default "4" if MELAN || M486 || M386


Additionally this will make it possible to solve cases where users 
configuring the kernel currently ask "Which CPU should I select for a 
kernel that runs on both a K6 and a Pentium-III?" automatically inside 
arch/i386/Makefile.

I'll send a patch within the next days.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

