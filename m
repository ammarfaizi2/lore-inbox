Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVKESSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVKESSB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVKESSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:18:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31249 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932176AbVKESRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:17:47 -0500
Date: Sat, 5 Nov 2005 18:17:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert serial drivers
Message-ID: <20051105181741.GM14419@flint.arm.linux.org.uk>
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

diff -u b/drivers/serial/8250.c b/drivers/serial/8250.c
--- b/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2311,9 +2311,9 @@
  * list is terminated with a zero flags entry, which means we expect
  * all entries to have at least UPF_BOOT_AUTOCONF set.
  */
-static int __devinit serial8250_probe(struct device *dev)
+static int __devinit serial8250_probe(struct platform_device *dev)
 {
-	struct plat_serial8250_port *p = dev->platform_data;
+	struct plat_serial8250_port *p = dev->dev.platform_data;
 	struct uart_port port;
 	int ret, i;
 
@@ -2329,12 +2329,12 @@
 		port.flags	= p->flags;
 		port.mapbase	= p->mapbase;
 		port.hub6	= p->hub6;
-		port.dev	= dev;
+		port.dev	= &dev->dev;
 		if (share_irqs)
 			port.flags |= UPF_SHARE_IRQ;
 		ret = serial8250_register_port(&port);
 		if (ret < 0) {
-			dev_err(dev, "unable to register port at index %d "
+			dev_err(&dev->dev, "unable to register port at index %d "
 				"(IO%lx MEM%lx IRQ%d): %d\n", i,
 				p->iobase, p->mapbase, p->irq, ret);
 		}
@@ -2345,14 +2345,14 @@
 /*
  * Remove serial ports registered against a platform device.
  */
-static int __devexit serial8250_remove(struct device *dev)
+static int __devexit serial8250_remove(struct platform_device *dev)
 {
 	int i;
 
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
-		if (up->port.dev == dev)
+		if (up->port.dev == &dev->dev)
 			serial8250_unregister_port(i);
 	}
 	return 0;
@@ -2358,28 +2358,28 @@
 	return 0;
 }
 
-static int serial8250_suspend(struct device *dev, pm_message_t state)
+static int serial8250_suspend(struct platform_device *dev, pm_message_t state)
 {
 	int i;
 
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == dev)
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
 			uart_suspend_port(&serial8250_reg, &up->port);
 	}
 
 	return 0;
 }
 
-static int serial8250_resume(struct device *dev)
+static int serial8250_resume(struct platform_device *dev)
 {
 	int i;
 
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == dev)
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
 			uart_resume_port(&serial8250_reg, &up->port);
 	}
 
@@ -2386,13 +2386,14 @@
 	return 0;
 }
 
