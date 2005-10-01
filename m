Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVJASD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVJASD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 14:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVJASD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 14:03:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:17540 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750762AbVJASD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 14:03:56 -0400
Date: Sat, 1 Oct 2005 11:04:41 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Suzanne Wood <suzannew@cs.pdx.edu>, Robert.Olsson@data.slu.se,
       davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20051001180441.GA1578@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200510010656.j916ufhT007410@rastaban.cs.pdx.edu> <20051001071248.GA15990@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051001071248.GA15990@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 05:12:48PM +1000, Herbert Xu wrote:
> On Fri, Sep 30, 2005 at 11:56:41PM -0700, Suzanne Wood wrote:
> > 
> > But it is interesting to have discarded what was developed yesterday
> > to minimize rcu_dereference impact:
> >
> > >> ----- Original message  -----
> > >> From: Herbert Xu <herbert@gondor.apana.org.au>
> > >> Date: Fri, 30 Sep 2005 11:19:07 +1000
> > >> 
> > >> On Thu, Sep 29, 2005 at 06:16:03PM -0700, Paul E. McKenney wrote:
> > >>> 
> > >>> OK, how about this instead?
> > >>> 
> > >>> rcu_read_lock();
> > >>> in_dev = dev->ip_ptr;
> > >>> if (in_dev) {
> > >>> atomic_inc(&rcu_dereference(in_dev)->refcnt);
> > >>> }
> > >>> rcu_read_unlock();
> > >>> return in_dev;
> > >> 
> > >> Looks great. 
> > 
> > while adding a function call level by wrapping  __in_dev_get_rcu
> > with in_dev_get as suggested here.
> 
> It might look different, but it should compile to the same result.
> GCC should be smart enough to combine the two branches and produce a
> memory barrier only when in_dev is not NULL.
>  
> > The other thing I'd hoped to address in pktgen.c was 
> > removing the __in_dev_put() which decrements refcnt 
> > while __in_dev_get_rcu() does not increment.
> 
> Well spotted.
> 
> Here is a patch on top of the last one to fix this bogus decrement.

Both this and Herbert's prior patch look good to me!

							Thanx, Paul

> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Thanks,
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -1673,7 +1673,6 @@ static void pktgen_setup_inject(struct p
>  					pkt_dev->saddr_min = in_dev->ifa_list->ifa_address;
>  					pkt_dev->saddr_max = pkt_dev->saddr_min;
>  				}
> -				__in_dev_put(in_dev);	
>  			}
>  			rcu_read_unlock();
>  		}

