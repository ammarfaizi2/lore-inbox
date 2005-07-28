Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVG1Hzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVG1Hzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVG1Hzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:55:49 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:14003 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261353AbVG1Hxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:53:52 -0400
Message-ID: <42E88EC7.9080200@jp.fujitsu.com>
Date: Thu, 28 Jul 2005 16:52:39 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2.6.13-rc3 2/6] failure of acpi_register_gsi() should be handled
 properly - change acpi pci code
References: <42E88DC8.7050507@jp.fujitsu.com>
In-Reply-To: <42E88DC8.7050507@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the error check of acpi_register_gsi() into
acpi_pci_enable_irq().

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.13-rc3-kanesige/drivers/acpi/pci_irq.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/pci_irq.c~handle-error-acpi_register_gsi-acpi_pci_enable_irq drivers/acpi/pci_irq.c
--- linux-2.6.13-rc3/drivers/acpi/pci_irq.c~handle-error-acpi_register_gsi-acpi_pci_enable_irq	2005-07-28 01:01:15.000000000 +0900
+++ linux-2.6.13-rc3-kanesige/drivers/acpi/pci_irq.c	2005-07-28 01:01:15.000000000 +0900
@@ -392,6 +392,7 @@ acpi_pci_irq_enable (
 	int			edge_level = ACPI_LEVEL_SENSITIVE;
 	int			active_high_low = ACPI_ACTIVE_LOW;
 	char			*link = NULL;
+	int			rc;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
 
@@ -444,7 +445,13 @@ acpi_pci_irq_enable (
 		}
  	}
 
-	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
+	rc = acpi_register_gsi(irq, edge_level, active_high_low);
+	if (rc < 0) {
+		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: failed "
+		       "to register GSI\n", pci_name(dev), ('A' + pin));
+		return_VALUE(rc);
+	}
+	dev->irq = rc;
 
 	printk(KERN_INFO PREFIX "PCI Interrupt %s[%c] -> ",
 		pci_name(dev), 'A' + pin);

_


