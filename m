Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268831AbUJEGb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268831AbUJEGb3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268832AbUJEGb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:31:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9680 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268831AbUJEGb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:31:26 -0400
Date: Tue, 5 Oct 2004 02:31:04 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: bug in sched.c:activate_task()
In-Reply-To: <200410050216.i952Gb620657@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0410050229380.31508@devserv.devel.redhat.com>
References: <200410050216.i952Gb620657@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Oct 2004, Chen, Kenneth W wrote:

> Update p->timestamp to "now" in activate_task() doesn't look right to me
> at all.  p->timestamp records last time it was running on a cpu.  
> activate_task shouldn't update that variable when it queues a task on
> the runqueue.

correct, we are overriding it in schedule():

        if (likely(prev != next)) {
                next->timestamp = now;
                rq->nr_switches++;

the line your patch removes is a remnant of an earlier logic when we
timestamped tasks when they touched the runqueue. (vs. timestamping when
they actually run on a CPU.) So the patch looks good to me. Andrew, please
apply.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

        Ingo


> 
> This bug (and combined with others) triggers improper load balancing.
> 
> Patch against linux-2.6.9-rc3.  Didn't diff it against 2.6.9-rc3-mm2
> because mm tree has so many change in sched.c.
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 
> 
> --- linux-2.6.9-rc3/kernel/sched.c.orig	2004-10-04 19:11:21.000000000 -0700
> +++ linux-2.6.9-rc3/kernel/sched.c	2004-10-04 19:11:35.000000000 -0700
> @@ -888,7 +888,6 @@ static void activate_task(task_t *p, run
>  			p->activated = 1;
>  		}
>  	}
> -	p->timestamp = now;
> 
>  	__activate_task(p, rq);
>  }
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
