Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUD0QBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUD0QBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUD0QBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:01:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:63631 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263015AbUD0QBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:01:21 -0400
Date: Tue, 27 Apr 2004 09:01:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Keith Owens <kaos@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.6-rc2 Allow architectures to reenable interrupts on
 contended spinlocks
In-Reply-To: <1928.1083031191@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.58.0404270856260.19703@ppc970.osdl.org>
References: <1928.1083031191@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Apr 2004, Keith Owens wrote:
>
> This patch consists of an ia64 specific change (David Mosberger is
> happy with it) and an architecture independent change.  The latter has
> no effect unless the architecture implements this feature and defines
> __HAVE_ARCH_RAW_SPIN_LOCK_FLAGS.  IOW, this change has no effect on
> anything except ia64, unless the other architecture maintainers want to
> implement this feature for their architecture.

Aargh. Ugly ugly. Can you instead _first_ do all the infrastructure, and 
just add the unused "flags" argument to all architectures, ie take this 
part of the patch:

> Index: 2.6.6-rc2/include/linux/spinlock.h
> ===================================================================
> --- 2.6.6-rc2.orig/include/linux/spinlock.h	Thu Dec 18 13:58:49 2003
> +++ 2.6.6-rc2/include/linux/spinlock.h	Tue Apr 27 11:48:03 2004
> @@ -184,6 +184,12 @@
>  
>  #endif /* !SMP */
>  
> +#ifdef __HAVE_ARCH_RAW_SPIN_LOCK_FLAGS
> +#define _raw_spin_lock(lock) _raw_spin_lock_flags(lock, 0)
> +#else
> +#define _raw_spin_lock_flags(lock, flags) do { (void)flags; _raw_spin_lock(lock); } while(0)
> +#endif
> +
>  /*
>   * Define the various spin_lock and rw_lock methods.  Note we define these
>   * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
> @@ -257,7 +263,7 @@
>  do { \
>  	local_irq_save(flags); \
>  	preempt_disable(); \
> -	_raw_spin_lock(lock); \
> +	_raw_spin_lock_flags(lock, flags); \
>  } while (0)
>  
>  #define spin_lock_irq(lock) \

And remove the need for "__HAVE_ARCH_RAW_SPIN_LOCK_FLAGS", and instead 
create a patch where _all_ architectures have that 

	_raw_spin_lock_flags()

define, it's just that they ignore the "flags" value.

I think the patch makes sense, but I'd rather make the infrastructure 
clean, than have another silly architecture flag.

		Linus
