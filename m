Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbUKHXbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUKHXbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbUKHXbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:31:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:34243 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261301AbUKHXap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:30:45 -0500
Date: Mon, 8 Nov 2004 15:30:22 -0800
From: Chris Wright <chrisw@osdl.org>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, len.brown@intel.com,
       borislav@users.sourceforge.net
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041108153022.N14339@build.pdx.osdl.net>
References: <200411081334.18751.annabellesgarden@yahoo.de> <200411082240.02787.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200411082240.02787.annabellesgarden@yahoo.de>; from annabellesgarden@yahoo.de on Mon, Nov 08, 2004 at 10:40:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Karsten Wiese (annabellesgarden@yahoo.de) wrote:
> Found out, what happened:
> By accident I had ibm_acpi.ko built. Its name "ibm" was still present under "/proc/acpi".
> This is not an ibm(-laptop)-machine, so ibm_acpi.ko is useless here.
> "Unable to handle kernel paging request at virtual address f89e7b00":
> this address corresponds to the "struct module *" of ibm_acpi.ko, which was not loaded anymore.
> So the real bug here is that there is a non NULL "struct module *", where the corresponding module is unloaded.
> Or so I guess.....

The init error cleanup paths are broken in that driver.  It creates the
/proc/acpi/ibm dir and forgets to clean it up.  Partially that's due to
returning directly from the macro IBM_HANDLE_INIT_REQ.  This should help.

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- linux-2.6.10-rc1-mm3/drivers/acpi/ibm_acpi.c~orig	2004-11-05 15:18:51.000000000 -0800
+++ linux-2.6.10-rc1-mm3/drivers/acpi/ibm_acpi.c	2004-11-08 15:14:20.000000000 -0800
@@ -1129,22 +1129,18 @@
 		if (ACPI_SUCCESS(status))
 			return 0;
 	}
-	
-	if (required) {
-		printk(IBM_ERR "%s object not found\n", name);
-		return -1;
-	}
 
 	*handle = NULL;
 
+	if (required)
+		printk(IBM_ERR "%s object not found\n", name);
+
 	return 0;
 }
 
-#define IBM_HANDLE_INIT_REQ(object) do {                                      \
-        if (ibm_handle_init(#object, &object##_handle, *object##_parent,      \
-		object##_paths, sizeof(object##_paths)/sizeof(char *), 1) < 0)\
-		return -ENODEV;                                               \
-} while (0)
+#define IBM_HANDLE_INIT_REQ(object)                                        \
+        ibm_handle_init(#object, &object##_handle, *object##_parent,       \
+		object##_paths, sizeof(object##_paths)/sizeof(char *), 1)
 
 #define IBM_HANDLE_INIT(object)                                           \
 	ibm_handle_init(#object, &object##_handle, *object##_parent,      \
@@ -1179,46 +1175,56 @@
 
 static int __init acpi_ibm_init(void)
 {
-	int ret, i;
+	int i, ret = -ENODEV;
 
 	if (acpi_disabled)
-		return -ENODEV;
+		return ret;
 
 	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
 	if (!proc_dir) {
 		printk(IBM_ERR "unable to create proc dir %s", IBM_DIR);
-		return -ENODEV;
+		return ret;
 	}
 	proc_dir->owner = THIS_MODULE;
 	
-	IBM_HANDLE_INIT_REQ(ec);
-	IBM_HANDLE_INIT_REQ(hkey);
-	IBM_HANDLE_INIT_REQ(vid);
+	IBM_HANDLE_INIT(ec);
+	if (!ec_handle)
+		goto cleanup;
+
+	IBM_HANDLE_INIT(hkey);
+	if (!hkey_handle)
+		goto cleanup;
+
+	IBM_HANDLE_INIT(vid);
+	if (!vid_handle)
+		goto cleanup;
+
 	IBM_HANDLE_INIT(cmos);
 	IBM_HANDLE_INIT(lght);
+	if (!cmos_handle && !lght_handle) {
+		printk(IBM_ERR "neither cmos nor lght object found\n");
+		goto cleanup;
+	}
+
 	IBM_HANDLE_INIT(dock);
 	IBM_HANDLE_INIT(bay);
 	IBM_HANDLE_INIT(bayej);
 	IBM_HANDLE_INIT(led);
+
 	IBM_HANDLE_INIT(sysl);
 	IBM_HANDLE_INIT(bled);
-	IBM_HANDLE_INIT_REQ(beep);
-
-	if (!cmos_handle && !lght_handle) {
-		printk(IBM_ERR "neither cmos nor lght object found\n");
-		return -ENODEV;
-	}
-
 	if (!led_handle && !sysl_handle) {
 		printk(IBM_ERR "neither led nor sysl object found\n");
-		return -ENODEV;
+		goto cleanup;
 	}
+	IBM_HANDLE_INIT_REQ(beep);
+	if (!beep_handle)
+		goto cleanup;
 
 	for (i=0; i<NUM_IBMS; i++) {
 		ret = ibm_init(&ibms[i]);
 		if (ret < 0) {
-			acpi_ibm_exit();
-			return ret;
+			goto cleanup;
 		}
 	}
 
@@ -1233,6 +1239,9 @@
 	IBM_PARAM(beep);
 
 	return 0;
+cleanup:
+	acpi_ibm_exit();
+	return ret;
 }
 
 module_init(acpi_ibm_init);
