Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUCPODQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUCPN6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:58:51 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:33748 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S261703AbUCPNvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:51:32 -0500
Date: Tue, 16 Mar 2004 14:51:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (6/10): z/VM monitor stream.
Message-ID: <20040316135109.GG2785@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for z/VM monitor stream:
 - Add try_module_get and module_put to the [un]register functions.
 - Some code beautification.

diffstat:
 arch/s390/appldata/appldata_base.c |   59 +++++++++++++------------------------
 1 files changed, 22 insertions(+), 37 deletions(-)

diff -urN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-s390/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	Thu Mar 11 03:55:24 2004
+++ linux-2.6-s390/arch/s390/appldata/appldata_base.c	Tue Mar 16 14:03:12 2004
@@ -233,8 +233,8 @@
 				.buffer_addr = virt_to_phys((void *) buffer)
 	};
 
-        if (!MACHINE_IS_VM)
-                return -ENOSYS;
+	if (!MACHINE_IS_VM)
+		return -ENOSYS;	
 	ry = -1;
 	asm volatile(
 			"diag %1,%0,0xDC\n\t"
@@ -336,9 +336,9 @@
 		P_ERROR("Timer CPU interval has to be > 0!\n");
 		return -EINVAL;
 	}
-	per_cpu_interval = (u64) (interval*1000 / num_online_cpus()) * TOD_MICRO;
 
 	spin_lock(&appldata_timer_lock);
+	per_cpu_interval = (u64) (interval*1000 / num_online_cpus()) * TOD_MICRO;
 	appldata_interval = interval;
 	if (appldata_timer_active) {
 		for (i = 0; i < num_online_cpus(); i++) {
@@ -395,6 +395,10 @@
 
 	spin_lock_bh(&appldata_ops_lock);
 	if ((buf[0] == '1') && (ops->active == 0)) {
+		if (!try_module_get(ops->owner)) {
+			spin_unlock_bh(&appldata_ops_lock);
+			return -ENODEV;
+		}
 		ops->active = 1;
 		ops->callback(ops->data);	// init record
 		rc = appldata_diag(ops->record_nr,
@@ -403,6 +407,7 @@
 		if (rc != 0) {
 			P_ERROR("START DIAG 0xDC for %s failed, "
 				"return code: %d\n", ops->name, rc);
+			module_put(ops->owner);
 			ops->active = 0;
 		} else {
 			P_INFO("Monitoring %s data enabled, "
@@ -419,6 +424,7 @@
 			P_INFO("Monitoring %s data disabled, "
 				"DIAG 0xDC stopped.\n", ops->name);
 		}
+		module_put(ops->owner);
 	}
 	spin_unlock_bh(&appldata_ops_lock);
 out:
@@ -440,30 +446,26 @@
 {
 	struct list_head *lh;
 	struct appldata_ops *tmp_ops;
-	int rc, i;
-
-	rc = 0;
+	int i;
+	
 	i = 0;
 
 	if ((ops->size > APPLDATA_MAX_REC_SIZE) ||
 		(ops->size < 0)){
 		P_ERROR("Invalid size of %s record = %i, maximum = %i!\n",
 			ops->name, ops->size, APPLDATA_MAX_REC_SIZE);
-		rc = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 	if ((ops->ctl_nr == CTL_APPLDATA) ||
 	    (ops->ctl_nr == CTL_APPLDATA_TIMER) ||
 	    (ops->ctl_nr == CTL_APPLDATA_INTERVAL)) {
 		P_ERROR("ctl_nr %i already in use!\n", ops->ctl_nr);
-		rc = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 	ops->ctl_table = kmalloc(4*sizeof(struct ctl_table), GFP_KERNEL);
 	if (ops->ctl_table == NULL) {
 		P_ERROR("Not enough memory for %s ctl_table!\n", ops->name);
-		rc = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 	memset(ops->ctl_table, 0, 4*sizeof(struct ctl_table));
 
@@ -477,18 +479,16 @@
 			ops->ctl_nr);
 		if (strncmp(tmp_ops->name, ops->name,
 				APPLDATA_PROC_NAME_LENGTH) == 0) {
-			spin_unlock_bh(&appldata_ops_lock);
 			P_ERROR("Name \"%s\" already registered!\n", ops->name);
 			kfree(ops->ctl_table);
-			rc = -EBUSY;
-			goto out;
+			spin_unlock_bh(&appldata_ops_lock);
+			return -EBUSY;
 		}
 		if (tmp_ops->ctl_nr == ops->ctl_nr) {
-			spin_unlock_bh(&appldata_ops_lock);
 			P_ERROR("ctl_nr %i already registered!\n", ops->ctl_nr);
 			kfree(ops->ctl_table);
-			rc = -EBUSY;
-			goto out;
+			spin_unlock_bh(&appldata_ops_lock);
+			return -EBUSY;
 		}
 	}
 	list_add(&ops->list, &appldata_ops_list);
@@ -512,9 +512,9 @@
 
 	ops->sysctl_header = register_sysctl_table(ops->ctl_table,1);
 	ops->ctl_table[2].de->owner = ops->owner;
+
 	P_INFO("%s-ops registered!\n", ops->name);
-out:
-	return rc;
+	return 0;
 }
 
 /*
@@ -524,26 +524,11 @@
  */
 void appldata_unregister_ops(struct appldata_ops *ops)
 {
-	int rc;
-
-	unregister_sysctl_table(ops->sysctl_header);
-	kfree(ops->ctl_table);
-	if (ops->active == 1) {
-		ops->active = 0;
-		rc = appldata_diag(ops->record_nr, APPLDATA_STOP_REC,
-				(unsigned long) ops->data, ops->size);
-		if (rc != 0) {
-			P_ERROR("STOP DIAG 0xDC for %s failed, "
-				"return code: %d\n", ops->name, rc);
-		} else {
-			P_INFO("Monitoring %s data disabled, "
-				"DIAG 0xDC stopped.\n", ops->name);
-		}
-
-	}
 	spin_lock_bh(&appldata_ops_lock);
 	list_del(&ops->list);
 	spin_unlock_bh(&appldata_ops_lock);
+	unregister_sysctl_table(ops->sysctl_header);
+	kfree(ops->ctl_table);
 	P_INFO("%s-ops unregistered!\n", ops->name);
 }
 /********************** module-ops management <END> **************************/
