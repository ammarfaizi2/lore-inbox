Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUIARYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUIARYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUIAPzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:55:46 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:57266 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267356AbUIAPvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:46 -0400
Date: Wed, 1 Sep 2004 16:51:18 +0100
Message-Id: <200409011551.i81FpIUd000585@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Clean up failure path in DAC960
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. If the ScatterGatherPool allocation fails, its pointless
   trying to allocate a RequestSensePool.
2. Free up the ScatterGatherPool if the RequestSensePool allocation fails.

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/DAC960.c linux-2.6/drivers/block/DAC960.c
--- bk-linus/drivers/block/DAC960.c	2004-06-04 12:08:32.000000000 +0100
+++ linux-2.6/drivers/block/DAC960.c	2004-06-07 11:07:03.000000000 +0100
@@ -288,12 +288,17 @@ static boolean DAC960_CreateAuxiliaryStr
 		Controller->PCIDevice,
 	DAC960_V2_ScatterGatherLimit * sizeof(DAC960_V2_ScatterGatherSegment_T),
 	sizeof(DAC960_V2_ScatterGatherSegment_T), 0);
+      if (ScatterGatherPool == NULL)
+	    return DAC960_Failure(Controller,
+			"AUXILIARY STRUCTURE CREATION (SG)");
       RequestSensePool = pci_pool_create("DAC960_V2_RequestSense",
 		Controller->PCIDevice, sizeof(DAC960_SCSI_RequestSense_T),
 		sizeof(int), 0);
-      if (ScatterGatherPool == NULL || RequestSensePool == NULL)
+      if (RequestSensePool == NULL) {
+	    pci_pool_destroy(ScatterGatherPool);
 	    return DAC960_Failure(Controller,
 			"AUXILIARY STRUCTURE CREATION (SG)");
+      }
       Controller->ScatterGatherPool = ScatterGatherPool;
       Controller->V2.RequestSensePool = RequestSensePool;
     }
