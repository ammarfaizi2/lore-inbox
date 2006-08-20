Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWHTI0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWHTI0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 04:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWHTI0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 04:26:37 -0400
Received: from 1wt.eu ([62.212.114.60]:43024 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751483AbWHTI0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 04:26:37 -0400
Date: Sun, 20 Aug 2006 10:26:02 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820082602.GB602@1wt.eu>
References: <20060820003840.GA17249@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820003840.GA17249@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 04:38:40AM +0400, Solar Designer wrote:
> Willy and all,
> 
> Attached is a trivial patch (extracted from 2.4.33-ow1) that makes
> set*uid() kill the current process rather than proceed with -EAGAIN when
> the kernel is running out of memory.  Apparently, alloc_uid() can't fail
> and return anyway due to properties of the allocator, in which case the
> patch does not change a thing.  But better safe than sorry.

Whether it can fail or not, alloc_uid()'s author intent was to report its
problems via NULL :

                new = kmem_cache_alloc(uid_cachep, SLAB_KERNEL);
                if (!new)
                        return NULL;

So your change to set_user() are consistent with this design choice.
Now, chosing to kill the process whe the kernel runs out of memory
seems consistent with what will happen a few milliseconds later to
other processes anyway.

I'm just wondering why you return a SIGSEGV. When the kernel kills
tasks on OOM conditions, it sends either SIGTERM or SIGKILL, as we
can see here in mm/oom_kill.c:__oom_kill_task() :

        p->flags |= PF_MEMALLOC | PF_MEMDIE;
        /* This process has hardware access, be more careful. */
        if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
                force_sig(SIGTERM, p);
        } else {
                force_sig(SIGKILL, p);
        }

Shouldn't we simply re-use the same code ? (not the function, I would not
like to get OOM messages outside the OOM killer).

> As you're probably aware, 2.6 kernels are affected to a greater extent,
> where set*uid() may also fail on trying to exceed RLIMIT_NPROC.  That
> needs to be fixed, too.

I've followed the thread a little bit but am not aware of all the details.

> Opinions are welcome.
> 
> Thanks,
> 
> Alexander

What do you (and others) think about this ?
Willy


> diff -urpPX nopatch linux-2.4.33/kernel/sys.c linux/kernel/sys.c
> --- linux-2.4.33/kernel/sys.c	Fri Nov 28 21:26:21 2003
> +++ linux/kernel/sys.c	Wed Aug 16 05:19:21 2006
> @@ -514,8 +514,10 @@ static int set_user(uid_t new_ruid, int 
>  	struct user_struct *new_user;
>  
>  	new_user = alloc_uid(new_ruid);
> -	if (!new_user)
> +	if (!new_user) {
> +		force_sig(SIGSEGV, current);
>  		return -EAGAIN;
> +	}
>  	switch_uid(new_user);
>  
>  	if(dumpclear)

