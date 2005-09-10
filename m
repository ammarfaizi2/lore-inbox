Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbVIJAUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbVIJAUm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 20:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVIJAUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 20:20:42 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:25533 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932635AbVIJAUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 20:20:41 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:message-id;
	b=OqCbXysq3AhAATaqoHslvkdba7ikSYdC7dfKvqAU15YbfV8LHCY2j++iZkmFYXXNS
	V2CraOxVFfs5FxRlJjHPQ==
Date: Fri, 09 Sep 2005 17:20:33 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: SPI redux ... [refresh, 2/2]
Cc: dpervushin@ru.mvista.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050910002033.58AF9E9DEE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second part, with some example code for each part
of the system an SPI stack would need to provide.

- Dave

--------------------------	SNIP!

This has code for two SPI examples:

  - "ads7846.c" -- a protocol driver that reads some sensors.

  - "spi_plat_example.c" sets up up a multi-device configuration.

There are Linux systems using the ADS chip for touchscreen inputs, and
before long this should handle that part too.  (Examples include Zaurus
Corgi models, and the OMAP OSK with the Mistral add-on board.)


--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ osk/drivers/spi/ads7846.c	2005-09-09 16:53:51.030088662 -0700
@@ -0,0 +1,171 @@
+#include <linux/autoconf.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/spi.h>
+
+
+
+/* The ADS7846 has touchscreen and other sensors; this driver will
+ * eventually feed touchscreen events to the input layer.
+ *
+ * The protocol is MicroWire compatible:  write a command byte,
+ * then read the resulting ADC conversion value.
+ */
+#define	ADS_START		(1 << 7)
+#define	ADS_A2A1A0_d_y		(1 << 4)	/* differential */
+#define	ADS_A2A1A0_d_z1		(3 << 4)	/* differential */
+#define	ADS_A2A1A0_d_z2		(4 << 4)	/* differential */
+#define	ADS_A2A1A0_d_x		(5 << 4)	/* differential */
+#define	ADS_A2A1A0_temp0	(0 << 4)	/* non-differential */
+#define	ADS_A2A1A0_vbatt	(2 << 4)	/* non-differential */
+#define	ADS_A2A1A0_vaux		(6 << 4)	/* non-differential */
+#define	ADS_A2A1A0_temp1	(7 << 4)	/* non-differential */
+#define	ADS_8_BIT		(1 << 3)
+#define	ADS_12_BIT		(0 << 3)
+#define	ADS_SER			(1 << 2)	/* non-differential */
+#define	ADS_DFR			(0 << 2)	/* differential */
+#define	ADS_PD10_PDOWN		(0 << 0)	/* lowpower mode */
+#define	ADS_PD10_ADC_ON		(1 << 0)	/* ADC on */
+#define	ADS_PD10_REF_ON		(2 << 0)	/* vREF on */
+#define	ADS_PD10_ALL_ON		(3 << 0)	/* ADC + vREF on */
+
+#define	READ_12BIT_DFR(x) (ADS_START | ADS_A2A1A0_d_ ## x \
+	| ADS_12_BIT | ADS_DFR | ADS_PD10_PDOWN)
+
+#define	READ_12BIT_SER(x) (ADS_START | ADS_A2A1A0_ ## x \
+	| ADS_12_BIT | ADS_SER | ADS_PD10_REF_ON)
+
+static DECLARE_MUTEX(lock);
+
+/*--------------------------------------------------------------------------*/
+
+/*
+ * some sensors only use single-ended conversion
+ */
+static int ads7846_read12_ser(struct device *dev, unsigned command)
+{
+	struct spi_device	*spi = to_spi_device(dev);
+	int			sample;
+
+	down(&lock);
+
+	/* activate reference, so it has time to settle; */
+	(void) spi_w8r16(spi, READ_12BIT_DFR(x) | ADS_PD10_REF_ON);
+
+	/* take sample, then turn off reference */
+	sample = spi_w8r16(spi, command);
+	(void) spi_w8r16(spi, READ_12BIT_DFR(y));
+
+	up(&lock);
+
+	return sample;
+}
+
+#define SHOW(name) static ssize_t \
+name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	ssize_t v = ads7846_read12_ser(dev, READ_12BIT_SER(name)); \
+	if (v < 0) \
+		return v; \
+	return sprintf(buf, "%u\n", (unsigned) v); \
+} \
+static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
+
+SHOW(temp0)
+SHOW(temp1)
+SHOW(vaux)
+SHOW(vbatt)
+
+// FIXME replace this with touchscreen input event code.
+#define	DFR_TEST
+
+
+#ifdef	DFR_TEST
+/*
+ * touchscreen sensors normally use differential conversion
+ */
+static int ads7846_read12_dfr(struct device *dev, unsigned command)
+{
+	int value;
+
+	down(&lock);
+	value = spi_w8r16(to_spi_device(dev), command);
+	up(&lock);
+
+	return value;
+}
+
+#define SHOW_D(name) static ssize_t \
+name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	ssize_t v = ads7846_read12_dfr(dev, READ_12BIT_DFR(name)); \
+	if (v < 0) \
+		return v; \
+	return sprintf(buf, "%u\n", (unsigned) v); \
+} \
+static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
+
+SHOW_D(x)
+SHOW_D(y)
+SHOW_D(z1)
+SHOW_D(z2)
+#endif	/* DFR_TEST */
+
+
+/*--------------------------------------------------------------------------*/
+
+static int ads7846_probe(struct device *dev)
+{
+	device_create_file(dev, &dev_attr_temp0);
+	device_create_file(dev, &dev_attr_temp1);
+	device_create_file(dev, &dev_attr_vaux);
+	device_create_file(dev, &dev_attr_vbatt);
+#ifdef	DFR_TEST
+	device_create_file(dev, &dev_attr_x);
+	device_create_file(dev, &dev_attr_y);
+	device_create_file(dev, &dev_attr_z1);
+	device_create_file(dev, &dev_attr_z2);
+#endif
+	pr_debug("%s: probed\n", dev->bus_id);
+	return 0;
+}
+
+static int ads7846_remove(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_temp0);
+	device_remove_file(dev, &dev_attr_temp1);
+	device_remove_file(dev, &dev_attr_vaux);
+	device_remove_file(dev, &dev_attr_vbatt);
+#ifdef	DFR_TEST
+	device_remove_file(dev, &dev_attr_x);
+	device_remove_file(dev, &dev_attr_y);
+	device_remove_file(dev, &dev_attr_z1);
+	device_remove_file(dev, &dev_attr_z2);
+#endif
+	pr_debug("%s: removed\n", dev->bus_id);
+	return 0;
+}
+
+static struct device_driver ads7846 = {
+	.name		= "ads7846",
+	.bus		= &spi_bus_type,
+	.owner		= THIS_MODULE,
+	.probe		= ads7846_probe,
+	.remove		= ads7846_remove,
+};
+
+static int __init ads7846_init(void)
+{
+	return driver_register(&ads7846);
+}
+module_init(ads7846_init);
+
+static void __exit ads7846_exit(void)
+{
+	driver_unregister(&ads7846);
+}
+module_exit(ads7846_exit);
+
+MODULE_LICENSE("GPL");
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ osk/drivers/spi/spi_plat_example.c	2005-09-09 16:53:51.031088472 -0700
@@ -0,0 +1,331 @@
+/*
+ * this file is an example showing how a platform could use this
+ * minimal <linux/spi.h> framework:
+ *
+ *  - board-specific tables for what SPI devices exist
+ *  - board-specific tables for what SPI (master) controllers exist
+ *  - SPI controller drivers
+ *  - SPI protocol drivers (SEPARATE)
+ */
+
+#include <linux/autoconf.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/spi.h>
+
+
+/* ... actually no board-specific stuff should be done in a module;
+ * it all needs to run in early boot code.  only the device drivers
+ * (both controller and protocol) should be modular.
+ */
+MODULE_LICENSE("GPL");
+
+
+/* FIRST PART:  board-specific table listing the built-in SPI devices
+ * by address (bus and chipselect numbers) and type.
+ *
+ * On ARM this will usually live in linux/arch/arm/mach-X/board-Y.c
+ * files, with the bus numbers being defined by the SOC ("X") to
+ * address each of the SPI-capable controllers.
+ */
+
+#define	MHZ(x)	((x) * 1000 * 1000)
+
+static /* const */ struct spi_board_info __initdata my_board_info[] = { {
+	.modalias	= "dataflash",		/* root filesystem */
+	.max_speed_hz	= MHZ(50),
+	.bus_num	= 1,
+	.chip_select	= 0,
+}, {
+	.modalias	= "ads7846",		/* touchscreen/other sensors */
+	.max_speed_hz	= MHZ(3),
+	.bus_num	= 1,
+	.chip_select	= 3,
+}, {
+	.modalias	= "dataflash",		/* card in MMC socket, etc */
+	.max_speed_hz	= MHZ(20),
+	.bus_num	= 3,
+	.chip_select	= 3,
+}, {
+	.modalias	= "n9604_udc",		/* USB peripheral */
+	.max_speed_hz	= MHZ(12),
+	.bus_num	= 6,
+	.chip_select	= 0,
+} };
+
+
+static int __init myboard_init(void)
+{
+	spi_register_board_info(my_board_info, ARRAY_SIZE(my_board_info));
+}
+// arch_initcall(myboard_init);
+
+
+/*-----------------------------------------------------------------------*/
+
+/* SECOND PART:  board-specific table listing the SPI master controllers
+ * that are in use, and their bus numbers.
+ *
+ * On ARM this is often called **indirectly** from the mach-X/board-Y.c
+ * files, through shared code.  For example the board code may declare to
+ * shared SOC-specific code which of the controllers are in use, and how
+ * they're pinned out.  Then that shared code would multiplex pins to suit,
+ * and register the relevant platform devices.  Not every board would use
+ * that SOC's "mmc2"; but on boards that do, it'll look and act the same.
+ */
+
+static struct platform_device plat_spi = {
+	/* dedicated SPI controller */
+	.name		= "plat_spi",
+	.id		= 1,
+	// ... there'd likely be memory and IRQ resources
+};
+
+static struct platform_device mmc1_spi = {
+	/* one of two MMC controllers, used in SPI mode */
+	.name		= "mmc_spi",
+	.id		= 3,
+	// ... there'd likely be memory and IRQ resources
+};
+
+static struct platform_device ssp2_spi = {
+	/* one of three SSP controllers, used in SPI mode */
+	.name		= "ssp_spi",
+	.id		= 6,
+	// ... there'd likely be memory and IRQ resources
+};
+
+static int __init myboard_init2(void)
+{
+	platform_device_register(&plat_spi);
+	platform_device_register(&mmc1_spi);
+	platform_device_register(&ssp2_spi);
+}
+// arch_initcall(myboard_init2);
+
+#if 0
+static void __exit myboard_exit2(void)
+{
+	/* NOTE:  normally board-specific code NEVER unregisters
+	 * platform devices.  THIS IS ONLY FOR DEBUG, and can oops ...
+	 */
+	platform_device_unregister(&plat_spi);
+	platform_device_unregister(&mmc1_spi);
+	platform_device_unregister(&ssp2_spi);
+}
+#endif
+
+/*-----------------------------------------------------------------------*/
+
+/* THIRD PART:  SPI (master) controller drivers
+ *
+ * These would normally live in separate linux/drivers/spi/... files,
+ * one per driver, with the other SPI controller drivers.  Even after
+ * they're registered, they can't do anything until the board-specific
+ * code populates the SPI device table.
+ *
+ * This is really one driver faking itself as three, with methods that
+ * do nothing except print what they SHOULD do.  (Someone ambitious could
+ * plug in an SPI slave API emulator there...)
+ *
+ * Note that these drivers "should" never have board-specific code.
+ * Use platform_data to provide board-specific parameters as much as
+ * possible, avoiding "if (machine_is_xyzzy()) { ... }" type logic.
+ */
+
+struct foo_master {
+	// spinlock_t		lock;
+	struct spi_master	master;
+	struct list_head	queue;
+};
+
+static int foo_setup(struct spi_device *spi)
+{
+	struct foo_master	*foo;
+
+	foo = container_of(spi->master, struct foo_master, master);
+	// spin_lock_irqsave(&foo->lock, flags);
+
+	/* a real driver would write hardware config registers here.
+	 * ideally this is enough:  no per-request tweaking is needed.
+	 */
+	pr_debug("%s setup: %u MHz, mode %d\n",
+			spi->dev.bus_id,
+			spi->max_speed_hz / 1000000,
+			spi->mode);
+
+	// spin_unlock_irqrestore(&foo->lock, flags);
+	return 0;
+}
+
+static int foo_transfer(struct spi_device *spi, struct spi_message *msg)
+{
+	struct foo_master	*foo;
+	unsigned		i;
+
+	msg->actual_length = 0;
+	msg->status = 0;
+	foo = container_of(spi->master, struct foo_master, master);
+	// spin_lock_irqsave(&foo->lock, flags);
+
+	// if the queue is running,
+	// 	list_add_tail(&msg->queue, &foo->queue)
+	// or, PIO may be an option too.
+
+	// activate spi->chip_select, if it's not already active
+
+	/* a real driver would perform the transfers using either
+	 * PIO or DMA.  with DMA it might just append to foo->queue
+	 * and use interrupts to work through the queue.
+	 */
+	for (i = 0; i < msg->n_transfer; i++) {
+		static u8		counter;
+		struct spi_transfer	*x = msg->transfers + i;
+
+		pr_debug("%s: [%u] %u bytes %s\n",
+				spi->dev.bus_id, i, x->len,
+				(x->tx_buf && x->rx_buf) ? "read/write" :
+				(x->tx_buf ? "write" :
+				(x->rx_buf ? "read" : "??")));
+		if (x->rx_buf)
+			memset(x->rx_buf, counter++, x->len);
+		msg->actual_length += x->len;
+	}
+
+	// if (!msg->csrel_disable) deactivate spi->chip_select
+
+	// msg->status = -EIO;
+	msg->complete(msg->context);
+	// spin_unlock_irqrestore(&foo->lock, flags);
+	return 0;
+}
+
+#define	kzalloc(n, flags)	kcalloc(1,(n),(flags))
+
+static int __init foo_probe(struct device *dev)
+{
+	struct platform_device	*pdev = to_platform_device(dev);
+	struct foo_master	*foo;
+	int			status;
+
+	foo = kzalloc(sizeof *foo, GFP_KERNEL);
+	if (!foo)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&foo->queue);
+
+	/* Here, SPI bus numbers are the same as platform bus IDs.
+	 * You probably won't do that on real hardware, since that
+	 * causes misnamings ("ssp1" hardware called "ssp5", etc).
+	 */
+	foo->master.bus_num = pdev->id;
+	foo->master.setup = foo_setup;
+	foo->master.transfer = foo_transfer;
+
+	switch (pdev->id) {
+	case 1:			/* SPI */
+	case 2:			/* MicroWire */
+		foo->master.num_chipselect = 4;
+		break;
+	case 3:			/* MMC */
+	case 4:
+		foo->master.num_chipselect = 16;
+		break;
+	case 5:			/* SSP, McBSP, etc */
+	case 6:
+	case 7:
+		foo->master.num_chipselect = 1;
+		break;
+	}
+
+	/* this fake hardware needs no clock or power gating ... */
+
+	dev_set_drvdata(dev, foo);
+	status = spi_register_master(dev, &foo->master);
+//	if (!status)
+//		kfree(foo);
+	return status;
+}
+
+static int __exit foo_remove(struct device *dev)
+{
+	struct foo_master	*foo = foo = dev_get_drvdata(dev);
+
+	spi_unregister_master(&foo->master);
+//	kfree(foo);
+	return 0;
+}
+
+static struct device_driver plat_spi_driver = {
+	.name		= "plat_spi",
+	.bus		= &platform_bus_type,
+	.owner		= THIS_MODULE,
+
+	.probe		= foo_probe,
+	.remove		= __exit_p(foo_remove),
+};
+
+static struct device_driver ssp_spi_driver = {
+	.name		= "ssp_spi",
+	.bus		= &platform_bus_type,
+	.owner		= THIS_MODULE,
+
+	.probe		= foo_probe,
+	.remove		= __exit_p(foo_remove),
+};
+
+static struct device_driver mmc_spi_driver = {
+	.name		= "mmc_spi",
+	.bus		= &platform_bus_type,
+	.owner		= THIS_MODULE,
+
+	.probe		= foo_probe,
+	.remove		= __exit_p(foo_remove),
+};
+
+static int __init init3(void)
+{
+	driver_register(&plat_spi_driver);
+	driver_register(&mmc_spi_driver);
+	driver_register(&ssp_spi_driver);
+}
+// device_initcall(init3);
+
+#if 0
+static void __exit exit3(void)
+{
+	driver_unregister(&plat_spi_driver);
+	driver_unregister(&mmc_spi_driver);
+	driver_unregister(&ssp_spi_driver);
+}
+#endif
+
+/*-----------------------------------------------------------------------*/
+
+/* FOURTH PART:  SPI protocol driver(s)
+ *
+ * NOT HERE -- separate modules
+ */
+
+/*-----------------------------------------------------------------------*/
+
+static int __init kluge1(void)
+{
+	myboard_init();
+	myboard_init2();
+	init3();
+	return 0;
+}
+module_init(kluge1);
+
+#if 0
+static void __exit kluge2(void)
+{
+pr_debug("%s\n", __FUNCTION__);
+	exit3();
+	myboard_exit2();
+	// myboard_exit();
+}
+module_exit(kluge2);
+#endif
