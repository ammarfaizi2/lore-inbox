Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274859AbRIUWWE>; Fri, 21 Sep 2001 18:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274858AbRIUWVy>; Fri, 21 Sep 2001 18:21:54 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:7438 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S274855AbRIUWVo>; Fri, 21 Sep 2001 18:21:44 -0400
Date: Fri, 21 Sep 2001 18:22:07 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH:v2] fix register_sysrq() in 2.4.9++
Message-ID: <20010921182207.M8188@mueller.datastacks.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E15k86n-0005lE-00@the-village.bc.nu> <3BAA3C17.557A2C4E@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAA3C17.557A2C4E@osdlab.org>; from rddunlap@osdlab.org on Thu, Sep 20, 2001 at 11:57:27AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this is sufficient. The low level interfaces need to be
exposed, and if we are not expecting modules to pay attention to the
CONFIG_MAGIC_SYSRQ setting, then the all of these interfaces need to be
overridden.

However, do we even need this #ifdef CONFIG_MAGIC_SYSRQ block at all?
What does it matter if modules register or unregister events, if they
cannot be called?

The old code only zaped the enable if sysrq was not defined, and that is
what I'm doing in the table. Some real changes would be neccessary to
actually drop out the whole system.

There is also no real reason to try and no-op these functions for speed,
as they are trivial and FAR outside of the main call path.

So the way to go I see here is:
 a) allow the registration functions to always be defined.
and either:
 b) handle the return failure in the __sysrq_XXX functions themselves,
 c) or not.

++ 20/09/01 11:57 -0700 - Randy.Dunlap:
> Alan Cox wrote:
> > 
> > > Yeah, I considered that, and it doesn't matter to me whether it
> > > reports 0 or -1, but it's the data pointer that (mostly) requires
> > > the #ifdefs, unless the data is always present or a dummy data pointer
> > > is used.... ?
> > 
> > #define it to an inline without some arguments ?
> ~~~~~~~~~~~~~~~~~~
> I can't get that to work, but someone else may be able to...
> 
> Here's another version for you to consider.
> 
> The [un]register_sysrq_key() calls return 0 when CONFIG_MAGIC_SYSRQ
> is not defined/configured.
> However, it sacrifices one small data structure of 3 pointers.
> 
> ~Randy
> --- linux/arch/i386/kernel/apm.c.org	Mon Sep 17 10:15:45 2001
> +++ linux/arch/i386/kernel/apm.c	Thu Sep 20 11:51:25 2001
> @@ -703,6 +703,8 @@
>  	help_msg:       "Off",
>  	action_msg:     "Power Off\n"
>  };
> +#else
> +struct sysrq_key_op sysrq_poweroff_op;
>  #endif
>  
>  
> --- linux/include/linux/sysrq.h.org	Mon Sep 17 10:21:07 2001
> +++ linux/include/linux/sysrq.h	Thu Sep 20 11:42:15 2001
> @@ -87,8 +87,17 @@
>  }
>  
>  #else
> -#define register_sysrq_key(a,b)		do {} while(0)
> -#define unregister_sysrq_key(a,b)	do {} while(0)
> +
> +static inline int register_sysrq_key(int key, struct sysrq_key_op *op_p)
> +{
> +	return 0;
> +}
> +
> +static inline int unregister_sysrq_key(int key, struct sysrq_key_op *op_p)
> +{
> +	return 0;
> +}
> +
>  #endif
>  
>  /* Deferred actions */


-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
