Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbUCSXho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbUCSXgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:36:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:40911 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263145AbUCSXcd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:32:33 -0500
Subject: [PATCH] PCI and PCI Hotplug fixes for 2.6.5-rc1
In-Reply-To: <20040319232516.GA16178@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 19 Mar 2004 15:32:11 -0800
Message-Id: <1079739131391@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.97.1, 2004/03/10 14:22:31-08:00, schwab@suse.de

[PATCH] PCI Hotplug: Fix PCIE and SHPC hotplug drivers for ia64

This patch fixes the PCIE and SHPC hotplug driver for ia64.  The function
pcibios_set_irq_routing only exists on x86, and acpi_bridges_head may be
NULL, so don't crash.

Andreas.


 drivers/pci/hotplug/pciehp_pci.c    |    2 +-
 drivers/pci/hotplug/pciehprm_acpi.c |    3 ++-
 drivers/pci/hotplug/shpchp_pci.c    |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
--- a/drivers/pci/hotplug/pciehp_pci.c	Fri Mar 19 15:21:36 2004
+++ b/drivers/pci/hotplug/pciehp_pci.c	Fri Mar 19 15:21:36 2004
@@ -103,7 +103,7 @@
  */
 int pciehp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 {
-#if !defined(CONFIG_X86_IO_APIC) && !defined(CONFIG_X86_64)
+#if defined(CONFIG_X86) && !defined(CONFIG_X86_IO_APIC) && !defined(CONFIG_X86_64)
 	int rc;
 	u16 temp_word;
 	struct pci_dev fakedev;
diff -Nru a/drivers/pci/hotplug/pciehprm_acpi.c b/drivers/pci/hotplug/pciehprm_acpi.c
--- a/drivers/pci/hotplug/pciehprm_acpi.c	Fri Mar 19 15:21:36 2004
+++ b/drivers/pci/hotplug/pciehprm_acpi.c	Fri Mar 19 15:21:36 2004
@@ -1268,7 +1268,8 @@
 int pciehprm_print_pirt(void)
 {
 	dbg("PCIEHPRM ACPI Slots\n");
-	print_acpi_resources (acpi_bridges_head);
+	if (acpi_bridges_head)
+		print_acpi_resources (acpi_bridges_head);
 
 	return 0;
 }
diff -Nru a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
--- a/drivers/pci/hotplug/shpchp_pci.c	Fri Mar 19 15:21:36 2004
+++ b/drivers/pci/hotplug/shpchp_pci.c	Fri Mar 19 15:21:36 2004
@@ -101,7 +101,7 @@
  */
 int shpchp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 {
-#if !defined(CONFIG_X86_IO_APIC) && !defined(CONFIG_X86_64)
+#if defined(CONFIG_X86) && !defined(CONFIG_X86_IO_APIC) && !defined(CONFIG_X86_64)
 	int rc;
 	u16 temp_word;
 	struct pci_dev fakedev;

