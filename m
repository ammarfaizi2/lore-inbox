Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbWI2HwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWI2HwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 03:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWI2HwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 03:52:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:35304 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030404AbWI2HwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 03:52:22 -0400
Subject: Re: [Lse-tech] [RFC][PATCH 05/10] Task watchers v2 Register cpuset
	task watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: sekharan@us.ibm.com, jtk@us.ibm.com, jes@sgi.com,
       linux-kernel@vger.kernel.org, linux-audit@redhat.com,
       viro@zeniv.linux.org.uk, lse-tech@lists.sourceforge.net,
       sgrubb@redhat.com, hch@lst.de
In-Reply-To: <20060928193138.963c510a.pj@sgi.com>
References: <20060929020232.756637000@us.ibm.com>
	 <20060929021300.851205000@us.ibm.com>  <20060928193138.963c510a.pj@sgi.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 29 Sep 2006 00:52:18 -0700
Message-Id: <1159516338.3286.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 19:31 -0700, Paul Jackson wrote:
> Matt wrote:
> 
> > -	cpuset_fork(p);
> >  #ifdef CONFIG_NUMA
> >   	p->mempolicy = mpol_copy(p->mempolicy);
> >   	if (IS_ERR(p->mempolicy)) {
> >   		retval = PTR_ERR(p->mempolicy);
> >   		p->mempolicy = NULL;
> > - 		goto bad_fork_cleanup_cpuset;
> > + 		goto bad_fork_cleanup_delays_binfmt;
> >   	}
> >  	mpol_fix_fork_child_flag(p);
> >  #endif
> >  #ifdef CONFIG_TRACE_IRQFLAGS
> >  	p->irq_events = 0;
> > @@ -1280,13 +1278,11 @@ bad_fork_cleanup_files:
> >  bad_fork_cleanup_security:
> >  	security_task_free(p);
> >  bad_fork_cleanup_policy:
> >  #ifdef CONFIG_NUMA
> >  	mpol_free(p->mempolicy);
> > -bad_fork_cleanup_cpuset:
> >  #endif
> > -	cpuset_exit(p);
> >  bad_fork_cleanup_delays_binfmt:
> 
> 
> The above code, before your change, had the affect that if mpol_copy()
> failed, then the cpusets that were just setup by the cpuset_fork()
> call were undone by a cpuset_exit() call.
> 
> >From what I can tell, after your change, this is no longer done,
> and a failed mpol_copy will leave cpusets in an incorrect state.
> 
> Am I missing something?
> 

If you look in the first patch there's a corresponding
notify_task_watchers(WATCH_TASK_FREE, tsk) below when we get a failure
from INIT. That in turn calls cpuset_exit() because a cpuset_exit()
because a hunk of this patch marks it for execution whenever a task is
freed.

Cheers,
	-Matt Helsley

