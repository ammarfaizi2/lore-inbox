Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263047AbVCQLtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263047AbVCQLtC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbVCQLoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:44:37 -0500
Received: from ozlabs.org ([203.10.76.45]:30101 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263047AbVCQKn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:43:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.24485.811976.668027@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 21:44:53 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <ntl@pobox.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] PPC64 prom.c: use pSeries reconfig notifier
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pSeries_reconfig notifier list to fix up a device node which
is about to be added.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

 arch/ppc64/kernel/prom.c |   40 ++++++++++++++++++++-------
 1 files changed, 31 insertions(+), 9 deletions(-)

Index: linux-2.6.11-bk10/arch/ppc64/kernel/prom.c
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/prom.c	2005-03-14 22:15:45.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/prom.c	2005-03-14 22:28:19.000000000 +0000
@@ -52,6 +52,7 @@
 #include <asm/btext.h>
 #include <asm/sections.h>
 #include <asm/machdep.h>
+#include <asm/pSeries_reconfig.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -1635,15 +1636,6 @@ out:
  */
 void of_attach_node(struct device_node *np)
 {
-	int err;
-
-	/* This use of finish_node will be moved to a notifier so
-	 * the error code can be used.
-	 */
-	err = finish_node(np, NULL, of_finish_dynamic_node, 0, 0, 0);
-	if (err < 0)
-		return;
-
 	write_lock(&devtree_lock);
 	np->sibling = np->parent->child;
 	np->allnext = allnodes;
@@ -1690,6 +1682,36 @@ void of_detach_node(const struct device_
 	write_unlock(&devtree_lock);
 }
 
+static int prom_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
+{
+	int err;
+
+	switch (action) {
+	case PSERIES_RECONFIG_ADD:
+		err = finish_node(node, NULL, of_finish_dynamic_node, 0, 0, 0);
+		if (err < 0) {
+			printk(KERN_ERR "finish_node returned %d\n", err);
+			err = NOTIFY_BAD;
+		}
+		break;
+	default:
+		err = NOTIFY_DONE;
+		break;
+	}
+	return err;
+}
+
+static struct notifier_block prom_reconfig_nb = {
+	.notifier_call prom_reconfig_notifier,
+	.priority = 10, /* This one needs to run first */
+};
+
+static int __init prom_reconfig_setup(void)
+{
+	return pSeries_reconfig_notifier_register(&prom_reconfig_nb);
+}
+__initcall(prom_reconfig_setup);
+
 /*
  * Find a property with a given name for a given node
  * and return the value.
