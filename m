Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbUCCEXH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUCCEXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:23:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:34690 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262357AbUCCEVy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:21:54 -0500
Subject: Re: [PATCH] PCI Hotplug fixes for 2.6.4-rc1
In-Reply-To: <10782877062961@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:21:46 -0800
Message-Id: <10782877061393@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1624, 2004/03/02 19:10:44-08:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI Hotplug: fixes for shpc and pcie hot-plug drivers

This patch contains the following:
1.  Fix up the pcie and shpc options to make it easier for distros
    to use as what we have discussed;
2.  Fix bug encountered when installing the drivers on non-hotplug
    systems;
3.  Put PCI_CAP_ID_SHPC in include/linux/pci.h


 drivers/pci/hotplug/Kconfig         |   30 ++++++------------------------
 drivers/pci/hotplug/Makefile        |   24 ++++++++++++++----------
 drivers/pci/hotplug/pciehprm_acpi.c |    3 +++
 drivers/pci/hotplug/shpchp.h        |    3 ---
 drivers/pci/hotplug/shpchprm_acpi.c |    3 +++
 include/linux/pci.h                 |    1 +
 6 files changed, 27 insertions(+), 37 deletions(-)


diff -Nru a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	Tue Mar  2 19:42:09 2004
+++ b/drivers/pci/hotplug/Kconfig	Tue Mar  2 19:42:09 2004
@@ -135,23 +135,14 @@
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_PCIE_POLL_EVENT_MODE
-	bool "Use polling mechanism for hot-plug events."
+	bool "Use polling mechanism for hot-plug events (for testing purpose)"
 	depends on HOTPLUG_PCI_PCIE
 	help
 	  Say Y here if you want to use the polling mechanism for hot-plug 
-	  events.
+	  events for early platform testing.
 	   
 	  When in doubt, say N.
 
-config HOTPLUG_PCI_PCIE_PHPRM_NONACPI
-	bool "Non-ACPI: Use $HPRT for resource/configuration"
-	depends on HOTPLUG_PCI_PCIE
-	help
-	  Say Y here if Hotplug resource/configuration information is provided
-	  by platform BIOS $HPRT or bridge resource information, not by ACPI.
-
-	  When in doubt, say N.
-
 config HOTPLUG_PCI_SHPC
 	tristate "SHPC PCI Hotplug driver"
 	depends on HOTPLUG_PCI
@@ -165,29 +156,20 @@
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_SHPC_POLL_EVENT_MODE
-	bool "Use polling mechanism for hot-plug events"
+	bool "Use polling mechanism for hot-plug events (for testing purpose)"
 	depends on HOTPLUG_PCI_SHPC
 	help
 	  Say Y here if you want to use the polling mechanism for hot-plug 
-	  events.
-
-	  When in doubt, say N.
-
-config HOTPLUG_PCI_SHPC_PHPRM_NONACPI
-	bool "Non-ACPI: Use $HPRT for resource/configuration"
-	depends on HOTPLUG_PCI_SHPC
-	help
-	  Say Y here if Hotplug resource/configuration information is provided
-	  by platform BIOS $HPRT or bridge resource information, not by ACPI.
+	  events for early platform testing.
 
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_SHPC_PHPRM_LEGACY
 	bool "For AMD SHPC only: Use $HRT for resource/configuration"
-	depends on HOTPLUG_PCI_SHPC && HOTPLUG_PCI_SHPC_PHPRM_NONACPI
+	depends on HOTPLUG_PCI_SHPC && !ACPI_BUS 
 	help
 	  Say Y here for AMD SHPC. You have to select this option if you are 
-	  using this driver on AMD platform with SHPC.
+	  using this driver on platform with AMD SHPC.
 
 config HOTPLUG_PCI_RPA
 	tristate "RPA PCI Hotplug driver"
diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	Tue Mar  2 19:42:09 2004
+++ b/drivers/pci/hotplug/Makefile	Tue Mar  2 19:42:09 2004
@@ -51,10 +51,12 @@
 				pciehp_sysfs.o	\
 				pciehp_hpc.o
 
