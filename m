Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288595AbSA3Fw7>; Wed, 30 Jan 2002 00:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288597AbSA3Fwu>; Wed, 30 Jan 2002 00:52:50 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:39598 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S288595AbSA3Fwc>;
	Wed, 30 Jan 2002 00:52:32 -0500
Date: Wed, 30 Jan 2002 16:50:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>,
        Greg Louis <glouis@dynamicro.on.ca>
Cc: VANDROVE@vc.cvut.cz, jdthood@mail.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, skraw@ithnet.com
Subject: Re: 2.4.18-pre7 slow ... apm problem
Message-Id: <20020130165058.0dc3147f.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0201300841160.3719-100000@boston.corp.fedex.com>
In-Reply-To: <104D80077517@vcnet.vc.cvut.cz>
	<Pine.LNX.4.44.0201300841160.3719-100000@boston.corp.fedex.com>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff, Greg and other interested parties,

Would you like to try another patch? :-)

This is rather longer than needed, it has some tidy ups from Thomas
Hood as well.  I have basically simplified the idle loop and added
a couple of more points where it can escape.

I am not seeing your problems, but then again I am running on an IBM
Thinkpad, so I do BIOS calls with interrupts enabled and the BIOS halts
on idle (as opposed to slowing the CPU).  I also have SpeedStep
disabled.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.18-pre7/arch/i386/kernel/apm.c 2.4.18-pre7-APM.1/arch/i386/kernel/apm.c
--- 2.4.18-pre7/arch/i386/kernel/apm.c	Thu Jan 24 11:33:54 2002
+++ 2.4.18-pre7-APM.1/arch/i386/kernel/apm.c	Tue Jan 29 22:56:09 2002
@@ -380,7 +380,7 @@
 static int			set_pm_idle;
 static int			suspends_pending;
 static int			standbys_pending;
-static int			waiting_for_resume;
+static int			ignore_sys_suspend;
 static int			ignore_normal_resume;
 static int			bounce_interval = DEFAULT_BOUNCE_INTERVAL;
 
@@ -761,15 +761,6 @@
 	}
 }
 
-/*
- * If no process has really been interested in
- * the CPU for some time, we want to call BIOS
- * power management - we probably want
- * to conserve power.
- */
-#define IDLE_CALC_LIMIT   (HZ * 100)
-#define IDLE_LEAKY_MAX    16
-
 static void (*sys_idle)(void);
 
 extern void default_idle(void);
@@ -777,28 +768,24 @@
 /**
  * apm_cpu_idle		-	cpu idling for APM capable Linux
  *
- * This is the idling function the kernel executes when APM is available. It 
- * tries to do BIOS powermanagement based on the average system idle time.
- * Furthermore it calls the system default idle routine.
+ * This is the idling function the kernel executes when APM is available.
+ * It tries to do BIOS power management based on the average system
+ * idle time.  Furthermore it calls the system idle routines.
  */
 
 static void apm_cpu_idle(void)
 {
-	static int use_apm_idle = 0;
-	static unsigned int last_jiffies = 0;
-	static unsigned int last_stime = 0;
-
-	int apm_is_idle = 0;
-	unsigned int jiffies_since_last_check = jiffies - last_jiffies;
-	unsigned int t1;
+	static int use_apm_idle;
+	static unsigned int last_jiffies;
+	static unsigned int last_stime;
 
+	int apm_idle_done = 0;
+	unsigned int jiffies_since_last_check;
+
+	jiffies_since_last_check = jiffies - last_jiffies;
 
 recalc:
-	if (jiffies_since_last_check > IDLE_CALC_LIMIT) {
-		use_apm_idle = 0;
-		last_jiffies = jiffies;
-		last_stime = current->times.tms_stime;
-	} else if (jiffies_since_last_check > idle_period) {
+	if (jiffies_since_last_check > idle_period) {
 		unsigned int idle_percentage;
 
 		idle_percentage = current->times.tms_stime - last_stime;
@@ -809,39 +796,33 @@
 		last_stime = current->times.tms_stime;
 	}
 
-	t1 = IDLE_LEAKY_MAX;
-
 	while (!current->need_resched) {
 		if (use_apm_idle) {
-			unsigned int t;
+			unsigned int t = jiffies;
 
-			t = jiffies;
 			switch (apm_do_idle()) {
-			case 0: apm_is_idle = 1;
-				if (t != jiffies) {
-					if (t1) {
-						t1 = IDLE_LEAKY_MAX;
-						continue;
-					}
-				} else if (t1) {
-					t1--;
+			case 0: apm_idle_done = 1;
+				if (t != jiffies)
 					continue;
-				}
 				break;
-			case 1: apm_is_idle = 1;
+			case 1: apm_idle_done = 1;
 				break;
 			}
 		}
+		if (current->need_resched)
+			break;
 		if (sys_idle)
 			sys_idle();
 		else
 			default_idle();
+		if (current->need_resched)
+			break;
 		jiffies_since_last_check = jiffies - last_jiffies;
 		if (jiffies_since_last_check > idle_period)
 			goto recalc;
 	}
 
-	if (apm_is_idle)
+	if (apm_idle_done)
 		apm_do_busy();
 }
 
@@ -1196,7 +1177,7 @@
 			if (apm_info.connection_version > 0x100)
 				apm_set_power_state(APM_STATE_REJECT);
 			err = -EBUSY;
-			waiting_for_resume = 0;
+			ignore_sys_suspend = 0;
 			printk(KERN_WARNING "apm: suspend was vetoed.\n");
 			goto out;
 		}
@@ -1295,16 +1276,15 @@
 				break;
 			}
 			/*
-			 * If we are already processing a SUSPEND,
-			 * then further SUSPEND events from the BIOS
-			 * will be ignored.  We also return here to
-			 * cope with the fact that the Thinkpads keep
-			 * sending a SUSPEND event until something else
-			 * happens!
+			 * If we are already processing a SUSPEND, then
+			 * further SUSPEND events from the BIOS should
+			 * be ignored.  We have to check for this because
+			 * Thinkpads keep sending SUSPEND events until
+			 * something else happens!
 			 */
-			if (waiting_for_resume)
+			if (ignore_sys_suspend)
 				return;
-			waiting_for_resume = 1;
+			ignore_sys_suspend = 1;
 			queue_event(event, NULL);
 			if (suspends_pending <= 0)
 				(void) suspend(1);
@@ -1313,7 +1293,7 @@
 		case APM_NORMAL_RESUME:
 		case APM_CRITICAL_RESUME:
 		case APM_STANDBY_RESUME:
-			waiting_for_resume = 0;
+			ignore_sys_suspend = 0;
 			last_resume = jiffies;
 			ignore_bounce = 1;
 			if ((event != APM_NORMAL_RESUME)
@@ -1381,7 +1361,7 @@
 		if (exit_kapmd)
 			break;
 		/*
-		 * Ok, check all events, check for idle (and mark us sleeping
+		 * Ok, check all events (and mark us sleeping
 		 * so as not to count towards the load average)..
 		 */
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1455,6 +1435,11 @@
 	return 0;
 }
 
+/*
+ * Note that the drivers may reject a suspend request.
+ * When this happens, no suspend is done, and the ioctl()
+ * returns the EBUSY error code to the user.
+ */
 static int do_ioctl(struct inode * inode, struct file *filp,
 		    u_int cmd, u_long arg)
 {
