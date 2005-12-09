Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVLISCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVLISCo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVLISCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:02:44 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:26569 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751283AbVLISCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:02:43 -0500
Message-ID: <4399D852.47E0BB4E@tv-sign.ru>
Date: Fri, 09 Dec 2005 22:17:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
References: <439889FA.BB08E5E1@tv-sign.ru> <20051209024623.GA14844@in.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> 
> On Thu, Dec 08, 2005 at 10:31:06PM +0300, Oleg Nesterov wrote:
> > I can't see how this change can prevent idle cpus to be included in
> > ->cpumask, cpu can add itself to nohz_cpu_mask right after some other
> > cpu started new grace period.
> 
> Yes that can happen, but if they check for rcu_pending right after that
> it will prevent them from going tickless atleast (which will prevent grace
> periods from being unnecessarily extended). Something like below:
> 
>         CPU0                                    CPU1
> 
>         rcp->cur++;     /* New GP */
> 
>         smp_mb();

I think I need some education on memory barriers.

Does this mb() garantees that the new value of ->cur will be visible
on other cpus immediately after smp_mb() (so that rcu_pending() will
notice it) ?

My understanding is that it only garantees that all stores before it
must be visible before any store after mb. (yes, mb implies rmb, but
I think it does not matter if CPU1 adds itself to nonhz mask after
CPU0 reads nohz_cpu_mask). This means that CPU1 can read the stale
value of ->cur. I guess I am wrong, but I can't prove it to myself.

Could you please clarify this?

Even simpler question:

CPU0
	var = 1;
	wmb();

after that CPU1 does rmb().

Does it garantees that CPU1 will see the new value of var?

> Ideally we would have needed a smp_mb() in CPU1 also between setting CPU1
> in nohz_cpu_mask and checking for rcu_pending(), but I guess it is not needed
> in s390 because of its strong ordering?

I don't know, but please note that s390's definition of smp_mb__after_atomic_inc()
is not a 'nop'.

Oleg.
