Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUG2Ups@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUG2Ups (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUG2UnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:43:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52888 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265256AbUG2Uj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:39:57 -0400
Date: Thu, 29 Jul 2004 21:04:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Per kthread freezer flags
Message-ID: <20040729190438.GA468@openzaurus.ucw.cz>
References: <1090999301.8316.12.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090999301.8316.12.camel@laptop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> At the moment, all kthreads have PF_NOFREEZE set, meaning that they're
> not refrigerated during a suspend. This isn't right for some threads.

Looks good, but see comments below.



> --- linux-2.6.8-rc1-mm1/drivers/block/pktcdvd.c	2004-07-28 16:37:46.000000000 +1000
> +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/drivers/block/pktcdvd.c	2004-07-28 16:59:22.000000000 +1000
> @@ -2372,7 +2372,7 @@
>  
>  	pkt_init_queue(pd);
>  
> -	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
> +	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", 0, pd->name);
>  	if (IS_ERR(pd->cdrw.thread)) {
>  		printk("pktcdvd: can't start kernel thread\n");
>  		ret = -ENOMEM;

What if someone does swapon /dev/pktdvd0?


> +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/drivers/md/dm-raid1.c	2004-07-28 16:48:44.000000000 +1000
> @@ -1238,7 +1238,7 @@
>  	if (r)
>  		return r;
>  
> -	_kmirrord_wq = create_workqueue("kmirrord");
> +	_kmirrord_wq = create_workqueue("kmirrord", PF_NOFREEZE);
>  	if (!_kmirrord_wq) {
>  		DMERR("couldn't start kmirrord");
>  		dm_dirty_log_exit();


I'm not 100% certain what kmirrord does, but we certainly do not
want raid array to be reconstructed while suspending.



linux-2.6.8-rc1-mm1-kthread_refrigerator/fs/aio.c
> --- linux-2.6.8-rc1-mm1/fs/aio.c	2004-07-28 16:36:03.000000000 +1000
> +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/fs/aio.c	2004-07-28 16:43:48.000000000 +1000
> @@ -69,7 +69,7 @@
>  	kioctx_cachep = kmem_cache_create("kioctx", sizeof(struct kioctx),
>  				0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
>  
> -	aio_wq = create_workqueue("aio");
> +	aio_wq = create_workqueue("aio", PF_NOFREEZE);
>  
>  	pr_debug("aio_setup: sizeof(struct page) = %d\n", (int)sizeof(struct page));
>  

Are you sure? Unless swsusp itself uses aio, we want this to freeze.


linux-2.6.8-rc1-mm1-kthread_refrigerator/kernel/sched.c	2004-07-28 16:43:48.000000000 +1000
> @@ -3550,7 +3550,8 @@
>  
>  	switch (action) {
>  	case CPU_UP_PREPARE:
> -		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
> +		p = kthread_create(migration_thread, hcpu, 0,
> +				"migration/%d",cpu);
>  		if (IS_ERR(p))
>  			return NOTIFY_BAD;
>  		p->flags |= PF_NOFREEZE;

Ugh, creating thread normally only to add PF_NOFREEZE 2 lines later
looks bad.

> +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/kernel/softirq.c	2004-07-28 16:43:48.000000000 +1000
> @@ -425,7 +425,7 @@
>  	case CPU_UP_PREPARE:
>  		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
>  		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
> -		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
> +		p = kthread_create(ksoftirqd, hcpu, 0, "ksoftirqd/%d", hotcpu);
>  		if (IS_ERR(p)) {
>  			printk("ksoftirqd for %i failed\n", hotcpu);
>  			return NOTIFY_BAD;

I guess softinterrupts may be neccessary for suspend... Random drivers may use
them, right?


				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

