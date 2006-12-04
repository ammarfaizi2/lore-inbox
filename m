Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937117AbWLDQmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937117AbWLDQmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937120AbWLDQmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:42:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:33206 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937118AbWLDQme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:42:34 -0500
Date: Mon, 4 Dec 2006 08:43:53 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? rcu_do_batch: fix a pure theoretical memory ordering race
Message-ID: <20061204164353.GA1793@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061202212517.GA1199@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061202212517.GA1199@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 12:25:17AM +0300, Oleg Nesterov wrote:
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

The memory allocators are required to do whatever is required to
ensure that the first CPU is no longer accessing the memory before
allocating it to the second CPU.

So we should not need to do this -- and if we did, we would have
serious problems throughout the kernel.

							Thanx, Paul

> 	- [1] completes and gets a wrong result
> 
> This means we need a barrier in between. mb() looks more suitable, but I think
> rmb() should suffice.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 19-rc6/kernel/rcupdate.c~rdp	2006-12-02 20:46:03.000000000 +0300
> +++ 19-rc6/kernel/rcupdate.c	2006-12-02 21:04:12.000000000 +0300
> @@ -236,6 +236,8 @@ static void rcu_do_batch(struct rcu_data
>  	list = rdp->donelist;
>  	while (list) {
>  		next = list->next;
> +		/* complete the load above before we call ->func() */
> +		smp_rmb();
>  		prefetch(next);
>  		list->func(list);
>  		list = next;
> 
