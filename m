Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTIVRaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbTIVRaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:30:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:11662 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263263AbTIVRag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:30:36 -0400
Date: Mon, 22 Sep 2003 10:31:23 -0700
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DAC960, remove redundant (and uninitialized) PciDevice pointer.
Message-ID: <20030922173123.GA8745@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch fixes a bug that appeared only on Alpha hardware with
DAC960 controllers.  The Command->PciDevice structure member was
never initialized.  This was passed to the pci scatter/gather functions.
This didn't cause a problem for x86 platforms because the scatter/gather
funtions never really used that information.  Alpha platforms do use
that pointer.

The Command->PciDevice field was also redundant with the Controller->PCIDevice
field, which IS initialized properly.  So, eliminating the redundant
structure member and substituting the Controller's member fixes the bug.

-------------------------------------------------------------------------

diff -ur linux-2.6.0-test5-mm4_original/drivers/block/DAC960.c linux-2.6.0-test5-mm4_DAC/drivers/block/DAC960.c
--- linux-2.6.0-test5-mm4_original/drivers/block/DAC960.c	2003-09-22 10:11:29.000000000 -0700
+++ linux-2.6.0-test5-mm4_DAC/drivers/block/DAC960.c	2003-09-22 10:20:35.000000000 -0700
@@ -3300,7 +3300,7 @@
   Command->SegmentCount = blk_rq_map_sg(Controller->RequestQueue,
 		  Command->Request, Command->cmd_sglist);
   /* pci_map_sg MAY change the value of SegCount */
-  Command->SegmentCount = pci_map_sg(Command->PciDevice, Command->cmd_sglist,
+  Command->SegmentCount = pci_map_sg(Controller->PCIDevice, Command->cmd_sglist,
 		 Command->SegmentCount, Command->DmaDirection);
 
   DAC960_QueueReadWriteCommand(Command);
@@ -3336,7 +3336,7 @@
   (void)blk_rq_map_sg(Controller->RequestQueue, Command->Request,
                                         Command->cmd_sglist);
 
-  (void)pci_map_sg(Command->PciDevice, Command->cmd_sglist, 1,
+  (void)pci_map_sg(Controller->PCIDevice, Command->cmd_sglist, 1,
 		                        Command->DmaDirection);
   /*
    * Resubmitting the request sector at a time is really tedious.
@@ -3377,7 +3377,7 @@
 	if (SuccessfulIO)
 		UpToDate = 1;
 
-	pci_unmap_sg(Command->PciDevice, Command->cmd_sglist,
+	pci_unmap_sg(Command->Controller->PCIDevice, Command->cmd_sglist,
 		Command->SegmentCount, Command->DmaDirection);
 
 	 if (!end_that_request_first(Request, UpToDate, Command->BlockCount)) {
diff -ur linux-2.6.0-test5-mm4_original/drivers/block/DAC960.h linux-2.6.0-test5-mm4_DAC/drivers/block/DAC960.h
--- linux-2.6.0-test5-mm4_original/drivers/block/DAC960.h	2003-09-08 12:50:21.000000000 -0700
+++ linux-2.6.0-test5-mm4_DAC/drivers/block/DAC960.h	2003-09-22 10:20:35.000000000 -0700
@@ -2248,7 +2248,6 @@
   int	DmaDirection;
   struct scatterlist *cmd_sglist;
   struct request *Request;
-  struct pci_dev *PciDevice;
   union {
     struct {
       DAC960_V1_CommandMailbox_T CommandMailbox;
