Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVCVBQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVCVBQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVCVBNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:13:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:51345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262251AbVCVBHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:07:00 -0500
Date: Mon, 21 Mar 2005 17:06:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-Id: <20050321170623.4eabc7f8.akpm@osdl.org>
In-Reply-To: <20050322004456.GB1372@elf.ucw.cz>
References: <20050321025159.1cabd62e.akpm@osdl.org>
	<200503212343.31665.rjw@sisk.pl>
	<20050321160306.2f7221ec.akpm@osdl.org>
	<20050322004456.GB1372@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> > > On Monday, 21 of March 2005 11:51, you wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/
> > > 
> > > I get the following BUG every time I try to suspend my box to disk.
> > 
> > Pavel, that's the BUG() in pci_choose_state().  I did have some
> > reject-fixing to do on that wrt a change in Greg's tree, so maybe there was
> > some incompatible intent in there.
> > 
> > I dunno why pci_choose_state() is saying that it received PCI_D1, when
> > prepare_devices() is passing down PMSG_FREEZE?
> 
> Uf, I don't know what version that was.. I think I have
> 
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 12
> EXTRAVERSION =-rc1-mm1

yes, the report was against 2.6.12-rc1-mm1.

> and that says:
> 
> #define PMSG_FREEZE     ((__force pm_message_t) 3)
> 
> ... I certainly have _FREEZE defined as 1 in my local tree, but I do
> not see that change in -mm yet.

Both 2.6.12-rc1-mm1 and 2.6.12-rc1 have:

#define PMSG_FREEZE     ((__force pm_message_t) 3)
#define PMSG_SUSPEND    ((__force pm_message_t) 3)
#define PMSG_ON         ((__force pm_message_t) 0)

which looks odd.

> Possibly pm.h changes went in faster than pci.c or something like
> that?

grep says that 2.6.12-rc1-mm1 has these patches from you:

fix-suspend-resume-on-via-velocity.patch
x86-fix-esp-corruption-cpu-bug-take-2.patch
swsusp-add-missing-refrigerator-calls.patch
suspend-to-ram-update-videotxt-with-more-systems.patch
pm-remove-obsolete-pm_-from-vtc.patch
swsusp-small-updates.patch
swsusp-1-1-kill-swsusp_restore.patch
pcmcia-id_table-for-orinoco_cs.patch
fix-pm_message_t-in-generic-code.patch
fix-u32-vs-pm_message_t-in-usb.patch
more-pm_message_t-fixes.patch
fix-u32-vs-pm_message_t-confusion-in-oss.patch
fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
fix-u32-vs-pm_message_t-confusion-in-framebuffers.patch
fix-u32-vs-pm_message_t-confusion-in-mmc.patch
fix-u32-vs-pm_message_t-confusion-in-serials.patch
fix-u32-vs-pm_message_t-in-macintosh.patch
fix-u32-vs-pm_message_t-confusion-in-agp.patch

> I reproduced it here.. I do not know who introduced
> platform_pci_choose_state, but it is *very* wrong. It returns
> it. Should it return pci_power_t? It probably should to match
> pci_choose_state, but that int is retyped to pm_message_t. Oops.

That change came from Len.  I've appended the two relevant patches below.

So hm.  We have incompatible changes in flight.  That doesn't happen very
often.

Could I suggest that you prepare a fixup against 2.6.12-rc1-mm1 and send
that to Len and myself?  If that fixup is not suitable for a 2.6.12-rc1
based tree then I can look after it until things get flushed out.

