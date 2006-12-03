Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758246AbWLCRjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758246AbWLCRjc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 12:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758255AbWLCRjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 12:39:32 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:2008 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1758246AbWLCRjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 12:39:32 -0500
Date: Sun, 03 Dec 2006 18:34:37 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: PATCH? rcu_do_batch: fix a pure theoretical memory ordering race
In-reply-to: <20061202212517.GA1199@oleg>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Message-id: <45730AAD.1050006@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <20061202212517.GA1199@oleg>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov a écrit :
> On top of rcu-add-a-prefetch-in-rcu_do_batch.patch
> 
> rcu_do_batch:
> 
> 	struct rcu_head *next, *list;
> 
> 	while (list) {
> 		next = list->next;	<------ [1]
> 		list->func(list);
> 		list = next;
> 	}
> 
> We can't trust *list after list->func() call, that is why we load list->next
> beforehand. However I suspect in theory this is not enough, suppose that
> 
> 	- [1] is stalled
> 
> 	- list->func() marks *list as unused in some way
> 
> 	- another CPU re-uses this rcu_head and dirties it
> 
> 	- [1] completes and gets a wrong result
> 
> This means we need a barrier in between. mb() looks more suitable, but I think
> rmb() should suffice.
> 

Well, hopefully the "list->func()" MUST do the right thing [*], so your patch 
is not necessary.

For example, most structures are freed with kfree()/kmem_cache_free() and 
these functions MUST imply an smp_mb() [if/when exchanging data with other 
cpus], or else many uses in the kernel should be corrected as well.


[*] : In particular, slab code managment does something special when 
transfering local objects from local cpu A store to 'other cpus B'.
Other mechanisms should also use some kind of memory barrier in order to 
transfer an object to another cpu too, or you could imagine in flight stores 
from CPU A overwriting an object that was 'given' to CPU B.

