Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVLMB4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVLMB4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 20:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVLMB4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 20:56:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:53994 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932346AbVLMB4p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 20:56:45 -0500
Subject: Re: 2.6.14-rt21: slow-running clock
From: john stultz <johnstul@us.ibm.com>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512090219.jB92JxtV006757@auster.physics.adelaide.edu.au>
References: <200512090219.jB92JxtV006757@auster.physics.adelaide.edu.au>
Content-Type: multipart/mixed; boundary="=-FvfJD3tAtVIEWQvjo0OO"
Date: Mon, 12 Dec 2005 17:56:41 -0800
Message-Id: <1134439002.14627.28.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FvfJD3tAtVIEWQvjo0OO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-12-09 at 12:49 +1030, Jonathan Woithe wrote:
> > Ok, I went digging further and found the c3tsc selection is correct on
> > your hardware. I'm just too used to my own laptop where the TSC varies
> > with cpu speed and we lower the rating value. So that should be ok.
> 
> Ok, good.  That leaves the c3tsc slowdown as the only outstanding issue at
> this stage.
> 
> > I'm now working on why we mis-compensate the c3tsc clocksource in the
> > -RT tree. 
> 
> No problem.  Let me know when you have something to test or need further
> info.

Hey Jonathan,

	Attached is a test patch to see if it doesn't resolve the issue for
you. I get a maximum change in drift of 30ppm when idling between C3
states by being more careful with the C3 TSC compensation and I also
force timekeeping updates when cpufreq events occur. 

I'm not sure if this is the right fix yet, but it might help narrow down
the problem.


Also attached is a python script that will spit out the offset value
from an ntp server and calculate the drift. This also will give us a
better idea of what is going on. If you could run it with and without
the patch, that would be great!


First shutdown NTPd then run:
	./drift-test.py [-s] <timeserver> <polling interval>

Where -s will sync the clock before running.


thanks
-john




--=-FvfJD3tAtVIEWQvjo0OO
Content-Disposition: attachment; filename=c3fix-test.diff
Content-Type: text/x-patch; name=c3fix-test.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -66,13 +66,13 @@ void mark_tsc_unstable(void)
 /* Code to compensate for C3 stalls */
 static u64 tsc_c3_offset;
 
-void tsc_c3_compensate(unsigned long nsecs)
+void tsc_c3_compensate(unsigned long nsecs, u64 tsc_offset)
 {
 	/* this could def be optimized */
 	u64 cycles = ((u64)nsecs * tsc_khz);
 
 	do_div(cycles, 1000000);
-	tsc_c3_offset += cycles;
+	tsc_c3_offset += cycles - tsc_offset;
 }
 
 EXPORT_SYMBOL_GPL(tsc_c3_compensate);
@@ -263,6 +263,7 @@ static int
 time_cpufreq_notifier(struct notifier_block *nb, unsigned long val, void *data)
 {
 	struct cpufreq_freqs *freq = data;
+	unsigned long old_tsc_khz = tsc_khz;
 
 	if (val != CPUFREQ_RESUMECHANGE)
 		write_seqlock_irq(&xtime_lock);
@@ -299,6 +300,9 @@ time_cpufreq_notifier(struct notifier_bl
 	if (val != CPUFREQ_RESUMECHANGE)
 		write_sequnlock_irq(&xtime_lock);
 
+	if(old_tsc_khz != tsc_khz)
+		timeofday_force_update();
+
 	return 0;
 }
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -177,7 +177,7 @@ static void acpi_safe_halt(void)
 }
 
 static atomic_t c3_cpu_count;
