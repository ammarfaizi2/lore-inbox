Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWEJA4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWEJA4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 20:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWEJA4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 20:56:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:43196 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932349AbWEJA4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 20:56:41 -0400
X-Authenticated: #31060655
Message-ID: <446139FF.205@gmx.net>
Date: Wed, 10 May 2006 02:55:27 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: trenn@suse.de, Pavel Machek <pavel@suse.cz>, thoenig@suse.de
Subject: [RFC] [PATCH] Execute PCI quirks on resume from suspend-to-RAM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

machines with the asus_hides_smbus "feature" have the problem
that the smbus is disabled again after suspend-to-RAM. This
causes all sorts of problems, the worst being a total fan
failure on my Samsung P35 notebook after STR and STD.

References: Novell bugzilla #173420.

This (totally ugly) patch fixes it.
Comments/criticism welcome.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
-- 
http://www.hailfinger.org/

--- linux-2.6.16.14/drivers/acpi/sleep/main.c	2006-05-09 19:02:39.000000000 +0200
+++ linux-2.6.16.14/drivers/acpi/sleep/main.c	2006-05-10 01:47:07.000000000 +0200
@@ -10,6 +10,7 @@
  *
  */

+#include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/dmi.h>
@@ -24,6 +25,7 @@
 static struct pm_ops acpi_pm_ops;

 extern void do_suspend_lowlevel(void);
+extern struct pci_dev *asus_lpc_pcidev;

 static u32 acpi_suspend_states[] = {
 	[PM_SUSPEND_ON] = ACPI_STATE_S0,
@@ -116,6 +118,9 @@
 	if (pm_state > PM_SUSPEND_STANDBY)
 		acpi_restore_state_mem();

+	if (asus_lpc_pcidev)
+		pci_fixup_device(pci_fixup_header, asus_lpc_pcidev);
+
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }

--- linux-2.6.16.14/drivers/pci/quirks.c	2006-05-05 02:03:45.000000000 +0200
+++ linux-2.6.16.14/drivers/pci/quirks.c	2006-05-10 01:51:06.000000000 +0200
@@ -873,9 +873,10 @@
  * becomes necessary to do this tweak in two steps -- I've chosen the Host
  * bridge as trigger.
  */
-static int __initdata asus_hides_smbus = 0;
+static int asus_hides_smbus = 0;
+struct pci_dev *asus_lpc_pcidev = NULL;

-static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
+static void asus_hides_smbus_hostbridge(struct pci_dev *dev)
 {
 	if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
 		if (dev->device == PCI_DEVICE_ID_INTEL_82845_HB)
@@ -968,7 +969,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_HB, asus_hides_smbus_hostbridge );

-static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
+static void asus_hides_smbus_lpc(struct pci_dev *dev)
 {
 	u16 val;
 	
@@ -981,8 +982,11 @@
 		pci_read_config_word(dev, 0xF2, &val);
 		if (val & 0x8)
 			printk(KERN_INFO "PCI: i801 SMBus device continues to play 'hide and seek'! 0x%x\n", val);
-		else
+		else {
 			printk(KERN_INFO "PCI: Enabled i801 SMBus device\n");
+			if (!asus_lpc_pcidev)
+				asus_lpc_pcidev = dev;
+		}
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc );
@@ -991,7 +995,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );

-static void __init asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
+static void asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
 {
 	u32 val, rcba;
 	void __iomem *base;
@@ -1374,4 +1378,5 @@
 EXPORT_SYMBOL(pcie_mch_quirk);
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_fixup_device);
+EXPORT_SYMBOL(asus_lpc_pcidev);
 #endif


