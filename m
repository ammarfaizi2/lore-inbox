Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVAOPz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVAOPz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 10:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVAOPz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 10:55:58 -0500
Received: from cpe-66-74-186-186.socal.rr.com ([66.74.186.186]:403 "EHLO
	mail.blackbean.org") by vger.kernel.org with ESMTP id S262292AbVAOPze
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 10:55:34 -0500
Date: Sat, 15 Jan 2005 07:55:19 -0800
From: Jim Radford <radford@blackbean.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: IBM-ACPI broken in 2.6.10
Message-ID: <20050115155519.GA29719@blackbean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105744800.7565.4.camel@tyrosine>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The ibm-acpi module included in 2.6.10 doesn't appear to parse
> parameters correctly.  This seems to be due to a patch from Rusty
> Russell [1] which attempted to fix up the parameter parsing.

> What's the right way of fixing this?

I'm not sure about the "right" way, but this is what I came up with.
I sent a copy of this patch to Borislav Deianov a few weeks ago with
no resposne.  Maybe someone else will pick it up.

With this fix "insmod ibm_acpi light=on" works for me again.

-Jim

Module params don't work for me with 2.6.10 because the callbacks get
called before ibm_acpi_init so that the acpi_handle's are still NULL.

Here's a patch to force the param callbacks to be called after the
module is inited so that cmos_handle et al will be defined.

Signed-Off-By: Jim Radford <radford@blackbean.org>

--- linux-2.6.10/drivers/acpi/ibm_acpi.c.orig	2004-12-25 09:33:48.000000000 -0800
+++ linux-2.6.10/drivers/acpi/ibm_acpi.c	2004-12-26 14:17:16.000000000 -0800
@@ -153,6 +153,8 @@
 	} state;
 
 	int experimental;
+
+	const char *param;
 };
 
 struct proc_dir_entry *proc_dir = NULL;
@@ -1150,17 +1152,11 @@
 static int set_ibm_param(const char *val, struct kernel_param *kp)
 {
 	unsigned int i;
-	char arg_with_comma[32];
-
-	if (strlen(val) > 30)
-		return -ENOSPC;
-
-	strcpy(arg_with_comma, val);
-	strcat(arg_with_comma, ",");
-
 	for (i=0; i<NUM_IBMS; i++)
-		if (strcmp(ibms[i].name, kp->name) == 0)
-			return ibms[i].write(&ibms[i], arg_with_comma);
+		if (strcmp(ibms[i].name, kp->name) == 0) {
+			ibms[i].param = val;
+			return 0;
+		}
 	BUG();
 	return -EINVAL;
 }
@@ -1215,6 +1211,14 @@
 	
 	for (i=0; i<NUM_IBMS; i++) {
 		ret = ibm_init(&ibms[i]);
+		if (ret >= 0 && ibms[i].param) {
+			char arg_with_comma[32];
+			if (strlen(ibms[i].param) > sizeof(arg_with_comma)-2)
+				return -ENOSPC;
+			strcpy(arg_with_comma, ibms[i].param);
+			strcat(arg_with_comma, ",");
+			ret = ibms[i].write(&ibms[i], arg_with_comma);
+		}
 		if (ret < 0) {
 			acpi_ibm_exit();
 			return ret;