-extern void tsc_c3_compensate(unsigned long nsecs);
+extern void tsc_c3_compensate(unsigned long nsecs, u64 tsc_offset);
 
 static void acpi_processor_idle(void)
 {
@@ -186,6 +186,7 @@ static void acpi_processor_idle(void)
 	struct acpi_processor_cx *next_state = NULL;
 	int sleep_ticks = 0;
 	u32 t1, t2 = 0;
+	u64 tsc1, tsc2, tsc3;
 
 	pr = processors[smp_processor_id()];
 	if (!pr)
@@ -359,12 +360,15 @@ static void acpi_processor_idle(void)
 
 		/* Get start time (ticks) */
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
+		rdtscll(tsc1);
 		/* Invoke C3 */
 		inb(cx->address);
 		/* Dummy op - must do something useless after P_LVL3 read */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Get end time (ticks) */
+		rdtscll(tsc2);
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
+		rdtscll(tsc3);
 		if (pr->flags.bm_check) {
 			/* Enable bus master arbitration */
 			atomic_dec(&c3_cpu_count);
@@ -374,7 +378,7 @@ static void acpi_processor_idle(void)
 
 #ifdef CONFIG_GENERIC_TIME
 		/* compensate for TSC pause */
-		tsc_c3_compensate((u32)(((u64)((t2-t1)&0xFFFFFF)*286070)>>10));
+		tsc_c3_compensate((u32)(((u64)((t2-t1)&0xFFFFFF)*286070)>>10), tsc3-tsc1);
 #endif
 
 		/* Re-enable interrupts */
diff --git a/include/asm-i386/tsc.h b/include/asm-i386/tsc.h
--- a/include/asm-i386/tsc.h
+++ b/include/asm-i386/tsc.h
@@ -44,7 +44,7 @@ static inline cycles_t get_cycles(void)
 }
 
 extern void tsc_init(void);
-extern void tsc_c3_compensate(unsigned long usecs);
+extern void tsc_c3_compensate(unsigned long usecs, unsigned long long tsc_offset);
 extern void mark_tsc_unstable(void);
 
 #endif
diff --git a/include/linux/timeofday.h b/include/linux/timeofday.h
--- a/include/linux/timeofday.h
+++ b/include/linux/timeofday.h
@@ -30,6 +30,7 @@ extern int do_settimeofday(struct timesp
 
 /* Internal functions */
 extern int timeofday_is_continuous(void);
+extern void timeofday_force_update(void);
 extern void timeofday_init(void);
 
 #ifndef CONFIG_IS_TICK_BASED
diff --git a/kernel/time/timeofday.c b/kernel/time/timeofday.c
--- a/kernel/time/timeofday.c
+++ b/kernel/time/timeofday.c
@@ -745,6 +745,12 @@ static void timeofday_periodic_hook(unsi
 		jiffies + 1 + msecs_to_jiffies(PERIODIC_INTERVAL_MS));
 }
 
+
+void timeofday_force_update(void)
+{
+	timeofday_periodic_hook(0);
+}
+
 /**
  * timeofday_is_continuous - check to see if timekeeping is free running
  */

--=-FvfJD3tAtVIEWQvjo0OO
Content-Disposition: attachment; filename=drift-test.py
Content-Type: text/x-python; name=drift-test.py; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#!/usr/bin/python

# Time Drift Script
#		Periodically checks and displays time drift
#		by john stultz (jstultz@us.ibm.com)

import commands
import sys
import string
import time

server_default = "yourserverhere"
sleep_time_default  = 60

server = ""
sleep_time = 0
set_time = 0

#parse args
for arg in sys.argv[1:]:
	if arg == "-s":
		set_time = 1
	elif server == "":
		server = arg
	elif sleep_time == 0:
		sleep_time = string.atoi(arg)

if server == "":
	server = server_default
if sleep_time == 0:
	sleep_time = sleep_time_default

#set time
if (set_time == 1):
	cmd = commands.getoutput('/usr/sbin/ntpdate -ub ' + server)

cmd = commands.getoutput('/usr/sbin/ntpdate -uq ' + server)
line = string.split(cmd)

#parse original offset
start_offset = string.atof(line[-2]);
#parse original time
start_time = time.localtime(time.time())
datestr = time.strftime("%d %b %Y %H:%M:%S", start_time)

time.sleep(1)
while 1:
	cmd = commands.getoutput('/usr/sbin/ntpdate -uq ' + server)
	line = string.split(cmd)

	#parse offset
	now_offset = string.atof(line[-2]);

	#parse time
	now_time = time.localtime(time.time())
	datestr = time.strftime("%d %b %Y %H:%M:%S", now_time)

	# calculate drift
	delta_time = time.mktime(now_time) - time.mktime(start_time)
	delta_offset = now_offset - start_offset
	drift =  delta_offset / delta_time * 1000000

	#print output
	print time.strftime("%d %b %H:%M:%S",now_time), 
	print "	offset:", now_offset , 
	print "	drift:", drift ,"ppm"
	sys.stdout.flush()

	#sleep 
	time.sleep(sleep_time)

--=-FvfJD3tAtVIEWQvjo0OO--

