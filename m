Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUE1Waa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUE1Waa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbUE1WHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:07:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:36542 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264108AbUE1WBb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:01:31 -0400
Subject: Re: [PATCH] I2C update for 2.6.7-rc1
In-Reply-To: <10857816433297@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 28 May 2004 15:00:43 -0700
Message-Id: <10857816433753@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.6.25, 2004/05/19 00:25:35-07:00, ebs@ebshome.net

[PATCH] I2C PPC4xx IIC driver: upgrade to new OCP infrastructre

this patch changes IBM PPC4xx IIC driver to support new PPC OCP infrastructure
recently added to 2.6 kernel.


 drivers/i2c/busses/i2c-ibm_iic.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	Fri May 28 14:52:27 2004
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Fri May 28 14:52:27 2004
@@ -3,7 +3,7 @@
  *
  * Support for the IIC peripheral on IBM PPC 4xx
  *
- * Copyright (c) 2003 Zultys Technologies.
+ * Copyright (c) 2003, 2004 Zultys Technologies.
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
  * Based on original work by 
@@ -45,7 +45,7 @@
 
 #include "i2c-ibm_iic.h"
 
-#define DRIVER_VERSION "2.0"
+#define DRIVER_VERSION "2.01"
 
 MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
 MODULE_LICENSE("GPL");
@@ -549,19 +549,24 @@
 
 	struct ibm_iic_private* dev;
 	struct i2c_adapter* adap;
+	struct ocp_func_iic_data* iic_data = ocp->def->additions;
 	int ret;
-	bd_t* bd = (bd_t*)&__res;
 	
+	if (!iic_data)
+		printk(KERN_WARNING"ibm-iic%d: missing additional data!\n",
+			ocp->def->index);
+
 	if (!(dev = kmalloc(sizeof(*dev), GFP_KERNEL))){
-		printk(KERN_CRIT "ibm-iic: failed to allocate device data\n");
+		printk(KERN_CRIT "ibm-iic%d: failed to allocate device data\n",
+			ocp->def->index);
 		return -ENOMEM;
 	}
 
 	memset(dev, 0, sizeof(*dev));
-	dev->idx = ocp->num;
+	dev->idx = ocp->def->index;
 	ocp_set_drvdata(ocp, dev);
 	
-	if (!(dev->vaddr = ioremap(ocp->paddr, sizeof(struct iic_regs)))){
+	if (!(dev->vaddr = ioremap(ocp->def->paddr, sizeof(struct iic_regs)))){
 		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
 			dev->idx);
 		ret = -ENXIO;
@@ -570,7 +575,7 @@
 	
 	init_waitqueue_head(&dev->wq);
 
-	dev->irq = iic_force_poll ? -1 : ocp->irq;
+	dev->irq = iic_force_poll ? -1 : ocp->def->irq;
 	if (dev->irq >= 0){
 		/* Disable interrupts until we finish intialization,
 		   assumes level-sensitive IRQ setup...
@@ -589,13 +594,12 @@
 			dev->idx);
 		
 	/* Board specific settings */
-	BUG_ON(dev->idx >= sizeof(bd->bi_iic_fast) / sizeof(bd->bi_iic_fast[0]));
-	dev->fast_mode = iic_force_fast ? 1 : bd->bi_iic_fast[dev->idx];
+	dev->fast_mode = iic_force_fast ? 1 : (iic_data ? iic_data->fast_mode : 0);
 	
 	/* clckdiv is the same for *all* IIC interfaces, 
 	 * but I'd rather make a copy than introduce another global. --ebs
 	 */
-	dev->clckdiv = iic_clckdiv(bd->bi_opb_busfreq);
+	dev->clckdiv = iic_clckdiv(ocp_sys_info.opb_bus_freq);
 	DBG("%d: clckdiv = %d\n", dev->idx, dev->clckdiv);
 	
 	/* Initialize IIC interface */
@@ -664,7 +668,7 @@
 
 static struct ocp_device_id ibm_iic_ids[] __devinitdata = 
 {
-	{ .vendor = OCP_VENDOR_IBM, .device = OCP_FUNC_IIC },
+	{ .vendor = OCP_VENDOR_IBM, .function = OCP_FUNC_IIC },
 	{ .vendor = OCP_VENDOR_INVALID }
 };
 
@@ -672,7 +676,7 @@
 
 static struct ocp_driver ibm_iic_driver =
 {
-	.name 		= "ocp_iic",
+	.name 		= "iic",
 	.id_table	= ibm_iic_ids,
 	.probe		= iic_probe,
 	.remove		= __devexit_p(iic_remove),
@@ -685,7 +689,7 @@
 static int __init iic_init(void)
 {
 	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
-	return ocp_module_init(&ibm_iic_driver);
+	return ocp_register_driver(&ibm_iic_driver);
 }
 
 static void __exit iic_exit(void)

