Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbTIMSWl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTIMSWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:22:41 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49353 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261470AbTIMSWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:22:23 -0400
Date: Sat, 13 Sep 2003 20:22:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913182212.GK27368@fs.tum.de>
References: <20030913125103.GE27368@fs.tum.de> <20030913161149.GA1750@redhat.com> <20030913164146.GI27368@fs.tum.de> <20030913172130.GO1191@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913172130.GO1191@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 06:21:30PM +0100, Dave Jones wrote:
> On Sat, Sep 13, 2003 at 06:41:46PM +0200, Adrian Bunk wrote:
> 
>  > >  > In 2.6 selecting M486 means that only the 486 is supported.
>  > > 
>  > > What are you basing this on ? This seems bogus to me.
>  > > Last I checked, I could for eg, boot a 386 kernel on an Athlon.
>  > 
>  > It currently works.
> 
> Exactly, then your first statement above is bogus.

It was a leftover from a first version where I had a misunderstanding 
regarding the exact effects of X86_L1_CACHE_SHIFT.

If it should continue to work as it currently works the description 
"Generic x86 support" is _very_ misleading.

What does a user think on which machines a kernel will run after he 
enabled the following options?
  - "Athlon/Duron/K7"
  - "Generic x86 support"

>  > The question is the exact semantics of X86_GENERIC. 
>  > If you read the description of X86_GENERIC it implicitely says a kernel 
>  > for a 386 isn't generic.
> 
> Apart from using incorrect cache line alignments on P4, an i386 kernel
> is no more, no less generic than one compiled with X86_GENERIC

plus X86_INTEL_USERCOPY

>  > >  > +config CPU_VIAC3_2
>  > >  >  	bool "VIA C3-2 (Nehemiah)"
>  > >  >  	help
>  > >  > -	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage
>  > >  > -	  of SSE and tells gcc to treat the CPU as a 686.
>  > >  > -	  Note, this kernel will not boot on older (pre model 9) C3s.
>  > >  > +	  Select this for a VIA C3 "Nehemiah" (model 9 and above).
>  > > 
>  > > You lost an important part of helptext.
>  > With the patch to the Makefile the "enables usage of SSE and tells gcc
>  > to treat the CPU as a 686" is only true if you don't compile support for 
>  > older CPUs.
> 
> Incidentally, looking closer you broke this option.
> 
> +ifdef CONFIG_CPU_VIAC3_2
> +  cpuflags-y  := $(call check_gcc,-march=c3,-march=i686)
> +endif
> 
> Its C3_2 becauase it needs -march=c3-2 to use SSE instead of 3dnow
> prefetches.  One thing that just occured to me, it may be possible
>...

Which gcc does support -march=c3-2 ? gcc 3.3.1 doesn't support it.

That's the reason why I changed this -march setting (as noted in my 
changelog).

>...
>  > >  > -#ifdef CONFIG_MK7
>  > >  > +#ifndef CONFIG_CPU_CYRIXIII
>  > >  >  
>  > >  >  /*
>  > >  >   *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and
>  > > 
>  > > wtf ?
>  > 
>  > It's logical considering the dependencies of X86_USE_3DNOW.
>  > 
>  > But thinking about it a second time, it seems a CONFIG_CPU_ONLY_K7 does 
>  > the same and is less error prone.
> 
> X86_USE_3DNOW would seem more logical to me. I never checked if this
> was a win on C3, but as that also has 3dnow its possibly worth looking into.

Current -test5 (without my patch) has

config X86_USE_3DNOW
        bool
        depends on MCYRIXIII || MK7
        default y

This #ifdef is there to differenciate between the K7 and the generic MMX 
implementation.

>  > >  > --- linux-2.6.0-test5-cpu/arch/i386/mm/init.c.old	2003-09-13 14:18:04.000000000 +0200
>  > >  > +++ linux-2.6.0-test5-cpu/arch/i386/mm/init.c	2003-09-13 14:23:26.000000000 +0200
>  > >  > @@ -436,8 +436,12 @@
>  > >  >  	if (!mem_map)
>  > >  >  		BUG();
>  > >  >  #endif
>  > >  > -	
>  > >  > +
>  > >  > +#ifdef CONFIG_CPU_686
>  > >  >  	bad_ppro = ppro_with_ram_bug();
>  > >  > +#else
>  > >  > +	bad_ppro = 0;
>  > >  > +#endif
>  > >  >  
>  > > 
>  > > If we boot a 386 kernel on a ppro with that bug, this goes bang.
>  > 
>  > ppro_with_ram_bug checks for one specific ppro bug.
>  > On a 386 this funtion returns 0.
> 
> I'm not talking about running it on a 386. I'm talking about running
> a kernel _compiled as 386_, on a PPro which has the bug this fixes.
> With your patch, this code does nothing, and the bug doesn't get worked
> around. Currently, it does the right thing. You're saving a half dozen
> or so bytes, and making things like vendor boot kernels (typically
> compiled as 386) not perform a necessary errata workaround.

Well, this is an optional part of my patch. It will be splitted from the 
main part.

> And "You can select 486/586/686 too" is not an answer. These kernels
> need to be small, and errata workarounds should NEVER be compiled out
> for exactly this reason.
>...

Why is a kernel compiled with support for all CPUs necessarily much
bigger than a current M386 kernel?

OTOH, why waste space on a 486 for 3DNow! support?

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

