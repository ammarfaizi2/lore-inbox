Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTI0BVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 21:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTI0BVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 21:21:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:18667 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261970AbTI0BVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 21:21:31 -0400
Date: Fri, 26 Sep 2003 18:21:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       adq_dvb@lidskialf.net
Subject: [PATCH] ACPI pci irq routing fix
Message-ID: <20030926182128.C24360@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If irq.active is set from _CRS, make sure to use it, rather than trying
anything from the from the _PRS list, as some machines don't handle this
properly.  This patch is against current linux-acpi-test-2.6.0.  It's
been floating about for a while, and fixes bug #1186.

Patch originally from Andrew de Quincey.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/acpi/pci_link.c 1.19 vs edited =====
--- 1.19/drivers/acpi/pci_link.c	Thu Sep 18 11:29:36 2003
+++ edited/drivers/acpi/pci_link.c	Fri Sep 26 14:36:15 2003
@@ -500,15 +500,15 @@
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
