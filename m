Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVANDlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVANDlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVANDjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:39:07 -0500
Received: from motgate8.mot.com ([129.188.136.8]:26611 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261889AbVANDfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:35:39 -0500
Date: Thu, 13 Jan 2005 21:35:32 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: greg@kroah.com
cc: linuxppc-embedded@ozlabs.org, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] I2C-MPC: Convert to platform_device driver
Message-ID: <Pine.LNX.4.61.0501132130580.27720@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Converted the driver to work as either a OCP or platform_device driver.  
The intent in the future (once we convert all PPC sub-archs from OCP to 
platform_device) is to remove the OCP code.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2005-01-13 21:27:38 -06:00
+++ b/drivers/i2c/busses/Kconfig	2005-01-13 21:27:38 -06:00
@@ -208,7 +208,7 @@
 
 config I2C_MPC
 	tristate "MPC107/824x/85xx/52xx"
-	depends on I2C && FSL_OCP
+	depends on I2C && PPC
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
diff -Nru a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c	2005-01-13 21:27:38 -06:00
+++ b/drivers/i2c/busses/i2c-mpc.c	2005-01-13 21:27:38 -06:00
@@ -1,12 +1,12 @@
 /*
  * (C) Copyright 2003-2004
  * Humboldt Solutions Ltd, adrian@humboldt.co.uk.
- 
+
  * This is a combined i2c adapter and algorithm driver for the
  * MPC107/Tsi107 PowerPC northbridge and processors that include
- * the same I2C unit (8240, 8245, 85xx). 
+ * the same I2C unit (8240, 8245, 85xx).
  *
- * Release 0.7
+ * Release 0.8
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -20,7 +20,13 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
+#ifdef CONFIG_FSL_OCP
 #include <asm/ocp.h>
+#define FSL_I2C_DEV_SEPARATE_DFSRR FS_I2C_SEPARATE_DFSRR
+#define FSL_I2C_DEV_CLOCK_5200 FS_I2C_CLOCK_5200
+#else
+#include <linux/fsl_devices.h>
+#endif
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -50,10 +56,11 @@
 
 struct mpc_i2c {
 	char *base;
-	struct ocp_def *ocpdef;
 	u32 interrupt;
 	wait_queue_head_t queue;
 	struct i2c_adapter adap;
+	int irq;
+	u32 flags;
 };
 
 static __inline__ void writeccr(struct mpc_i2c *i2c, u32 x)
@@ -79,7 +86,8 @@
 	u32 x;
 	int result = 0;
 
-	if (i2c->ocpdef->irq == OCP_IRQ_NA) {
+	if (i2c->irq == 0)
+	{
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
 			if (time_after(jiffies, orig_jiffies + timeout)) {
@@ -92,7 +100,7 @@
 		writeb(0, i2c->base + MPC_I2C_SR);
 	} else {
 		/* Interrupt mode */
-		result = wait_event_interruptible_timeout(i2c->queue, 
+		result = wait_event_interruptible_timeout(i2c->queue,
 			(i2c->interrupt & CSR_MIF), timeout * HZ);
 
 		if (unlikely(result < 0))
@@ -130,12 +138,11 @@
 
 static void mpc_i2c_setclock(struct mpc_i2c *i2c)
 {
-	struct ocp_fs_i2c_data *i2c_data = i2c->ocpdef->additions;
 	/* Set clock and filters */
-	if (i2c_data && (i2c_data->flags & FS_I2C_SEPARATE_DFSRR)) {
+	if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
 		writeb(0x31, i2c->base + MPC_I2C_FDR);
 		writeb(0x10, i2c->base + MPC_I2C_DFSRR);
-	} else if (i2c_data && (i2c_data->flags & FS_I2C_CLOCK_5200))
+	} else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
 		writeb(0x3f, i2c->base + MPC_I2C_FDR);
 	else
 		writel(0x1031, i2c->base + MPC_I2C_FDR);
@@ -287,6 +294,7 @@
 	.retries = 1
 };
 
+#ifdef CONFIG_FSL_OCP
 static int __devinit mpc_i2c_probe(struct ocp_device *ocp)
 {
 	int result = 0;
@@ -296,7 +304,9 @@
 		return -ENOMEM;
 	}
 	memset(i2c, 0, sizeof(*i2c));
