Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262523AbTCRQFl>; Tue, 18 Mar 2003 11:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbTCRQFl>; Tue, 18 Mar 2003 11:05:41 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:61188 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S262523AbTCRQFf>; Tue, 18 Mar 2003 11:05:35 -0500
Subject: Re: [patch] NUMAQ subarchification
From: James Bottomley <James.Bottomley@steeleye.com>
To: colpatch@us.ibm.com
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3E767D45.6020308@us.ibm.com>
References: <1047676332.5409.374.camel@mulgrave>
	<3E7284CA.6010907@us.ibm.com> <3E7285E7.8080802@us.ibm.com>
	<247240000.1047693951@flay>  <3E767D45.6020308@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Mar 2003 11:16:20 -0500
Message-Id: <1048004181.2210.53.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-17 at 20:58, Matthew Dobson wrote:
> 
> I'm inclined to agree with Martin on this one.  The useless code 
> duplication is outright stupidity.  Makefile hackery would work, as 
> would James' suggestion of #include'ing the .c files.  I tend to agree 
> with his assessment of that as the least of evils.  But until we have a 
> good way of falling back to mach-default for .c files, I'm going to 
> leave the one (relatively) small .c file in arch/i386/kernel.  It will 
> be trivial to move it later, and for now it sits nicely next to it's 
> kin: arch/i386/kernel/numaq.c.

There are five hooks in setup.c (since I assume SUMMIT isn't MCA),
amounting to about 20 lines of code in all.  There is no extra code in
the hooks which doesn't serve a purpose to the rest of the subarch
implementations.

I also notice there's some summit code that *should* be in an arch hook:

> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.65-vanilla/arch/i386/kernel/setup.c linux-2.5.65-summit_pcimap/arch/i386/kernel/setup.c
> --- linux-2.5.65-vanilla/arch/i386/kernel/setup.c	Mon Mar 17 13:44:05 2003
> +++ linux-2.5.65-summit_pcimap/arch/i386/kernel/setup.c	Mon Mar 17 17:34:03 2003
> @@ -939,6 +939,9 @@
>  	if (smp_found_config)
>  		get_smp_config();
>  #endif
> +#ifdef CONFIG_X86_SUMMIT
> +	setup_summit();
> +#endif
>  
>  	register_memory(max_low_pfn);
>  
> --- linux-2.5.65-vanilla/include/asm-i386/mpspec.h	Mon Mar 17 13:43:37 2003
> +++ linux-2.5.65-summit_pcimap/include/asm-i386/mpspec.h	Mon Mar 17 17:34:03 2003
> @@ -222,6 +222,10 @@
>  extern int pic_mode;
>  extern int using_apic_timer;
>  
> +#ifdef CONFIG_X86_SUMMIT
> +extern void setup_summit (void);
> +#endif
> +

which is already there waiting for you to use it.

As I've already pointed out, the summit topology.c file should be split
out from the default one and the #ifdef CONFIG_NUMA removed.

All in all, properly done, there would be very little code duplication
even for something as PC like as the summit.

If I read correctly between the whines, the real issue is that subarch
is used to support things that vary from uniquely oddball to extremely
weird and are all ancient and highly unlikely ever to be found in
nature.  IBM, understandably, doesn't want its brand new and expensive
summit lumped with such company.

I'm not the gatekeeper of code purity in arch/i386/kernel, so if you can
convince Linus, he'll probably take it.  However, if you could come up
with a cogent technical argument why you can't use the subarch (or
modify it for your needs), it would probably be helpful.  Not wanting to
duplicate 15 lines of code isn't really that convincing...

James


