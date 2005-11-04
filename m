Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbVKDBFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbVKDBFJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbVKDAtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:49:18 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:40595
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1030577AbVKDAtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:49:15 -0500
Date: Thu, 3 Nov 2005 18:49:15 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 6/42]: ppc64: avoid PCI error reporting for empty slots
Message-ID: <20051104004915.GA26827@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06-eeh-empty-slot-error.patch

Performing PCI config-space reads to empty PCI slots can lead to reports of 
"permanent failure" from the firmware. Ignore permanent failures on empty slots.

Signed-off-by: Linas Vepstas <linas@linas.org>

Index: linux-2.6.14-git3/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/ppc64/kernel/eeh.c	2005-10-31 12:13:09.282168648 -0600
+++ linux-2.6.14-git3/arch/ppc64/kernel/eeh.c	2005-10-31 12:15:26.162962756 -0600
@@ -617,7 +617,32 @@
 	 * In any case they must share a common PHB.
 	 */
 	ret = read_slot_reset_state(pdn, rets);
-	if (!(ret == 0 && rets[1] == 1 && (rets[0] == 2 || rets[0] == 4))) {
+
+	/* If the call to firmware failed, punt */
+	if (ret != 0) {
+		printk(KERN_WARNING "EEH: read_slot_reset_state() failed; rc=%d dn=%s\n",
+		       ret, dn->full_name);
+		__get_cpu_var(false_positives)++;
+		return 0;
+	}
+
+	/* If EEH is not supported on this device, punt. */
+	if (rets[1] != 1) {
+		printk(KERN_WARNING "EEH: event on unsupported device, rc=%d dn=%s\n",
+		       ret, dn->full_name);
+		__get_cpu_var(false_positives)++;
+		return 0;
+	}
+
+	/* If not the kind of error we know about, punt. */
+	if (rets[0] != 2 && rets[0] != 4 && rets[0] != 5) {
+		__get_cpu_var(false_positives)++;
+		return 0;
+	}
+
+	/* Note that config-io to empty slots may fail;
+	 * we recognize empty because they don't have children. */
+	if ((rets[0] == 5) && (dn->child == NULL)) {
 		__get_cpu_var(false_positives)++;
 		return 0;
 	}
@@ -650,7 +675,7 @@
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out. */
-	dump_stack();
+	if (rets[0] != 5) dump_stack();
 	schedule_work(&eeh_event_wq);
 
 	return 0;
