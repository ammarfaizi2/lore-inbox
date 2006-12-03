Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760052AbWLCUCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760052AbWLCUCo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 15:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760055AbWLCUCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 15:02:43 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:62860 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1760052AbWLCUCn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 15:02:43 -0500
Date: Sun, 3 Dec 2006 23:01:53 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? rcu_do_batch: fix a pure theoretical memory ordering race
Message-ID: <20061203200153.GA107@oleg>
References: <20061202212517.GA1199@oleg> <45730AAD.1050006@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45730AAD.1050006@cosmosbay.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03, Eric Dumazet wrote:
>
> Oleg Nesterov a ?crit :
> >On top of rcu-add-a-prefetch-in-rcu_do_batch.patch
> >
> >rcu_do_batch:
> >
> >	struct rcu_head *next, *list;
> >
> >	while (list) {
> >		next = list->next;	<------ [1]
> >		list->func(list);
> >		list = next;
> >	}
> >
> >We can't trust *list after list->func() call, that is why we load 
> >list->next
> >beforehand. However I suspect in theory this is not enough, suppose that
> >
> >	- [1] is stalled
> >
> >	- list->func() marks *list as unused in some way
> >
> >	- another CPU re-uses this rcu_head and dirties it
> >
> >	- [1] completes and gets a wrong result
> >
> >This means we need a barrier in between. mb() looks more suitable, but I 
> >think
> >rmb() should suffice.
> >
> 
> Well, hopefully the "list->func()" MUST do the right thing [*], so your 
> patch is not necessary.

Yes, I don't claim it is necessary, note the "pure theoretical".

> For example, most structures are freed with kfree()/kmem_cache_free() and 
> these functions MUST imply an smp_mb() [if/when exchanging data with other 
> cpus], or else many uses in the kernel should be corrected as well.

Yes, mb() is enough (wmb() isn't) and kfree()/kmem_cache_free() are ok.
And I don't know any example of "unsafe" code in that sense.

However I believe it is easy to make the code which is correct from the
RCU's API pov, but unsafe.

Oleg.

