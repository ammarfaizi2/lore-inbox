Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSG2BTF>; Sun, 28 Jul 2002 21:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSG2BTF>; Sun, 28 Jul 2002 21:19:05 -0400
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:38407 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S317349AbSG2BTE>;
	Sun, 28 Jul 2002 21:19:04 -0400
Subject: Re: [PATCH] fix APM notify of apmd for on-AC/on-battery transitions
From: Ray Lee <ray-lk@madrabbit.org>
To: cort@fsmlabs.com, davej@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020726201721.B6370@cort.fsmlabs.com>
References: <1027726949.2691.68.camel@orca> 
	<20020726201721.B6370@cort.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 28 Jul 2002 18:22:20 -0700
Message-Id: <1027905740.11483.23.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 19:17, cort@fsmlabs.com wrote:
> I think this affects all Vaio laptops.  With enough reports maybe
> we'll find out something different, though.

Agreed to both.

> Thanks for the suggestion to move the get_event().  I'll see about moving
> that (but not on a friday night).

Heh, you mean you have a life? I'm jealous :-)

Below is my suggestion for the patch. Mostly it's just a rework of the
structure, but one thing that cropped up is that 2.4.18 got rid of the
send_event() call. Also, as you'll note from the patch I'm suggesting we
back off from identifying systems one by one, and instead just always do
the right thing: if the BIOS decides to step up and take responsibility
for power change events, then disable the workaround code. Otherwise,
let it be and send a notification as if the BIOS had done it correctly
to begin with.

Comments?

diff -NurX dontdiff linux/arch/i386/kernel/apm.c apm-fixes/arch/i386/kernel/apm.c
--- linux/arch/i386/kernel/apm.c	2002-06-08 08:31:24.000000000 -0700
+++ apm-fixes/arch/i386/kernel/apm.c	2002-07-28 17:48:42.000000000 -0700
@@ -385,6 +385,7 @@
 static int			ignore_sys_suspend;
 static int			ignore_normal_resume;
 static int			bounce_interval = DEFAULT_BOUNCE_INTERVAL;
+static u_short			last_power_status;
 
 #ifdef CONFIG_APM_RTC_IS_GMT
 #	define	clock_cmos_diff	0
@@ -1240,15 +1241,40 @@
 	apm_eventinfo_t	info;
 
 	static int notified;
+	static u_short	power_event_state = 0;
 
 	/* we don't use the eventinfo */
 	error = apm_get_event(&event, &info);
-	if (error == APM_SUCCESS)
+	if (error == APM_SUCCESS) {
+		/* if BIOS reports power changes, disable workaround */
+		if (event == APM_POWER_STATUS_CHANGE)
+			power_event_state = 2;
 		return event;
+	}
 
 	if ((error != APM_NO_EVENTS) && (notified++ == 0))
 		apm_error("get_event", error);
 
+	/*
+	 * Sony Vaios don't seem to want to notify us about AC line power
+	 * status changes.  So for those and any others like them, we keep
+	 * track of it by hand and emulate it here.
+	 */
+	if (power_event_state < 2) {
+		u_short status, bat, life;
+		error = apm_get_power_status(&status, &bat, &life);
+		if (error == APM_SUCCESS && (status ^ last_power_status) & 0xff00) {
+			/* fake an APM_POWER_STATUS_CHANGE event */
+			last_power_status = status;
+			if (power_event_state == 0) {
+				printk(KERN_WARNING "apm: power status notification workaround enabled\n");
+				power_event_state = 1;
+			}
+			return APM_POWER_STATUS_CHANGE;
+		} else if (error != APM_SUCCESS)
+			power_event_state=2;
+	}
+
 	return 0;
 }
 
@@ -1758,6 +1784,7 @@
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = apm_console_blank;
 #endif
+		apm_get_power_status(&last_power_status, &cx, &dx);
 		apm_mainloop();
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = NULL;



