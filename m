Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbUCZSYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUCZSYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:24:17 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:4809 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S264115AbUCZSUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:20:33 -0500
Date: Fri, 26 Mar 2004 19:20:20 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/7): z/VM monitor stream.
Message-ID: <20040326182020.GD2523@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

z/VM monitor stream changes:
 - Correct sysctl vs. module ref-counting.

diffstat:
 arch/s390/appldata/appldata_base.c |   43 ++++++++++++++++++++++++++++++-------
 1 files changed, 35 insertions(+), 8 deletions(-)

diff -urN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-s390/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	Fri Mar 26 18:24:53 2004
+++ linux-2.6-s390/arch/s390/appldata/appldata_base.c	Fri Mar 26 18:25:57 2004
@@ -372,31 +372,57 @@
 appldata_generic_handler(ctl_table *ctl, int write, struct file *filp,
 			   void *buffer, size_t *lenp)
 {
-	struct appldata_ops *ops;
-	int rc, len;
+	struct appldata_ops *ops = NULL, *tmp_ops;
+	int rc, len, found;
 	char buf[2];
+	struct list_head *lh;
 
+	found = 0;
+	spin_lock_bh(&appldata_ops_lock);
+	list_for_each(lh, &appldata_ops_list) {
+		tmp_ops = list_entry(lh, struct appldata_ops, list);
+		if (&tmp_ops->ctl_table[2] == ctl) {
+			found = 1;
+		}
+	}
+	if (!found) {
+		spin_unlock_bh(&appldata_ops_lock);
+		return -ENODEV;
+	}
 	ops = ctl->data;
+	if (!try_module_get(ops->owner)) {	// protect this function
+		spin_unlock_bh(&appldata_ops_lock);
+		return -ENODEV;
+	}
+	spin_unlock_bh(&appldata_ops_lock);
+	
 	if (!*lenp || filp->f_pos) {
 		*lenp = 0;
+		module_put(ops->owner);
 		return 0;
 	}
 	if (!write) {
 		len = sprintf(buf, ops->active ? "1\n" : "0\n");
 		if (len > *lenp)
 			len = *lenp;
-		if (copy_to_user(buffer, buf, len))
+		if (copy_to_user(buffer, buf, len)) {
+			module_put(ops->owner);
 			return -EFAULT;
+		}
 		goto out;
 	}
 	len = *lenp;
-	if (copy_from_user(buf, buffer, len > sizeof(buf) ? sizeof(buf) : len))
+	if (copy_from_user(buf, buffer,
+			   len > sizeof(buf) ? sizeof(buf) : len)) {
+		module_put(ops->owner);
 		return -EFAULT;
+	}
 
 	spin_lock_bh(&appldata_ops_lock);
 	if ((buf[0] == '1') && (ops->active == 0)) {
-		if (!try_module_get(ops->owner)) {
+		if (!try_module_get(ops->owner)) {	// protect tasklet
 			spin_unlock_bh(&appldata_ops_lock);
+			module_put(ops->owner);
 			return -ENODEV;
 		}
 		ops->active = 1;
@@ -430,6 +456,7 @@
 out:
 	*lenp = len;
 	filp->f_pos += len;
+	module_put(ops->owner);
 	return 0;
 }
 
@@ -511,7 +538,6 @@
 	ops->ctl_table[3].ctl_name = 0;
 
 	ops->sysctl_header = register_sysctl_table(ops->ctl_table,1);
-	ops->ctl_table[2].de->owner = ops->owner;
 
 	P_INFO("%s-ops registered!\n", ops->name);
 	return 0;
@@ -525,10 +551,11 @@
 void appldata_unregister_ops(struct appldata_ops *ops)
 {
 	spin_lock_bh(&appldata_ops_lock);
-	list_del(&ops->list);
-	spin_unlock_bh(&appldata_ops_lock);
 	unregister_sysctl_table(ops->sysctl_header);
+	list_del(&ops->list);
 	kfree(ops->ctl_table);
+	ops->ctl_table = NULL;
+	spin_unlock_bh(&appldata_ops_lock);
 	P_INFO("%s-ops unregistered!\n", ops->name);
 }
 /********************** module-ops management <END> **************************/
