Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUK2AjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUK2AjU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 19:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUK2AjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 19:39:20 -0500
Received: from ozlabs.org ([203.10.76.45]:4544 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261610AbUK2AjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 19:39:10 -0500
Subject: Re: [PATCH] ibm-acpi-0.8 (was Re: 2.6.10-rc1-mm3)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Borislav Deianov <borislav@users.sourceforge.net>
Cc: Chris Wright <chrisw@osdl.org>, len.brown@intel.com,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, acpi-devel@lists.sourceforge.net
In-Reply-To: <20041109023119.GB21832@aero.ensim.com>
References: <200411081334.18751.annabellesgarden@yahoo.de>
	 <200411082240.02787.annabellesgarden@yahoo.de>
	 <20041108153022.N14339@build.pdx.osdl.net>
	 <20041109013013.GA21832@aero.ensim.com>
	 <20041108181224.F2357@build.pdx.osdl.net>
	 <20041109023119.GB21832@aero.ensim.com>
Content-Type: text/plain
Date: Mon, 29 Nov 2004 11:34:30 +1100
Message-Id: <1101688470.25347.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 18:31 -0800, Borislav Deianov wrote:
> On Mon, Nov 08, 2004 at 06:12:24PM -0800, Chris Wright wrote:
> > 
> > Ah, even better.  Thanks Boris.  BTW, you could probably mark ibm_init()
> > and ibm_handle_init() as __init.
> 
> Good point, I'll do it in the next version.

You cannot use module_param the way you are trying to: it must be used
at the top level, and it will be called before your module's init
function.

This patch might serve as a starting point...
Rusty.

Name: Fix Parameter Handling in ibm_acpi.c
Status: Untested
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

You can't call module_param et al inside a function.  It doesn't make
sense, and it doesn't work.

Index: linux-2.6.10-rc2-bk11-Module/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-2.6.10-rc2-bk11-Module.orig/drivers/acpi/ibm_acpi.c	2004-11-29
11:30:51.723729720 +1100
+++ linux-2.6.10-rc2-bk11-Module/drivers/acpi/ibm_acpi.c	2004-11-29
11:31:08.757140248 +1100
@@ -1147,21 +1147,26 @@
 		object##_paths, sizeof(object##_paths)/sizeof(char*), required)
 
 
-static void ibm_param(char *feature, char *cmd)
+static int set_ibm_param(const char *val, struct kernel_param *kp)
 {
-	int i;
+	unsigned int i;
+	char arg_with_comma[32];
+
+	if (strlen(val) > 30)
+		return -ENOSPC;
+
+	strcpy(arg_with_comma, val);
+	strcat(arg_with_comma, ",");
 
-	strcat(cmd, ",");
 	for (i=0; i<NUM_IBMS; i++)
-		if (strcmp(ibms[i].name, feature) == 0)
-			ibms[i].write(&ibms[i], cmd);
-}	
-
-#define IBM_PARAM(feature) do {					\
-	static char cmd[32];					\
-	module_param_string(feature, cmd, sizeof(cmd) - 1, 0);	\
-	ibm_param(#feature, cmd);				\
-} while (0)
+		if (strcmp(ibms[i].name, kp->name) == 0)
+			return ibms[i].write(&ibms[i], arg_with_comma);
+	BUG();
+	return -EINVAL;
+} 
+
+#define IBM_PARAM(feature) \
+	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
 
 static void __exit acpi_ibm_exit(void)
 {
@@ -1216,16 +1221,6 @@
 		}
 	}
 
-	IBM_PARAM(hotkey);
-	IBM_PARAM(bluetooth);
-	IBM_PARAM(video);
-	IBM_PARAM(light);
-	IBM_PARAM(dock);
-	IBM_PARAM(bay);
-	IBM_PARAM(cmos);
-	IBM_PARAM(led);
-	IBM_PARAM(beep);
-
 	return 0;
 }
 
@@ -1235,3 +1230,13 @@
 MODULE_AUTHOR("Borislav Deianov");
 MODULE_DESCRIPTION(IBM_DESC);
 MODULE_LICENSE("GPL");
+
+IBM_PARAM(hotkey);
+IBM_PARAM(bluetooth);
+IBM_PARAM(video);
+IBM_PARAM(light);
+IBM_PARAM(dock);
+IBM_PARAM(bay);
+IBM_PARAM(cmos);
+IBM_PARAM(led);
+IBM_PARAM(beep);


-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

