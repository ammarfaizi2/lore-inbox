Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268525AbUHaNyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268525AbUHaNyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUHaNyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:54:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:21929 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268525AbUHaNyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:54:21 -0400
Date: Tue, 31 Aug 2004 15:54:20 +0200
From: Andi Kleen <ak@suse.de>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: davem@redhat.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       Dipankar <dipankar@in.ibm.com>, paulmck@us.ibm.com
Subject: Re: [RFC] Use RCU for tcp_ehash lookup
Message-ID: <20040831135419.GA17642@wotan.suse.de>
References: <20040831125941.GA5534@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831125941.GA5534@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 06:29:41PM +0530, Srivatsa Vaddagiri wrote:
> 
>   I would be interested to know if anyone has seen high-rate of lock contention
>   for hash bucket lock. Such workloads would benefit from the lock-free lookup.

I would suspect something that does IO from multiple threads over 
a single connection. However there is also the socket lock, which
may prevent too much parallelism.
> 
>   In the absence of any workload which resulted in lock contention, I resorted
>   to disabling NAPI and irq balance (noirqbalance) to study the effect of cache
>   bouncing on the lookup routine. The result was that CPU usage of the stack
>   was halved in lock-free case, which IMHO, is a strong enough reason for us
>   to consider this seriously.

Yes, sounds very nice.

I bet also when you just do rdtsc timing for the TCP receive
path the cycle numbers will be way down (excluding the copy).

And it should also fix the performance problems with
cat /proc/net/tcp on ppc64/ia64 for large hash tables because the rw locks 
are gone.

>   
> - I presume that one of the reasons for keeping the hash table so big is to
>   keep lock contention low (& to reduce the size of hash chains). If the lookup
>   is made lock-free, then could the size of the hash table be reduced (without
>   adversely impacting performance)?

Definitely worth trying IMHO. The current hash tables are far
too big. I would do that as followon patches though.

I haven't studied it in detail (yet), just two minor style 
comments: 


> -		sk_free(sk);
> +sp_loop:
> +	if (atomic_dec_and_test(&sk->sk_refcnt)) {
> +		/* Restore ref count and schedule callback.
> +		 * If we don't restore ref count, then the callback can be
> +		 * scheduled by more than one CPU.
> +		 */
> +		atomic_inc(&sk->sk_refcnt);
> +
> +		if (atomic_read(&sk->sk_refcnt) == 1)
> +			call_rcu(&sk->sk_rcu, sk_free_rcu);
> +		else
> +			goto sp_loop;
> +	}

Can you rewrite that without goto? 
> +tput_loop:
>  	if (atomic_dec_and_test(&tw->tw_refcnt)) {
> -#ifdef INET_REFCNT_DEBUG
> -		printk(KERN_DEBUG "tw_bucket %p released\n", tw);
> -#endif
> -		kmem_cache_free(tcp_timewait_cachep, tw);
> +		/* Restore ref count and schedule callback.
> +		 * If we don't restore ref count, then the callback can be
> +		 * scheduled by more than one CPU.
> +		 */
> +
> +		atomic_inc(&tw->tw_refcnt);
> +
> +		if (atomic_read(&tw->tw_refcnt) == 1)
> +			call_rcu(&tw->tw_rcu, tcp_tw_free);
> +		else
> +			goto tput_loop;

And that too.


-Andi
