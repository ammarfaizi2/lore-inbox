Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282839AbRLLWu1>; Wed, 12 Dec 2001 17:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282848AbRLLWuI>; Wed, 12 Dec 2001 17:50:08 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:27408 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282839AbRLLWuH>; Wed, 12 Dec 2001 17:50:07 -0500
Date: Wed, 12 Dec 2001 22:49:57 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: jdthood@mail.com
Subject: Re: USB not processing APM suspend event properly?
Message-ID: <20011212224957.D16377@flint.arm.linux.org.uk>
In-Reply-To: <1008195310.1126.17.camel@thanatos> <E16EI4D-0002h7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16EI4D-0002h7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Dec 12, 2001 at 10:41:33PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 10:41:33PM +0000, Alan Cox wrote:
> > my USB mouse, but then tried (twice) to reconnect it again
> > while the apm driver was still processing the suspend.  The
> > attempts to reconnect failed.  I presume there is something
> > wrong with this picture.  Does this indicate a bug in
> > USB power management?
> 
> More it indicates a bug in the APM code. Have a look at Russell King's
> patches which actually issue the APM and user mode events in the right
> order. There is a USB problem there too, but the USB problem can't be fixed
> sanely until the APM order is fixed

And for those who have an interest, here's the patch...  It might be
outdated a little now though.  It came out of a problem I had on my
laptop, where the machine drove itself into total battery exhaustion
because Linux wouldn't let the APM bios suspend/hibernate the machine.

This was caused by the PCMCIA network interface being off, and the apmd
scripts trying to fuser -k and unmount an in-use NFS partition, which
in turn wanted to generate NFS traffic to the server over the shut down
PCMCIA network interface...

--------------------- original mail follows --------------------

Basically, I've changed the order that things happen on suspend, such that
we always pass the event to apmd, and any other listeners on /dev/apm_bios.
Once everyone has replied (subject to the rules of course), it then sends
the PM_SUSPEND to the devices.

The original code sent PM_SUSPEND on receiving the original request, and
then multiple times each time a listener on /dev/apm_bios replied.  Not
good if apmd wants to unmount NFS, and your NFS mounts require traffic
over your PCMCIA ether card!


--- orig/arch/i386/kernel/apm.c	Wed Nov  7 14:46:35 2001
+++ linux/arch/i386/kernel/apm.c	Wed Nov  7 15:01:22 2001
@@ -1133,40 +1133,21 @@
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
+			return -EIO;
+		}
+	}
+
 	get_time_diff();
 	cli();
 	err = apm_set_power_state(APM_STATE_SUSPEND);
@@ -1176,12 +1157,15 @@
 		err = APM_SUCCESS;
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
-	send_event(APM_NORMAL_RESUME);
 	sti();
+
+	pm_send_all(PM_RESUME, (void *)0);
+
 	queue_event(APM_NORMAL_RESUME, NULL);
+	err = (err == APM_SUCCESS) ? 0 : -EIO;
 	for (as = user_list; as != NULL; as = as->next) {
 		as->suspend_wait = 0;
-		as->suspend_result = ((err == APM_SUCCESS) ? 0 : -EIO);
+		as->suspend_result = err;
 	}
 	ignore_normal_resume = 1;
 	wake_up_interruptible(&apm_suspend_waitqueue);
@@ -1241,11 +1225,9 @@
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
@@ -1270,12 +1252,10 @@
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
@@ -1287,7 +1267,7 @@
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
 				set_time();
-				send_event(event);
+				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
 			}
 			break;
@@ -1295,7 +1275,6 @@
 		case APM_CAPABILITY_CHANGE:
 		case APM_LOW_BATTERY:
 		case APM_POWER_STATUS_CHANGE:
-			send_event(event);
 			queue_event(event, NULL);
 			break;
 
@@ -1304,12 +1283,11 @@
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
@@ -1479,9 +1457,7 @@
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
@@ -1491,13 +1467,10 @@
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
@@ -1528,7 +1501,7 @@
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

