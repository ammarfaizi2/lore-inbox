Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423496AbWLBLXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423496AbWLBLXd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423245AbWLBLXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:23:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:31754 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162965AbWLBLX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:23:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ABrs/NdkgLUx7TwvuHj3eOr7aks0oyTlilh57X4kVEhSosfa6Jd7GiCIWUoq9XGcMaBg0hQQPC261W9pmS+sjJKmtp8DlLhNQ5URt6MzYHJLV4KHDavcrzAhf74oOmlyxOv0Mdr+up6dD4L6LoK6kcbzXduSWXk4xhd1jz0Osyw=
Subject: [PATCH 2.6.19] ia64: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tony.luck@intel.com, trivial@kernel.org
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:20:23 +0200
Message-Id: <1165058423.4523.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc 

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/arch/ia64/hp/common/sba_iommu.c linux-2.6.19-rc5_kzalloc/arch/ia64/hp/common/sba_iommu.c
--- linux-2.6.19-rc5_orig/arch/ia64/hp/common/sba_iommu.c	2006-11-09 12:16:22.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/ia64/hp/common/sba_iommu.c	2006-11-11 22:44:04.000000000 +0200
@@ -1672,15 +1672,13 @@ ioc_sac_init(struct ioc *ioc)
 	 * SAC (single address cycle) addressable, so allocate a
 	 * pseudo-device to enforce that.
 	 */
-	sac = kmalloc(sizeof(*sac), GFP_KERNEL);
+	sac = kzalloc(sizeof(*sac), GFP_KERNEL);
 	if (!sac)
 		panic(PFX "Couldn't allocate struct pci_dev");
-	memset(sac, 0, sizeof(*sac));
 
-	controller = kmalloc(sizeof(*controller), GFP_KERNEL);
+	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
 	if (!controller)
 		panic(PFX "Couldn't allocate struct pci_controller");
-	memset(controller, 0, sizeof(*controller));
 
 	controller->iommu = ioc;
 	sac->sysdata = controller;
@@ -1737,12 +1735,10 @@ ioc_init(u64 hpa, void *handle)
 	struct ioc *ioc;
 	struct ioc_iommu *info;
 
-	ioc = kmalloc(sizeof(*ioc), GFP_KERNEL);
+	ioc = kzalloc(sizeof(*ioc), GFP_KERNEL);
 	if (!ioc)
 		return NULL;
 
-	memset(ioc, 0, sizeof(*ioc));
-
 	ioc->next = ioc_list;
 	ioc_list = ioc;
 
diff -rubp linux-2.6.19-rc5_orig/arch/ia64/hp/sim/simserial.c linux-2.6.19-rc5_kzalloc/arch/ia64/hp/sim/simserial.c
--- linux-2.6.19-rc5_orig/arch/ia64/hp/sim/simserial.c	2006-11-09 12:16:22.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/ia64/hp/sim/simserial.c	2006-11-11 22:44:04.000000000 +0200
@@ -684,12 +684,11 @@ static int get_async_struct(int line, st
 		*ret_info = sstate->info;
 		return 0;
 	}
-	info = kmalloc(sizeof(struct async_struct), GFP_KERNEL);
+	info = kzalloc(sizeof(struct async_struct), GFP_KERNEL);
 	if (!info) {
 		sstate->count--;
 		return -ENOMEM;
 	}
-	memset(info, 0, sizeof(struct async_struct));
 	init_waitqueue_head(&info->open_wait);
 	init_waitqueue_head(&info->close_wait);
 	init_waitqueue_head(&info->delta_msr_wait);
diff -rubp linux-2.6.19-rc5_orig/arch/ia64/kernel/perfmon.c linux-2.6.19-rc5_kzalloc/arch/ia64/kernel/perfmon.c
--- linux-2.6.19-rc5_orig/arch/ia64/kernel/perfmon.c	2006-11-09 12:16:22.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/ia64/kernel/perfmon.c	2006-11-11 22:44:04.000000000 +0200
@@ -853,9 +853,8 @@ pfm_context_alloc(void)
 	 * allocate context descriptor 
 	 * must be able to free with interrupts disabled
 	 */
-	ctx = kmalloc(sizeof(pfm_context_t), GFP_KERNEL);
+	ctx = kzalloc(sizeof(pfm_context_t), GFP_KERNEL);
 	if (ctx) {
-		memset(ctx, 0, sizeof(pfm_context_t));
 		DPRINT(("alloc ctx @%p\n", ctx));
 	}
 	return ctx;

diff -rubp linux-2.6.19-rc5_orig/arch/ia64/pci/pci.c linux-2.6.19-rc5_kzalloc/arch/ia64/pci/pci.c
--- linux-2.6.19-rc5_orig/arch/ia64/pci/pci.c	2006-11-09 12:16:22.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/ia64/pci/pci.c	2006-11-11 22:44:04.000000000 +0200
@@ -125,11 +125,10 @@ alloc_pci_controller (int seg)
 {
 	struct pci_controller *controller;
 
-	controller = kmalloc(sizeof(*controller), GFP_KERNEL);
+	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
 	if (!controller)
 		return NULL;
 
-	memset(controller, 0, sizeof(*controller));
 	controller->segment = seg;
 	controller->node = -1;
 	return controller;



