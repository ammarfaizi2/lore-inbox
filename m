Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154008AbPGTDlZ>; Mon, 19 Jul 1999 23:41:25 -0400
Received: by vger.rutgers.edu id <S153947AbPGTDlM>; Mon, 19 Jul 1999 23:41:12 -0400
Received: from pb158.warszawa.ppp.tpnet.pl ([212.160.53.158]:49160 "HELO olaf") by vger.rutgers.edu with SMTP id <S153953AbPGTDhQ>; Mon, 19 Jul 1999 23:37:16 -0400
Message-ID: <3793EDBB.6B7D7E12@geocities.com>
Date: Tue, 20 Jul 1999 05:32:11 +0200
From: Artur Skawina <skawina@geocities.com>
X-Mailer: Mozilla 3.04 (X11; U; Linux 2.3.5as i686)
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
CC: Kurt Garloff <kurt@garloff.de>
Subject: [RFC] increasing and masquerading HZ
Content-Type: multipart/mixed; boundary="------------54341B8F2B3E33702282A786"
Sender: owner-linux-kernel@vger.rutgers.edu

This is a multi-part message in MIME format.

--------------54341B8F2B3E33702282A786
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch increases HZ to 800 for kernels compiled for 686
It tries to hide the HZ change from userspace. The places I found were:

o /proc/stat
o /proc/<pid>/stat
o /proc/<pid>/cpu
o BSD Process Accounting
o siginfo
o sys_times

Not handled:
o the ip routing sysctls [defined in jiffies...:( ]

also note there are drivers that assume HZ==100 (initio scsi for one).


The numbers I've got so far doesn't look very good however,
a 3% drop in performance (HZ=1024) is a bit much.


[I did this patch from scratch so that the chance of spotting all
 places requiring updates would be greater. turned up to be a good
 thing - it handles a few more cases than the previously mentioned
 patch by Kurt Garloff]

What did I miss? :)

--------------54341B8F2B3E33702282A786
Content-Type: text/plain; charset=us-ascii; name="linux-2.3.5as-hzmasq"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="linux-2.3.5as-hzmasq"

diff -urNp --exclude-from /usr/src/lkdontdiff /img/linux-2.3.5/arch/i386/Makefile linux-2.3.5as/arch/i386/Makefile
--- /img/linux-2.3.5/arch/i386/Makefile	Thu May 20 01:59:04 1999
+++ linux-2.3.5as/arch/i386/Makefile	Tue Jul 20 02:13:13 1999
 endif
 
 ifdef CONFIG_M686
-CFLAGS := $(CFLAGS) -DCPU=686
+CFLAGS := $(CFLAGS) -DCPU=686 -DHZ=800
 AFLAGS := $(AFLAGS) -DCPU=686
 endif
 
