Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030686AbWKOQkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030686AbWKOQkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030685AbWKOQkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:40:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46015 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030680AbWKOQkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:40:15 -0500
From: John Keller <jpk@sgi.com>
To: linux-acpi@vger.kernel.org
Cc: akpm@osdl.org, len.brown@intel.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       gregkh@suse.de, linux-kernel@vger.kernel.org, ayoung@sgi.com,
       jes@sgi.com, John Keller <jpk@sgi.com>
Date: Wed, 15 Nov 2006 10:40:06 -0600
Message-Id: <20061115164006.1640.3310.sendpatchset@attica.americas.sgi.com>
Subject: [PATCH 3/3: Resend
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 This patch makes acpi_load_table() available
 for use by removing it from the #ifdef ACPI_FUTURE_USAGE.

 It also adds a new routine used to unload an ACPI table
 of a given type and "id" - acpi_unload_table_id().
 The implementation of this new routine was almost a direct
 copy of existing routine acpi_unload_table() - only difference
 being that it only removes a specific table id instead of
 ALL tables of a given type.
 The SN hotplug driver (sgi_hotplug.c) now uses both of these
 interfaces to dynamically load and unload SSDT ACPI tables.

 Also, a few other ACPI routines now used by the SN hotplug
 driver are exported (since the driver can be a loadable module):

 acpi_ns_map_handle_to_node
 acpi_ns_convert_entry_to_handle
 acpi_ns_get_next_node

Signed-off-by: Aaron Young <ayoung@sgi.com>

---

Resend #1
    Original send of this patch was outdated and did not have
    acpi_ut_acquire_mutex() and acpi_ut_release_mutex() calls
    in acpi_unload_table_id().

 drivers/acpi/namespace/nsutils.c |    4 ++
 drivers/acpi/namespace/nswalk.c  |    2 +
 drivers/acpi/tables/tbxface.c    |   54 ++++++++++++++++++++++++++++-
 include/acpi/acpixf.h            |    5 +-
 4 files changed, 62 insertions(+), 3 deletions(-)


Index: linux-2.6/drivers/acpi/namespace/nsutils.c
===================================================================
--- linux-2.6.orig/drivers/acpi/namespace/nsutils.c	2006-11-15 08:18:27.587345652 -0600
+++ linux-2.6/drivers/acpi/namespace/nsutils.c	2006-11-15 08:33:26.129843027 -0600
@@ -701,6 +701,8 @@ struct acpi_namespace_node *acpi_ns_map_
 	return (ACPI_CAST_PTR(struct acpi_namespace_node, handle));
 }
 
+ACPI_EXPORT_SYMBOL(acpi_ns_map_handle_to_node)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_convert_entry_to_handle
@@ -737,6 +739,8 @@ acpi_handle acpi_ns_convert_entry_to_han
 ------------------------------------------------------*/
 }
 
+ACPI_EXPORT_SYMBOL(acpi_ns_convert_entry_to_handle)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_terminate
Index: linux-2.6/drivers/acpi/namespace/nswalk.c
===================================================================
--- linux-2.6.orig/drivers/acpi/namespace/nswalk.c	2006-11-15 08:18:27.587345652 -0600
+++ linux-2.6/drivers/acpi/namespace/nswalk.c	2006-11-15 08:33:26.141845016 -0600
@@ -119,6 +119,8 @@ struct acpi_namespace_node *acpi_ns_get_
 	return (NULL);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_ns_get_next_node)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_walk_namespace
Index: linux-2.6/drivers/acpi/tables/tbxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables/tbxface.c	2006-11-15 08:18:27.635354917 -0600
+++ linux-2.6/drivers/acpi/tables/tbxface.c	2006-11-15 09:54:54.715023969 -0600
@@ -123,7 +123,6 @@ acpi_status acpi_load_tables(void)
 
 ACPI_EXPORT_SYMBOL(acpi_load_tables)
 
-#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_load_table
@@ -221,6 +220,59 @@ ACPI_EXPORT_SYMBOL(acpi_load_table)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_unload_table_id
+ *
+ * PARAMETERS:  table_type    - Type of table to be unloaded
+ *              id            - Owner ID of the table to be removed.
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This routine is used to force the unload of a table (by id)
+ *
+ ******************************************************************************/
+acpi_status acpi_unload_table_id(acpi_table_type table_type, acpi_owner_id id)
+{
+	struct acpi_table_desc *table_desc;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_unload_table);
+
+	/* Parameter validation */
+	if (table_type > ACPI_TABLE_ID_MAX)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
+	/* Find table from the requested type list */
+	table_desc = acpi_gbl_table_lists[table_type].next;
+	while (table_desc && table_desc->owner_id != id)
+		table_desc = table_desc->next;
+
+	if (!table_desc)
+		return_ACPI_STATUS(AE_NOT_EXIST);
+
+	/*
+	 * Delete all namespace objects owned by this table. Note that these
+	 * objects can appear anywhere in the namespace by virtue of the AML
+	 * "Scope" operator. Thus, we need to track ownership by an ID, not
+	 * simply a position within the hierarchy
+	 */
+	acpi_ns_delete_namespace_by_owner(table_desc->owner_id);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
+
+	(void)acpi_tb_uninstall_table(table_desc);
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_unload_table_id)
+
+#ifdef ACPI_FUTURE_USAGE
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_unload_table
  *
  * PARAMETERS:  table_type    - Type of table to be unloaded
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h	2006-11-15 08:18:33.708526941 -0600
+++ linux-2.6/include/acpi/acpixf.h	2006-11-15 08:33:26.197854296 -0600
@@ -97,11 +97,12 @@ acpi_find_root_pointer(u32 flags, struct
 
 acpi_status acpi_load_tables(void);
 
-#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_load_table(struct acpi_table_header *table_ptr);
 
-acpi_status acpi_unload_table(acpi_table_type table_type);
+acpi_status acpi_unload_table_id(acpi_table_type table_type, acpi_owner_id id);
 
+#ifdef ACPI_FUTURE_USAGE
+acpi_status acpi_unload_table(acpi_table_type table_type);
 acpi_status
 acpi_get_table_header(acpi_table_type table_type,
 		      u32 instance, struct acpi_table_header *out_table_header);
