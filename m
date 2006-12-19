Return-Path: <linux-kernel-owner+w=401wt.eu-S1751684AbWLSNVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWLSNVM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 08:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWLSNVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 08:21:12 -0500
Received: from mx2.go2.pl ([193.17.41.42]:49674 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751684AbWLSNVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 08:21:11 -0500
Date: Tue, 19 Dec 2006 14:22:09 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] lockdep: more unlock-on-error fixes, fix
Message-ID: <20061219132209.GA4139@ff.dom.local>
References: <20061218115632.GA5373@ff.dom.local> <20061218143936.GA4415@elte.hu> <20061219095047.GA2694@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219095047.GA2694@elte.hu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 10:50:47AM +0100, Ingo Molnar wrote:
...
> moving the graph unlock back, and by leaving the max_lockdep_depth
> variable update possibly racy. (we dont care, it's just statistics)

I would agree if it were not the lockdep.
I mean it's like the "father figure"!

> also add some minimal debugging code to graph_unlock()/graph_lock(), 
> which caught this locking bug.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/lockdep.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Index: linux/kernel/lockdep.c
> ===================================================================
> --- linux.orig/kernel/lockdep.c
> +++ linux/kernel/lockdep.c
> @@ -70,6 +70,9 @@ static int graph_lock(void)
>  
>  static inline int graph_unlock(void)
>  {
> +	if (debug_locks && !__raw_spin_is_locked(&lockdep_lock))
> +		return DEBUG_LOCKS_WARN_ON(1);
> +
>  	__raw_spin_unlock(&lockdep_lock);
>  	return 0;
>  }
> @@ -716,6 +719,9 @@ find_usage_backwards(struct lock_class *
>  	struct lock_list *entry;
>  	int ret;
>  
> +	if (!__raw_spin_is_locked(&lockdep_lock))
> +		return DEBUG_LOCKS_WARN_ON(1);
> +
>  	if (depth > max_recursion_depth)
>  		max_recursion_depth = depth;
>  	if (depth >= RECURSION_LIMIT)
> @@ -2208,6 +2214,7 @@ out_calc_hash:
>  		if (!chain_head && ret != 2)
>  			if (!check_prevs_add(curr, hlock))
>  				return 0;
> +		graph_unlock();
>  	} else
>  		/* after lookup_chain_cache(): */
>  		if (unlikely(!debug_locks))

Probably similar changes should be done in
debug_locks_off_graph_unlock() etc.

I think it's going slightly complicated - there is
hard to say where and when the lock is really on. 
Maybe graph_lock needs some rethinking?

My proposal is to do unconditional locking in
graph_lock() and always check its return value e.g.:

if (!graph_lock()) {
	graph_unlock();
	return 0;
}

It is clear and gives some place for exceptions.
 
Jarek P.

PS: thanks for this followup_to info!
