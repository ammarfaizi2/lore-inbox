Return-Path: <linux-kernel-owner+w=401wt.eu-S932676AbWLSIno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbWLSIno (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWLSInn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:43:43 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:54703 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676AbWLSInm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:43:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=JLk4niM5v7uakg1F5QodDZ+7Rg2aIHRYTzShTHRT6XZS5B1J4aEJpGEwGkHTm9/9fnbz1aOPpmSynSBRxn693jsJSkP/+f4rkOG40f2KvWwe1DDfV7Ka6puTk4zSHx6E3qisiygoxHeZK2n3RdH42x8d11MZCJVkaeMcRAQ31J4=
Date: Tue, 19 Dec 2006 17:42:48 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
       Christoph Raisch <raisch@de.ibm.com>
Subject: [PATCH] ehca: fix kthread_create() error check
Message-ID: <20061219084248.GF4049@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of kthread_create() should be checked by
IS_ERR(). create_comp_task() returns the return value from
kthread_create().

Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: Christoph Raisch <raisch@de.ibm.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/infiniband/hw/ehca/ehca_irq.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
===================================================================
--- 2.6-mm.orig/drivers/infiniband/hw/ehca/ehca_irq.c
+++ 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -670,11 +670,13 @@ static int comp_pool_callback(struct not
 {
 	unsigned int cpu = (unsigned long)hcpu;
 	struct ehca_cpu_comp_task *cct;
+	struct task_struct *task;
 
 	switch (action) {
 	case CPU_UP_PREPARE:
 		ehca_gen_dbg("CPU: %x (CPU_PREPARE)", cpu);
-		if(!create_comp_task(pool, cpu)) {
+		task = create_comp_task(pool, cpu);
+		if (IS_ERR(task)) {
 			ehca_gen_err("Can't create comp_task for cpu: %x", cpu);
 			return NOTIFY_BAD;
 		}
@@ -730,7 +732,7 @@ int ehca_create_comp_pool(void)
 
 	for_each_online_cpu(cpu) {
 		task = create_comp_task(pool, cpu);
-		if (task) {
+		if (!IS_ERR(task)) {
 			kthread_bind(task, cpu);
 			wake_up_process(task);
 		}
