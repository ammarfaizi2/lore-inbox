Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbRLRVsN>; Tue, 18 Dec 2001 16:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285210AbRLRVqz>; Tue, 18 Dec 2001 16:46:55 -0500
Received: from hermes.toad.net ([162.33.130.251]:24785 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S285180AbRLRVqV>;
	Tue, 18 Dec 2001 16:46:21 -0500
Subject: Re: APM driver patch summary
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, 125612@bugs.debian.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 18 Dec 2001 16:46:20 -0500
Message-Id: <1008711982.21128.4.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Let's try that again, with the promised patch appended .. grrr]

Here is an updated list of the patches:

Notify listener of suspend before notifying driver  (Russell King / me)
    (appended)
Fix idle handling                                   (Andreas Steinmetz)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100754277600661&w=2
Control apm idle calling by runtime parameter       (Andrej Borsenkow)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100852862320955&w=2
Detect failure to stop CPU on apm idle call         (Andrej Borsenkow)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100869841008117&w=2

I added the last one which was posted today (18 Dec).

I have modified Russell's patch to notify (of standbys & suspends)
listeners before drivers.  I made the following changes:

Return -EBUSY instead of -EIO (or -EAGAIN) to listeners if a driver
   rejects suspend request.  (Suggestion from apmd maintainer.
   Is this okay?)
Move "sti()" up a bit inside suspend() function. (Should be harmless.)
Move "ignore_normal_resume = 1" before "sti()"  (to make sure that
   normal resumes are rejected even if this func is interrupted).
Move "out:" after "queue_event" so that no RESUME event will be
   queued if the suspend is skipped. (Listeners must notice the
   EBUSY return code and undo whatever they did to prepare for 
   the suspend.)
Recode suspend() a bit to make it easier to read.
   (Unfortunately this makes the patch harder to read.  Sorry.)
Skip doing the suspend even if APM version is 0x100 (... just don't
   try to set APM_STATE_REJECT.  I don't see why this should be
   a problem, judging from a quick read of the APM spec).
Also, move definition of waiting_for_resume inside check_events()
   where it belongs.

The driver compiles with this patch, but I haven't tested it yet.

I still have one worry about the driver with this patch applied.
If a user requests a suspend and it is rejected by a driver
(and the APM version > 0x100) then APM_STATE_REJECT is sent
to the BIOS.  If the BIOS didn't generate the request then this
REJECT is comes out of the blue.  Is that acceptable, or
should we refrain from sending such REJECTS when the suspend
request didn't come from the BIOS?

--
Thomas

--- linux-2.4.17-rc1_ORIG/arch/i386/kernel/apm.c	Tue Nov 27 18:59:54 2001
+++ linux-2.4.17-rc1/arch/i386/kernel/apm.c	Tue Dec 18 16:39:38 2001
@@ -349,13 +349,12 @@
 }				apm_bios_entry;
 #ifdef CONFIG_APM_CPU_IDLE
 static int			clock_slowed;
 #endif
 static int			suspends_pending;
 static int			standbys_pending;
-static int			waiting_for_resume;
 static int			ignore_normal_resume;
 static int			bounce_interval = DEFAULT_BOUNCE_INTERVAL;
 
 #ifdef CONFIG_APM_RTC_IS_GMT
 #	define	clock_cmos_diff	0
 #	define	got_clock_diff	1
@@ -1130,63 +1129,46 @@
 	outb(LATCH >> 8 , 0x40);	/* MSB */
 	udelay(10);
 	restore_flags(flags);
 #endif
 }
 
