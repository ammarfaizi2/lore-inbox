Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVJPU5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVJPU5x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 16:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVJPU5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 16:57:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:28325 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751304AbVJPU5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 16:57:53 -0400
Date: Sun, 16 Oct 2005 13:58:36 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suzanne Wood <suzannew@cs.pdx.edu>
Subject: Re: [LIST] Add missing rcu_dereference on first element
Message-ID: <20051016205836.GB1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051015002649.GA28555@gondor.apana.org.au> <20051015020324.GL1302@us.ibm.com> <20051015023918.GA22074@gondor.apana.org.au> <20051015032241.GA3893@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051015032241.GA3893@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 01:22:41PM +1000, Herbert Xu wrote:
> Hi Paul:
> 
> On Sat, Oct 15, 2005 at 12:39:18PM +1000, herbert wrote:
> > 
> > Besides, the expression
> > 
> > i = foo(i)
> > 
> > where foo has side-effects is pretty normal.
> 
> Actually I've changed my mind on this.  I think your version is
> better because the side-effect of rcu_dereference will cause the
> above assignment to occur twice when i refers to a memory-backed
> variable.
> 
> Since all current prefetch implementations are safe as far as
> side-effects are concerned, here is an updated version that
> doesn't do i = foo(i).
> 
> Andrew, please replace the previous version with this.

Looks great to me!

						Thanx, Paul

Acked-by: <paulmck@us.ibm.com>

> Thanks,
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

> diff --git a/include/linux/list.h b/include/linux/list.h
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -442,12 +442,14 @@ static inline void list_splice_init(stru
>   * as long as the traversal is guarded by rcu_read_lock().
>   */
>  #define list_for_each_rcu(pos, head) \
> -	for (pos = (head)->next; prefetch(pos->next), pos != (head); \
> -        	pos = rcu_dereference(pos->next))
> +	for (pos = (head)->next; \
> +		prefetch(rcu_dereference(pos)->next), pos != (head); \
> +        	pos = pos->next)
>  
>  #define __list_for_each_rcu(pos, head) \
> -	for (pos = (head)->next; pos != (head); \
> -        	pos = rcu_dereference(pos->next))
> +	for (pos = (head)->next; \
> +		rcu_dereference(pos) != (head); \
> +        	pos = pos->next)
>  
>  /**
>   * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
> @@ -461,8 +463,9 @@ static inline void list_splice_init(stru
>   * as long as the traversal is guarded by rcu_read_lock().
>   */
>  #define list_for_each_safe_rcu(pos, n, head) \
> -	for (pos = (head)->next, n = pos->next; pos != (head); \
> -		pos = rcu_dereference(n), n = pos->next)
> +	for (pos = (head)->next; \
> +		n = rcu_dereference(pos)->next, pos != (head); \
> +		pos = n)
>  
>  /**
>   * list_for_each_entry_rcu	-	iterate over rcu list of given type
> @@ -474,11 +477,11 @@ static inline void list_splice_init(stru
>   * the _rcu list-mutation primitives such as list_add_rcu()
>   * as long as the traversal is guarded by rcu_read_lock().
>   */
> -#define list_for_each_entry_rcu(pos, head, member)			\
> -	for (pos = list_entry((head)->next, typeof(*pos), member);	\
> -	     prefetch(pos->member.next), &pos->member != (head); 	\
> -	     pos = rcu_dereference(list_entry(pos->member.next, 	\
> -					typeof(*pos), member)))
> +#define list_for_each_entry_rcu(pos, head, member) \
> +	for (pos = list_entry((head)->next, typeof(*pos), member); \
> +		prefetch(rcu_dereference(pos)->member.next), \
> +			&pos->member != (head); \
> +		pos = list_entry(pos->member.next, typeof(*pos), member))
>  
>  
>  /**
> @@ -492,8 +495,9 @@ static inline void list_splice_init(stru
>   * as long as the traversal is guarded by rcu_read_lock().
>   */
>  #define list_for_each_continue_rcu(pos, head) \
> -	for ((pos) = (pos)->next; prefetch((pos)->next), (pos) != (head); \
> -        	(pos) = rcu_dereference((pos)->next))
> +	for ((pos) = (pos)->next; \
> +		prefetch(rcu_dereference((pos))->next), (pos) != (head); \
> +        	(pos) = (pos)->next)
>  
>  /*
>   * Double linked lists with a single pointer list head.
> @@ -696,8 +700,9 @@ static inline void hlist_add_after_rcu(s
>  	     pos = n)
>  
>  #define hlist_for_each_rcu(pos, head) \
> -	for ((pos) = (head)->first; pos && ({ prefetch((pos)->next); 1; }); \
> -		(pos) = rcu_dereference((pos)->next))
> +	for ((pos) = (head)->first; \
> +		rcu_dereference((pos)) && ({ prefetch((pos)->next); 1; }); \
> +		(pos) = (pos)->next)
>  
>  /**
>   * hlist_for_each_entry	- iterate over list of given type
> @@ -762,9 +767,9 @@ static inline void hlist_add_after_rcu(s
>   */
>  #define hlist_for_each_entry_rcu(tpos, pos, head, member)		 \
>  	for (pos = (head)->first;					 \
> -	     pos && ({ prefetch(pos->next); 1;}) &&			 \
> +	     rcu_dereference(pos) && ({ prefetch(pos->next); 1;}) &&	 \
>  		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
> -	     pos = rcu_dereference(pos->next))
> +	     pos = pos->next)
>  
>  #else
>  #warning "don't include kernel headers in userspace"

