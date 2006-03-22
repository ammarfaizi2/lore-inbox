Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWCVGj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWCVGj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWCVGiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:38:51 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43907 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750884AbWCVGiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:38:11 -0500
Message-Id: <20060322063750.631016000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:53 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 13/35] Support loading an initrd when running on Xen
Content-Disposition: inline; filename=12-i386-setup-initrd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the initial physical memory layout when booting on Xen, the initrd
image ends up below min_low_pfn (as registered with the bootstrap memory
allocator). Add an i386 build option to allow this scenario by setting
the initrd_below_start_ok flag.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/setup.c |    7 ++++++-
 drivers/block/Kconfig    |    4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

--- xen-subarch-2.6.orig/arch/i386/kernel/setup.c
+++ xen-subarch-2.6/arch/i386/kernel/setup.c
@@ -1237,10 +1237,15 @@ void __init setup_bootmem_allocator(void
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
-			reserve_bootmem(INITRD_START, INITRD_SIZE);
 			initrd_start =
 				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
 			initrd_end = initrd_start+INITRD_SIZE;
+#ifdef CONFIG_BLK_DEV_INITRD_BELOW_START_OK
+			if (initrd_start < min_low_pfn << PAGE_SHIFT)
+				initrd_below_start_ok = 1;
+			else
+#endif
+			reserve_bootmem(INITRD_START, INITRD_SIZE);
 		}
 		else {
 			printk(KERN_ERR "initrd extends beyond end of memory "
--- xen-subarch-2.6.orig/drivers/block/Kconfig
+++ xen-subarch-2.6/drivers/block/Kconfig
@@ -409,6 +409,10 @@ config BLK_DEV_INITRD
 	  "real" root file system, etc. See <file:Documentation/initrd.txt>
 	  for details.
 
+config BLK_DEV_INITRD_BELOW_START_OK
+	bool
+	depends on XEN
+	default BLK_DEV_INITRD
 
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media"

--
