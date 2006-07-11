Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWGKK3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWGKK3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWGKK3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:29:33 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:64272 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750955AbWGKK3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:29:32 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@osdl.org (Andrew Morton)
Subject: Re: [Patch 6/6] per task delay accounting taskstats interface: fix clone skbs for each listener
Cc: nagar@watson.ibm.com, linux-kernel@vger.kernel.org, jlan@sgi.com,
       csturtiv@sgi.com, pj@sgi.com, balbir@in.ibm.com, sekharan@us.ibm.com,
       hadi@cyberus.ca, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <20060711030524.39abc3d5.akpm@osdl.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G0FU2-0002oE-00@gondolin.me.apana.org.au>
Date: Tue, 11 Jul 2006 20:28:50 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> On Tue, 11 Jul 2006 00:36:39 -0400
> Shailabh Nagar <nagar@watson.ibm.com> wrote:
> 
>>       down_write(&listeners->sem);
>>       list_for_each_entry_safe(s, tmp, &listeners->list, list) {
>> -             ret = genlmsg_unicast(skb, s->pid);
>> +             skb_next = NULL;
>> +             if (!list_islast(&s->list, &listeners->list)) {
>> +                     skb_next = skb_clone(skb_cur, GFP_KERNEL);
> 
> If we do a GFP_KERNEL allocation with this semaphore held, and the
> oom-killer tries to kill something to satisfy the allocation, and the
> killed task gets stuck on that semaphore, I wonder of the box locks up.

We do GFP_KERNEL inside semaphores/mutexes in lots of places.  So if this
can deadlock with the oom-killer we probably should fix that, preferably
by having GFP_KERNEL fail in that case.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
