Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTIMSWH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbTIMSWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:22:07 -0400
Received: from havoc.gtf.org ([63.247.75.124]:15763 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261182AbTIMSWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:22:01 -0400
Date: Sat, 13 Sep 2003 14:21:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913182159.GA10047@gtf.org>
References: <20030913125103.GE27368@fs.tum.de> <20030913161149.GA1750@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913161149.GA1750@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 05:11:49PM +0100, Dave Jones wrote:
> 
>  > In 2.4 selecting e.g. M486 has the semantics to get a kernel that runs 
>  > on a 486 and above.
>  > In 2.6 selecting M486 means that only the 486 is supported.
> 
> What are you basing this on ? This seems bogus to me.
> Last I checked, I could for eg, boot a 386 kernel on an Athlon.

If you know that you're only booting on a 486, why include all the junk
needed solely for later processors?


> 
>  > +config CPU_ONLY_K7
>  > +	bool
>  > +	depends on CPU_K7 && !CPU_INTEL && !CPU_K6 && !CPU_K8 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_CYRIXIII && !CPU_VIAC3_2
>  > +
>  > +config CPU_ONLY_K8
>  > +	bool
>  > +	depends on CPU_K8 && !CPU_INTEL && !CPU_K6 && !CPU_K7 && !X86_ELAN && !CPU_CRUSOE && !CPU_WINCHIP && !CPU_CYRIXIII && !CPU_VIAC3_2
>  > +
>  > +config CPU_ONLY_WINCHIP
>  > +	bool
>  > +	depends on CPU_WINCHIP && !CPU_INTEL && !CPU_K6 && !CPU_K7 && !CPU_K8 && !X86_ELAN && !CPU_CRUSOE && !CPU_CYRIXIII && !CPU_VIAC3_2
>  > +	default y
> 
> These are hurrendous.  Each time we add support for a new CPU we
> have to update each and every one of these. This won't fly,
> someone *WILL* miss one. We've had this sort of thing happen before,
> and its an accident waiting to happen.

Agreed


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

Echo my first comment.  I think it's fair to make this stuff
fine-grained -- as long as present behavior is preserved.  So IMO
fine-grained "I really want this cpu, and this cpu only" stuff really
requires a dependency on CONFIG_EMBEDDED.  When !CONFIG_EMBEDDED, for
example, it would define CONFIG_CPU_686 to ensure the required 686
pieces were in place.

I like the general direction of Adrian's patch, and think that moving in
this direction will provide a lot of hidden maintenance _benefits_ after
the initial pain...  But.  Adrian's patch is a tough thing to get right,
and IMO requires a lot of testing.


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

The arch/i386/kernel/cpu stuff is so modular, code like the above just
screams for an ->init_mtrr() hook in there.  drivers/char/hw_random.c
(portably) depends on VIA RNG's xstore instruction, which implies a
dependency on code and settings in arch/i386/*.  So, there's nothing
fundamentally wrong with sticking your fingers in there, IMO...

	Jeff



