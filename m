Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVCLWcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVCLWcs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 17:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVCLWbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 17:31:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23059 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262045AbVCLW1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 17:27:21 -0500
Date: Sat, 12 Mar 2005 23:27:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: tom.l.nguyen@intel.com
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: [2.6 patch] drivers/pci/pci-acpi.c: possible cleanups
Message-ID: <20050312222720.GM3814@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- pci-acpi.c: make OSC_UUID static
- remove the following unused functions:
  - pci-acpi.c: acpi_query_osc
  - pci-acpi.c: pci_osc_support_set
- remove the following unneeded EXPORT_SYMBOL's:
  - pci-acpi.c: pci_osc_support_set

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/pci/pci-acpi.c   |   97 ---------------------------------------
 include/linux/pci-acpi.h |    2 
 2 files changed, 1 insertion(+), 98 deletions(-)

--- linux-2.6.11-rc3-mm2-full/include/linux/pci-acpi.h.old	2005-02-17 23:18:44.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/include/linux/pci-acpi.h	2005-02-17 23:18:54.000000000 +0100
@@ -48,14 +48,12 @@
 
 #ifdef CONFIG_ACPI
 extern acpi_status pci_osc_control_set(u32 flags);
-extern acpi_status pci_osc_support_set(u32 flags);
 #else
 #if !defined(acpi_status)
 typedef u32 		acpi_status;
 #define AE_ERROR      	(acpi_status) (0x0001)
 #endif    
 static inline acpi_status pci_osc_control_set(u32 flags) {return AE_ERROR;}
-static inline acpi_status pci_osc_support_set(u32 flags) {return AE_ERROR;} 
 #endif
 
 #endif	/* _PCI_ACPI_H_ */
--- linux-2.6.11-rc3-mm2-full/drivers/pci/pci-acpi.c.old	2005-02-17 23:17:28.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/pci/pci-acpi.c	2005-02-17 23:48:50.000000000 +0100
@@ -19,72 +19,7 @@
 
 static u32 ctrlset_buf[3] = {0, 0, 0};
 static u32 global_ctrlsets = 0;
-u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
-
-static acpi_status  
-acpi_query_osc (
-	acpi_handle	handle,
-	u32		level,
-	void		*context,
-	void		**retval )
-{
-	acpi_status		status;
-	struct acpi_object_list	input;
-	union acpi_object 	in_params[4];
-	struct acpi_buffer	output;
-	union acpi_object 	out_obj;	
-	u32			osc_dw0;
-
-	/* Setting up output buffer */
-	output.length = sizeof(out_obj) + 3*sizeof(u32);  
-	output.pointer = &out_obj;
-	
-	/* Setting up input parameters */
-	input.count = 4;
-	input.pointer = in_params;
-	in_params[0].type 		= ACPI_TYPE_BUFFER;
-	in_params[0].buffer.length 	= 16;
-	in_params[0].buffer.pointer	= OSC_UUID;
-	in_params[1].type 		= ACPI_TYPE_INTEGER;
-	in_params[1].integer.value 	= 1;
-	in_params[2].type 		= ACPI_TYPE_INTEGER;
-	in_params[2].integer.value	= 3;
-	in_params[3].type		= ACPI_TYPE_BUFFER;
-	in_params[3].buffer.length 	= 12;
-	in_params[3].buffer.pointer 	= (u8 *)context;
-
-	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
-	if (ACPI_FAILURE (status)) {
-		printk(KERN_DEBUG  
-			"Evaluate _OSC Set fails. Status = 0x%04x\n", status);
-		return status;
-	}
-	if (out_obj.type != ACPI_TYPE_BUFFER) {
-		printk(KERN_DEBUG  
-			"Evaluate _OSC returns wrong type\n");
-		return AE_TYPE;
-	}
-	osc_dw0 = *((u32 *) out_obj.buffer.pointer);
-	if (osc_dw0) {
-		if (osc_dw0 & OSC_REQUEST_ERROR)
-			printk(KERN_DEBUG "_OSC request fails\n"); 
-		if (osc_dw0 & OSC_INVALID_UUID_ERROR)
-			printk(KERN_DEBUG "_OSC invalid UUID\n"); 
-		if (osc_dw0 & OSC_INVALID_REVISION_ERROR)
-			printk(KERN_DEBUG "_OSC invalid revision\n"); 
-		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
-			/* Update Global Control Set */
-			global_ctrlsets = *((u32 *)(out_obj.buffer.pointer+8));
-			return AE_OK;
-		}
-		return AE_ERROR;
-	}
-
-	/* Update Global Control Set */
-	global_ctrlsets = *((u32 *)(out_obj.buffer.pointer + 8));
-	return AE_OK;
-}
-
+static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
 
 static acpi_status  
 acpi_run_osc (
@@ -147,36 +82,6 @@
 }
 
 /**
- * pci_osc_support_set - register OS support to Firmware
- * @flags: OS support bits
- *
- * Update OS support fields and doing a _OSC Query to obtain an update
- * from Firmware on supported control bits.
- **/
-acpi_status pci_osc_support_set(u32 flags)
-{
-	u32 temp;
-
-	if (!(flags & OSC_SUPPORT_MASKS)) {
-		return AE_TYPE;
-	}
-	ctrlset_buf[OSC_SUPPORT_TYPE] |= (flags & OSC_SUPPORT_MASKS);
-
-	/* do _OSC query for all possible controls */
-	temp = ctrlset_buf[OSC_CONTROL_TYPE];
-	ctrlset_buf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	ctrlset_buf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
-	acpi_get_devices ( PCI_ROOT_HID_STRING,
-			acpi_query_osc,
-			ctrlset_buf,
-			NULL );
-	ctrlset_buf[OSC_QUERY_TYPE] = !OSC_QUERY_ENABLE;
-	ctrlset_buf[OSC_CONTROL_TYPE] = temp;
-	return AE_OK;
-}
-EXPORT_SYMBOL(pci_osc_support_set);
-
-/**
  * pci_osc_control_set - commit requested control to Firmware
  * @flags: driver's requested control bits
  *
