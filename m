Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWCQSnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWCQSnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWCQSnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:43:18 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:41892 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751322AbWCQSnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:43:17 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Fri, 17 Mar 2006 15:50:35 +0800."
             <3ACA40606221794F80A5670F0AF15F84041AC265@pdsmsx403> 
Date: Fri, 17 Mar 2006 18:43:14 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FKJus-000166-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, please try hack thermal.c by removing calls to _TMP.

I did something like that before, by changing acpi_evaluate_integer()
to return 3000 if it is asked for _TMP.  

--- a/utils.c	2006-03-15 01:42:34.000000000 -0500
+++ b/utils.c	2006-03-14 23:36:59.000000000 -0500
@@ -270,7 +270,15 @@ acpi_evaluate_integer(acpi_handle handle
 	memset(element, 0, sizeof(union acpi_object));
 	buffer.length = sizeof(union acpi_object);
 	buffer.pointer = element;
-	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
+	if (strcmp(pathname, "_TMP") != 0)
+	  status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
+	else {
+	  printk(KERN_INFO PREFIX "acpi_evaluate_integer: Faking _TMP\n");
+	  status = AE_OK;
+	  element->type = ACPI_TYPE_INTEGER;
+	  element->integer.value = 3000; /* 27 C, in deciKelvins */
+	}
+
 	if (ACPI_FAILURE(status)) {
 		acpi_util_eval_error(handle, pathname, status);
 		return_ACPI_STATUS(status);


The alternative, obvious change in thermal.c (diff below) turns out
not to be a minimal change.  If acpi_thermal_get_temperature() returns
with a failure, then most of the later methods in THM0 aren't
executed, so one is actually commenting out much more than _TMP.

Which is why I think the minimal change is the diff above to utils.c.
With that change the system never hung.

Or should I do a compromise modification, where calls from thermal.c
to _TMP use the hacked acpi_evaluate_integer()
[e.g. acpi_evaluate_integer_called_from_thermal()], but other calls to
_TMP get the unhacked version?

Here is the diff for commenting out _TMP directly in thermal.c, which
I think I've tried already but I'll try it again.  I'm sure it'll
work, though.

--- a/thermal.c	2006-03-16 09:45:30.000000000 -0500
+++ b/thermal.c	2006-03-17 09:00:30.000000000 -0500
@@ -222,7 +222,7 @@ static int acpi_thermal_get_temperature(
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_get_temperature");
 
-	if (!tz)
+	if (!tz || strcmp(tz->handle, "_TMP") == 0)
 		return_VALUE(-EINVAL);
 
 	tz->last_temperature = tz->temperature;


