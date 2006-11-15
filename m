Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161369AbWKOT7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161369AbWKOT7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbWKOT7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:59:41 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:61175 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161369AbWKOT7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:59:40 -0500
Date: Wed, 15 Nov 2006 11:58:36 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, len.brown@intel.com,
       Linus Torvalds <torvalds@osdl.org>, jeff@garzik.org, tiwai@suse.de
Subject: Re: [PATCH v3] ACPI: use MSI_NOT_SUPPORTED bit
Message-Id: <20061115115836.b3190b94.randy.dunlap@oracle.com>
In-Reply-To: <20061115114155.3a94d48c.randy.dunlap@oracle.com>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<p73ejs5co0q.fsf@bingen.suse.de>
	<20061115103525.19e9d3eb.randy.dunlap@oracle.com>
	<200611151944.12415.ak@suse.de>
	<20061115114155.3a94d48c.randy.dunlap@oracle.com>
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

On Wed, 15 Nov 2006 11:41:55 -0800 Randy Dunlap wrote:

> On Wed, 15 Nov 2006 19:44:12 +0100 Andi Kleen wrote:
> 
> > On Wednesday 15 November 2006 19:35, Randy Dunlap wrote:
> > > On 15 Nov 2006 05:49:41 +0100 Andi Kleen wrote:
> > > 
> > > > BTW there seems to be a new ACPI FADT bit that says "MSI is broken"
> > > > We should probably check that too as a double check.
> > > 
> > > Do you mean more than just use that bit when you say "double check"?
> > > 
> > > I wonder why this hasn't already been done. (?)
> > 
> > Nobody coded it yet.
> > 
> > > How's this look?  Build-tested only.
> > 
> > There should be probably a command line option to overwrite it
> 
> OK, anything else?
(oops, v2 didn't quite build)

---
From: Randy Dunlap <randy.dunlap@oracle.com>

- Implement use of FADT boot_flags.MSI_NOT_SUPPORTED bit to prevent
  assigning MSIs.
- Force MSI_NOT_SUPPORTED for ACPI 1.0 tables.
- Add "pci=allowmsi" to override (ignore) the MSI_NOT_SUPPORTED bit
  from the APCI FADT.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/kernel-parameters.txt |    6 ++++++
 drivers/acpi/bus.c                  |    7 +++++++
 drivers/acpi/tables/tbconvrt.c      |    3 ++-
 drivers/pci/pci.c                   |    6 +++++-
 include/acpi/actbl.h                |    4 +++-
 include/linux/pci.h                 |    3 +++
 6 files changed, 26 insertions(+), 3 deletions(-)

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
@@ -618,6 +619,8 @@ extern int pci_enable_msix(struct pci_de
 	struct msix_entry *entries, int nvec);
 extern void pci_disable_msix(struct pci_dev *dev);
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
+extern void pci_no_msi(void);
+extern int pci_allow_msi;
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
@@ -637,6 +638,12 @@ void __init acpi_early_init(void)
 	}
 #endif
 
+	if (!pci_allow_msi &&
+	   (acpi_fadt.iapc_boot_arch & BAF_MSI_NOT_SUPPORTED)) {
+		printk(KERN_DEBUG PREFIX "MSI not supported, disabling it\n");
+		pci_no_msi();
+	}
+
 	status =
 	    acpi_enable_subsystem(~
 				  (ACPI_NO_HARDWARE_INIT |
--- linux-2619-rc5.orig/Documentation/kernel-parameters.txt
+++ linux-2619-rc5/Documentation/kernel-parameters.txt
@@ -1178,6 +1178,12 @@ and is between 256 and 4096 characters. 
 		nomsi		[MSI] If the PCI_MSI kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of MSI interrupts system-wide.
+		allowmsi	[MSI,ACPI] If ACPI FADT says that MSI is not
+				supported on this platform but the user wants
+				to use it anyway, this option tells the kernel
+				to ignore the ACPI FADT MSI flag and allow MSI
+				to be used if there are devices that want to
+				use it.
 		nosort		[IA-32] Don't sort PCI devices according to
 				order given by the PCI BIOS. This sorting is
 				done to get a device order compatible with
--- linux-2619-rc5.orig/drivers/pci/pci.c
+++ linux-2619-rc5/drivers/pci/pci.c
@@ -20,6 +20,8 @@
 #include "pci.h"
 
 unsigned int pci_pm_d3_delay = 10;
+int pci_allow_msi; /* when set, this overrides the ACPI FADT boot_arch
+		    * MSI_NOT_SUPPORTED bit so that MSI can still be used */
 
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
@@ -998,7 +1000,9 @@ static int __devinit pci_setup(char *str
 		if (*str && (str = pcibios_setup(str)) && *str) {
 			if (!strcmp(str, "nomsi")) {
 				pci_no_msi();
-			} else {
+			} else if (!strcmp(str, "allowmsi"))
+				pci_allow_msi = 1;
+			else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
 			}

