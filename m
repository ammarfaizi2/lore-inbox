Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUIAM5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUIAM5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUIAM5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:57:24 -0400
Received: from ozlabs.org ([203.10.76.45]:8423 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266391AbUIAMzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:55:17 -0400
Date: Wed, 1 Sep 2004 22:51:00 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] Print backtrace in EEH code
Message-ID: <20040901125100.GQ26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We should print a stack backtrace when we get EEH errors, it makes
debugging the cause of the fail easier.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

===== eeh.c 1.29 vs edited =====
--- 1.29/arch/ppc64/kernel/eeh.c	Mon Aug 23 18:14:40 2004
+++ edited/eeh.c	Mon Aug 30 09:02:41 2004
@@ -447,6 +447,10 @@
 
 		spin_unlock_irqrestore(&slot_errbuf_lock, flags);
 
+		printk(KERN_ERR "EEH: MMIO failure (%d) on device:%s %s\n",
+		       rets[0], pci_name(dev), pci_pretty_name(dev));
+		WARN_ON(1);
+
 		/*
 		 * XXX We should create a separate sysctl for this.
 		 *
@@ -454,14 +458,11 @@
 		 * the system in light of potential corruption, we
 		 * can use it here.
 		 */
-		if (panic_on_oops) {
+		if (panic_on_oops)
 			panic("EEH: MMIO failure (%d) on device:%s %s\n",
 			      rets[0], pci_name(dev), pci_pretty_name(dev));
-		} else {
+		else
 			__get_cpu_var(ignored_failures)++;
-			printk(KERN_INFO "EEH: MMIO failure (%d) on device:%s %s\n",
-			       rets[0], pci_name(dev), pci_pretty_name(dev));
-		}
 	} else {
 		__get_cpu_var(false_positives)++;
 	}
