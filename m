Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTLDQCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLDQCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:02:43 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:20996 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262679AbTLDQCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:02:39 -0500
Subject: [RFC] enhanced psxface.c error handling
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: acpi-devel@lists.sourceforge.net
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-HZIZJ8eznrNoAVGDmQ4T"
Message-Id: <1070553752.14488.4.camel@glass.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 04 Dec 2003 17:02:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HZIZJ8eznrNoAVGDmQ4T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

This patch tries to fix the situation where an error could cause
acpi_psx_execute() to exit without releasing held references to the
elements of param[].

Thanks!

--=-HZIZJ8eznrNoAVGDmQ4T
Content-Disposition: attachment; filename=acpi.patch
Content-Type: text/x-patch; name=acpi.patch; charset=
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.0-test11.orig/drivers/acpi/parser/psxface.c linux-2.6.0-test11/drivers/acpi/parser/psxface.c
--- linux-2.6.0-test11.orig/drivers/acpi/parser/psxface.c	2003-11-26 21:45:20.000000000 +0100
+++ linux-2.6.0-test11/drivers/acpi/parser/psxface.c	2003-12-01 09:23:18.591462114 +0100
@@ -127,7 +127,8 @@
 
 	op = acpi_ps_create_scope_op ();
 	if (!op) {
-		return_ACPI_STATUS (AE_NO_MEMORY);
+		status = AE_NO_MEMORY;
+		goto acpi_psx_parse_unref;
 	}
 
 	/*
@@ -142,14 +143,15 @@
 	walk_state = acpi_ds_create_walk_state (obj_desc->method.owning_id,
 			   NULL, NULL, NULL);
 	if (!walk_state) {
-		return_ACPI_STATUS (AE_NO_MEMORY);
+		goto acpi_psx_parse_unref;
+		status = AE_NO_MEMORY;
 	}
 
 	status = acpi_ds_init_aml_walk (walk_state, op, method_node, obj_desc->method.aml_start,
 			  obj_desc->method.aml_length, NULL, NULL, 1);
 	if (ACPI_FAILURE (status)) {
 		acpi_ds_delete_walk_state (walk_state);
-		return_ACPI_STATUS (status);
+		goto acpi_psx_parse_unref;
 	}
 
 	/* Parse the AML */
@@ -168,7 +170,8 @@
 
 	op = acpi_ps_create_scope_op ();
 	if (!op) {
-		return_ACPI_STATUS (AE_NO_MEMORY);
+		status = AE_NO_MEMORY;
+		goto acpi_psx_parse_unref;
 	}
 
 	/* Init new op with the method name and pointer back to the NS node */
@@ -180,14 +183,15 @@
 
 	walk_state = acpi_ds_create_walk_state (0, NULL, NULL, NULL);
 	if (!walk_state) {
-		return_ACPI_STATUS (AE_NO_MEMORY);
+		status = AE_NO_MEMORY;
+		goto acpi_psx_parse_unref;
 	}
 
 	status = acpi_ds_init_aml_walk (walk_state, op, method_node, obj_desc->method.aml_start,
 			  obj_desc->method.aml_length, params, return_obj_desc, 3);
 	if (ACPI_FAILURE (status)) {
 		acpi_ds_delete_walk_state (walk_state);
-		return_ACPI_STATUS (status);
+		goto acpi_psx_parse_unref;
 	}
 
 	/*
@@ -196,16 +200,6 @@
 	status = acpi_ps_parse_aml (walk_state);
 	acpi_ps_delete_parse_tree (op);
 
-	if (params) {
-		/* Take away the extra reference that we gave the parameters above */
-
-		for (i = 0; params[i]; i++) {
-			/* Ignore errors, just do them all */
-
-			(void) acpi_ut_update_object_reference (params[i], REF_DECREMENT);
-		}
-	}
-
 	/*
 	 * If the method has returned an object, signal this to the caller with
 	 * a control exception code
@@ -218,6 +212,18 @@
 		status = AE_CTRL_RETURN_VALUE;
 	}
 
+acpi_psx_parse_unref:
+
+	if (params) {
+		/* Take away the extra reference that we gave the parameters above */
+
+		for (i = 0; params[i]; i++) {
+			/* Ignore errors, just do them all */
+
+			(void) acpi_ut_update_object_reference (params[i], REF_DECREMENT);
+		}
+	}
+
 	return_ACPI_STATUS (status);
 }

--=-HZIZJ8eznrNoAVGDmQ4T--

