Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUAOO5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 09:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUAOO5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 09:57:04 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:63617 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S263571AbUAOO5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 09:57:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16390.43574.867869.286685@gargle.gargle.HOWL>
Date: Thu, 15 Jan 2004 09:56:54 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com, Jesse Barnes <jbarnes@sgi.com>
Subject: [patch] 2.6.1-mm3 acpi frees free irq0
X-Mailer: VM 7.03 under Emacs 21.2.1
From: Jes Sorensen <jes@trained-monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a bug in the ACPI code found in 2.6.1-mm3 where if it can't
find the interrupt source for the ACPI System Control Interrupt Handler,
it end up trying to free irq 0.

Included patch fixes the problem.

Cheers,
Jes

--- linux-2.6.1-mm3/drivers/acpi/osl.c~	Wed Jan 14 05:00:25 2004
+++ linux-2.6.1-mm3/drivers/acpi/osl.c	Thu Jan 15 06:43:28 2004
@@ -257,13 +257,13 @@
 		return AE_OK;
 	}
 #endif
-	acpi_irq_irq = irq;
 	acpi_irq_handler = handler;
 	acpi_irq_context = context;
 	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
 		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
 		return AE_NOT_ACQUIRED;
 	}
+	acpi_irq_irq = irq;
 
 	return AE_OK;
 }
@@ -271,12 +271,13 @@
 acpi_status
 acpi_os_remove_interrupt_handler(u32 irq, OSD_HANDLER handler)
 {
-	if (acpi_irq_handler) {
+	if (irq) {
 #if defined(CONFIG_IA64) || defined(CONFIG_PCI_USE_VECTOR)
 		irq = acpi_irq_to_vector(irq);
 #endif
 		free_irq(irq, acpi_irq);
 		acpi_irq_handler = NULL;
+		acpi_irq_irq = 0;
 	}
 
 	return AE_OK;
