Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267488AbUG2W1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267488AbUG2W1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267489AbUG2W1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:27:42 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:64395 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267488AbUG2W1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:27:07 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729190438.GA468@openzaurus.ucw.cz>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040729190438.GA468@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1091139864.2703.24.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 30 Jul 2004 08:24:24 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-07-30 at 05:04, Pavel Machek wrote:
> Hi!
> 
> > At the moment, all kthreads have PF_NOFREEZE set, meaning that they're
> > not refrigerated during a suspend. This isn't right for some threads.
> 
> Looks good, but see comments below.
> > --- linux-2.6.8-rc1-mm1/drivers/block/pktcdvd.c	2004-07-28 16:37:46.000000000 +1000
> > +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/drivers/block/pktcdvd.c	2004-07-28 16:59:22.000000000 +1000
> > @@ -2372,7 +2372,7 @@
> >  
> >  	pkt_init_queue(pd);
> >  
> > -	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
> > +	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", 0, pd->name);
> >  	if (IS_ERR(pd->cdrw.thread)) {
> >  		printk("pktcdvd: can't start kernel thread\n");
> >  		ret = -ENOMEM;
> 
> What if someone does swapon /dev/pktdvd0?

Sorry. That's my ignorance. I thought the packet writer was only for
writing :>

> > +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/drivers/md/dm-raid1.c	2004-07-28 16:48:44.000000000 +1000
> > @@ -1238,7 +1238,7 @@
> >  	if (r)
> >  		return r;
> >  
> > -	_kmirrord_wq = create_workqueue("kmirrord");
> > +	_kmirrord_wq = create_workqueue("kmirrord", PF_NOFREEZE);
> >  	if (!_kmirrord_wq) {
> >  		DMERR("couldn't start kmirrord");
> >  		dm_dirty_log_exit();
> 
> 
> I'm not 100% certain what kmirrord does, but we certainly do not
> want raid array to be reconstructed while suspending.

Mmm. Again, I plead picking it based on what I thought the code did. Can
we get an author to say which it should be? 

> linux-2.6.8-rc1-mm1-kthread_refrigerator/fs/aio.c
> > --- linux-2.6.8-rc1-mm1/fs/aio.c	2004-07-28 16:36:03.000000000 +1000
> > +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/fs/aio.c	2004-07-28 16:43:48.000000000 +1000
> > @@ -69,7 +69,7 @@
> >  	kioctx_cachep = kmem_cache_create("kioctx", sizeof(struct kioctx),
> >  				0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
> >  
> > -	aio_wq = create_workqueue("aio");
> > +	aio_wq = create_workqueue("aio", PF_NOFREEZE);
> >  
> >  	pr_debug("aio_setup: sizeof(struct page) = %d\n", (int)sizeof(struct page));
> >  
> 
> Are you sure? Unless swsusp itself uses aio, we want this to freeze.

I think it was needed to get the writes happening. Even if its wrong, it
shouldn't matter as the only I/O pending should be what we're doing.

> linux-2.6.8-rc1-mm1-kthread_refrigerator/kernel/sched.c	2004-07-28 16:43:48.000000000 +1000
> > @@ -3550,7 +3550,8 @@
> >  
> >  	switch (action) {
> >  	case CPU_UP_PREPARE:
> > -		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
> > +		p = kthread_create(migration_thread, hcpu, 0,
> > +				"migration/%d",cpu);
> >  		if (IS_ERR(p))
> >  			return NOTIFY_BAD;
> >  		p->flags |= PF_NOFREEZE;
> 
> Ugh, creating thread normally only to add PF_NOFREEZE 2 lines later
> looks bad.

Yes. Tunnel vision! Humble apologies.

> > +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/kernel/softirq.c	2004-07-28 16:43:48.000000000 +1000
> > @@ -425,7 +425,7 @@
> >  	case CPU_UP_PREPARE:
> >  		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
> >  		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
> > -		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
> > +		p = kthread_create(ksoftirqd, hcpu, 0, "ksoftirqd/%d", hotcpu);
> >  		if (IS_ERR(p)) {
> >  			printk("ksoftirqd for %i failed\n", hotcpu);
> >  			return NOTIFY_BAD;
> 
> I guess softinterrupts may be neccessary for suspend... Random drivers may use
> them, right?

I made this change at least a month ago and no one using suspend2 has
had any problems since, so perhaps not. Then again, with the voluntary
preemption (from what I've seen of comments about it) this would be a
definite yes.

Nigel

