Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbVKDBDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbVKDBDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbVKDAtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:49:55 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:43667
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161016AbVKDAtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:49:32 -0500
Date: Thu, 3 Nov 2005 18:49:31 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 8/42]: ppc64: escape hatch for spinning interrupt deadlocks
Message-ID: <20051104004931.GA26844@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

08-eeh-spin-counter.patch

One an EEH event is triggers, all further I/O to a device is blocked (until
reset).  Bad device drivers may end up spinning in their interrupt handlers, 
trying to read an interrupt status register that will never change state.
This patch moves that spin counter to a per-device structure, and adds
some diagnostic prints to help locate the bad driver.

Signed-off-by: Linas Vepstas <linas@linas.org>

Index: linux-2.6.14-git3/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/ppc64/kernel/eeh.c	2005-10-31 12:16:19.766441392 -0600
+++ linux-2.6.14-git3/arch/ppc64/kernel/eeh.c	2005-10-31 12:18:21.924300428 -0600
@@ -78,14 +78,12 @@
 
 static struct notifier_block *eeh_notifier_chain;
 
-/*
- * If a device driver keeps reading an MMIO register in an interrupt
+/* If a device driver keeps reading an MMIO register in an interrupt
  * handler after a slot isolation event has occurred, we assume it
  * is broken and panic.  This sets the threshold for how many read
  * attempts we allow before panicking.
  */
-#define EEH_MAX_FAILS	1000
-static atomic_t eeh_fail_count;
+#define EEH_MAX_FAILS	100000
 
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -521,7 +519,6 @@
 		       "%s\n", event->reset_state,
 		       pci_name(event->dev));
 
-		atomic_set(&eeh_fail_count, 0);
 		notifier_call_chain (&eeh_notifier_chain,
 				     EEH_NOTIFY_FREEZE, event);
 
@@ -657,12 +654,18 @@
 	spin_lock_irqsave(&confirm_error_lock, flags);
 	rc = 1;
 	if (pdn->eeh_mode & EEH_MODE_ISOLATED) {
-		atomic_inc(&eeh_fail_count);
-		if (atomic_read(&eeh_fail_count) >= EEH_MAX_FAILS) {
+		pdn->eeh_check_count ++;
+		if (pdn->eeh_check_count >= EEH_MAX_FAILS) {
+			printk (KERN_ERR "EEH: Device driver ignored %d bad reads, panicing\n",
+			        pdn->eeh_check_count);
+			dump_stack();
+			
 			/* re-read the slot reset state */
 			if (read_slot_reset_state(pdn, rets) != 0)
 				rets[0] = -1;	/* reset state unknown */
-			eeh_panic(dev, rets[0]);
+
+			/* If we are here, then we hit an infinite loop. Stop. */
+			panic("EEH: MMIO halt (%d) on device:%s\n", rets[0], pci_name(dev));
 		}
 		goto dn_unlock;
 	}
@@ -808,6 +811,8 @@
 	struct pci_dn *pdn = PCI_DN(dn);
 
 	pdn->eeh_mode = 0;
+	pdn->eeh_check_count = 0;
+	pdn->eeh_freeze_count = 0;
 
 	if (status && strcmp(status, "ok") != 0)
 		return NULL;	/* ignore devices with bad status */
