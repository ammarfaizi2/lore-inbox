Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289015AbSAUCvq>; Sun, 20 Jan 2002 21:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289017AbSAUCv2>; Sun, 20 Jan 2002 21:51:28 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:41937 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S289015AbSAUCvP>;
	Sun, 20 Jan 2002 21:51:15 -0500
Date: Mon, 21 Jan 2002 13:50:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linux-kernel@vger.kernel.org
Cc: "Udo A. Steinberg" <reality@delusion.de>
Subject: [PATCH] Combined APM patch for 2.5.3-pre2
Message-Id: <20020121135046.574bfa60.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is the same patch as the 2.4 combined APM patch I posted earlier,
but against 2.5.3-pre2.  It does:
	Update a couple of email addresses
	Fix the idle handling (this is an improved version of the fix
		that Alan Cox has in his -ac tree)
	Notify user mode of suspend events before drivers (fix)
	Make the idling percentage boot time configurable
	Rename kapm-idled to kapmd

As a bonus, it makes apm compile! :-)

Anyone brave enough to run 2.5.3-pre on their laptop, please test
and let me know the results.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.3-pre2/arch/i386/kernel/apm.c 2.5.3-pre2-APM.1/arch/i386/kernel/apm.c
--- 2.5.3-pre2/arch/i386/kernel/apm.c	Mon Jan 21 01:16:27 2002
+++ 2.5.3-pre2-APM.1/arch/i386/kernel/apm.c	Mon Jan 21 11:05:19 2002
@@ -39,6 +39,7 @@
  * Feb 2000, Version 1.13
  * Nov 2000, Version 1.14
  * Oct 2001, Version 1.15
+ * Jan 2002, Version 1.16
  *
  * History:
  *    0.6b: first version in official kernel, Linux 1.3.46
@@ -85,7 +86,7 @@
  *         change APM_NOINTS to CONFIG_APM_ALLOW_INTS
  *         remove dependency on CONFIG_PROC_FS
  *         Stephen Rothwell
- *    1.9: Fix small typo.  <laslo@ilo.opole.pl>
+ *    1.9: Fix small typo.  <laslo@wodip.opole.pl>
  *         Try to cope with BIOS's that need to have all display
  *         devices blanked and not just the first one.
  *         Ross Paterson <ross@soi.city.ac.uk>
@@ -164,8 +165,18 @@
  *         If an APM idle fails log it and idle sensibly
  *   1.15: Don't queue events to clients who open the device O_WRONLY.
  *         Don't expect replies from clients who open the device O_RDONLY.
- *         (Idea from Thomas Hood <jdthood at yahoo.co.uk>)
- *         Minor waitqueue cleanups.(John Fremlin <chief@bandits.org>)
+ *         (Idea from Thomas Hood <jdthood@mail.com>)
+ *         Minor waitqueue cleanups. (John Fremlin <chief@bandits.org>)
+ *   1.16: Fix idle calling. (Andreas Steinmetz <ast@domdv.de> et al.)
+ *         Notify listeners of standby or suspend events before notifying
+ *         drivers. Return EBUSY to ioctl() if suspend is rejected.
+ *         (Russell King <rmk@arm.linux.org.uk> and Thomas Hood)
+ *         Ignore first resume after we generate our own resume event
+ *         after a suspend (Thomas Hood <jdthood@mail.com>)
+ *         Daemonize now gets rid of our controlling terminal (sfr).
+ *         CONFIG_APM_CPU_IDLE now just affects the default value of
+ *         idle_threshold (sfr).
+ *         Change name of kernel apm daemon (as it no longer idles) (sfr).
  *
  * APM 1.1 Reference:
  *
@@ -238,6 +249,12 @@
  *	    [no-]power[-_]off		power off on shutdown
  *	    bounce[-_]interval=<n>	number of ticks to ignore suspend
  *	    				bounces
+ *          idle[-_]threshold=<n>       System idle percentage above which to
+ *                                      make APM BIOS idle calls. Set it to
+ *                                      100 to disable.
+ *          idle[-_]period=<n>          Period (in 1/100s of a second) over
+ *                                      which the idle percentage is
+ *                                      calculated.
  */
 
 /* KNOWN PROBLEM MACHINES:
@@ -341,15 +358,26 @@
 #define APM_BIOS_MAGIC		0x4101
 
 /*
+ * idle percentage above which bios idle calls are done
+ */
+#ifdef CONFIG_APM_CPU_IDLE
+#define DEFAULT_IDLE_THRESHOLD	95
+#else
+#define DEFAULT_IDLE_THRESHOLD	100
+#endif
+#define DEFAULT_IDLE_PERIOD	(100 / 3)
+
+/*
  * Local variables
  */
 static struct {
 	unsigned long	offset;
 	unsigned short	segment;
 }				apm_bios_entry;
