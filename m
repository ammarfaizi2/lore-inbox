Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbTIMQl5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 12:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTIMQl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 12:41:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17102 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261337AbTIMQlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 12:41:53 -0400
Date: Sat, 13 Sep 2003 18:41:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913164146.GI27368@fs.tum.de>
References: <20030913125103.GE27368@fs.tum.de> <20030913161149.GA1750@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913161149.GA1750@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 05:11:49PM +0100, Dave Jones wrote:
> On Sat, Sep 13, 2003 at 02:51:03PM +0200, Adrian Bunk wrote:
> 
>  > This patch makes the bzImage for my computer (same .config, same 
>  > compiler, same compiler options) a good 5 kB smaller.
> 
> For the invasiveness of the patch, 5KB really is a questionable gain..

I should have stated that the arch/i386/kernel/cpu{,/mtrr}/Makefile 
parts are an example of what is possible with such a CPU selection 
schema.

I'll send a splitted patch where this is only an optional enhanchement.

>  > In 2.4 selecting e.g. M486 has the semantics to get a kernel that runs 
>  > on a 486 and above.
>  > In 2.6 selecting M486 means that only the 486 is supported.
> 
> What are you basing this on ? This seems bogus to me.
> Last I checked, I could for eg, boot a 386 kernel on an Athlon.

It currently works. The question is the exact semantics of X86_GENERIC. 
If you read the description of X86_GENERIC it implicitely says a kernel 
for a 386 isn't generic.

>  > +config CPU_VIAC3_2
>  >  	bool "VIA C3-2 (Nehemiah)"
>  >  	help
>  > -	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage
>  > -	  of SSE and tells gcc to treat the CPU as a 686.
>  > -	  Note, this kernel will not boot on older (pre model 9) C3s.
>  > +	  Select this for a VIA C3 "Nehemiah" (model 9 and above).
> 
> You lost an important part of helptext.

With the patch to the Makefile the "enables usage of SSE and tells gcc
to treat the CPU as a 686" is only true if you don't compile support for 
older CPUs.

>...
>  > +
>  > +ifdef CONFIG_CPU_K8
>  > +  ifdef CONFIG_CPU_PENTIUM4
>  > +    cpuflags-y	:= $(call check_gcc,-march=pentium3,-march=i686)
>  > +  else
>  > +    cpuflags-y	:= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
>  > +  endif
>  > +endif
>  > +
> 
> These horrible nesting things are also a real PITA, as theres >1 case
> that needs updating when something changes for a particular
> vendor/family.  The cflags-$foo stuff in 2.6 was just starting to
> become readable, and you want to undo that?

The idea is to move the question "Which CPU option supports bot an
Athlon and a Pentium 4?" from the user to the kernel. The user no longer 
has to take care of this, he simply selects all CPUs he wants to 
support.

>  > --- linux-2.6.0-test5-cpu/arch/i386/lib/mmx.c.old	2003-09-13 11:14:00.000000000 +0200
>  > +++ linux-2.6.0-test5-cpu/arch/i386/lib/mmx.c	2003-09-13 11:17:00.000000000 +0200
>  > @@ -121,7 +121,7 @@
>  >  	return p;
>  >  }
>  >  
>  > -#ifdef CONFIG_MK7
>  > +#ifndef CONFIG_CPU_CYRIXIII
>  >  
>  >  /*
>  >   *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and
> 
> wtf ?

It's logical considering the dependencies of X86_USE_3DNOW.

But thinking about it a second time, it seems a CONFIG_CPU_ONLY_K7 does 
the same and is less error prone.

>  > --- linux-2.6.0-test5-cpu/arch/i386/mm/init.c.old	2003-09-13 14:18:04.000000000 +0200
>  > +++ linux-2.6.0-test5-cpu/arch/i386/mm/init.c	2003-09-13 14:23:26.000000000 +0200
>  > @@ -436,8 +436,12 @@
>  >  	if (!mem_map)
>  >  		BUG();
>  >  #endif
>  > -	
>  > +
>  > +#ifdef CONFIG_CPU_686
>  >  	bad_ppro = ppro_with_ram_bug();
>  > +#else
>  > +	bad_ppro = 0;
>  > +#endif
>  >  
> 
> If we boot a 386 kernel on a ppro with that bug, this goes bang.

ppro_with_ram_bug checks for one specific ppro bug.
On a 386 this funtion returns 0.

This is part of the (optional) part of this patch that selects only the 
needed parts in arch/i386/kernel/cpu/Makefile. When compiling a kernel 
without any support for Intel CPUs I got a linker error. It could be 
CONFIG_CPU_INTEL (since that's when arch/i386/kernel/cpu/intel.c gets 
compiled) but since this function returns 1 only for some ppro's I've 
optimized it to ppro_with_ram_bug.

>  >  static void __init init_ifs(void)
>  >  {
>  > +
>  > +#if defined(CONFIG_CPU_K6)
>  >  	amd_init_mtrr();
>  > +#endif
>  > +
>  > +#if defined(CONFIG_CPU_586)
>  >  	cyrix_init_mtrr();
>  > +#endif
>  > +
>  > +#if defined(CONFIG_CPU_WINCHIP) || defined(CONFIG_CPU_CYRIXIII) || defined(CONFIG_CPU_VIAC3_2)
>  >  	centaur_init_mtrr();
>  > +#endif
>  > +
> 
> For the handful of bytes saved in the mtrr driver, I'm more concerned
> about ifdef noise, and the fact that we don't have a compile once-run
> everywhere MTRR driver anymore unless you pick your options right

You have a "compile once-run everywhere MTRR driver" if you select all 
CPUs.

As stated above, this isn't part of the core patch.

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

