Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTJSAWL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 20:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTJSAWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 20:22:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:18390 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261947AbTJSAWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 20:22:08 -0400
Date: Sat, 18 Oct 2003 17:21:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@digitalvampire.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6.0-test8 __might_sleep warnings on boot
Message-Id: <20031018172140.4968e273.akpm@osdl.org>
In-Reply-To: <87d6cuozm7.fsf@love-shack.home.digitalvampire.org>
References: <87he26p6pq.fsf@love-shack.home.digitalvampire.org>
	<20031018161439.484915f8.akpm@osdl.org>
	<87d6cuozm7.fsf@love-shack.home.digitalvampire.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@digitalvampire.org> wrote:
>
>         if (system_running)
>                 cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
>         else
>                 cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_ATOMIC);
>

I've already done this; didn't like it.

>         if (system_running)
>                 acquire_console_sem();
> 
>         /* ... */
> 
>         if (system_running)
>                 release_console_sem();

Ditto.

> --- linux-2.6.0-test8/kernel/sched.c~early_might_sleep	Sat Oct 18 11:54:24 2003
> +++ linux-2.6.0-test8/kernel/sched.c	Sat Oct 18 16:44:14 2003
> @@ -2847,8 +2847,12 @@ void __might_sleep(char *file, int line)
>  {
>  #if defined(in_atomic)
>  	static unsigned long prev_jiffy;	/* ratelimiting */
> +	extern int system_running;
>  
> -	if (in_atomic() || irqs_disabled()) {
> +	/* Don't print warnings until system_running is set.  This avoids
> +	   spurious warnings during boot before local_irq_enable() and
> +	   init_idle(). */
> +	if (system_running && (in_atomic() || irqs_disabled())) {
>  		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
>  			return;
>  		prev_jiffy = jiffies;

And ditto.  (Except declarations go in .h files, not in .c files).

Sigh.  We may as well use this approach I guess.

