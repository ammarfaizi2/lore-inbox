Return-Path: <linux-kernel-owner+w=401wt.eu-S1425551AbWLHPTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425551AbWLHPTt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425554AbWLHPTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:19:49 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:61499 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425556AbWLHPTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:19:47 -0500
Date: Fri, 8 Dec 2006 16:19:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, rwuerthn@de.ibm.com
Subject: [S390] add reset call handler to the ap bus.
Message-ID: <20061208151941.GC14596@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

[S390] add reset call handler to the ap bus.

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

diff -urpN linux-2.6/drivers/s390/crypto/ap_bus.c linux-2.6-patched/drivers/s390/crypto/ap_bus.c
--- linux-2.6/drivers/s390/crypto/ap_bus.c	2006-12-08 15:52:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/ap_bus.c	2006-12-08 15:52:47.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/kthread.h>
 #include <linux/mutex.h>
 #include <asm/s390_rdev.h>
+#include <asm/reset.h>
 
 #include "ap_bus.h"
 
@@ -1128,6 +1129,19 @@ static void ap_poll_thread_stop(void)
 	mutex_unlock(&ap_poll_thread_mutex);
 }
 
+static void ap_reset(void)
+{
+	int i, j;
+
+	for (i = 0; i < AP_DOMAINS; i++)
+		for (j = 0; j < AP_DEVICES; j++)
+			ap_reset_queue(AP_MKQID(j, i));
+}
+
+static struct reset_call ap_reset_call = {
+	.fn = ap_reset,
+};
+
 /**
  * The module initialization code.
  */
@@ -1144,6 +1158,7 @@ int __init ap_module_init(void)
 		printk(KERN_WARNING "AP instructions not installed.\n");
 		return -ENODEV;
 	}
+	register_reset_call(&ap_reset_call);
 
 	/* Create /sys/bus/ap. */
 	rc = bus_register(&ap_bus_type);
@@ -1197,6 +1212,7 @@ out_bus:
 		bus_remove_file(&ap_bus_type, ap_bus_attrs[i]);
 	bus_unregister(&ap_bus_type);
 out:
+	unregister_reset_call(&ap_reset_call);
 	return rc;
 }
 
@@ -1227,6 +1243,7 @@ void ap_module_exit(void)
 	for (i = 0; ap_bus_attrs[i]; i++)
 		bus_remove_file(&ap_bus_type, ap_bus_attrs[i]);
 	bus_unregister(&ap_bus_type);
+	unregister_reset_call(&ap_reset_call);
 }
 
 #ifndef CONFIG_ZCRYPT_MONOLITHIC
