Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWBSMxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWBSMxc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 07:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWBSMxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 07:53:32 -0500
Received: from devrace.com ([198.63.210.113]:2576 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932418AbWBSMxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 07:53:31 -0500
Date: Sun, 19 Feb 2006 13:52:58 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: acpi-devel@lists.sourceforge.net
Cc: Linus Torvalds <torvalds@osdl.org>, Hanno Boeck <mail@hboeck.de>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Christian Aichinger <Greek0@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Work around asus_acpi driver oopses on Samsung P30s and the like due to the ACPI implicit return
Message-ID: <20060219125258.GB6041@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	acpi-devel@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>, Hanno Boeck <mail@hboeck.de>,
	Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
	Christian Aichinger <Greek0@gmx.net>, linux-kernel@vger.kernel.org
References: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com> <20051222174226.GB20051@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222174226.GB20051@hell.org.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, I need the patch below to stop ACPI freezing at boot on Asus S1300N.
There is a BIOS update from Asus, but no mention of any fixes in ACPI,
so as I have no means to backup the BIOS in case something goes wrong
I didn't do the update.

I found out (by putting printks in the initialization code) that a
call to INI (whatever it is) of VGA_ (whatever this is) immediately
freezes the notebook and the fan goes on shortly afterwards.


diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index f4c8775..d415b30 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -352,8 +352,8 @@ static struct model_data model_conf[END_
 	 .lcd_status = "\\BKLT",
 	 .brightness_set = "SPLV",
 	 .brightness_get = "GPLV",
-	 .display_set = "SDSP",
-	 .display_get = "\\ADVG"}
+	 /* .display_set = "SDSP",
+	 .display_get = "\\ADVG" */}
 };
 
 /* procdir we use */
diff --git a/drivers/acpi/namespace/nsinit.c b/drivers/acpi/namespace/nsinit.c
index 9f929e4..79fa2ec 100644
--- a/drivers/acpi/namespace/nsinit.c
+++ b/drivers/acpi/namespace/nsinit.c
@@ -384,7 +384,12 @@ acpi_ns_init_one_device(acpi_handle obj_
 	pinfo.parameters = NULL;
 	pinfo.parameter_type = ACPI_PARAM_ARGS;
 
-	status = acpi_ut_execute_STA(pinfo.node, &flags);
+	/* workaround Asus S1300N freeze at INI */
+	if ( memcmp(pinfo.node->name.ascii, "VGA_",4)==0 ) {
+	    printk(KERN_ERR "acpi: VGA_ ignored\n");
+	    status = AE_NOT_FOUND;
+	} else
+	    status = acpi_ut_execute_STA(pinfo.node, &flags);
 	if (ACPI_FAILURE(status)) {
 		/* Ignore error and move on to next device */
 
