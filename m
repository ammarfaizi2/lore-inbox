Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTIEXRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 19:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTIEXRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:17:40 -0400
Received: from lidskialf.net ([62.3.233.115]:59084 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262543AbTIEXRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:17:09 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] 2.4.23-pre3 ACPI fixes series (2/3)
Date: Sat, 6 Sep 2003 01:15:36 +0100
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
Message-Id: <200309060115.36772.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch retries IRQ programming with an extended IRQ resource descriptor
if using a standard IRQ descriptor fails.


--- linux-2.4.23-pre3.picmode/drivers/acpi/pci_link.c	2003-09-05 23:54:45.522947816 +0100
+++ linux-2.4.23-pre3.extirq/drivers/acpi/pci_link.c	2003-09-05 23:54:59.945755216 +0100
@@ -290,7 +290,8 @@
 	struct acpi_buffer	buffer = {sizeof(resource)+1, &resource};
 	int			i = 0;
 	int			valid = 0;
-
+	int			resource_type = 0;
+   
 	ACPI_FUNCTION_TRACE("acpi_pci_link_set");
 
 	if (!link || !irq)
@@ -312,13 +313,24 @@
 			return_VALUE(-EINVAL);
 		}
 	}
+ 
+	/* If IRQ<=15, first try with a "normal" IRQ descriptor. If that fails, try with
+	 * an extended one */
+	if (irq <= 15) {
+		resource_type = ACPI_RSTYPE_IRQ;
+	} else {
+		resource_type = ACPI_RSTYPE_EXT_IRQ;
+	}
+
+retry_programming:
    
 	memset(&resource, 0, sizeof(resource));
 
 	/* NOTE: PCI interrupts are always level / active_low / shared. But not all
 	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition for 
 	   parameters */
-	if (irq <= 15) {	
+	switch(resource_type) {
+	case ACPI_RSTYPE_IRQ:
 		resource.res.id = ACPI_RSTYPE_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.irq.edge_level = link->irq.edge_level;
@@ -326,8 +338,9 @@
 		resource.res.data.irq.shared_exclusive = ACPI_SHARED;
 		resource.res.data.irq.number_of_interrupts = 1;
 		resource.res.data.irq.interrupts[0] = irq;
-	}
-	else {
+		break;
+	 
+	case ACPI_RSTYPE_EXT_IRQ:
 		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
@@ -337,11 +350,21 @@
 		resource.res.data.extended_irq.number_of_interrupts = 1;
 		resource.res.data.extended_irq.interrupts[0] = irq;
 		/* ignore resource_source, it's optional */
+		break;
 	}
 	resource.end.id = ACPI_RSTYPE_END_TAG;
 
 	/* Attempt to set the resource */
 	status = acpi_set_current_resources(link->handle, &buffer);
+   
+	/* if we failed and IRQ <= 15, try again with an extended descriptor */
+	if (ACPI_FAILURE(status) && (resource_type == ACPI_RSTYPE_IRQ)) {
+                resource_type = ACPI_RSTYPE_EXT_IRQ;
+                printk(PREFIX "Retrying with extended IRQ descriptor\n");
+                goto retry_programming;
+	}
+
+	/* check for total failure */
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));
 		return_VALUE(-ENODEV);

