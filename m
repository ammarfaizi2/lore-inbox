Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTK1Owk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 09:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTK1Owk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 09:52:40 -0500
Received: from gprs148-17.eurotel.cz ([160.218.148.17]:642 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262323AbTK1Owi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 09:52:38 -0500
Date: Fri, 28 Nov 2003 15:52:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: If your ACPI-enabled machine does clean shutdown randomly...
Message-ID: <20031128145249.GA563@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


...then you probably need this one. (One notebook I have here
certainly needs it).

It seems that acpi likes to report completely bogus value from time to
time...

								Pavel

--- clean/drivers/acpi/thermal.c	2003-07-27 22:31:09.000000000 +0200
+++ linux/drivers/acpi/thermal.c	2003-11-25 22:27:11.000000000 +0100
@@ -456,6 +459,10 @@
 	if (!tz || !tz->trips.critical.flags.valid)
 		return_VALUE(-EINVAL);
 
+	if (KELVIN_TO_CELSIUS(tz->temperature) >= 200) {
+		printk(KERN_ALERT "Are you running CPU or nuclear power plant? ACPI claims CPU temp is %d C. Ignoring.\n", KELVIN_TO_CELSIUS(tz->temperature));
+		return_VALUE(0);
+	}
 	if (tz->temperature >= tz->trips.critical.temperature) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
 		tz->trips.critical.flags.enabled = 1;
@@ -467,6 +474,7 @@
 	if (result)
 		return_VALUE(result);
 
+	printk(KERN_EMERG "Critical temperature reached (%d C), shutting down.\n", tz->temperature);
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
 
 	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
