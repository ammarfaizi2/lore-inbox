Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUGVPNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUGVPNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUGVPNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:13:50 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:36846 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266362AbUGVPNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:13:37 -0400
Date: Thu, 22 Jul 2004 11:16:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, shaohua.li@intel.com,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] Quiesce after changing ACPI idle thread
Message-ID: <Pine.LNX.4.58.0407221055391.19190@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses the following bugzilla bug;

http://bugzilla.kernel.org/show_bug.cgi?id=1716

When unloading the processor module we modify the currently used idle
thread (pm_idle), this causes an oops due to the idle thread text being
unloaded.

Index: linux-2.6.8-rc1-mm1/drivers/acpi/processor.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc1-mm1/drivers/acpi/processor.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.c
--- linux-2.6.8-rc1-mm1/drivers/acpi/processor.c	14 Jul 2004 04:56:25 -0000	1.1.1.1
+++ linux-2.6.8-rc1-mm1/drivers/acpi/processor.c	20 Jul 2004 15:31:46 -0000
@@ -2372,8 +2372,10 @@ acpi_processor_remove (
 	pr = (struct acpi_processor *) acpi_driver_data(device);

 	/* Unregister the idle handler when processor #0 is removed. */
-	if (pr->id == 0)
+	if (pr->id == 0) {
 		pm_idle = pm_idle_save;
+		synchronize_kernel();
+	}

 	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 		acpi_processor_notify);
