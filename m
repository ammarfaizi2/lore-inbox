Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286789AbRLVO51>; Sat, 22 Dec 2001 09:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286790AbRLVO5T>; Sat, 22 Dec 2001 09:57:19 -0500
Received: from hermes.domdv.de ([193.102.202.1]:1553 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S286789AbRLVO5C>;
	Sat, 22 Dec 2001 09:57:02 -0500
Message-ID: <XFMail.20011222154452.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.5.1.Linux:20011222153709:1483=_"
In-Reply-To: <1008992132.805.6.camel@thanatos>
Date: Sat, 22 Dec 2001 15:44:52 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Thomas Hood <jdthood@mail.com>
Subject: Re: APM driver patch summary
Cc: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>, rmk@arm.linux.org.uk,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.5.1.Linux:20011222153709:1483=_
Content-Type: text/plain; charset=us-ascii

Hi,
I merged 2., 3. and 4. (attached) with some modifications.

1. There is now a module parameter apm-idle-threshold which allows to override
   the compiled in idle percentage threshold above which BIOS idle calls are
   done.

2. I modified Andrej's mechanism to detect a defunct BIOS (stating 'does stop
   CPU' when it actually doesn't) to take into account that there's other
   interrupts than the timer interrupt that could reactivate the cpu.
   As there's 16 hardware interrupts on x86 (apm is arch specific anyway) I do
   use a leaky bucket counter for a maximum of 16 idle rounds until jiffies is
   increased. When the counter reaches zero it stays at this value and the
   system idle routine is called. If BIOS idle is a noop then the counter
   reaches zero fast, thus effectively halting the cpu.

Andrej, could you please test the patch if it works for your laptop?

On 22-Dec-2001 Thomas Hood wrote:
> I wrote:
> ---------------------------------------------------------------------
> Here is an updated list of the patches:
> 1. Notify listener of suspend before drivers        (Russell King, me)
>     (appended)
> 2. Fix idle handling                                (Andreas Steinmetz)
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=100754277600661&w=2
> 3. Control apm idle calling by runtime parameter    (Andrej Borsenkow)
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=100852862320955&w=2
> 4. Detect failure to stop CPU on apm idle call      (Andrej Borsenkow)
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=100869841008117&w=2
> ---------------------------------------------------------------------
> 
> I have just tried to combine these and I have run into trouble.
> Patch 4 applies on top of patch 3, but neither of these applies
> on top of patch 2.  Can you guys sort these out into one big
> "fix idle calling" patch that includes a runtime parameter
> to control idle calling, which overrides a default selected
> either by CONFIG_APM_CPU_IDLE or by a bit of code that checks
> for CPU stoppage?
> 
> Or has someone already done this?
> 
> The latest Russell King (modified by me) patch is now at:
>    http://panopticon.csustan.edu/thood/apm.html
> 
> --
> Thomas Hood
> 
> 
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--_=XFMail.1.5.1.Linux:20011222153709:1483=_
Content-Disposition: attachment; filename="apm.c.diff"
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; name=apm.c.diff; SizeOnDisk=6145

--- /tmp/apm.c.orig	Sat Dec 22 15:19:42 2001
+++ /tmp/apm.c	Sat Dec 22 15:17:23 2001
@@ -341,6 +341,11 @@
 #define APM_BIOS_MAGIC		0x4101
 
 /*
+ * idle percentage above which bios idle calls are done
+ */
+#define BIOS_IDLE_TRIGGER	95
+
+/*
  * Local variables
  */
 static struct {
@@ -349,6 +354,8 @@
 }				apm_bios_entry;
 #ifdef CONFIG_APM_CPU_IDLE
 static int			clock_slowed;
+static int			idle_enabled = 1;
+static int			idle_threshold = BIOS_IDLE_TRIGGER;
 #endif
 static int			suspends_pending;
 static int			standbys_pending;
@@ -735,63 +742,84 @@
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
+ * CPU for some time, we want to call BIOS
+ * power management - we probably want
  * to conserve power.
  */
 #define HARD_IDLE_TIMEOUT (HZ/3)
+#define IDLE_CALC_LIMIT   (HZ*100)
+#define IDLE_LEAKY_MAX    16
 
