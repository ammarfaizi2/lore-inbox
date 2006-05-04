Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWEDV36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWEDV36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWEDV35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:29:57 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:42801 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751407AbWEDV34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:29:56 -0400
X-IronPort-AV: i="4.05,89,1146466800"; 
   d="scan'208"; a="272848744:sNHT25150198"
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
X-Message-Flag: Warning: May contain useful information
References: <4450A196.2050901@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 04 May 2006 14:29:54 -0700
In-Reply-To: <4450A196.2050901@de.ibm.com> (Heiko J. Schick's message of "Thu, 27 Apr 2006 12:48:54 +0200")
Message-ID: <adaejz9o4vh.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 May 2006 21:29:54.0983 (UTC) FILETIME=[E2B9B370:01C66FC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +void ehca_queue_comp_task(struct ehca_comp_pool *pool, struct ehca_cq *__cq)
 > +{
 > +	int cpu;
 > +	int cpu_id;
 > +	struct ehca_cpu_comp_task *cct;
 > +	unsigned long flags_cct;
 > +	unsigned long flags_cq;
 > +
 > +	cpu = get_cpu();
 > +	cpu_id = find_next_online_cpu(pool);
 > +
 > +	EDEB_EN(7, "pool=%p cq=%p cq_nr=%x CPU=%x:%x:%x:%x",
 > +		pool, __cq, __cq->cq_number,
 > +		cpu, cpu_id, num_online_cpus(), num_possible_cpus());
 > +
 > +	BUG_ON(!cpu_online(cpu_id));
 > +
 > +	cct = per_cpu_ptr(pool->cpu_comp_tasks, cpu_id);
 > +
 > +	spin_lock_irqsave(&cct->task_lock, flags_cct);
 > +	spin_lock_irqsave(&__cq->task_lock, flags_cq);
 > +
 > +	if (__cq->nr_callbacks == 0) {
 > +		__cq->nr_callbacks++;
 > +		list_add_tail(&__cq->entry, &cct->cq_list);
 > +		wake_up(&cct->wait_queue);
 > +	}
 > +	else
 > +		__cq->nr_callbacks++;
 > +
 > +	spin_unlock_irqrestore(&__cq->task_lock, flags_cq);
 > +	spin_unlock_irqrestore(&cct->task_lock, flags_cct);
 > +
 > +	put_cpu();
 > +
 > +	EDEB_EX(7, "cct=%p", cct);
 > +
 > +	return;
 > +}

I never read the ehca completion event handling code very carefully
until now.  But I was motivated by Shirley's work on IPoIB to take a
closer look.

It seems that you are deferring completion event dispatch into threads
spread across all the CPUs.  This seems like a very strange thing to
me -- you are adding latency and possibly causing cacheline pingpong.

It may help throughput in some cases to spread the work across
multiple CPUs but it seems strange to me to do this in the low-level
driver.  My intuition would be that it would be better to do this in
the higher levels, and leave open the possibility for protocols that
want the lowest possible latency to be called directly from the
interrupt handler.

What was the thinking that led to this design?

 - R.
