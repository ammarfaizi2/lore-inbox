Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282955AbRLQWWq>; Mon, 17 Dec 2001 17:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282959AbRLQWWi>; Mon, 17 Dec 2001 17:22:38 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:35344 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282955AbRLQWWb>; Mon, 17 Dec 2001 17:22:31 -0500
Date: Mon, 17 Dec 2001 22:22:24 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: APM driver patch summary
Message-ID: <20011217222224.C6418@flint.arm.linux.org.uk>
In-Reply-To: <1008613695.4859.84.camel@thanatos> <20011217220402.A6418@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011217220402.A6418@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Dec 17, 2001 at 10:04:02PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 10:04:02PM +0000, Russell King wrote:
> On Mon, Dec 17, 2001 at 01:28:13PM -0500, Thomas Hood wrote:
> > Each of these changes is required, IMHO.  However, the Russell King
> > patch probably won't apply without modifications.  Also, it needs to
> > be modified so that it will send a resume event to listeners in case
> > a driver rejects a suspend event that listeners have already
> > processed.
> 
> It does do that - check the suspend() function.

Actually you're right, it doesn't send a resume event.  However, It's
worse than that - it will leave all sleeping listeners still sleeping.

Try this patch instead - this should cause all listeners to get a -EIO
to indicate that the suspend failed, and also get the resume event.

Thanks for finding that.  This (untested) patch should fix the problem.
(difference is in suspend()):

--- orig/arch/i386/kernel/apm.c	Fri Nov 23 10:12:07 2001
+++ linux/arch/i386/kernel/apm.c	Mon Dec 17 22:20:03 2001
@@ -1133,40 +1133,22 @@
 #endif
 }
 
-static int send_event(apm_event_t event)
-{
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
-			if (apm_info.connection_version > 0x100)
-				apm_set_power_state(APM_STATE_REJECT);
-			return 0;
-		}
-		break;
-	case APM_NORMAL_RESUME:
-	case APM_CRITICAL_RESUME:
-		/* map all resumes to ACPI D0 */
-		(void) pm_send_all(PM_RESUME, (void *)0);
-		break;
-	}
-
-	return 1;
-}
-
-static int suspend(void)
+static int suspend(int vetoable)
 {
 	int		err;
 	struct apm_user	*as;
 
+	if (pm_send_all(PM_SUSPEND, (void *)3)) {
+		if (!vetoable) {
+			printk(KERN_CRIT
+			       "apm: suspend was vetoed, expect armageddon\n");
+		} else if (apm_info.connection_version > 0x100) {
+			apm_set_power_state(APM_STATE_REJECT);
+			err = -EIO;
+			goto out;
+		}
+	}
+
 	get_time_diff();
 	cli();
 	err = apm_set_power_state(APM_STATE_SUSPEND);
@@ -1176,12 +1158,17 @@
 		err = APM_SUCCESS;
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
-	send_event(APM_NORMAL_RESUME);
 	sti();
+
+	pm_send_all(PM_RESUME, (void *)0);
+
+	err = (err == APM_SUCCESS) ? 0 : -EIO;
+
+ out:
 	queue_event(APM_NORMAL_RESUME, NULL);
 	for (as = user_list; as != NULL; as = as->next) {
 		as->suspend_wait = 0;
-		as->suspend_result = ((err == APM_SUCCESS) ? 0 : -EIO);
+		as->suspend_result = err;
 	}
 	ignore_normal_resume = 1;
 	wake_up_interruptible(&apm_suspend_waitqueue);
@@ -1241,11 +1228,9 @@
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
@@ -1270,12 +1255,10 @@
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
@@ -1287,7 +1270,7 @@
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
 				set_time();
-				send_event(event);
+				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
 			}
 			break;
@@ -1295,7 +1278,6 @@
 		case APM_CAPABILITY_CHANGE:
 		case APM_LOW_BATTERY:
 		case APM_POWER_STATUS_CHANGE:
-			send_event(event);
 			queue_event(event, NULL);
 			break;
 
@@ -1304,12 +1286,11 @@
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
@@ -1479,9 +1460,7 @@
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
@@ -1491,13 +1470,10 @@
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
@@ -1528,7 +1504,7 @@
 	if (as->suspends_pending > 0) {
 		suspends_pending -= as->suspends_pending;
 		if (suspends_pending <= 0)
-			(void) suspend();
+			(void) suspend(1);
 	}
 	if (user_list == as)
 		user_list = as->next;


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

