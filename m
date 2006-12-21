Return-Path: <linux-kernel-owner+w=401wt.eu-S1423111AbWLUVWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423111AbWLUVWI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423113AbWLUVWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:22:08 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:49813 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423111AbWLUVWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:22:06 -0500
Date: Thu, 21 Dec 2006 22:22:02 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
       Christoph Raisch <raisch@de.ibm.com>
Subject: Re: [PATCH] ehca: fix kthread_create() error check
Message-ID: <20061221212202.GA23157@osiris.ibm.com>
References: <20061219084248.GF4049@APFDCB5C>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219084248.GF4049@APFDCB5C>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Index: 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
> ===================================================================
> --- 2.6-mm.orig/drivers/infiniband/hw/ehca/ehca_irq.c
> +++ 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
> @@ -670,11 +670,13 @@ static int comp_pool_callback(struct not
>  {
>  	unsigned int cpu = (unsigned long)hcpu;
>  	struct ehca_cpu_comp_task *cct;
> +	struct task_struct *task;
> 
>  	switch (action) {
>  	case CPU_UP_PREPARE:
>  		ehca_gen_dbg("CPU: %x (CPU_PREPARE)", cpu);
> -		if(!create_comp_task(pool, cpu)) {
> +		task = create_comp_task(pool, cpu);
> +		if (IS_ERR(task)) {
>  			ehca_gen_err("Can't create comp_task for cpu: %x", cpu);
>  			return NOTIFY_BAD;
>  		}

If this fails then the code will crash on CPU_UP_CANCELED. Because of
kthread_bind(cct->task,...). cct->task would be just the encoded error
number.

> @@ -730,7 +732,7 @@ int ehca_create_comp_pool(void)
> 
>  	for_each_online_cpu(cpu) {
>  		task = create_comp_task(pool, cpu);
> -		if (task) {
> +		if (!IS_ERR(task)) {
>  			kthread_bind(task, cpu);
>  			wake_up_process(task);
>  		}

So you silently ignore errors and the module loads anyway?