diff -urNp --exclude-from /usr/src/lkdontdiff /img/linux-2.3.5/arch/i386/kernel/irq.c linux-2.3.5as/arch/i386/kernel/irq.c
--- /img/linux-2.3.5/arch/i386/kernel/irq.c	Wed May 12 19:30:30 1999
+++ linux-2.3.5as/arch/i386/kernel/irq.c	Tue Jul 20 01:39:25 1999
@@ -1104,7 +1108,7 @@ __initfunc(void init_IRQ(void))
 	request_region(0xa0,0x20,"pic2");
 
 	/*
-	 * Set the clock to 100 Hz, we already have a valid
+	 * Set the clock to HZ Hz, we already have a valid
 	 * vector now:
 	 */
 	outb_p(0x34,0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
diff -urNp --exclude-from /usr/src/lkdontdiff /img/linux-2.3.5/fs/proc/array.c linux-2.3.5as/fs/proc/array.c
--- /img/linux-2.3.5/fs/proc/array.c	Sat May 15 13:08:42 1999
+++ linux-2.3.5as/fs/proc/array.c	Tue Jul 20 00:58:23 1999
@@ -240,19 +241,19 @@ static int get_kstat(char * buffer)
 #ifdef __SMP__
 	len = sprintf(buffer,
 		"cpu  %u %u %u %lu\n",
-		kstat.cpu_user,
-		kstat.cpu_nice,
-		kstat.cpu_system,
-		jiffies*smp_num_cpus - (kstat.cpu_user + kstat.cpu_nice + kstat.cpu_system));
+		HZTOUSER(kstat.cpu_user),
+		HZTOUSER(kstat.cpu_nice),
+		HZTOUSER(kstat.cpu_system),
+		HZTOUSER(jiffies*smp_num_cpus - (kstat.cpu_user + kstat.cpu_nice + kstat.cpu_system)));
 	for (i = 0 ; i < smp_num_cpus; i++)
 		len += sprintf(buffer + len, "cpu%d %u %u %u %lu\n",
 			i,
-			kstat.per_cpu_user[cpu_logical_map(i)],
-			kstat.per_cpu_nice[cpu_logical_map(i)],
-			kstat.per_cpu_system[cpu_logical_map(i)],
-			jiffies - (  kstat.per_cpu_user[cpu_logical_map(i)] \
+			HZTOUSER(kstat.per_cpu_user[cpu_logical_map(i)]),
+			HZTOUSER(kstat.per_cpu_nice[cpu_logical_map(i)]),
+			HZTOUSER(kstat.per_cpu_system[cpu_logical_map(i)]),
+			HZTOUSER(jiffies - (  kstat.per_cpu_user[cpu_logical_map(i)] \
 			           + kstat.per_cpu_nice[cpu_logical_map(i)] \
-			           + kstat.per_cpu_system[cpu_logical_map(i)]));
+			           + kstat.per_cpu_system[cpu_logical_map(i)])));
 	len += sprintf(buffer + len,
 		"disk %u %u %u %u\n"
 		"disk_rio %u %u %u %u\n"
@@ -273,10 +274,10 @@ static int get_kstat(char * buffer)
 		"page %u %u\n"
 		"swap %u %u\n"
 		"intr %u",
-		kstat.cpu_user,
-		kstat.cpu_nice,
-		kstat.cpu_system,
-		ticks - (kstat.cpu_user + kstat.cpu_nice + kstat.cpu_system),
+		HZTOUSER(kstat.cpu_user),
+		HZTOUSER(kstat.cpu_nice),
+		HZTOUSER(kstat.cpu_system),
+		HZTOUSER(ticks - (kstat.cpu_user + kstat.cpu_nice + kstat.cpu_system)),
 #endif
 		kstat.dk_drive[0], kstat.dk_drive[1],
 		kstat.dk_drive[2], kstat.dk_drive[3],
@@ -910,15 +911,15 @@ static int get_stat(int pid, char * buff
 		tsk->cmin_flt,
 		tsk->maj_flt,
 		tsk->cmaj_flt,
-		tsk->times.tms_utime,
-		tsk->times.tms_stime,
-		tsk->times.tms_cutime,
-		tsk->times.tms_cstime,
+		HZTOUSER(tsk->times.tms_utime),
+		HZTOUSER(tsk->times.tms_stime),
+		HZTOUSER(tsk->times.tms_cutime),
+		HZTOUSER(tsk->times.tms_cstime),
 		priority,
 		nice,
 		0UL /* removed */,
 		tsk->it_real_value,
-		tsk->start_time,
+		HZTOUSER(tsk->start_time),
 		vsize,
 		tsk->mm ? tsk->mm->rss : 0, /* you might want to shift this left 3 */
 		tsk->rlim ? tsk->rlim[RLIMIT_RSS].rlim_cur : 0,
@@ -1229,14 +1230,14 @@ static int get_pidcpu(int pid, char * bu
 
 	len = sprintf(buffer,
 		"cpu  %lu %lu\n",
-		tsk->times.tms_utime,
-		tsk->times.tms_stime);
+		HZTOUSER(tsk->times.tms_utime),
+		HZTOUSER(tsk->times.tms_stime));
 		
 	for (i = 0 ; i < smp_num_cpus; i++)
 		len += sprintf(buffer + len, "cpu%d %lu %lu\n",
 			i,
-			tsk->per_cpu_utime[cpu_logical_map(i)],
-			tsk->per_cpu_stime[cpu_logical_map(i)]);
+			HZTOUSER(tsk->per_cpu_utime[cpu_logical_map(i)]),
+			HZTOUSER(tsk->per_cpu_stime[cpu_logical_map(i)]));
 
 	return len;
 }
diff -urNp --exclude-from /usr/src/lkdontdiff /img/linux-2.3.5/include/asm-i386/param.h linux-2.3.5as/include/asm-i386/param.h
--- /img/linux-2.3.5/include/asm-i386/param.h	Tue Aug  1 15:08:17 1995
+++ linux-2.3.5as/include/asm-i386/param.h	Tue Jul 20 02:14:21 1999
@@ -1,8 +1,18 @@
 #ifndef _ASMi386_PARAM_H
 #define _ASMi386_PARAM_H
 
