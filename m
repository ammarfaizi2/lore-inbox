Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <153923-13684>; Tue, 5 Jan 1999 19:45:49 -0500
Received: by vger.rutgers.edu id <157044-13684>; Tue, 5 Jan 1999 12:34:37 -0500
Received: from lilly.ping.de ([195.37.120.2]:23364 "HELO lilly.ping.de" ident: "qmailr") by vger.rutgers.edu with SMTP id <155137-25901>; Tue, 5 Jan 1999 01:33:51 -0500
Message-ID: <19990105094830.A17862@kg1.ping.de>
Date: Tue, 5 Jan 1999 09:48:30 +0100
From: Kurt Garloff <K.Garloff@ping.de>
To: Linux kernel list <linux-kernel@vger.rutgers.edu>
Subject: [PATCH] HZ change for ix86
Mail-Followup-To: Linux kernel list <linux-kernel@vger.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=6c2NcOVqGQ03X4Wi
X-Mailer: Mutt 0.90.4i
X-Operating-System: Linux 2.1.132 i686
Sender: owner-linux-kernel@vger.rutgers.edu


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii

Hey guys,

lately, I've seen a couple of questions about changing HZ in the kernel for
ix86. Your scheduler will run more often and your system might feel snappier
when increasing HZ, that's why we want it. Overhead for doing so got
relativlely low with recent CPUs, so me might really want it.

Basically, you can change it without causing any problems within the kernel.
However the HZ based value is reported by a system call sys_times() to the
userspace and as well from the proc fs.

So, this has to be fixed to have a seamless HZ change.

I created a patch which changes the values of HZ to 400 and fixed all places
I could spot which report the jiffies value to userspace. I think I caught
all of them. Note that 400 is a nice value, because we have to divide the
values by 4 then, which the gcc optimizes to shift operations, which can be
done in one or two cycles each and even parallelized on modern CPUs. Integer
divisions are slow on the ix86 (~20 cycles) and the sys_times() needs four of
them. You can easily change HZ to 500 and HZ_TO_STD to 5 in asm-i386/param.h, 
but then you would loose 80 CPU cycles per sys_times() syscall, which you
might want to avoid.

This patch works here since 2.1.125, so you can consider it well tested on
one system.

Have fun !
-- 
Kurt Garloff <kurt@garloff.de>                           [Dortmund, FRG]  
Plasma physics, high perf. computing              [Linux-ix86,-axp, DUX]
PGP key on http://www.garloff.de/kurt/        [Linux SCSI driver: DC390]

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Description: 21125-hz-change.diff
Content-Disposition: attachment; filename="21125-hz-change.diff"

--- linux/arch/i386/kernel/time.c.orig	Wed Oct 21 00:23:16 1998
+++ linux/arch/i386/kernel/time.c	Thu Nov 12 14:34:10 1998
@@ -604,7 +604,7 @@
 		{	unsigned long eax=0, edx=1000000;
 			__asm__("divl %2"
 	       		:"=a" (cpu_hz), "=d" (edx)
-               		:"r" (fast_gettimeoffset_quotient),
+               		:"r" (fast_gettimeoffset_quotient * HZ_TO_STD),
                 	"0" (eax), "1" (edx));
 			printk("Detected %ld Hz processor.\n", cpu_hz);
 		}
--- linux/include/asm-i386/param.h.orig	Thu Nov 12 14:35:23 1998
+++ linux/include/asm-i386/param.h	Wed Nov 11 07:48:44 1998
@@ -2,7 +2,8 @@
 #define _ASMi386_PARAM_H
 
 #ifndef HZ
-#define HZ 100
+#define HZ 400
+#define HZ_TO_STD 4
 #endif
 
 #define EXEC_PAGESIZE	4096
--- linux/kernel/sys.c.orig	Thu Nov 12 14:36:57 1998
+++ linux/kernel/sys.c	Wed Nov  4 11:59:39 1998
@@ -623,10 +623,15 @@
 	 *	atomically safe type this is just fine. Conceptually its
 	 *	as if the syscall took an instant longer to occur.
 	 */
