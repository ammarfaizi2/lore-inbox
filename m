Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTFSX2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTFSX22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:28:28 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18591 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261944AbTFSXZq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:25:46 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1056065969234@kroah.com>
Subject: [PATCH] PCI changes and fixes for 2.5.72
In-Reply-To: <20030619233727.GA7200@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jun 2003 16:39:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1327.5.1, 2003/06/16 16:43:45-07:00, willy@debian.org

[PATCH] PCI: Tidy up sysfs a bit

This patch contains a set of uncontroversial changes to PCI sysfs.

 - Always output 64-bit resources so userspace doesn't need ifdefs
   and 32-bit userspace works on 64-bit architectures.  Separate them
   with spaces rather than tabs.
 - Prefix hex quantities with "0x"
 - Always show 7 resources for non-bridge devices, and all resources for
   bridges rather than stopping on the first empty resource.


 drivers/pci/pci-sysfs.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	Thu Jun 19 16:32:26 2003
+++ b/drivers/pci/pci-sysfs.c	Thu Jun 19 16:32:26 2003
@@ -18,12 +18,6 @@
 
 #include "pci.h"
 
-#if BITS_PER_LONG == 32
-#define LONG_FORMAT "\t%08lx"
-#else
-#define LONG_FORMAT "\t%16lx"
-#endif
-
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
@@ -36,11 +30,11 @@
 }									\
 static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
 
-pci_config_attr(vendor, "%04x\n");
-pci_config_attr(device, "%04x\n");
-pci_config_attr(subsystem_vendor, "%04x\n");
-pci_config_attr(subsystem_device, "%04x\n");
-pci_config_attr(class, "%06x\n");
+pci_config_attr(vendor, "0x%04x\n");
+pci_config_attr(device, "0x%04x\n");
+pci_config_attr(subsystem_vendor, "0x%04x\n");
+pci_config_attr(subsystem_device, "0x%04x\n");
+pci_config_attr(class, "0x%06x\n");
 pci_config_attr(irq, "%u\n");
 
 /* show resources */
@@ -50,9 +44,13 @@
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	char * str = buf;
 	int i;
+	int max = 7;
+
+	if (pci_dev->subordinate)
+		max = DEVICE_COUNT_RESOURCE;
 
-	for (i = 0; i < DEVICE_COUNT_RESOURCE && pci_resource_start(pci_dev,i); i++) {
-		str += sprintf(str,LONG_FORMAT LONG_FORMAT LONG_FORMAT "\n",
+	for (i = 0; i < max; i++) {
+		str += sprintf(str,"0x%016lx 0x%016lx 0x%016lx\n",
 			       pci_resource_start(pci_dev,i),
 			       pci_resource_end(pci_dev,i),
 			       pci_resource_flags(pci_dev,i));

