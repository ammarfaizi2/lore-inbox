Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265736AbUGILBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUGILBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUGILBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:01:33 -0400
Received: from ozlabs.org ([203.10.76.45]:22232 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265690AbUGILBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:01:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16621.15756.614613.94668@cargo.ozlabs.ibm.com>
Date: Thu, 8 Jul 2004 22:26:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] (2/3) PPC64 Enable EEH on PCI host bridges
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linas Vepstas <linas@austin.ibm.com>

On recent pSeries systems, EEH needs to be enabled even on PCI Host
Bridges (PHB's).  If not enabled, then ordinary PCI probing
(config-space reads/writes to the bridges) will generate firmware
error messages, possibly a very large number of messages for systems
with large numbers of pci slots.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.6/arch/ppc64/kernel/eeh.c test25/arch/ppc64/kernel/eeh.c
--- linux-2.6/arch/ppc64/kernel/eeh.c	2004-07-08 16:56:46.244591376 +1000
+++ test25/arch/ppc64/kernel/eeh.c	2004-07-08 17:03:20.189702616 +1000
@@ -485,16 +485,10 @@
 	if (status && strcmp(status, "ok") != 0)
 		return NULL;	/* ignore devices with bad status */
 
-	/* Weed out PHBs or other bad nodes. */
+	/* Ignore bad nodes. */
 	if (!class_code || !vendor_id || !device_id)
 		return NULL;
 
-	/* Ignore known PHBs and EADs bridges */
-	if (*vendor_id == PCI_VENDOR_ID_IBM &&
-	    (*device_id == 0x0102 || *device_id == 0x008b ||
-	     *device_id == 0x0188 || *device_id == 0x0302))
-		return NULL;
-
 	/* There is nothing to check on PCI to ISA bridges */
 	if (dn->type && !strcmp(dn->type, "isa")) {
 		dn->eeh_mode |= EEH_MODE_NOCHECK;
@@ -526,15 +520,8 @@
 		dn->eeh_mode |= EEH_MODE_NOCHECK;
 	}
 
-	/* This device may already have an EEH parent. */
-	if (dn->parent && (dn->parent->eeh_mode & EEH_MODE_SUPPORTED)) {
-		/* Parent supports EEH. */
-		dn->eeh_mode |= EEH_MODE_SUPPORTED;
-		dn->eeh_config_addr = dn->parent->eeh_config_addr;
-		return NULL;
-	}
-
-	/* Ok... see if this device supports EEH. */
+	/* Ok... see if this device supports EEH.  Some do, some don't,
+	 * and the only way to find out is to check each and every one. */
 	regs = (u32 *)get_property(dn, "reg", 0);
 	if (regs) {
 		/* First register entry is addr (00BBSS00)  */
@@ -547,12 +534,18 @@
 			dn->eeh_mode |= EEH_MODE_SUPPORTED;
 			dn->eeh_config_addr = regs[0];
 #ifdef DEBUG
-			printk(KERN_DEBUG "EEH: %s: eeh enabled\n",
-			       dn->full_name);
+			printk(KERN_DEBUG "EEH: %s: eeh enabled\n", dn->full_name);
 #endif
 		} else {
-			printk(KERN_WARNING "EEH: %s: could not enable EEH, rtas_call failed; rc=%d\n",
-			       dn->full_name, ret);
+
+			/* This device doesn't support EEH, but it may have an
+			 * EEH parent, in which case we mark it as supported. */
+			if (dn->parent && (dn->parent->eeh_mode & EEH_MODE_SUPPORTED)) {
+				/* Parent supports EEH. */
+				dn->eeh_mode |= EEH_MODE_SUPPORTED;
+				dn->eeh_config_addr = dn->parent->eeh_config_addr;
+				return NULL;
+			}
 		}
 	} else {
 		printk(KERN_WARNING "EEH: %s: unable to get reg property.\n",
