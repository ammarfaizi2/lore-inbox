Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbUBIN2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUBIN2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:28:43 -0500
Received: from d64-180-152-77.bchsia.telus.net ([64.180.152.77]:2821 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S265150AbUBIN20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:28:26 -0500
Date: Mon, 9 Feb 2004 05:24:55 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Buslogic.[ch] with gcc-2.95.4
Message-ID: <20040209132455.GA29348@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Minor patch to get the BusLogic driver building again under
gcc-2.95.4 with the latest (as of this writing) bk pull from
the 2.6 tree.

Apparently, anonymous structs don't play well with gcc-2.95.4,
even with -std=gnu99.

Can someone eyeball this and forward it off to Linus if it's all
good?

Thanks,

-- DN
Daniel

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1589  -> 1.1590 
#	drivers/scsi/BusLogic.h	1.16    -> 1.17   
#	drivers/scsi/BusLogic.c	1.27    -> 1.28   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/09	barbeque@kittens.172.16.0.1	1.1590
# Fix to get it building under gcc-2.95.4.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
--- a/drivers/scsi/BusLogic.c	Mon Feb  9 05:22:57 2004
+++ b/drivers/scsi/BusLogic.c	Mon Feb  9 05:22:57 2004
@@ -467,8 +467,8 @@
   while (--TimeoutCounter >= 0)
     {
       StatusRegister.All = BusLogic_ReadStatusRegister(HostAdapter);
-      if (StatusRegister.HostAdapterReady &&
-	  !StatusRegister.CommandParameterRegisterBusy)
+      if (StatusRegister.sr.HostAdapterReady &&
+	  !StatusRegister.sr.CommandParameterRegisterBusy)
 	break;
       udelay(100);
     }
@@ -504,10 +504,10 @@
       udelay(100);
       InterruptRegister.All = BusLogic_ReadInterruptRegister(HostAdapter);
       StatusRegister.All = BusLogic_ReadStatusRegister(HostAdapter);
-      if (InterruptRegister.CommandComplete) break;
+      if (InterruptRegister.ir.CommandComplete) break;
       if (HostAdapter->HostAdapterCommandCompleted) break;
-      if (StatusRegister.DataInRegisterReady) break;
-      if (StatusRegister.CommandParameterRegisterBusy) continue;
+      if (StatusRegister.sr.DataInRegisterReady) break;
+      if (StatusRegister.sr.CommandParameterRegisterBusy) continue;
       BusLogic_WriteCommandParameterRegister(HostAdapter, *ParameterPointer++);
       ParameterLength--;
     }
