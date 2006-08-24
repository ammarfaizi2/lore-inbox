Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWHXLOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWHXLOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWHXLOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:14:05 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:63842 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751121AbWHXLOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:14:02 -0400
Date: Thu, 24 Aug 2006 13:13:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Gautham R Shenoy <ego@in.ibm.com>, rusty@rustcorp.com.au,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, mingo@elte.hu, davej@redhat.com,
       vatsa@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 2/4] Revert Changes to kernel/workqueue.c
Message-ID: <20060824111349.GB6868@osiris.boeblingen.de.ibm.com>
References: <20060824103043.GC2395@in.ibm.com> <20060824105100.GA6868@osiris.boeblingen.de.ibm.com> <20060824110306.GB3651@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824110306.GB3651@in.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:33:06PM +0530, Dipankar Sarma wrote:
> On Thu, Aug 24, 2006 at 12:51:00PM +0200, Heiko Carstens wrote:
> > > @@ -510,13 +515,11 @@ int schedule_on_each_cpu(void (*func)(vo
> > >  	if (!works)
> > >  		return -ENOMEM;
> > >  
> > > -	mutex_lock(&workqueue_mutex);
> > >  	for_each_online_cpu(cpu) {
> > >  		INIT_WORK(per_cpu_ptr(works, cpu), func, info);
> > >  		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
> > >  				per_cpu_ptr(works, cpu));
> > >  	}
> > > -	mutex_unlock(&workqueue_mutex);
> > >  	flush_workqueue(keventd_wq);
> > >  	free_percpu(works);
> > >  	return 0;
> > 
> > Removing this lock without adding a lock/unlock_cpu_hotplug seems wrong,
> > since this function is walking the cpu_online_map.
> 
> As long as you disable preemption and don't block the critical
> section should be safe from cpu hotplug. There is no need to 
> lock/unlock cpu hotplug.

What disables preemption here?
Ah.. you probably meant preempt_disable/enable instead of lock/unlock cpu
hotplug would be sufficient. True.
