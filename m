Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270135AbUJSXb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270135AbUJSXb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270191AbUJSX1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:27:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:15242 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270157AbUJSWqg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:36 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225733903@kroah.com>
Date: Tue, 19 Oct 2004 15:42:14 -0700
Message-Id: <10982257341560@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.15, 2004/10/06 11:50:52-07:00, shaohua.li@intel.com

[PATCH] PCI: Reorder some initialization code to allow resources to be proper allocated.

On Tuesday, August 31, 2004, Linus Torvalds wrote:
> That list per se obviously looks ok by me, although I'd worry that some
> other fs_initcall depends on the ACPI stuff having been run (ie while the
> abover ordering is great, I worry that some _other_ part doesn't fit in
> the above ordering). Doing a quick check finds "chr_dev_init()", for
> example, which will do fbmem_init(), which might depend on the ACPI/PnP
> stuff having run already.
>
> So it _might_ be safer to make this ordering more explicit, rather than

Yes, I agree. The problem is there isn't a straightforward method for
it. It possibly is hard to get it.

> depending on the different phases of the initcalls. But I'd happily be
> proven wrogn with some simple argument for why this is guaranteed to be
> ok.. For example, maybe ACPI and PnP is linked before chr/mem.c, in which
> case it should all be ok.

Original PCI assign resources code is the last 'subsys_initcall'
according to the makefile, so move some code of it to 'fs_initcall'
(just below 'subsystem_initcall') should be ok. As you said, ACPI and
PnP is linked before chr/mem.c. The method requires all other
'fs_initcall' don't touch PCI resources, since
'pcibios_assign_resources' is a 'fs_initcall' and maybe don't run, but
it looks ok currently. Again, I will be appreciated if we can find a
solution to make the ordering explicit.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/i386.c       |   10 ++++++++--
 drivers/acpi/motherboard.c |    6 +++++-
 drivers/pnp/system.c       |    6 +++++-
 3 files changed, 18 insertions(+), 4 deletions(-)


diff -Nru a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
--- a/arch/i386/pci/i386.c	2004-10-19 15:26:35 -07:00
+++ b/arch/i386/pci/i386.c	2004-10-19 15:26:35 -07:00
@@ -164,7 +164,7 @@
 	}
 }
 
-static void __init pcibios_assign_resources(void)
+static int __init pcibios_assign_resources(void)
 {
 	struct pci_dev *dev = NULL;
 	int idx;
@@ -204,6 +204,7 @@
 				pci_assign_resource(dev, PCI_ROM_RESOURCE);
 		}
 	}
+	return 0;
 }
 
 void __init pcibios_resource_survey(void)
@@ -212,8 +213,13 @@
 	pcibios_allocate_bus_resources(&pci_root_buses);
 	pcibios_allocate_resources(0);
 	pcibios_allocate_resources(1);
-	pcibios_assign_resources();
 }
+
+/**
+ * called in fs_initcall (one below subsys_initcall),
+ * give a chance for motherboard reserve resources
+ */
+fs_initcall(pcibios_assign_resources);
 
 int pcibios_enable_resources(struct pci_dev *dev, int mask)
 {
diff -Nru a/drivers/acpi/motherboard.c b/drivers/acpi/motherboard.c
--- a/drivers/acpi/motherboard.c	2004-10-19 15:26:35 -07:00
+++ b/drivers/acpi/motherboard.c	2004-10-19 15:26:35 -07:00
@@ -170,4 +170,8 @@
 	return 0;
 }
 
-subsys_initcall(acpi_motherboard_init);
+/**
+ * Reserve motherboard resources after PCI claim BARs,
+ * but before PCI assign resources for uninitialized PCI devices
+ */
+fs_initcall(acpi_motherboard_init);
diff -Nru a/drivers/pnp/system.c b/drivers/pnp/system.c
--- a/drivers/pnp/system.c	2004-10-19 15:26:35 -07:00
+++ b/drivers/pnp/system.c	2004-10-19 15:26:35 -07:00
@@ -104,4 +104,8 @@
 	return pnp_register_driver(&system_pnp_driver);
 }
 
-subsys_initcall(pnp_system_init);
+/**
+ * Reserve motherboard resources after PCI claim BARs,
+ * but before PCI assign resources for uninitialized PCI devices
+ */
+fs_initcall(pnp_system_init);

