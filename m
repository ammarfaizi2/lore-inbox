Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWBVTRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWBVTRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWBVTRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:17:25 -0500
Received: from fmr18.intel.com ([134.134.136.17]:41107 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750851AbWBVTRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:17:24 -0500
Subject: [patch 3/3] acpi: remove dock event handling from ibm_acpi
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Cc: greg@kroah.com, len.brown@intel.com, muneda.takahiro@jp.fujitsu.com,
       pavel@ucw.cz, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
References: <20060222190839.268403000@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Feb 2006 11:21:31 -0800
Message-Id: <1140636091.32574.21.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 22 Feb 2006 19:16:16.0195 (UTC) FILETIME=[73D38130:01C637E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dock station support from ibm_acpi by default.  This support has been 
put into acpiphp instead.  Allow ibm_acpi to continue to provide docking
station support via config option for laptops/docking stations that are 
not supported by acpiphp.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com> 

---
 drivers/acpi/Kconfig    |   12 ++++++++++++
 drivers/acpi/ibm_acpi.c |   13 ++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

--- linux-dock-mm.orig/drivers/acpi/Kconfig
+++ linux-dock-mm/drivers/acpi/Kconfig
@@ -205,6 +205,18 @@ config ACPI_IBM
 
 	  If you have an IBM ThinkPad laptop, say Y or M here.
 
+config ACPI_IBM_DOCK
+	bool "Legacy Docking Station Support"
+	depends on ACPI_IBM
+	default n
+	---help---
+	  Allows the ibm_acpi driver to handle docking station events.
+	  This support is limited and should only be enabled if the generic
+          docking station support driver does not support your laptop/dock
+	  station.
+
+	  If you are not sure, say N here.
+
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
--- linux-dock-mm.orig/drivers/acpi/ibm_acpi.c
+++ linux-dock-mm/drivers/acpi/ibm_acpi.c
@@ -160,13 +160,13 @@ IBM_HANDLE(cmos, root, "\\UCMS",	/* R50,
 	   "\\CMOS",		/* A3x, G4x, R32, T23, T30, X22-24, X30 */
 	   "\\CMS",		/* R40, R40e */
     );				/* all others */
-
+#ifdef CONFIG_ACPI_IBM_DOCK
 IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 	   "\\_SB.PCI0.DOCK",	/* 600e/x,770e,770x,A2xm/p,T20-22,X20-21 */
 	   "\\_SB.PCI0.PCI1.DOCK",	/* all others */
 	   "\\_SB.PCI.ISA.SLCE",	/* 570 */
     );				/* A21e,G4x,R30,R31,R32,R40,R40e,R50e */
-
+#endif
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
 	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
@@ -844,7 +844,7 @@ static int _sta(acpi_handle handle)
 
 	return status;
 }
-
+#ifdef CONFIG_ACPI_IBM_DOCK
 #define dock_docked() (_sta(dock_handle) & 1)
 
 static int dock_read(char *p)
@@ -907,6 +907,7 @@ static void dock_notify(struct ibm_struc
 		acpi_bus_generate_event(ibm->device, event, 0);	/* unknown */
 	}
 }
+#endif
 
 static int bay_status_supported;
 static int bay_status2_supported;
@@ -1574,6 +1575,7 @@ static struct ibm_struct ibms[] = {
 	 .read = light_read,
 	 .write = light_write,
 	 },
+#ifdef CONFIG_ACPI_IBM_DOCK
 	{
 	 .name = "dock",
 	 .read = dock_read,
@@ -1589,6 +1591,7 @@ static struct ibm_struct ibms[] = {
 	 .handle = &pci_handle,
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
+#endif
 	{
 	 .name = "bay",
 	 .init = bay_init,
@@ -1880,7 +1883,9 @@ IBM_PARAM(hotkey);
 IBM_PARAM(bluetooth);
 IBM_PARAM(video);
 IBM_PARAM(light);
+#ifdef CONFIG_ACPI_IBM_DOCK
 IBM_PARAM(dock);
+#endif
 IBM_PARAM(bay);
 IBM_PARAM(cmos);
 IBM_PARAM(led);
@@ -1927,7 +1932,9 @@ static int __init acpi_ibm_init(void)
 	IBM_HANDLE_INIT(hkey);
 	IBM_HANDLE_INIT(lght);
 	IBM_HANDLE_INIT(cmos);
+#ifdef CONFIG_ACPI_IBM_DOCK
 	IBM_HANDLE_INIT(dock);
+#endif
 	IBM_HANDLE_INIT(pci);
 	IBM_HANDLE_INIT(bay);
 	if (bay_handle)

--
