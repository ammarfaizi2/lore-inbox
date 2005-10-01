Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVJASBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVJASBF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 14:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVJASBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 14:01:05 -0400
Received: from iron.cat.pdx.edu ([131.252.208.92]:17331 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1750728AbVJASBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 14:01:04 -0400
Date: Sat, 1 Oct 2005 11:00:28 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510011800.j91I0S3G012676@rastaban.cs.pdx.edu>
To: herbert@gondor.apana.org.au
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the spotlight leaving in_dev_get, we have the parallel question 
of in_dev_put() and __in_dev_put()  both defined with refcnt 
decrement, but the preceding underscore may lend itself to an
inadvertant pairing and refcnt inaccuracy.

In the following  cscope of linux-2.6.14-rc2 prior to Herbert's patches 
which remove the occurence in pktgen.c and the others are
paired with __in_dev_get_rtnl(), except xfrm4_policy.c():

C symbol: __in_dev_put
  File           Function              Line
  File           Function              Line
0 inetdevice.h   <global>               172 #define __in_dev_put(idev) atomic_dec(&(idev)->refcnt)
1 pktgen.c       pktgen_setup_inject   1687 __in_dev_put(in_dev);
2 devinet.c      inet_rtm_deladdr       412 __in_dev_put(in_dev);
3 igmp.c         igmp_gq_timer_expire   686 __in_dev_put(in_dev);
4 igmp.c         igmp_ifc_timer_expire  698 __in_dev_put(in_dev);
5 igmp.c         igmp_heard_query       801 __in_dev_put(in_dev);
6 igmp.c         ip_mc_down            1228 __in_dev_put(in_dev);
7 igmp.c         ip_mc_down            1231 __in_dev_put(in_dev);
8 igmp.c         ip_mc_find_dev        1310 __in_dev_put(idev);
9 xfrm4_policy.c xfrm4_dst_ifdown       280 __in_dev_put(loopback_idev);

It may not be reasonable to rename __in_dev_put for its parallel definition
since its current usage is with __in_dev_get_rtnl() which does not increment 
refcnt. 

It is also probably good to retain the old __in_dev_get() 
and __in_dev_put() and deprecate them.

Old business:  this is probably stating the obvious,
with Herbert's patches in place, none of the test patch
I'd submitted 8 Sept should take effect.

Thank you.
Suzanne

----- Original Message ----- 
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Sent: Saturday, October 01, 2005 12:12 AM

> On Fri, Sep 30, 2005 at 11:56:41PM -0700, Suzanne Wood wrote:
>> 
>> The other thing I'd hoped to address in pktgen.c was 
>> removing the __in_dev_put() which decrements refcnt 
>> while __in_dev_get_rcu() does not increment.
> 
> Well spotted.
> 
> Here is a patch on top of the last one to fix this bogus decrement.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

