Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVKESSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVKESSI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVKESSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:18:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31505 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932162AbVKESSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:18:03 -0500
Date: Sat, 5 Nov 2005 18:17:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert i2c drivers
Message-ID: <20051105181757.GN14419@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105181122.GD12228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105181122.GD12228@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform drivers to use struct platform_driver

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/hwmon/hdaps.c b/drivers/hwmon/hdaps.c
--- b/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -284,7 +284,7 @@
 
 /* Device model stuff */
 
-static int hdaps_probe(struct device *dev)
+static int hdaps_probe(struct platform_device *dev)
 {
 	int ret;
 
@@ -296,17 +296,18 @@
 	return 0;
 }
 
-static int hdaps_resume(struct device *dev)
+static int hdaps_resume(struct platform_device *dev)
 {
 	return hdaps_device_init();
 }
 
-static struct device_driver hdaps_driver = {
-	.name = "hdaps",
-	.bus = &platform_bus_type,
-	.owner = THIS_MODULE,
+static struct platform_driver hdaps_driver = {
 	.probe = hdaps_probe,
-	.resume = hdaps_resume
+	.resume = hdaps_resume,
+	.driver	= {
+		.name = "hdaps",
+		.owner = THIS_MODULE,
+	},
 };
 
 /* Input class stuff */
@@ -550,7 +551,7 @@
 		goto out;
 	}
 
-	ret = driver_register(&hdaps_driver);
+	ret = platform_driver_register(&hdaps_driver);
 	if (ret)
 		goto out_region;
 
@@ -583,7 +584,7 @@
 out_device:
 	platform_device_unregister(pdev);
 out_driver:
-	driver_unregister(&hdaps_driver);
+	platform_driver_unregister(&hdaps_driver);
 out_region:
 	release_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS);
 out:
@@ -597,7 +598,7 @@
 	input_unregister_device(&hdaps_idev);
 	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 	platform_device_unregister(pdev);
-	driver_unregister(&hdaps_driver);
+	platform_driver_unregister(&hdaps_driver);
 	release_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS);
 
 	printk(KERN_INFO "hdaps: driver unloaded.\n");
diff -u b/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
--- b/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -405,10 +405,9 @@
 };
 
 static int 
-iop3xx_i2c_remove(struct device *device)
+iop3xx_i2c_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(device);
-	struct i2c_adapter *padapter = dev_get_drvdata(&pdev->dev);
+	struct i2c_adapter *padapter = platform_get_drvdata(pdev);
 	struct i2c_algo_iop3xx_data *adapter_data = 
 		(struct i2c_algo_iop3xx_data *)padapter->algo_data;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -426,15 +425,14 @@
 	kfree(adapter_data);
 	kfree(padapter);
 
-	dev_set_drvdata(&pdev->dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
 
 static int 
-iop3xx_i2c_probe(struct device *dev)
+iop3xx_i2c_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
 	int ret;
 	struct i2c_adapter *new_adapter;
@@ -499,7 +497,7 @@
 	iop3xx_i2c_set_slave_addr(adapter_data);
 	iop3xx_i2c_enable(adapter_data);
 
-	dev_set_drvdata(&pdev->dev, new_adapter);
+	platform_set_drvdata(pdev, new_adapter);
 	new_adapter->algo_data = adapter_data;
 
 	i2c_add_adapter(new_adapter);
@@ -523,24 +521,25 @@ out:
 }
 
 
-static struct device_driver iop3xx_i2c_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "IOP3xx-I2C",
-	.bus		= &platform_bus_type,
+static struct platform_driver iop3xx_i2c_driver = {
 	.probe		= iop3xx_i2c_probe,
 	.remove		= iop3xx_i2c_remove
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "IOP3xx-I2C",
+	},
 };
 
 static int __init 
 i2c_iop3xx_init (void)
 {
-	return driver_register(&iop3xx_i2c_driver);
+	return platform_driver_register(&iop3xx_i2c_driver);
 }
 
 static void __exit 
 i2c_iop3xx_exit (void)
 {
-	driver_unregister(&iop3xx_i2c_driver);
+	platform_driver_unregister(&iop3xx_i2c_driver);
 	return;
 }
 
