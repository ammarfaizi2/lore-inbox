Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263571AbUJ2ViC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUJ2ViC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbUJ2VfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:35:24 -0400
Received: from atarelbas03.hp.com ([156.153.255.206]:2185 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S263629AbUJ2VaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:30:23 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Bob Picco <Robert.Picco@hp.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [PATCH] HPET init/add fixes
Date: Fri, 29 Oct 2004 15:30:12 -0600
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kZrgBo1aBoAHxcs"
Message-Id: <200410291530.12174.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_kZrgBo1aBoAHxcs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Cleanup/bugfix HPET driver:

    - hpet_init() could return failure with driver still registered with ACPI
    - driver add() functions were marked __init, but can be called any time
      until driver is unregistered (not a real problem until HPETs can be
      hotplugged)
    - time interpolator registration now done in driver add() path, so we can
      support removal of HPETs someday
    - physical MMIO address should be printed, not ioremapped address

--Boundary-00=_kZrgBo1aBoAHxcs
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hpet-cleanup-bugfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hpet-cleanup-bugfix.patch"

Cleanup/bugfix HPET driver:

    - hpet_init() could return failure with driver still registered with ACPI
    - driver add() functions were marked __init, but can be called any time
      until driver is unregistered (not a real problem until HPETs can be
      hotplugged)
    - time interpolator registration now done in driver add() path, so we can
      support removal of HPETs someday
    - physical MMIO address should be printed, not ioremapped address

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff -u -ur 2.6.10-rc1-mm2/arch/i386/kernel/time_hpet.c acpi-register2/arch/i386/kernel/time_hpet.c
--- 2.6.10-rc1-mm2/arch/i386/kernel/time_hpet.c	2004-10-29 12:56:32.312804006 -0600
+++ acpi-register2/arch/i386/kernel/time_hpet.c	2004-10-29 14:16:10.892823594 -0600
@@ -161,6 +161,7 @@
 		 * Register with driver.
 		 * Timer0 and Timer1 is used by platform.
 		 */
+		hd.hd_phys_address = hpet_address;
 		hd.hd_address = hpet_virt_address;
 		hd.hd_nirqs = ntimer;
 		hd.hd_flags = HPET_DATA_PLATFORM;
diff -u -ur 2.6.10-rc1-mm2/arch/x86_64/kernel/time.c acpi-register2/arch/x86_64/kernel/time.c
--- 2.6.10-rc1-mm2/arch/x86_64/kernel/time.c	2004-10-29 12:56:32.503233691 -0600
+++ acpi-register2/arch/x86_64/kernel/time.c	2004-10-29 14:22:45.400631261 -0600
@@ -746,6 +746,7 @@
 	 * Register with driver.
 	 * Timer0 and Timer1 is used by platform.
 	 */
+	hd.hd_phys_address = vxtime.hpet_address;
 	hd.hd_address = (void *)fix_to_virt(FIX_HPET_BASE);
 	hd.hd_nirqs = ntimer;
 	hd.hd_flags = HPET_DATA_PLATFORM;
diff -u -ur 2.6.10-rc1-mm2/drivers/char/hpet.c acpi-register2/drivers/char/hpet.c
--- 2.6.10-rc1-mm2/drivers/char/hpet.c	2004-10-29 12:56:14.820616721 -0600
+++ acpi-register2/drivers/char/hpet.c	2004-10-29 15:10:27.288291515 -0600
@@ -76,6 +76,7 @@
 struct hpets {
 	struct hpets *hp_next;
 	struct hpet __iomem *hp_hpet;
+	struct time_interpolator *hp_interpolator;
 	unsigned long hp_period;
 	unsigned long hp_delta;
 	unsigned int hp_ntimer;
@@ -660,15 +661,6 @@
 	return hpet_ioctl_common(devp, cmd, arg, 1);
 }
 
-#ifdef	CONFIG_TIME_INTERPOLATION
-
-static struct time_interpolator hpet_interpolator = {
-	.source = TIME_SOURCE_MMIO64,
-	.shift = 10
-};
-
-#endif
-
 static ctl_table hpet_table[] = {
 	{
 	 .ctl_name = 1,
@@ -705,6 +697,27 @@
 
 static struct ctl_table_header *sysctl_header;
 
+static void hpet_register_interpolator(struct hpets *hpetp)
+{
+#ifdef	CONFIG_TIME_INTERPOLATION
+	struct time_interpolator *ti;
+
+	ti = kmalloc(sizeof(*ti), GFP_KERNEL);
+	if (!ti)
+		return;
+
+	memset(ti, 0, sizeof(*ti));
+	ti->source = TIME_SOURCE_MMIO64;
+	ti->shift = 10;
+	ti->addr = &hpetp->hp_hpet->hpet_mc;
+	ti->frequency = hpet_time_div(hpets->hp_period);
+	ti->drift = ti->frequency * HPET_DRIFT / 1000000;
+
+	hpetp->hp_interpolator = ti;
+	register_time_interpolator(ti);
+#endif
+}
+
 /*
  * Adjustment for when arming the timer with
  * initial conditions.  That is, main counter
@@ -712,7 +725,7 @@
  */
 #define	TICK_CALIBRATE	(1000UL)
 
-static unsigned long __init hpet_calibrate(struct hpets *hpetp)
+static unsigned long hpet_calibrate(struct hpets *hpetp)
 {
 	struct hpet_timer __iomem *timer = NULL;
 	unsigned long t, m, count, i, flags, start;
@@ -749,7 +762,7 @@
 	return (m - start) / i;
 }
 
-int __init hpet_alloc(struct hpet_data *hdp)
+int hpet_alloc(struct hpet_data *hdp)
 {
 	u64 cap, mcfg;
 	struct hpet_dev *devp;
@@ -757,7 +770,7 @@
 	struct hpets *hpetp;
 	size_t siz;
 	struct hpet __iomem *hpet;
-	static struct hpets *last __initdata = (struct hpets *)0;
+	static struct hpets *last = (struct hpets *)0;
 	unsigned long ns;
 
 	/*
@@ -810,8 +823,9 @@
 	hpetp->hp_period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
 	    HPET_COUNTER_CLK_PERIOD_SHIFT;
 
-	printk(KERN_INFO "hpet%d: at MMIO 0x%p, IRQ%s",
-		hpetp->hp_which, hpet, hpetp->hp_ntimer > 1 ? "s" : "");
+	printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
+		hpetp->hp_which, hdp->hd_phys_address,
+		hpetp->hp_ntimer > 1 ? "s" : "");
 	for (i = 0; i < hpetp->hp_ntimer; i++)
 		printk("%s %d", i > 0 ? "," : "", hdp->hd_irq[i]);
 	printk("\n");
@@ -854,11 +868,12 @@
 	}
 
 	hpetp->hp_delta = hpet_calibrate(hpetp);
+	hpet_register_interpolator(hpetp);
 
 	return 0;
 }
 
-static acpi_status __init hpet_resources(struct acpi_resource *res, void *data)
+static acpi_status hpet_resources(struct acpi_resource *res, void *data)
 {
 	struct hpet_data *hdp;
 	acpi_status status;
@@ -873,6 +888,7 @@
 		unsigned long size;
 
 		size = addr.max_address_range - addr.min_address_range + 1;
+		hdp->hd_phys_address = addr.min_address_range;
 		hdp->hd_address = ioremap(addr.min_address_range, size);
 
 		for (hpetp = hpets; hpetp; hpetp = hpetp->hp_next)
@@ -898,7 +914,7 @@
 	return AE_OK;
 }
 
-static int __init hpet_acpi_add(struct acpi_device *device)
+static int hpet_acpi_add(struct acpi_device *device)
 {
 	acpi_status result;
 	struct hpet_data data;
@@ -920,9 +936,10 @@
 	return hpet_alloc(&data);
 }
 
-static int __init hpet_acpi_remove(struct acpi_device *device, int type)
+static int hpet_acpi_remove(struct acpi_device *device, int type)
 {
-	return 0;
+	/* XXX need to unregister interpolator, dealloc mem, etc */
+	return -EINVAL;
 }
 
 static struct acpi_driver hpet_acpi_driver = {
@@ -938,37 +955,32 @@
 
 static int __init hpet_init(void)
 {
-	(void)acpi_bus_register_driver(&hpet_acpi_driver);
+	int result;
 
-	if (hpets) {
-		if (misc_register(&hpet_misc))
-			return -ENODEV;
+	result = misc_register(&hpet_misc);
+	if (result < 0)
+		return -ENODEV;
 
-		sysctl_header = register_sysctl_table(dev_root, 0);
+	sysctl_header = register_sysctl_table(dev_root, 0);
 
-#ifdef	CONFIG_TIME_INTERPOLATION
-		{
-			struct hpet *hpet;
+	result = acpi_bus_register_driver(&hpet_acpi_driver);
+	if (result < 0) {
+		if (sysctl_header)
+			unregister_sysctl_table(sysctl_header);
+		misc_deregister(&hpet_misc);
+		return result;
+	}
 
-			hpet = hpets->hp_hpet;
-			hpet_interpolator.addr = &hpets->hp_hpet->hpet_mc;
-			hpet_interpolator.frequency = hpet_time_div(hpets->hp_period);
-			hpet_interpolator.drift = hpet_interpolator.frequency *
-			    HPET_DRIFT / 1000000;
-			register_time_interpolator(&hpet_interpolator);
-		}
-#endif
-		return 0;
-	} else
-		return -ENODEV;
+	return 0;
 }
 
 static void __exit hpet_exit(void)
 {
 	acpi_bus_unregister_driver(&hpet_acpi_driver);
 
-	if (hpets)
+	if (sysctl_header)
 		unregister_sysctl_table(sysctl_header);
+	misc_deregister(&hpet_misc);
 
 	return;
 }
diff -u -ur 2.6.10-rc1-mm2/include/linux/hpet.h acpi-register2/include/linux/hpet.h
--- 2.6.10-rc1-mm2/include/linux/hpet.h	2004-10-29 12:56:12.138976128 -0600
+++ acpi-register2/include/linux/hpet.h	2004-10-29 14:14:02.947512661 -0600
@@ -112,6 +112,7 @@
 };
 
 struct hpet_data {
+	unsigned long hd_phys_address;
 	void __iomem *hd_address;
 	unsigned short hd_nirqs;
 	unsigned short hd_flags;

--Boundary-00=_kZrgBo1aBoAHxcs--
