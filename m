Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751959AbWCBDT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbWCBDT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWCBDT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:19:58 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:38550 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751959AbWCBDT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:19:57 -0500
Message-ID: <44066401.3070207@jp.fujitsu.com>
Date: Thu, 02 Mar 2006 12:18:25 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [Pcihpd-discuss] [patch] pci hotplug: add common acpi	functions
 to core
References: <1141174017.28842.6.camel@whizzy>	 <44050A17.9030506@jp.fujitsu.com> <1141252941.13333.31.camel@whizzy>
In-Reply-To: <1141252941.13333.31.camel@whizzy>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Accardi wrote:
> On Wed, 2006-03-01 at 11:42 +0900, Kenji Kaneshige wrote:
> 
>>Hi Kristen,
>>
>>Here is one more comment.
>>
>>
>>>+void acpi_get_hp_params_from_firmware(struct pci_dev *dev,
>>>+		struct hotplug_params *hpp)
>>>+{
>>>+	acpi_status status = AE_NOT_FOUND;
>>>+	struct pci_dev *pdev = dev;
>>>+
>>>+	/*
>>>+	 * _HPP settings apply to all child buses, until another _HPP is
>>>+	 * encountered. If we don't find an _HPP for the input pci dev,
>>>+	 * look for it in the parent device scope since that would apply to
>>>+	 * this pci dev. If we don't find any _HPP, use hardcoded defaults
>>>+	 */
>>>+	while (pdev && (ACPI_FAILURE(status))) {
>>>+		acpi_handle handle = DEVICE_ACPI_HANDLE(&(pdev->dev));
>>>+		if (!handle)
>>>+			break;
>>>+		status = acpi_run_hpp(handle, hpp);
>>>+		if (!(pdev->bus->parent))
>>>+			break;
>>>+		/* Check if a parent object supports _HPP */
>>>+		pdev = pdev->bus->parent->self;
>>>+	}
>>>+}
>>>+EXPORT_SYMBOL_GPL(acpi_get_hp_params_from_firmware);
>>
>>I think the acpi_get_hp_params_from_firmware() function assumes that
>>users set default hpp parameters into *hpp before calling this function.
>>I think it is very hard for new users of the function to notice it, so
>>I think this assumption should be removed.
>>
>>Thanks,
>>Kenji Kaneshige
>>
> 
> 
> Are you suggesting that we have the defaults set within this function?
> I would like to change acpiphp to use the same functions to get hpp
> values eventually (in a different patch), but I notice that acpiphp sets
> the default cache line size to 8, while shpchp sets the default cache
> line size to 16.  So it seems like it would be better to allow drivers
> to set the default themselves, unless one of these drivers is doing the
> wrong thing and using the wrong default value.
> 

The other options are:

    (a) Leave the code as it is, and put the comments to indicate users
        how to use this function. That is, users have to set defaults
        before calling this function, otherwise the parameters returned
        from the function would be undefined.

    (b) Change the return value to let users know whether _HPP parameters
        were successfully parsed.

I'd prefer (b).
I'm attaching the sample patch for (b), though I've not tested it at all.
This patch is against 2.6.16-rc5-mm1 with the following patches applied

    - shpchp: cleanup bus speed handling
    - acpiphp: Scan slots under the nested P2P bridge
    - Your set of patches

Thanks,
Kenji Kaneshige


---
 drivers/pci/hotplug/acpi_pcihp.c  |    4 +++-
 drivers/pci/hotplug/pci_hotplug.h |    2 +-
 drivers/pci/hotplug/pciehp.h      |    9 +++++++++
 drivers/pci/hotplug/shpchp.h      |   12 +++++++++---
 drivers/pci/hotplug/shpchp_pci.c  |   15 +++++++++++++--
 5 files changed, 35 insertions(+), 7 deletions(-)

Index: linux-2.6.16-rc5-mm1/drivers/pci/hotplug/acpi_pcihp.c
===================================================================
--- linux-2.6.16-rc5-mm1.orig/drivers/pci/hotplug/acpi_pcihp.c	2006-03-02 10:47:08.000000000 +0900
+++ linux-2.6.16-rc5-mm1/drivers/pci/hotplug/acpi_pcihp.c	2006-03-02 11:05:01.000000000 +0900
@@ -143,7 +143,7 @@
 
 
 
