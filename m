Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVLHUg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVLHUg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVLHUg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:36:59 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:50594 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932308AbVLHUg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:36:57 -0500
Subject: Re: [ACPI] ACPI owner_id limit too low
From: Alex Williamson <alex.williamson@hp.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <4398963D.8040207@gmx.net>
References: <1134066095.32040.20.camel@tdi>  <4398963D.8040207@gmx.net>
Content-Type: text/plain
Organization: LOSL
Date: Thu, 08 Dec 2005 13:36:48 -0700
Message-Id: <1134074208.1907.6.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 21:23 +0100, Carl-Daniel Hailfinger wrote:

> > -	for (i = 0; i < 32; i++) {
> > -		if (!(acpi_gbl_owner_id_mask & (1 << i))) {
> > +	for (i = 0; i < 64; i++) {
> > +		if (!(acpi_gbl_owner_id_mask & (1UL << i))) {
> 
> Shouldn't this be 1ULL if you intend it to be 64 bit wide on a
> 32 bit arch?

   Yes, sorry I overlooked that.  Here's an updated patch.  Thanks,

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
+		if (!(acpi_gbl_owner_id_mask & (1ULL << i))) {
 			ACPI_DEBUG_PRINT((ACPI_DB_VALUES,
-					  "Current owner_id mask: %8.8X New ID: %2.2X\n",
+					  "Current owner_id mask: %16.16lX New ID: %2.2X\n",
 					  acpi_gbl_owner_id_mask,
 					  (unsigned int)(i + 1)));
 
-			acpi_gbl_owner_id_mask |= (1 << i);
+			acpi_gbl_owner_id_mask |= (1ULL << i);
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
+	if (acpi_gbl_owner_id_mask & (1ULL << owner_id)) {
+		acpi_gbl_owner_id_mask ^= (1ULL << owner_id);
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


