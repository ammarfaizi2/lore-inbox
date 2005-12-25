Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVLYVRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVLYVRN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 16:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVLYVRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 16:17:13 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:49817 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750935AbVLYVRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 16:17:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [RFT] Sonypi: convert to the new platform device interface
Date: Sun, 25 Dec 2005 16:17:08 -0500
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>, Stelian Pop <stelian@popies.net>
References: <200512130219.41034.dtor_core@ameritech.net> <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com> <Pine.LNX.4.61.0512252207020.15152@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0512252207020.15152@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512251617.09153.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 December 2005 16:09, Jan Engelhardt wrote:
> 
> >> > The patch compiles but I was unable to test it since I don't have the
> >> > hardware...
> >>
> >> other than that seems to work here on a type2 model:
> 
> It does not work here on a SONY VAIO U3. After loading the sonypi module, 
> neither mev nor showkey return something for the special stuff like 
> jogwheel, jogbutton or Fn keys respectively.
> 
> Running 2.6.15-rc7, this appeared in the kernel log:
> Dec 25 22:06:14 takeshi kernel: sonypi: request_irq failed
> 

Jan,

You did make the changes Maattia Dongili was talking about, didn't you?
Just in case I am sending corrected patch.

-- 
Dmitry

Sonypi: convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away,
implement ->probe() and ->remove() functions so manual binding and
unbinding will work with this driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/sonypi.c |  358 ++++++++++++++++++++++++++++----------------------
 1 files changed, 206 insertions(+), 152 deletions(-)

Index: work/drivers/char/sonypi.c
===================================================================
--- work.orig/drivers/char/sonypi.c
+++ work/drivers/char/sonypi.c
@@ -471,7 +471,6 @@ struct sonypi_keypress {
 
 static struct sonypi_device {
 	struct pci_dev *dev;
-	struct platform_device *pdev;
 	u16 irq;
 	u16 bits;
 	u16 ioport1;
@@ -1165,45 +1164,12 @@ static int sonypi_disable(void)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int old_camera_power;
-
-static int sonypi_suspend(struct platform_device *dev, pm_message_t state)
-{
-	old_camera_power = sonypi_device.camera_power;
-	sonypi_disable();
-
-	return 0;
-}
-
-static int sonypi_resume(struct platform_device *dev)
-{
-	sonypi_enable(old_camera_power);
-	return 0;
-}
-#endif
-
-static void sonypi_shutdown(struct platform_device *dev)
-{
-	sonypi_disable();
-}
-
-static struct platform_driver sonypi_driver = {
-#ifdef CONFIG_PM
-	.suspend	= sonypi_suspend,
-	.resume		= sonypi_resume,
-#endif
-	.shutdown	= sonypi_shutdown,
-	.driver		= {
-		.name	= "sonypi",
-	},
-};
-
 static int __devinit sonypi_create_input_devices(void)
 {
 	struct input_dev *jog_dev;
 	struct input_dev *key_dev;
 	int i;
+	int error;
 
 	sonypi_device.input_jog_dev = jog_dev = input_allocate_device();
 	if (!jog_dev)
@@ -1219,9 +1185,8 @@ static int __devinit sonypi_create_input
 
 	sonypi_device.input_key_dev = key_dev = input_allocate_device();
 	if (!key_dev) {
-		input_free_device(jog_dev);
-		sonypi_device.input_jog_dev = NULL;
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto err_free_jogdev;
 	}
 
 	key_dev->name = "Sony Vaio Keys";
@@ -1234,56 +1199,122 @@ static int __devinit sonypi_create_input
 		if (sonypi_inputkeys[i].inputev)
 			set_bit(sonypi_inputkeys[i].inputev, key_dev->keybit);
 
-	input_register_device(jog_dev);
-	input_register_device(key_dev);
+	error = input_register_device(jog_dev);
+	if (error)
+		goto err_free_keydev;
+
+	error = input_register_device(key_dev);
+	if (error)
+		goto err_unregister_jogdev;
 
 	return 0;
+
+ err_unregister_jogdev:
+	input_unregister_device(jog_dev);
+	/* Set to NULL so we don't free it again below */
+	jog_dev = NULL;
+ err_free_keydev:
+	input_free_device(key_dev);
+	sonypi_device.input_key_dev = NULL;
+ err_free_jogdev:
+	input_free_device(jog_dev);
+	sonypi_device.input_jog_dev = NULL;
+
+	return error;
 }
 
-static int __devinit sonypi_probe(void)
+static int __devinit sonypi_setup_ioports(struct sonypi_device *dev,
+				const struct sonypi_ioport_list *ioport_list)
 {
-	int i, ret;
-	struct sonypi_ioport_list *ioport_list;
-	struct sonypi_irq_list *irq_list;
-	struct pci_dev *pcidev;
+	while (ioport_list->port1) {
 
-	if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
-				     PCI_DEVICE_ID_INTEL_82371AB_3, NULL)))
-		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE1;
-	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
-					  PCI_DEVICE_ID_INTEL_ICH6_1, NULL)))
-		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE3;
-	else
-		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
+		if (request_region(ioport_list->port1,
+				   sonypi_device.region_size,
+				   "Sony Programable I/O Device")) {
+			dev->ioport1 = ioport_list->port1;
+			dev->ioport2 = ioport_list->port2;
+			return 0;
+		}
+		ioport_list++;
+	}
 
