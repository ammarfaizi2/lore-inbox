Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSJBNF5>; Wed, 2 Oct 2002 09:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263144AbSJBNF5>; Wed, 2 Oct 2002 09:05:57 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:64772 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263143AbSJBNF4>; Wed, 2 Oct 2002 09:05:56 -0400
Date: Wed, 2 Oct 2002 14:11:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Erich Focht <efocht@ess.nec.de>
Subject: Re: [RFC] Simple NUMA scheduler patch
Message-ID: <20021002141121.C2141@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, Erich Focht <efocht@ess.nec.de>
References: <Pine.LNX.4.44.0209050905180.8086-100000@localhost.localdomain> <1033516540.1209.144.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033516540.1209.144.camel@dyn9-47-17-164.beaverton.ibm.com>; from hohnbaum@us.ibm.com on Tue, Oct 01, 2002 at 04:55:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 04:55:35PM -0700, Michael Hohnbaum wrote:
> --- clean-2.5.40/kernel/sched.c	Tue Oct  1 13:48:34 2002
> +++ linux-2.5.40/kernel/sched.c	Tue Oct  1 13:27:46 2002
> @@ -30,6 +30,9 @@
>  #include <linux/notifier.h>
>  #include <linux/delay.h>
>  #include <linux/timer.h>
> +#if CONFIG_NUMA
> +#include <asm/topology.h>
> +#endif

Please make this inlcude unconditional, okay?

> +/*
> + * find_busiest_queue - find the busiest runqueue.
> + */
> +static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
> +{
> +	int nr_running, load, max_load_on_node, max_load_off_node, i;
> +	runqueue_t *busiest, *busiest_on_node, *busiest_off_node, *rq_src;

You're new find_busiest_queue is to 80 or 90% the same as the non-NUMA one.
At least add the #ifdefs only where needed, but as cpu_to_node() optimizes
away for the non-NUMA case I think you could just make it unconditional.

> +		if (__cpu_to_node(i) == __cpu_to_node(this_cpu)) {

I think it should be cpu_to_node, not __cpu_to_node.

> +#if CONFIG_NUMA
> +/*
> + * If dest_cpu is allowed for this process, migrate the task to it.
> + * This is accomplished by forcing the cpu_allowed mask to only
> + * allow dest_cpu, which will force the cpu onto dest_cpu.  Then
> + * the cpu_allowed mask is restored.
> + */
> +void sched_migrate_task(task_t *p, int dest_cpu)

Looks like this one could be static?

