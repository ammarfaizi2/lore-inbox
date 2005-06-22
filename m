Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVFVV1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVFVV1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVFVVZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:25:30 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:7932 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262327AbVFVVJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:09:17 -0400
Date: Wed, 22 Jun 2005 16:09:02 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       sensors@stimpy.netroedge.com
Subject: [PATCH] I2C-MPC: Remove OCP device model support  
Message-ID: <Pine.LNX.4.61.0506221607500.3291@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All consumers of the driver MPC10x, MPC52xx, MPC824x, MPC83xx,
and MPC85xx are all using platform devices.  We can get ride of
the dead code to support using this driver with the old OCP based
model

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 8589d0b1ac6dc3ab9aaee30eb943c2d231e28685
tree 1b9b8e9193c4118d652e70138bf389f9d771ff03
parent 96590616b248746bfc06dad1cb5b956b006f8926
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 17:35:30 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 17:35:30 -0500

 drivers/i2c/busses/i2c-mpc.c |  204 ------------------------------------------
 1 files changed, 0 insertions(+), 204 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -20,13 +20,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
-#ifdef CONFIG_FSL_OCP
-#include <asm/ocp.h>
-#define FSL_I2C_DEV_SEPARATE_DFSRR FS_I2C_SEPARATE_DFSRR
-#define FSL_I2C_DEV_CLOCK_5200 FS_I2C_CLOCK_5200
-#else
 #include <linux/fsl_devices.h>
-#endif
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -293,204 +287,6 @@ static struct i2c_adapter mpc_ops = {
 	.timeout = 1,
 	.retries = 1
 };
