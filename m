Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVJFXZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVJFXZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVJFXZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:25:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:60869 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751224AbVJFXZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:25:06 -0400
Date: Thu, 6 Oct 2005 18:25:04 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2/22] ppc64: Enable detection bugfix
Message-ID: <20051006232504.GC29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


02-EEH-enable-bugfix.patch

Bugfix: With the curent linux-2.6.14-rc2-git6, EEH errors are 
ignored because thier detection requires an unusued, uninitialized 
flag to be set.  This patch removes the unused flag.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-10-04 15:32:17.844809875 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-10-04 15:54:21.769066567 -0500
@@ -631,11 +631,12 @@
 	pdn = PCI_DN(dn);
 
 	/* Access to IO BARs might get this far and still not want checking. */
-	if (!pdn->eeh_capable || !(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
+	if (!(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
 		__get_cpu_var(ignored_check)++;
 #ifdef DEBUG
-		printk ("EEH:ignored check for %s %s\n", pci_name (dev), dn->full_name);
+		printk ("EEH:ignored check (%x) for %s %s\n", 
+		        pdn->eeh_mode, pci_name (dev), dn->full_name);
 #endif
 		return 0;
 	}
Index: linux-2.6.14-rc2-git6/include/asm-ppc64/pci-bridge.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/include/asm-ppc64/pci-bridge.h	2005-10-04 15:32:17.845809735 -0500
+++ linux-2.6.14-rc2-git6/include/asm-ppc64/pci-bridge.h	2005-10-04 15:54:21.769066567 -0500
@@ -61,7 +61,6 @@
 	int	devfn;			/* for pci devices */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
-	int	eeh_capable;		/* from firmware */
 	int 	eeh_check_count;	/* # times driver ignored error */
 	int 	eeh_freeze_count;	/* # times this device froze up. */
 	int	eeh_is_bridge;		/* device is pci-to-pci bridge */
