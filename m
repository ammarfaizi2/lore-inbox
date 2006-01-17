Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWAQRYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWAQRYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWAQRYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:24:42 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:20957 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S932212AbWAQRYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:24:41 -0500
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Brent Casavant <bcasavan@sgi.com>
Subject: [patch] sem2mutex ioc4.c
From: Jes Sorensen <jes@sgi.com>
Date: 17 Jan 2006 12:24:39 -0500
Message-ID: <yq0mzhurcmg.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another simple sem2mutex conversion.

Cheers,
Jes


Convert to use a single mutex instead of two rwsems as this isn't
performance critical.

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Brent Casavant <bcasavan@sgi.com>

----

 drivers/sn/ioc4.c |   41 ++++++++++++++++++-----------------------
 1 files changed, 18 insertions(+), 23 deletions(-)

Index: linux-2.6.15-quilt/drivers/sn/ioc4.c
===================================================================
--- linux-2.6.15-quilt.orig/drivers/sn/ioc4.c
+++ linux-2.6.15-quilt/drivers/sn/ioc4.c
@@ -31,7 +31,7 @@
 #include <linux/ioc4.h>
 #include <linux/mmtimer.h>
 #include <linux/rtc.h>
-#include <linux/rwsem.h>
+#include <linux/mutex.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/clksupport.h>
 #include <asm/sn/shub_mmr.h>
@@ -54,11 +54,10 @@
  * Submodule management *
  ************************/
 
-static LIST_HEAD(ioc4_devices);
-static DECLARE_RWSEM(ioc4_devices_rwsem);
+static DEFINE_MUTEX(ioc4_mutex);
 
+static LIST_HEAD(ioc4_devices);
 static LIST_HEAD(ioc4_submodules);
-static DECLARE_RWSEM(ioc4_submodules_rwsem);
 
 /* Register an IOC4 submodule */
 int
@@ -66,15 +65,13 @@
 {
 	struct ioc4_driver_data *idd;
 
-	down_write(&ioc4_submodules_rwsem);
+	mutex_lock(&ioc4_mutex);
 	list_add(&is->is_list, &ioc4_submodules);
-	up_write(&ioc4_submodules_rwsem);
 
 	/* Initialize submodule for each IOC4 */
 	if (!is->is_probe)
-		return 0;
+		goto out;
 
-	down_read(&ioc4_devices_rwsem);
 	list_for_each_entry(idd, &ioc4_devices, idd_list) {
 		if (is->is_probe(idd)) {
 			printk(KERN_WARNING
@@ -84,8 +81,8 @@
 			       pci_name(idd->idd_pdev));
 		}
 	}
-	up_read(&ioc4_devices_rwsem);
-
+ out:
+	mutex_unlock(&ioc4_mutex);
 	return 0;
 }
 
@@ -95,15 +92,13 @@
 {
 	struct ioc4_driver_data *idd;
 
-	down_write(&ioc4_submodules_rwsem);
+	mutex_lock(&ioc4_mutex);
 	list_del(&is->is_list);
-	up_write(&ioc4_submodules_rwsem);
 
 	/* Remove submodule for each IOC4 */
 	if (!is->is_remove)
-		return;
+		goto out;
 
-	down_read(&ioc4_devices_rwsem);
 	list_for_each_entry(idd, &ioc4_devices, idd_list) {
 		if (is->is_remove(idd)) {
 			printk(KERN_WARNING
@@ -113,7 +108,8 @@
 			       pci_name(idd->idd_pdev));
 		}
 	}
-	up_read(&ioc4_devices_rwsem);
+ out:
+	mutex_unlock(&ioc4_mutex);
 }
 
 /*********************
@@ -312,12 +308,11 @@
 	/* Track PCI-device specific data */
 	idd->idd_serial_data = NULL;
 	pci_set_drvdata(idd->idd_pdev, idd);
-	down_write(&ioc4_devices_rwsem);
+
+	mutex_lock(&ioc4_mutex);
 	list_add(&idd->idd_list, &ioc4_devices);
-	up_write(&ioc4_devices_rwsem);
 
 	/* Add this IOC4 to all submodules */
-	down_read(&ioc4_submodules_rwsem);
 	list_for_each_entry(is, &ioc4_submodules, is_list) {
 		if (is->is_probe && is->is_probe(idd)) {
 			printk(KERN_WARNING
@@ -327,7 +322,7 @@
 			       pci_name(idd->idd_pdev));
 		}
 	}
-	up_read(&ioc4_submodules_rwsem);
+	mutex_unlock(&ioc4_mutex);
 
 	return 0;
 
@@ -351,7 +346,7 @@
 	idd = pci_get_drvdata(pdev);
 
 	/* Remove this IOC4 from all submodules */
-	down_read(&ioc4_submodules_rwsem);
+	mutex_lock(&ioc4_mutex);
 	list_for_each_entry(is, &ioc4_submodules, is_list) {
 		if (is->is_remove && is->is_remove(idd)) {
 			printk(KERN_WARNING
@@ -361,7 +356,7 @@
 			       pci_name(idd->idd_pdev));
 		}
 	}
-	up_read(&ioc4_submodules_rwsem);
+	mutex_unlock(&ioc4_mutex);
 
 	/* Release resources */
 	iounmap(idd->idd_misc_regs);
@@ -377,9 +372,9 @@
 	pci_disable_device(pdev);
 
 	/* Remove and free driver data */
-	down_write(&ioc4_devices_rwsem);
+	mutex_lock(&ioc4_mutex);
 	list_del(&idd->idd_list);
-	up_write(&ioc4_devices_rwsem);
+	mutex_unlock(&ioc4_mutex);
 	kfree(idd);
 }
 
