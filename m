Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbTAOJsV>; Wed, 15 Jan 2003 04:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTAOJsV>; Wed, 15 Jan 2003 04:48:21 -0500
Received: from [195.78.204.43] ([195.78.204.43]:2184 "EHLO mail.rhx.it")
	by vger.kernel.org with ESMTP id <S266043AbTAOJsS>;
	Wed, 15 Jan 2003 04:48:18 -0500
Date: Wed, 15 Jan 2003 11:03:02 +0100
From: Sergio Visinoni <piffio@arklinux.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: acpi-devel@sourceforge.net, kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: ACPI patches updated (20030109)
Message-ID: <20030115110302.A18021@piffio.homelinux.org>
References: <F760B14C9561B941B89469F59BA3A84725A119@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A119@orsmsx401.jf.intel.com>; from andrew.grover@intel.com on ven, gen 10, 2003 at 10:38:03 -0800
X-Operating-System: Linux maniac 2.4.9-21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Grover, Andrew (andrew.grover@intel.com) wrote:
> Hi all,
> 
> ACPI patches based upon the 20030109 label have been released.
> http://sourceforge.net/projects/acpi . The non-Linux releases will be
> available at

Hi,
the attached patch fixes compilation for acpiphp with the latest
acpi patches.
Generated on a 2.4.20 tree (but it shoud apply correctly for 2.4.21-pre3 too).

Greetings,
Sergio Visinoni

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.20-acpiphp-fix.patch"

--- linux-2.4.20/drivers/hotplug/acpiphp_glue.c.ark	2003-01-14 19:32:33.000000000 +0100
+++ linux-2.4.20/drivers/hotplug/acpiphp_glue.c	2003-01-14 19:40:17.000000000 +0100
@@ -234,11 +234,11 @@
  * TBD: _TRA, etc.
  */
 static void
-decode_acpi_resource (acpi_resource *resource, struct acpiphp_bridge *bridge)
+decode_acpi_resource (struct acpi_resource *resource, struct acpiphp_bridge *bridge)
 {
-	acpi_resource_address16 *address16_data;
-	acpi_resource_address32 *address32_data;
-	acpi_resource_address64 *address64_data;
+	struct acpi_resource_address16 *address16_data;
+	struct acpi_resource_address32 *address32_data;
+	struct acpi_resource_address64 *address64_data;
 	struct pci_resource *res;
 
 	u32 resource_type, producer_consumer, address_length;
@@ -256,7 +256,7 @@
 
 		switch (resource->id) {
 		case ACPI_RSTYPE_ADDRESS16:
-			address16_data = (acpi_resource_address16 *)&resource->data;
+			address16_data = (struct acpi_resource_address16 *)&resource->data;
 			resource_type = address16_data->resource_type;
 			producer_consumer = address16_data->producer_consumer;
 			min_address_range = address16_data->min_address_range;
@@ -268,7 +268,7 @@
 			break;
 
 		case ACPI_RSTYPE_ADDRESS32:
-			address32_data = (acpi_resource_address32 *)&resource->data;
+			address32_data = (struct acpi_resource_address32 *)&resource->data;
 			resource_type = address32_data->resource_type;
 			producer_consumer = address32_data->producer_consumer;
 			min_address_range = address32_data->min_address_range;
@@ -280,7 +280,7 @@
 			break;
 
 		case ACPI_RSTYPE_ADDRESS64:
-			address64_data = (acpi_resource_address64 *)&resource->data;
+			address64_data = (struct acpi_resource_address64 *)&resource->data;
 			resource_type = address64_data->resource_type;
 			producer_consumer = address64_data->producer_consumer;
 			min_address_range = address64_data->min_address_range;
@@ -300,7 +300,7 @@
 			break;
 		}
 
-		resource = (acpi_resource *)((char*)resource + resource->length);
+		resource = (struct acpi_resource *)((char*)resource + resource->length);
 
 		if (found && producer_consumer == ACPI_PRODUCER && address_length > 0) {
 			switch (resource_type) {
@@ -397,9 +397,9 @@
 #if ACPI_CA_VERSION < 0x20020201
 	acpi_buffer buffer;
 #else
-	acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 #endif
-	acpi_object *package;
+	union acpi_object *package;
 	int i;
 
 	/* default numbers */
@@ -429,7 +429,7 @@
 		return;
 	}
 
-	package = (acpi_object *) buffer.pointer;
+	package = (union acpi_object *) buffer.pointer;
 
 	if (!package || package->type != ACPI_TYPE_PACKAGE ||
 	    package->package.count != 4 || !package->package.elements) {
@@ -503,7 +503,7 @@
 #if ACPI_CA_VERSION < 0x20020201
 	acpi_buffer buffer;
 #else
-	acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 #endif
 	struct acpiphp_bridge *bridge;
 
@@ -818,9 +818,9 @@
 find_host_bridge (acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
-	acpi_device_info info;
+	struct acpi_device_info info;
 	char objname[5];
-	acpi_buffer buffer = { sizeof(objname), objname };
+	struct acpi_buffer buffer = { sizeof(objname), objname };
 
 	status = acpi_get_object_info(handle, &info);
 	if (ACPI_FAILURE(status)) {
@@ -881,8 +881,8 @@
 	acpi_status status;
 	struct acpiphp_func *func;
 	struct list_head *l;
-	acpi_object_list arg_list;
-	acpi_object arg;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
 
 	int retval = 0;
 
@@ -1117,7 +1117,7 @@
 {
 	struct acpiphp_bridge *bridge;
 	char objname[64];
-	acpi_buffer buffer = { sizeof(objname), objname };
+	struct acpi_buffer buffer = { sizeof(objname), objname };
 
 	bridge = (struct acpiphp_bridge *)context;
 
@@ -1167,7 +1167,7 @@
 {
 	struct acpiphp_func *func;
 	char objname[64];
-	acpi_buffer buffer = { sizeof(objname), objname };
+	struct acpi_buffer buffer = { sizeof(objname), objname };
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 

--KsGdsel6WgEHnImy--