+#include <linux/config.h>
+
 #ifndef HZ
 #define HZ 100
+#endif
+
+#if HZ!=100
+/*#define HZTOUSER(hz) (((hz)*100)/HZ) would be better, but could overflow*/
+#define HZTOUSER(hz)    ((hz)/(HZ/100))
+/*#define HZFROMUSER(hz)  ((hz)*(HZ/100)) hmm, these will be small values, right?*/
+#define HZFROMUSER(hz)  (((hz)*HZ)/100)
+#define HZ_MASQUERADING (HZ/100)    /* defined if masquerading, HZ/HZ_MASQUERADING==100 */
 #endif
 
 #define EXEC_PAGESIZE	4096
diff -urNp --exclude-from /usr/src/lkdontdiff /img/linux-2.3.5/include/linux/param.h linux-2.3.5as/include/linux/param.h
--- /img/linux-2.3.5/include/linux/param.h	Tue Aug 15 13:25:06 1995
+++ linux-2.3.5as/include/linux/param.h	Tue Jul 20 02:14:42 1999
@@ -3,4 +3,10 @@
 
 #include <asm/param.h>
 
+/* if userspace sees the same HZ as the kernel then these are noops */
+#ifndef HZ_MASQUERADING
+#define HZTOUSER(hz)    (hz)
+#define HZFROMUSER(hz)  (hz)
+#endif
+
 #endif
diff -urNp --exclude-from /usr/src/lkdontdiff /img/linux-2.3.5/kernel/acct.c linux-2.3.5as/kernel/acct.c
--- /img/linux-2.3.5/kernel/acct.c	Sat May  1 16:36:01 1999
+++ linux-2.3.5as/kernel/acct.c	Tue Jul 20 00:59:49 1999
@@ -292,9 +292,9 @@ static int do_acct_process(long exitcode
 	ac.ac_comm[ACCT_COMM - 1] = '\0';
 
 	ac.ac_btime = CT_TO_SECS(current->start_time) + (xtime.tv_sec - (jiffies / HZ));
-	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
-	ac.ac_utime = encode_comp_t(current->times.tms_utime);
-	ac.ac_stime = encode_comp_t(current->times.tms_stime);
+	ac.ac_etime = encode_comp_t(HZTOUSER(jiffies - current->start_time));
+	ac.ac_utime = encode_comp_t(HZTOUSER(current->times.tms_utime));
+	ac.ac_stime = encode_comp_t(HZTOUSER(current->times.tms_stime));
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
 	ac.ac_tty = (current->tty) ? kdev_t_to_nr(current->tty->device) : 0;
diff -urNp --exclude-from /usr/src/lkdontdiff /img/linux-2.3.5/kernel/signal.c linux-2.3.5as/kernel/signal.c
--- /img/linux-2.3.5/kernel/signal.c	Tue Jun  1 10:21:01 1999
+++ linux-2.3.5as/kernel/signal.c	Tue Jul 20 00:36:17 1999
@@ -583,8 +583,8 @@ notify_parent(struct task_struct *tsk, i
 	info.si_pid = tsk->pid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
-	info.si_utime = tsk->times.tms_utime;
-	info.si_stime = tsk->times.tms_stime;
+	info.si_utime = HZTOUSER(tsk->times.tms_utime);
+	info.si_stime = HZTOUSER(tsk->times.tms_stime);
 
 	why = SI_KERNEL;	/* shouldn't happen */
 	switch (tsk->state) {
diff -urNp --exclude-from /usr/src/lkdontdiff /img/linux-2.3.5/kernel/sys.c linux-2.3.5as/kernel/sys.c
--- /img/linux-2.3.5/kernel/sys.c	Sat May 15 13:08:47 1999
+++ linux-2.3.5as/kernel/sys.c	Tue Jul 20 00:41:43 1999
@@ -614,7 +616,13 @@ asmlinkage long sys_times(struct tms * t
 	if (tbuf)
 		if (copy_to_user(tbuf, &current->times, sizeof(struct tms)))
 			return -EFAULT;
-	return jiffies;
+#if HZ_MASQUERADING
+	tbuf->tms_utime  /= HZ_MASQUERADING;
+	tbuf->tms_stime  /= HZ_MASQUERADING;
+	tbuf->tms_cutime /= HZ_MASQUERADING;
+	tbuf->tms_cstime /= HZ_MASQUERADING;
+#endif
+	return HZTOUSER(jiffies);
 }
 
 /*

--------------54341B8F2B3E33702282A786--



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