diff -u b/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
--- b/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -86,12 +86,11 @@
 	struct i2c_algo_bit_data algo_data;
 };
 
-static int ixp2000_i2c_remove(struct device *dev)
+static int ixp2000_i2c_remove(struct platform_device *plat_dev)
 {
-	struct platform_device *plat_dev = to_platform_device(dev);
-	struct ixp2000_i2c_data *drv_data = dev_get_drvdata(&plat_dev->dev);
+	struct ixp2000_i2c_data *drv_data = platform_get_drvdata(plat_dev);
 
-	dev_set_drvdata(&plat_dev->dev, NULL);
+	platform_set_drvdata(plat_dev, NULL);
 
 	i2c_bit_del_bus(&drv_data->adapter);
 
@@ -100,10 +99,9 @@
 	return 0;
 }
 
-static int ixp2000_i2c_probe(struct device *dev)
+static int ixp2000_i2c_probe(struct platform_device *plat_dev)
 {
 	int err;
-	struct platform_device *plat_dev = to_platform_device(dev);
 	struct ixp2000_i2c_pins *gpio = plat_dev->dev.platform_data;
 	struct ixp2000_i2c_data *drv_data = 
 		kzalloc(sizeof(struct ixp2000_i2c_data), GFP_KERNEL);
@@ -139,7 +137,7 @@
 		return err;
 	} 
 
-	dev_set_drvdata(&plat_dev->dev, drv_data);
+	platform_set_drvdata(plat_dev, drv_data);
 
 	return 0;
 }
@@ -144,22 +142,23 @@ static int ixp2000_i2c_probe(struct devi
 	return 0;
 }
 
-static struct device_driver ixp2000_i2c_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "IXP2000-I2C",
-	.bus		= &platform_bus_type,
+static struct platform_driver ixp2000_i2c_driver = {
 	.probe		= ixp2000_i2c_probe,
 	.remove		= ixp2000_i2c_remove,
+	.driver		= {
+		.name	= "IXP2000-I2C",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static int __init ixp2000_i2c_init(void)
 {
-	return driver_register(&ixp2000_i2c_driver);
+	return platform_driver_register(&ixp2000_i2c_driver);
 }
 
 static void __exit ixp2000_i2c_exit(void)
 {
-	driver_unregister(&ixp2000_i2c_driver);
+	platform_driver_unregister(&ixp2000_i2c_driver);
 }
 
 module_init(ixp2000_i2c_init);
diff -u b/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
--- b/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -87,12 +87,11 @@
 	struct i2c_algo_bit_data algo_data;
 };
 
-static int ixp4xx_i2c_remove(struct device *dev)
+static int ixp4xx_i2c_remove(struct platform_device *plat_dev)
 {
-	struct platform_device *plat_dev = to_platform_device(dev);
-	struct ixp4xx_i2c_data *drv_data = dev_get_drvdata(&plat_dev->dev);
+	struct ixp4xx_i2c_data *drv_data = platform_get_drvdata(plat_dev);
 
-	dev_set_drvdata(&plat_dev->dev, NULL);
+	platform_set_drvdata(plat_dev, NULL);
 
 	i2c_bit_del_bus(&drv_data->adapter);
 
@@ -101,10 +100,9 @@
 	return 0;
 }
 
-static int ixp4xx_i2c_probe(struct device *dev)
+static int ixp4xx_i2c_probe(struct platform_device *plat_dev)
 {
 	int err;
-	struct platform_device *plat_dev = to_platform_device(dev);
 	struct ixp4xx_i2c_pins *gpio = plat_dev->dev.platform_data;
 	struct ixp4xx_i2c_data *drv_data = 
 		kzalloc(sizeof(struct ixp4xx_i2c_data), GFP_KERNEL);
@@ -148,7 +146,7 @@
 		return err;
 	}
 
-	dev_set_drvdata(&plat_dev->dev, drv_data);
+	platform_set_drvdata(plat_dev, drv_data);
 
 	return 0;
 }