-	i2c->ocpdef = ocp->def;
+
+	i2c->irq = ocp->def->irq;
+	i2c->flags = ((struct ocp_fs_i2c_data *)ocp->def->additions)->flags;
 	init_waitqueue_head(&i2c->queue);
 
 	if (!request_mem_region(ocp->def->paddr, MPC_I2C_REGION, "i2c-mpc")) {
@@ -312,16 +322,20 @@
 		goto fail_map;
 	}
 
-	if (ocp->def->irq != OCP_IRQ_NA)
+	if (i2c->irq != OCP_IRQ_NA)
+	{
 		if ((result = request_irq(ocp->def->irq, mpc_i2c_isr,
 					  0, "i2c-mpc", i2c)) < 0) {
 			printk(KERN_ERR
 			       "i2c-mpc - failed to attach interrupt\n");
 			goto fail_irq;
 		}
+	} else
+		i2c->irq = 0;
 
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
+
 	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
@@ -348,9 +362,9 @@
 	i2c_del_adapter(&i2c->adap);
 
 	if (ocp->def->irq != OCP_IRQ_NA)
-		free_irq(i2c->ocpdef->irq, i2c);
+		free_irq(i2c->irq, i2c);
 	iounmap(i2c->base);
-	release_mem_region(i2c->ocpdef->paddr, MPC_I2C_REGION);
+	release_mem_region(ocp->def->paddr, MPC_I2C_REGION);
 	kfree(i2c);
 }
 
@@ -380,6 +394,101 @@
 
 module_init(iic_init);
 module_exit(iic_exit);
+#else
+static int fsl_i2c_probe(struct device *device)
+{
+	int result = 0;
+	struct mpc_i2c *i2c;
+	struct platform_device *pdev = to_platform_device(device);
+	struct fsl_i2c_platform_data *pdata;
+	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
+
+	if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
+		return -ENOMEM;
+	}
+	memset(i2c, 0, sizeof(*i2c));
+
+	i2c->irq = platform_get_irq(pdev, 0);
+	i2c->flags = pdata->device_flags;
+	init_waitqueue_head(&i2c->queue);
+
+	i2c->base = ioremap((phys_addr_t)r->start, MPC_I2C_REGION);
+
+	if (!i2c->base) {
+		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
+		result = -ENOMEM;
+		goto fail_map;
+	}
+
+	if (i2c->irq != 0)
+		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
+					  0, "fsl-i2c", i2c)) < 0) {
+			printk(KERN_ERR
+			       "i2c-mpc - failed to attach interrupt\n");
+			goto fail_irq;
+		}
+
+	i2c->adap = mpc_ops;
+	i2c_set_adapdata(&i2c->adap, i2c);
+	i2c->adap.dev.parent = &pdev->dev;
+	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
+		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
+		goto fail_add;
+	}
+
+	mpc_i2c_setclock(i2c);
+	dev_set_drvdata(device, i2c);
+	return result;
+
+      fail_add:
+	if (i2c->irq != 0)
+		free_irq(i2c->irq, 0);
+      fail_irq:
+	iounmap(i2c->base);
+      fail_map:
+	kfree(i2c);
+	return result;
+};
+
+static int fsl_i2c_remove(struct device *device)
+{
+	struct mpc_i2c *i2c = dev_get_drvdata(device);
+
+	dev_set_drvdata(device, NULL);
+	i2c_del_adapter(&i2c->adap);
+
+	if (i2c->irq != 0)
+		free_irq(i2c->irq, i2c);
+
+	iounmap(i2c->base);
+	kfree(i2c);
+	return 0;
+};
+
+/* Structure for a device driver */
+static struct device_driver fsl_i2c_driver = {
+	.name = "fsl-i2c",
+	.bus = &platform_bus_type,
+	.probe = fsl_i2c_probe,
+	.remove = fsl_i2c_remove,
+};
+
+static int __init fsl_i2c_init(void)
+{
+	return driver_register(&fsl_i2c_driver);
+}
+
+static void __exit fsl_i2c_exit(void)
+{
+	driver_unregister(&fsl_i2c_driver);
+}
+
+module_init(fsl_i2c_init);
+module_exit(fsl_i2c_exit);
+
+#endif /* CONFIG_FSL_OCP */
 
 MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
 MODULE_DESCRIPTION
