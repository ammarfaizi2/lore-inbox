Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTIPXIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 19:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTIPXIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 19:08:34 -0400
Received: from lidskialf.net ([62.3.233.115]:54145 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262525AbTIPXIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 19:08:32 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: [PATCH] 2.4.23-pre3 Don't change BIOS allocated IRQs
Date: Wed, 17 Sep 2003 00:06:59 +0100
User-Agent: KMail/1.5.3
Cc: linux-acpi@intel.com, Chris Wright <chrisw@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309170006.59980.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of Chris Wright testing several failed patches, I've tracked 
down another ACPI IRQ problem. On many systems, the BIOS 
pre-allocates IRQs for certain PCI devices, providing a list of alternate 
possibilities as well.

On some systems, changing the IRQ to one of those alternate possibilities 
works fine. On others however, it really isn't a good idea. As theres no 
way to tell which systems are good and bad in advance, this patch simply 
ensures that ACPI does not change an IRQ if the BIOS has pre-allocated it.


--- linux-2.4.23-pre3.null_crs/drivers/acpi/pci_link.c	2003-09-05 23:57:39.000000000 +0100
+++ linux-2.4.23-pre3.nochangeirq/drivers/acpi/pci_link.c	2003-09-16 23:59:49.212387016 +0100
@@ -507,15 +507,15 @@
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[0];
-	}
 
-	/* 
-	 * Select the best IRQ.  This is done in reverse to promote 
-	 * the use of IRQs 9, 10, 11, and >15.
-	 */
-	for (i=(link->irq.possible_count-1); i>0; i--) {
-		if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
-			irq = link->irq.possible[i];
+		/* 
+		 * Select the best IRQ.  This is done in reverse to promote 
+		 * the use of IRQs 9, 10, 11, and >15.
+		 */
+		for (i=(link->irq.possible_count-1); i>0; i--) {
+			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
+				irq = link->irq.possible[i];
+		}
 	}
 
 	/* Attempt to enable the link device at this IRQ. */

