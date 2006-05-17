Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWEQSER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWEQSER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWEQSEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:04:16 -0400
Received: from mga03.intel.com ([143.182.124.21]:27516 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750818AbWEQSEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:04:16 -0400
X-IronPort-AV: i="4.05,138,1146466800"; 
   d="scan'208"; a="37862777:sNHT3426660692"
Subject: [patch] pci: correctly allocate return buffers for osc calls
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 11:13:37 -0700
Message-Id: <1147889618.8472.6.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 17 May 2006 18:02:48.0012 (UTC) FILETIME=[1B0B28C0:01C679DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The OSC set and query functions do not allocate enough space for return values,
and set the output buffer length to a false, too large value.  This causes the 
acpi-ca code to assume that the output buffer is larger than it actually is, 
and overwrite memory when copying acpi return buffers into this caller provided
buffer.  In some cases this can cause kernel oops if the memory that is 
overwritten is a pointer.  This patch will change these calls to use a 
dynamically allocated output buffer, thus allowing the acpi-ca code to decide 
how much space is needed.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/pci/pci-acpi.c |   60 ++++++++++++++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 25 deletions(-)

--- 2.6-git.orig/drivers/pci/pci-acpi.c
+++ 2.6-git/drivers/pci/pci-acpi.c
@@ -33,13 +33,10 @@ acpi_query_osc (
 	acpi_status		status;
 	struct acpi_object_list	input;
 	union acpi_object 	in_params[4];
-	struct acpi_buffer	output;
-	union acpi_object 	out_obj;	
+	struct acpi_buffer	output = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object 	*out_obj;
 	u32			osc_dw0;
 
-	/* Setting up output buffer */
-	output.length = sizeof(out_obj) + 3*sizeof(u32);  
-	output.pointer = &out_obj;
 	
 	/* Setting up input parameters */
 	input.count = 4;
@@ -61,12 +58,15 @@ acpi_query_osc (
 			"Evaluate _OSC Set fails. Status = 0x%04x\n", status);
 		return status;
 	}
-	if (out_obj.type != ACPI_TYPE_BUFFER) {
+	out_obj = output.pointer;
+
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
 		printk(KERN_DEBUG  
 			"Evaluate _OSC returns wrong type\n");
-		return AE_TYPE;
+		status = AE_TYPE;
+		goto query_osc_out;
 	}
-	osc_dw0 = *((u32 *) out_obj.buffer.pointer);
+	osc_dw0 = *((u32 *) out_obj->buffer.pointer);
 	if (osc_dw0) {
 		if (osc_dw0 & OSC_REQUEST_ERROR)
 			printk(KERN_DEBUG "_OSC request fails\n"); 
@@ -76,15 +76,21 @@ acpi_query_osc (
 			printk(KERN_DEBUG "_OSC invalid revision\n"); 
 		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
 			/* Update Global Control Set */
-			global_ctrlsets = *((u32 *)(out_obj.buffer.pointer+8));
-			return AE_OK;
+			global_ctrlsets = *((u32 *)(out_obj->buffer.pointer+8));
+			status = AE_OK;
+			goto query_osc_out;
 		}
-		return AE_ERROR;
+		status = AE_ERROR;
+		goto query_osc_out;
 	}
 
 	/* Update Global Control Set */
-	global_ctrlsets = *((u32 *)(out_obj.buffer.pointer + 8));
-	return AE_OK;
+	global_ctrlsets = *((u32 *)(out_obj->buffer.pointer + 8));
+	status = AE_OK;
+
+query_osc_out:
+	kfree(output.pointer);
+	return status;
 }
 
 
@@ -96,14 +102,10 @@ acpi_run_osc (
 	acpi_status		status;
 	struct acpi_object_list	input;
 	union acpi_object 	in_params[4];
-	struct acpi_buffer	output;
-	union acpi_object 	out_obj;	
+	struct acpi_buffer	output = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object 	*out_obj;
 	u32			osc_dw0;
 
-	/* Setting up output buffer */
-	output.length = sizeof(out_obj) + 3*sizeof(u32);  
-	output.pointer = &out_obj;
-	
 	/* Setting up input parameters */
 	input.count = 4;
 	input.pointer = in_params;
@@ -124,12 +126,14 @@ acpi_run_osc (
 			"Evaluate _OSC Set fails. Status = 0x%04x\n", status);
 		return status;
 	}
-	if (out_obj.type != ACPI_TYPE_BUFFER) {
+	out_obj = output.pointer;
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
 		printk(KERN_DEBUG  
 			"Evaluate _OSC returns wrong type\n");
-		return AE_TYPE;
+		status = AE_TYPE;
+		goto run_osc_out;
 	}
-	osc_dw0 = *((u32 *) out_obj.buffer.pointer);
+	osc_dw0 = *((u32 *) out_obj->buffer.pointer);
 	if (osc_dw0) {
 		if (osc_dw0 & OSC_REQUEST_ERROR)
 			printk(KERN_DEBUG "_OSC request fails\n"); 
@@ -139,11 +143,17 @@ acpi_run_osc (
 			printk(KERN_DEBUG "_OSC invalid revision\n"); 
 		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
 			printk(KERN_DEBUG "_OSC FW not grant req. control\n");
-			return AE_SUPPORT;
+			status = AE_SUPPORT;
+			goto run_osc_out;
 		}
-		return AE_ERROR;
+		status = AE_ERROR;
+		goto run_osc_out;
 	}
-	return AE_OK;
+	status = AE_OK;
+
+run_osc_out:
+	kfree(output.pointer);
+	return status;
 }
 
 /**
