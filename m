Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbUCGMpm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 07:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUCGMpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 07:45:42 -0500
Received: from zux191-241.adsl.green.ch ([80.254.191.241]:59144 "EHLO jupiter")
	by vger.kernel.org with ESMTP id S261854AbUCGMpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 07:45:40 -0500
Message-ID: <1078670323.404b33f368fbb@oribi.org>
Date: Sun,  7 Mar 2004 15:38:43 +0100
From: markus.amsler@oribi.org
To: linux-kernel@vger.kernel.org
Subject: [PATCH] DAC960 Oopses
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 192.168.67.251
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first part fixes a Kernel paging request failure on alpha with
some older DAC960P cards (i tried D040340-0-DEC/Firmware 2.70).
The Problem was, that ioremap_nocache(NULL) is not  NULL (only on alpha).
This card is still unsupported, due to lacking PCI resources.

The second part fixes a kernel Oops, if the initialization
of the Controller fails (like too old firmware).
In that case, DAC960_UnregisterBlockDevice fails, 
because DAC960_RegisterBlockDevice was never called.
This is a side effect of the multi-queue patch by Dave Olien.

Please CC to me directly.

--- linux-2.6.3/drivers/block/DAC960.c	Wed Feb 18 04:59:05 2004
+++ linux/drivers/block/DAC960.c	Sun Mar  7 11:47:55 2004
@@ -2723,6 +2723,20 @@
 	  break;
   }
 
+  /*
+    Controller with Mylex P/N D040340-0-DEC has no PCI resource[1]!!
+    Checking the MemoryMappedAddress == NULL will fail on 
+    virtual Alpha addresses. 
+  */	  
+  if (!Controller->PCI_Address)
+  {
+	  DAC960_Error("Unable to get PCI Address. "
+		       "This Controller is currently not supported.\n",
+                       Controller);
+	  Controller->IO_Address = 0;
+	  goto Failure;
+  }
+
   pci_set_drvdata(PCI_Device, (void *)((long)Controller->ControllerNumber));
   for (i = 0; i < DAC960_MaxLogicalDrives; i++) {
 	Controller->disks[i] = alloc_disk(1<<DAC960_MaxPartitionsBits);
@@ -3061,8 +3075,8 @@
 				    DAC960_V2_RAID_Controller);
 	  DAC960_Notice("done\n", Controller);
 	}
+    DAC960_UnregisterBlockDevice(Controller);
     }
-  DAC960_UnregisterBlockDevice(Controller);
   DAC960_DestroyAuxiliaryStructures(Controller);
   DAC960_DestroyProcEntries(Controller);
   DAC960_DetectCleanup(Controller);
