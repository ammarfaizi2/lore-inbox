Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWEQWQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWEQWQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWEQWQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:16:08 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47491 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751251AbWEQWMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:09 -0400
Message-Id: <20060517221407.149238000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:12 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Kristen Accardi <kristen.c.accardi@intel.com>, greg@kroah.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/22] PCI: correctly allocate return buffers for osc calls
Content-Disposition: inline; filename=pci-correctly-allocate-return-buffers-for-osc-calls.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

The OSC set and query functions do not allocate enough space for return values,
and set the output buffer length to a false, too large value.  This causes the 
acpi-ca code to assume that the output buffer is larger than it actually is, 
and overwrite memory when copying acpi return buffers into this caller provided
buffer.  In some cases this can cause kernel oops if the memory that is 
overwritten is a pointer.  This patch will change these calls to use a 
dynamically allocated output buffer, thus allowing the acpi-ca code to decide 
how much space is needed.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/pci/pci-acpi.c |   60 ++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

--- linux-2.6.16.16.orig/drivers/pci/pci-acpi.c
+++ linux-2.6.16.16/drivers/pci/pci-acpi.c
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

--
