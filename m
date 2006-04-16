Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWDPWFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWDPWFz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 18:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWDPWFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 18:05:55 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:52677 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750808AbWDPWFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 18:05:54 -0400
Date: Mon, 17 Apr 2006 00:05:53 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: sfr@canb.auug.org.au, linux-laptop@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] -mm: i386 apm.c optimization
Message-ID: <20060416220552.GA22998@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

- avoid expensive modulo (integer division) which happened
  since APM_MAX_EVENTS is 20 (non-power-of-2)
- kill compiler warnings by initializing two variables
- add __read_mostly to some important static variables that are read often
  (by idle loop etc.)
- constify several structures

Patch tested on 2.6.16-ck5, rediffed against 2.6.17-rc1-mm2.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc1-mm2.orig/arch/i386/kernel/apm.c linux-2.6.17-rc1-mm2/arch/i386/kernel/apm.c
--- linux-2.6.17-rc1-mm2.orig/arch/i386/kernel/apm.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-mm2/arch/i386/kernel/apm.c	2006-04-16 23:49:00.000000000 +0200
@@ -374,14 +374,14 @@
 	unsigned short	segment;
 }				apm_bios_entry;
 static int			clock_slowed;
-static int			idle_threshold = DEFAULT_IDLE_THRESHOLD;
-static int			idle_period = DEFAULT_IDLE_PERIOD;
+static int			idle_threshold __read_mostly = DEFAULT_IDLE_THRESHOLD;
+static int			idle_period __read_mostly = DEFAULT_IDLE_PERIOD;
 static int			set_pm_idle;
 static int			suspends_pending;
 static int			standbys_pending;
 static int			ignore_sys_suspend;
 static int			ignore_normal_resume;
-static int			bounce_interval = DEFAULT_BOUNCE_INTERVAL;
+static int			bounce_interval __read_mostly = DEFAULT_BOUNCE_INTERVAL;
 
 #ifdef CONFIG_APM_RTC_IS_GMT
 #	define	clock_cmos_diff	0
@@ -390,8 +390,8 @@
 static long			clock_cmos_diff;
 static int			got_clock_diff;
 #endif
-static int			debug;
-static int			smp;
+static int			debug __read_mostly;
+static int			smp __read_mostly;
 static int			apm_disabled = -1;
 #ifdef CONFIG_SMP
 static int			power_off;
@@ -403,8 +403,8 @@
 #else
 static int			realmode_power_off;
 #endif
-static int			exit_kapmd;
-static int			kapmd_running;
+static int			exit_kapmd __read_mostly;
+static int			kapmd_running __read_mostly;
 #ifdef CONFIG_APM_ALLOW_INTS
 static int			allow_ints = 1;
 #else
@@ -416,15 +416,15 @@
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *	user_list;
 static DEFINE_SPINLOCK(user_list_lock);
-static struct desc_struct	bad_bios_desc = { 0, 0x00409200 };
+static const struct desc_struct	bad_bios_desc = { 0, 0x00409200 };
 
-static char			driver_version[] = "1.16ac";	/* no spaces */
+static const char		driver_version[] = "1.16ac";	/* no spaces */
 
 /*
  *	APM event names taken from the APM 1.2 specification. These are
  *	the message codes that the BIOS uses to tell us about events
  */
-static char *	apm_event_name[] = {
+static const char *	const apm_event_name[] = {
 	"system standby",
 	"system suspend",
 	"normal resume",
@@ -616,7 +616,7 @@
  *	@ecx_in: ECX register value for BIOS call
  *	@eax: EAX register on return from the BIOS call
  *
- *	Make a BIOS call that does only returns one value, or just status.
+ *	Make a BIOS call that returns one value only, or just status.
  *	If there is an error, then the error code is returned in AH
  *	(bits 8-15 of eax) and this function returns non-zero. This is
  *	used for simpler BIOS operations. This call may hold interrupts
@@ -822,7 +822,7 @@
 #define IDLE_CALC_LIMIT   (HZ * 100)
 #define IDLE_LEAKY_MAX    16
 
-static void (*original_pm_idle)(void);
+static void (*original_pm_idle)(void) __read_mostly;
 
 /**
  * apm_cpu_idle		-	cpu idling for APM capable Linux
@@ -1063,7 +1063,8 @@
  
 static int apm_console_blank(int blank)
 {
-	int error, i;
+	int error = APM_NOT_ENGAGED; /* silence gcc */
+	int i;
 	u_short state;
 	static const u_short dev[3] = { 0x100, 0x1FF, 0x101 };
 
@@ -1104,7 +1105,8 @@
 
 static apm_event_t get_queued_event(struct apm_user *as)
 {
-	as->event_tail = (as->event_tail + 1) % APM_MAX_EVENTS;
+	if (++as->event_tail >= APM_MAX_EVENTS)
+		as->event_tail = 0;
 	return as->events[as->event_tail];
 }
 
@@ -1118,13 +1120,16 @@
 	for (as = user_list; as != NULL; as = as->next) {
 		if ((as == sender) || (!as->reader))
 			continue;
-		as->event_head = (as->event_head + 1) % APM_MAX_EVENTS;
+		if (++as->event_head >= APM_MAX_EVENTS)
+			as->event_head = 0;
+
 		if (as->event_head == as->event_tail) {
 			static int notified;
 
 			if (notified++ == 0)
 			    printk(KERN_ERR "apm: an event queue overflowed\n");
-			as->event_tail = (as->event_tail + 1) % APM_MAX_EVENTS;
+			if (++as->event_tail >= APM_MAX_EVENTS)
+				as->event_tail = 0;
 		}
 		as->events[as->event_head] = event;
 		if ((!as->suser) || (!as->writer))
@@ -1282,7 +1287,7 @@
 static apm_event_t get_event(void)
 {
 	int		error;
-	apm_event_t	event;
+	apm_event_t	event = APM_NO_EVENTS; /* silence gcc */
 	apm_eventinfo_t	info;
 
 	static int notified;