-#ifdef CONFIG_APM_CPU_IDLE
 static int			clock_slowed;
-#endif
+static int			idle_threshold = DEFAULT_IDLE_THRESHOLD;
+static int			idle_period = DEFAULT_IDLE_PERIOD;
+static int			set_pm_idle;
 static int			suspends_pending;
 static int			standbys_pending;
 static int			waiting_for_resume;
@@ -389,7 +417,7 @@
 static struct apm_user *	user_list;
 static spinlock_t		user_list_lock = SPIN_LOCK_UNLOCKED;
 
-static char			driver_version[] = "1.15";	/* no spaces */
+static char			driver_version[] = "1.16";	/* no spaces */
 
 /*
  *	APM event names taken from the APM 1.2 specification. These are
@@ -685,8 +713,6 @@
 	return set_power_state(APM_DEVICE_ALL, state);
 }
 
-#ifdef CONFIG_APM_CPU_IDLE
-
 /**
  *	apm_do_idle	-	perform power saving
  *
@@ -736,63 +762,89 @@
 	}
 }
 
-#if 0
-extern int hlt_counter;
-
 /*
- * If no process has been interested in this
- * CPU for some time, we want to wake up the
- * power management thread - we probably want
+ * If no process has really been interested in
+ * the CPU for some time, we want to call BIOS
+ * power management - we probably want
  * to conserve power.
  */
-#define HARD_IDLE_TIMEOUT (HZ/3)
+#define IDLE_CALC_LIMIT   (HZ * 100)
+#define IDLE_LEAKY_MAX    16
 
-/* This should wake up kapmd and ask it to slow the CPU */
-#define powermanagement_idle()  do { } while (0)
+static void (*sys_idle)(void);
+
+extern void default_idle(void);
 
 /**
  * apm_cpu_idle		-	cpu idling for APM capable Linux
  *
  * This is the idling function the kernel executes when APM is available. It 
- * tries to save processor time directly by using hlt instructions. A
- * separate apm thread tries to do the BIOS power management.
- *
- * N.B. This is curently not used for kernels 2.4.x.
+ * tries to do BIOS powermanagement based on the average system idle time.
+ * Furthermore it calls the system default idle routine.
  */
 
 static void apm_cpu_idle(void)
 {
-	unsigned int start_idle;
+	static int use_apm_idle = 0;
+	static unsigned int last_jiffies = 0;
+	static unsigned int last_stime = 0;
+
+	int apm_is_idle = 0;
+	unsigned int jiffies_since_last_check = jiffies - last_jiffies;
+	unsigned int t1;
+
+
+recalc:
+	if (jiffies_since_last_check > IDLE_CALC_LIMIT) {
+		use_apm_idle = 0;
+		last_jiffies = jiffies;
+		last_stime = current->times.tms_stime;
+	} else if (jiffies_since_last_check > idle_period) {
+		unsigned int idle_percentage;
+
+		idle_percentage = current->times.tms_stime - last_stime;
+		idle_percentage *= 100;
+		idle_percentage /= jiffies_since_last_check;
+		use_apm_idle = (idle_percentage > idle_threshold);
+		last_jiffies = jiffies;
+		last_stime = current->times.tms_stime;
+	}
+
+	t1 = IDLE_LEAKY_MAX;
+
+	while (!need_resched()) {
+		if (use_apm_idle) {
+			unsigned int t;
 
-	start_idle = jiffies;
-	while (1) {
-		if (!need_resched()) {
-			if (jiffies - start_idle < HARD_IDLE_TIMEOUT) {
-				if (!current_cpu_data.hlt_works_ok)
-					continue;
-				if (hlt_counter)
+			t = jiffies;
+			switch (apm_do_idle()) {
+			case 0: apm_is_idle = 1;
+				if (t != jiffies) {
+					if (t1) {
+						t1 = IDLE_LEAKY_MAX;
+						continue;
+					}
+				} else if (t1) {
+					t1--;
 					continue;
-				__cli();
-				if (!need_resched())
-					safe_halt();
-				else
-					__sti();
-				continue;
+				}
+				break;
+			case 1: apm_is_idle = 1;
+				break;
 			}
-
-			/*
-			 * Ok, do some power management - we've been idle for too long
-			 */
-			powermanagement_idle();
 		}
-
-		schedule();
-		check_pgt_cache();
-		start_idle = jiffies;
+		if (sys_idle)
+			sys_idle();
+		else
+			default_idle();
+		jiffies_since_last_check = jiffies - last_jiffies;
+		if (jiffies_since_last_check > idle_period)
+			goto recalc;
 	}
+
+	if (apm_is_idle)
+		apm_do_busy();
 }
-#endif
-#endif
 
 #ifdef CONFIG_SMP
 static int apm_magic(void * unused)
@@ -1137,59 +1189,44 @@
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
+			waiting_for_resume = 0;
+			printk(KERN_WARNING "apm: suspend was vetoed.\n");
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
+	ignore_normal_resume = 1;
+ out:
 	spin_lock(&user_list_lock);
 	for (as = user_list; as != NULL; as = as->next) {
 		as->suspend_wait = 0;
-		as->suspend_result = ((err == APM_SUCCESS) ? 0 : -EIO);
+		as->suspend_result = err;
 	}
 	spin_unlock(&user_list_lock);
-	ignore_normal_resume = 1;
 	wake_up_interruptible(&apm_suspend_waitqueue);
 	return err;
 }
@@ -1198,6 +1235,7 @@
 {
 	int	err;
 
+	/* If needed, notify drivers here */
 	get_time_diff();
 	err = apm_set_power_state(APM_STATE_STANDBY);
 	if ((err != APM_SUCCESS) && (err != APM_NO_ERROR))
@@ -1241,17 +1279,13 @@
 		if (ignore_bounce
 		    && ((jiffies - last_resume) > bounce_interval))
 			ignore_bounce = 0;
-		if (ignore_normal_resume && (event != APM_NORMAL_RESUME))
-			ignore_normal_resume = 0;
 
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
@@ -1276,12 +1310,10 @@
 			 */
 			if (waiting_for_resume)
 				return;
-			if (send_event(event)) {
-				queue_event(event, NULL);
-				waiting_for_resume = 1;
-				if (suspends_pending <= 0)
-					(void) suspend();
-			}
+			waiting_for_resume = 1;
+			queue_event(event, NULL);
+			if (suspends_pending <= 0)
+				(void) suspend(1);
 			break;
 
 		case APM_NORMAL_RESUME:
@@ -1293,16 +1325,17 @@
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
 				set_time();
-				send_event(event);
+				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
 			}
+			ignore_normal_resume = 0;
 			break;
 
 		case APM_CAPABILITY_CHANGE:
 		case APM_LOW_BATTERY:
 		case APM_POWER_STATUS_CHANGE:
-			send_event(event);
 			queue_event(event, NULL);
+			/* If needed, notify drivers here */
 			break;
 
 		case APM_UPDATE_TIME:
@@ -1310,12 +1343,10 @@
 			break;
 
 		case APM_CRITICAL_SUSPEND:
-			send_event(event);
 			/*
-			 * We can only hope it worked - we are not allowed
-			 * to reject a critical suspend.
+			 * We are not allowed to reject a critical suspend.
 			 */
-			(void) suspend();
+			(void) suspend(0);
 			break;
 		}
 	}