@@ -524,7 +524,7 @@
   if (OperationCode == BusLogic_ModifyIOAddress)
     {
       StatusRegister.All = BusLogic_ReadStatusRegister(HostAdapter);
-      if (StatusRegister.CommandInvalid)
+      if (StatusRegister.sr.CommandInvalid)
 	{
 	  BusLogic_CommandFailureReason = "Modify I/O Address Invalid";
 	  Result = -1;
@@ -562,16 +562,16 @@
     {
       InterruptRegister.All = BusLogic_ReadInterruptRegister(HostAdapter);
       StatusRegister.All = BusLogic_ReadStatusRegister(HostAdapter);
-      if (InterruptRegister.CommandComplete) break;
+      if (InterruptRegister.ir.CommandComplete) break;
       if (HostAdapter->HostAdapterCommandCompleted) break;
-      if (StatusRegister.DataInRegisterReady)
+      if (StatusRegister.sr.DataInRegisterReady)
 	{
 	  if (++ReplyBytes <= ReplyLength)
 	    *ReplyPointer++ = BusLogic_ReadDataInRegister(HostAdapter);
 	  else BusLogic_ReadDataInRegister(HostAdapter);
 	}
       if (OperationCode == BusLogic_FetchHostAdapterLocalRAM &&
-	  StatusRegister.HostAdapterReady) break;
+	  StatusRegister.sr.HostAdapterReady) break;
       udelay(100);
     }
   if (TimeoutCounter < 0)
@@ -602,7 +602,7 @@
   /*
     Process Command Invalid conditions.
   */
-  if (StatusRegister.CommandInvalid)
+  if (StatusRegister.sr.CommandInvalid)
     {
       /*
 	Some early BusLogic Host Adapters may not recover properly from
@@ -614,14 +614,14 @@
       */
       udelay(1000);
       StatusRegister.All = BusLogic_ReadStatusRegister(HostAdapter);
-      if (StatusRegister.CommandInvalid ||
-	  StatusRegister.Reserved ||
-	  StatusRegister.DataInRegisterReady ||
-	  StatusRegister.CommandParameterRegisterBusy ||
-	  !StatusRegister.HostAdapterReady ||
-	  !StatusRegister.InitializationRequired ||
-	  StatusRegister.DiagnosticActive ||
-	  StatusRegister.DiagnosticFailure)
+      if (StatusRegister.sr.CommandInvalid ||
+	  StatusRegister.sr.Reserved ||
+	  StatusRegister.sr.DataInRegisterReady ||
+	  StatusRegister.sr.CommandParameterRegisterBusy ||
+	  !StatusRegister.sr.HostAdapterReady ||
+	  !StatusRegister.sr.InitializationRequired ||
+	  StatusRegister.sr.DiagnosticActive ||
+	  StatusRegister.sr.DiagnosticFailure)
 	{
 	  BusLogic_SoftReset(HostAdapter);
 	  udelay(1000);
@@ -1333,11 +1333,11 @@
 		    HostAdapter->IO_Address, StatusRegister.All,
 		    InterruptRegister.All, GeometryRegister.All);
   if (StatusRegister.All == 0 ||
-      StatusRegister.DiagnosticActive ||
-      StatusRegister.CommandParameterRegisterBusy ||
-      StatusRegister.Reserved ||
-      StatusRegister.CommandInvalid ||
-      InterruptRegister.Reserved != 0)
+      StatusRegister.sr.DiagnosticActive ||
+      StatusRegister.sr.CommandParameterRegisterBusy ||
+      StatusRegister.sr.Reserved ||
+      StatusRegister.sr.CommandInvalid ||
+      InterruptRegister.ir.Reserved != 0)
     return false;
   /*
     Check the undocumented Geometry Register to test if there is an I/O port
@@ -1405,7 +1405,7 @@
   while (--TimeoutCounter >= 0)
     {
       StatusRegister.All = BusLogic_ReadStatusRegister(HostAdapter);
-      if (StatusRegister.DiagnosticActive) break;
+      if (StatusRegister.sr.DiagnosticActive) break;
       udelay(100);
     }
   if (BusLogic_GlobalOptions.TraceHardwareReset)
@@ -1426,7 +1426,7 @@
   while (--TimeoutCounter >= 0)
     {
       StatusRegister.All = BusLogic_ReadStatusRegister(HostAdapter);
-      if (!StatusRegister.DiagnosticActive) break;
+      if (!StatusRegister.sr.DiagnosticActive) break;
       udelay(100);
     }
   if (BusLogic_GlobalOptions.TraceHardwareReset)
@@ -1442,9 +1442,9 @@
   while (--TimeoutCounter >= 0)
     {
       StatusRegister.All = BusLogic_ReadStatusRegister(HostAdapter);
-      if (StatusRegister.DiagnosticFailure ||
-	  StatusRegister.HostAdapterReady ||
-	  StatusRegister.DataInRegisterReady)
+      if (StatusRegister.sr.DiagnosticFailure ||
+	  StatusRegister.sr.HostAdapterReady ||
+	  StatusRegister.sr.DataInRegisterReady)
 	break;
       udelay(100);
     }
@@ -1458,14 +1458,14 @@
     error occurred during the Host Adapter diagnostics.  If Data In Register
     Ready is set, then there is an Error Code available.
   */
-  if (StatusRegister.DiagnosticFailure ||
-      !StatusRegister.HostAdapterReady)
+  if (StatusRegister.sr.DiagnosticFailure ||
+      !StatusRegister.sr.HostAdapterReady)
     {
       BusLogic_CommandFailureReason = NULL;
       BusLogic_Failure(HostAdapter, "HARD RESET DIAGNOSTICS");
       BusLogic_Error("HOST ADAPTER STATUS REGISTER = %02X\n",
 		     HostAdapter, StatusRegister.All);
-      if (StatusRegister.DataInRegisterReady)
+      if (StatusRegister.sr.DataInRegisterReady)
 	{
 	  unsigned char ErrorCode = BusLogic_ReadDataInRegister(HostAdapter);
 	  BusLogic_Error("HOST ADAPTER ERROR CODE = %d\n",
@@ -1756,7 +1756,7 @@
   */
   GeometryRegister.All = BusLogic_ReadGeometryRegister(HostAdapter);
   HostAdapter->ExtendedTranslationEnabled =
-    GeometryRegister.ExtendedTranslationEnabled;
+    GeometryRegister.gr.ExtendedTranslationEnabled;
   /*
     Save the Scatter Gather Limits, Level Sensitive Interrupt flag, Wide
     SCSI flag, Differential SCSI flag, SCAM Supported flag, and
@@ -3184,7 +3184,7 @@
 	Read the Host Adapter Interrupt Register.
       */
       InterruptRegister.All = BusLogic_ReadInterruptRegister(HostAdapter);
-      if (InterruptRegister.InterruptValid)
+      if (InterruptRegister.ir.InterruptValid)
 	{
 	  /*
 	    Acknowledge the interrupt and reset the Host Adapter
@@ -3197,11 +3197,11 @@
 	    and Outgoing Mailbox Available Interrupts are ignored, as
 	    they are never enabled.
 	  */
-	  if (InterruptRegister.ExternalBusReset)
+	  if (InterruptRegister.ir.ExternalBusReset)
 	    HostAdapter->HostAdapterExternalReset = true;
-	  else if (InterruptRegister.IncomingMailboxLoaded)
+	  else if (InterruptRegister.ir.IncomingMailboxLoaded)
 	    BusLogic_ScanIncomingMailboxes(HostAdapter);
-	  else if (InterruptRegister.CommandComplete)
+	  else if (InterruptRegister.ir.CommandComplete)
 	    HostAdapter->HostAdapterCommandCompleted = true;
 	}
     }
diff -Nru a/drivers/scsi/BusLogic.h b/drivers/scsi/BusLogic.h
--- a/drivers/scsi/BusLogic.h	Mon Feb  9 05:22:57 2004
+++ b/drivers/scsi/BusLogic.h	Mon Feb  9 05:22:57 2004
@@ -344,7 +344,7 @@
     boolean InterruptReset:1;				/* Bit 5 */
     boolean SoftReset:1;				/* Bit 6 */
     boolean HardReset:1;				/* Bit 7 */
-  };
+  } cr;
 };
 
 /*
@@ -363,7 +363,7 @@
     boolean InitializationRequired:1;			/* Bit 5 */
     boolean DiagnosticFailure:1;			/* Bit 6 */
     boolean DiagnosticActive:1;				/* Bit 7 */
