Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTBKV5M>; Tue, 11 Feb 2003 16:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTBKV4R>; Tue, 11 Feb 2003 16:56:17 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:20446 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id <S266356AbTBKVzy>;
	Tue, 11 Feb 2003 16:55:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
Subject: [PATCH] 1/3 ACPI resource handling
Date: Tue, 11 Feb 2003 14:58:09 -0700
User-Agent: KMail/1.4.3
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: t-kochi@bq.jp.nec.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302111458.09832.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches against acpi-20030123-2.5.59.diff.gz make it more
convenient to handle ACPI resources and reduce code duplication.

The changes fall into three pieces:

    1) Addition of acpi_walk_resources(), which calls a callback for
       each resource in _CRS or _PRS.  This is handy because you don't
       have to allocate/free buffers, loop over resource lists, or
       make assumptions about the order in which resources appear.

    2) Addition of acpi_resource_to_address64(), which copies
       address16, address32, or address64 resources to an address64
       structure, so you don't have to maintain three sets of code
       that differ only in the size of the address they deal with.

    3) Changes to the EC, PCI link, and ACPI PCI hot-plug drivers to
       use acpi_walk_resources() instead of acpi_get_current_resources().

So far this is just "cleanup" in the sense that there's no new
functionality.  As soon as any issues with these patches are
worked out, I have additional patches that build on them to
add ia64 support for multiple I/O port spaces.

Bjorn


diff -ur acpi-1/drivers/acpi/acpi_ksyms.c acpi-2/drivers/acpi/acpi_ksyms.c
--- acpi-1/drivers/acpi/acpi_ksyms.c	2003-02-06 14:48:20.000000000 -0700
+++ acpi-2/drivers/acpi/acpi_ksyms.c	2003-02-09 22:13:47.000000000 -0700
@@ -76,6 +76,7 @@
 EXPORT_SYMBOL(acpi_release_global_lock);
 EXPORT_SYMBOL(acpi_get_current_resources);
 EXPORT_SYMBOL(acpi_get_possible_resources);
+EXPORT_SYMBOL(acpi_walk_resources);
 EXPORT_SYMBOL(acpi_set_current_resources);
 EXPORT_SYMBOL(acpi_enable_event);
 EXPORT_SYMBOL(acpi_disable_event);
diff -ur acpi-1/drivers/acpi/resources/rsutils.c acpi-2/drivers/acpi/resources/rsutils.c
--- acpi-1/drivers/acpi/resources/rsutils.c	2003-01-16 19:21:38.000000000 -0700
+++ acpi-2/drivers/acpi/resources/rsutils.c	2003-02-09 22:13:47.000000000 -0700
@@ -195,6 +195,61 @@
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_rs_get_method_data
+ *
+ * PARAMETERS:  Handle          - a handle to the containing object
+ *              ret_buffer      - a pointer to a buffer structure for the
+ *                                  results
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function is called to get the _CRS or _PRS value of an
+ *              object contained in an object specified by the handle passed in
+ *
+ *              If the function fails an appropriate status will be returned
+ *              and the contents of the callers buffer is undefined.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_rs_get_method_data (
+	acpi_handle                     handle,
+	char                            *path,
+	struct acpi_buffer              *ret_buffer)
+{
+	union acpi_operand_object       *obj_desc;
+	acpi_status                     status;
+
+
+	ACPI_FUNCTION_TRACE ("rs_get_method_data");
+
+
+	/* Parameters guaranteed valid by caller */
+
+	/*
+	 * Execute the method, no parameters
+	 */
+	status = acpi_ut_evaluate_object (handle, path, ACPI_BTYPE_BUFFER, &obj_desc);
+	if (ACPI_FAILURE (status)) {
+		return_ACPI_STATUS (status);
+	}
+
+	/*
+	 * Make the call to create a resource linked list from the
+	 * byte stream buffer that comes back from the method
+	 * execution.
+	 */
+	status = acpi_rs_create_resource_list (obj_desc, ret_buffer);
+
+	/* on exit, we must delete the object returned by evaluate_object */
+
+	acpi_ut_remove_reference (obj_desc);
+	return_ACPI_STATUS (status);
+}
+
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_rs_set_srs_method_data
  *
  * PARAMETERS:  Handle          - a handle to the containing object