-
-#ifdef CONFIG_FSL_OCP
-static int __devinit mpc_i2c_probe(struct ocp_device *ocp)
-{
-	int result = 0;
-	struct mpc_i2c *i2c;
-
-	if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
-		return -ENOMEM;
-	}
-	memset(i2c, 0, sizeof(*i2c));
-
-	i2c->irq = ocp->def->irq;
-	i2c->flags = ((struct ocp_fs_i2c_data *)ocp->def->additions)->flags;
-	init_waitqueue_head(&i2c->queue);
-
-	if (!request_mem_region(ocp->def->paddr, MPC_I2C_REGION, "i2c-mpc")) {
-		printk(KERN_ERR "i2c-mpc - resource unavailable\n");
-		return -ENODEV;
-	}
-
-	i2c->base = ioremap(ocp->def->paddr, MPC_I2C_REGION);
-
-	if (!i2c->base) {
-		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
-		result = -ENOMEM;
-		goto fail_map;
-	}
-
-	if (i2c->irq != OCP_IRQ_NA)
-	{
-		if ((result = request_irq(ocp->def->irq, mpc_i2c_isr,
-					  SA_SHIRQ, "i2c-mpc", i2c)) < 0) {
-			printk(KERN_ERR
-			       "i2c-mpc - failed to attach interrupt\n");
-			goto fail_irq;
-		}
-	} else
-		i2c->irq = 0;
-
-	mpc_i2c_setclock(i2c);
-	ocp_set_drvdata(ocp, i2c);
-
-	i2c->adap = mpc_ops;
-	i2c_set_adapdata(&i2c->adap, i2c);
-
-	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
-		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
-		goto fail_add;
-	}
-
-	return result;
-
-      fail_add:
-	if (ocp->def->irq != OCP_IRQ_NA)
-		free_irq(ocp->def->irq, 0);
-      fail_irq:
-	iounmap(i2c->base);
-      fail_map:
-	release_mem_region(ocp->def->paddr, MPC_I2C_REGION);
-	kfree(i2c);
-	return result;
-}
-static void __devexit mpc_i2c_remove(struct ocp_device *ocp)
-{
-	struct mpc_i2c *i2c = ocp_get_drvdata(ocp);
-	i2c_del_adapter(&i2c->adap);
-	ocp_set_drvdata(ocp, NULL);
-
-	if (ocp->def->irq != OCP_IRQ_NA)
-		free_irq(i2c->irq, i2c);
-	iounmap(i2c->base);
-	release_mem_region(ocp->def->paddr, MPC_I2C_REGION);
-	kfree(i2c);
-}
-
-static struct ocp_device_id mpc_iic_ids[] __devinitdata = {
-	{.vendor = OCP_VENDOR_FREESCALE,.function = OCP_FUNC_IIC},
-	{.vendor = OCP_VENDOR_INVALID}
-};
-
-MODULE_DEVICE_TABLE(ocp, mpc_iic_ids);
-
-static struct ocp_driver mpc_iic_driver = {
-	.name = "iic",
-	.id_table = mpc_iic_ids,
-	.probe = mpc_i2c_probe,
-	.remove = __devexit_p(mpc_i2c_remove)
-};
-
-static int __init iic_init(void)
-{
-	return ocp_register_driver(&mpc_iic_driver);
-}
-
-static void __exit iic_exit(void)
-{
-	ocp_unregister_driver(&mpc_iic_driver);
-}
-
-module_init(iic_init);
-module_exit(iic_exit);
-#else
-static int fsl_i2c_probe(struct device *device)
-{
-	int result = 0;
-	struct mpc_i2c *i2c;
-	struct platform_device *pdev = to_platform_device(device);
-	struct fsl_i2c_platform_data *pdata;
-	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
-
-	if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
-		return -ENOMEM;
-	}
-	memset(i2c, 0, sizeof(*i2c));
-
-	i2c->irq = platform_get_irq(pdev, 0);
-	i2c->flags = pdata->device_flags;
-	init_waitqueue_head(&i2c->queue);
-
-	i2c->base = ioremap((phys_addr_t)r->start, MPC_I2C_REGION);
-
-	if (!i2c->base) {
-		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
-		result = -ENOMEM;
-		goto fail_map;
-	}
-
-	if (i2c->irq != 0)
-		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
-					  SA_SHIRQ, "i2c-mpc", i2c)) < 0) {
-			printk(KERN_ERR
-			       "i2c-mpc - failed to attach interrupt\n");
-			goto fail_irq;
-		}
-
-	mpc_i2c_setclock(i2c);
-	dev_set_drvdata(device, i2c);
-
-	i2c->adap = mpc_ops;
-	i2c_set_adapdata(&i2c->adap, i2c);
-	i2c->adap.dev.parent = &pdev->dev;
-	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
-		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
-		goto fail_add;
-	}
-
-	return result;
-
-      fail_add:
-	if (i2c->irq != 0)
-		free_irq(i2c->irq, NULL);
-      fail_irq:
-	iounmap(i2c->base);
-      fail_map:
-	kfree(i2c);
-	return result;
-};
-
-static int fsl_i2c_remove(struct device *device)
-{
-	struct mpc_i2c *i2c = dev_get_drvdata(device);
-
-	i2c_del_adapter(&i2c->adap);
-	dev_set_drvdata(device, NULL);
-
-	if (i2c->irq != 0)
-		free_irq(i2c->irq, i2c);
-
-	iounmap(i2c->base);
-	kfree(i2c);
-	return 0;
-};
-
-/* Structure for a device driver */
-static struct device_driver fsl_i2c_driver = {
-	.name = "fsl-i2c",
-	.bus = &platform_bus_type,
-	.probe = fsl_i2c_probe,
-	.remove = fsl_i2c_remove,
-};
-
-static int __init fsl_i2c_init(void)
-{
-	return driver_register(&fsl_i2c_driver);
-}
-
-static void __exit fsl_i2c_exit(void)
-{
-	driver_unregister(&fsl_i2c_driver);
-}
-
-module_init(fsl_i2c_init);
-module_exit(fsl_i2c_exit);
-
-#endif /* CONFIG_FSL_OCP */
 
 MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
 MODULE_DESCRIPTION