@@ -153,22 +151,23 @@ static int ixp4xx_i2c_probe(struct devic
 	return 0;
 }
 
-static struct device_driver ixp4xx_i2c_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "IXP4XX-I2C",
-	.bus		= &platform_bus_type,
+static struct platform_driver ixp4xx_i2c_driver = {
 	.probe		= ixp4xx_i2c_probe,
 	.remove		= ixp4xx_i2c_remove,
+	.driver		= {
+		.name	= "IXP4XX-I2C",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static int __init ixp4xx_i2c_init(void)
 {
-	return driver_register(&ixp4xx_i2c_driver);
+	return platform_driver_register(&ixp4xx_i2c_driver);
 }
 
 static void __exit ixp4xx_i2c_exit(void)
 {
-	driver_unregister(&ixp4xx_i2c_driver);
+	platform_driver_unregister(&ixp4xx_i2c_driver);
 }
 
 module_init(ixp4xx_i2c_init);
diff -u b/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- b/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -288,11 +288,10 @@
 	.retries = 1
 };
 
-static int fsl_i2c_probe(struct device *device)
+static int fsl_i2c_probe(struct platform_device *pdev)
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
-	struct platform_device *pdev = to_platform_device(device);
 	struct fsl_i2c_platform_data *pdata;
 	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
@@ -323,7 +322,7 @@
 		}
 
 	mpc_i2c_setclock(i2c);
-	dev_set_drvdata(device, i2c);
+	platform_set_drvdata(pdev, i2c);
 
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
@@ -345,12 +344,12 @@
 	return result;
 };
 
-static int fsl_i2c_remove(struct device *device)
+static int fsl_i2c_remove(struct platform_device *pdev)
 {
-	struct mpc_i2c *i2c = dev_get_drvdata(device);
+	struct mpc_i2c *i2c = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&i2c->adap);
-	dev_set_drvdata(device, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	if (i2c->irq != 0)
 		free_irq(i2c->irq, i2c);
@@ -361,22 +360,23 @@ static int fsl_i2c_remove(struct device 
 };
 
 /* Structure for a device driver */
-static struct device_driver fsl_i2c_driver = {
-	.owner = THIS_MODULE,
-	.name = "fsl-i2c",
-	.bus = &platform_bus_type,
+static struct platform_driver fsl_i2c_driver = {
 	.probe = fsl_i2c_probe,
 	.remove = fsl_i2c_remove,
+	.driver	= {
+		.owner = THIS_MODULE,
+		.name = "fsl-i2c",
+	},
 };
 
 static int __init fsl_i2c_init(void)
 {
-	return driver_register(&fsl_i2c_driver);
+	return platform_driver_register(&fsl_i2c_driver);
 }
 
 static void __exit fsl_i2c_exit(void)
 {
-	driver_unregister(&fsl_i2c_driver);
+	platform_driver_unregister(&fsl_i2c_driver);
 }
 
 module_init(fsl_i2c_init);
diff -u b/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
--- b/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -492,11 +492,10 @@
 }
 
 static int __devinit
-mv64xxx_i2c_probe(struct device *dev)
+mv64xxx_i2c_probe(struct platform_device *pd)
 {
-	struct platform_device		*pd = to_platform_device(dev);
 	struct mv64xxx_i2c_data		*drv_data;
-	struct mv64xxx_i2c_pdata	*pdata = dev->platform_data;
+	struct mv64xxx_i2c_pdata	*pdata = pd->dev.platform_data;
 	int	rc;
 
 	if ((pd->id != 0) || !pdata)
@@ -526,7 +525,7 @@
 	drv_data->adapter.class = I2C_CLASS_HWMON;
 	drv_data->adapter.timeout = pdata->timeout;
 	drv_data->adapter.retries = pdata->retries;
-	dev_set_drvdata(dev, drv_data);
+	platform_set_drvdata(pd, drv_data);
 	i2c_set_adapdata(&drv_data->adapter, drv_data);
 
 	if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
@@ -555,9 +554,9 @@
 }
 
 static int __devexit
-mv64xxx_i2c_remove(struct device *dev)
+mv64xxx_i2c_remove(struct platform_device *dev)
 {
-	struct mv64xxx_i2c_data		*drv_data = dev_get_drvdata(dev);
+	struct mv64xxx_i2c_data		*drv_data = platform_get_drvdata(dev);
 	int	rc;
 
 	rc = i2c_del_adapter(&drv_data->adapter);
@@ -568,24 +567,25 @@ mv64xxx_i2c_remove(struct device *dev)
 	return rc;
 }
 
-static struct device_driver mv64xxx_i2c_driver = {
-	.owner	= THIS_MODULE,
-	.name	= MV64XXX_I2C_CTLR_NAME,
-	.bus	= &platform_bus_type,
+static struct platform_driver mv64xxx_i2c_driver = {
 	.probe	= mv64xxx_i2c_probe,
 	.remove	= mv64xxx_i2c_remove,
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= MV64XXX_I2C_CTLR_NAME,
+	},
 };
 
 static int __init
 mv64xxx_i2c_init(void)
 {
-	return driver_register(&mv64xxx_i2c_driver);
+	return platform_driver_register(&mv64xxx_i2c_driver);
 }
 
 static void __exit
 mv64xxx_i2c_exit(void)
 {
-	driver_unregister(&mv64xxx_i2c_driver);
+	platform_driver_unregister(&mv64xxx_i2c_driver);
 }
 
 module_init(mv64xxx_i2c_init);
diff -u b/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
--- b/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -936,10 +936,10 @@
 	},
 };
 
