Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVKESTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVKESTI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVKESTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:19:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32273 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932183AbVKESTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:19:02 -0500
Date: Sat, 5 Nov 2005 18:18:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert USB drivers
Message-ID: <20051105181855.GQ14419@flint.arm.linux.org.uk>
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

diff -u b/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
--- b/drivers/usb/gadget/dummy_hcd.c
+++ b/drivers/usb/gadget/dummy_hcd.c
@@ -897,7 +897,7 @@
 #endif
 }
 
-static int dummy_udc_probe (struct device *dev)
+static int dummy_udc_probe (struct platform_device *dev)
 {
 	struct dummy	*dum = the_controller;
 	int		rc;
@@ -910,7 +910,7 @@
 	dum->gadget.is_otg = (dummy_to_hcd(dum)->self.otg_port != 0);
 
 	strcpy (dum->gadget.dev.bus_id, "gadget");
-	dum->gadget.dev.parent = dev;
+	dum->gadget.dev.parent = &dev->dev;
 	dum->gadget.dev.release = dummy_gadget_release;
 	rc = device_register (&dum->gadget.dev);
 	if (rc < 0)
@@ -920,26 +920,26 @@
 	usb_bus_get (&dummy_to_hcd (dum)->self);
 #endif
 
-	dev_set_drvdata (dev, dum);
+	platform_set_drvdata (dev, dum);
 	device_create_file (&dum->gadget.dev, &dev_attr_function);
 	return rc;
 }
 
-static int dummy_udc_remove (struct device *dev)
+static int dummy_udc_remove (struct platform_device *dev)
 {
-	struct dummy	*dum = dev_get_drvdata (dev);
+	struct dummy	*dum = platform_get_drvdata (dev);
 
-	dev_set_drvdata (dev, NULL);
+	platform_set_drvdata (dev, NULL);
 	device_remove_file (&dum->gadget.dev, &dev_attr_function);
 	device_unregister (&dum->gadget.dev);
 	return 0;
 }
 
-static int dummy_udc_suspend (struct device *dev, pm_message_t state)
+static int dummy_udc_suspend (struct platform_device *dev, pm_message_t state)
 {
-	struct dummy	*dum = dev_get_drvdata(dev);
+	struct dummy	*dum = platform_get_drvdata(dev);
 
-	dev_dbg (dev, "%s\n", __FUNCTION__);
+	dev_dbg (&dev->dev, "%s\n", __FUNCTION__);
 	spin_lock_irq (&dum->lock);
 	dum->udc_suspended = 1;
 	set_link_state (dum);
@@ -950,29 +950,30 @@
 	return 0;
 }
 
-static int dummy_udc_resume (struct device *dev)
+static int dummy_udc_resume (struct platform_device *dev)
 {
-	struct dummy	*dum = dev_get_drvdata(dev);
+	struct dummy	*dum = platform_get_drvdata(dev);
 
-	dev_dbg (dev, "%s\n", __FUNCTION__);
+	dev_dbg (&dev->dev, "%s\n", __FUNCTION__);
 	spin_lock_irq (&dum->lock);
 	dum->udc_suspended = 0;
 	set_link_state (dum);
 	spin_unlock_irq (&dum->lock);
 
-	dev->power.power_state = PMSG_ON;
+	dev->dev.power.power_state = PMSG_ON;
 	usb_hcd_poll_rh_status (dummy_to_hcd (dum));
 	return 0;
 }
 
-static struct device_driver dummy_udc_driver = {
-	.name		= (char *) gadget_name,
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver dummy_udc_driver = {
 	.probe		= dummy_udc_probe,
 	.remove		= dummy_udc_remove,
 	.suspend	= dummy_udc_suspend,
 	.resume		= dummy_udc_resume,
+	.driver		= {
+		.name	= (char *) gadget_name,
+		.owner	= THIS_MODULE,
+	},
 };
 
 /*-------------------------------------------------------------------------*/
@@ -1899,14 +1900,14 @@
 	.bus_resume =		dummy_bus_resume,
 };
 
