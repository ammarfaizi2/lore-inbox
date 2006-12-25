Return-Path: <linux-kernel-owner+w=401wt.eu-S1754372AbWLYJgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbWLYJgK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 04:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbWLYJgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 04:36:09 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:46671 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbWLYJgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 04:36:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RC1XH9Dthvk8MYTvea9HEElr/nDNCE/BsaO0AfHU4NRBcSo4GEjUwfH7chPkcN3WPSe46dyEZlk4ibl0ZQjctTS57g7UTwQtGXO7vK8ipB1Kg0F6uKWXXDDdRZ3H11OagHMF2JEE1F7SrgHu6U3RmjZrd5vBYBlrBuY7kGYDV90=
Date: Mon, 25 Dec 2006 18:35:57 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
       Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
       Christoph Raisch <raisch@de.ibm.com>, akpm@osdl.org
Subject: Re: [PATCH -mm] ehca: avoid crash on kthread_create() failure
Message-ID: <20061225093557.GA5726@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Muli Ben-Yehuda <muli@il.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>, akpm@osdl.org
References: <20061219084248.GF4049@APFDCB5C> <20061221212202.GA23157@osiris.ibm.com> <20061225081257.GA3869@APFDCB5C> <20061225083023.GA5334@APFDCB5C> <20061225085551.GB2313@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061225085551.GB2313@rhun.haifa.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2006 at 10:55:51AM +0200, Muli Ben-Yehuda wrote:
> This is correct because cct is allocated via alloc_percpu, which in
> turn calls kzalloc, which means cct->task is NULL by default, but it's
> a little too obscure for me. How about making it explicit?
> 
> task = kthread_create(...)
> if (!IS_ERR(task))
>    cct->task = task;
> else
>   cct->task = NULL;
> 
> return cct->task;

Subject: [PATCH -mm] ehca: avoid crash on kthread_create() failure (v3)

This patch disallows invalid task_struct pointer returned by
kthread_create() to be written to percpu data to avoid crash.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: Christoph Raisch <raisch@de.ibm.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/infiniband/hw/ehca/ehca_irq.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
===================================================================
--- 2.6-mm.orig/drivers/infiniband/hw/ehca/ehca_irq.c
+++ 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -606,15 +606,20 @@ static int comp_task(void *__cct)
 static struct task_struct *create_comp_task(struct ehca_comp_pool *pool,
 					    int cpu)
 {
+	struct task_struct *task;
 	struct ehca_cpu_comp_task *cct;
 
 	cct = per_cpu_ptr(pool->cpu_comp_tasks, cpu);
 	spin_lock_init(&cct->task_lock);
 	INIT_LIST_HEAD(&cct->cq_list);
 	init_waitqueue_head(&cct->wait_queue);
-	cct->task = kthread_create(comp_task, cct, "ehca_comp/%d", cpu);
+	task = kthread_create(comp_task, cct, "ehca_comp/%d", cpu);
+	if (!IS_ERR(task))
+		cct->task = task;
+	else
+		cct->task = NULL;
 
-	return cct->task;
+	return task;
 }
 
 static void destroy_comp_task(struct ehca_comp_pool *pool,
@@ -684,8 +689,10 @@ static int comp_pool_callback(struct not
 	case CPU_UP_CANCELED:
 		ehca_gen_dbg("CPU: %x (CPU_CANCELED)", cpu);
 		cct = per_cpu_ptr(pool->cpu_comp_tasks, cpu);
-		kthread_bind(cct->task, any_online_cpu(cpu_online_map));
-		destroy_comp_task(pool, cpu);
+		if (cct->task) {
+			kthread_bind(cct->task, any_online_cpu(cpu_online_map));
+			destroy_comp_task(pool, cpu);
+		}
 		break;
 	case CPU_ONLINE:
 		ehca_gen_dbg("CPU: %x (CPU_ONLINE)", cpu);