-	sonypi_device.dev = pcidev;
+	return -EBUSY;
+}
+
+static int __devinit sonypi_setup_irq(struct sonypi_device *dev,
+				      const struct sonypi_irq_list *irq_list)
+{
+	while (irq_list->irq) {
+
+		if (!request_irq(irq_list->irq, sonypi_irq,
+				 SA_SHIRQ, "sonypi", sonypi_irq)) {
+			dev->irq = irq_list->irq;
+			dev->bits = irq_list->bits;
+			return 0;
+		}
+		irq_list++;
+	}
+
+	return -EBUSY;
+}
+
+static void __devinit sonypi_display_info(void)
+{
+	printk(KERN_INFO "sonypi: detected type%d model, "
+	       "verbose = %d, fnkeyinit = %s, camera = %s, "
+	       "compat = %s, mask = 0x%08lx, useinput = %s, acpi = %s\n",
+	       sonypi_device.model,
+	       verbose,
+	       fnkeyinit ? "on" : "off",
+	       camera ? "on" : "off",
+	       compat ? "on" : "off",
+	       mask,
+	       useinput ? "on" : "off",
+	       SONYPI_ACPI_ACTIVE ? "on" : "off");
+	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
+	       sonypi_device.irq,
+	       sonypi_device.ioport1, sonypi_device.ioport2);
+
+	if (minor == -1)
+		printk(KERN_INFO "sonypi: device allocated minor is %d\n",
+		       sonypi_misc_device.minor);
+}
+
+static int __devinit sonypi_probe(struct platform_device *dev)
+{
+	const struct sonypi_ioport_list *ioport_list;
+	const struct sonypi_irq_list *irq_list;
+	struct pci_dev *pcidev;
+	int error;
 
 	spin_lock_init(&sonypi_device.fifo_lock);
 	sonypi_device.fifo = kfifo_alloc(SONYPI_BUF_SIZE, GFP_KERNEL,
 					 &sonypi_device.fifo_lock);
 	if (IS_ERR(sonypi_device.fifo)) {
 		printk(KERN_ERR "sonypi: kfifo_alloc failed\n");
-		ret = PTR_ERR(sonypi_device.fifo);
-		goto out_fifo;
+		return PTR_ERR(sonypi_device.fifo);
 	}
 
 	init_waitqueue_head(&sonypi_device.fifo_proc_list);
 	init_MUTEX(&sonypi_device.lock);
 	sonypi_device.bluetooth_power = -1;
 
+	if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+				     PCI_DEVICE_ID_INTEL_82371AB_3, NULL)))
+		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE1;
+	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+					  PCI_DEVICE_ID_INTEL_ICH6_1, NULL)))
+		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE3;
+	else
+		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
+
 	if (pcidev && pci_enable_device(pcidev)) {
 		printk(KERN_ERR "sonypi: pci_enable_device failed\n");
-		ret = -EIO;
-		goto out_pcienable;
-	}
-
-	if (minor != -1)
-		sonypi_misc_device.minor = minor;
-	if ((ret = misc_register(&sonypi_misc_device))) {
-		printk(KERN_ERR "sonypi: misc_register failed\n");
-		goto out_miscreg;
+		error = -EIO;
+		goto err_put_pcidev;
 	}
 
+	sonypi_device.dev = pcidev;
 
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) {
 		ioport_list = sonypi_type1_ioport_list;
@@ -1302,43 +1333,36 @@ static int __devinit sonypi_probe(void)
 		irq_list = sonypi_type3_irq_list;
 	}
 
