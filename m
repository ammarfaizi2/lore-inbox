Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267654AbTBFW1F>; Thu, 6 Feb 2003 17:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267667AbTBFW1F>; Thu, 6 Feb 2003 17:27:05 -0500
Received: from air-2.osdl.org ([65.172.181.6]:41185 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267654AbTBFW1D>;
	Thu, 6 Feb 2003 17:27:03 -0500
Date: Thu, 6 Feb 2003 14:36:37 -0800
From: Dave Olien <dmo@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: [PATCH] DAC960 Stanford Checker fix
Message-ID: <20030206223637.GA3762@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This was found by the Standford Checker.
The LogicalDeviceNumber bad range test was changed from > to >=
I also replaced a couple of panic() calls with error messages,
since panic-ing seemed a little extreme.

---------------------------------------------------------------------------

diff -ur linux-2.5.59_original/drivers/block/DAC960.c linux-2.5.59_DAC_Logical_Dev/drivers/block/DAC960.c
--- linux-2.5.59_original/drivers/block/DAC960.c	2003-01-16 18:22:28.000000000 -0800
+++ linux-2.5.59_DAC_Logical_Dev/drivers/block/DAC960.c	2003-01-28 16:36:02.000000000 -0800
@@ -1729,12 +1729,17 @@
       if (!DAC960_V2_NewLogicalDeviceInfo(Controller, LogicalDeviceNumber))
 	break;
       LogicalDeviceNumber = NewLogicalDeviceInfo->LogicalDeviceNumber;
-      if (LogicalDeviceNumber > DAC960_MaxLogicalDrives)
-	panic("DAC960: Logical Drive Number %d not supported\n",
-		       LogicalDeviceNumber);
-      if (NewLogicalDeviceInfo->DeviceBlockSizeInBytes != DAC960_BlockSize)
-	panic("DAC960: Logical Drive Block Size %d not supported\n",
-	      NewLogicalDeviceInfo->DeviceBlockSizeInBytes);
+      if (LogicalDeviceNumber >= DAC960_MaxLogicalDrives) {
+	DAC960_Error("DAC960: Logical Drive Number %d not supported\n",
+		       Controller, LogicalDeviceNumber);
+		break;
+      }
+      if (NewLogicalDeviceInfo->DeviceBlockSizeInBytes != DAC960_BlockSize) {
+	DAC960_Error("DAC960: Logical Drive Block Size %d not supported\n",
+	      Controller, NewLogicalDeviceInfo->DeviceBlockSizeInBytes);
+        LogicalDeviceNumber++;
+        continue;
+      }
       PhysicalDevice.Controller = 0;
       PhysicalDevice.Channel = NewLogicalDeviceInfo->Channel;
       PhysicalDevice.TargetID = NewLogicalDeviceInfo->TargetID;


