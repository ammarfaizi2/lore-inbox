Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUAWGsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266523AbUAWGqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:46:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266522AbUAWGgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:46 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
From: davej@redhat.com
Subject: Remove useless cruft from ATM HE driver.
Message-Id: <E1Ajuub-0000xS-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Echoing changes done in 2.4. (It now has a pci_pool_create backport).

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/atm/he.c linux-2.5/drivers/atm/he.c
--- bk-linus/drivers/atm/he.c	2003-10-17 20:53:48.000000000 +0100
+++ linux-2.5/drivers/atm/he.c	2003-10-21 02:32:37.000000000 +0100
@@ -109,10 +109,6 @@ typedef void irqreturn_t;
 #define pci_get_drvdata(pci_dev)	(pci_dev)->driver_data
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,44)
-#define pci_pool_create(a, b, c, d, e)	pci_pool_create(a, b, c, d, e, SLAB_KERNEL)
-#endif
-
 #include "he.h"
 
 #include "suni.h"
@@ -785,7 +781,7 @@ he_init_group(struct he_dev *he_dev, int
 	/* small buffer pool */
 #ifdef USE_RBPS_POOL
 	he_dev->rbps_pool = pci_pool_create("rbps", he_dev->pci_dev,
-			CONFIG_RBPS_BUFSIZE, 8, 0);
+			CONFIG_RBPS_BUFSIZE, 8, 0, SLAB_KERNEL);
 	if (he_dev->rbps_pool == NULL) {
 		hprintk("unable to create rbps pages\n");
 		return -ENOMEM;
@@ -849,7 +845,7 @@ he_init_group(struct he_dev *he_dev, int
 	/* large buffer pool */
 #ifdef USE_RBPL_POOL
 	he_dev->rbpl_pool = pci_pool_create("rbpl", he_dev->pci_dev,
-			CONFIG_RBPL_BUFSIZE, 8, 0);
+			CONFIG_RBPL_BUFSIZE, 8, 0, SLAB_KERNEL);
 	if (he_dev->rbpl_pool == NULL) {
 		hprintk("unable to create rbpl pool\n");
 		return -ENOMEM;
@@ -1475,7 +1471,7 @@ he_start(struct atm_dev *dev)
 
 #ifdef USE_TPD_POOL
 	he_dev->tpd_pool = pci_pool_create("tpd", he_dev->pci_dev,
-		sizeof(struct he_tpd), TPD_ALIGNMENT, 0);
+		sizeof(struct he_tpd), TPD_ALIGNMENT, 0, SLAB_KERNEL);
 	if (he_dev->tpd_pool == NULL) {
 		hprintk("unable to create tpd pci_pool\n");
 		return -ENOMEM;         
@@ -1986,8 +1982,7 @@ he_service_tbrq(struct he_dev *he_dev, i
 			TBRQ_MULTIPLE(he_dev->tbrq_head) ? " MULTIPLE" : "");
 #ifdef USE_TPD_POOL
 		tpd = NULL;
-		p = &he_dev->outstanding_tpds;
-		while ((p = p->next) != &he_dev->outstanding_tpds) {
+		list_for_each(p, &he_dev->outstanding_tpds) {
 			struct he_tpd *__tpd = list_entry(p, struct he_tpd, entry);
 			if (TPD_ADDR(__tpd->status) == TBRQ_TPD(he_dev->tbrq_head)) {
 				tpd = __tpd;
