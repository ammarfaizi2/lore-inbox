Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbUC1KJT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 05:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUC1KJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 05:09:19 -0500
Received: from omr2.netsolmail.com ([216.168.230.163]:50067 "EHLO
	omr2.netsolmail.com") by vger.kernel.org with ESMTP id S262248AbUC1KJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 05:09:02 -0500
From: <shai@ftcon.com>
Message-Id: <200403281007.BHM58439@ms6.netsolmail.com>
Reply-To: <shai@ftcon.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <ricklind@us.ibm.com>, <mbligh@aracnet.com>,
       <lse-tech@lists.sourceforge.net>,
       "'Erik Jacobson'" <erikj@subway.americas.sgi.com>,
       "'Erich Focht'" <efocht@hpce.nec.com>, "'Paul Jackson'" <pj@sgi.com>,
       "'Xavier Bru'" <xavier.bru@bull.net>, <linux-kernel@vger.kernel.org>
Subject: FW: [Lse-tech] Re: NUMA scheduler issue
Date: Sun, 28 Mar 2004 02:07:54 -0800
Organization: FT Consulting
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00D3_01C41469.7C0F0FE0"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcQTD+3nX+TOcKyFTqG7YuYx8aLHxgBnIdWw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00D3_01C41469.7C0F0FE0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Very nice patch.
Andrew, would you consider adding this one? 

--Shai


-----Original Message-----
From: lse-tech-admin@lists.sourceforge.net
[mailto:lse-tech-admin@lists.sourceforge.net] On Behalf Of Erich Focht
Sent: Friday, March 26, 2004 00:31
To: Paul Jackson; Xavier Bru
Cc: ricklind@us.ibm.com; mbligh@aracnet.com; lse-tech@lists.sourceforge.net;
Erik Jacobson
Subject: Re: [Lse-tech] Re: NUMA scheduler issue

Hi Paul,

On Wednesday 24 March 2004 20:03, Paul Jackson wrote:
> Where are you getting the printouts that look like:
>
>     initial CPU = 2
>     cpu  18491 16
>     cpu0 17125 2
>     cpu1 441 0
>     cpu2 700 14
>     cpu3 225 0
>     ...
>     current_cpu 0
>
> We have something in our SGI 2.4 kernels (/proc/<pid>/cpu) that
> displays this sort of per-cpu usage, but I don't see anything
> in the 2.6 kernels that seems to do this.

its probably the attached patch. Sorry, I'm travelling and couldn't
rediff against a current version...





------=_NextPart_000_00D3_01C41469.7C0F0FE0
Content-Type: text/x-diff;
	name="cputimes_stat-2.6.0t1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cputimes_stat-2.6.0t1.patch"

diff -urN 2.6.0-test1-ia64-0/fs/proc/array.c =
2.6.0-test1-ia64-na/fs/proc/array.c
--- 2.6.0-test1-ia64-0/fs/proc/array.c	2003-07-14 05:35:12.000000000 =
+0200
+++ 2.6.0-test1-ia64-na/fs/proc/array.c	2003-07-18 13:38:02.000000000 =
+0200
@@ -405,3 +405,26 @@
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
 		       size, resident, shared, text, lib, data, 0);
 }
+
+#ifdef CONFIG_SMP
+int proc_pid_cpu(struct task_struct *task, char * buffer)
+{
+	int i, len;
+
+	len =3D sprintf(buffer,
+		"cpu  %lu %lu\n",
+		jiffies_to_clock_t(task->utime),
+		jiffies_to_clock_t(task->stime));
+	=09
+	for (i =3D 0 ; i < NR_CPUS; i++) {
+		if (cpu_online(i))
+		len +=3D sprintf(buffer + len, "cpu%d %lu %lu\n",
+			i,
+			jiffies_to_clock_t(task->per_cpu_utime[i]),
+			jiffies_to_clock_t(task->per_cpu_stime[i]));
+
+	}
+	len +=3D sprintf(buffer + len, "current_cpu %d\n",task_cpu(task));
+	return len;
+}
+#endif
diff -urN 2.6.0-test1-ia64-0/fs/proc/base.c =
2.6.0-test1-ia64-na/fs/proc/base.c
--- 2.6.0-test1-ia64-0/fs/proc/base.c	2003-07-14 05:35:15.000000000 =
+0200
+++ 2.6.0-test1-ia64-na/fs/proc/base.c	2003-07-18 13:38:02.000000000 =
+0200
@@ -56,6 +56,7 @@
 	PROC_PID_STAT,
 	PROC_PID_STATM,
 	PROC_PID_MAPS,
