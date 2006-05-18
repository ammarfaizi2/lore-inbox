Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWERUF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWERUF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWERUF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:05:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751390AbWERUF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:05:28 -0400
Date: Thu, 18 May 2006 13:05:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, pj@sgi.com,
       ak@suse.de, linux-mm@kvack.org, garlick@llnl.gov, mgrondona@llnl.gov
Subject: Re: [PATCH] mm: avoid unnecessary OOM kills
Message-Id: <20060518130510.29444628.akpm@osdl.org>
In-Reply-To: <200605181729.k4IHToRU025597@calaveras.llnl.gov>
References: <200605181729.k4IHToRU025597@calaveras.llnl.gov>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
> Below is a 2.6.17-rc4-mm1 patch that fixes a problem where the OOM killer was
> unnecessarily killing system daemons in addition to memory-hogging user
> processes.  The patch fixes things so that the following assertion is
> satisfied:
> 
>     If a failed attempt to allocate memory triggers the OOM killer, then the
>     failed attempt must have occurred _after_ any process previously shot by
>     the OOM killer has cleaned out its mm_struct.
> 
> Thus we avoid situations where concurrent invocations of the OOM killer cause
> more processes to be shot than necessary to resolve the OOM condition.
> 
> ...
>
> --- linux-2.6.17-rc4-mm1.orig/include/linux/swap.h	2006-05-17 22:31:38.000000000 -0700
> +++ linux-2.6.17-rc4-mm1/include/linux/swap.h	2006-05-17 22:33:54.000000000 -0700
> @@ -155,6 +156,29 @@
>  #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
>  
>  /* linux/mm/oom_kill.c */
> +extern volatile unsigned long oom_kill_in_progress;

This shouldn't be volatile.

> +/*
> + * Attempt to start an OOM kill operation.  Return 0 on success, or 1 if an
> + * OOM kill is already in progress.
> + */
> +static inline int oom_kill_start(void)
> +{
> +	return test_and_set_bit(0, &oom_kill_in_progress);
> +}

Suggest this be called oom_kill_trystart().

> ===================================================================
> --- linux-2.6.17-rc4-mm1.orig/mm/oom_kill.c	2006-05-17 22:31:38.000000000 -0700
> +++ linux-2.6.17-rc4-mm1/mm/oom_kill.c	2006-05-17 22:33:54.000000000 -0700
> @@ -25,6 +25,8 @@
>  int sysctl_panic_on_oom;
>  /* #define DEBUG */
>  
> +volatile unsigned long oom_kill_in_progress = 0;

This shouldn't be initialised to zero.  The kernel zeroes bss at startup.

>  /**
>   * badness - calculate a numeric value for how bad this task has been
>   * @p: task struct of which task we should calculate
> @@ -260,27 +262,31 @@
>  	struct mm_struct *mm;
>  	task_t * g, * q;
>  
> +	task_lock(p);
>  	mm = p->mm;
>  
> -	/* WARNING: mm may not be dereferenced since we did not obtain its
> -	 * value from get_task_mm(p).  This is OK since all we need to do is
> -	 * compare mm to q->mm below.
> +	if (mm == NULL || mm == &init_mm) {
> +		task_unlock(p);
> +		return 1;
> +	}
> +
> +	set_bit(MM_FLAG_OOM_NOTIFY, &mm->flags);
> +	task_unlock(p);

Putting task_lock() in here would be a fairly obvious way to address the
fragility which that comment describes.  But I have a feeling that we
discussed that a couple of weeks ago and found a problem with it, didn't we?

> ===================================================================
> --- linux-2.6.17-rc4-mm1.orig/mm/page_alloc.c	2006-05-17 22:31:38.000000000 -0700
> +++ linux-2.6.17-rc4-mm1/mm/page_alloc.c	2006-05-17 22:33:54.000000000 -0700
> @@ -910,6 +910,36 @@
>  	return 1;
>  }
>  
> +/* Try to allocate one more time before invoking the OOM killer. */
> +static struct page * oom_alloc(gfp_t gfp_mask, unsigned int order,
> +		struct zonelist *zonelist)
> +{
> +	struct page *page;
> +
> +	/* The use of oom_kill_start() below prevents parallel OOM kill
> +	 * operations.  This fixes a problem where the OOM killer was observed
> +	 * shooting system daemons in addition to memory-hogging user
> +	 * processes.
> +	 */
> +	if (oom_kill_start())
> +		return NULL;  /* previous OOM kill still in progress */
> +
> +	/* If we get this far, we _know_ that any previous OOM killer victim
> +	 * has cleaned out its mm_struct.  Therefore we should pick a victim
> +	 * to shoot if the allocation below fails.
> +	 */
> +	page = get_page_from_freelist(gfp_mask | __GFP_HARDWALL, order,
> +			zonelist, ALLOC_WMARK_HIGH | ALLOC_CPUSET);
> +
> +	if (page) {
> +		oom_kill_finish();  /* cancel OOM kill operation */
> +		return page;
> +	}
> +
> +	out_of_memory(zonelist, gfp_mask, order);
> +	return NULL;
> +}
> +
>  /*
>   * get_page_from_freeliest goes through the zonelist trying to allocate
>   * a page.
> @@ -1116,18 +1146,8 @@
>  		if (page)
>  			goto got_pg;
>  	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
> -		/*
> -		 * Go through the zonelist yet one more time, keep
> -		 * very high watermark here, this is only to catch
> -		 * a parallel oom killing, we must fail if we're still
> -		 * under heavy pressure.
> -		 */
> -		page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
> -				zonelist, ALLOC_WMARK_HIGH|ALLOC_CPUSET);
> -		if (page)
> +		if ((page = oom_alloc(gfp_mask, order, zonelist)) != NULL)
>  			goto got_pg;
> -
> -		out_of_memory(zonelist, gfp_mask, order);
>  		goto restart;
>  	}

So if process A did a successful oom_kill_start(), and processes B, C, D
and E all get into difficulty as well, they'll go into busywait loops.  The
cond_resched() will eventually save us from locking up, but it's a bit
unpleasant.

And I'm trying to work out where process A will run oom_kill_finish() if
`cancel' ends up being 0 in out_of_memory().  afaict, it doesn't, and the
oom-killer will be accidentally disabled?