-	if (tbuf)
+	if (tbuf) {
 		if (copy_to_user(tbuf, &current->times, sizeof(struct tms)))
 			return -EFAULT;
-	return jiffies;
+		tbuf->tms_utime  /= HZ_TO_STD;
+		tbuf->tms_stime  /= HZ_TO_STD;
+		tbuf->tms_cutime /= HZ_TO_STD;
+		tbuf->tms_cstime /= HZ_TO_STD;
+	};
+	return jiffies /* / HZ_TO_STD*/;
 }
 
 /*
--- linux/fs/proc/array.c.orig	Tue Oct 27 17:38:51 1998
+++ linux/fs/proc/array.c	Thu Nov 12 14:40:26 1998
@@ -230,26 +230,26 @@
 	extern unsigned long total_forks;
 	unsigned long ticks;
 
-	ticks = jiffies * smp_num_cpus;
+	ticks = jiffies * smp_num_cpus / HZ_TO_STD;
 	for (i = 0 ; i < NR_IRQS ; i++)
 		sum += kstat_irqs(i);
 
 #ifdef __SMP__
 	len = sprintf(buffer,
 		"cpu  %u %u %u %lu\n",
-		kstat.cpu_user,
-		kstat.cpu_nice,
-		kstat.cpu_system,
-		jiffies*smp_num_cpus - (kstat.cpu_user + kstat.cpu_nice + kstat.cpu_system));
+		kstat.cpu_user/HZ_TO_STD,
+		kstat.cpu_nice/HZ_TO_STD,
+		kstat.cpu_system/HZ_TO_STD,
+		ticks - ((kstat.cpu_user + kstat.cpu_nice + kstat.cpu_system))/HZ_TO_STD);
 	for (i = 0 ; i < smp_num_cpus; i++)
 		len += sprintf(buffer + len, "cpu%d %u %u %u %lu\n",
 			i,
-			kstat.per_cpu_user[cpu_logical_map(i)],
-			kstat.per_cpu_nice[cpu_logical_map(i)],
-			kstat.per_cpu_system[cpu_logical_map(i)],
-			jiffies - (  kstat.per_cpu_user[cpu_logical_map(i)] \
+			kstat.per_cpu_user[cpu_logical_map(i)]/HZ_TO_STD,
+			kstat.per_cpu_nice[cpu_logical_map(i)]/HZ_TO_STD,
+			kstat.per_cpu_system[cpu_logical_map(i)]/HZ_TO_STD,
+			(jiffies - (  kstat.per_cpu_user[cpu_logical_map(i)] \
 			           + kstat.per_cpu_nice[cpu_logical_map(i)] \
-			           + kstat.per_cpu_system[cpu_logical_map(i)]));
+			           + kstat.per_cpu_system[cpu_logical_map(i)]))/HZ_TO_STD);
 	len += sprintf(buffer + len,
 		"disk %u %u %u %u\n"
 		"disk_rio %u %u %u %u\n"
@@ -270,10 +270,10 @@
 		"page %u %u\n"
 		"swap %u %u\n"
 		"intr %u",
-		kstat.cpu_user,
-		kstat.cpu_nice,
-		kstat.cpu_system,
-		ticks - (kstat.cpu_user + kstat.cpu_nice + kstat.cpu_system),
+		kstat.cpu_user/HZ_TO_STD,
+		kstat.cpu_nice/HZ_TO_STD,
+		kstat.cpu_system/HZ_TO_STD,
+		ticks - ((kstat.cpu_user + kstat.cpu_nice + kstat.cpu_system)/HZ_TO_STD),
 #endif
 		kstat.dk_drive[0], kstat.dk_drive[1],
 		kstat.dk_drive[2], kstat.dk_drive[3],
@@ -886,10 +886,10 @@
 		tsk->cmin_flt,
 		tsk->maj_flt,
 		tsk->cmaj_flt,
-		tsk->times.tms_utime,
-		tsk->times.tms_stime,
-		tsk->times.tms_cutime,
-		tsk->times.tms_cstime,
+		tsk->times.tms_utime/HZ_TO_STD,
+		tsk->times.tms_stime/HZ_TO_STD,
+		tsk->times.tms_cutime/HZ_TO_STD,
+		tsk->times.tms_cstime/HZ_TO_STD,
 		priority,
 		nice,
 		tsk->timeout,
@@ -1204,14 +1204,14 @@
 
 	len = sprintf(buffer,
 		"cpu  %lu %lu\n",
-		tsk->times.tms_utime,
-		tsk->times.tms_stime);
+		tsk->times.tms_utime/HZ_TO_STD,
+		tsk->times.tms_stime/HZ_TO_STD);
 		
 	for (i = 0 ; i < smp_num_cpus; i++)
 		len += sprintf(buffer + len, "cpu%d %lu %lu\n",
 			i,
-			tsk->per_cpu_utime[cpu_logical_map(i)],
-			tsk->per_cpu_stime[cpu_logical_map(i)]);
+			tsk->per_cpu_utime[cpu_logical_map(i)]/HZ_TO_STD,
+			tsk->per_cpu_stime[cpu_logical_map(i)]/HZ_TO_STD);
 
 	return len;
 }

--6c2NcOVqGQ03X4Wi--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
