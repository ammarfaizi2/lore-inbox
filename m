Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUG2WvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUG2WvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUG2Wsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:48:39 -0400
Received: from gprs214-254.eurotel.cz ([160.218.214.254]:54915 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267514AbUG2Wqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:46:31 -0400
Date: Fri, 30 Jul 2004 00:44:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Per kthread freezer flags
Message-ID: <20040729224422.GG18623@elf.ucw.cz>
References: <1090999301.8316.12.camel@laptop.cunninghams> <20040729190438.GA468@openzaurus.ucw.cz> <1091139864.2703.24.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091139864.2703.24.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > -	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
> > > +	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", 0, pd->name);
> > >  	if (IS_ERR(pd->cdrw.thread)) {
> > >  		printk("pktcdvd: can't start kernel thread\n");
> > >  		ret = -ENOMEM;
> > 
> > What if someone does swapon /dev/pktdvd0?
> 
> Sorry. That's my ignorance. I thought the packet writer was only for
> writing :>

Well, swapon /dev/pktdvd would be *very* bad idea as optical drives
are very slow, but PF_NOFREEZE is more correct here.

> > > +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/drivers/md/dm-raid1.c	2004-07-28 16:48:44.000000000 +1000
> > > @@ -1238,7 +1238,7 @@
> > >  	if (r)
> > >  		return r;
> > >  
> > > -	_kmirrord_wq = create_workqueue("kmirrord");
> > > +	_kmirrord_wq = create_workqueue("kmirrord", PF_NOFREEZE);
> > >  	if (!_kmirrord_wq) {
> > >  		DMERR("couldn't start kmirrord");
> > >  		dm_dirty_log_exit();
> > 
> > 
> > I'm not 100% certain what kmirrord does, but we certainly do not
> > want raid array to be reconstructed while suspending.
> 
> Mmm. Again, I plead picking it based on what I thought the code did. Can
> we get an author to say which it should be? 

I'd make it stop to be safe, and see what happens ;-).

> > linux-2.6.8-rc1-mm1-kthread_refrigerator/fs/aio.c
> > > --- linux-2.6.8-rc1-mm1/fs/aio.c	2004-07-28 16:36:03.000000000 +1000
> > > +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/fs/aio.c	2004-07-28 16:43:48.000000000 +1000
> > > @@ -69,7 +69,7 @@
> > >  	kioctx_cachep = kmem_cache_create("kioctx", sizeof(struct kioctx),
> > >  				0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
> > >  
> > > -	aio_wq = create_workqueue("aio");
> > > +	aio_wq = create_workqueue("aio", PF_NOFREEZE);
> > >  
> > >  	pr_debug("aio_setup: sizeof(struct page) = %d\n", (int)sizeof(struct page));
> > >  
> > 
> > Are you sure? Unless swsusp itself uses aio, we want this to freeze.
> 
> I think it was needed to get the writes happening. Even if its wrong, it
> shouldn't matter as the only I/O pending should be what we're doing.

I'm little bit nervous about this one. I'd make it stop, and see if it
breaks... From quick look at aio.c it really does *not* seem we need this. 

> > > +++ linux-2.6.8-rc1-mm1-kthread_refrigerator/kernel/softirq.c	2004-07-28 16:43:48.000000000 +1000
> > > @@ -425,7 +425,7 @@
> > >  	case CPU_UP_PREPARE:
> > >  		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
> > >  		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
> > > -		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
> > > +		p = kthread_create(ksoftirqd, hcpu, 0, "ksoftirqd/%d", hotcpu);
> > >  		if (IS_ERR(p)) {
> > >  			printk("ksoftirqd for %i failed\n", hotcpu);
> > >  			return NOTIFY_BAD;
> > 
> > I guess softinterrupts may be neccessary for suspend... Random drivers may use
> > them, right?
> 
> I made this change at least a month ago and no one using suspend2 has
> had any problems since, so perhaps not. Then again, with the voluntary
> preemption (from what I've seen of comments about it) this would be a
> definite yes.

Ok.
									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
