Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbTBKV4E>; Tue, 11 Feb 2003 16:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTBKV4E>; Tue, 11 Feb 2003 16:56:04 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:18654 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id <S266320AbTBKVzx>;
	Tue, 11 Feb 2003 16:55:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Subject: [PATCH] 2/3 ACPI resource handling
Date: Tue, 11 Feb 2003 14:59:35 -0700
User-Agent: KMail/1.4.3
Cc: t-kochi@bq.jp.nec.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200302111459.35380.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that this contains a couple structure copies; don't know your
philosophy on those.

Bjorn


diff -ur acpi-2/drivers/acpi/resources/rsxface.c acpi-3/drivers/acpi/resources/rsxface.c
--- acpi-2/drivers/acpi/resources/rsxface.c	2003-02-09 22:13:47.000000000 -0700
+++ acpi-3/drivers/acpi/resources/rsxface.c	2003-02-09 22:13:52.000000000 -0700
@@ -316,3 +316,65 @@
 	status = acpi_rs_set_srs_method_data (device_handle, in_buffer);
 	return_ACPI_STATUS (status);
 }
+
+
+#define copy_field(out, in, field)	out->field = in->field
+#define copy_address(out, in)					\
+	copy_field(out, in, resource_type);			\
+	copy_field(out, in, producer_consumer);			\
+	copy_field(out, in, decode);				\
+	copy_field(out, in, min_address_fixed);			\
+	copy_field(out, in, max_address_fixed);			\
+	copy_field(out, in, attribute);				\
+	copy_field(out, in, granularity);			\
+	copy_field(out, in, min_address_range);			\
+	copy_field(out, in, max_address_range);			\
+	copy_field(out, in, address_translation_offset);	\
+	copy_field(out, in, address_length);			\
+	copy_field(out, in, resource_source);
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_resource_to_address64
+ *
+ * PARAMETERS:  resource                - Pointer to a resource
+ *              out                     - Pointer to the users's return 
+ *                                        buffer (a struct
+ *                                        acpi_resource_address64)
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: If the resource is an address16, address32, or address64,
+ *              copy it to the address64 return buffer.  This saves the
+ *              caller from having to duplicate code for different-sized
+ *              addresses.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_resource_to_address64 (
+	struct acpi_resource            *resource,
+	struct acpi_resource_address64  *out)
+{
+	struct acpi_resource_address16  *address16;
+	struct acpi_resource_address32  *address32;
+	struct acpi_resource_address64  *address64;
+
+	switch (resource->id) {
+		case ACPI_RSTYPE_ADDRESS16:
+			address16 = (struct acpi_resource_address16 *) &resource->data;
+			copy_address(out, address16);
+			break;
+		case ACPI_RSTYPE_ADDRESS32:
+			address32 = (struct acpi_resource_address32 *) &resource->data;
+			copy_address(out, address32);
+			break;
+		case ACPI_RSTYPE_ADDRESS64:
+			address64 = (struct acpi_resource_address64 *) &resource->data;
+			copy_address(out, address64);
+			break;
+		default:
+			return (AE_BAD_PARAMETER);
+	}
+	return (AE_OK);
+}
diff -ur acpi-2/include/acpi/acpixf.h acpi-3/include/acpi/acpixf.h
--- acpi-2/include/acpi/acpixf.h	2003-02-09 22:13:47.000000000 -0700
+++ acpi-3/include/acpi/acpixf.h	2003-02-09 22:13:52.000000000 -0700
@@ -352,6 +352,11 @@
 	acpi_handle                     bus_device_handle,
 	struct acpi_buffer              *ret_buffer);
 
+acpi_status
+acpi_resource_to_address64 (
+	struct acpi_resource            *resource,
+	struct acpi_resource_address64  *out);
+
 
 /*
  * Hardware (ACPI device) interfaces