-void acpi_get_hp_params_from_firmware(struct pci_dev *dev,
+acpi_status acpi_get_hp_params_from_firmware(struct pci_dev *dev,
 		struct hotplug_params *hpp)
 {
 	acpi_status status = AE_NOT_FOUND;
@@ -165,6 +165,8 @@
 		/* Check if a parent object supports _HPP */
 		pdev = pdev->bus->parent->self;
 	}
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(acpi_get_hp_params_from_firmware);
 
Index: linux-2.6.16-rc5-mm1/drivers/pci/hotplug/pci_hotplug.h
===================================================================
--- linux-2.6.16-rc5-mm1.orig/drivers/pci/hotplug/pci_hotplug.h	2006-03-02 10:47:08.000000000 +0900
+++ linux-2.6.16-rc5-mm1/drivers/pci/hotplug/pci_hotplug.h	2006-03-02 11:05:35.000000000 +0900
@@ -188,7 +188,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/actypes.h>
 extern acpi_status acpi_run_oshp(acpi_handle handle);
-extern void acpi_get_hp_params_from_firmware(struct pci_dev *dev,
+extern acpi_status acpi_get_hp_params_from_firmware(struct pci_dev *dev,
 		struct hotplug_params *hpp);
 extern u8 * acpi_path_name( acpi_handle	handle);
 int is_root_bridge(acpi_handle handle);
Index: linux-2.6.16-rc5-mm1/drivers/pci/hotplug/shpchp.h
===================================================================
--- linux-2.6.16-rc5-mm1.orig/drivers/pci/hotplug/shpchp.h	2006-03-02 10:47:08.000000000 +0900
+++ linux-2.6.16-rc5-mm1/drivers/pci/hotplug/shpchp.h	2006-03-02 11:25:20.000000000 +0900
@@ -193,15 +193,21 @@
 
 
 #ifdef CONFIG_ACPI
-#define get_hp_params_from_firmware(dev, hpp) \
-	acpi_get_hp_params_from_firmware(dev, hpp)
+static inline int get_hp_params_from_firmware(struct pci_dev *dev,
+					      struct hotplug_params *hpp)
+{
+	acpi_status status = acpi_get_hp_params_from_firmware(dev, hpp);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+	return 0;
+}
 #define get_hp_hw_control_from_firmware(pdev) \
 	do { \
 		if (DEVICE_ACPI_HANDLE(&(pdev->dev))) \
 			acpi_run_oshp(DEVICE_ACPI_HANDLE(&(pdev->dev))); \
 	} while (0)
 #else
-#define get_hp_params_from_firmware(dev, hpp)
+#define get_hp_params_from_firmware(dev, hpp)		(-ENODEV)
 #define get_hp_hw_control_from_firmware(dev)
 #endif
 
Index: linux-2.6.16-rc5-mm1/drivers/pci/hotplug/shpchp_pci.c
===================================================================
--- linux-2.6.16-rc5-mm1.orig/drivers/pci/hotplug/shpchp_pci.c	2006-03-01 13:53:27.000000000 +0900
+++ linux-2.6.16-rc5-mm1/drivers/pci/hotplug/shpchp_pci.c	2006-03-02 11:32:52.000000000 +0900
@@ -38,7 +38,8 @@
 {
 	u16 pci_cmd, pci_bctl;
 	struct pci_dev *cdev;
-	struct hotplug_params hpp = {0x8, 0x40, 0, 0}; /* defaults */
+	struct hotplug_params hpp;
+	int rc;
 
 	/* Program hpp values for this device */
 	if (!(dev->hdr_type == PCI_HEADER_TYPE_NORMAL ||
@@ -46,7 +47,17 @@
 			(dev->class >> 8) == PCI_CLASS_BRIDGE_PCI)))
 		return;
 
-	get_hp_params_from_firmware(dev, &hpp);
+	rc = get_hp_params_from_firmware(dev, &hpp);
+	if (rc) {
+		/*
+		 * If we could not get hotplug parameters from
+		 * firmware, use hardcoded defaults.
+		 */
+		hpp.cache_line_size = 0x8;
+		hpp.latency_timer = 0x40;
+		hpp.enable_serr = 0;
+		hpp.enable_perr = 0;
+	}
 
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, hpp.cache_line_size);
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, hpp.latency_timer);
Index: linux-2.6.16-rc5-mm1/drivers/pci/hotplug/pciehp.h
===================================================================
--- linux-2.6.16-rc5-mm1.orig/drivers/pci/hotplug/pciehp.h	2006-03-02 10:47:08.000000000 +0900
+++ linux-2.6.16-rc5-mm1/drivers/pci/hotplug/pciehp.h	2006-03-02 11:44:47.000000000 +0900
@@ -281,10 +281,19 @@
 #ifdef CONFIG_ACPI
 #define pciehp_get_hp_hw_control_from_firmware(dev) \
 	pciehp_acpi_get_hp_hw_control_from_firmware(dev)
+static inline int pciehp_get_hp_params_from_firmware(struct pci_dev *dev,
+						struct hotplug_params *hpp)
+{
+	acpi_status status = acpi_get_hp_params_from_firmware(dev, hpp);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+	return 0;
+}
 #define pciehp_get_hp_params_from_firmware(dev, hpp) \
 	acpi_get_hp_params_from_firmware(dev, hpp)
 #else
 #define pciehp_get_hp_hw_control_from_firmware(dev) 	0
 #define acpi_get_hp_params_from_firmware(dev, hpp)
+#define pciehp_get_hp_params_from_firmware(dev, hpp)	(-ENODEV)
 #endif 				/* CONFIG_ACPI */
 #endif				/* _PCIEHP_H */
