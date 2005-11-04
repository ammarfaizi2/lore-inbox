Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbVKDAtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbVKDAtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbVKDAtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:49:51 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:46995
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161014AbVKDAtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:49:45 -0500
Date: Thu, 3 Nov 2005 18:49:45 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 10/42]: ppc64: bugfix: don't silently gnore PCI errors
Message-ID: <20051104004945.GA26860@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

10-EEH-enable-bugfix.patch

Bugfix: With the curent linux-2.6.14-rc2-git6, EEH errors are 
ignored because thier detection requires an unusued, uninitialized 
flag to be set.  This patch removes the unused flag.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-git3/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/ppc64/kernel/eeh.c	2005-10-31 12:54:20.919034814 -0600
+++ linux-2.6.14-git3/arch/ppc64/kernel/eeh.c	2005-10-31 12:54:48.165215962 -0600
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
Index: linux-2.6.14-git3/include/asm-ppc64/pci-bridge.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-ppc64/pci-bridge.h	2005-10-31 12:54:20.919034814 -0600
+++ linux-2.6.14-git3/include/asm-ppc64/pci-bridge.h	2005-10-31 12:54:48.167215682 -0600
@@ -63,7 +63,6 @@
 	int	devfn;			/* for pci devices */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
-	int	eeh_capable;		/* from firmware */
 	int 	eeh_check_count;	/* # times driver ignored error */
 	int 	eeh_freeze_count;	/* # times this device froze up. */
 	int	eeh_is_bridge;		/* device is pci-to-pci bridge */