+	PROC_PID_CPU,
 	PROC_PID_MOUNTS,
 	PROC_PID_WCHAN,
 #ifdef CONFIG_SECURITY
@@ -83,6 +84,9 @@
   E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
   E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
   E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
+#ifdef CONFIG_SMP
+  E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
+#endif
   E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
   E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
   E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
@@ -1170,6 +1174,12 @@
 			inode->i_fop =3D &proc_info_file_operations;
 			ei->op.proc_read =3D proc_pid_stat;
 			break;
+#ifdef CONFIG_SMP
+		case PROC_PID_CPU:
+			inode->i_fop =3D &proc_info_file_operations;
+			ei->op.proc_read =3D proc_pid_cpu;
+			break;
+#endif
 		case PROC_PID_CMDLINE:
 			inode->i_fop =3D &proc_info_file_operations;
 			ei->op.proc_read =3D proc_pid_cmdline;
diff -urN 2.6.0-test1-ia64-0/include/linux/sched.h =
2.6.0-test1-ia64-na/include/linux/sched.h
--- 2.6.0-test1-ia64-0/include/linux/sched.h	2003-07-14 =
05:30:40.000000000 +0200
+++ 2.6.0-test1-ia64-na/include/linux/sched.h	2003-07-18 =
13:38:02.000000000 +0200
@@ -390,6 +390,9 @@
 	struct list_head posix_timers; /* POSIX.1b Interval Timers */
 	unsigned long utime, stime, cutime, cstime;
 	u64 start_time;
+#ifdef CONFIG_SMP
+	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
+#endif
 /* mm fault and swap info: this can arguably be seen as either =
mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 /* process credentials */
diff -urN 2.6.0-test1-ia64-0/kernel/fork.c =
2.6.0-test1-ia64-na/kernel/fork.c
--- 2.6.0-test1-ia64-0/kernel/fork.c	2003-07-14 05:30:39.000000000 +0200
+++ 2.6.0-test1-ia64-na/kernel/fork.c	2003-07-18 13:38:02.000000000 =
+0200
@@ -861,6 +861,14 @@
 	p->tty_old_pgrp =3D 0;
 	p->utime =3D p->stime =3D 0;
 	p->cutime =3D p->cstime =3D 0;
+#ifdef CONFIG_SMP
+	{
+		int i;
+
+		for(i =3D 0; i < NR_CPUS; i++)
+			p->per_cpu_utime[i] =3D p->per_cpu_stime[i] =3D 0;
+	}
+#endif
 	p->array =3D NULL;
 	p->lock_depth =3D -1;		/* -1 =3D no lock */
 	p->start_time =3D get_jiffies_64();
diff -urN 2.6.0-test1-ia64-0/kernel/timer.c =
2.6.0-test1-ia64-na/kernel/timer.c
--- 2.6.0-test1-ia64-0/kernel/timer.c	2003-07-14 05:37:22.000000000 =
+0200
+++ 2.6.0-test1-ia64-na/kernel/timer.c	2003-07-18 13:38:02.000000000 =
+0200
@@ -720,6 +720,10 @@
 void update_one_process(struct task_struct *p, unsigned long user,
 			unsigned long system, int cpu)
 {
+#ifdef CONFIG_SMP
+	p->per_cpu_utime[cpu] +=3D user;
+	p->per_cpu_stime[cpu] +=3D system;
+#endif
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
 	do_it_prof(p);

------=_NextPart_000_00D3_01C41469.7C0F0FE0--

