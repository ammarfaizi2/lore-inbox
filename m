Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbTIMQNw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 12:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbTIMQNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 12:13:51 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:40013 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261277AbTIMQNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 12:13:48 -0400
Date: Sat, 13 Sep 2003 17:11:49 +0100
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913161149.GA1750@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
References: <20030913125103.GE27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913125103.GE27368@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 02:51:03PM +0200, Adrian Bunk wrote:

 > This patch makes the bzImage for my computer (same .config, same 
 > compiler, same compiler options) a good 5 kB smaller.

For the invasiveness of the patch, 5KB really is a questionable gain..

 > In 2.4 selecting e.g. M486 has the semantics to get a kernel that runs 
 > on a 486 and above.
 > In 2.6 selecting M486 means that only the 486 is supported.

What are you basing this on ? This seems bogus to me.
Last I checked, I could for eg, boot a 386 kernel on an Athlon.

 > +config CPU_VIAC3_2
 >  	bool "VIA C3-2 (Nehemiah)"
 >  	help
 > -	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage
 > -	  of SSE and tells gcc to treat the CPU as a 686.
 > -	  Note, this kernel will not boot on older (pre model 9) C3s.
 > +	  Select this for a VIA C3 "Nehemiah" (model 9 and above).

You lost an important part of helptext.

 > +config CPU_ONLY_K7
 > +	bool
 > +	depends on CPU_K7 && !CPU_INTEL && !CPU_K6 && !CPU_K8 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_CYRIXIII && !CPU_VIAC3_2
 > +
 > +config CPU_ONLY_K8
 > +	bool
 > +	depends on CPU_K8 && !CPU_INTEL && !CPU_K6 && !CPU_K7 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_CYRIXIII && !CPU_VIAC3_2
 > +
 > +config CPU_ONLY_WINCHIP
 > +	bool
 > +	depends on CPU_WINCHIP && !CPU_INTEL && !CPU_K6 && !CPU_K7 && !CPU_K8 && !X86_ELAN && !CPU_CRUSOE && !CPU_CYRIXIII && !CPU_VIAC3_2
 > +	default y

These are hurrendous.  Each time we add support for a new CPU we
have to update each and every one of these. This won't fly,
someone *WILL* miss one. We've had this sort of thing happen before,
and its an accident waiting to happen.

 > +
 > +ifdef CONFIG_CPU_K8
 > +  ifdef CONFIG_CPU_PENTIUM4
 > +    cpuflags-y	:= $(call check_gcc,-march=pentium3,-march=i686)
 > +  else
 > +    cpuflags-y	:= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
 > +  endif
 > +endif
 > +

These horrible nesting things are also a real PITA, as theres >1 case
that needs updating when something changes for a particular
vendor/family.  The cflags-$foo stuff in 2.6 was just starting to
become readable, and you want to undo that?

 > --- linux-2.6.0-test5-cpu/arch/i386/lib/mmx.c.old	2003-09-13 11:14:00.000000000 +0200
 > +++ linux-2.6.0-test5-cpu/arch/i386/lib/mmx.c	2003-09-13 11:17:00.000000000 +0200
 > @@ -121,7 +121,7 @@
 >  	return p;
 >  }
 >  
 > -#ifdef CONFIG_MK7
 > +#ifndef CONFIG_CPU_CYRIXIII
 >  
 >  /*
 >   *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and

wtf ?

 > --- linux-2.6.0-test5-cpu/arch/i386/mm/init.c.old	2003-09-13 14:18:04.000000000 +0200
 > +++ linux-2.6.0-test5-cpu/arch/i386/mm/init.c	2003-09-13 14:23:26.000000000 +0200
 > @@ -436,8 +436,12 @@
 >  	if (!mem_map)
 >  		BUG();
 >  #endif
 > -	
 > +
 > +#ifdef CONFIG_CPU_686
 >  	bad_ppro = ppro_with_ram_bug();
 > +#else
 > +	bad_ppro = 0;
 > +#endif
 >  

If we boot a 386 kernel on a ppro with that bug, this goes bang.

 >  static void __init init_ifs(void)
 >  {
 > +
 > +#if defined(CONFIG_CPU_K6)
 >  	amd_init_mtrr();
 > +#endif
 > +
 > +#if defined(CONFIG_CPU_586)
 >  	cyrix_init_mtrr();
 > +#endif
 > +
 > +#if defined(CONFIG_CPU_WINCHIP) || defined(CONFIG_CPU_CYRIXIII) || defined(CONFIG_CPU_VIAC3_2)
 >  	centaur_init_mtrr();
 > +#endif
 > +

For the handful of bytes saved in the mtrr driver, I'm more concerned
about ifdef noise, and the fact that we don't have a compile once-run
everywhere MTRR driver anymore unless you pick your options right

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