diff -ur acpi-1/drivers/acpi/resources/rsxface.c acpi-2/drivers/acpi/resources/rsxface.c
--- acpi-1/drivers/acpi/resources/rsxface.c	2003-01-16 19:22:23.000000000 -0700
+++ acpi-2/drivers/acpi/resources/rsxface.c	2003-02-09 22:13:47.000000000 -0700
@@ -193,6 +193,89 @@
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_walk_resources
+ *
+ * PARAMETERS:  device_handle   - a handle to the device object for the
+ *                                device we are querying
+ *              path            - method name of the resources we want
+ *                                (METHOD_NAME__CRS or METHOD_NAME__PRS)
+ *              user_function   - called for each resource
+ *              context         - passed to user_function
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Retrieves the current or possible resource list for the
+ *              specified device.  The user_function is called once for
+ *              each resource in the list.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_walk_resources (
+	acpi_handle                     device_handle,
+	char                            *path,
+	acpi_walk_resource_callback     user_function,
+	void                            *context)
+{
+	acpi_status                     status;
+	struct acpi_buffer		buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_resource		*resource;
+
+	ACPI_FUNCTION_TRACE ("acpi_walk_resources");
+
+
+	if (!device_handle ||
+	    (ACPI_STRNCMP (path, METHOD_NAME__CRS, sizeof (METHOD_NAME__CRS)) &&
+	     ACPI_STRNCMP (path, METHOD_NAME__PRS, sizeof (METHOD_NAME__PRS)))) {
+		return_ACPI_STATUS (AE_BAD_PARAMETER);
+	}
+
+	status = acpi_rs_get_method_data (device_handle, path, &buffer);
+	if (ACPI_FAILURE (status)) {
+		return_ACPI_STATUS (status);
+	}
+
+	resource = (struct acpi_resource *) buffer.pointer;
+	for (;;) {
+		if (!resource || resource->id == ACPI_RSTYPE_END_TAG)
+			break;
+
+		status = user_function (resource, context);
+
+		switch (status) {
+		case AE_OK:
+		case AE_CTRL_DEPTH:
+
+			/* Just keep going */
+			status = AE_OK;
+			break;
+
+		case AE_CTRL_TERMINATE:
+
+			/* Exit now, with OK stats */
+
+			status = AE_OK;
+			goto end;
+
+		default:
+
+			/* All others are valid exceptions */
+
+			goto end;
+		}
+
+		resource = ACPI_NEXT_RESOURCE (resource);
+	}
+
+end:
+	acpi_os_free (buffer.pointer);
+
+	return_ACPI_STATUS (status);
+}
+
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_set_current_resources
  *
  * PARAMETERS:  device_handle   - a handle to the device object for the
diff -ur acpi-1/include/acpi/acpixf.h acpi-2/include/acpi/acpixf.h
--- acpi-1/include/acpi/acpixf.h	2003-02-06 14:48:20.000000000 -0700
+++ acpi-2/include/acpi/acpixf.h	2003-02-09 22:13:47.000000000 -0700
@@ -320,6 +320,11 @@
  * Resource interfaces
  */
 
+typedef
+acpi_status (*acpi_walk_resource_callback) (
+	struct acpi_resource            *resource,
+	void                            *context);
+
 acpi_status
 acpi_get_current_resources(
 	acpi_handle                     device_handle,
@@ -331,6 +336,13 @@
 	struct acpi_buffer              *ret_buffer);
 
 acpi_status
+acpi_walk_resources (
+	acpi_handle                     device_handle,
+	char                            *path,
+	acpi_walk_resource_callback     user_function,
+	void                            *context);
+
+acpi_status
 acpi_set_current_resources (
 	acpi_handle                     device_handle,
 	struct acpi_buffer              *in_buffer);
diff -ur acpi-1/include/acpi/acresrc.h acpi-2/include/acpi/acresrc.h
--- acpi-1/include/acpi/acresrc.h	2003-02-06 14:48:20.000000000 -0700
+++ acpi-2/include/acpi/acresrc.h	2003-02-09 22:13:47.000000000 -0700
@@ -47,6 +47,12 @@
 	struct acpi_buffer              *ret_buffer);
 
 acpi_status
+acpi_rs_get_method_data (
+	acpi_handle                     handle,
+	char                            *path,
+	struct acpi_buffer              *ret_buffer);
+
+acpi_status
 acpi_rs_set_srs_method_data (
 	acpi_handle                     handle,
 	struct acpi_buffer              *ret_buffer);
diff -ur acpi-1/include/acpi/acutils.h acpi-2/include/acpi/acutils.h
--- acpi-1/include/acpi/acutils.h	2003-02-06 14:48:20.000000000 -0700
+++ acpi-2/include/acpi/acutils.h	2003-02-09 22:13:47.000000000 -0700
@@ -444,6 +444,8 @@
 #define METHOD_NAME__SEG        "_SEG"
 #define METHOD_NAME__BBN        "_BBN"
 #define METHOD_NAME__PRT        "_PRT"
+#define METHOD_NAME__CRS        "_CRS"
+#define METHOD_NAME__PRS        "_PRS"
 
 
 acpi_status

