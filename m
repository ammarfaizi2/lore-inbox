Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUHKIxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUHKIxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 04:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267999AbUHKIxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 04:53:47 -0400
Received: from gprs214-4.eurotel.cz ([160.218.214.4]:6016 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267998AbUHKIxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 04:53:43 -0400
Date: Wed, 11 Aug 2004 10:53:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: trenn@suse.de, seife@suse.de, kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Allow userspace do something special on overtemp
Message-ID: <20040811085326.GA11765@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch cleans up thermal.c a bit, and adds possibility to react to
critical overtemp: it tries to call /sbin/overtemp, and only if that
fails calls /sbin/poweroff.

Could it be applied?
								Pavel

--- tmp/linux/drivers/acpi/thermal.c	2004-08-11 10:47:04.000000000 +0200
+++ linux/drivers/acpi/thermal.c	2004-08-11 10:45:36.000000000 +0200
@@ -60,7 +60,6 @@
 #define ACPI_THERMAL_NOTIFY_HOT		0xF1
 #define ACPI_THERMAL_MODE_ACTIVE	0x00
 #define ACPI_THERMAL_MODE_PASSIVE	0x01
-#define ACPI_THERMAL_PATH_POWEROFF	"/sbin/poweroff"
 
 #define ACPI_THERMAL_MAX_ACTIVE	10
 
@@ -424,24 +423,25 @@
 
 
 static int
-acpi_thermal_call_usermode (
-	char			*path)
+acpi_thermal_call_usermode(void)
 {
 	char			*argv[2] = {NULL, NULL};
 	char			*envp[3] = {NULL, NULL, NULL};
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_call_usermode");
 
-	if (!path)
-		return_VALUE(-EINVAL);
-
-	argv[0] = path;
-
 	/* minimal command environment */
 	envp[0] = "HOME=/";
 	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-	
-	call_usermodehelper(argv[0], argv, envp, 0);
+
+	argv[0] = "/sbin/overtemp";
+	if (call_usermodehelper(argv[0], argv, envp, 0)) {
+		argv[0] = "/sbin/poweroff";
+		if (call_usermodehelper(argv[0], argv, envp, 0)) {
+			/* What to do here? Should we just cut the power? */
+			printk(KERN_CRIT "attempts to poweroff failed, please power me down manually\n");
+		}
+	}
 
 	return_VALUE(0);
 }
@@ -483,7 +483,7 @@
 	printk(KERN_EMERG "Critical temperature reached (%ld C), shutting down.\n", KELVIN_TO_CELSIUS(tz->temperature));
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
 
-	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
+	acpi_thermal_call_usermode();
 
 	return_VALUE(0);
 }


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
