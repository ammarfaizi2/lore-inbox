Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWDRVAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWDRVAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 17:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWDRVAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 17:00:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:27621 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932264AbWDRVAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 17:00:14 -0400
Subject: [PATCH] tpm: add HID module paramater
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 15:56:19 -0500
Message-Id: <1145393779.4829.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently found that not all BIOS manufacturers are using the specified
generic PNP id in their TPM ACPI table entry.  I have added the vendor
specific IDs that I know about and added a module parameter that a user
can specify another HID to the probe list if their device isn't being
found by the default list.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_tis.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc1/drivers/char/tpm/tpm_tis.c	2006-04-18 15:24:27.850777000 -0500
+++ linux-2.6.17-rc1-tpm/drivers/char/tpm/tpm_tis.c	2006-04-18 15:38:33.719640500 -0500
@@ -602,7 +610,13 @@ static int tpm_tis_pnp_resume(struct pnp
 
 static struct pnp_device_id tpm_pnp_tbl[] __devinitdata = {
 	{"PNP0C31", 0},		/* TPM */
-	{"", 0}
+	{"ATM1200", 0},		/* Atmel */
+	{"IFX0102", 0},		/* Infineon */
+	{"BCM0101", 0},		/* Broadcom */
+	{"NSC1200", 0},		/* National */
+	/* Add new here */
+	{"", 0},		/* User Specified */
+	{"", 0}			/* Terminator */
 };
 
 static struct pnp_driver tis_pnp_driver = {
@@ -613,6 +627,11 @@ static struct pnp_driver tis_pnp_driver 
 	.resume = tpm_tis_pnp_resume,
 };
 
+#define TIS_HID_USR_IDX sizeof(tpm_pnp_tbl)/sizeof(struct pnp_device_id) -2
+module_param_string(hid, tpm_pnp_tbl[TIS_HID_USR_IDX].id,
+		    sizeof(tpm_pnp_tbl[TIS_HID_USR_IDX].id), 0444);
+MODULE_PARM_DESC(hid, "Set additional specific HID for this driver to probe");
+
 static int __init init_tis(void)
 {
 	return pnp_register_driver(&tis_pnp_driver);


