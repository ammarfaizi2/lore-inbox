Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTFYBKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTFYBKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:10:44 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:62094 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263279AbTFYBKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:10:19 -0400
Date: Tue, 24 Jun 2003 20:59:18 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP Fixes for 2.5.73
Message-ID: <20030624205918.GC14945@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1386  -> 1.1387 
#	drivers/pnp/pnpbios/core.c	1.32    -> 1.33   
#	drivers/pnp/interface.c	1.16    -> 1.17   
#	drivers/pnp/support.c	1.5     -> 1.6    
#	drivers/pnp/isapnp/core.c	1.38    -> 1.39   
#	drivers/pnp/manager.c	1.7     -> 1.8    
#	 include/linux/pnp.h	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/24	ambx1@neo.rr.com	1.1387
# [PNP] pnp_init_resource_table compile fix
# 
# In the last release, this api was accidently changed and therefore 
# affected some drivers.  This patch corrects the issue by renaming
# the api back to pnp_init_resource_table.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Tue Jun 24 20:34:23 2003
+++ b/drivers/pnp/interface.c	Tue Jun 24 20:34:23 2003
@@ -323,14 +323,14 @@
 	if (!strnicmp(buf,"auto",4)) {
 		if (dev->active)
 			goto done;
-		pnp_init_resources(&dev->res);
+		pnp_init_resource_table(&dev->res);
 		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
 	if (!strnicmp(buf,"clear",5)) {
 		if (dev->active)
 			goto done;
-		pnp_init_resources(&dev->res);
+		pnp_init_resource_table(&dev->res);
 		goto done;
 	}
 	if (!strnicmp(buf,"get",3)) {
@@ -345,7 +345,7 @@
 		if (dev->active)
 			goto done;
 		buf += 3;
-		pnp_init_resources(&dev->res);
+		pnp_init_resource_table(&dev->res);
 		down(&pnp_res_mutex);
 		while (1) {
 			while (isspace(*buf))
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Tue Jun 24 20:34:23 2003
+++ b/drivers/pnp/isapnp/core.c	Tue Jun 24 20:34:23 2003
@@ -458,7 +458,7 @@
 	dev->capabilities |= PNP_READ;
 	dev->capabilities |= PNP_WRITE;
 	dev->capabilities |= PNP_DISABLE;
-	pnp_init_resources(&dev->res);
+	pnp_init_resource_table(&dev->res);
 	return dev;
 }
 
@@ -1020,7 +1020,7 @@
 static int isapnp_get_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
 {
 	int ret;
-	pnp_init_resources(res);
+	pnp_init_resource_table(res);
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	ret = isapnp_read_resources(dev, res);
 	isapnp_cfg_end();
diff -Nru a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Tue Jun 24 20:34:23 2003
+++ b/drivers/pnp/manager.c	Tue Jun 24 20:34:23 2003
@@ -190,7 +190,7 @@
  * @table: pointer to the desired resource table
  *
  */
-void pnp_init_resources(struct pnp_resource_table *table)
+void pnp_init_resource_table(struct pnp_resource_table *table)
 {
 	int idx;
 	down(&pnp_res_mutex);
@@ -226,7 +226,7 @@
  * @res - the resources to clean
  *
  */
-static void pnp_clean_resources(struct pnp_resource_table * res)
+static void pnp_clean_resource_table(struct pnp_resource_table * res)
 {
 	int idx;
 	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
@@ -278,7 +278,7 @@
 		return -ENODEV;
 
 	down(&pnp_res_mutex);
-	pnp_clean_resources(&dev->res); /* start with a fresh slate */
+	pnp_clean_resource_table(&dev->res); /* start with a fresh slate */
 	if (dev->independent) {
 		port = dev->independent->port;
 		mem = dev->independent->mem;
@@ -351,7 +351,7 @@
 	return 1;
 
 fail:
-	pnp_clean_resources(&dev->res);
+	pnp_clean_resource_table(&dev->res);
 	up(&pnp_res_mutex);
 	return 0;
 }
@@ -510,7 +510,7 @@
 
 	/* release the resources so that other devices can use them */
 	down(&pnp_res_mutex);
-	pnp_clean_resources(&dev->res);
+	pnp_clean_resource_table(&dev->res);
 	up(&pnp_res_mutex);
 
 	return 1;
@@ -539,4 +539,4 @@
 EXPORT_SYMBOL(pnp_activate_dev);
 EXPORT_SYMBOL(pnp_disable_dev);
 EXPORT_SYMBOL(pnp_resource_change);
-EXPORT_SYMBOL(pnp_init_resources);
+EXPORT_SYMBOL(pnp_init_resource_table);
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Tue Jun 24 20:34:23 2003
+++ b/drivers/pnp/pnpbios/core.c	Tue Jun 24 20:34:23 2003
@@ -937,7 +937,7 @@
 
 	/* clear out the damaged flags */
 	if (!dev->active)
-		pnp_init_resources(&dev->res);
+		pnp_init_resource_table(&dev->res);
 
 	pnp_add_device(dev);
 	pnpbios_interface_attach_device(node);
diff -Nru a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	Tue Jun 24 20:34:23 2003
+++ b/drivers/pnp/support.c	Tue Jun 24 20:34:23 2003
@@ -123,7 +123,7 @@
 		return NULL;
 
 	/* Blank the resource table values */
-	pnp_init_resources(res);
+	pnp_init_resource_table(res);
 
 	while ((char *)p < (char *)end) {
 
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Tue Jun 24 20:34:23 2003
+++ b/include/linux/pnp.h	Tue Jun 24 20:34:23 2003
@@ -400,7 +400,7 @@
 int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data);
 int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data);
 int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data);
-void pnp_init_resources(struct pnp_resource_table *table);
+void pnp_init_resource_table(struct pnp_resource_table *table);
 int pnp_assign_resources(struct pnp_dev *dev, int depnum);
 int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode);
 int pnp_auto_config_dev(struct pnp_dev *dev);
@@ -448,7 +448,7 @@
 static inline int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data) { return -ENODEV; }
 static inline int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data) { return -ENODEV; }
 static inline int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data) { return -ENODEV; }
-static inline void pnp_init_resources(struct pnp_resource_table *table) { }
+static inline void pnp_init_resource_table(struct pnp_resource_table *table) { }
 static inline int pnp_assign_resources(struct pnp_dev *dev, int depnum) { return -ENODEV; }
 static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
