Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTL1XBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 18:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTL1XBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 18:01:09 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:18560 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S262123AbTL1XA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 18:00:59 -0500
Date: Mon, 29 Dec 2003 00:05:22 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 can run with HZ==0!
Message-ID: <20031228230522.GA1876@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The first thing I noticed was that a select for .2 seconds seemed to
hang in a python script I was working on that time. I didn't believe it
so I tried some other things including "sleep 1", "usleep 1", stracing
them and it all came down to one conclusion

	the clock has stopped

/proc/interrupts confirmed that the clock has stopped:

$ cat /proc/interrupts 
           CPU0       
  0:    7745428          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  via82cxxx, usb-uhci
 11:      12106          XT-PIC  usb-uhci, usb-uhci, eth0
 12:      12079          XT-PIC  eth1
 14:       8582          XT-PIC  ide0
 15:       8623          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
$ cat /proc/interrupts 
           CPU0       
  0:    7745428          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  via82cxxx, usb-uhci
 11:      12116          XT-PIC  usb-uhci, usb-uhci, eth0
 12:      12079          XT-PIC  eth1
 14:       8582          XT-PIC  ide0
 15:       8623          XT-PIC  ide1

notice that network irqs are taking place for eth0 but no timer irqs.

halt, reboot (-f) etc didn't work because they all wanted to sleep. I
had to power cycle. Now HZ is ok (1000) again.  HZ has been patched but
that's an unlikely cause (patch attached in case you wonder).

Hardware: VIA CL6000

At the time this happened I was also playing with /dev/ttyS3 lines on
the mobo (static discharge?)

-- 
Frank

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hz.patch"

--- linux/include/asm-i386/param.h.hz	Mon Aug 18 12:15:42 2003
+++ linux/include/asm-i386/param.h	Mon Aug 18 12:26:26 2003
@@ -2,8 +2,9 @@
 #define _ASMi386_PARAM_H
 
 #ifndef HZ
-#define HZ 100
+#define HZ 1000
 #endif
+#define jiffies_to_clock_t(x) ((x) / (HZ / 100))
 
 #define EXEC_PAGESIZE	4096
 
--- linux/kernel/sys.c.hz	Mon Aug 18 12:15:36 2003
+++ linux/kernel/sys.c	Mon Aug 18 12:26:20 2003
@@ -807,10 +807,16 @@
 	 *	atomically safe type this is just fine. Conceptually its
 	 *	as if the syscall took an instant longer to occur.
 	 */
-	if (tbuf)
-		if (copy_to_user(tbuf, &current->times, sizeof(struct tms)))
+	if (tbuf) {
+		struct tms tmp;
+		tmp.tms_utime = jiffies_to_clock_t(current->times.tms_utime);
+		tmp.tms_stime = jiffies_to_clock_t(current->times.tms_stime);
+		tmp.tms_cutime = jiffies_to_clock_t(current->times.tms_cutime);
+		tmp.tms_cstime = jiffies_to_clock_t(current->times.tms_cstime);
+		if (copy_to_user(tbuf, &tmp, sizeof(struct tms)))
 			return -EFAULT;
-	return jiffies;
+	}
+	return jiffies_to_clock_t(jiffies);
 }
 
 /*
--- linux/kernel/timer.c.hz	Wed Dec  4 11:01:40 2002
+++ linux/kernel/timer.c	Mon Aug 18 12:15:42 2003
@@ -472,6 +472,15 @@
     else
 	time_adj += (time_adj >> 2) + (time_adj >> 5);
 #endif
+#if HZ == 1000
+    /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
+     * Add 1.5625% and 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
+     */
+    if (time_adj < 0)
+	time_adj -= (-time_adj >> 6) + (-time_adj >> 7);
+    else
+	time_adj += (time_adj >> 6) + (time_adj >> 7);
+#endif
 }
 
 /* in the NTP reference this is called "hardclock()" */
--- linux/fs/proc/array.c.hz	2003-11-30 21:52:24.000000000 +0100
+++ linux/fs/proc/array.c	2003-11-30 21:52:26.000000000 +0100
@@ -362,15 +362,15 @@
 		task->cmin_flt,
 		task->maj_flt,
 		task->cmaj_flt,
-		task->times.tms_utime,
-		task->times.tms_stime,
-		task->times.tms_cutime,
-		task->times.tms_cstime,
+		jiffies_to_clock_t(task->times.tms_utime),
+		jiffies_to_clock_t(task->times.tms_stime),
+		jiffies_to_clock_t(task->times.tms_cutime),
+		jiffies_to_clock_t(task->times.tms_cstime),
 		priority,
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		task->start_time,
+		jiffies_to_clock_t(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,
--- linux/fs/proc/proc_misc.c.hz	Mon Aug 18 12:15:26 2003
+++ linux/fs/proc/proc_misc.c	Mon Aug 18 13:35:59 2003
@@ -325,18 +325,21 @@
 	}
 
 	proc_sprintf(page, &off, &len,
-		      "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
+		      "cpu  %u %u %u %lu\n",
+			jiffies_to_clock_t(user),
+			jiffies_to_clock_t(nice),
+			jiffies_to_clock_t(system),
+			jiffies_to_clock_t(jif * smp_num_cpus - (user + nice + system)));
 	for (i = 0 ; i < smp_num_cpus; i++)
 		proc_sprintf(page, &off, &len,
 			"cpu%d %u %u %u %lu\n",
 			i,
-			kstat.per_cpu_user[cpu_logical_map(i)],
-			kstat.per_cpu_nice[cpu_logical_map(i)],
-			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
+			jiffies_to_clock_t(kstat.per_cpu_user[cpu_logical_map(i)]),
+			jiffies_to_clock_t(kstat.per_cpu_nice[cpu_logical_map(i)]),
+			jiffies_to_clock_t(kstat.per_cpu_system[cpu_logical_map(i)]),
+			jiffies_to_clock_t(jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
 				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+				   + kstat.per_cpu_system[cpu_logical_map(i)])));
 	proc_sprintf(page, &off, &len,
 		"page %u %u\n"
 		"swap %u %u\n"

--6c2NcOVqGQ03X4Wi--