-static int i2c_pxa_probe(struct device *dev)
+static int i2c_pxa_probe(struct platform_device *dev)
 {
 	struct pxa_i2c *i2c = &i2c_pxa;
-	struct i2c_pxa_platform_data *plat = dev->platform_data;
+	struct i2c_pxa_platform_data *plat = dev->dev.platform_data;
 	int ret;
 
 #ifdef CONFIG_PXA27x
@@ -968,7 +968,7 @@
 	i2c_pxa_reset(i2c);
 
 	i2c->adap.algo_data = i2c;
-	i2c->adap.dev.parent = dev;
+	i2c->adap.dev.parent = &dev->dev;
 
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
@@ -976,7 +976,7 @@
 		goto err_irq;
 	}
 
-	dev_set_drvdata(dev, i2c);
+	platform_set_drvdata(dev, i2c);
 
 #ifdef CONFIG_I2C_PXA_SLAVE
 	printk(KERN_INFO "I2C: %s: PXA I2C adapter, slave address %d\n",
@@ -993,11 +993,11 @@
 	return ret;
 }
 
-static int i2c_pxa_remove(struct device *dev)
+static int i2c_pxa_remove(struct platform_device *dev)
 {
-	struct pxa_i2c *i2c = dev_get_drvdata(dev);
+	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(dev, NULL);
 
 	i2c_del_adapter(&i2c->adap);
 	free_irq(IRQ_I2C, i2c);
@@ -1006,21 +1006,22 @@ static int i2c_pxa_remove(struct device 
 	return 0;
 }
 
-static struct device_driver i2c_pxa_driver = {
-	.name		= "pxa2xx-i2c",
-	.bus		= &platform_bus_type,
+static struct platform_driver i2c_pxa_driver = {
 	.probe		= i2c_pxa_probe,
 	.remove		= i2c_pxa_remove,
+	.driver		= {
+		.name	= "pxa2xx-i2c",
+	},
 };
 
 static int __init i2c_adap_pxa_init(void)
 {
-	return driver_register(&i2c_pxa_driver);
+	return platform_driver_register(&i2c_pxa_driver);
 }
 
 static void i2c_adap_pxa_exit(void)
 {
-	return driver_unregister(&i2c_pxa_driver);
+	return platform_driver_unregister(&i2c_pxa_driver);
 }
 
 module_init(i2c_adap_pxa_init);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