-ifeq ($(CONFIG_HOTPLUG_PCI_PCIE_PHPRM_NONACPI),y)
-  pciehp-objs += pciehprm_nonacpi.o
-else
-  pciehp-objs += pciehprm_acpi.o
+ifdef CONFIG_HOTPLUG_PCI_PCIE
+  ifdef CONFIG_ACPI_BUS
+    pciehp-objs += pciehprm_acpi.o
+  else
+    pciehp-objs += pciehprm_nonacpi.o
+  endif
 endif
 
 shpchp-objs		:=	shpchp_core.o	\
@@ -63,12 +65,14 @@
 				shpchp_sysfs.o	\
 				shpchp_hpc.o
 
-ifeq ($(CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY),y)
-  shpchp-objs += shpchprm_legacy.o
-else
-  ifeq ($(CONFIG_HOTPLUG_PCI_SHPC_PHPRM_NONACPI),y)
-    shpchp-objs += shpchprm_nonacpi.o
-  else
+ifdef CONFIG_HOTPLUG_PCI_SHPC
+  ifdef CONFIG_ACPI_BUS
     shpchp-objs += shpchprm_acpi.o
+  else
+    ifdef CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY
+      shpchp-objs += shpchprm_legacy.o
+    else
+      shpchp-objs += shpchprm_nonacpi.o
+    endif
   endif
 endif
diff -Nru a/drivers/pci/hotplug/pciehprm_acpi.c b/drivers/pci/hotplug/pciehprm_acpi.c
--- a/drivers/pci/hotplug/pciehprm_acpi.c	Tue Mar  2 19:42:09 2004
+++ b/drivers/pci/hotplug/pciehprm_acpi.c	Tue Mar  2 19:42:09 2004
@@ -1188,6 +1188,9 @@
 
 static void pciehprm_free_bridges ( struct acpi_bridge	*ab)
 {
+	if (!ab)
+		return;
+
 	if (ab->child)
 		pciehprm_free_bridges (ab->child);
 
diff -Nru a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
--- a/drivers/pci/hotplug/shpchp.h	Tue Mar  2 19:42:09 2004
+++ b/drivers/pci/hotplug/shpchp.h	Tue Mar  2 19:42:09 2004
@@ -154,9 +154,6 @@
 /* Define AMD SHPC ID  */
 #define PCI_DEVICE_ID_AMD_GOLAM_7450	0x7450 
 
-/* Define SHPC CAP ID - not defined in kernel yet */
-#define PCI_CAP_ID_SHPC			0x0C 
-
 #define INT_BUTTON_IGNORE		0
 #define INT_PRESENCE_ON			1
 #define INT_PRESENCE_OFF		2
diff -Nru a/drivers/pci/hotplug/shpchprm_acpi.c b/drivers/pci/hotplug/shpchprm_acpi.c
--- a/drivers/pci/hotplug/shpchprm_acpi.c	Tue Mar  2 19:42:09 2004
+++ b/drivers/pci/hotplug/shpchprm_acpi.c	Tue Mar  2 19:42:09 2004
@@ -1187,6 +1187,9 @@
 
 static void shpchprm_free_bridges ( struct acpi_bridge	*ab)
 {
+	if (!ab)
+		return;
+
 	if (ab->child)
 		shpchprm_free_bridges (ab->child);
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Mar  2 19:42:09 2004
+++ b/include/linux/pci.h	Tue Mar  2 19:42:09 2004
@@ -199,6 +199,7 @@
 #define  PCI_CAP_ID_MSI		0x05	/* Message Signalled Interrupts */
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX	0x07	/* PCI-X */
+#define  PCI_CAP_ID_SHPC 	0x0C	/* PCI Standard Hot-Plug Controller */
 #define  PCI_CAP_ID_EXP 	0x10	/* PCI Express */
 #define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */
 #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */

