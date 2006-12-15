Return-Path: <linux-kernel-owner+w=401wt.eu-S1752821AbWLOQ1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbWLOQ1r (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWLOQ1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:27:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48239 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbWLOQ1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:27:46 -0500
Date: Fri, 15 Dec 2006 17:24:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: + schedule_on_each_cpu-use-preempt_disable.patch added to -mm tree
Message-ID: <20061215162416.GB29191@elte.hu>
References: <200612150823.kBF8NV2u011171@shell0.pdx.osdl.net> <20061215083112.GB10687@elte.hu> <20061215081138.4c51e7c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215081138.4c51e7c5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > >  	for_each_online_cpu(cpu) {
> > >  		INIT_WORK(per_cpu_ptr(works, cpu), func);
> > >  		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
> > >  				per_cpu_ptr(works, cpu));
> > >  	}
> > > -	mutex_unlock(&workqueue_mutex);
> > > +	preempt_enable();
> > 
> > Why not cpu_hotplug_lock()?
> > 
> 
> Because the workqueue code was explicitly switched over to 
> per-subsystem cpu-hotplug locking.
> 
> Because lock_cpu_hotplug() is a complete turkey, source of deadlocks 
> and overall bad idea.

not in the locking model i outlined earlier, which would turn it into a 
read-lock in essence.

> This is actually a pretty simple problem.  A subsystem has per-cpu 
> reosurces, and it needs to lock them while using them.  duh.  We know 
> how to do that sort of thing.  But because the first implementation of 
> lock_cpu_hotplug() was conceived with magical properties, we seem to 
> think we need to retain magical properties.  We don't...

actually, we use two things here: cpu_online_map and the per-cpu keventd 
workqueues. cpu_online_map is pretty much attached to the CPU hotplug 
subsystem so it would be quite natural to use cpu_hotplug_read_lock() 
for that.

so i disagree that CPU hotplug locking should be per-subsystem. We 
should have one lightweight and scalable primitive that protects 
cpu_online_map use, and that same primitive can be used to protect other 
per-CPU resources too.

	Ingo
