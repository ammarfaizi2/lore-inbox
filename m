Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbTBNTml>; Fri, 14 Feb 2003 14:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267406AbTBNTmk>; Fri, 14 Feb 2003 14:42:40 -0500
Received: from franka.aracnet.com ([216.99.193.44]:14811 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267405AbTBNTm3>; Fri, 14 Feb 2003 14:42:29 -0500
Date: Fri, 14 Feb 2003 11:51:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Theurer <habanero@us.ibm.com>,
       Mark Peloquin <peloquin@austin.ibm.com>
Subject: [PATCH] percpu load avererages / *real* load averages
Message-ID: <72980000.1045252305@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1262621422=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1262621422==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Probably needs some tidying up before it's mergeable, but I like it. 
Is useful as is, so I thought other people might want to look at it and
give me feedback. Based very loosely on a earlier patch by Andrew Theurer
that gave nr_running per cpu, but I wanted to see load averages. This is
extremely useful for looking at scheduler rebalancing problems.

I think we should be basing the scheduler rebalance calculations off load
averages, rather than a couple of sample points - I'll create a patch to do
this sometime soon.

The normal load average calculates nr_running() + nr_uninterruptible()
which can be confusing. real_load_average just uses nr_running.

Output here is from a NUMA 16-way machine running make -j256 bzImage on the
kernel. 

larry:~# cat /proc/real_loadavg 
Domain    load1    load2    load3  nr_run/nr_thrd
SYSTEM    80.67    25.75     9.02     253/901
    0      5.09     1.61     0.56      18/901
    1      5.17     1.66     0.58      17/901
    2      5.28     1.70     0.59      14/901
    3      4.80     1.54     0.54      17/901
    4      5.39     1.72     0.60      16/901
    5      5.17     1.66     0.58      15/901
    6      4.72     1.50     0.53      15/901
    7      4.62     1.46     0.51      16/901
    8      5.27     1.69     0.59      18/901
    9      5.06     1.61     0.56      15/901
   10      5.15     1.63     0.57      16/901
   11      5.06     1.59     0.55      15/901
   12      5.45     1.70     0.59      17/901
   13      4.77     1.56     0.54      15/901
   14      4.89     1.55     0.54      15/901
   15      4.74     1.50     0.52      14/901
--==========1262621422==========
Content-Type: text/plain; charset=iso-8859-1; name=percpu_loadavg
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=percpu_loadavg; size=4908

diff -urpN -X /home/fletch/.diff.exclude virgin/fs/proc/proc_misc.c =
percpu_loadavg/fs/proc/proc_misc.c
--- virgin/fs/proc/proc_misc.c	Fri Jan 17 09:18:30 2003
+++ percpu_loadavg/fs/proc/proc_misc.c	Fri Feb 14 11:48:09 2003
@@ -95,6 +95,37 @@ static int loadavg_read_proc(char *page,
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
=20
+static int real_loadavg_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	int a, b, c, cpu;
+	int len;
+
+	a =3D tasks_running[0] + (FIXED_1/200);
+	b =3D tasks_running[1] + (FIXED_1/200);
+	c =3D tasks_running[2] + (FIXED_1/200);
+	len =3D sprintf(page,"Domain    load1    load2    load3  =
nr_run/nr_thrd\n");
+	len +=3D sprintf(page+len,"SYSTEM %5d.%02d %5d.%02d %5d.%02d %7ld/%7d\n",
+		LOAD_INT(a), LOAD_FRAC(a),
+		LOAD_INT(b), LOAD_FRAC(b),
+		LOAD_INT(c), LOAD_FRAC(c),
+		nr_running(), nr_threads);
+	for (cpu =3D 0; cpu < NR_CPUS; ++cpu) {
+		if (!cpu_online(cpu))
+			continue;
+		a =3D cpu_tasks_running[0][cpu] + (FIXED_1/200);
+		b =3D cpu_tasks_running[1][cpu] + (FIXED_1/200);
+		c =3D cpu_tasks_running[2][cpu] + (FIXED_1/200);
+		len +=3D sprintf(page+len, "%5d  %5d.%02d %5d.%02d %5d.%02d %7ld/7%d\n",
+			cpu,
+			LOAD_INT(a), LOAD_FRAC(a),=20
+			LOAD_INT(b), LOAD_FRAC(b),
+			LOAD_INT(c), LOAD_FRAC(c),
+			nr_running_cpu(cpu), nr_threads);
+	}
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -553,6 +584,7 @@ void __init proc_misc_init(void)
 		int (*read_proc)(char*,char**,off_t,int,int*,void*);
 	} *p, simple_ones[] =3D {
 		{"loadavg",     loadavg_read_proc},
+		{"real_loadavg",real_loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
 		{"version",	version_read_proc},
diff -urpN -X /home/fletch/.diff.exclude virgin/include/linux/sched.h =
percpu_loadavg/include/linux/sched.h
--- virgin/include/linux/sched.h	Fri Jan 17 09:18:32 2003
+++ percpu_loadavg/include/linux/sched.h	Fri Feb 14 10:35:14 2003
@@ -69,7 +69,11 @@ struct exec_domain;
  *    the EXP_n values would be 1981, 2034 and 2043 if still using only
  *    11 bit fractions.
  */
-extern unsigned long avenrun[];		/* Load averages */
+extern unsigned long avenrun[];				/* Load averages */
+extern unsigned long tasks_running[3]; 			/* Real load averages */
+extern unsigned long cpu_tasks_running[3][NR_CPUS];	/* Real load averages =
per cpu */
+
+extern unsigned long tasks_running[];	/* Real load averages */
=20
 #define FSHIFT		11		/* nr of bits of precision */
 #define FIXED_1		(1<<FSHIFT)	/* 1.0 as fixed-point */
@@ -91,6 +95,7 @@ extern int last_pid;
 DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 extern unsigned long nr_running(void);
+extern unsigned long nr_running_cpu(int i);
 extern unsigned long nr_uninterruptible(void);
 extern unsigned long nr_iowait(void);
=20
diff -urpN -X /home/fletch/.diff.exclude virgin/kernel/sched.c =
percpu_loadavg/kernel/sched.c
--- virgin/kernel/sched.c	Fri Jan 17 09:18:32 2003
+++ percpu_loadavg/kernel/sched.c	Fri Feb 14 11:06:23 2003
@@ -601,6 +601,11 @@ unsigned long nr_running(void)
 	return sum;
 }
=20
+unsigned long nr_running_cpu(int cpu)
+{
+	return cpu_rq(cpu)->nr_running;
+}
+
 unsigned long nr_uninterruptible(void)
 {
 	unsigned long i, sum =3D 0;
diff -urpN -X /home/fletch/.diff.exclude virgin/kernel/timer.c =
percpu_loadavg/kernel/timer.c
--- virgin/kernel/timer.c	Mon Dec 16 21:50:51 2002
+++ percpu_loadavg/kernel/timer.c	Fri Feb 14 10:58:55 2003
@@ -731,6 +731,8 @@ static unsigned long count_active_tasks(
  * Requires xtime_lock to access.
  */
 unsigned long avenrun[3];
+unsigned long tasks_running[3];
+unsigned long cpu_tasks_running[3][NR_CPUS];
=20
 /*
  * calc_load - given tick count, update the avenrun load estimates.
@@ -738,8 +740,9 @@ unsigned long avenrun[3];
  */
 static inline void calc_load(unsigned long ticks)
 {
-	unsigned long active_tasks; /* fixed-point */
+	unsigned long active_tasks, running_tasks; /* fixed-point */
 	static int count =3D LOAD_FREQ;
+	int cpu;
=20
 	count -=3D ticks;
 	if (count < 0) {
@@ -748,6 +751,19 @@ static inline void calc_load(unsigned lo
 		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
 		CALC_LOAD(avenrun[1], EXP_5, active_tasks);
 		CALC_LOAD(avenrun[2], EXP_15, active_tasks);
+		running_tasks =3D nr_running() * FIXED_1;
+		CALC_LOAD(tasks_running[0], EXP_1,  running_tasks);
+		CALC_LOAD(tasks_running[1], EXP_5,  running_tasks);
+		CALC_LOAD(tasks_running[2], EXP_15, running_tasks);
+		for (cpu =3D 0; cpu < NR_CPUS; ++cpu) {
+			if (!cpu_online(cpu))=20
+				continue;
+			running_tasks =3D nr_running_cpu(cpu) * FIXED_1;
+			CALC_LOAD(cpu_tasks_running[0][cpu], EXP_1,  running_tasks);
+			CALC_LOAD(cpu_tasks_running[1][cpu], EXP_5,  running_tasks);
+			CALC_LOAD(cpu_tasks_running[2][cpu], EXP_15, running_tasks);
+		}
+			
 	}
 }
=20

--==========1262621422==========--