-/* This should wake up kapmd and ask it to slow the CPU */
-#define powermanagement_idle()  do { } while (0)
+static void (*sys_idle)(void);
+static unsigned int last_jiffies = 0;
+static unsigned int last_stime = 0;
+static int use_apm_idle = 0;
 
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
-
-	start_idle = jiffies;
-	while (1) {
-		if (!current->need_resched) {
-			if (jiffies - start_idle < HARD_IDLE_TIMEOUT) {
-				if (!current_cpu_data.hlt_works_ok)
-					continue;
-				if (hlt_counter)
+	int apm_is_idle = 0;
+	unsigned int t1 = jiffies - last_jiffies;
+	unsigned int t2;
+
+recalc:	if(t1 > IDLE_CALC_LIMIT)
+		goto reset;
+
+	if(t1 > HARD_IDLE_TIMEOUT) {
+		t2 = current->times.tms_stime - last_stime;
+		t2 *= 100;
+		t2 /= t1;
+		if (t2 > idle_threshold)
+			use_apm_idle = 1;
+		else
+reset:			use_apm_idle = 0;
+		last_jiffies = jiffies;
+		last_stime = current->times.tms_stime;
+	}
+
+	t2 = IDLE_LEAKY_MAX;
+
+	while (!current->need_resched) {
+		if(use_apm_idle) {
+			t1 = jiffies;
+			switch (apm_do_idle()) {
+			case 0:	apm_is_idle = 1;
+				if (t1 != jiffies) {
+					if (t2) {
+						t2 = IDLE_LEAKY_MAX;
+						continue;
+					}
+				} else if (t2) {
+					t2--;
 					continue;
-				__cli();
-				if (!current->need_resched)
-					safe_halt();
-				else
-					__sti();
-				continue;
+				}
+				break;
+			case 1:	apm_is_idle = 1;
+				break;
 			}
-
-			/*
-			 * Ok, do some power management - we've been idle for too long
-			 */
-			powermanagement_idle();
 		}
 
-		schedule();
-		check_pgt_cache();
-		start_idle = jiffies;
+		if (sys_idle)
+			sys_idle();
+
+		t1 = jiffies - last_jiffies;
+		if (t1 > HARD_IDLE_TIMEOUT)
+			goto recalc;
 	}
+
+	if (apm_is_idle)
+		apm_do_busy();
 }
 #endif
-#endif
 
 #ifdef CONFIG_SMP
 static int apm_magic(void * unused)
@@ -1346,17 +1374,12 @@
 
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
 
@@ -1366,34 +1389,6 @@
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
@@ -1814,6 +1809,17 @@
 		if ((strncmp(str, "realmode-power-off", 18) == 0) ||
 		    (strncmp(str, "realmode_power_off", 18) == 0))
 			apm_info.realmode_power_off = !invert;
+#ifdef CONFIG_APM_CPU_IDLE
+		if ((strncmp(str, "apm-idle", 8) == 0) ||
+		    (strncmp(str, "apm_idle", 8) == 0))
+			idle_enabled = !invert;
+		if ((strncmp(str, "apm-idle-threshold=", 19) == 0) ||
+		    (strncmp(str, "apm_idle_threshold=", 19) == 0)) {
+			idle_threshold = simple_strtol(str + 19, NULL, 0);
+			if ( idle_threshold < 0 || idle_threshold > 99 )
+				idle_threshold = BIOS_IDLE_TRIGGER;
+		}
+#endif
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
@@ -1968,6 +1974,13 @@
 
 	misc_register(&apm_device);
 
+#ifdef CONFIG_APM_CPU_IDLE
+	if (idle_enabled) {
+		sys_idle = pm_idle;
+		pm_idle  = apm_cpu_idle;
+	}
+#endif
+
 	return 0;
 }
 
@@ -1975,6 +1988,11 @@
 {
 	int	error;
 
+#ifdef CONFIG_APM_CPU_IDLE
+	if (idle_enabled)
+		pm_idle = sys_idle;
+#endif
+
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) == 0)
 	    && (apm_info.connection_version > 0x0100)) {
 		error = apm_engage_power_management(APM_DEVICE_ALL, 0);
@@ -2012,5 +2030,11 @@
 MODULE_PARM(realmode_power_off, "i");
 MODULE_PARM_DESC(realmode_power_off,
 		"Switch to real mode before powering off");
+#ifdef CONFIG_APM_CPU_IDLE
+MODULE_PARM(apm_idle, "i");
+MODULE_PARM_DESC(apm_idle, "Make BIOS idle calls when idle");
+MODULE_PARM(apm_idle_threshold, "i");
+MODULE_PARM_DESC(apm_idle_threshold, "System idle percentage for BIOS idle call
s");
+#endif
 
 EXPORT_NO_SYMBOLS;

--_=XFMail.1.5.1.Linux:20011222153709:1483=_--
End of MIME message
