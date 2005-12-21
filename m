Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVLUNim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVLUNim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVLUNim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:38:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:42389 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932414AbVLUNik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:38:40 -0500
Date: Wed, 21 Dec 2005 05:38:47 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Large thread wakeup (scheduling) delay spikes
Message-ID: <20051221133847.GB7613@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051220151722.GA357@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220151722.GA357@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 09:17:22AM -0600, Dimitri Sivanich wrote:
> I posted something about this back in October, but received little response.
> Maybe others have run into problems with this since then.
> 
> I've noticed much less deterministic and more widely varying thread wakeup
> (scheduling) delays on recent kernels.  Even with isolated processors, the
> maximum delay to wakeup has gotten much longer (configured with or without
> CONFIG_PREEMPT).

Interesting -- what workload are you running, and what mechanism are
you using to check scheduling delays?

What happens when you run this workload on a -rt kernel?

							Thanx, Paul

> The maximum delay to wakeup is now more than 10x longer than it was in
> 2.6.13.4 and previous kernels, and that's on isolated processors (as much
> as 300 usec on a 1GHz cpu), although nominal values remain largely unchanged.
> The latest version I've tested is 2.6.15-rc5.
> 
> Delving into this further I discovered that this is due to the execution
> time of file_free_rcu(), running from rcu_process_callbacks() in ksoftirqd.
> It appears that the modification that caused this was:
> 	http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ab2af1f5005069321c5d130f09cce577b03f43ef
> 
> By simply making the following change things return to more consistent
> thread wakeup delays on isolated cpus, similiar to what we had on kernels
> previous to the above mentioned mod (I know this change is incorrect,
> it is just for test purposes):
> 
> fs/file_table.c
> @@ -62,7 +62,7 @@
>  
>  static inline void file_free(struct file *f)
>  {
> -       call_rcu(&f->f_rcuhead, file_free_rcu);
> +       kmem_cache_free(filp_cachep, f);
>  }
>  
> 
> I am wondering if there is some way we can return to consistently fast
> and predictable scheduling of threads to be woken?  If not on the
> system in general, maybe at least on certain specified processors?
> 
> Dimitri
> 
