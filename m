Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVG2TSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVG2TSS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVG2TP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:15:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:33966 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262737AbVG2TPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:15:03 -0400
Date: Fri, 29 Jul 2005 12:14:40 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kumar.gala@freescale.com
Subject: [patch 06/29] I2C-MPC: Restore code removed
Message-ID: <20050729191440.GH5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kumar Gala <galak@freescale.com>

I2C-MPC: Restore code removed

A previous patch to remove support for the OCP device model was way
to generious and moved some of the platform device model code, oops.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/busses/i2c-mpc.c |   94 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+)

--- gregkh-2.6.orig/drivers/i2c/busses/i2c-mpc.c	2005-07-29 11:30:00.000000000 -0700
+++ gregkh-2.6/drivers/i2c/busses/i2c-mpc.c	2005-07-29 11:34:01.000000000 -0700
@@ -382,6 +382,100 @@
 module_init(fsl_i2c_init);
 module_exit(fsl_i2c_exit);
 
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

--
