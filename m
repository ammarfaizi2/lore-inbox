Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVLVRmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVLVRmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbVLVRmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:42:31 -0500
Received: from hell.org.pl ([62.233.239.4]:4368 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S1030236AbVLVRma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:42:30 -0500
Date: Thu, 22 Dec 2005 18:42:26 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: "Brown, Len" <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Hanno B??ck <mail@hboeck.de>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Christian Aichinger <Greek0@gmx.net>
Subject: [PATCH] Work around asus_acpi driver oopses on Samsung P30s and the like due to the ACPI implicit return
Message-ID: <20051222174226.GB20051@hell.org.pl>
Mail-Followup-To: "Brown, Len" <len.brown@intel.com>,
	Linus Torvalds <torvalds@osdl.org>, Hanno B??ck <mail@hboeck.de>,
	Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Christian Aichinger <Greek0@gmx.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Brown, Len:
> Karol,
> Do you have an update of your asus driver in the pipeline
> that addresses this?

Here it goes. Rediffed, also plugs a leak my previous patch introduced. I
believe it addresses Linus' comments. It's still not a proper fix (see
below), but I believe it's better than none.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl


Work around asus_acpi driver oopses on Samsung P30s and the like due to the
ACPI implicit return.

The code used to rely on a certain method to return a NULL buffer, which
is now hardly possible with the implicit return code on by default. This
sort of fixes bugs #5067 and #5092 for now.

Note: this patch makes the driver unusable on said machines (and on said
machines only) iff acpi=strict is specified, but it seems noone really uses
that.

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/asus_acpi.c	2005-12-22 18:08:56.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2005-12-22 18:16:19.000000000 +0100
@@ -987,9 +987,21 @@ static int __init asus_hotk_get_info(voi
 		printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n",
 		       bsts_result);
 
-	/* Samsung P30 has a device with a valid _HID whose INIT does not 
-	 * return anything. Catch this one and any similar here */
-	if (buffer.pointer == NULL) {
+	/* This is unlikely with implicit return */
+	if (buffer.pointer == NULL)
+		return -EINVAL;
+
+	model = (union acpi_object *) buffer.pointer;
+	/*
+	 * Samsung P30 has a device with a valid _HID whose INIT does not 
+	 * return anything. It used to be possible to catch this exception,
+	 * but the implicit return code will now happily confuse the 
+	 * driver. We assume that every ACPI_TYPE_STRING is a valid model
+	 * identifier but it's still possible to get completely bogus data.
+	 */
+	if (model->type == ACPI_TYPE_STRING) {
+		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
+	} else {
 		if (asus_info &&	/* Samsung P30 */
 		    strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {
 			hotk->model = P30;
@@ -1002,13 +1014,10 @@ static int __init asus_hotk_get_info(voi
 			       "the developers with your DSDT\n");
 		}
 		hotk->methods = &model_conf[hotk->model];
-		return AE_OK;
-	}
+		
+		acpi_os_free(model);
 
-	model = (union acpi_object *)buffer.pointer;
-	if (model->type == ACPI_TYPE_STRING) {
-		printk(KERN_NOTICE "  %s model detected, ",
-		       model->string.pointer);
+		return AE_OK;
 	}
 
 	hotk->model = END_MODEL;
