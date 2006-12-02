Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162768AbWLBEZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162768AbWLBEZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162769AbWLBEZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:25:49 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:37320 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S1162768AbWLBEZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:25:48 -0500
Date: Fri, 1 Dec 2006 22:25:46 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH 3/12] IPMI: pass sysfs name from lower level driver
Message-ID: <20061202042546.GC30214@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch passes in the sysfs name from the lower-level IPMI driver,
as the coming IPMI serial driver will need that to link properly from
the serial device sysfs directory.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_msghandler.c
@@ -205,6 +205,7 @@ struct ipmi_smi
 
 	struct bmc_device *bmc;
 	char *my_dev_name;
+	char *sysfs_name;
 
 	/* This is the lower-layer's sender routine. */
 	struct ipmi_smi_handlers *handlers;
@@ -2004,7 +2005,11 @@ static void ipmi_bmc_unregister(ipmi_smi
 {
 	struct bmc_device *bmc = intf->bmc;
 
-	sysfs_remove_link(&intf->si_dev->kobj, "bmc");
+	if (intf->sysfs_name) {
+		sysfs_remove_link(&intf->si_dev->kobj, intf->sysfs_name);
+		kfree(intf->sysfs_name);
+		intf->sysfs_name = NULL;
+	}
 	if (intf->my_dev_name) {
 		sysfs_remove_link(&bmc->dev->dev.kobj, intf->my_dev_name);
 		kfree(intf->my_dev_name);
@@ -2140,7 +2145,8 @@ out:
 	return err;
 }
 
-static int ipmi_bmc_register(ipmi_smi_t intf)
+static int ipmi_bmc_register(ipmi_smi_t intf, int ifnum,
+			     const char *sysfs_name)
 {
 	int               rv;
 	struct bmc_device *bmc = intf->bmc;
@@ -2257,29 +2263,44 @@ static int ipmi_bmc_register(ipmi_smi_t 
 	 * create symlink from system interface device to bmc device
 	 * and back.
 	 */
+	intf->sysfs_name = kstrdup(sysfs_name, GFP_KERNEL);
+	if (!intf->sysfs_name) {
+		rv = -ENOMEM;
+		printk(KERN_ERR
+		       "ipmi_msghandler: allocate link to BMC: %d\n",
+		       rv);
+		goto out_err;
+	}
+
 	rv = sysfs_create_link(&intf->si_dev->kobj,
-			       &bmc->dev->dev.kobj, "bmc");
+			       &bmc->dev->dev.kobj, intf->sysfs_name);
 	if (rv) {
+		kfree(intf->sysfs_name);
+		intf->sysfs_name = NULL;
 		printk(KERN_ERR
 		       "ipmi_msghandler: Unable to create bmc symlink: %d\n",
 		       rv);
 		goto out_err;
 	}
 
-	size = snprintf(dummy, 0, "ipmi%d", intf->intf_num);
+	size = snprintf(dummy, 0, "ipmi%d", ifnum);
 	intf->my_dev_name = kmalloc(size+1, GFP_KERNEL);
 	if (!intf->my_dev_name) {
+		kfree(intf->sysfs_name);
+		intf->sysfs_name = NULL;
 		rv = -ENOMEM;
 		printk(KERN_ERR
 		       "ipmi_msghandler: allocate link from BMC: %d\n",
 		       rv);
 		goto out_err;
 	}
-	snprintf(intf->my_dev_name, size+1, "ipmi%d", intf->intf_num);
+	snprintf(intf->my_dev_name, size+1, "ipmi%d", ifnum);
 
 	rv = sysfs_create_link(&bmc->dev->dev.kobj, &intf->si_dev->kobj,
 			       intf->my_dev_name);
 	if (rv) {
+		kfree(intf->sysfs_name);
+		intf->sysfs_name = NULL;
 		kfree(intf->my_dev_name);
 		intf->my_dev_name = NULL;
 		printk(KERN_ERR
@@ -2464,6 +2485,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 		      void		       *send_info,
 		      struct ipmi_device_id    *device_id,
 		      struct device            *si_dev,
+		      const char               *sysfs_name,
 		      unsigned char            slave_addr)
 {
 	int              i, j;
@@ -2579,7 +2601,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	if (rv == 0)
 		rv = add_proc_entries(intf, i);
 
-	rv = ipmi_bmc_register(intf);
+	rv = ipmi_bmc_register(intf, i, sysfs_name);
 
  out:
 	if (rv) {
Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
@@ -2362,6 +2362,7 @@ static int try_smi_init(struct smi_info 
 			       new_smi,
 			       &new_smi->device_id,
 			       new_smi->dev,
+			       "bmc",
 			       new_smi->slave_addr);
 	if (rv) {
 		printk(KERN_ERR
Index: linux-2.6.19-rc6/include/linux/ipmi_smi.h
===================================================================
--- linux-2.6.19-rc6.orig/include/linux/ipmi_smi.h
+++ linux-2.6.19-rc6/include/linux/ipmi_smi.h
@@ -173,6 +173,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 		      void                     *send_info,
 		      struct ipmi_device_id    *device_id,
 		      struct device            *dev,
+		      const char               *sysfs_name,
 		      unsigned char            slave_addr);
 
 /*