-  };
+  } sr;
 };
 
 /*
@@ -380,7 +380,7 @@
     boolean ExternalBusReset:1;				/* Bit 3 */
     unsigned char Reserved:3;				/* Bits 4-6 */
     boolean InterruptValid:1;				/* Bit 7 */
-  };
+  } ir;
 };
 
 /*
@@ -395,7 +395,7 @@
     enum BusLogic_BIOS_DiskGeometryTranslation Drive1Geometry:2;/* Bits 2-3 */
     unsigned char :3;						/* Bits 4-6 */
     boolean ExtendedTranslationEnabled:1;			/* Bit 7 */
-  };
+  } gr;
 };
 
 /*
@@ -1272,7 +1272,7 @@
 {
   union BusLogic_ControlRegister ControlRegister;
   ControlRegister.All = 0;
-  ControlRegister.SCSIBusReset = true;
+  ControlRegister.cr.SCSIBusReset = true;
   outb(ControlRegister.All,
        HostAdapter->IO_Address + BusLogic_ControlRegisterOffset);
 }
@@ -1281,7 +1281,7 @@
 {
   union BusLogic_ControlRegister ControlRegister;
   ControlRegister.All = 0;
-  ControlRegister.InterruptReset = true;
+  ControlRegister.cr.InterruptReset = true;
   outb(ControlRegister.All,
        HostAdapter->IO_Address + BusLogic_ControlRegisterOffset);
 }
@@ -1290,7 +1290,7 @@
 {
   union BusLogic_ControlRegister ControlRegister;
   ControlRegister.All = 0;
-  ControlRegister.SoftReset = true;
+  ControlRegister.cr.SoftReset = true;
   outb(ControlRegister.All,
        HostAdapter->IO_Address + BusLogic_ControlRegisterOffset);
 }
@@ -1299,7 +1299,7 @@
 {
   union BusLogic_ControlRegister ControlRegister;
   ControlRegister.All = 0;
-  ControlRegister.HardReset = true;
+  ControlRegister.cr.HardReset = true;
   outb(ControlRegister.All,
        HostAdapter->IO_Address + BusLogic_ControlRegisterOffset);
 }
