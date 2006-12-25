Return-Path: <linux-kernel-owner+w=401wt.eu-S1754329AbWLYIzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbWLYIzy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 03:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbWLYIzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 03:55:54 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:52303 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316AbWLYIzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 03:55:53 -0500
Date: Mon, 25 Dec 2006 10:55:51 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
       Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
       Christoph Raisch <raisch@de.ibm.com>, akpm@osdl.org
Subject: Re: [PATCH -mm] ehca: avoid crash on kthread_create() failure
Message-ID: <20061225085551.GB2313@rhun.haifa.ibm.com>
References: <20061219084248.GF4049@APFDCB5C> <20061221212202.GA23157@osiris.ibm.com> <20061225081257.GA3869@APFDCB5C> <20061225083023.GA5334@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061225083023.GA5334@APFDCB5C>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2006 at 05:30:23PM +0900, Akinobu Mita wrote:
> On Mon, Dec 25, 2006 at 05:12:57PM +0900, Akinobu Mita wrote:
> > Index: 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
> > ===================================================================
> > --- 2.6-mm.orig/drivers/infiniband/hw/ehca/ehca_irq.c
> > +++ 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
> > @@ -606,13 +606,16 @@ static int comp_task(void *__cct)
> >  static struct task_struct *create_comp_task(struct ehca_comp_pool *pool,
> >  					    int cpu)
> >  {
> > +	struct task_struct *task;
> >  	struct ehca_cpu_comp_task *cct;
> >  
> >  	cct = per_cpu_ptr(pool->cpu_comp_tasks, cpu);
> >  	spin_lock_init(&cct->task_lock);
> >  	INIT_LIST_HEAD(&cct->cq_list);
> >  	init_waitqueue_head(&cct->wait_queue);
> > -	cct->task = kthread_create(comp_task, cct, "ehca_comp/%d", cpu);
> > +	task = kthread_create(comp_task, cct, "ehca_comp/%d", cpu);
> > +	if (!IS_ERR(task))
> > +		cct->task = task;
> >  
> >  	return cct->task;
> >  }
> 
> This patch is wrong. It changes to make create_comp_task() return NULL
> on failure.
> 
> (BTW, all these ehca fixes are not compile tested due to luck of
> cross comile environment)
> 
> Subject: [PATCH -mm] ehca: avoid crash on kthread_create() failure (v2)
> 
> This patch disallows invalid task_struct pointer returned by
> kthread_create() to be written to percpu data to avoid crash.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
> Cc: Christoph Raisch <raisch@de.ibm.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> ---
>  drivers/infiniband/hw/ehca/ehca_irq.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> Index: 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
> ===================================================================
> --- 2.6-mm.orig/drivers/infiniband/hw/ehca/ehca_irq.c
> +++ 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
> @@ -606,15 +606,18 @@ static int comp_task(void *__cct)
>  static struct task_struct *create_comp_task(struct ehca_comp_pool *pool,
>  					    int cpu)
>  {
> +	struct task_struct *task;
>  	struct ehca_cpu_comp_task *cct;
>  
>  	cct = per_cpu_ptr(pool->cpu_comp_tasks, cpu);
>  	spin_lock_init(&cct->task_lock);
>  	INIT_LIST_HEAD(&cct->cq_list);
>  	init_waitqueue_head(&cct->wait_queue);
> -	cct->task = kthread_create(comp_task, cct, "ehca_comp/%d", cpu);
> +	task = kthread_create(comp_task, cct, "ehca_comp/%d", cpu);
> +	if (!IS_ERR(task))
> +		cct->task = task;
>  
> -	return cct->task;
> +	return task;
>  }
>  
>  static void destroy_comp_task(struct ehca_comp_pool *pool,
> @@ -684,8 +687,10 @@ static int comp_pool_callback(struct not
>  	case CPU_UP_CANCELED:
>  		ehca_gen_dbg("CPU: %x (CPU_CANCELED)", cpu);
>  		cct = per_cpu_ptr(pool->cpu_comp_tasks, cpu);
> -		kthread_bind(cct->task, any_online_cpu(cpu_online_map));
> -		destroy_comp_task(pool, cpu);
> +		if (cct->task) {
> +			kthread_bind(cct->task, any_online_cpu(cpu_online_map));
> +			destroy_comp_task(pool, cpu);
> +		}

This is correct because cct is allocated via alloc_percpu, which in
turn calls kzalloc, which means cct->task is NULL by default, but it's
a little too obscure for me. How about making it explicit?

task = kthread_create(...)
if (!IS_ERR(task))
   cct->task = task;
else
  cct->task = NULL;

return cct->task;

Cheers,
Muli