-static int dummy_hcd_probe (struct device *dev)
+static int dummy_hcd_probe (struct platform_device *dev)
 {
 	struct usb_hcd		*hcd;
 	int			retval;
 
 	dev_info (dev, "%s, driver " DRIVER_VERSION "\n", driver_desc);
 
-	hcd = usb_create_hcd (&dummy_hcd, dev, dev->bus_id);
+	hcd = usb_create_hcd (&dummy_hcd, &dev->dev, dev->dev.bus_id);
 	if (!hcd)
 		return -ENOMEM;
 	the_controller = hcd_to_dummy (hcd);
@@ -1919,34 +1920,34 @@
 	return retval;
 }
 
-static int dummy_hcd_remove (struct device *dev)
+static int dummy_hcd_remove (struct platform_device *dev)
 {
 	struct usb_hcd		*hcd;
 
-	hcd = dev_get_drvdata (dev);
+	hcd = platform_get_drvdata (dev);
 	usb_remove_hcd (hcd);
 	usb_put_hcd (hcd);
 	the_controller = NULL;
 	return 0;
 }
 
-static int dummy_hcd_suspend (struct device *dev, pm_message_t state)
+static int dummy_hcd_suspend (struct platform_device *dev, pm_message_t state)
 {
 	struct usb_hcd		*hcd;
 
-	dev_dbg (dev, "%s\n", __FUNCTION__);
-	hcd = dev_get_drvdata (dev);
+	dev_dbg (&dev->dev, "%s\n", __FUNCTION__);
+	hcd = platform_get_drvdata (dev);
 
 	hcd->state = HC_STATE_SUSPENDED;
 	return 0;
 }
 
-static int dummy_hcd_resume (struct device *dev)
+static int dummy_hcd_resume (struct platform_device *dev)
 {
 	struct usb_hcd		*hcd;
 
-	dev_dbg (dev, "%s\n", __FUNCTION__);
-	hcd = dev_get_drvdata (dev);
+	dev_dbg (&dev->dev, "%s\n", __FUNCTION__);
+	hcd = platform_get_drvdata (dev);
 	hcd->state = HC_STATE_RUNNING;
 
 	usb_hcd_poll_rh_status (hcd);
@@ -1953,14 +1954,15 @@
 	return 0;
 }
 
-static struct device_driver dummy_hcd_driver = {
-	.name		= (char *) driver_name,
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver dummy_hcd_driver = {
 	.probe		= dummy_hcd_probe,
 	.remove		= dummy_hcd_remove,
 	.suspend	= dummy_hcd_suspend,
 	.resume		= dummy_hcd_resume,
+	.driver		= {
+		.name	= (char *) driver_name,
+		.owner	= THIS_MODULE,
+	},
 };
 
 /*-------------------------------------------------------------------------*/
@@ -1996,11 +1998,11 @@
 	if (usb_disabled ())
 		return -ENODEV;
 
-	retval = driver_register (&dummy_hcd_driver);
+	retval = platform_driver_register (&dummy_hcd_driver);
 	if (retval < 0)
 		return retval;
 
-	retval = driver_register (&dummy_udc_driver);
+	retval = platform_driver_register (&dummy_udc_driver);
 	if (retval < 0)
 		goto err_register_udc_driver;
 
@@ -2016,9 +2018,9 @@
 err_register_udc:
 	platform_device_unregister (&the_hcd_pdev);
 err_register_hcd:
-	driver_unregister (&dummy_udc_driver);
+	platform_driver_unregister (&dummy_udc_driver);
 err_register_udc_driver:
-	driver_unregister (&dummy_hcd_driver);
+	platform_driver_unregister (&dummy_hcd_driver);
 	return retval;
 }
 module_init (init);
@@ -2028,6 +2030,6 @@
 	platform_device_unregister (&the_udc_pdev);
 	platform_device_unregister (&the_hcd_pdev);
-	driver_unregister (&dummy_udc_driver);
-	driver_unregister (&dummy_hcd_driver);
+	platform_driver_unregister (&dummy_udc_driver);
+	platform_driver_unregister (&dummy_hcd_driver);
 }
 module_exit (cleanup);