-static struct device_driver serial8250_isa_driver = {
-	.name		= "serial8250",
-	.bus		= &platform_bus_type,
+static struct platform_driver serial8250_isa_driver = {
 	.probe		= serial8250_probe,
 	.remove		= __devexit_p(serial8250_remove),
 	.suspend	= serial8250_suspend,
 	.resume		= serial8250_resume,
+	.driver		= {
+		.name	= "serial8250",
+	},
 };
 
 /*
@@ -2538,7 +2539,7 @@
 
 	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
 
-	ret = driver_register(&serial8250_isa_driver);
+	ret = platform_driver_register(&serial8250_isa_driver);
 	if (ret == 0)
 		goto out;
 
@@ -2560,7 +2561,7 @@
 	 */
 	serial8250_isa_devs = NULL;
 
-	driver_unregister(&serial8250_isa_driver);
+	platform_driver_unregister(&serial8250_isa_driver);
 	platform_device_unregister(isa_dev);
 
 	uart_unregister_driver(&serial8250_reg);
diff -u b/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
--- b/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -717,10 +717,9 @@
 /* ======================================================================== */
 
 static int __devinit
-mpc52xx_uart_probe(struct device *dev)
+mpc52xx_uart_probe(struct platform_device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *res = pdev->resource;
+	struct resource *res = dev->resource;
 
 	struct uart_port *port = NULL;
 	int i, idx, ret;
@@ -761,17 +760,17 @@
 	/* Add the port to the uart sub-system */
 	ret = uart_add_one_port(&mpc52xx_uart_driver, port);
 	if (!ret)
-		dev_set_drvdata(dev, (void*)port);
+		platform_set_drvdata(dev, (void*)port);
 
 	return ret;
 }
 
 static int
-mpc52xx_uart_remove(struct device *dev)
+mpc52xx_uart_remove(struct platform_device *dev)
 {
-	struct uart_port *port = (struct uart_port *) dev_get_drvdata(dev);
+	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
 
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(dev, NULL);
 
 	if (port)
 		uart_remove_one_port(&mpc52xx_uart_driver, port);
@@ -781,9 +780,9 @@
 
 #ifdef CONFIG_PM
 static int
-mpc52xx_uart_suspend(struct device *dev, pm_message_t state)
+mpc52xx_uart_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct uart_port *port = (struct uart_port *) dev_get_drvdata(dev);
+	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
 
 	if (sport)
 		uart_suspend_port(&mpc52xx_uart_driver, port);
@@ -792,9 +791,9 @@
 }
 
 static int
-mpc52xx_uart_resume(struct device *dev)
+mpc52xx_uart_resume(struct platform_device *dev)
 {
-	struct uart_port *port = (struct uart_port *) dev_get_drvdata(dev);
+	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
 
 	if (port)
 		uart_resume_port(&mpc52xx_uart_driver, port);
@@ -803,15 +802,16 @@
 }
 #endif
 
-static struct device_driver mpc52xx_uart_platform_driver = {
-	.name		= "mpc52xx-psc",
-	.bus		= &platform_bus_type,
+static struct platform_driver mpc52xx_uart_platform_driver = {
 	.probe		= mpc52xx_uart_probe,
 	.remove		= mpc52xx_uart_remove,
 #ifdef CONFIG_PM
 	.suspend	= mpc52xx_uart_suspend,
 	.resume		= mpc52xx_uart_resume,
 #endif
+	.driver		= {
+		.name	= "mpc52xx-psc",
+	},
 };
 
 
@@ -828,7 +828,7 @@
 
 	ret = uart_register_driver(&mpc52xx_uart_driver);
 	if (ret == 0) {
-		ret = driver_register(&mpc52xx_uart_platform_driver);
+		ret = platform_driver_register(&mpc52xx_uart_platform_driver);
 		if (ret)
 			uart_unregister_driver(&mpc52xx_uart_driver);
 	}
@@ -839,7 +839,7 @@
 static void __exit
 mpc52xx_uart_exit(void)
 {
-	driver_unregister(&mpc52xx_uart_platform_driver);
+	platform_driver_unregister(&mpc52xx_uart_platform_driver);
 	uart_unregister_driver(&mpc52xx_uart_driver);
 }
 
diff -u b/drivers/serial/mpsc.c b/drivers/serial/mpsc.c
--- b/drivers/serial/mpsc.c
+++ b/drivers/serial/mpsc.c
@@ -1551,15 +1551,14 @@
 }
 
 static int
-mpsc_shared_drv_probe(struct device *dev)
+mpsc_shared_drv_probe(struct platform_device *dev)
 {
-	struct platform_device		*pd = to_platform_device(dev);
 	struct mpsc_shared_pdata	*pdata;
 	int				 rc = -ENODEV;
 
-	if (pd->id == 0) {
-		if (!(rc = mpsc_shared_map_regs(pd)))  {
-			pdata = (struct mpsc_shared_pdata *)dev->platform_data;
+	if (dev->id == 0) {
+		if (!(rc = mpsc_shared_map_regs(dev)))  {
+			pdata = (struct mpsc_shared_pdata *)dev->dev.platform_data;
 
 			mpsc_shared_regs.MPSC_MRR_m = pdata->mrr_val;
 			mpsc_shared_regs.MPSC_RCRR_m= pdata->rcrr_val;
@@ -1577,12 +1576,11 @@
 }
 
 static int
-mpsc_shared_drv_remove(struct device *dev)
+mpsc_shared_drv_remove(struct platform_device *dev)
 {
-	struct platform_device	*pd = to_platform_device(dev);
 	int	rc = -ENODEV;
 
-	if (pd->id == 0) {
+	if (dev->id == 0) {
 		mpsc_shared_unmap_regs();
 		mpsc_shared_regs.MPSC_MRR_m = 0;
 		mpsc_shared_regs.MPSC_RCRR_m = 0;
@@ -1595,11 +1593,12 @@ mpsc_shared_drv_remove(struct device *de
 	return rc;
 }
 
-static struct device_driver mpsc_shared_driver = {
-	.name	= MPSC_SHARED_NAME,
-	.bus	= &platform_bus_type,
+static struct platform_driver mpsc_shared_driver = {
 	.probe	= mpsc_shared_drv_probe,
 	.remove	= mpsc_shared_drv_remove,
+	.driver	= {
+		.name = MPSC_SHARED_NAME,
+	},
 };
 
 /*
@@ -1732,19 +1731,18 @@
 }
 
 static int
-mpsc_drv_probe(struct device *dev)
+mpsc_drv_probe(struct platform_device *dev)
 {
-	struct platform_device	*pd = to_platform_device(dev);
 	struct mpsc_port_info	*pi;
 	int			rc = -ENODEV;
 
-	pr_debug("mpsc_drv_probe: Adding MPSC %d\n", pd->id);
+	pr_debug("mpsc_drv_probe: Adding MPSC %d\n", dev->id);
 
-	if (pd->id < MPSC_NUM_CTLRS) {
-		pi = &mpsc_ports[pd->id];
+	if (dev->id < MPSC_NUM_CTLRS) {
+		pi = &mpsc_ports[dev->id];
 
-		if (!(rc = mpsc_drv_map_regs(pi, pd))) {
-			mpsc_drv_get_platform_data(pi, pd, pd->id);
+		if (!(rc = mpsc_drv_map_regs(pi, dev))) {
+			mpsc_drv_get_platform_data(pi, dev, dev->id);
 
 			if (!(rc = mpsc_make_ready(pi)))
 				if (!(rc = uart_add_one_port(&mpsc_reg,
@@ -1764,16 +1762,14 @@
 }
 
 static int
-mpsc_drv_remove(struct device *dev)
+mpsc_drv_remove(struct platform_device *dev)
 {
-	struct platform_device	*pd = to_platform_device(dev);
+	pr_debug("mpsc_drv_exit: Removing MPSC %d\n", dev->id);
 
-	pr_debug("mpsc_drv_exit: Removing MPSC %d\n", pd->id);
-
-	if (pd->id < MPSC_NUM_CTLRS) {
-		uart_remove_one_port(&mpsc_reg, &mpsc_ports[pd->id].port);
-		mpsc_release_port((struct uart_port *)&mpsc_ports[pd->id].port);
-		mpsc_drv_unmap_regs(&mpsc_ports[pd->id]);
+	if (dev->id < MPSC_NUM_CTLRS) {
+		uart_remove_one_port(&mpsc_reg, &mpsc_ports[dev->id].port);
+		mpsc_release_port((struct uart_port *)&mpsc_ports[dev->id].port);
+		mpsc_drv_unmap_regs(&mpsc_ports[dev->id]);
 		return 0;
 	}
 	else
@@ -1780,11 +1776,12 @@ mpsc_drv_remove(struct device *dev)
 		return -ENODEV;
 }
 
-static struct device_driver mpsc_driver = {
-	.name	= MPSC_CTLR_NAME,
-	.bus	= &platform_bus_type,
+static struct platform_driver mpsc_driver = {
 	.probe	= mpsc_drv_probe,
 	.remove	= mpsc_drv_remove,
+	.driver	= {
+		.name = MPSC_CTLR_NAME,
+	},
 };
 
 static int __init
@@ -1798,9 +1795,9 @@ mpsc_drv_init(void)
 	memset(&mpsc_shared_regs, 0, sizeof(mpsc_shared_regs));
 
 	if (!(rc = uart_register_driver(&mpsc_reg))) {
-		if (!(rc = driver_register(&mpsc_shared_driver))) {
-			if ((rc = driver_register(&mpsc_driver))) {
-				driver_unregister(&mpsc_shared_driver);
+		if (!(rc = platform_driver_register(&mpsc_shared_driver))) {
+			if ((rc = platform_driver_register(&mpsc_driver))) {
+				platform_driver_unregister(&mpsc_shared_driver);
 				uart_unregister_driver(&mpsc_reg);
 			}
 		}
@@ -1815,8 +1812,8 @@ mpsc_drv_init(void)
 static void __exit
 mpsc_drv_exit(void)
 {
-	driver_unregister(&mpsc_driver);
-	driver_unregister(&mpsc_shared_driver);
+	platform_driver_unregister(&mpsc_driver);
+	platform_driver_unregister(&mpsc_shared_driver);
 	uart_unregister_driver(&mpsc_reg);
 	memset(mpsc_ports, 0, sizeof(mpsc_ports));
 	memset(&mpsc_shared_regs, 0, sizeof(mpsc_shared_regs));
diff -u b/drivers/serial/pxa.c b/drivers/serial/pxa.c
--- b/drivers/serial/pxa.c
+++ b/drivers/serial/pxa.c
@@ -805,9 +805,9 @@
 	.cons		= PXA_CONSOLE,
 };
 
-static int serial_pxa_suspend(struct device *_dev, pm_message_t state)
+static int serial_pxa_suspend(struct platform_device *dev, pm_message_t state)
 {
-        struct uart_pxa_port *sport = dev_get_drvdata(_dev);
+        struct uart_pxa_port *sport = platform_get_drvdata(dev);
 
         if (sport)
                 uart_suspend_port(&serial_pxa_reg, &sport->port);
@@ -815,9 +815,9 @@
         return 0;
 }
 
-static int serial_pxa_resume(struct device *_dev)
+static int serial_pxa_resume(struct platform_device *dev)
 {
-        struct uart_pxa_port *sport = dev_get_drvdata(_dev);
+        struct uart_pxa_port *sport = platform_get_drvdata(dev);
 
         if (sport)
                 uart_resume_port(&serial_pxa_reg, &sport->port);
@@ -825,21 +825,19 @@
         return 0;
 }
 
-static int serial_pxa_probe(struct device *_dev)
+static int serial_pxa_probe(struct platform_device *dev)
 {
-	struct platform_device *dev = to_platform_device(_dev);
-
-	serial_pxa_ports[dev->id].port.dev = _dev;
+	serial_pxa_ports[dev->id].port.dev = &dev->dev;
 	uart_add_one_port(&serial_pxa_reg, &serial_pxa_ports[dev->id].port);
-	dev_set_drvdata(_dev, &serial_pxa_ports[dev->id]);
+	platform_set_drvdata(dev, &serial_pxa_ports[dev->id]);
 	return 0;
 }
 
-static int serial_pxa_remove(struct device *_dev)
+static int serial_pxa_remove(struct platform_device *dev)
 {
-	struct uart_pxa_port *sport = dev_get_drvdata(_dev);
+	struct uart_pxa_port *sport = platform_get_drvdata(dev);
 
-	dev_set_drvdata(_dev, NULL);
+	platform_set_drvdata(dev, NULL);
 
 	if (sport)
 		uart_remove_one_port(&serial_pxa_reg, &sport->port);
@@ -847,14 +845,15 @@
 	return 0;
 }
 
-static struct device_driver serial_pxa_driver = {
-        .name           = "pxa2xx-uart",
-        .bus            = &platform_bus_type,
+static struct platform_driver serial_pxa_driver = {
         .probe          = serial_pxa_probe,
         .remove         = serial_pxa_remove,
 
 	.suspend	= serial_pxa_suspend,
 	.resume		= serial_pxa_resume,
+	.driver		= {
+	        .name	= "pxa2xx-uart",
+	},
 };
 
 int __init serial_pxa_init(void)
@@ -865,7 +864,7 @@
 	if (ret != 0)
 		return ret;
 
-	ret = driver_register(&serial_pxa_driver);
+	ret = platform_driver_register(&serial_pxa_driver);
 	if (ret != 0)
 		uart_unregister_driver(&serial_pxa_reg);
 
@@ -874,7 +873,7 @@
 
 void __exit serial_pxa_exit(void)
 {
-        driver_unregister(&serial_pxa_driver);
+	platform_driver_unregister(&serial_pxa_driver);
 	uart_unregister_driver(&serial_pxa_reg);
 }
 
diff -u b/drivers/serial/vr41xx_siu.c b/drivers/serial/vr41xx_siu.c
--- b/drivers/serial/vr41xx_siu.c
+++ b/drivers/serial/vr41xx_siu.c
@@ -924,7 +924,7 @@
 	.cons		= SERIAL_VR41XX_CONSOLE,
 };
 
-static int siu_probe(struct device *dev)
+static int siu_probe(struct platform_device *dev)
 {
 	struct uart_port *port;
 	int num, i, retval;
@@ -941,7 +941,7 @@
 	for (i = 0; i < num; i++) {
 		port = &siu_uart_ports[i];
 		port->ops = &siu_uart_ops;
-		port->dev = dev;
+		port->dev = &dev->dev;
 
 		retval = uart_add_one_port(&siu_uart_driver, port);
 		if (retval < 0) {
@@ -958,14 +958,14 @@
 	return 0;
 }
 
-static int siu_remove(struct device *dev)
+static int siu_remove(struct platform_device *dev)
 {
 	struct uart_port *port;
 	int i;
 
 	for (i = 0; i < siu_uart_driver.nr; i++) {
 		port = &siu_uart_ports[i];
-		if (port->dev == dev) {
+		if (port->dev == &dev->dev) {
 			uart_remove_one_port(&siu_uart_driver, port);
 			port->dev = NULL;
 		}
@@ -976,7 +976,7 @@
 	return 0;
 }
 
-static int siu_suspend(struct device *dev, pm_message_t state)
+static int siu_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct uart_port *port;
 	int i;
@@ -984,7 +984,7 @@
 	for (i = 0; i < siu_uart_driver.nr; i++) {
 		port = &siu_uart_ports[i];
 		if ((port->type == PORT_VR41XX_SIU ||
-		     port->type == PORT_VR41XX_DSIU) && port->dev == dev)
+		     port->type == PORT_VR41XX_DSIU) && port->dev == &dev->dev)
 			uart_suspend_port(&siu_uart_driver, port);
 
 	}
@@ -992,7 +992,7 @@
 	return 0;
 }
 
-static int siu_resume(struct device *dev)
+static int siu_resume(struct platform_device *dev)
 {
 	struct uart_port *port;
 	int i;
@@ -1000,7 +1000,7 @@
 	for (i = 0; i < siu_uart_driver.nr; i++) {
 		port = &siu_uart_ports[i];
 		if ((port->type == PORT_VR41XX_SIU ||
-		     port->type == PORT_VR41XX_DSIU) && port->dev == dev)
+		     port->type == PORT_VR41XX_DSIU) && port->dev == &dev->dev)
 			uart_resume_port(&siu_uart_driver, port);
 	}
 
@@ -1009,13 +1009,14 @@
 
 static struct platform_device *siu_platform_device;
 
-static struct device_driver siu_device_driver = {
-	.name		= "SIU",
-	.bus		= &platform_bus_type,
+static struct platform_driver siu_device_driver = {
 	.probe		= siu_probe,
 	.remove		= siu_remove,
 	.suspend	= siu_suspend,
 	.resume		= siu_resume,
+	.driver		= {
+		.name	= "SIU",
+	},
 };
 
 static int __devinit vr41xx_siu_init(void)
@@ -1026,7 +1027,7 @@
 	if (IS_ERR(siu_platform_device))
 		return PTR_ERR(siu_platform_device);
 
-	retval = driver_register(&siu_device_driver);
+	retval = platform_driver_register(&siu_device_driver);
 	if (retval < 0)
 		platform_device_unregister(siu_platform_device);
 
@@ -1035,7 +1036,7 @@
 
 static void __devexit vr41xx_siu_exit(void)
 {
-	driver_unregister(&siu_device_driver);
+	platform_driver_unregister(&siu_device_driver);
 
 	platform_device_unregister(siu_platform_device);
 }


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