-	for (i = 0; ioport_list[i].port1; i++) {
-		if (request_region(ioport_list[i].port1,
-				   sonypi_device.region_size,
-				   "Sony Programable I/O Device")) {
-			/* get the ioport */
-			sonypi_device.ioport1 = ioport_list[i].port1;
-			sonypi_device.ioport2 = ioport_list[i].port2;
-			break;
-		}
-	}
-	if (!sonypi_device.ioport1) {
-		printk(KERN_ERR "sonypi: request_region failed\n");
-		ret = -ENODEV;
-		goto out_reqreg;
+	error = sonypi_setup_ioports(&sonypi_device, ioport_list);
+	if (error) {
+		printk(KERN_ERR "sonypi: failed to request ioports\n");
+		goto err_disable_pcidev;
 	}
 
-	for (i = 0; irq_list[i].irq; i++) {
-
-		sonypi_device.irq = irq_list[i].irq;
-		sonypi_device.bits = irq_list[i].bits;
-
-		if (!request_irq(sonypi_device.irq, sonypi_irq,
-				 SA_SHIRQ, "sonypi", sonypi_irq))
-			break;
+	error = sonypi_setup_irq(&sonypi_device, irq_list);
+	if (error) {
+		printk(KERN_ERR "sonypi: request_irq failed\n");
+		goto err_free_ioports;
 	}
 
-	if (!irq_list[i].irq) {
-		printk(KERN_ERR "sonypi: request_irq failed\n");
-		ret = -ENODEV;
-		goto out_reqirq;
+	if (minor != -1)
+		sonypi_misc_device.minor = minor;
+	error = misc_register(&sonypi_misc_device);
+	if (error) {
+		printk(KERN_ERR "sonypi: misc_register failed\n");
+		goto err_free_irq;
 	}
 
+	sonypi_display_info();
+
 	if (useinput) {
 
-		ret = sonypi_create_input_devices();
-		if (ret)
-			goto out_inputdevices;
+		error = sonypi_create_input_devices();
+		if (error) {
+			printk(KERN_ERR
+				"sonypi: failed to create input devices\n");
+			goto err_miscdev_unregister;
+		}
 
 		spin_lock_init(&sonypi_device.input_fifo_lock);
 		sonypi_device.input_fifo =
@@ -1346,90 +1370,103 @@ static int __devinit sonypi_probe(void)
 				    &sonypi_device.input_fifo_lock);
 		if (IS_ERR(sonypi_device.input_fifo)) {
 			printk(KERN_ERR "sonypi: kfifo_alloc failed\n");
-			ret = PTR_ERR(sonypi_device.input_fifo);
-			goto out_infifo;
+			error = PTR_ERR(sonypi_device.input_fifo);
+			goto err_inpdev_unregister;
 		}
 
 		INIT_WORK(&sonypi_device.input_work, input_keyrelease, NULL);
 	}
 
-	sonypi_device.pdev = platform_device_register_simple("sonypi", -1,
-							     NULL, 0);
-	if (IS_ERR(sonypi_device.pdev)) {
-		ret = PTR_ERR(sonypi_device.pdev);
-		goto out_platformdev;
-	}
-
 	sonypi_enable(0);
 
-	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver"
-	       "v%s.\n", SONYPI_DRIVER_VERSION);
-	printk(KERN_INFO "sonypi: detected type%d model, "
-	       "verbose = %d, fnkeyinit = %s, camera = %s, "
-	       "compat = %s, mask = 0x%08lx, useinput = %s, acpi = %s\n",
-	       sonypi_device.model,
-	       verbose,
-	       fnkeyinit ? "on" : "off",
-	       camera ? "on" : "off",
-	       compat ? "on" : "off",
-	       mask,
-	       useinput ? "on" : "off",
-	       SONYPI_ACPI_ACTIVE ? "on" : "off");
-	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
-	       sonypi_device.irq,
-	       sonypi_device.ioport1, sonypi_device.ioport2);
-
-	if (minor == -1)
-		printk(KERN_INFO "sonypi: device allocated minor is %d\n",
-		       sonypi_misc_device.minor);
-
 	return 0;
 
-out_platformdev:
-	kfifo_free(sonypi_device.input_fifo);
-out_infifo:
+ err_inpdev_unregister:
 	input_unregister_device(sonypi_device.input_key_dev);
 	input_unregister_device(sonypi_device.input_jog_dev);
