Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVI3BCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVI3BCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVI3BCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:02:40 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7071 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932536AbVI3BCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:02:32 -0400
Date: Thu, 29 Sep 2005 20:02:28 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] ppc64: EEH Halt if bad drivers spin in error condition
Message-ID: <20050930010228.GG6173@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930004800.GL29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


07-eeh-spin-counter.patch

One an EEH event is triggers, all further I/O to a device is blocked (until
reset).  Bad device drivers may end up spinning in their interrupt handlers, 
trying to read an interrupt status register that will never change state.
This patch moves that spin counter to a per-device structure, and adds
some diagnostic prints to help locate the bad driver.

Signed-off-by: Linas Vepstas <linas@linas.org>

Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-09-29 16:29:00.726884805 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-09-29 16:32:05.550949258 -0500
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
