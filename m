Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUCKB6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 20:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUCKB6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 20:58:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:39380 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262956AbUCKB5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 20:57:46 -0500
Subject: [PATCH] Fix lockup accessing config space on G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078970036.9750.214.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 12:53:57 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes the code that workaround lockups when accessing
the config space of devices on K2 when they are shut down. The
code was there but in the wrong place ;) And a typo prevented the
ohci1394 version of it from working.

===== arch/ppc64/kernel/pmac_feature.c 1.1 vs edited =====
--- 1.1/arch/ppc64/kernel/pmac_feature.c	Thu Feb 12 14:47:55 2004
+++ edited/arch/ppc64/kernel/pmac_feature.c	Thu Mar 11 11:49:03 2004
@@ -221,7 +221,7 @@
 		mb();
 		k2_skiplist[1] = NULL;
 	} else {
-		k2_skiplist[0] = pdev;
+		k2_skiplist[1] = pdev;
 		mb();
 		MACIO_BIC(KEYLARGO_FCR1, K2_FCR1_FW_CLK_ENABLE);
 	}
===== arch/ppc64/kernel/pmac_pci.c 1.3 vs edited =====
--- 1.3/arch/ppc64/kernel/pmac_pci.c	Mon Mar  1 11:50:37 2004
+++ edited/arch/ppc64/kernel/pmac_pci.c	Thu Mar 11 11:47:52 2004
@@ -152,7 +152,6 @@
 	struct pci_controller *hose;
 	struct device_node *busdn;
 	unsigned long addr;
-	int i;
 
 	if (bus->self)
 		busdn = pci_device_to_OF_node(bus->self);
@@ -164,24 +163,6 @@
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	/*
-	 * When a device in K2 is powered down, we die on config
-	 * cycle accesses. Fix that here.
-	 */
-	for (i=0; i<2; i++)
-		if (k2_skiplist[i] && k2_skiplist[i]->bus == bus &&
-		    k2_skiplist[i]->devfn == devfn) {
-			switch (len) {
-			case 1:
-				*val = 0xff; break;
-			case 2:
-				*val = 0xffff; break;
-			default:
-				*val = 0xfffffffful; break;
-			}
-			return PCIBIOS_SUCCESSFUL;
-		}
-	    
 	addr = macrisc_cfg_access(hose, bus->number, devfn, offset);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -209,7 +190,6 @@
 	struct pci_controller *hose;
 	struct device_node *busdn;
 	unsigned long addr;
-	int i;
 
 	if (bus->self)
 		busdn = pci_device_to_OF_node(bus->self);
@@ -221,15 +201,6 @@
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	/*
-	 * When a device in K2 is powered down, we die on config
-	 * cycle accesses. Fix that here.
-	 */
-	for (i=0; i<2; i++)
-		if (k2_skiplist[i] && k2_skiplist[i]->bus == bus &&
-		    k2_skiplist[i]->devfn == devfn)
-			return PCIBIOS_SUCCESSFUL;
-
 	addr = macrisc_cfg_access(hose, bus->number, devfn, offset);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -265,6 +236,17 @@
  * implement self-view of the HT host yet
  */
 
+static int skip_k2_device(struct pci_bus *bus, unsigned int devfn)
+{
+	int i;
+
+	for (i=0; i<2; i++)
+		if (k2_skiplist[i] && k2_skiplist[i]->bus == bus &&
+		    k2_skiplist[i]->devfn == devfn)
+			return 1;
+	return 0;
+}
+
 #define U3_HT_CFA0(devfn, off)		\
 		((((unsigned long)devfn) << 8) | offset)
 #define U3_HT_CFA1(bus, devfn, off)	\
@@ -306,6 +288,24 @@
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	/*
+	 * When a device in K2 is powered down, we die on config
+	 * cycle accesses. Fix that here. We may ultimately want
+	 * to cache the config space for those instead of returning
+	 * 0xffffffff's to make life easier to HW detection tools
+	 */
+	if (skip_k2_device(bus, devfn)) {
+		switch (len) {
+		case 1:
+			*val = 0xff; break;
+		case 2:
+			*val = 0xffff; break;
+		default:
+			*val = 0xfffffffful; break;
+		}
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	/*
 	 * Note: the caller has already checked that offset is
 	 * suitably aligned and that len is 1, 2 or 4.
 	 */
@@ -344,6 +344,13 @@
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	/*
+	 * When a device in K2 is powered down, we die on config
+	 * cycle accesses. Fix that here.
+	 */
+	if (skip_k2_device(bus, devfn))
+		return PCIBIOS_SUCCESSFUL;
+
+	/*
 	 * Note: the caller has already checked that offset is
 	 * suitably aligned and that len is 1, 2 or 4.
 	 */


