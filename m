Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSGKTP5>; Thu, 11 Jul 2002 15:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSGKTP4>; Thu, 11 Jul 2002 15:15:56 -0400
Received: from dsl-213-023-020-056.arcor-ip.net ([213.23.20.56]:61859 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317874AbSGKTPt>;
	Thu, 11 Jul 2002 15:15:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: spinlock assertion macros
Date: Thu, 11 Jul 2002 21:17:44 +0200
X-Mailer: KMail [version 1.3.2]
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SWXm-0002BL-00@starship> <20020711180326.GH709072@sgi.com>
In-Reply-To: <20020711180326.GH709072@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17SjRh-0002VI-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 20:03, Jesse Barnes wrote:
> How about this?

It looks good, the obvious thing we don't get is what the actual lock
count is, and actually, we don't care because we know what it is in
this case.

> Are there simple *_is_locked() calls for the other
> mutex mechanisms?

I didn't look, but my guess is no and you're in for some reverse
engineering, or you could just ask Ben.

> If so, I could add those too...

Definitely needed.  Note there are both counting and mutex forms of
semaphore and they are actually the same primitive - this doesn't mean
the asserts should treat them the same.  That is, it doesn't make
sense to think of the counting form of semaphore in terms of lock
coverage, so actually, we're never interested in semaphore count
values other than 0 and 1,  the simple BUG_ON is all we need.  This
is nice, not only because it reads well, but because it doesn't
generate a lot of code.  This whole feature will be a lot more useful
if code size isn't a problem, in which case I'd tend to run with the
option enabled in the normal course of development.

> Thanks,
> Jesse
> 
> 
> diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/fs/inode.c linux-2.5.25-spinassert/fs/inode.c
> --- linux-2.5.25/fs/inode.c	Fri Jul  5 16:42:38 2002
> +++ linux-2.5.25-spinassert/fs/inode.c	Thu Jul 11 10:59:23 2002
> @@ -183,6 +183,8 @@
>   */
>  void __iget(struct inode * inode)
>  {
> +	MUST_HOLD(&inode_lock);
> +
>  	if (atomic_read(&inode->i_count)) {
>  		atomic_inc(&inode->i_count);
>  		return;
> diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/include/linux/spinlock.h linux-2.5.25-spinassert/include/linux/spinlock.h
> --- linux-2.5.25/include/linux/spinlock.h	Fri Jul  5 16:42:24 2002
> +++ linux-2.5.25-spinassert/include/linux/spinlock.h	Thu Jul 11 11:02:17 2002
> @@ -116,7 +116,19 @@
>  #define _raw_write_lock(lock)	(void)(lock) /* Not "unused variable". */
>  #define _raw_write_unlock(lock)	do { } while(0)
>  
> -#endif /* !SMP */
> +#endif /* !CONFIG_SMP */
> +
> +/*
> + * Simple lock assertions for debugging and documenting where locks need
> + * to be locked/unlocked.
> + */
> +#if defined(CONFIG_DEBUG_SPINLOCK) && defined(CONFIG_SMP)
> +#define MUST_HOLD(lock)		BUG_ON(!spin_is_locked(lock))
> +#define MUST_NOT_HOLD(lock)	BUG_ON(spin_is_locked(lock))
> +#else
> +#define MUST_HOLD(lock)		do { } while(0)
> +#define MUST_NOT_HOLD(lock)	do { } while(0)
> +#endif /* CONFIG_DEBUG_SPINLOCK && CONFIG_SMP */
>  
>  #ifdef CONFIG_PREEMPT
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Daniel
