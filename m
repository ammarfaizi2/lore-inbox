Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVJOCji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVJOCji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 22:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVJOCji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 22:39:38 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:8977 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751048AbVJOCjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 22:39:37 -0400
Date: Sat, 15 Oct 2005 12:39:18 +1000
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suzanne Wood <suzannew@cs.pdx.edu>
Subject: Re: [LIST] Add missing rcu_dereference on first element
Message-ID: <20051015023918.GA22074@gondor.apana.org.au>
References: <20051015002649.GA28555@gondor.apana.org.au> <20051015020324.GL1302@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051015020324.GL1302@us.ibm.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 07:03:25PM -0700, Paul E. McKenney wrote:
> 
> > diff --git a/include/linux/list.h b/include/linux/list.h
> > --- a/include/linux/list.h
> > +++ b/include/linux/list.h
> > @@ -442,12 +442,15 @@ static inline void list_splice_init(stru
> >   * as long as the traversal is guarded by rcu_read_lock().
> >   */
> >  #define list_for_each_rcu(pos, head) \
> > -	for (pos = (head)->next; prefetch(pos->next), pos != (head); \
> > -        	pos = rcu_dereference(pos->next))
> > +	for (pos = (head)->next; \
> > +		pos = rcu_dereference(pos), \
> > +			prefetch(pos->next), pos != (head); \
> > +        	pos = pos->next)
> 
> Why not something like the following?  Seems a bit simpler to me.
> 
> #define list_for_each_rcu(pos, head) \
> 	for (pos = rcu_dereference((head)->next); \
> 		prefetch(pos->next), pos != (head); \
>         	pos = rcu_dereference(pos->next))

In this case your version is indeed more concise.  However, in most of
the other for_each macros having it in the loop conditional looks more
natural.

So in order to be consistent throughout list.h, I'd like to keep the
rcu_dereference in the loop conditional.

> > @@ -492,8 +496,10 @@ static inline void list_splice_init(stru
> >   * as long as the traversal is guarded by rcu_read_lock().
> >   */
> >  #define list_for_each_continue_rcu(pos, head) \
> > -	for ((pos) = (pos)->next; prefetch((pos)->next), (pos) != (head); \
> > -        	(pos) = rcu_dereference((pos)->next))
> > +	for ((pos) = (pos)->next; \
> > +		(pos) = rcu_dereference((pos)), \
> > +			prefetch((pos)->next), (pos) != (head); \
> > +        	(pos) = (pos)->next)
> 
> The above hurts my head -- childhood trauma due to having to use a
> FORTRAN compiler that required "I=I" at odd intervals in order to
> generate correct code...  How about the following?
> 
> #define list_for_each_continue_rcu(pos, head) \
> 	for ((pos) = (pos)->next; \
> 		prefetch(rcu_dereference(pos)->next), (pos) != (head); \
>         	(pos) = (pos)->next)

I chose to keep it out of prefetch because normally the argument to
prefetch does not have any side-effects.  Even though today's prefetch
is an inline function which does respect side-effects, there is always
a possibility that someone somewhere might decide to implement prefetch
as a macro.

Besides, the expression

i = foo(i)

where foo has side-effects is pretty normal.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
