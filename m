Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbVJTFsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbVJTFsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 01:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbVJTFsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 01:48:23 -0400
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:15116
	"EHLO avtrex.com") by vger.kernel.org with ESMTP id S1751625AbVJTFsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 01:48:23 -0400
From: David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.12191.789743.351629@dl2.hq2.avtrex.com>
Date: Wed, 19 Oct 2005 22:48:15 -0700
To: linux-mips@linux-mips.org
CC: linux-kernel@vger.kernel.org
Subject: Patch: ATI Xilleon port 1/11 Allow PCI resources to be overridden
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first part of my Xilleon port.

I am sending the full set of patches to linux-mips@linux-mips.org
which is archived at: http://www.linux-mips.org/archives/

Only the patches that touch generic parts of the kernel are coming
here.

The Xilleon's (32bit MIPS SOC) PCU resides on the PCI bus, but is
non-standard in that it has several apertures that should not be
mapped into the standard PCI aperture.

The idea behind the patch is that ports that define
CONFIG_PCIBIOS_OVERRIDE_RESOURCE supply a hook in their pcibios
(pcibios_override_resource()) that gets a chance to handle a mapping
before the default pci setup code tries to do it.

For ports that don't define CONFIG_PCIBIOS_OVERRIDE_RESOURCE
(i.e. everything except Xilleon) there should be no change.

patch against 2.6.14-rc2 from linux-mips.org

Signed-off-by: David Daney <ddaney@avtrex.com>

pcibios_override_resource infrastructure.  Initially for use with
xilleon port.

---
commit d559c11c9fecd8ec2a952982083e3a1fe118ab09
tree ee2da62d9441f3d829f79a9ff9912ba279b290fc
parent 8817d129d5d5fc662858925aa39ddda0cb3b73a0
author David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:32:14 -0700
committer David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:32:14 -0700

 drivers/pci/setup-res.c |   10 ++++++----
 include/linux/pci.h     |    9 +++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -127,10 +127,12 @@ int pci_assign_resource(struct pci_dev *
 	   required alignment in the "start" field. */
 	align = (resno < PCI_BRIDGE_RESOURCES) ? size : res->start;
 
-	/* First, try exact prefetching match.. */
-	ret = pci_bus_alloc_resource(bus, res, size, align, min,
-				     IORESOURCE_PREFETCH,
-				     pcibios_align_resource, dev);
+        ret = pcibios_override_resource(dev, resno);
+        if (ret)
+            /* First, try exact prefetching match.. */
+            ret = pci_bus_alloc_resource(bus, res, size, align, min,
+                                         IORESOURCE_PREFETCH,
+                                         pcibios_align_resource, dev);
 
 	if (ret < 0 && (res->flags & IORESOURCE_PREFETCH)) {
 		/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -293,6 +293,15 @@ extern struct bus_type pci_bus_type;
 extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 extern struct list_head pci_devices;	/* list of all devices */
 
+#ifdef CONFIG_PCIBIOS_OVERRIDE_RESOURCE
+int pcibios_override_resource(struct pci_dev *dev, int resno);
+#else
+static inline int pcibios_override_resource(struct pci_dev *dev, int resno)
+{
+    return 1;
+}
+#endif
+
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);
 char *pcibios_setup (char *str);