-static int send_event(apm_event_t event)
+static int suspend(int vetoable)
 {
-	switch (event) {
-	case APM_SYS_SUSPEND:
-	case APM_CRITICAL_SUSPEND:
-	case APM_USER_SUSPEND:
-		/* map all suspends to ACPI D3 */
-		if (pm_send_all(PM_SUSPEND, (void *)3)) {
-			if (event == APM_CRITICAL_SUSPEND) {
-				printk(KERN_CRIT
-					"apm: Critical suspend was vetoed, "
-					"expect armageddon\n" );
-				return 0;
-			}
+	int		err;
+	struct apm_user	*as;
+
+	if (pm_send_all(PM_SUSPEND, (void *)3)) {
+		/* Vetoed */
+		if (vetoable) {
 			if (apm_info.connection_version > 0x100)
 				apm_set_power_state(APM_STATE_REJECT);
-			return 0;
+			err = -EBUSY;
+			goto out;
 		}
-		break;
-	case APM_NORMAL_RESUME:
-	case APM_CRITICAL_RESUME:
-		/* map all resumes to ACPI D0 */
-		(void) pm_send_all(PM_RESUME, (void *)0);
-		break;
+		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
-
-	return 1;
-}
-
-static int suspend(void)
-{
-	int		err;
-	struct apm_user	*as;
-
 	get_time_diff();
 	cli();
 	err = apm_set_power_state(APM_STATE_SUSPEND);
 	reinit_timer();
 	set_time();
+	ignore_normal_resume = 1;
+	sti();
 	if (err == APM_NO_ERROR)
 		err = APM_SUCCESS;
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
-	send_event(APM_NORMAL_RESUME);
-	sti();
+	err = (err == APM_SUCCESS) ? 0 : -EIO;
+	pm_send_all(PM_RESUME, (void *)0);
 	queue_event(APM_NORMAL_RESUME, NULL);
+ out:
 	for (as = user_list; as != NULL; as = as->next) {
 		as->suspend_wait = 0;
-		as->suspend_result = ((err == APM_SUCCESS) ? 0 : -EIO);
+		as->suspend_result = err;
 	}
-	ignore_normal_resume = 1;
 	wake_up_interruptible(&apm_suspend_waitqueue);
 	return err;
 }
 
 static void standby(void)
 {
@@ -1219,12 +1201,13 @@
 
 static void check_events(void)
 {
 	apm_event_t		event;
 	static unsigned long	last_resume;
 	static int		ignore_bounce;
+	static int		waiting_for_resume; /* = 0 */
 
 	while ((event = get_event()) != 0) {
 		if (debug) {
 			if (event <= NR_APM_EVENT_NAME)
 				printk(KERN_DEBUG "apm: received %s notify\n",
 				       apm_event_name[event - 1]);
@@ -1238,17 +1221,15 @@
 		if (ignore_normal_resume && (event != APM_NORMAL_RESUME))
 			ignore_normal_resume = 0;
 
 		switch (event) {
 		case APM_SYS_STANDBY:
 		case APM_USER_STANDBY:
-			if (send_event(event)) {
-				queue_event(event, NULL);
-				if (standbys_pending <= 0)
-					standby();
-			}
+			queue_event(event, NULL);
+			if (standbys_pending <= 0)
+				standby();
 			break;
 
 		case APM_USER_SUSPEND:
 #ifdef CONFIG_APM_IGNORE_USER_SUSPEND
 			if (apm_info.connection_version > 0x100)
 				apm_set_power_state(APM_STATE_REJECT);
@@ -1267,52 +1248,48 @@
 			 * cope with the fact that the Thinkpads keep
 			 * sending a SUSPEND event until something else
 			 * happens!
 			 */
 			if (waiting_for_resume)
 				return;
-			if (send_event(event)) {
-				queue_event(event, NULL);
-				waiting_for_resume = 1;
-				if (suspends_pending <= 0)
-					(void) suspend();
-			}
+			queue_event(event, NULL);
+			waiting_for_resume = 1;
+			if (suspends_pending <= 0)
+				(void) suspend(1);
 			break;
 
 		case APM_NORMAL_RESUME:
 		case APM_CRITICAL_RESUME:
 		case APM_STANDBY_RESUME:
 			waiting_for_resume = 0;
 			last_resume = jiffies;
 			ignore_bounce = 1;
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
 				set_time();
-				send_event(event);
+				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
 			}
 			break;
 
 		case APM_CAPABILITY_CHANGE:
 		case APM_LOW_BATTERY:
 		case APM_POWER_STATUS_CHANGE:
-			send_event(event);
 			queue_event(event, NULL);
 			break;
 
 		case APM_UPDATE_TIME:
 			set_time();
 			break;
 
 		case APM_CRITICAL_SUSPEND:
-			send_event(event);
 			/*
 			 * We can only hope it worked - we are not allowed
 			 * to reject a critical suspend.
 			 */
-			(void) suspend();
+			(void) suspend(0);
 			break;
 		}
 	}
 }
 
 static void apm_event_handler(void)
@@ -1476,31 +1453,26 @@
 	switch (cmd) {
 	case APM_IOC_STANDBY:
 		if (as->standbys_read > 0) {
 			as->standbys_read--;
 			as->standbys_pending--;
 			standbys_pending--;
-		} else if (!send_event(APM_USER_STANDBY))
-			return -EAGAIN;
-		else
+		} else
 			queue_event(APM_USER_STANDBY, as);
 		if (standbys_pending <= 0)
 			standby();
 		break;
 	case APM_IOC_SUSPEND:
 		if (as->suspends_read > 0) {
 			as->suspends_read--;
 			as->suspends_pending--;
 			suspends_pending--;
-		} else if (!send_event(APM_USER_SUSPEND))
-			return -EAGAIN;
-		else
+		} else
 			queue_event(APM_USER_SUSPEND, as);
 		if (suspends_pending <= 0) {
-			if (suspend() != APM_SUCCESS)
-				return -EIO;
+			return suspend(1);
 		} else {
 			as->suspend_wait = 1;
 			wait_event_interruptible(apm_suspend_waitqueue,
 					as->suspend_wait == 0);
 			return as->suspend_result;
 		}
@@ -1525,13 +1497,13 @@
 		if (standbys_pending <= 0)
 			standby();
 	}
 	if (as->suspends_pending > 0) {
 		suspends_pending -= as->suspends_pending;
 		if (suspends_pending <= 0)
-			(void) suspend();
+			(void) suspend(1);
 	}
 	if (user_list == as)
 		user_list = as->next;
 	else {
 		struct apm_user *	as1;
 