diff -u b/drivers/usb/gadget/lh7a40x_udc.c b/drivers/usb/gadget/lh7a40x_udc.c
--- b/drivers/usb/gadget/lh7a40x_udc.c
+++ b/drivers/usb/gadget/lh7a40x_udc.c
@@ -2085,21 +2085,21 @@
 /*
  * 	probe - binds to the platform device
  */
-static int lh7a40x_udc_probe(struct device *_dev)
+static int lh7a40x_udc_probe(struct platform_device *pdev)
 {
 	struct lh7a40x_udc *dev = &memory;
 	int retval;
 
-	DEBUG("%s: %p\n", __FUNCTION__, _dev);
+	DEBUG("%s: %p\n", __FUNCTION__, pdev);
 
 	spin_lock_init(&dev->lock);
-	dev->dev = _dev;
+	dev->dev = &pdev->dev;
 
 	device_initialize(&dev->gadget.dev);
-	dev->gadget.dev.parent = _dev;
+	dev->gadget.dev.parent = &pdev->dev;
 
 	the_controller = dev;
-	dev_set_drvdata(_dev, dev);
+	platform_set_drvdata(pdev, dev);
 
 	udc_disable(dev);
 	udc_reinit(dev);
@@ -2119,11 +2119,11 @@
 	return retval;
 }
 
