Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWEKUab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWEKUab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 16:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWEKUab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 16:30:31 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:55502 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1750768AbWEKUaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 16:30:30 -0400
Date: Thu, 11 May 2006 13:30:13 -0700
Message-Id: <200605112030.k4BKUDDe011199@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH -mm] BusLogic gcc 4.1 warning fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's another attempt . 

- Reworked all the very long lines in that block (this drivers full of them though)
- Returns an error in three places that it didn't before.
- Properly clean up after a scsi_add_host() failure .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/scsi/BusLogic.c
===================================================================
--- linux-2.6.16.orig/drivers/scsi/BusLogic.c
+++ linux-2.6.16/drivers/scsi/BusLogic.c
@@ -2177,6 +2177,7 @@ static int __init BusLogic_init(void)
 {
 	int BusLogicHostAdapterCount = 0, DriverOptionsIndex = 0, ProbeIndex;
 	struct BusLogic_HostAdapter *PrototypeHostAdapter;
+	int ret = 0;	
 
 #ifdef MODULE
 	if (BusLogic)
@@ -2282,26 +2283,50 @@ static int __init BusLogic_init(void)
 		   Create the Initial CCBs, Initialize the Host Adapter, and finally
 		   perform Target Device Inquiry.
 		 */
-		if (BusLogic_ReadHostAdapterConfiguration(HostAdapter) &&
-		    BusLogic_ReportHostAdapterConfiguration(HostAdapter) && BusLogic_AcquireResources(HostAdapter) && BusLogic_CreateInitialCCBs(HostAdapter) && BusLogic_InitializeHostAdapter(HostAdapter) && BusLogic_TargetDeviceInquiry(HostAdapter)) {
+		if (BusLogic_ReadHostAdapterConfiguration(HostAdapter) && 
+		    BusLogic_ReportHostAdapterConfiguration(HostAdapter) && 
+		    BusLogic_AcquireResources(HostAdapter) && 
+		    BusLogic_CreateInitialCCBs(HostAdapter) && 
+		    BusLogic_InitializeHostAdapter(HostAdapter) && 
+		    BusLogic_TargetDeviceInquiry(HostAdapter)) {
 			/*
 			   Initialization has been completed successfully.  Release and
 			   re-register usage of the I/O Address range so that the Model
 			   Name of the Host Adapter will appear, and initialize the SCSI
 			   Host structure.
 			 */
-			release_region(HostAdapter->IO_Address, HostAdapter->AddressCount);
-			if (!request_region(HostAdapter->IO_Address, HostAdapter->AddressCount, HostAdapter->FullModelName)) {
-				printk(KERN_WARNING "BusLogic: Release and re-register of " "port 0x%04lx failed \n", (unsigned long) HostAdapter->IO_Address);
+			release_region(HostAdapter->IO_Address, 
+				       HostAdapter->AddressCount);
+			if (!request_region(HostAdapter->IO_Address, 
+					    HostAdapter->AddressCount, 
+					    HostAdapter->FullModelName)) {
+				printk(KERN_WARNING 
+					"BusLogic: Release and re-register of " 
+					"port 0x%04lx failed \n", 
+					(unsigned long)HostAdapter->IO_Address);
 				BusLogic_DestroyCCBs(HostAdapter);
 				BusLogic_ReleaseResources(HostAdapter);
 				list_del(&HostAdapter->host_list);
 				scsi_host_put(Host);
+				ret = -ENOMEM;
 			} else {
-				BusLogic_InitializeHostStructure(HostAdapter, Host);
-				scsi_add_host(Host, HostAdapter->PCI_Device ? &HostAdapter->PCI_Device->dev : NULL);
-				scsi_scan_host(Host);
-				BusLogicHostAdapterCount++;
+				BusLogic_InitializeHostStructure(HostAdapter, 
+								 Host);
+				if (scsi_add_host(Host, HostAdapter->PCI_Device 
+						? &HostAdapter->PCI_Device->dev 
+						  : NULL)) {
+					printk(KERN_WARNING 
+					       "BusLogic: scsi_add_host()"
+					       "failed!\n");
+					BusLogic_DestroyCCBs(HostAdapter);
+					BusLogic_ReleaseResources(HostAdapter);
+					list_del(&HostAdapter->host_list);
+					scsi_host_put(Host);
+					ret = -ENODEV;
+				} else {
+					scsi_scan_host(Host);
+					BusLogicHostAdapterCount++;
+				}
 			}
 		} else {
 			/*
@@ -2316,12 +2341,13 @@ static int __init BusLogic_init(void)
 			BusLogic_ReleaseResources(HostAdapter);
 			list_del(&HostAdapter->host_list);
 			scsi_host_put(Host);
+			ret = -ENODEV;
 		}
 	}
 	kfree(PrototypeHostAdapter);
 	kfree(BusLogic_ProbeInfoList);
 	BusLogic_ProbeInfoList = NULL;
-	return 0;
+	return ret;
 }
 
 
@@ -2955,6 +2981,7 @@ static int BusLogic_QueueCommand(struct 
 }
 
 
+#if 0
 /*
   BusLogic_AbortCommand aborts Command if possible.
 */
@@ -3025,6 +3052,7 @@ static int BusLogic_AbortCommand(struct 
 	return SUCCESS;
 }
 
+#endif
 /*
   BusLogic_ResetHostAdapter resets Host Adapter if possible, marking all
   currently executing SCSI Commands as having been Reset.