(Len, platform_pci_set_power_state shouldn't be initialised to NULL).

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/19 00:15:48-05:00 len.brown@intel.com 
#   [ACPI] PCI can now get suspend state from firmware
#   
#   pci_choose_state() can now call
#   	platform_pci_choose_state()
#   		and ACPI can answer
#   
#   http://bugzilla.kernel.org/show_bug.cgi?id=4277
#   
#   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
#   Signed-off-by: Len Brown <len.brown@intel.com>
# 
# drivers/pci/pci.h
#   2005/03/19 00:15:24-05:00 len.brown@intel.com +3 -0
#   add platform_pci_choose_state()
# 
# drivers/pci/pci.c
#   2005/03/19 00:15:24-05:00 len.brown@intel.com +7 -0
#   add platform_pci_choose_state()
# 
# drivers/pci/pci-acpi.c
#   2005/03/19 00:15:24-05:00 len.brown@intel.com +46 -1
#   add platform_pci_choose_state()
# 
diff -Nru a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
--- a/drivers/pci/pci-acpi.c	2005-03-21 17:01:44 -08:00
+++ b/drivers/pci/pci-acpi.c	2005-03-21 17:01:44 -08:00
@@ -1,6 +1,6 @@
 /*
  * File:	pci-acpi.c
- * Purpose:	Provide PCI support in ACPI
+ * Purpose:	Provde PCI support in ACPI
  *
  * Copyright (C) 2005 David Shaohua Li <shaohua.li@intel.com>
  * Copyright (C) 2004 Tom Long Nguyen <tom.l.nguyen@intel.com>
@@ -17,6 +17,7 @@
 #include <acpi/acpi_bus.h>
 
 #include <linux/pci-acpi.h>
+#include "pci.h"
 
 static u32 ctrlset_buf[3] = {0, 0, 0};
 static u32 global_ctrlsets = 0;
@@ -209,6 +210,49 @@
 }
 EXPORT_SYMBOL(pci_osc_control_set);
 
+/*
+ * _SxD returns the D-state with the highest power
+ * (lowest D-state number) supported in the S-state "x".
+ *
+ * If the devices does not have a _PRW
+ * (Power Resources for Wake) supporting system wakeup from "x"
+ * then the OS is free to choose a lower power (higher number
+ * D-state) than the return value from _SxD.
+ *
+ * But if _PRW is enabled at S-state "x", the OS
+ * must not choose a power lower than _SxD --
+ * unless the device has an _SxW method specifying
+ * the lowest power (highest D-state number) the device
+ * may enter while still able to wake the system.
+ *
+ * ie. depending on global OS policy:
+ *
+ * if (_PRW at S-state x)
+ *	choose from highest power _SxD to lowest power _SxW
+ * else // no _PRW at S-state x
+ * 	choose highest power _SxD or any lower power
+ *
+ * currently we simply return _SxD, if present.
+ */
+
+static int acpi_pci_choose_state(struct pci_dev *pdev, pm_message_t state)
+{
+	char dstate_str[] = "_S0D";
+	acpi_status status;
+	unsigned long val;
+	struct device *dev = &pdev->dev;
+
+	/* Fixme: the check is wrong after pm_message_t is a struct */
+	if ((state >= PM_SUSPEND_MAX) || !DEVICE_ACPI_HANDLE(dev))
+		return -EINVAL;
+	dstate_str[2] += state;	/* _S1D, _S2D, _S3D, _S4D */
+	status = acpi_evaluate_integer(DEVICE_ACPI_HANDLE(dev), dstate_str,
+		NULL, &val);
+	if (ACPI_SUCCESS(status))
+		return val;
+	return -ENODEV;
+}
+
 /* ACPI bus type */
 static int pci_acpi_find_device(struct device *dev, acpi_handle *handle)
 {
@@ -255,6 +299,7 @@
 	ret = register_acpi_bus_type(&pci_acpi_bus);
 	if (ret)
 		return 0;
+	platform_pci_choose_state = acpi_pci_choose_state;
 	return 0;
 }
 arch_initcall(pci_acpi_init);
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2005-03-21 17:01:44 -08:00
+++ b/drivers/pci/pci.c	2005-03-21 17:01:44 -08:00
@@ -317,12 +317,19 @@
  * Returns PCI power state suitable for given device and given system
  * message.
  */
+int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state) = NULL;
 
 pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
 {
+	int	ret;
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
+	if (platform_pci_choose_state) {
+		ret = platform_pci_choose_state(dev, state);
+		if (ret >= 0)
+			state = ret;
+	}
 	switch (state) {
 	case 0:	return PCI_D0;
 	case 2: return PCI_D2;
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	2005-03-21 17:01:44 -08:00
+++ b/drivers/pci/pci.h	2005-03-21 17:01:44 -08:00
@@ -11,6 +11,9 @@
 				  void (*alignf)(void *, struct resource *,
 					  	 unsigned long, unsigned long),
 				  void *alignf_data);
+/* Firmware callbacks */
+extern int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);



# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/19 00:16:18-05:00 len.brown@intel.com 
#   [ACPI] pci_set_power_state() now calls
#   	platform_pci_set_power_state()
#   		and ACPI can answer
#   
#   http://bugzilla.kernel.org/show_bug.cgi?id=4277
#   
#   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
#   Signed-off-by: Len Brown <len.brown@intel.com>
# 
# drivers/pci/pci.h
#   2005/03/03 04:20:56-05:00 len.brown@intel.com +1 -0
#   pci_set_power_state() now calls platform_pci_set_power_state()
# 
# drivers/pci/pci.c
#   2005/03/03 04:20:56-05:00 len.brown@intel.com +9 -2
#   pci_set_power_state() now calls platform_pci_set_power_state()
# 
# drivers/pci/pci-acpi.c
#   2005/03/03 04:28:23-05:00 len.brown@intel.com +19 -0
#   pci_set_power_state() now calls platform_pci_set_power_state()
# 
# drivers/acpi/bus.c
#   2005/03/03 04:20:56-05:00 len.brown@intel.com +7 -1
#   pci_set_power_state() now calls platform_pci_set_power_state()
# 
diff -Nru a/drivers/acpi/bus.c b/drivers/acpi/bus.c
--- a/drivers/acpi/bus.c	2005-03-21 17:02:38 -08:00
+++ b/drivers/acpi/bus.c	2005-03-21 17:02:38 -08:00
@@ -212,6 +212,12 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Device is not power manageable\n"));
 		return_VALUE(-ENODEV);
 	}
+	/*
+	 * Get device's current power state if it's unknown
+	 * This means device power state isn't initialized or previous setting failed
+	 */
+	if (device->power.state == ACPI_STATE_UNKNOWN)
+		acpi_bus_get_power(device->handle, &device->power.state);
 	if (state == device->power.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n", state));
 		return_VALUE(0);
@@ -231,7 +237,7 @@
 	 * On transitions to a high-powered state we first apply power (via
 	 * power resources) then evalute _PSx.  Conversly for transitions to
 	 * a lower-powered state.
-	 */ 
+	 */
 	if (state < device->power.state) {
 		if (device->power.flags.power_resources) {
 			result = acpi_power_transition(device, state);
diff -Nru a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
--- a/drivers/pci/pci-acpi.c	2005-03-21 17:02:38 -08:00
+++ b/drivers/pci/pci-acpi.c	2005-03-21 17:02:38 -08:00
@@ -253,6 +253,24 @@
 	return -ENODEV;
 }
 
+static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+	static int state_conv[] = {
+		[0] = 0,
+		[1] = 1,
+		[2] = 2,
+		[3] = 3,
+		[4] = 3
+	};
+	int acpi_state = state_conv[(int __force) state];
+
+	if (!handle)
+		return -ENODEV;
+	return acpi_bus_set_power(handle, acpi_state);
+}
+
+
 /* ACPI bus type */
 static int pci_acpi_find_device(struct device *dev, acpi_handle *handle)
 {
@@ -300,6 +318,7 @@
 	if (ret)
 		return 0;
 	platform_pci_choose_state = acpi_pci_choose_state;
+	platform_pci_set_power_state = acpi_pci_set_power_state;
 	return 0;
 }
 arch_initcall(pci_acpi_init);
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2005-03-21 17:02:38 -08:00
+++ b/drivers/pci/pci.c	2005-03-21 17:02:38 -08:00
@@ -240,7 +240,7 @@
  * -EIO if device does not support PCI PM.
  * 0 if we can successfully change the power state.
  */
-
+int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t t) = NULL;
 int
 pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
@@ -304,8 +304,15 @@
 		msleep(10);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(200);
-	dev->current_state = state;
 
+	/*
+	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
+	 * Firmware method after natice method ?
+	 */
+	if (platform_pci_set_power_state)
+		platform_pci_set_power_state(dev, state);
+
+	dev->current_state = state;
 	return 0;
 }
 
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	2005-03-21 17:02:38 -08:00
+++ b/drivers/pci/pci.h	2005-03-21 17:02:38 -08:00
@@ -13,6 +13,7 @@
 				  void *alignf_data);
 /* Firmware callbacks */
 extern int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+extern int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t state);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS

