Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTIFABU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 20:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbTIEX7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:59:49 -0400
Received: from lidskialf.net ([62.3.233.115]:5069 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S265111AbTIEX7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:59:12 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] 2.6.0-test4 ACPI fixes series (3/4)
Date: Sat, 6 Sep 2003 01:57:40 +0100
User-Agent: KMail/1.5.3
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, linux-acpi@intel.com
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
In-Reply-To: <3F590E28.6090101@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309060157.40420.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is actually a patch by "Jun Nakajima" <jun.nakajima@intel.com>
When setting an IRQ link device, it checks if the value returned by _CRS is
0. If so, it assumes everything went OK. This fixes problems on MANY VIA
bioses. It seems to be a standard-ish way of saying "the _CRS IRQ setting
cannot be read".


--- linux-2.4.23-pre3.extirq/drivers/acpi/pci_link.c	2003-09-05 23:54:59.945755216 +0100
+++ linux-2.4.23-pre3.null_crs/drivers/acpi/pci_link.c	2003-09-05 23:57:39.782456344 +0100
@@ -277,6 +277,32 @@
 
 
 static int
+acpi_pci_link_try_get_current (
+	struct acpi_pci_link *link,
+	int irq)
+{
+	int result;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_link_try_get_current");
+   
+	result = acpi_pci_link_get_current(link);
+	if (result && link->irq.active) 
+	{
+		return_VALUE(result);
+	}
+
+	if (!link->irq.active) 
+	{
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No active IRQ resource found\n"));
+		printk(KERN_WARNING "_CRS returns NULL! Using IRQ %d for device (%s [%s]).\n", irq, acpi_device_name(link->device), acpi_device_bid(link->device));
+		link->irq.active = irq;
+	}
+   
+	return 0;
+}
+
+
+static int
 acpi_pci_link_set (
 	struct acpi_pci_link	*link,
 	int			irq)
@@ -382,7 +408,7 @@
 	}
 
 	/* Make sure the active IRQ is the one we requested. */
-	result = acpi_pci_link_get_current(link);
+	result = acpi_pci_link_try_get_current(link, irq);
 	if (result) {
 		return_VALUE(result);
 	}
@@ -600,10 +626,6 @@
 		else
 			printk(" %d", link->irq.possible[i]);
 	}
-	if (!link->irq.active)
-		printk(", disabled");
-	else if (!found)
-		printk(", enabled at IRQ %d", link->irq.active);
 	printk(")\n");
 
 	/* TBD: Acquire/release lock */

