Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWHMFsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWHMFsn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 01:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWHMFsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 01:48:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750700AbWHMFsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 01:48:42 -0400
Date: Sat, 12 Aug 2006 22:48:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH for review] [109/145] x86_64: Convert modlist_lock to be
 a raw spinlock
Message-Id: <20060812224825.1da23a1a.akpm@osdl.org>
In-Reply-To: <20060810193707.9DE2013C0B@wotan.suse.de>
References: <20060810 935.775038000@suse.de>
	<20060810193707.9DE2013C0B@wotan.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 21:37:07 +0200 (CEST)
Andi Kleen <ak@suse.de> wrote:

> This is a preparationary patch for converting stacktrace over to the
> new dwarf2 unwinder. lockdep uses stacktrace and the new unwinder
> takes the modlist_lock so using a normal spinlock would cause a deadlock.
> Use a raw lock instead.
> 

It breaks the build on most architectures.

> ---
>  kernel/module.c |   42 ++++++++++++++++++++++++++----------------
>  1 files changed, 26 insertions(+), 16 deletions(-)
> 
> Index: linux/kernel/module.c
> ===================================================================
> --- linux.orig/kernel/module.c
> +++ linux/kernel/module.c
> @@ -59,7 +59,7 @@
>  #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
>  
>  /* Protects module list */
> -static DEFINE_SPINLOCK(modlist_lock);
> +static raw_spinlock_t modlist_lock = __RAW_SPIN_LOCK_UNLOCKED;
>  
>  /* List of modules, protected by module_mutex AND modlist_lock */
>  static DEFINE_MUTEX(module_mutex);
> @@ -751,11 +751,13 @@ void __symbol_put(const char *symbol)
>  	unsigned long flags;
>  	const unsigned long *crc;
>  
> -	spin_lock_irqsave(&modlist_lock, flags);
> +	raw_local_save_flags(flags);
> +	__raw_spin_lock(&modlist_lock);
>  	if (!__find_symbol(symbol, &owner, &crc, 1))
>  		BUG();
>  	module_put(owner);
> -	spin_unlock_irqrestore(&modlist_lock, flags);
> +	__raw_spin_unlock(&modlist_lock);
> +	raw_local_irq_restore(flags);

That looks fairly hacky.  Wouldn't it be better to implement
raw_spin_lock_irqsave()?
