Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSGaS3t>; Wed, 31 Jul 2002 14:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318436AbSGaS3t>; Wed, 31 Jul 2002 14:29:49 -0400
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:56330 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S318435AbSGaS3s>;
	Wed, 31 Jul 2002 14:29:48 -0400
Subject: [PATCH] Guarantee APM power status change notifications
From: Ray Lee <ray-lk@madrabbit.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: cort@fsmlabs.com, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20020726201721.B6370@cort.fsmlabs.com>
References: <1027726949.2691.68.camel@orca> 
	<20020726201721.B6370@cort.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 31 Jul 2002 11:33:10 -0700
Message-Id: <1028140392.1771.66.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Below is a rework of Cort Dougan's APM patch of last Thursday and
Friday. As a reminder, the issue is that some laptops, notably Vaios,
don't send notification when the power status changes to AC or to
on-battery. The below patch fixes this such that it always just works.

There are three cases. First, the BIOS doesn't send any notifications;
this is fixed. Second, the BIOS sends notifications. In this case, the
code notes that, and disables the workaround. Third, the BIOS sends
notifications, but somehow we managed to notice the power change before
the BIOS could tell us. This seems highly unlikely, but what the heck,
it could theoretically happen. In that case, we disable the workaround,
and drop the notification that the BIOS generated, as we already sent it
onward up the call chain.

The rework was for a couple of small reasons. First, Cort's patch was
against 2.4.16, and 2.4.18 changed a few things in apm.c. Second, this
pushes the specifics of the workaround down to the get_event() routine,
which exists pretty much solely as an abstraction point between the
actual BIOS call (apm_get_event()) and the event dispatch function
(check_events()). Lastly, I see no need to do dmi matching. The code can
be structured to always do the right thing, so that's what we do.

I'm on the road from Thursday to Monday, and won't be reading email, but
comments are welcome. The patch is pretty darn straight-forward, though.

Please consider for the next -ac patch, and 2.4.20-preX. Actual patch
generated against 2.4.19-rc3-ac5.

Ray Lee

diff -NurX /usr/src/dontdiff linux-2.4.19-rc3-ac5/arch/i386/kernel/apm.c linux-2.4.19-rc3-ac5-apm-fixes/arch/i386/kernel/apm.c
--- linux-2.4.19-rc3-ac5/arch/i386/kernel/apm.c	2002-07-31 11:27:39.000000000 -0700
+++ linux-2.4.19-rc3-ac5-apm-fixes/arch/i386/kernel/apm.c	2002-07-31 11:30:19.000000000 -0700
@@ -385,6 +385,7 @@
 static int			ignore_sys_suspend;
 static int			ignore_normal_resume;
 static int			bounce_interval = DEFAULT_BOUNCE_INTERVAL;
+static u_short			last_power_status;
 
 #ifdef CONFIG_APM_RTC_IS_GMT
 #	define	clock_cmos_diff	0
@@ -1239,17 +1240,46 @@
 	int		error;
 	apm_event_t	event;
 	apm_eventinfo_t	info;
-
+	static u_short	power_event_workaround_enabled = 1;
 	static int notified;
 
 	/* we don't use the eventinfo */
 	error = apm_get_event(&event, &info);
-	if (error == APM_SUCCESS)
+	if (error == APM_SUCCESS) {
+		/* if BIOS reports power changes, disable workaround */
+		if (event == APM_POWER_STATUS_CHANGE) {
+			/* check to see if we jumped the gun and reported a
+			 * power change event that the BIOS would have (and
+			 * just did) on its own. If so, drop the duplicate.
+			 */
+			if (power_event_workaround_enabled)
+				event=get_event();
+			power_event_workaround_enabled = 0;
+		}
 		return event;
+	}
 
 	if ((error != APM_NO_EVENTS) && (notified++ == 0))
 		apm_error("get_event", error);
 
+	/*
+	 * Sony Vaios don't seem to want to notify us about AC line power
+	 * status changes.  So for those and any others like them, we keep
+	 * track of it by hand and emulate it here.
+	 */
+	if (power_event_workaround_enabled) {
+		u_short status, bat, life;
+		error = apm_get_power_status(&status, &bat, &life);
+		if (error == APM_SUCCESS) {
+			if ((status ^ last_power_status) & 0xff00) {
+				/* fake an APM_POWER_STATUS_CHANGE event */
+				last_power_status = status;
+				return APM_POWER_STATUS_CHANGE;
+			}
+		} else 
+			power_event_workaround_enabled=0;
+	}
+
 	return 0;
 }
 
@@ -1758,6 +1788,7 @@
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = apm_console_blank;
 #endif
+		apm_get_power_status(&last_power_status, &cx, &dx);
 		apm_mainloop();
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = NULL;

