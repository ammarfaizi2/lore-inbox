Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVJAG5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVJAG5I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 02:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVJAG5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 02:57:08 -0400
Received: from lead.cat.pdx.edu ([131.252.208.91]:17336 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1750755AbVJAG5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 02:57:06 -0400
Date: Fri, 30 Sep 2005 23:56:41 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510010656.j916ufhT007410@rastaban.cs.pdx.edu>
To: herbert@gondor.apana.org.au
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       suzannew@cs.pdx.edu, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks for addressing this issue.

----- Original Message ----- 
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Date: Sat, 1 Oct 2005 11:13:12 +1000
> 
> On Thu, Sep 29, 2005 at 06:06:50PM -0700, Suzanne Wood wrote:
>> 
>> Are there three cases then?  RCU protection with refcnt, RCU without refcnt,
>> and the bare cast of the dereference? 
> 
> Correct.
> 
> The following patch renames __in_dev_get() to __in_dev_get_rtnl() and
> introduces __in_dev_get_rcu() to cover the second case.
> 
> 1) RCU with refcnt should use in_dev_get().
> 2) RCU without refcnt should use __in_dev_get_rcu().
> 3) All others must hold RTNL and use __in_dev_get_rtnl().
> 

The naming to indicate purpose looks good and the leading underscores
in the prior work did seem to imply wrapping to add functionality.

But it is interesting to have discarded what was developed yesterday
to minimize rcu_dereference impact:

>> ----- Original message  -----
>> From: Herbert Xu <herbert@gondor.apana.org.au>
>> Date: Fri, 30 Sep 2005 11:19:07 +1000
>> 
>> On Thu, Sep 29, 2005 at 06:16:03PM -0700, Paul E. McKenney wrote:
>>> 
>>> OK, how about this instead?
>>> 
>>> rcu_read_lock();
>>> in_dev = dev->ip_ptr;
>>> if (in_dev) {
>>> atomic_inc(&rcu_dereference(in_dev)->refcnt);
>>> }
>>> rcu_read_unlock();
>>> return in_dev;
>> 
>> Looks great. 

while adding a function call level by wrapping  __in_dev_get_rcu
with in_dev_get as suggested here.

> -- 
> diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
> --- a/include/linux/inetdevice.h
> +++ b/include/linux/inetdevice.h
> @@ -142,13 +142,21 @@ static __inline__ int bad_mask(u32 mask,
> 
> #define endfor_ifa(in_dev) }
> 
> +static inline struct in_device *__in_dev_get_rcu(const struct net_device *dev)
> +{
> + struct in_device *in_dev = dev->ip_ptr;
> + if (in_dev)
> + in_dev = rcu_dereference(in_dev);
> + return in_dev;
> +}
> +
> static __inline__ struct in_device *
> in_dev_get(const struct net_device *dev)
> {
>  struct in_device *in_dev;
> 
>  rcu_read_lock();
> - in_dev = dev->ip_ptr;
> + in_dev = __in_dev_get_rcu(dev);
>  if (in_dev)
>  atomic_inc(&in_dev->refcnt);
>  rcu_read_unlock();
> @@ -156,7 +164,7 @@ in_dev_get(const struct net_device *dev)
> }
> 
> static __inline__ struct in_device *
> -__in_dev_get(const struct net_device *dev)
> +__in_dev_get_rtnl(const struct net_device *dev)
> {
>  return (struct in_device*)dev->ip_ptr;
> }

The other thing I'd hoped to address in pktgen.c was 
removing the __in_dev_put() which decrements refcnt 
while __in_dev_get_rcu() does not increment.

> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -1667,7 +1667,7 @@ static void pktgen_setup_inject(struct p
>  struct in_device *in_dev; 
> 
>  rcu_read_lock();
> - in_dev = __in_dev_get(pkt_dev->odev);
> + in_dev = __in_dev_get_rcu(pkt_dev->odev);
>  if (in_dev) {
>  if (in_dev->ifa_list) {
>  pkt_dev->saddr_min = in_dev->ifa_list->ifa_address;

     pkt_dev->saddr_max = pkt_dev->saddr_min;
    }
-   __in_dev_put(in_dev); 
   }
   rcu_read_unlock();

Thank you very much again for resolving this by clarifying both the 
RCU and RTNL usages.
