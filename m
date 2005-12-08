Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVLHSVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVLHSVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 13:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVLHSVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 13:21:40 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:2222 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932166AbVLHSVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 13:21:40 -0500
Subject: ACPI owner_id limit too low
From: Alex Williamson <alex.williamson@hp.com>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Content-Type: text/plain
Organization: LOSL
Date: Thu, 08 Dec 2005 11:21:35 -0700
Message-Id: <1134066095.32040.20.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   We've found recently that it's not very hard to bump into the limit
of the number of owner_ids that the ACPI subsystem can provide.  This is
not because of leaks or complicated method execution, but simply because
our ACPI namespace is describing a complicated system and includes a
large number of SSDT tables.  We end up using far more than half the
owner_ids statically allocated for these tables.  The ACPI subsystem has
a limit of 256 ACPI tables, but we'd have a hard time getting within an
order of magnitude of that number and still have enough owner_ids
available for method execution.  I hear rumor that the next CA release
increases this limit, but given that the in kernel CA revision often
lags by several months, I'm wondering if we can bump up this limit in
the interim.  Doubling the limit to 64 is a sufficient short term fix
and a fairly trivial patch, maybe even something that could go in before
2.6.15.  Len, could we do something like the below patch to give us a
little more reasonable limit?  We could switch to a bitmap too, but
given how close the next kernel is to release this is less impact.
Thanks,

	Alex


Signed-off-by: Alex Williamson <alex.williamson@hp.com>
---

diff -r 03055821672a drivers/acpi/utilities/utmisc.c
--- a/drivers/acpi/utilities/utmisc.c	Mon Dec  5 01:00:10 2005
+++ b/drivers/acpi/utilities/utmisc.c	Wed Dec  7 14:55:58 2005
@@ -84,14 +84,14 @@
 
 	/* Find a free owner ID */
 
-	for (i = 0; i < 32; i++) {
-		if (!(acpi_gbl_owner_id_mask & (1 << i))) {
+	for (i = 0; i < 64; i++) {
+		if (!(acpi_gbl_owner_id_mask & (1UL << i))) {
 			ACPI_DEBUG_PRINT((ACPI_DB_VALUES,
-					  "Current owner_id mask: %8.8X New ID: %2.2X\n",
+					  "Current owner_id mask: %16.16lX New ID: %2.2X\n",
 					  acpi_gbl_owner_id_mask,
 					  (unsigned int)(i + 1)));
 
-			acpi_gbl_owner_id_mask |= (1 << i);
+			acpi_gbl_owner_id_mask |= (1UL << i);
 			*owner_id = (acpi_owner_id) (i + 1);
 			goto exit;
 		}
@@ -106,7 +106,7 @@
 	 */
 	*owner_id = 0;
 	status = AE_OWNER_ID_LIMIT;
-	ACPI_REPORT_ERROR(("Could not allocate new owner_id (32 max), AE_OWNER_ID_LIMIT\n"));
+	ACPI_REPORT_ERROR(("Could not allocate new owner_id (64 max), AE_OWNER_ID_LIMIT\n"));
 
       exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
@@ -123,7 +123,7 @@
  *              control method or unloading a table. Either way, we would
  *              ignore any error anyway.
  *
- * DESCRIPTION: Release a table or method owner ID.  Valid IDs are 1 - 32
+ * DESCRIPTION: Release a table or method owner ID.  Valid IDs are 1 - 64
  *
  ******************************************************************************/
 
@@ -140,7 +140,7 @@
 
 	/* Zero is not a valid owner_iD */
 
-	if ((owner_id == 0) || (owner_id > 32)) {
+	if ((owner_id == 0) || (owner_id > 64)) {
 		ACPI_REPORT_ERROR(("Invalid owner_id: %2.2X\n", owner_id));
 		return_VOID;
 	}
@@ -158,8 +158,8 @@
 
 	/* Free the owner ID only if it is valid */
 
-	if (acpi_gbl_owner_id_mask & (1 << owner_id)) {
-		acpi_gbl_owner_id_mask ^= (1 << owner_id);
+	if (acpi_gbl_owner_id_mask & (1UL << owner_id)) {
+		acpi_gbl_owner_id_mask ^= (1UL << owner_id);
 	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
diff -r 03055821672a include/acpi/acglobal.h
--- a/include/acpi/acglobal.h	Mon Dec  5 01:00:10 2005
+++ b/include/acpi/acglobal.h	Wed Dec  7 14:55:58 2005
@@ -211,7 +211,7 @@
 ACPI_EXTERN u32 acpi_gbl_rsdp_original_location;
 ACPI_EXTERN u32 acpi_gbl_ns_lookup_count;
 ACPI_EXTERN u32 acpi_gbl_ps_find_count;
-ACPI_EXTERN u32 acpi_gbl_owner_id_mask;
+ACPI_EXTERN u64 acpi_gbl_owner_id_mask;
 ACPI_EXTERN u16 acpi_gbl_pm1_enable_register_save;
 ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
 ACPI_EXTERN u8 acpi_gbl_debugger_configuration;