-out_inputdevices:
+ err_miscdev_unregister:
+	misc_deregister(&sonypi_misc_device);
+ err_free_irq:
 	free_irq(sonypi_device.irq, sonypi_irq);
-out_reqirq:
+ err_free_ioports:
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
-out_reqreg:
-	misc_deregister(&sonypi_misc_device);
-out_miscreg:
+ err_disable_pcidev:
 	if (pcidev)
 		pci_disable_device(pcidev);
-out_pcienable:
+ err_put_pcidev:
+	pci_dev_put(pcidev);
 	kfifo_free(sonypi_device.fifo);
-out_fifo:
-	pci_dev_put(sonypi_device.dev);
-	return ret;
+
+	return error;
 }
 
-static void __devexit sonypi_remove(void)
+static int __devexit sonypi_remove(struct platform_device *dev)
 {
 	sonypi_disable();
 
 	synchronize_sched();  /* Allow sonypi interrupt to complete. */
 	flush_scheduled_work();
 
-	platform_device_unregister(sonypi_device.pdev);
-
 	if (useinput) {
 		input_unregister_device(sonypi_device.input_key_dev);
 		input_unregister_device(sonypi_device.input_jog_dev);
 		kfifo_free(sonypi_device.input_fifo);
 	}
 
+	misc_deregister(&sonypi_misc_device);
+
 	free_irq(sonypi_device.irq, sonypi_irq);
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
-	misc_deregister(&sonypi_misc_device);
-	if (sonypi_device.dev)
+
+	if (sonypi_device.dev) {
 		pci_disable_device(sonypi_device.dev);
+		pci_dev_put(sonypi_device.dev);
+	}
+
 	kfifo_free(sonypi_device.fifo);
-	pci_dev_put(sonypi_device.dev);
-	printk(KERN_INFO "sonypi: removed.\n");
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int old_camera_power;
+
+static int sonypi_suspend(struct platform_device *dev, pm_message_t state)
+{
+	old_camera_power = sonypi_device.camera_power;
+	sonypi_disable();
+
+	return 0;
+}
+
+static int sonypi_resume(struct platform_device *dev)
+{
+	sonypi_enable(old_camera_power);
+	return 0;
 }
+#else
+#define sonypi_suspend	NULL
+#define sonypi_resume	NULL
+#endif
+
+static void sonypi_shutdown(struct platform_device *dev)
+{
+	sonypi_disable();
+}
+
+static struct platform_driver sonypi_driver = {
+	.driver		= {
+		.name	= "sonypi",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sonypi_probe,
+	.remove		= __devexit_p(sonypi_remove),
+	.shutdown	= sonypi_shutdown,
+	.suspend	= sonypi_suspend,
+	.resume		= sonypi_resume,
+};
+
+static struct platform_device *sonypi_platform_device;
 
 static struct dmi_system_id __initdata sonypi_dmi_table[] = {
 	{
@@ -1451,26 +1488,43 @@ static struct dmi_system_id __initdata s
 
 static int __init sonypi_init(void)
 {
-	int ret;
+	int error;
+
+	printk(KERN_INFO
+		"sonypi: Sony Programmable I/O Controller Driver v%s.\n",
+		SONYPI_DRIVER_VERSION);
 
 	if (!dmi_check_system(sonypi_dmi_table))
 		return -ENODEV;
 
-	ret = platform_driver_register(&sonypi_driver);
-	if (ret)
-		return ret;
+	error = platform_driver_register(&sonypi_driver);
+	if (error)
+		return error;
+
+	sonypi_platform_device = platform_device_alloc("sonypi", -1);
+	if (!sonypi_platform_device) {
+		error = -ENOMEM;
+		goto err_driver_unregister;
+	}
 
-	ret = sonypi_probe();
-	if (ret)
-		platform_driver_unregister(&sonypi_driver);
+	error = platform_device_add(sonypi_platform_device);
+	if (error)
+		goto err_free_device;
 
-	return ret;
+	return 0;
+
+ err_free_device:
+	platform_device_put(sonypi_platform_device);
+ err_driver_unregister:
+	platform_driver_unregister(&sonypi_driver);
+	return error;
 }
 
 static void __exit sonypi_exit(void)
 {
+	platform_device_unregister(sonypi_platform_device);
 	platform_driver_unregister(&sonypi_driver);
-	sonypi_remove();
+	printk(KERN_INFO "sonypi: removed.\n");
 }
 
 module_init(sonypi_init);


