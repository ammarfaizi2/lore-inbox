Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbTHVVIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 17:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbTHVVI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 17:08:29 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:1424 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263767AbTHVVIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 17:08:13 -0400
Date: Fri, 22 Aug 2003 23:08:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@osdl.org, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030822210800.GA4403@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As far as I can see, I'm still maintainer of software suspend. That
did not stop you from crying "split those patches" when I tried to
submit changes to my code, and you were pretty pissed off when I tried
to push trivial one liners without contacting maintainers.

And now you pushed ton of crap into Linus' tree, breaking userland
interfaces in the stable series (/proc/acpi/sleep), killing copyrights
(Andy Grover has copyright on drivers/acpi/sleep/main.c), and
rewriting code without even sending diff to maintainer (no, I did not
see a mail from you, and you modified swsusp heavily). You did not
bother to send code to the lists, so that noone could review it.
Great. This way we are going to have stable PM code... in 2056.

Linus, could you make sure Patricks patches are at least reviewed on
the lists?
								Pavel

--- a/include/linux/pm.h	Fri Aug 15 01:15:23 2003
+++ b/include/linux/pm.h	Mon Aug 18 15:31:58 2003
@@ -186,8 +186,30 @@
 
 #endif /* CONFIG_PM */
 
+
+/*
+ * Callbacks for platform drivers to implement.
+ */
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
+
+enum {
+	PM_SUSPEND_ON,
+	PM_SUSPEND_STANDBY,
+	PM_SUSPEND_MEM,
+	PM_SUSPEND_DISK,
+	PM_SUSPEND_MAX,
+};
+
+extern int (*pm_power_down)(u32 state);

If you defined enum, you should also use it. 

@@ -1114,7 +986,8 @@
 
 static int __init resume_setup(char *str)
 {
-	strncpy( resume_file, str, 255 );
+	if (strlen(str))
+		strncpy(resume_file, str, 255);
 	return 1;
 }

Why are you obfuscating the code?

You changed return type of do_magic() to int, but did not bother to
update assembly code, as far as I can see. Did you test those changes?

+Some devices are broken and will inevitably have problems powering
+down or disabling themselves with interrupts enabled. For these
+special cases, they may return -EAGAIN. This will put the device on a
+list to be taken care of later. When interrupts are disabled, before
+we enter the low-power state, their drivers are called again to put
+their device to sleep. 

Returning EAGAIN to be called with interrupts disabled is extremely
ugly hack. We were passing suspend level before. Why did you have to
break it?



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
