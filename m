Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTIMRXe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbTIMRXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:23:34 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:11785 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261449AbTIMRX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:23:29 -0400
Date: Sat, 13 Sep 2003 18:21:30 +0100
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913172130.GO1191@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
References: <20030913125103.GE27368@fs.tum.de> <20030913161149.GA1750@redhat.com> <20030913164146.GI27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913164146.GI27368@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 06:41:46PM +0200, Adrian Bunk wrote:

 > >  > In 2.6 selecting M486 means that only the 486 is supported.
 > > 
 > > What are you basing this on ? This seems bogus to me.
 > > Last I checked, I could for eg, boot a 386 kernel on an Athlon.
 > 
 > It currently works.

Exactly, then your first statement above is bogus.
 
 > The question is the exact semantics of X86_GENERIC. 
 > If you read the description of X86_GENERIC it implicitely says a kernel 
 > for a 386 isn't generic.

Apart from using incorrect cache line alignments on P4, an i386 kernel
is no more, no less generic than one compiled with X86_GENERIC

 > >  > +config CPU_VIAC3_2
 > >  >  	bool "VIA C3-2 (Nehemiah)"
 > >  >  	help
 > >  > -	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage
 > >  > -	  of SSE and tells gcc to treat the CPU as a 686.
 > >  > -	  Note, this kernel will not boot on older (pre model 9) C3s.
 > >  > +	  Select this for a VIA C3 "Nehemiah" (model 9 and above).
 > > 
 > > You lost an important part of helptext.
 > With the patch to the Makefile the "enables usage of SSE and tells gcc
 > to treat the CPU as a 686" is only true if you don't compile support for 
 > older CPUs.

Incidentally, looking closer you broke this option.

+ifdef CONFIG_CPU_VIAC3_2
+  cpuflags-y  := $(call check_gcc,-march=c3,-march=i686)
+endif

Its C3_2 becauase it needs -march=c3-2 to use SSE instead of 3dnow
prefetches.  One thing that just occured to me, it may be possible
to dispose of this option completley now that Andi's runtime
patching code is in. If I get time I'll take a look at that.

 > >  > +ifdef CONFIG_CPU_K8
 > >  > +  ifdef CONFIG_CPU_PENTIUM4
 > >  > +    cpuflags-y	:= $(call check_gcc,-march=pentium3,-march=i686)
 > >  > +  else
 > >  > +    cpuflags-y	:= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
 > >  > +  endif
 > >  > +endif
 > >  > +
 > > 
 > > These horrible nesting things are also a real PITA, as theres >1 case
 > > that needs updating when something changes for a particular
 > > vendor/family.  The cflags-$foo stuff in 2.6 was just starting to
 > > become readable, and you want to undo that?
 > 
 > The idea is to move the question "Which CPU option supports bot an
 > Athlon and a Pentium 4?" from the user to the kernel. The user no longer 
 > has to take care of this, he simply selects all CPUs he wants to 
 > support.

That should be solved using CONFIG_X86_GENERIC, not fuglifying the Makefiles.
Seriously, I think this is completely the wrong approach. Seriously, how many
mails does l-k get of people saying, "Oh duh, my no booting kernel was
because I chose to compile for Athlon, and I have a Pentium 4" or the likes?
This seems to be a solution in search of a problem.

 > >  > -#ifdef CONFIG_MK7
 > >  > +#ifndef CONFIG_CPU_CYRIXIII
 > >  >  
 > >  >  /*
 > >  >   *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and
 > > 
 > > wtf ?
 > 
 > It's logical considering the dependencies of X86_USE_3DNOW.
 > 
 > But thinking about it a second time, it seems a CONFIG_CPU_ONLY_K7 does 
 > the same and is less error prone.

X86_USE_3DNOW would seem more logical to me. I never checked if this
was a win on C3, but as that also has 3dnow its possibly worth looking into.

 > >  > --- linux-2.6.0-test5-cpu/arch/i386/mm/init.c.old	2003-09-13 14:18:04.000000000 +0200
 > >  > +++ linux-2.6.0-test5-cpu/arch/i386/mm/init.c	2003-09-13 14:23:26.000000000 +0200
 > >  > @@ -436,8 +436,12 @@
 > >  >  	if (!mem_map)
 > >  >  		BUG();
 > >  >  #endif
 > >  > -	
 > >  > +
 > >  > +#ifdef CONFIG_CPU_686
 > >  >  	bad_ppro = ppro_with_ram_bug();
 > >  > +#else
 > >  > +	bad_ppro = 0;
 > >  > +#endif
 > >  >  
 > > 
 > > If we boot a 386 kernel on a ppro with that bug, this goes bang.
 > 
 > ppro_with_ram_bug checks for one specific ppro bug.
 > On a 386 this funtion returns 0.

I'm not talking about running it on a 386. I'm talking about running
a kernel _compiled as 386_, on a PPro which has the bug this fixes.
With your patch, this code does nothing, and the bug doesn't get worked
around. Currently, it does the right thing. You're saving a half dozen
or so bytes, and making things like vendor boot kernels (typically
compiled as 386) not perform a necessary errata workaround.
And "You can select 486/586/686 too" is not an answer. These kernels
need to be small, and errata workarounds should NEVER be compiled out
for exactly this reason.

 > >  >  static void __init init_ifs(void)
 > >  >  {
 > >  > +
 > >  > +#if defined(CONFIG_CPU_K6)
 > >  >  	amd_init_mtrr();
 > >  > +#endif
 > >  > +
 > >  > +#if defined(CONFIG_CPU_586)
 > >  >  	cyrix_init_mtrr();
 > >  > +#endif
 > >  > +
 > >  > +#if defined(CONFIG_CPU_WINCHIP) || defined(CONFIG_CPU_CYRIXIII) || defined(CONFIG_CPU_VIAC3_2)
 > >  >  	centaur_init_mtrr();
 > >  > +#endif
 > >  > +
 > > 
 > > For the handful of bytes saved in the mtrr driver, I'm more concerned
 > > about ifdef noise, and the fact that we don't have a compile once-run
 > > everywhere MTRR driver anymore unless you pick your options right
 > 
 > You have a "compile once-run everywhere MTRR driver" if you select all 
 > CPUs.

That doesn't solve the 'looks ugly as all hell' problem.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
