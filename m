Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263181AbVGOC6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbVGOC6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbVGOC6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:58:55 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:24567 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S263181AbVGOC6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:58:54 -0400
Date: Thu, 14 Jul 2005 21:58:46 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] I2C-MPC: Restore code removed
Message-ID: <Pine.LNX.4.61.0507142157350.14920@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

If we can get this to Linus before 2.6.13 is released that would be a good 
thing.

I2C-MPC: Restore code removed

A previous patch to remove support for the OCP device model was way
to generious and moved some of the platform device model code, oops.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 0a224850142b1169b5a67735e51268057d24b833
tree fd8ba3598b6ba6585e2dd90c2d53138d7e6c7d17
parent 1eccf76f7b943d1e4b722c7f0847876127cad8b7
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 14 Jul 2005 21:41:36 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 14 Jul 2005 21:41:36 -0500

 drivers/i2c/busses/i2c-mpc.c |   94 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -288,6 +288,100 @@ static struct i2c_adapter mpc_ops = {
 	.retries = 1
 };
 
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
+					  SA_SHIRQ, "i2c-mpc", i2c)) < 0) {
+			printk(KERN_ERR
+			       "i2c-mpc - failed to attach interrupt\n");
+			goto fail_irq;
+		}
+
+	mpc_i2c_setclock(i2c);
+	dev_set_drvdata(device, i2c);
+
+	i2c->adap = mpc_ops;
+	i2c_set_adapdata(&i2c->adap, i2c);
+	i2c->adap.dev.parent = &pdev->dev;
+	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
+		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
+		goto fail_add;
+	}
+
+	return result;
+
+      fail_add:
+	if (i2c->irq != 0)
+		free_irq(i2c->irq, NULL);
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
+	i2c_del_adapter(&i2c->adap);
+	dev_set_drvdata(device, NULL);
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
 MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
 MODULE_DESCRIPTION
     ("I2C-Bus adapter for MPC107 bridge and MPC824x/85xx/52xx processors");
