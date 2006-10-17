Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWJQUUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWJQUUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWJQUUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:20:31 -0400
Received: from mail.suse.de ([195.135.220.2]:63641 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751254AbWJQUUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:20:30 -0400
Date: Tue, 17 Oct 2006 22:19:22 +0200
From: Stefan Seyfried <seife@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] swsusp: fix platform mode
Message-ID: <20061017201922.GA4915@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: openSUSE 10.2 (i586) Alpha5plus, Kernel 2.6.18-14-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point after 2.6.13, in-kernel software suspend got "incomplete"
for the so-called "platform" mode. pm_ops->prepare() is never called.
A visible sign of this is the "moon" light on thinkpads not flashing
during suspend. Fix by readding the pm_ops->prepare call during suspend.

Signed-off-by: Stefan Seyfried <seife@suse.de>
Acked-by: "Rafael J. Wysocki" <rjw@sisk.pl>
---

 kernel/power/disk.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- linux/kernel/power/disk.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18.patched/kernel/power/disk.c	2006-10-17 22:03:26.000000000 +0200
@@ -27,6 +27,22 @@ char resume_file[256] = CONFIG_PM_STD_PA
 dev_t swsusp_resume_device;
 
 /**
+ *	platform_prepare - prepare the machine for hibernation using the
+ *	platform driver if so configured and return an error code if it fails
+ */
+
+static inline int platform_prepare(void)
+{
+	int error = 0;
+
+	if (pm_disk_mode == PM_DISK_PLATFORM) {
+		if (pm_ops && pm_ops->prepare)
+			error = pm_ops->prepare(PM_SUSPEND_DISK);
+	}
+	return error;
+}
+
+/**
  *	power_down - Shut machine down for hibernate.
  *	@mode:		Suspend-to-disk mode
  *
@@ -79,9 +95,15 @@ static int prepare_processes(void)
 		goto thaw;
 	}
 
+	error = platform_prepare();
+	if (error)
+		goto thaw;
+
 	/* Free memory before shutting down devices. */
 	if (!(error = swsusp_shrink_memory()))
 		return 0;
+
+	platform_finish();
 thaw:
 	thaw_processes();
 	enable_nonboot_cpus();
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
