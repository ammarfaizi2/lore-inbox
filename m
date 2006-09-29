Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161283AbWI2Cbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161283AbWI2Cbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161287AbWI2Cbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:31:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4786 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161283AbWI2Cbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:31:50 -0400
Date: Thu, 28 Sep 2006 19:31:38 -0700
From: Paul Jackson <pj@sgi.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jes@sgi.com, lse-tech@lists.sourceforge.net,
       sekharan@us.ibm.com, jtk@us.ibm.com, hch@lst.de,
       viro@zeniv.linux.org.uk, sgrubb@redhat.com, linux-audit@redhat.com
Subject: Re: [RFC][PATCH 05/10] Task watchers v2 Register cpuset task
 watcher
Message-Id: <20060928193138.963c510a.pj@sgi.com>
In-Reply-To: <20060929021300.851205000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
	<20060929021300.851205000@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:

> -	cpuset_fork(p);
>  #ifdef CONFIG_NUMA
>   	p->mempolicy = mpol_copy(p->mempolicy);
>   	if (IS_ERR(p->mempolicy)) {
>   		retval = PTR_ERR(p->mempolicy);
>   		p->mempolicy = NULL;
> - 		goto bad_fork_cleanup_cpuset;
> + 		goto bad_fork_cleanup_delays_binfmt;
>   	}
>  	mpol_fix_fork_child_flag(p);
>  #endif
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	p->irq_events = 0;
> @@ -1280,13 +1278,11 @@ bad_fork_cleanup_files:
>  bad_fork_cleanup_security:
>  	security_task_free(p);
>  bad_fork_cleanup_policy:
>  #ifdef CONFIG_NUMA
>  	mpol_free(p->mempolicy);
> -bad_fork_cleanup_cpuset:
>  #endif
> -	cpuset_exit(p);
>  bad_fork_cleanup_delays_binfmt:


The above code, before your change, had the affect that if mpol_copy()
failed, then the cpusets that were just setup by the cpuset_fork()
call were undone by a cpuset_exit() call.

>From what I can tell, after your change, this is no longer done,
and a failed mpol_copy will leave cpusets in an incorrect state.

Am I missing something?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
