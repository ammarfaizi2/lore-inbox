Return-Path: <linux-kernel-owner+w=401wt.eu-S1752801AbWLOQLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbWLOQLs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbWLOQLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:11:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49605 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752801AbWLOQLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:11:47 -0500
Date: Fri, 15 Dec 2006 08:11:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: + schedule_on_each_cpu-use-preempt_disable.patch added to -mm
 tree
Message-Id: <20061215081138.4c51e7c5.akpm@osdl.org>
In-Reply-To: <20061215083112.GB10687@elte.hu>
References: <200612150823.kBF8NV2u011171@shell0.pdx.osdl.net>
	<20061215083112.GB10687@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 09:31:12 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * akpm@osdl.org <akpm@osdl.org> wrote:
> 
> > -	mutex_lock(&workqueue_mutex);
> > +	preempt_disable();		/* CPU hotplug */
> >  	for_each_online_cpu(cpu) {
> >  		INIT_WORK(per_cpu_ptr(works, cpu), func);
> >  		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
> >  				per_cpu_ptr(works, cpu));
> >  	}
> > -	mutex_unlock(&workqueue_mutex);
> > +	preempt_enable();
> 
> Why not cpu_hotplug_lock()?
> 

Because the workqueue code was explicitly switched over to per-subsystem
cpu-hotplug locking.

Because lock_cpu_hotplug() is a complete turkey, source of deadlocks and
overall bad idea.

This is actually a pretty simple problem.  A subsystem has per-cpu reosurces,
and it needs to lock them while using them.  duh.  We know how to do that
sort of thing.  But because the first implementation of lock_cpu_hotplug()
was conceived with magical properties, we seem to think we need to retain
magical properties.  We don't...
