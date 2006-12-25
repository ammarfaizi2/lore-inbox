Return-Path: <linux-kernel-owner+w=401wt.eu-S1754280AbWLYINJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbWLYINJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 03:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbWLYINI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 03:13:08 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:32300 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbWLYINH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 03:13:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=sZ5B0AW5u77Ot6xyHq3anEnBOmcHIBt323XYECRobFBegUx2eIEnRkAaNVgroZNi9bWkP99gkgUZDzSQfjHH6Y1jPvdrtC0OgxMCkfPk9nqQz/H4bb3UHog7Epbwjk22zqdUU2rQCRo6KztHs983JOOrlKnrKYdWbmkfxFJ/iPA=
Date: Mon, 25 Dec 2006 17:12:57 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
       Christoph Raisch <raisch@de.ibm.com>, akpm@osdl.org
Subject: [PATCH -mm] ehca: avoid crash on kthread_create() failure
Message-ID: <20061225081257.GA3869@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>, akpm@osdl.org
References: <20061219084248.GF4049@APFDCB5C> <20061221212202.GA23157@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221212202.GA23157@osiris.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 10:22:02PM +0100, Heiko Carstens wrote:
> > Index: 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
> > ===================================================================
> > --- 2.6-mm.orig/drivers/infiniband/hw/ehca/ehca_irq.c
> > +++ 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
> > @@ -670,11 +670,13 @@ static int comp_pool_callback(struct not
> >  {
> >  	unsigned int cpu = (unsigned long)hcpu;
> >  	struct ehca_cpu_comp_task *cct;
> > +	struct task_struct *task;
> > 
> >  	switch (action) {
> >  	case CPU_UP_PREPARE:
> >  		ehca_gen_dbg("CPU: %x (CPU_PREPARE)", cpu);
> > -		if(!create_comp_task(pool, cpu)) {
> > +		task = create_comp_task(pool, cpu);
> > +		if (IS_ERR(task)) {
> >  			ehca_gen_err("Can't create comp_task for cpu: %x", cpu);
> >  			return NOTIFY_BAD;
> >  		}
> 
> If this fails then the code will crash on CPU_UP_CANCELED. Because of
> kthread_bind(cct->task,...). cct->task would be just the encoded error
> number.

Subject: [PATCH -mm] ehca: avoid crash on kthread_create() failure

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
@@ -606,13 +606,16 @@ static int comp_task(void *__cct)
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
 
 	return cct->task;
 }
@@ -684,8 +687,10 @@ static int comp_pool_callback(struct not
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
