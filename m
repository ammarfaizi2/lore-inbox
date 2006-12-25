Return-Path: <linux-kernel-owner+w=401wt.eu-S1754292AbWLYIN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbWLYIN5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 03:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754293AbWLYIN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 03:13:57 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:32429 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbWLYIN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 03:13:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bRY4p1LEUynVzKOxhBnjHfnG0rAxaTXygvw2yJPLI46ta0aYytRMlQ5gugT+tKIyNggnPcwklJzm3h2UuwFYBETvW/HiO7TcUua4HiY0RHYYt2W4NFFqO1tsekRQkqZRGS/WZa2MK1CDtxQon3bFvuvxX6XIeU/AdLEF4vPzMVI=
Date: Mon, 25 Dec 2006 17:13:47 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
       Christoph Raisch <raisch@de.ibm.com>, akpm@osdl.org
Subject: [PATCH -mm] return error on create_comp_task() failure
Message-ID: <20061225081347.GB3869@APFDCB5C>
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
> > @@ -730,7 +732,7 @@ int ehca_create_comp_pool(void)
> > 
> >  	for_each_online_cpu(cpu) {
> >  		task = create_comp_task(pool, cpu);
> > -		if (task) {
> > +		if (!IS_ERR(task)) {
> >  			kthread_bind(task, cpu);
> >  			wake_up_process(task);
> >  		}
> 
> So you silently ignore errors and the module loads anyway?

Subject: [PATCH -mm] return error on create_comp_task() failure

This patch frees allocated data and returns error
to avoid module loading if create_comp_task() failed.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: Christoph Raisch <raisch@de.ibm.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/infiniband/hw/ehca/ehca_irq.c |   37 ++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

Index: 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
===================================================================
--- 2.6-mm.orig/drivers/infiniband/hw/ehca/ehca_irq.c
+++ 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -716,11 +716,12 @@ static int comp_pool_callback(struct not
 
 #endif
 
+#ifdef CONFIG_INFINIBAND_EHCA_SCALING
+
 int ehca_create_comp_pool(void)
 {
-#ifdef CONFIG_INFINIBAND_EHCA_SCALING
 	int cpu;
-	struct task_struct *task;
+	int err;
 
 	pool = kzalloc(sizeof(struct ehca_comp_pool), GFP_KERNEL);
 	if (pool == NULL)
@@ -736,21 +737,41 @@ int ehca_create_comp_pool(void)
 	}
 
 	for_each_online_cpu(cpu) {
-		task = create_comp_task(pool, cpu);
-		if (!IS_ERR(task)) {
-			kthread_bind(task, cpu);
-			wake_up_process(task);
+		struct task_struct *task = create_comp_task(pool, cpu);
+
+		if (IS_ERR(task)) {
+			err = PTR_ERR(task);
+			goto err_comp_task;
 		}
+		kthread_bind(task, cpu);
+		wake_up_process(task);
 	}
 
 	comp_pool_callback_nb.notifier_call = comp_pool_callback;
-	comp_pool_callback_nb.priority =0;
+	comp_pool_callback_nb.priority = 0;
 	register_cpu_notifier(&comp_pool_callback_nb);
-#endif
 
 	return 0;
+
+err_comp_task:
+	for_each_online_cpu(cpu)
+		destroy_comp_task(pool, cpu);
+
+	free_percpu(pool->cpu_comp_tasks);
+	kfree(pool);
+
+	return err;
+}
+
+#else
+
+int ehca_create_comp_pool(void)
+{
+	return 0;
 }
 
+#endif
+
 void ehca_destroy_comp_pool(void)
 {
 #ifdef CONFIG_INFINIBAND_EHCA_SCALING
