Return-Path: <linux-kernel-owner+w=401wt.eu-S965137AbXAJWAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbXAJWAU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbXAJWAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:00:20 -0500
Received: from europa.telenet-ops.be ([195.130.137.75]:50586 "EHLO
	europa.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965136AbXAJWAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:00:18 -0500
X-Greylist: delayed 1230 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 17:00:18 EST
Date: Wed, 10 Jan 2007 23:00:15 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] mm: pagefault_{disable,enable}()
In-Reply-To: <200612071659.kB7GxGHa030259@hera.kernel.org>
Message-ID: <Pine.LNX.4.64.0701102256410.4331@anakin>
References: <200612071659.kB7GxGHa030259@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006, Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a866374aecc90c7d90619727ccd851ac096b2fc7
> Commit:     a866374aecc90c7d90619727ccd851ac096b2fc7
> Parent:     6edaf68a87d17570790fd55f0c451a29ec1d6703
> Author:     Peter Zijlstra <a.p.zijlstra@chello.nl>
> AuthorDate: Wed Dec 6 20:32:20 2006 -0800
> Committer:  Linus Torvalds <torvalds@woody.osdl.org>
> CommitDate: Thu Dec 7 08:39:21 2006 -0800
> 
>     [PATCH] mm: pagefault_{disable,enable}()
>     
>     Introduce pagefault_{disable,enable}() and use these where previously we did
>     manual preempt increments/decrements to make the pagefault handler do the
>     atomic thing.
>     
>     Currently they still rely on the increased preempt count, but do not rely on
>     the disabled preemption, this might go away in the future.
>     
>     (NOTE: the extra barrier() in pagefault_disable might fix some holes on
>            machines which have too many registers for their own good)
>     
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index a48d7f1..67918c2 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -1,8 +1,43 @@
>  #ifndef __LINUX_UACCESS_H__
>  #define __LINUX_UACCESS_H__
>  
> +#include <linux/preempt.h>
>  #include <asm/uaccess.h>
>  
> +/*
> + * These routines enable/disable the pagefault handler in that
> + * it will not take any locks and go straight to the fixup table.
> + *
> + * They have great resemblance to the preempt_disable/enable calls
> + * and in fact they are identical; this is because currently there is
> + * no other way to make the pagefault handlers do this. So we do
> + * disable preemption but we don't necessarily care about that.
> + */
> +static inline void pagefault_disable(void)
> +{
> +	inc_preempt_count();
> +	/*
> +	 * make sure to have issued the store before a pagefault
> +	 * can hit.
> +	 */
> +	barrier();
> +}
> +
> +static inline void pagefault_enable(void)
> +{
> +	/*
> +	 * make sure to issue those last loads/stores before enabling
> +	 * the pagefault handler again.
> +	 */
> +	barrier();
> +	dec_preempt_count();
> +	/*
> +	 * make sure we do..
> +	 */
> +	barrier();
> +	preempt_check_resched();
> +}
> +
>  #ifndef ARCH_HAS_NOCACHE_UACCESS
>  
>  static inline unsigned long __copy_from_user_inatomic_nocache(void *to,

This change causes lots of compile errors of the following form on m68k:

| linux-2.6.20-rc4/include/linux/uaccess.h: In function `pagefault_disable':
| linux-2.6.20-rc4/include/linux/uaccess.h:18: error: dereferencing pointer to incomplete type
| linux-2.6.20-rc4/include/linux/uaccess.h: In function `pagefault_enable':
| linux-2.6.20-rc4/include/linux/uaccess.h:33: error: dereferencing pointer to incomplete type

    -> inc_preempt_count
    -> add_preempt_count
    -> preempt_count
    -> current_thread_info
    -> task_thread_info
which needs the definition of struct task_struct.

The patch below fixes it by including <linux/sched.h> in
include/linux/uaccess.h. But perhaps this is the right time to move
struct task_struct to its own include instead?

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67918c2..ae73f32 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,6 +2,7 @@
 #define __LINUX_UACCESS_H__
 
 #include <linux/preempt.h>
+#include <linux/sched.h>
 #include <asm/uaccess.h>
 
 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
