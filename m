Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTDQVZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 17:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTDQVZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 17:25:26 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1940 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262620AbTDQVZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 17:25:25 -0400
Date: Thu, 17 Apr 2003 14:37:37 -0700
From: Dave Olien <dmo@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: [PATCH] DAC960 2.5.67 add call to blk_queue_bounce_limit
Message-ID: <20030417213737.GA21387@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch adds a call to blk_queue_bounce_limit to the
DAC960 driver.  Otherwise, it uses bounce buffering more than it
needs to.

-------------------------------------------------------------------------------

diff -ur linux-2.5.67_original/drivers/block/DAC960.c linux-2.5.67_DACpatch/drivers/block/DAC960.c
--- linux-2.5.67_original/drivers/block/DAC960.c	2003-04-07 10:32:18.000000000 -0700
+++ linux-2.5.67_DACpatch/drivers/block/DAC960.c	2003-04-16 10:56:03.000000000 -0700
@@ -1069,6 +1069,7 @@
   
   if (pci_set_dma_mask(Controller->PCIDevice, DAC690_V1_PciDmaMask))
 	return DAC960_Failure(Controller, "DMA mask out of range");
+  Controller->BounceBufferLimit = DAC690_V1_PciDmaMask;
 
   if ((hw_type == DAC960_PD_Controller) || (hw_type == DAC960_P_Controller)) {
     CommandMailboxesSize =  0;
@@ -1271,6 +1272,7 @@
 
   if (pci_set_dma_mask(Controller->PCIDevice, DAC690_V2_PciDmaMask))
 	return DAC960_Failure(Controller, "DMA mask out of range");
+  Controller->BounceBufferLimit = DAC690_V2_PciDmaMask;
 
   /* This is a temporary dma mapping, used only in the scope of this function */
   CommandMailbox =
@@ -2386,6 +2388,7 @@
   */
   RequestQueue = &Controller->RequestQueue;
   blk_init_queue(RequestQueue, DAC960_RequestFunction, &Controller->queue_lock);
+  blk_queue_bounce_limit(RequestQueue, Controller->BounceBufferLimit);
   RequestQueue->queuedata = Controller;
   blk_queue_max_hw_segments(RequestQueue,
 			    Controller->DriverScatterGatherLimit);
diff -ur linux-2.5.67_original/drivers/block/DAC960.h linux-2.5.67_DACpatch/drivers/block/DAC960.h
--- linux-2.5.67_original/drivers/block/DAC960.h	2003-04-07 10:32:18.000000000 -0700
+++ linux-2.5.67_DACpatch/drivers/block/DAC960.h	2003-04-16 10:48:37.000000000 -0700
@@ -62,11 +62,6 @@
 
 /*
   Define the pci dma mask supported by DAC960 V1 and V2 Firmware Controlers
-
-  For now set the V2 mask to only 32 bits.  The controller IS capable
-  of doing 64 bit dma.  But I have yet to find out whether this needs to
-  be explicitely enabled in the controller, or of the controller adapts
-  automatically.
  */
 
 #define DAC690_V1_PciDmaMask	0xffffffff
@@ -2370,6 +2365,7 @@
   unsigned short ControllerScatterGatherLimit;
   unsigned short DriverScatterGatherLimit;
   unsigned int ControllerUsageCount;
+  u64		BounceBufferLimit;
   unsigned int CombinedStatusBufferLength;
   unsigned int InitialStatusLength;
   unsigned int CurrentStatusLength;
