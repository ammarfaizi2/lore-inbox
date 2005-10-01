Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVJAHNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVJAHNP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVJAHNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:13:15 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:59396 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750760AbVJAHNP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:13:15 -0400
Date: Sat, 1 Oct 2005 17:12:48 +1000
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20051001071248.GA15990@gondor.apana.org.au>
References: <200510010656.j916ufhT007410@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <200510010656.j916ufhT007410@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 30, 2005 at 11:56:41PM -0700, Suzanne Wood wrote:
> 
> But it is interesting to have discarded what was developed yesterday
> to minimize rcu_dereference impact:
>
> >> ----- Original message  -----
> >> From: Herbert Xu <herbert@gondor.apana.org.au>
> >> Date: Fri, 30 Sep 2005 11:19:07 +1000
> >> 
> >> On Thu, Sep 29, 2005 at 06:16:03PM -0700, Paul E. McKenney wrote:
> >>> 
> >>> OK, how about this instead?
> >>> 
> >>> rcu_read_lock();
> >>> in_dev = dev->ip_ptr;
> >>> if (in_dev) {
> >>> atomic_inc(&rcu_dereference(in_dev)->refcnt);
> >>> }
> >>> rcu_read_unlock();
> >>> return in_dev;
> >> 
> >> Looks great. 
> 
> while adding a function call level by wrapping  __in_dev_get_rcu
> with in_dev_get as suggested here.

It might look different, but it should compile to the same result.
GCC should be smart enough to combine the two branches and produce a
memory barrier only when in_dev is not NULL.
 
> The other thing I'd hoped to address in pktgen.c was 
> removing the __in_dev_put() which decrements refcnt 
> while __in_dev_get_rcu() does not increment.

Well spotted.

Here is a patch on top of the last one to fix this bogus decrement.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1673,7 +1673,6 @@ static void pktgen_setup_inject(struct p
 					pkt_dev->saddr_min = in_dev->ifa_list->ifa_address;
 					pkt_dev->saddr_max = pkt_dev->saddr_min;
 				}
-				__in_dev_put(in_dev);	
 			}
 			rcu_read_unlock();
 		}

--2fHTh5uZTiUOsy+g--
