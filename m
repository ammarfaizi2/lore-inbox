Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284181AbRLASH6>; Sat, 1 Dec 2001 13:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284179AbRLASHo>; Sat, 1 Dec 2001 13:07:44 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:11749 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284183AbRLASGZ>; Sat, 1 Dec 2001 13:06:25 -0500
Date: Sat, 1 Dec 2001 20:11:14 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup + reverted JBD code path
 changes
In-Reply-To: <420365759.1007228406@[195.224.237.69]>
Message-ID: <Pine.LNX.4.33.0112012004470.14914-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like your method, but looking at the code i've done the cleanup on,
most of it is not even close to being performance critical as you said. So
this might be overkill for it.

> If what you are worried about is performance loss through
> checking the argument to kfree() against NULL twice, wouldn't
> we be better doing something like this:
>
> --- linux.clean/kernel/slab.c     Sat Jan 27 20:05:11 2001
> +++ linux/kernel/slab.c      Sat Dec  1 17:31:38 2001
> @@ -1577,7 +1577,7 @@
>         kmem_cache_t *c;
>         unsigned long flags;
>
> -       if (!objp)
> +       if (unlikely(!objp))
>                 return;
>         local_irq_save(flags);
>         CHECK_PAGE(virt_to_page(objp));
>
> And then go through all the ones in your patch, and
> rather than deleting them, inserting likely() / unlikely()
> as appropriate in the ones that have any chance of actually
> affecting performance.
>
> Or even better, add in slab.h
>
> static inline void kfree(const void * objp)
> {
> 	if (likely(objp)) __kfree(objp);
> 	/* perhaps it should 'else BUG() here' but
> 	 * can't do that today
> 	 */
> }
>
> &
>
> --- linux.clean/kernel/slab.c     Sat Jan 27 20:05:11 2001
> +++ linux/kernel/slab.c      Sat Dec  1 17:35:35 2001
> @@ -1572,13 +1572,11 @@
>   * Don't free memory not originally allocated by kmalloc()
>   * or you will run into trouble.
>   */
> -void kfree (const void *objp)
> +void __kfree (const void *objp)
>  {
>         kmem_cache_t *c;
>         unsigned long flags;
>
> -       if (!objp)
> -               return;
>         local_irq_save(flags);
>         CHECK_PAGE(virt_to_page(objp));
>         c = GET_PAGE_CACHE(virt_to_page(objp));
>
> And on a good day gcc may optimize out all the double tests
> anyhow.
>

