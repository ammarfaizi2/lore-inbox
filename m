Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030841AbWKOSk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030841AbWKOSk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030845AbWKOSk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:40:27 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:63984 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030841AbWKOSkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:40:24 -0500
Date: Wed, 15 Nov 2006 10:35:25 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andi Kleen <ak@suse.de>, len.brown@intel.com
Cc: Linus Torvalds <torvalds@osdl.org>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: [PATCH] ACPI: use MSI_NOT_SUPPORTED bit
Message-Id: <20061115103525.19e9d3eb.randy.dunlap@oracle.com>
In-Reply-To: <p73ejs5co0q.fsf@bingen.suse.de>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	<20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	<p73ejs5co0q.fsf@bingen.suse.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2006 05:49:41 +0100 Andi Kleen wrote:

> BTW there seems to be a new ACPI FADT bit that says "MSI is broken"
> We should probably check that too as a double check.

Do you mean more than just use that bit when you say "double check"?

I wonder why this hasn't already been done. (?)

How's this look?  Build-tested only.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Implement use of FADT boot_flags.MSI_NOT_SUPPORTED bit to prevent
assigning MSIs.
Force MSI_NOT_SUPPORTED for ACPI 1.0 tables.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/acpi/bus.c             |    6 ++++++
 drivers/acpi/tables/tbconvrt.c |    3 ++-
 include/acpi/actbl.h           |    4 +++-
 include/linux/pci.h            |    2 ++
 4 files changed, 13 insertions(+), 2 deletions(-)

--- linux-2619-rc5.orig/include/acpi/actbl.h
+++ linux-2619-rc5/include/acpi/actbl.h
@@ -290,7 +290,7 @@ struct fadt_descriptor_rev1 {
 	ACPI_FADT_COMMON u32 flags;
 };
 
-/* FADT: Prefered Power Management Profiles */
+/* FADT: Preferred Power Management Profiles */
 
 #define PM_UNSPECIFIED                  0
 #define PM_DESKTOP                      1
@@ -304,6 +304,8 @@ struct fadt_descriptor_rev1 {
 
 #define BAF_LEGACY_DEVICES              0x0001
 #define BAF_8042_KEYBOARD_CONTROLLER    0x0002
+#define BAF_VGA_NOT_PRESENT		0x0004
+#define BAF_MSI_NOT_SUPPORTED		0x0008
 
 #define FADT2_REVISION_ID               3
 #define FADT2_MINUS_REVISION_ID         2
--- linux-2619-rc5.orig/drivers/acpi/tables/tbconvrt.c
+++ linux-2619-rc5/drivers/acpi/tables/tbconvrt.c
@@ -289,7 +289,8 @@ acpi_tb_convert_fadt1(struct fadt_descri
 		 * Since there isn't any equivalence in 1.0 and since it is highly
 		 * likely that a 1.0 system has legacy support.
 		 */
-		local_fadt->iapc_boot_arch = BAF_LEGACY_DEVICES;
+		local_fadt->iapc_boot_arch = BAF_LEGACY_DEVICES |
+						BAF_MSI_NOT_SUPPORTED;
 	}
 
 	/*
--- linux-2619-rc5.orig/include/linux/pci.h
+++ linux-2619-rc5/include/linux/pci.h
@@ -610,6 +610,7 @@ static inline int pci_enable_msix(struct
 	struct msix_entry *entries, int nvec) {return -1;}
 static inline void pci_disable_msix(struct pci_dev *dev) {}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
+static inline void pci_no_msi(void) {}
 #else
 extern void pci_scan_msi_device(struct pci_dev *dev);
 extern int pci_enable_msi(struct pci_dev *dev);
@@ -618,6 +619,7 @@ extern int pci_enable_msix(struct pci_de
 	struct msix_entry *entries, int nvec);
 extern void pci_disable_msix(struct pci_dev *dev);
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
+extern void pci_no_msi(void);
 #endif
 
 #ifdef CONFIG_HT_IRQ
--- linux-2619-rc5.orig/drivers/acpi/bus.c
+++ linux-2619-rc5/drivers/acpi/bus.c
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/sched.h>
+#include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/pm_legacy.h>
 #include <linux/device.h>
@@ -637,6 +638,11 @@ void __init acpi_early_init(void)
 	}
 #endif
 
+	if (acpi_fadt.iapc_boot_arch & BAF_MSI_NOT_SUPPORTED) {
+		printk(KERN_DEBUG PREFIX "MSI not supported, disabling it\n");
+		pci_no_msi();
+	}
+
 	status =
 	    acpi_enable_subsystem(~
 				  (ACPI_NO_HARDWARE_INIT |
