Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWANQNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWANQNy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWANQNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:13:54 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:65216 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751768AbWANQNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:13:53 -0500
Date: Sat, 14 Jan 2006 17:14:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: [patch 2.6.15-mm4] sem2mutex: acpi, acpi_link_lock
Message-ID: <20060114161400.GA3452@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 drivers/acpi/pci_link.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

Index: linux/drivers/acpi/pci_link.c
===================================================================
--- linux.orig/drivers/acpi/pci_link.c
+++ linux/drivers/acpi/pci_link.c
@@ -38,6 +38,7 @@
 #include <linux/spinlock.h>
 #include <linux/pm.h>
 #include <linux/pci.h>
+#include <linux/mutex.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -91,7 +92,7 @@ static struct {
 	int count;
 	struct list_head entries;
 } acpi_link;
-DECLARE_MUTEX(acpi_link_lock);
+DEFINE_MUTEX(acpi_link_lock);
 
 /* --------------------------------------------------------------------------
                             PCI Link Device Management
@@ -639,19 +640,19 @@ acpi_pci_link_allocate_irq(acpi_handle h
 		return_VALUE(-1);
 	}
 
-	down(&acpi_link_lock);
+	mutex_lock(&acpi_link_lock);
 	if (acpi_pci_link_allocate(link)) {
-		up(&acpi_link_lock);
+		mutex_unlock(&acpi_link_lock);
 		return_VALUE(-1);
 	}
 
 	if (!link->irq.active) {
-		up(&acpi_link_lock);
+		mutex_unlock(&acpi_link_lock);
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link active IRQ is 0!\n"));
 		return_VALUE(-1);
 	}
 	link->refcnt++;
-	up(&acpi_link_lock);
+	mutex_unlock(&acpi_link_lock);
 
 	if (triggering)
 		*triggering = link->irq.triggering;
@@ -689,9 +690,9 @@ int acpi_pci_link_free_irq(acpi_handle h
 		return_VALUE(-1);
 	}
 
-	down(&acpi_link_lock);
+	mutex_lock(&acpi_link_lock);
 	if (!link->irq.initialized) {
-		up(&acpi_link_lock);
+		mutex_unlock(&acpi_link_lock);
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link isn't initialized\n"));
 		return_VALUE(-1);
 	}
@@ -714,7 +715,7 @@ int acpi_pci_link_free_irq(acpi_handle h
 	if (link->refcnt == 0) {
 		acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
 	}
-	up(&acpi_link_lock);
+	mutex_unlock(&acpi_link_lock);
 	return_VALUE(link->irq.active);
 }
 
@@ -745,7 +746,7 @@ static int acpi_pci_link_add(struct acpi
 	strcpy(acpi_device_class(device), ACPI_PCI_LINK_CLASS);
 	acpi_driver_data(device) = link;
 
-	down(&acpi_link_lock);
+	mutex_lock(&acpi_link_lock);
 	result = acpi_pci_link_get_possible(link);
 	if (result)
 		goto end;
@@ -780,7 +781,7 @@ static int acpi_pci_link_add(struct acpi
       end:
 	/* disable all links -- to be activated on use */
 	acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
-	up(&acpi_link_lock);
+	mutex_unlock(&acpi_link_lock);
 
 	if (result)
 		kfree(link);
@@ -835,9 +836,9 @@ static int acpi_pci_link_remove(struct a
 
 	link = (struct acpi_pci_link *)acpi_driver_data(device);
 
-	down(&acpi_link_lock);
+	mutex_lock(&acpi_link_lock);
 	list_del(&link->node);
-	up(&acpi_link_lock);
+	mutex_unlock(&acpi_link_lock);
 
 	kfree(link);
 