-static int lh7a40x_udc_remove(struct device *_dev)
+static int lh7a40x_udc_remove(struct platform_device *pdev)
 {
-	struct lh7a40x_udc *dev = _dev->driver_data;
+	struct lh7a40x_udc *dev = platform_get_drvdata(pdev);
 
-	DEBUG("%s: %p\n", __FUNCTION__, dev);
+	DEBUG("%s: %p\n", __FUNCTION__, pdev);
 
 	udc_disable(dev);
 	remove_proc_files();
@@ -2131,7 +2131,7 @@
 
 	free_irq(IRQ_USBINTR, dev);
 
-	dev_set_drvdata(_dev, 0);
+	platform_set_drvdata(pdev, 0);
 
 	the_controller = 0;
 
@@ -2140,26 +2140,27 @@
 
 /*-------------------------------------------------------------------------*/
 
-static struct device_driver udc_driver = {
-	.name = (char *)driver_name,
-	.owner = THIS_MODULE,
-	.bus = &platform_bus_type,
+static struct platform_driver udc_driver = {
 	.probe = lh7a40x_udc_probe,
 	.remove = lh7a40x_udc_remove
 	    /* FIXME power management support */
 	    /* .suspend = ... disable UDC */
 	    /* .resume = ... re-enable UDC */
+	.driver	= {
+		.name = (char *)driver_name,
+		.owner = THIS_MODULE,
+	},
 };
 
 static int __init udc_init(void)
 {
 	DEBUG("%s: %s version %s\n", __FUNCTION__, driver_name, DRIVER_VERSION);
-	return driver_register(&udc_driver);
+	return platform_driver_register(&udc_driver);
 }
 
 static void __exit udc_exit(void)
 {
-	driver_unregister(&udc_driver);
+	platform_driver_unregister(&udc_driver);
 }
 
 module_init(udc_init);
diff -u b/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
--- b/drivers/usb/host/isp116x-hcd.c
+++ b/drivers/usb/host/isp116x-hcd.c
@@ -1633,17 +1633,15 @@
 
 /*----------------------------------------------------------------*/
 
-static int __init_or_module isp116x_remove(struct device *dev)
+static int __init_or_module isp116x_remove(struct platform_device *pdev)
 {
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct isp116x *isp116x;
-	struct platform_device *pdev;
 	struct resource *res;
 
 	if (!hcd)
 		return 0;
 	isp116x = hcd_to_isp116x(hcd);
-	pdev = container_of(dev, struct platform_device, dev);
 	remove_debug_file(isp116x);
 	usb_remove_hcd(hcd);
 
@@ -1660,18 +1658,16 @@
 
 #define resource_len(r) (((r)->end - (r)->start) + 1)
 
-static int __init isp116x_probe(struct device *dev)
+static int __init isp116x_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 	struct isp116x *isp116x;
-	struct platform_device *pdev;
 	struct resource *addr, *data;
 	void __iomem *addr_reg;
 	void __iomem *data_reg;
 	int irq;
 	int ret = 0;
 
-	pdev = container_of(dev, struct platform_device, dev);
 	if (pdev->num_resources < 3) {
 		ret = -ENODEV;
 		goto err1;
@@ -1685,7 +1681,7 @@
 		goto err1;
 	}
 
-	if (dev->dma_mask) {
+	if (pdev->dev.dma_mask) {
 		DBG("DMA not supported\n");
 		ret = -EINVAL;
 		goto err1;
@@ -1711,7 +1707,7 @@ static int __init isp116x_probe(struct d
 	}
 
 	/* allocate and initialize hcd */
-	hcd = usb_create_hcd(&isp116x_hc_driver, dev, dev->bus_id);
+	hcd = usb_create_hcd(&isp116x_hc_driver, &pdev->dev, pdev->dev.bus_id);
 	if (!hcd) {
 		ret = -ENOMEM;
 		goto err5;
@@ -1723,7 +1719,7 @@
 	isp116x->addr_reg = addr_reg;
 	spin_lock_init(&isp116x->lock);
 	INIT_LIST_HEAD(&isp116x->async);
-	isp116x->board = dev->platform_data;
+	isp116x->board = pdev->dev.platform_data;
 
 	if (!isp116x->board) {
 		ERR("Platform data structure not initialized\n");
@@ -1764,13 +1760,13 @@
 /*
   Suspend of platform device
 */
-static int isp116x_suspend(struct device *dev, pm_message_t state)
+static int isp116x_suspend(struct platform_device *dev, pm_message_t state)
 {
 	int ret = 0;
 
 	VDBG("%s: state %x\n", __func__, state);
 
-	dev->power.power_state = state;
+	dev->dev.power.power_state = state;
 
 	return ret;
 }
@@ -1778,13 +1774,13 @@
 /*
   Resume platform device
 */
-static int isp116x_resume(struct device *dev)
+static int isp116x_resume(struct platform_device *dev)
 {
 	int ret = 0;
 
-	VDBG("%s:  state %x\n", __func__, dev->power.power_state);
+	VDBG("%s:  state %x\n", __func__, dev->dev.power.power_state);
 
-	dev->power.power_state = PMSG_ON;
+	dev->dev.power.power_state = PMSG_ON;
 
 	return ret;
 }
@@ -1796,13 +1792,14 @@
 
 #endif
 
-static struct device_driver isp116x_driver = {
-	.name = (char *)hcd_name,
-	.bus = &platform_bus_type,
+static struct platform_driver isp116x_driver = {
 	.probe = isp116x_probe,
 	.remove = isp116x_remove,
 	.suspend = isp116x_suspend,
 	.resume = isp116x_resume,
+	.driver	= {
+		.name = (char *)hcd_name,
+	},
 };
 
 /*-----------------------------------------------------------------*/
@@ -1813,14 +1810,14 @@
 		return -ENODEV;
 
 	INFO("driver %s, %s\n", hcd_name, DRIVER_VERSION);
-	return driver_register(&isp116x_driver);
+	return platform_driver_register(&isp116x_driver);
 }
 
 module_init(isp116x_init);
 
 static void __exit isp116x_cleanup(void)
 {
-	driver_unregister(&isp116x_driver);
+	platform_driver_unregister(&isp116x_driver);
 }
 
 module_exit(isp116x_cleanup);
unchanged:
--- b/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1829,16 +1829,16 @@
 
 
 /* this driver is exported so sl811_cs can depend on it */
-struct device_driver sl811h_driver = {
-	.name =		(char *) hcd_name,
-	.bus =		&platform_bus_type,
-	.owner =	THIS_MODULE,
-
+struct platform_driver sl811h_driver = {
 	.probe =	sl811h_probe,
 	.remove =	__devexit_p(sl811h_remove),
 
 	.suspend =	sl811h_suspend,
 	.resume =	sl811h_resume,
+	.driver = {
+		.name =	(char *) hcd_name,
+		.owner = THIS_MODULE,
+	},
 };
 EXPORT_SYMBOL(sl811h_driver);
 
@@ -1851,11 +1851,11 @@
 
 	INFO("driver %s, %s\n", hcd_name, DRIVER_VERSION);
-	return driver_register(&sl811h_driver);
+	return platform_driver_register(&sl811h_driver);
 }
 module_init(sl811h_init);
 
 static void __exit sl811h_cleanup(void)
 {
-	driver_unregister(&sl811h_driver);
+	platform_driver_unregister(&sl811h_driver);
 }
 module_exit(sl811h_cleanup);
diff -u b/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
--- b/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -225,9 +225,8 @@
 
 /*-------------------------------------------------------------------------*/
 
-static int ohci_hcd_au1xxx_drv_probe(struct device *dev)
+static int ohci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	int ret;
 
 	pr_debug ("In ohci_hcd_au1xxx_drv_probe");
@@ -239,39 +238,37 @@
 	return ret;
 }
 
-static int ohci_hcd_au1xxx_drv_remove(struct device *dev)
+static int ohci_hcd_au1xxx_drv_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_hcd_au1xxx_remove(hcd, pdev);
 	return 0;
 }
 	/*TBD*/
-/*static int ohci_hcd_au1xxx_drv_suspend(struct device *dev)
+/*static int ohci_hcd_au1xxx_drv_suspend(struct platform_device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
 
 	return 0;
 }
-static int ohci_hcd_au1xxx_drv_resume(struct device *dev)
+static int ohci_hcd_au1xxx_drv_resume(struct platform_device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
 
 	return 0;
 }
 */
 
-static struct device_driver ohci_hcd_au1xxx_driver = {
-	.name		= "au1xxx-ohci",
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver ohci_hcd_au1xxx_driver = {
 	.probe		= ohci_hcd_au1xxx_drv_probe,
 	.remove		= ohci_hcd_au1xxx_drv_remove,
 	/*.suspend	= ohci_hcd_au1xxx_drv_suspend, */
 	/*.resume	= ohci_hcd_au1xxx_drv_resume, */
+	.driver		= {
+		.name	= "au1xxx-ohci",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static int __init ohci_hcd_au1xxx_init (void)
@@ -280,12 +277,12 @@
 	pr_debug ("block sizes: ed %d td %d\n",
 		sizeof (struct ed), sizeof (struct td));
 
-	return driver_register(&ohci_hcd_au1xxx_driver);
+	return platform_driver_register(&ohci_hcd_au1xxx_driver);
 }
 
 static void __exit ohci_hcd_au1xxx_cleanup (void)
 {
-	driver_unregister(&ohci_hcd_au1xxx_driver);
+	platform_driver_unregister(&ohci_hcd_au1xxx_driver);
 }
 
 module_init (ohci_hcd_au1xxx_init);
diff -u b/drivers/usb/host/ohci-lh7a404.c b/drivers/usb/host/ohci-lh7a404.c
--- b/drivers/usb/host/ohci-lh7a404.c
+++ b/drivers/usb/host/ohci-lh7a404.c
@@ -204,9 +204,8 @@
 
 /*-------------------------------------------------------------------------*/
 
-static int ohci_hcd_lh7a404_drv_probe(struct device *dev)
+static int ohci_hcd_lh7a404_drv_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	int ret;
 
 	pr_debug ("In ohci_hcd_lh7a404_drv_probe");
@@ -218,40 +217,38 @@
 	return ret;
 }
 
-static int ohci_hcd_lh7a404_drv_remove(struct device *dev)
+static int ohci_hcd_lh7a404_drv_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
 
 	usb_hcd_lh7a404_remove(hcd, pdev);
 	return 0;
 }
 	/*TBD*/
-/*static int ohci_hcd_lh7a404_drv_suspend(struct device *dev)
+/*static int ohci_hcd_lh7a404_drv_suspend(struct platform_device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
 
 	return 0;
 }
-static int ohci_hcd_lh7a404_drv_resume(struct device *dev)
+static int ohci_hcd_lh7a404_drv_resume(struct platform_device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
 
 
 	return 0;
 }
 */
 
-static struct device_driver ohci_hcd_lh7a404_driver = {
-	.name		= "lh7a404-ohci",
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver ohci_hcd_lh7a404_driver = {
 	.probe		= ohci_hcd_lh7a404_drv_probe,
 	.remove		= ohci_hcd_lh7a404_drv_remove,
 	/*.suspend	= ohci_hcd_lh7a404_drv_suspend, */
 	/*.resume	= ohci_hcd_lh7a404_drv_resume, */
+	.driver		= {
+		.name	= "lh7a404-ohci",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static int __init ohci_hcd_lh7a404_init (void)
@@ -260,12 +257,12 @@
 	pr_debug ("block sizes: ed %d td %d\n",
 		sizeof (struct ed), sizeof (struct td));
 
-	return driver_register(&ohci_hcd_lh7a404_driver);
+	return platform_driver_register(&ohci_hcd_lh7a404_driver);
 }
 
 static void __exit ohci_hcd_lh7a404_cleanup (void)
 {
-	driver_unregister(&ohci_hcd_lh7a404_driver);
+	platform_driver_unregister(&ohci_hcd_lh7a404_driver);
 }
 
 module_init (ohci_hcd_lh7a404_init);
diff -u b/drivers/usb/host/ohci-ppc-soc.c b/drivers/usb/host/ohci-ppc-soc.c
--- b/drivers/usb/host/ohci-ppc-soc.c
+++ b/drivers/usb/host/ohci-ppc-soc.c
@@ -172,9 +172,8 @@
 	.start_port_reset =	ohci_start_port_reset,
 };
 
-static int ohci_hcd_ppc_soc_drv_probe(struct device *dev)
+static int ohci_hcd_ppc_soc_drv_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	int ret;
 
 	if (usb_disabled())
@@ -184,25 +183,25 @@
 	return ret;
 }
 
-static int ohci_hcd_ppc_soc_drv_remove(struct device *dev)
+static int ohci_hcd_ppc_soc_drv_remove(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
 
 	usb_hcd_ppc_soc_remove(hcd, pdev);
 	return 0;
 }
 
-static struct device_driver ohci_hcd_ppc_soc_driver = {
-	.name		= "ppc-soc-ohci",
-	.owner		= THIS_MODULE,
-	.bus		= &platform_bus_type,
+static struct platform_driver ohci_hcd_ppc_soc_driver = {
 	.probe		= ohci_hcd_ppc_soc_drv_probe,
 	.remove		= ohci_hcd_ppc_soc_drv_remove,
 #ifdef	CONFIG_PM
 	/*.suspend	= ohci_hcd_ppc_soc_drv_suspend,*/
 	/*.resume	= ohci_hcd_ppc_soc_drv_resume,*/
 #endif
+	.driver		= {
+		.name	= "ppc-soc-ohci",
+		.owner	= THIS_MODULE,
+	},
 };
 
 static int __init ohci_hcd_ppc_soc_init(void)
@@ -211,12 +210,12 @@
 	pr_debug("block sizes: ed %d td %d\n", sizeof(struct ed),
 							sizeof(struct td));
 
-	return driver_register(&ohci_hcd_ppc_soc_driver);
+	return platform_driver_register(&ohci_hcd_ppc_soc_driver);
 }
 
 static void __exit ohci_hcd_ppc_soc_cleanup(void)
 {
-	driver_unregister(&ohci_hcd_ppc_soc_driver);
+	platform_driver_unregister(&ohci_hcd_ppc_soc_driver);
 }
 
 module_init(ohci_hcd_ppc_soc_init);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
