Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWCROiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWCROiW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 09:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWCROiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 09:38:22 -0500
Received: from smtpauth08.mail.atl.earthlink.net ([209.86.89.68]:28374 "EHLO
	smtpauth08.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S932207AbWCROiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 09:38:20 -0500
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
In-Reply-To: Your message of "Sat, 18 Mar 2006 21:24:04 +0800."
             <3ACA40606221794F80A5670F0AF15F84041AC267@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Sat, 18 Mar 2006 09:37:45 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FKcYr-00011r-9U@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478d165aa9320335d714855c6b41ab9031ebd6355a4fd6b880e350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm,  probably, you need to do :
>
> 4. in acpi_thermal_notify,
>       if (acpi_in_suspend == YES)
>               do nothing.

I've just tested that.  It suspended twice without problem, which made
me think the problem was solved.  But it hung on the third suspend!

I placed all the source under revision control, since I was spending
more time moving versions of files back and forth (and fixing the
inevitable mistakes, forgetting which version was which) than I would by
figuring out how to use the SCM.  So here is its generated diff between
the vanilla kernel (with config file that uses vanilla DSDT) and the
kernel that I just tested.

As you can see, the only change is the short-term fix including item 4
above.  It doesn't do anything else, e.g. there's no code to load just
THM0 (which is probably why it hung).  

Perhaps the other thermal zones have different problems, or maybe
there's yet another source of thermal method calls?

-Sanjoy


diff -r ac486e270597 -r 03c54e90f75d drivers/acpi/sleep/main.c
--- a/drivers/acpi/sleep/main.c	Sat Mar 18 08:35:34 2006 -0500
+++ b/drivers/acpi/sleep/main.c	Sat Mar 18 09:08:04 2006 -0500
@@ -19,6 +19,12 @@
 #include <acpi/acpi_drivers.h>
 #include "sleep.h"
 
+/* for functions putting machine to sleep to know that we're
+   suspending, so that they can careful about what AML methods they
+   invoke (to avoid trying untested BIOS code paths) */
+int acpi_in_suspend;
+EXPORT_SYMBOL(acpi_in_suspend);
+
 u8 sleep_states[ACPI_S_STATE_COUNT];
 
 static struct pm_ops acpi_pm_ops;
@@ -55,6 +61,8 @@ static int acpi_pm_prepare(suspend_state
 		printk("acpi_pm_prepare does not support %d \n", pm_state);
 		return -EPERM;
 	}
+	acpi_os_wait_events_complete(NULL);
+	acpi_in_suspend = TRUE;
 	return acpi_sleep_prepare(acpi_state);
 }
 
@@ -131,6 +139,7 @@ static int acpi_pm_finish(suspend_state_
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
+	acpi_in_suspend = FALSE;
 	acpi_leave_sleep_state(acpi_state);
 	acpi_disable_wakeup_device(acpi_state);
 
diff -r ac486e270597 -r 03c54e90f75d drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c	Sat Mar 18 08:35:34 2006 -0500
+++ b/drivers/acpi/thermal.c	Sat Mar 18 09:08:04 2006 -0500
@@ -79,6 +79,8 @@ static int tzp;
 static int tzp;
 module_param(tzp, int, 0);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
+
+extern int acpi_in_suspend;
 
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
@@ -683,6 +685,8 @@ static void acpi_thermal_run(unsigned lo
 static void acpi_thermal_run(unsigned long data)
 {
 	struct acpi_thermal *tz = (struct acpi_thermal *)data;
+	if (acpi_in_suspend)	/* thermal methods might cause a hang */
+		return;		/* so don't do them */
 	if (!tz->zombie)
 		acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
 					    acpi_thermal_check, (void *)data);
@@ -1224,6 +1228,9 @@ static void acpi_thermal_notify(acpi_han
 	struct acpi_device *device = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_notify");
+
+	if (acpi_in_suspend)	/* thermal methods might cause a hang */
+		return_VOID;	/* so don't do them */
 
 	if (!tz)
 		return_VOID;

