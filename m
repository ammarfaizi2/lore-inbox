Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVI3A6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVI3A6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVI3A6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:58:35 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:9186 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932530AbVI3A62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:58:28 -0400
Date: Thu, 29 Sep 2005 19:58:27 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] ppc64: EEH handle empty PCI slot failure 
Message-ID: <20050930005827.GE6173@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930004800.GL29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



05-eeh-empty-slot-error.patch

Performing PCI config-space reads to empty PCI slots can lead to reports of 
"permanent failure" from the firmware. Ignore permanent failures on empty slots.

Signed-off-by: Linas Vepstas <linas@linas.org>

Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-09-29 16:06:25.583986100 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-09-29 16:06:33.567867154 -0500
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
