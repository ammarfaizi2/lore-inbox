Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283853AbRLEI73>; Wed, 5 Dec 2001 03:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283856AbRLEI7V>; Wed, 5 Dec 2001 03:59:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30477 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283853AbRLEI7A>; Wed, 5 Dec 2001 03:59:00 -0500
Subject: Re: kapm-idled
To: ast@domdv.de (Andreas Steinmetz)
Date: Wed, 5 Dec 2001 09:07:20 +0000 (GMT)
Cc: gert@menke.za.net (Gert Menke), linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011205022659.ast@domdv.de> from "Andreas Steinmetz" at Dec 05, 2001 02:26:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BY1Q-0005Rf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> system idle time. I did send a patch correcting this weird behaviour for
> revision to Alan Cox a few days ago but until now there's no reaction from him.

It looks quite sensible to me (I thought i had replied)

> If you want to have a look at the patch please let me know though it may take a
> few days. I have to recover a system suffering from severe bit errors due to
> a memory module having gone south very slowly and quiet.

Your patch attached below
--
>From ast@domdv.de Sat Dec 01 18:22:50 2001
Return-path: <ast@domdv.de>
Envelope-to: alan@lxorguk.ukuu.org.uk
Delivery-date: Sat, 01 Dec 2001 18:22:50 +0000
Received: from hermes.domdv.de ([193.102.202.1] helo=zeus.domdv.de)
	by the-village.bc.nu with esmtp (Exim 3.22 #1)
	id 16AEmj-0007sv-00
	for alan@lxorguk.ukuu.org.uk; Sat, 01 Dec 2001 18:22:46 +0000
Received: from castor.lan.domdv.de by zeus.domdv.de  with esmtp
	(Smail3.2.0.114 #1) id m16AEdS-003oYMC; Sat, 1 Dec 2001 19:13:10 +0100 (CET)
Received: from ast@pcast2.domdv.de by castor.lan.domdv.de  with esmtp
	(Smail3.2.0.114 #1) id m16AEdR-00088zC; Sat, 1 Dec 2001 19:13:09 +0100 (CET)
Content-Length: 7592
Message-ID: <XFMail.20011201191127.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.5.1.Linux:20011201191127:1153=_"
In-Reply-To: <E16A9WI-00073W-00@the-village.bc.nu>
Date: Sat, 01 Dec 2001 19:11:27 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] apm fix for broken CONFIG_APM_CPU_IDLE 
Status: RO

This message is in MIME format
--_=XFMail.1.5.1.Linux:20011201191127:1153=_
Content-Type: text/plain; charset=us-ascii

Hi,
I did some analysis of APM for CONFIG_APM_CPU_IDLE as it just doesn't work as
expected. There are major deficiencies:

1. kapm-idled can't reliably handle APM idle calls as it may (and quite often
   does) run in sync with other processes that are ready to run e.g. on a
   select timeout but do only negigable processing until sleeping again
   (already reported).

2. kapm-idled does account as system load while doing idle calls. Furthermore
   the idle task cannot run while kapm-idled is running which can cause
   excess battery draining on laptops where the BIOS only slows the clock on
   APM idle calls. On the other hand on systems where the APM bios stops the
   clock may do additional power saving the additional power saving may not
   occur while kapm-idled is suspended and only system idling does occur.

3. The system may be slowed down unnecessarily by excess APM BIOS idle calls as
   kapm-idled doesn't take the average system load into account.

As far as I can see CONFIG_APM_CPU_IDLE should behave like this:

1. APM BIOS idle calls should be done when the system is nearly idle, otherwise
   standard idle handling should be done.
   The decision whether to do standard idle handling or to do APM BIOS calls
   needs to be done on a system load estimate during a certain time period.

2. When the APM BIOS stops the clock no standard idle handling is required.
   Note that in case of a broken APM BIOS signalling stopping of the CPU but
   not doing so the current handling is broken and configuring without
   CONFIG_APM_CPU_IDLE is anyway required.

3. When the APM BIOS just slows the clock standard idle handling is required in
   addition to the BIOS idle calls.

The attached patch implements the behaviour as described above:

1. APM BIOS idle call handling is completely removed from kapm-idled and placed
   in the reworked and 'reanimated' apm_cpu_idle function.

2. apm_cpu_idle is an 'in between' APM shim that calls the previously installed
   system idle function as required.

3. The decision wether to use APM idle calls or doing standard idle calls is
   based on the percentage of idle time during the last third of a second.
   More than 95% of idle time during this period causes APM idle calls to be
   used instead of standard idle handling.

4. I don't know if the patch is SMP safe as I do only have UP systems. It does
   however, run well on my laptop which did have problems with APM idle
   handling since my switch from 2.2 to 2.4.

I would ask you to review this patch as it does bring CONFIG_APM_CPU_IDLE back
to a working state which should really help linux laptop users.
If you can agree on the patch I would like to post it to lkml for kernel
inclusion.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--_=XFMail.1.5.1.Linux:20011201191127:1153=_
Content-Disposition: attachment; filename="apm.diff"
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; name=apm.diff; SizeOnDisk=4428

diff -rNu linux/arch/i386/kernel/apm.c linux-custom/arch/i386/kernel/apm.c
--- linux/arch/i386/kernel/apm.c	Sat Dec  1 18:12:50 2001
+++ linux-custom/arch/i386/kernel/apm.c	Sat Dec  1 18:12:40 2001
@@ -735,63 +735,71 @@
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
+#define BIOS_IDLE_TRIGGER 95
 
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
-					continue;
-				__cli();
-				if (!current->need_resched)
-					safe_halt();
-				else
-					__sti();
-				continue;
-			}
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
+		if (t2 > BIOS_IDLE_TRIGGER)
+			use_apm_idle = 1;
+		else
+reset:			use_apm_idle = 0;
+		last_jiffies = jiffies;
+		last_stime = current->times.tms_stime;
+	}
 
-			/*
-			 * Ok, do some power management - we've been idle for too long
-			 */
-			powermanagement_idle();
+	while (!current->need_resched) {
+		if(use_apm_idle)
+			switch (apm_do_idle()) {
+		case 0:	apm_is_idle = 1;
+			continue;
+		case 1:	apm_is_idle = 1;
+			break;
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
@@ -1346,17 +1354,12 @@
 
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
 
@@ -1366,34 +1369,6 @@
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
@@ -1968,12 +1943,21 @@
 
 	misc_register(&apm_device);
 
+#ifdef CONFIG_APM_CPU_IDLE
+	sys_idle=pm_idle;
+	pm_idle=apm_cpu_idle;
+#endif
+
 	return 0;
 }
 
 static void __exit apm_exit(void)
 {
 	int	error;
+
+#ifdef CONFIG_APM_CPU_IDLE
+	pm_idle=sys_idle;
+#endif
 
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) == 0)
 	    && (apm_info.connection_version > 0x0100)) {

--_=XFMail.1.5.1.Linux:20011201191127:1153=_--
End of MIME message