@@ -1343,63 +1374,24 @@
 
 /*
  * This is the APM thread main loop.
- *
- * Check whether we're the only running process to
- * decide if we should just power down.
- *
  */
-#define system_idle() (nr_running == 1)
 
 static void apm_mainloop(void)
 {
-	int timeout = HZ;
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue(&apm_waitqueue, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	for (;;) {
-		/* Nothing to do, just sleep for the timeout */
-		timeout = 2 * timeout;
-		if (timeout > APM_CHECK_TIMEOUT)
-			timeout = APM_CHECK_TIMEOUT;
-		schedule_timeout(timeout);
+		schedule_timeout(APM_CHECK_TIMEOUT);
 		if (exit_kapmd)
 			break;
-
 		/*
 		 * Ok, check all events, check for idle (and mark us sleeping
 		 * so as not to count towards the load average)..
 		 */
 		set_current_state(TASK_INTERRUPTIBLE);
 		apm_event_handler();
-#ifdef CONFIG_APM_CPU_IDLE
-		if (!system_idle())
-			continue;
-		
-		/*
-		 *	If we can idle...
-		 */
-		if (apm_do_idle() != -1) {
-			unsigned long start = jiffies;
-			while ((!exit_kapmd) && system_idle()) {
-				if (apm_do_idle()) {
-					set_current_state(TASK_INTERRUPTIBLE);
-					/* APM needs us to snooze .. either
-					   the BIOS call failed (-1) or it
-					   slowed the clock (1). We sleep
-					   until it talks to us again */
-					schedule_timeout(1);
-				}
-				if ((jiffies - start) > APM_CHECK_TIMEOUT) {
-					apm_event_handler();
-					start = jiffies;
-				}
-			}
-			apm_do_busy();
-			apm_event_handler();
-			timeout = 1;
-		}
-#endif
 	}
 	remove_wait_queue(&apm_waitqueue, &wait);
 }
@@ -1485,9 +1477,7 @@
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
@@ -1497,13 +1487,10 @@
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
@@ -1533,7 +1520,7 @@
 	if (as->suspends_pending > 0) {
 		suspends_pending -= as->suspends_pending;
 		if (suspends_pending <= 0)
-			(void) suspend();
+			(void) suspend(1);
 	}
   	spin_lock(&user_list_lock);
 	if (user_list == as)
@@ -1684,9 +1671,8 @@
 
 	daemonize();
 
-	strcpy(current->comm, "kapm-idled");
+	strcpy(current->comm, "kapmd");
 	sigfillset(&current->blocked);
-	current->tty = NULL;	/* get rid of controlling tty */
 
 	if (apm_info.connection_version == 0) {
 		apm_info.connection_version = apm_info.bios.version;
@@ -1805,7 +1791,14 @@
 		if ((strncmp(str, "bounce-interval=", 16) == 0) ||
 		    (strncmp(str, "bounce_interval=", 16) == 0))
 			bounce_interval = simple_strtol(str + 16, NULL, 0);
-		invert = (strncmp(str, "no-", 3) == 0);
+		if ((strncmp(str, "idle-threshold=", 15) == 0) ||
+		    (strncmp(str, "idle_threshold=", 15) == 0))
+			idle_threshold = simple_strtol(str + 15, NULL, 0);
+		if ((strncmp(str, "idle-period=", 12) == 0) ||
+		    (strncmp(str, "idle_period=", 12) == 0))
+			idle_threshold = simple_strtol(str + 15, NULL, 0);
+		invert = (strncmp(str, "no-", 3) == 0) ||
+			(strncmp(str, "no_", 3) == 0);
 		if (invert)
 			str += 3;
 		if (strncmp(str, "debug", 5) == 0)
@@ -1976,6 +1969,14 @@
 
 	misc_register(&apm_device);
 
+	if (HZ != 100)
+		idle_period = (idle_period * HZ) / 100;
+	if (idle_threshold < 100) {
+		sys_idle = pm_idle;
+		pm_idle  = apm_cpu_idle;
+		set_pm_idle = 1;
+	}
+
 	return 0;
 }
 
@@ -1983,6 +1984,8 @@
 {
 	int	error;
 
+	if (set_pm_idle)
+		pm_idle = sys_idle;
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) == 0)
 	    && (apm_info.connection_version > 0x0100)) {
 		error = apm_engage_power_management(APM_DEVICE_ALL, 0);
@@ -2020,5 +2023,11 @@
 MODULE_PARM(realmode_power_off, "i");
 MODULE_PARM_DESC(realmode_power_off,
 		"Switch to real mode before powering off");
+MODULE_PARM(idle_threshold, "i");
+MODULE_PARM_DESC(idle_threshold,
+	"System idle percentage above which to make APM BIOS idle calls");
+MODULE_PARM(idle_period, "i");
+MODULE_PARM_DESC(idle_period,
+	"Period (in sec/100) over which to caculate the idle percentage");
 
 EXPORT_NO_SYMBOLS;
diff -ruN 2.5.3-pre2/arch/i386/kernel/i386_ksyms.c 2.5.3-pre2-APM.1/arch/i386/kernel/i386_ksyms.c
--- 2.5.3-pre2/arch/i386/kernel/i386_ksyms.c	Thu Nov 29 23:32:06 2001
+++ 2.5.3-pre2-APM.1/arch/i386/kernel/i386_ksyms.c	Fri Jan 18 11:56:29 2002
@@ -35,6 +35,8 @@
 #if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
 extern void machine_real_restart(unsigned char *, int);
 EXPORT_SYMBOL(machine_real_restart);
+extern void default_idle(void);
+EXPORT_SYMBOL(default_idle);
 #endif
 
 #ifdef CONFIG_SMP
diff -ruN 2.5.3-pre2/arch/i386/kernel/process.c 2.5.3-pre2-APM.1/arch/i386/kernel/process.c
--- 2.5.3-pre2/arch/i386/kernel/process.c	Mon Jan 21 01:16:27 2002
+++ 2.5.3-pre2-APM.1/arch/i386/kernel/process.c	Mon Jan 21 11:07:12 2002
@@ -76,7 +76,7 @@
  * We use this if we don't have any better
  * idle routine..
  */
-static void default_idle(void)
+void default_idle(void)
 {
 	if (current_cpu_data.hlt_works_ok && !hlt_counter) {
 		__cli();
