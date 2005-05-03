Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVECOMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVECOMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVECOMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:12:42 -0400
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:33470 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261563AbVECOHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:07:45 -0400
Message-ID: <427785A3.2050601@lifl.fr>
Date: Tue, 03 May 2005 16:07:31 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Philippe Marquet <Philippe.Marquet@lifl.fr>,
       Christophe Osuna <osuna@lifl.fr>, Julien Soula <soula@lifl.fr>,
       Jean-Luc Dekeyser <dekeyser@lifl.fr>, paul.mckenney@us.ibm.com
Subject: [1/3] ARTiS, an asymmetric real-time scheduler
References: <42778532.7090806@lifl.fr>
In-Reply-To: <42778532.7090806@lifl.fr>
Content-Type: multipart/mixed;
 boundary="------------040001060200010108080207"
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040001060200010108080207
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Here is the core of ARTiS.

--------------040001060200010108080207
Content-Type: text/x-patch;
 name="artis-2.6.11-20050502-noarch.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="artis-2.6.11-20050502-noarch.patch"

diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/Documentation/artis.txt 2.6.11-artis-cvs/Documentation/artis.txt
--- 2.6.11-pfm/Documentation/artis.txt	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.11-artis-cvs/Documentation/artis.txt	2005-05-02 14:13:18.000000000 +0200
@@ -0,0 +1,243 @@
+ARTiS - an Asymmetric Real-Time Scheduling
+http://www.lifl.fr/west/artis/
+https://gna.org/projects/artis/
+
+Eric Piel <Eric.Piel@lifl.fr>
+Christophe Osuna <Christophe.Osuna@lifl.fr>
+Julien Soula <Julien.Soula@lifl.fr>
+Philippe Marquet <Philippe.Marquet@lifl.fr>
+
+Université des Sciences et Technologies de Lille
+Laboratoire d'Informatique Fondamentale de Lille
+Last update: May 02, 2005
+------------------------------------------------------------------------------
+
+
+Overview
+--------
+
+ARTiS is a patch to the Linux scheduler directed to real-time SMP
+systems. By migrating tasks from real-time CPUs to non-real-time ones
+it can achieve very low latencies. On an 4x IA-64 we target user
+latencies always under 300µs.
+
+Detail descriptions of the implementation and measurements are available as
+research articles at: http://www.lifl.fr/west/artis .
+
+Installation
+------------
+
+ARTiS is provided as a set of Linux kernel patch. They apply against
+the vanilla Linux Kernel, available at http://www.kernel.org . Some
+versions might need to be applied against the Bull version of the
+Linux kernel. Use the command:
+ % patch -p1 < ../the-name-of-the.patch 
+
+ARTiS was designed to run on IA-64 and x86 SMP systems. You can
+compile it into the kernel by selecting:
+
+ [X] File systems -> Pseudo filesystems -> /proc file system support
+ [X] Processor types and features -> Preemptible Kernel
+ [X] Processor types and features ->   Compile the kernel with ARTiS
+ support
+
+Optionally you can select:
+
+ [X] Processor types and features ->     Compile the kernel with ARTiS
+ debugging support
+ [X] Processor types and features ->     Compile the kernel with ARTiS
+ accounting support
+
+You also need to disable the energy saving functions that could put the CPUs
+into a state with a long transition latency. For example, on IA-64 the
+pal_halt optimisation must be disabled, this can be done by appending "nohalt"
+to the kernel command line (in elilo.conf).
+
+System administration
+---------------------
+
+Before you can benefit from the ARTiS enhancements, you will have to
+boot on a Linux kernel including the patches on a SMP computer.
+
+You need to choose an appropriate CPU for the real-time program and
+set affinities accordingly via the /proc file system.
+
+The ARTiS interface provides three files:
+/proc/artis/active : contains 0 or 1 corresponding to the deactivation
+  or activation of ARTiS. It is writable.
+/proc/artis/maskrt : contains a hexadecimal number corresponding to the RT
+  CPU mask. You can change it only when ARTiS is disabled.
+/proc/artis/cpustat : gives various statistics about ARTiS, it is read-only.
+
+EXAMPLE:
+
+This is an x86 system with 4 processors. We will use the RTC interrupt
+for our real-time program, which will run on the 4th processor.
+
+   % cat /proc/interrupts
+              CPU0       CPU1       CPU2       CPU3
+     0:   16320035         14         10         11    IO-APIC-edge  timer
+     1:          8          1          0          0    IO-APIC-edge  i8042
+     2:          0          0          0          0          XT-PIC  cascade
+     8:          2          0          1    2459330    IO-APIC-edge  rtc
+    19:    9930157    1643458    1603777          0   IO-APIC-level  eth0
+    20:        133          0          1          0   IO-APIC-level  aic7xxx
+    21:         29          0          1          0   IO-APIC-level  aic7xxx
+    22:     134403          0          1          0   IO-APIC-level  aic7xxx
+   NMI:          0          0          0          0
+   LOC:   16318912   16318911   16318910   16318835
+   ERR:          0
+   MIS:          0
+   
+We need to redirect all the interrupts except the RTC one to the 3
+first processors (which means 7 as CPU mask):
+
+   % for i in 1 2 19 20 21 22 ; do echo 7 > /proc/irq/$i/smp_affinity ; done
+
+Alternatively, you can use the change_all_irqs.sh script available on
+the ARTiS webpage in the affinity-utils package. Warning, on IA-64, we
+have noticed that some IRQ may not be able to change of mask. You need
+to select another CPU than the one where the IRQ are as a RT CPU.
+
+Here we want to keep IRQ 8 (RTC) for the real-time process on the 4th CPU:
+
+   % echo 8 > /proc/irq/8/smp_affinity
+
+We want the 4th processor to be set as real-time:
+
+   % echo 8 > /proc/artis/maskrt
+
+And of course we must activate ARTiS :-)
+
+   % echo 1 > /proc/artis/active
+
+The active state of ARTiS as well as the maskrt properties can also be
+set on the command line (in elilo.conf) via respectively
+"artis_active" and "artis_maskrt=".
+
+IMPORTANT NOTE (bug workaround): As of 20050502, there seems to be a
+latency problem on SMPs. This bug appears both on x86 and IA-64, even
+when the computer is purely idle and without ARTiS. The problem: there
+is always one (and only one) CPU where the latencies are much higher
+than anywhere else (10x or 100x higher). This CPU seems to be the
+same that receive all the IRQs at boot, so you can detect it by having
+a look at /proc/interrupts. Set this CPU as an NRT CPU, that's all.
+
+
+ARTiS /proc interface
+---------------------
+
+The ARTiS activation is now realized after boot-time via the /proc
+interface.
+
+The following enables ARTiS
+
+   % echo 1 > /proc/artis/active
+
+while the following disable ARTiS
+
+   % echo 0 > /proc/artis/active
+
+
+The file /proc/artis/cpustat contains one line of statistics per CPU
+(a maximum of 8 CPUs). Every line contains in turn four columns with
+the number of migrations initiated on this CPU and some timings useful
+for debugging.
+
+
+The file /proc/artis/maskrt identifies the RT CPUs.
+
+You can specify which CPUs are real-time by writing into this file
+the mask of the CPUs.
+
+For instance the following will set 4th processor as real-time:
+
+   % echo 8 > /proc/artis/maskrt
+
+The following will set 2nd, 3rd and 4th CPUs as real-time:
+
+   % echo e > /proc/artis/maskrt
+
+
+
+
+Real-Time programming with ARTiS
+--------------------------------
+
+You will need to add some instructions to a program to make it
+real-time and to bind it to a CPU. Fortunately this is not a difficult
+task and if your application is POSIX compliant, most of them are
+probably already done. A function like the next one can be used for
+this:
+
+   #include <string.h>
+   #include <sched.h>
+
+   /* Set the current process to real-time priority.
+    * Return 0 on success, -1 on failure */
+   int set_realtime_priority(void)
+   {
+       sched_param schp;
+
+       memset(&schp, 0, sizeof(schp));
+       schp.sched_priority = sched_get_priority_max(SCHED_FIFO);
+
+       return sched_setscheduler(0, SCHED_FIFO, &schp);
+   }
+
+Setting the affinity of a process might not be correctly handled by
+the glibc, so you will have to make a syscall. The following might
+help:
+
+   #include <unistd.h>
+
+   #if defined(__ia64__)
+   #define SYS_sched_setaffinity 1231
+   #define SYS_sched_getaffinity 1232
+   #elif defined(__i386__)
+   #define SYS_sched_setaffinity 241
+   #define SYS_sched_getaffinity 242
+   #else
+   #error Architecture not supported (only ia64 an i386 are)
+   #endif
+   
+   #define sched_setaffinity(arg1, arg2, arg3) \
+           syscall(SYS_sched_setaffinity, arg1, arg2, arg3)
+   #define sched_getaffinity(arg1, arg2, arg3) \
+           syscall(SYS_sched_getaffinity, arg1, arg2, arg3)
+   
+   /* Set the affinity of the current process.
+    * Return 0 on success, -1 on failure */
+   int set_affinity(unsigned long mask)
+   {
+       return sched_setaffinity(0, sizeof(mask), &mask);
+   }
+
+With respect to the example above, our program will need to make the
+following calls somewhere:
+
+   {
+       set_realtime_priority();
+       set_affinity(8);
+   }
+
+Due to the nature of ARTiS, the only constraint compared to a usual
+POSIX RT application is the order of this two function calls. The
+priority set up must always be *before* the affinity set up
+(otherwise, the affinity cannot be guaranted).
+
+Always keep in mind that if you want your task to have obtain firm
+real-time latencies, they will have to be RT0. Such task have the
+maximum RT FIFO priority and are binded to one and only one RT CPU.
+Guaranty can be insured only for one RT0 task per CPU. More RT0 per
+CPU is possible but it is your job to check that they can all be
+executed in the same time and always repect their deadlines.
+
+In case you don't want (or cannot) recompile your application to fit
+those specific requirements for ARTiS, you can still change it to RT0
+from outside. schedtool is probably what you need, cf http://freequaos.host.sk/schedtool/.
+
+Another way to do this is to use the functions provided by libartis, a
+small package available on the ARTiS webpage. If you need a more
+elaborate example, you can have a look at realfeel-pfm, also available
+at the ARTiS webpage.
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/Documentation/kernel-parameters.txt 2.6.11-artis-cvs/Documentation/kernel-parameters.txt
--- 2.6.11-pfm/Documentation/kernel-parameters.txt	2005-03-02 08:38:34.000000000 +0100
+++ 2.6.11-artis-cvs/Documentation/kernel-parameters.txt	2005-03-25 19:47:46.000000000 +0100
@@ -220,6 +220,12 @@ running once the system is up.
 	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
 			Format: <io>,<irq>,<nodeID>
 
+	artis_active    [KNL] Activates ARTiS
+			See also Documentation/artis.txt
+
+	artis_maskrt=   [KNL] Set ARTiS real-time CPUs mask
+			See also Documentation/artis.txt
+
 	ataflop=	[HW,M68k]
 
 	atarimouse=	[HW,MOUSE] Atari Mouse
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/fs/proc/artis.c 2.6.11-artis-cvs/fs/proc/artis.c
--- 2.6.11-pfm/fs/proc/artis.c	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.11-artis-cvs/fs/proc/artis.c	2005-05-02 14:22:14.000000000 +0200
@@ -0,0 +1,254 @@
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+#include <linux/ctype.h>
+#include <linux/kernel_stat.h>
+#include <linux/artis.h>
+#include <linux/sched.h>
+
+
+/* 
+ * tools functions 
+ */
+
+#define INT_10_SIZE (sizeof(int)*8/3+2/* 1 for the rouding and 1 for the sign */)
+#define LONG_10_SIZE (sizeof(long)*8/3+2/* 1 for the rouding and 1 for the sign */)
+
+int
+artis_copy_from_user_ltrim(const char *ubuf, int ulen, char *kbuf, int klen) {
+	int kl = 0, ul = 0;
+	kbuf[0] = '\0';
+	
+	while ((ul < ulen) && (kl < klen)) {
+		int l, i;
+		if (ulen-ul > klen-kl)
+			l = klen-kl;
+		else
+			l = ulen-ul;
+		copy_from_user(kbuf+kl, ubuf+ul, l);
+		ul += l;
+		kl += l;
+		kbuf[kl] = '\0';
+		for (i = 0; isspace(kbuf[i]); i++)
+			;
+		if (i) {
+			int j;
+			for (j = i; (kbuf[j-i] = kbuf[j]); j++)
+				;
+			kl -= i;
+		}
+	}
+	return ul;
+}
+
+#ifdef CONFIG_ARTIS
+
+static struct proc_dir_entry *proc_artis = NULL;
+
+/*
+ * functions for /proc/artis
+ */
+
+int 
+artis_proc_read_active(char* page, char** start, off_t off, int count, int* eof, void* data) {
+	int len = 0, r;
+
+	/* 0 or neg if inactive, number is number of task in RT-Q */
+	if (artis_info.active)
+		r = 1+atomic_read(&(artis_info.size));
+	else
+		r = -atomic_read(&(artis_info.size));
+	len = snprintf(page+off, count, "%d\n", r);
+	if (len > count)
+		return -EFAULT;
+	return len;
+}
+
+int 
+artis_proc_write_active(struct file *file, const char *buffer, unsigned long count, void *data) {
+	int len;
+#define MAXBUF INT_10_SIZE+100
+	char kbuf[MAXBUF+1];
+	char *endp;
+	int val;
+
+	len = artis_copy_from_user_ltrim(buffer, count, kbuf, MAXBUF);
+	val = simple_strtol(kbuf, &endp, 0);
+	if (*endp && !isspace(*endp))
+		return -EINVAL;
+
+	spin_lock(&artis_info.lock);
+	artis_info.active = (val > 0);
+	spin_unlock(&artis_info.lock);
+
+	return len;
+#undef MAXBUF
+}
+
+int 
+artis_proc_read_maskrt(char* page, char** start, off_t off, int count, int* eof, void* data) {
+	int len;
+
+	spin_lock(&artis_info.lock);
+	
+	len = cpumask_scnprintf(page, count - 2, artis_info.cpus_rt);
+	
+	if (count - len < 2) {
+		len = -EFAULT;
+		goto ret;
+	}
+	len += sprintf(page + len, "\n");
+ret:
+	spin_unlock(&artis_info.lock);
+	return len;
+}
+
+/* only work for less than 8*sizeof(long) CPUs */
+int 
+artis_proc_write_maskrt(struct file *file, const char *buffer, unsigned long count, void *data) {
+	int len = count, err;
+	cpumask_t mask;
+
+	spin_lock(&artis_info.lock);
+	if (artis_info.active) {
+		len = -EPERM;
+		goto ret ;
+	}
+
+	err = cpumask_parse(buffer, count, mask);
+	if (err) {
+		len = -EINVAL;
+		goto ret;
+	}
+
+	/* flush pending migrations */
+	/* XXX OK, this active wait is not very pretty, but this should not
+	 * occur frequently, so wo cares ? (not me obviously) */
+	while (atomic_read(&artis_info.size))
+		;
+
+	if (artis_reinit(mask)<0)
+		len = -EINVAL;
+ret:
+	spin_unlock(&artis_info.lock);
+	return len;
+#undef MAXBUF
+}
+
+
+#ifdef CONFIG_ARTIS_STAT
+int
+artis_proc_read_cpustat(char* page, char** start, off_t off, int count, int* eof, void* data) { 
+	int len, i;
+	artis_per_cpu_info_t *artis_cpu = NULL;
+
+	spin_lock(&artis_info.lock);
+	len = 0;
+	for(i = 0; i < NR_CPUS; i++) {
+		artis_cpu = cpu_artis(i);
+		len += snprintf(page+off+len, count-len,
+			"cpu%d %lu %lu %lu %lu %lu\n",
+			i,
+			artis_cpu->nb_migration,
+			artis_cpu->migration_delta[0],
+			artis_cpu->migration_delta[1],
+			artis_cpu->migration_delta[2],
+			kstat_cpu(i).cpustat.rt);
+		if (len > count) {
+			len = -EFAULT;
+			goto ret;
+		}
+	}
+ret:
+	spin_unlock(&artis_info.lock);
+	return len;
+}
+#endif
+
+/*
+ * Create /proc/artis struct
+ */
+int
+artis_proc_init(void) {
+	struct proc_dir_entry *proc_active, *proc_maskrt;
+#ifdef CONFIG_ARTIS_STAT
+	struct proc_dir_entry *proc_cpustat;
+#endif
+	if (!(proc_artis = proc_mkdir("artis", NULL))) {
+		printk("ARTIS error: create /proc/artis\n");
+		goto err;
+	}
+	if (!(proc_active = create_proc_entry("active", 0644, proc_artis))) {
+		printk("ARTIS error: create /proc/artis/active\n");
+		goto err1;
+	}
+	proc_active->read_proc = artis_proc_read_active;
+	proc_active->write_proc = artis_proc_write_active;
+	if (!(proc_maskrt = create_proc_entry("maskrt", 0644, proc_artis))) {
+		printk("ARTIS error: create /proc/artis/mask\n");
+		goto err2;
+	}
+	proc_maskrt->read_proc = artis_proc_read_maskrt;
+	proc_maskrt->write_proc = artis_proc_write_maskrt;
+#ifdef CONFIG_ARTIS_STAT
+	if (!(proc_cpustat = create_proc_read_entry("cpustat", 0444, proc_artis, artis_proc_read_cpustat, NULL))) {
+		printk("ARTIS error: create /proc/artis/cupstat\n");
+		goto err3;
+	}
+#endif
+	return 0;
+
+#ifdef CONFIG_ARTIS_STAT
+err3:
+	remove_proc_entry("cpustat", proc_artis);
+#endif
+	remove_proc_entry("maskrt", proc_artis);
+err2:
+	remove_proc_entry("active", proc_artis);
+err1:
+	remove_proc_entry("artis", NULL);
+err:
+	return -1;
+}
+
+int
+artis_proc_reset(void) {
+	remove_proc_entry("active", proc_artis);
+	remove_proc_entry("maskrt", proc_artis);
+	remove_proc_entry("cpustat", proc_artis);
+	remove_proc_entry("artis", NULL);
+	return 0;
+}
+
+/*
+ * functions for the /proc/<pid>/artis
+ */
+
+int 
+proc_pid_artis(struct task_struct *task, char *buffer)
+{
+	artis_task_status_t *artis_task;
+	artis_per_cpu_info_t *artis_cpu = NULL;
+	int len;
+
+	artis_migration_disable();
+	preempt_disable();
+	artis_task = &task->artis_status;
+	artis_cpu = cpu_artis(task->thread_info->cpu);
+	len = sprintf(buffer, 
+			"%lu %lx %lu",
+			artis_task->nb_migration, 
+			artis_flag(task),
+			artis_cpu->nb_migration
+			);
+	len += sprintf(buffer+len, " %llu %llu",
+		        artis_task->last_attempt,
+		        artis_task->attempt_period);
+	len += sprintf(buffer+len, "\n");
+	artis_migration_enable();
+	preempt_enable();
+	return len;
+}
+
+#endif
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/fs/proc/base.c 2.6.11-artis-cvs/fs/proc/base.c
--- 2.6.11-pfm/fs/proc/base.c	2005-03-02 08:38:12.000000000 +0100
+++ 2.6.11-artis-cvs/fs/proc/base.c	2005-03-25 19:47:46.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/artis.h>
 #include "internal.h"
 
 /*
@@ -74,6 +75,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TGID_LOGINUID,
 #endif
+#ifdef CONFIG_ARTIS
+	PROC_TGID_ARTIS,
+#endif
 	PROC_TGID_FD_DIR,
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
@@ -105,6 +109,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
 #endif
+#ifdef CONFIG_ARTIS
+	PROC_TID_ARTIS,
+#endif
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
@@ -148,6 +155,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_ARTIS
+	E(PROC_TGID_ARTIS,     "artis",   S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -178,6 +188,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_ARTIS
+	E(PROC_TID_ARTIS,     "artis",   S_IFREG|S_IRUGO),
+#endif
 	{0,0,NULL,0}
 };
 
@@ -1476,6 +1489,13 @@ static struct dentry *proc_pident_lookup
 			ei->op.proc_read = proc_pid_wchan;
 			break;
 #endif
+#ifdef CONFIG_ARTIS
+		case PROC_TID_ARTIS:
+		case PROC_TGID_ARTIS:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_artis;
+			break;
+#endif
 #ifdef CONFIG_SCHEDSTATS
 		case PROC_TID_SCHEDSTAT:
 		case PROC_TGID_SCHEDSTAT:
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/fs/proc/Makefile 2.6.11-artis-cvs/fs/proc/Makefile
--- 2.6.11-pfm/fs/proc/Makefile	2005-03-02 08:37:47.000000000 +0100
+++ 2.6.11-artis-cvs/fs/proc/Makefile	2005-03-25 19:47:46.000000000 +0100
@@ -8,7 +8,7 @@ proc-y			:= nommu.o task_nommu.o
 proc-$(CONFIG_MMU)	:= mmu.o task_mmu.o
 
 proc-y       += inode.o root.o base.o generic.o array.o \
-		kmsg.o proc_tty.o proc_misc.o
+		kmsg.o proc_tty.o proc_misc.o artis.o
 
 proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_DEVICETREE)	+= proc_devtree.o
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/include/linux/artis.h 2.6.11-artis-cvs/include/linux/artis.h
--- 2.6.11-pfm/include/linux/artis.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.11-artis-cvs/include/linux/artis.h	2005-04-22 18:08:19.000000000 +0200
@@ -0,0 +1,273 @@
+/*
+ * ARTiS support
+ *
+ */
+
+#ifndef _ARTIS_ARTIS_H
+#define	_ARTIS_ARTIS_H
+
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/cpumask.h>
+#include <linux/percpu.h>
+#include <linux/init.h>
+
+#include <linux/artis-macros.h>
+
+#if CONFIG_ARTIS
+
+#if defined(CONFIG_ARTIS_STAT) && defined(CONFIG_LTT)
+extern int artis_ltt_req1;
+extern int artis_ltt_req2;
+extern int artis_ltt_complete;
+extern int artis_ltt_fetch;
+#endif
+
+/* There is a migration queue between each RT and NRT CPU. The queue used to
+ * be a FIFO, but since the introduction of the optimized
+ * kernel/sched.c:artis_valois_pull_all() it is no longer the case: the
+ * very last task appened in the migration queue will be the first pulled
+ * from the migration queue. Still, this is not a big issue.
+ */
+
+
+/* Node of the migration queue */
+typedef struct artis_fifo_node {
+  struct task_struct *task;
+  struct artis_fifo_node *next;
+} artis_fifo_node_t;
+
+#define ARTIS_FIFO_NODE_INIT {    \
+        .task = NULL,        \
+        .next = NULL,        \
+}
+#define SET_ARTIS_FIFO_NODE_INIT(v) v = ARTIS_FIFO_NODE_INIT,
+
+extern kmem_cache_t *artis_fifo_node_cachep;
+#define alloc_artis_fifo_node(task) \
+	kmem_cache_alloc(artis_fifo_node_cachep, GFP_KERNEL)
+#define free_artis_fifo_node(node) \
+	kmem_cache_free(artis_fifo_node_cachep, (node))
+
+#ifdef CONFIG_ARTIS_DEBUG
+#define ARTIS_BT_SIZE 7
+typedef struct artis_stack {
+	unsigned long time;
+	void *bt[ARTIS_BT_SIZE];
+} artis_stack_t;
+
+#define ARTIS_STACK_INIT {	\
+	.time = 0,		\
+}
+#define SET_ARTIS_STACK_INIT(v) v = ARTIS_STACK_INIT,
+#endif
+
+typedef struct artis_local_task_status {
+	struct task_struct *next;	/* next task in the linked list */
+	cpumask_t cpus_allowed_bak;	/* backup of task cpus_allowed */
+	long cpu;			/* cpu from */
+#ifdef CONFIG_ARTIS_STAT
+        /* some timings of code of migration:
+         * _ migration_delta[0]: artis_request_for_migration() call
+         * _ migration_delta[1]: before the schedule() that will initiate the migration
+         * _ migration_delta[2]: artis_complete_migration() call
+         * _ migration_delta[3]: before the schedule() on the NRT CPU
+         */
+	unsigned long migration_delta[4];
+#endif
+#ifdef CONFIG_ARTIS_DEBUG
+	unsigned long complete_by_at;	/* time when being completed */
+	struct task_struct *complete_by; /* task that is doing the complete (not the completed task) */
+	artis_stack_t request;		/* info on the task doing the request */
+#endif
+} artis_local_task_status_t; 
+
+#if defined(CONFIG_ARTIS_STAT) && defined(CONFIG_ARTIS_DEBUG)
+#define ARTIS_LOCAL_TASK_STATUS_INIT {	\
+	.migration_delta = {0,0,0,0},	\
+	.complete_by_at = 0,		\
+	.complete_by = NULL,		\
+	ARTIS_STACK_INIT,		\
+}
+
+#elif defined(CONFIG_ARTIS_STAT)
+#define ARTIS_LOCAL_TASK_STATUS_INIT {	\
+	.migration_delta = {0,0,0,0},	\
+}
+
+#elif defined(CONFIG_ARTIS_DEBUG)
+#define ARTIS_LOCAL_TASK_STATUS_INIT {	\
+	.complete_by_at = 0,		\
+	.complete_by = NULL,		\
+	ARTIS_STACK_INIT,		\
+}
+
+#else
+#define ARTIS_LOCAL_TASK_STATUS_INIT {	\
+}
+#endif
+
+#define SET_ARTIS_LOCAL_TASK_STATUS_INIT(v) v = ARTIS_LOCAL_TASK_STATUS_INIT,
+
+/* Structure for ARTiS migration. This is added to task_struct. */
+typedef struct artis_task_status
+{
+	unsigned long flag;		/* step of migration */
+	unsigned long nb_migration;
+	int migration_count;		/* ARTiS lock depth */
+	artis_fifo_node_t *fifo_node;   /* node of the migration queue containing the task */
+	unsigned long long last_attempt;	/* last attempt to migrate for the task */
+	unsigned long long attempt_period;	/* time ponderated average period between attempt to migrate */
+	artis_local_task_status_t *local_status;
+#ifdef CONFIG_ARTIS_DEBUG
+	unsigned long complete_to_at;	/* time when completing */
+	struct task_struct *complete_to;/* task which is being completed */
+	artis_stack_t complete;		/* info on the task doing the complete (not the completed task) */
+#endif
+} artis_task_status_t;
+
+#ifdef CONFIG_ARTIS_DEBUG
+#define ARTIS_TASK_STATUS_INIT {	\
+	.flag = 0,			\
+	.nb_migration = 0,		\
+	.migration_count = 0,		\
+        .fifo_node = NULL,              \
+	.local_status = NULL,		\
+	.complete_to_at = 0,		\
+	.complete_to = NULL,		\
+      ARTIS_STACK_INIT,			\
+}
+#else
+
+#define ARTIS_TASK_STATUS_INIT {	\
+	.flag = 0,			\
+	.nb_migration = 0,		\
+	.migration_count = 0,		\
+	.last_attempt = 0,		\
+	.attempt_period = 0,		\
+	.fifo_node = NULL,              \
+	.local_status = NULL,		\
+}
+#endif
+
+#define SET_ARTIS_TASK_STATUS_INIT(v) v = ARTIS_TASK_STATUS_INIT,
+
+/* 
+ * Migration queue
+ * There will be one between each RT and NRT processors, or if 
+ * load-balancing is activated, there is 2 between each processors.
+ */
+typedef struct artis_migration_queue
+{
+	atomic_t size;				/* size of the linked list */
+	artis_fifo_node_t *head, *tail;		/* edjes of the list */
+} artis_migration_queue_t;
+
+#define ARTIS_MIGRATION_QUEUE_INIT { 		\
+	.size = ATOMIC_INIT(0),		       	\
+	.head = NULL,                           \
+	.tail = NULL,                           \
+}
+#define SET_ARTIS_MIGRATION_QUEUE_INIT(v) v = ARTIS_MIGRATION_QUEUE_INIT,
+
+typedef struct artis_per_cpu_info
+{
+	artis_migration_queue_t ***queues; /* pointer to shared [RT][NRT] queues matrix */
+	unsigned int cpu_type;		/* ARTIS_RT_CPU or ARTIS_NRT_CPU */
+	unsigned long nb_migration;	/* number of migrations initiated on this (RT) CPU */
+	atomic_t fetch_size;		/* number of tasks waiting for a fetch on this (NRT) CPU */
+#ifdef CONFIG_ARTIS_STAT
+	/* Biggest timings on this CPU: 
+	 * _ migration_delta[0]: time between artis_request_for_migration()
+	 * 	and schedule()
+	 * _ migration_delta[1]: time between schedule() and
+	 * 	artis_complete_migration()
+	 * _ migration_delta[2]: time between artis_complete_migration() and
+	 * 	schedule()
+	 */
+	unsigned long migration_delta[3];
+#endif
+} artis_per_cpu_info_t;
+
+#if defined(CONFIG_ARTIS_STAT) && defined(CONFIG_ARTIS_DEBUG)
+#define ARTIS_PER_CPU_INFO_INIT {	\
+	.queues = NULL, 		\
+	.cpu_type = 0,			\
+	.nb_migration = 0,		\
+	.fetch_size = ATOMIC_INIT(0),	\
+	.migration_delta = {0,0,0},	\
+}
+
+#elif defined(CONFIG_ARTIS_STAT)
+#define ARTIS_PER_CPU_INFO_INIT {	\
+	.queues = NULL, 		\
+	.cpu_type = 0,			\
+	.nb_migration = 0,		\
+	.fetch_size = ATOMIC_INIT(0),	\
+	.migration_delta = {0,0,0},	\
+}
+
+#elif defined(CONFIG_ARTIS_DEBUG)
+#define ARTIS_PER_CPU_INFO_INIT {	\
+	.queues = NULL, 		\
+	.cpu_type = 0,			\
+	.nb_migration = 0,		\
+	.fetch_size = ATOMIC_INIT(0),	\
+}
+
+#else
+#define ARTIS_PER_CPU_INFO_INIT {	\
+	.queues = NULL, 		\
+	.cpu_type = 0,			\
+	.nb_migration = 0,		\
+	.fetch_size = ATOMIC_INIT(0),	\
+}
+
+#endif
+
+#define SET_ARTIS_PER_CPU_INFO_INIT(v) v = ARTIS_PER_CPU_INFO_INIT,
+DECLARE_PER_CPU(artis_per_cpu_info_t, artis_percpu);
+
+typedef struct artis_info {
+	int active;		/* is ARTiS active? */
+	cpumask_t cpus_rt;	/* mask of RT CPUs */
+        cpumask_t cpus_nrt;	/* mask of NRT CPUs */
+	atomic_t size;		/* total number of tasks in all the fifo's */
+	spinlock_t lock;
+} artis_info_t;
+
+#define ARTIS_INFO_INIT {		\
+	.active = 0,			\
+	.cpus_rt = CPU_MASK_NONE,	\
+	.cpus_nrt = CPU_MASK_ALL,	\
+	.size = ATOMIC_INIT(0),		\
+	.lock = SPIN_LOCK_UNLOCKED,	\
+}
+#define SET_ARTIS_INFO_INIT(v) v = ARTIS_INFO_INIT,
+
+extern artis_info_t artis_info;
+
+void artis_request_for_migration(void);
+int artis_complete_migration(struct task_struct *task);
+void artis_fetch_from_migration(int);
+void artis_check_dummyfifo(int rt);
+int proc_pid_artis(struct task_struct *task, char *buffer);
+int artis_proc_init(void);
+int artis_proc_reset(void);
+int artis_reinit(cpumask_t);
+
+#ifdef CONFIG_ARTIS_DEBUG
+void artis_put_trace(void **, struct task_struct *, unsigned long *);
+#endif
+
+#else  /* CONFIG_ARTIS */
+
+#define SET_ARTIS_LOCAL_TASK_STATUS_INIT(v)
+#define SET_ARTIS_STACK_INIT(v)
+#define SET_ARTIS_TASK_STATUS_INIT(v)
+#define SET_ARTIS_MIGRATION_QUEUE_INIT(v)
+#define SET_ARTIS_PER_CPU_INFO_INIT(v)
+
+#endif /* CONFIG_ARTIS */
+
+#endif
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/include/linux/artis-macros.h 2.6.11-artis-cvs/include/linux/artis-macros.h
--- 2.6.11-pfm/include/linux/artis-macros.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.11-artis-cvs/include/linux/artis-macros.h	2005-05-02 14:22:14.000000000 +0200
@@ -0,0 +1,136 @@
+/*
+ * ARTiS macros support
+ *
+ *
+ */
+#ifndef _ARTIS_ARTIS_MACRO_H
+#define	_ARTIS_ARTIS_MACRO_H
+
+#define ARTIS_RT_CPU  1
+#define ARTIS_NRT_CPU 0
+
+#define ARTIS_DEBUG_SIZE 512
+
+#define ARTIS_STATUS_REQUEST1	(0x01) // beginning of request function
+#define ARTIS_STATUS_REQUEST2	(0x02) // just after the de-activate
+#define ARTIS_STATUS_COMPLETE1	(0x04) // just before the enqueueing
+#define ARTIS_STATUS_COMPLETE2	(0x08) // just after the enqueueing
+#define ARTIS_STATUS_FETCH	(0x10) // after the dequeueing
+#define ARTIS_STATUS_DUMMY1	(0x20) // in dummy, before the printk
+#define ARTIS_STATUS_DUMMY2	(0x40) // in dummy, after the printk
+#define ARTIS_STATUS_LB		(0x80) // a task is being load-balanced
+
+#define cpu_artis(cpu)          (&per_cpu(artis_percpu, (cpu)))
+#define this_artis()            (&__get_cpu_var(artis_percpu))
+
+#define artis_is_this_cpu_rt() (artis_is_cpu_rt(smp_processor_id()))
+#define artis_is_this_cpu_nrt() (artis_is_cpu_nrt(smp_processor_id()))
+#define artis_test_this_migrating() (artis_test_migrating(current))
+#define artis_this_flag() (artis_flag(current))
+#define artis_this_local() (artis_local(current))
+
+#ifdef CONFIG_ARTIS
+
+#ifdef CONFIG_ARTIS_DEBUG
+#define ARTIS_BUG(c, x...) 	\
+do { 				\
+	if (unlikely(c)) 	\
+		artis_bug(__LINE__, __FILE__, 0UL, ##x); \
+} while (0)
+void artis_bug(int, char *, unsigned long, ...);
+#else
+#define ARTIS_BUG(c, x...) 
+#endif
+
+void artis_try_to_migrate(void);
+void function_artis_migration_disable(void);
+void function_artis_migration_enable(void);
+
+#define artis_is_cpu_rt(id) ((cpu_artis(id))->cpu_type == ARTIS_RT_CPU)
+#define artis_is_cpu_nrt(id) ((cpu_artis(id))->cpu_type == ARTIS_NRT_CPU)
+#define artis_test_migrating(p) (artis_flag(p) & ARTIS_STATUS_REQUEST2)
+#define artis_flag(p) ((p)->artis_status.flag)
+#define artis_local(p) ((p)->artis_status.local_status)
+#define artis_migration_count() ((current)->artis_status.migration_count)
+
+#define artis_isrt0() ((current)->policy==SCHED_FIFO && \
+                      (current)->prio==0)
+
+/* preempt_disable() will try_to_migrate() */
+#define artis_force_migration() 	\
+do { 					\
+	preempt_disable(); 		\
+	preempt_enable_no_resched(); 	\
+} while(0)
+
+/*
+ * migration not possible if:
+ * 	idle or
+ * 	migration off or
+ * 	preempt already off or
+ * 	RT0 or
+ * 	in interrupt handler (hard or soft) or
+ * 	irq already off (shouldn't happen because we've already migrated before, BUT IT HAPPEN!!!) or
+ * 	CPU is not RT 
+ */
+
+/*
+ * this tests should be done before the migration stats because they are
+ * independant of the state of the task.
+ */
+#define _artis_ismigrable_nostat()	\
+	(artis_info.active > 0 &&	\
+	preempt_count() <= 1 &&		\
+	!in_interrupt() &&		\
+	!artis_migration_count() &&	\
+	!irqs_disabled() &&		\
+	current->pid > 1	)
+/*
+ * These tests should be done after stat computation because the task is
+ * endangering the RT properties (just that we allow it anyway).
+ */
+#define _artis_ismigrable_stat()	\
+	(artis_is_this_cpu_rt() &&	\
+	!artis_isrt0()		)
+
+#define inc_artis_migration_count() 	\
+do { 					\
+	artis_migration_count()++; 	\
+} while (0)
+
+#define dec_artis_migration_count() 	\
+do { 					\
+	artis_migration_count()--; 	\
+} while (0)
+
+#define artis_migration_disable() 	\
+do { 					\
+	inc_artis_migration_count(); 	\
+	barrier(); 			\
+} while (0)
+
+#define artis_migration_enable() 	\
+do { 					\
+	barrier(); 			\
+	dec_artis_migration_count(); 	\
+} while (0)
+
+#else
+
+#define ARTIS_BUG(c, x...) 
+
+#define artis_is_cpu_rt(id) (0)
+#define artis_is_cpu_nrt(id) (0)
+#define artis_isrt0() (0)
+#define artis_test_migrating(p) (0)
+#define artis_force_migration() do { } while(0)
+#define _artis_ismigrable() (0)
+#define _artis_ismigrable_nostat() (0)
+#define _artis_ismigrable_stat() (0)
+#define artis_migration_disable() do { } while(0)
+#define artis_migration_enable() do { } while(0)
+
+#endif
+
+#endif
+
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/include/linux/init_task.h 2.6.11-artis-cvs/include/linux/init_task.h
--- 2.6.11-pfm/include/linux/init_task.h	2005-03-02 08:37:48.000000000 +0100
+++ 2.6.11-artis-cvs/include/linux/init_task.h	2005-03-25 19:47:46.000000000 +0100
@@ -112,6 +112,7 @@ extern struct group_info init_groups;
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	SET_ARTIS_TASK_STATUS_INIT(.artis_status)			\
 }
 
 
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/include/linux/kernel_stat.h 2.6.11-artis-cvs/include/linux/kernel_stat.h
--- 2.6.11-pfm/include/linux/kernel_stat.h	2005-03-02 08:38:26.000000000 +0100
+++ 2.6.11-artis-cvs/include/linux/kernel_stat.h	2005-04-22 18:33:41.000000000 +0200
@@ -7,6 +7,7 @@
 #include <linux/threads.h>
 #include <linux/percpu.h>
 #include <asm/cputime.h>
+#include <linux/artis.h>
 
 /*
  * 'kernel_stat.h' contains the definitions needed for doing
@@ -23,6 +24,9 @@ struct cpu_usage_stat {
 	cputime64_t idle;
 	cputime64_t iowait;
 	cputime64_t steal;
+#ifdef CONFIG_ARTIS
+	u64 rt;
+#endif
 };
 
 struct kernel_stat {
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/include/linux/preempt.h 2.6.11-artis-cvs/include/linux/preempt.h
--- 2.6.11-pfm/include/linux/preempt.h	2005-03-02 08:37:50.000000000 +0100
+++ 2.6.11-artis-cvs/include/linux/preempt.h	2005-03-25 19:47:46.000000000 +0100
@@ -8,6 +8,7 @@
 
 #include <linux/config.h>
 #include <linux/linkage.h>
+#include <linux/artis-macros.h>
 
 #ifdef CONFIG_DEBUG_PREEMPT
   extern void fastcall add_preempt_count(int val);
@@ -17,7 +18,15 @@
 # define sub_preempt_count(val)	do { preempt_count() -= (val); } while (0)
 #endif
 
+#ifdef CONFIG_ARTIS
+#define inc_preempt_count() 	\
+do { 				\
+	add_preempt_count(1);	\
+	artis_try_to_migrate();	\
+} while (0)
+#else
 #define inc_preempt_count() add_preempt_count(1)
+#endif
 #define dec_preempt_count() sub_preempt_count(1)
 
 #define preempt_count()	(current_thread_info()->preempt_count)
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/include/linux/sched.h 2.6.11-artis-cvs/include/linux/sched.h
--- 2.6.11-pfm/include/linux/sched.h	2005-03-02 08:37:48.000000000 +0100
+++ 2.6.11-artis-cvs/include/linux/sched.h	2005-04-26 01:21:49.000000000 +0200
@@ -33,6 +33,8 @@
 #include <linux/percpu.h>
 #include <linux/topology.h>
 
+#include <linux/artis.h>
+
 struct exec_domain;
 
 /*
@@ -685,6 +687,11 @@ struct task_struct {
   	struct mempolicy *mempolicy;
 	short il_next;
 #endif
+#ifdef CONFIG_ARTIS
+	artis_task_status_t artis_status;
+	unsigned long nr_rt;
+	int prev_cpu_load_rt[NR_CPUS];
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/init/main.c 2.6.11-artis-cvs/init/main.c
--- 2.6.11-pfm/init/main.c	2005-03-02 08:37:49.000000000 +0100
+++ 2.6.11-artis-cvs/init/main.c	2005-03-25 19:47:47.000000000 +0100
@@ -46,6 +46,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/artis.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -106,6 +107,10 @@ extern void tc_init(void);
 enum system_states system_state;
 EXPORT_SYMBOL(system_state);
 
+#ifdef CONFIG_ARTIS
+extern void artis_init(void);
+#endif
+
 /*
  * Boot command-line arguments
  */
@@ -510,6 +515,11 @@ asmlinkage void __init start_kernel(void
 
 	acpi_early_init(); /* before LAPIC and SMP init */
 
+#ifdef CONFIG_ARTIS
+	artis_init();
+#endif
+
+
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/kernel/fork.c 2.6.11-artis-cvs/kernel/fork.c
--- 2.6.11-pfm/kernel/fork.c	2005-03-02 08:37:48.000000000 +0100
+++ 2.6.11-artis-cvs/kernel/fork.c	2005-03-25 19:47:47.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/artis.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -78,10 +79,16 @@ int nr_processes(void)
 # define free_task_struct(tsk)	kmem_cache_free(task_struct_cachep, (tsk))
 static kmem_cache_t *task_struct_cachep;
 #endif
+#ifdef CONFIG_ARTIS
+kmem_cache_t *artis_fifo_node_cachep = NULL;
+#endif
 
 void free_task(struct task_struct *tsk)
 {
 	free_thread_info(tsk->thread_info);
+#ifdef CONFIG_ARTIS
+	free_artis_fifo_node(tsk->artis_status.fifo_node);
+#endif
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -113,6 +120,14 @@ void __init fork_init(unsigned long memp
 		kmem_cache_create("task_struct", sizeof(struct task_struct),
 			ARCH_MIN_TASKALIGN, SLAB_PANIC, NULL, NULL);
 #endif
+#ifdef CONFIG_ARTIS
+	artis_fifo_node_cachep =
+	  kmem_cache_create("artis_fifo_node",
+			    sizeof(artis_fifo_node_t),0,
+			    SLAB_MUST_HWCACHE_ALIGN, NULL, NULL);
+	if (!artis_fifo_node_cachep)
+	  panic("fork_init(): cannot create artis_fifo_node_t SLAB cache");
+#endif
 
 	/*
 	 * The default maximum number of threads is set to a safe
@@ -135,6 +150,9 @@ static struct task_struct *dup_task_stru
 {
 	struct task_struct *tsk;
 	struct thread_info *ti;
+#ifdef CONFIG_ARTIS
+	artis_fifo_node_t *an, def_an=ARTIS_FIFO_NODE_INIT;
+#endif
 
 	prepare_to_copy(orig);
 
@@ -148,11 +166,23 @@ static struct task_struct *dup_task_stru
 		return NULL;
 	}
 
-	*ti = *orig->thread_info;
 	*tsk = *orig;
+#ifdef CONFIG_ARTIS
+	an = alloc_artis_fifo_node(tsk);
+	if (!an) {
+		free_task_struct(tsk);
+		free_thread_info(ti);
+		return NULL;
+	}
+	
+	*an = def_an;
+	an->task = tsk;
+	tsk->artis_status.fifo_node = an;
+#endif
+	*ti = *orig->thread_info;
 	tsk->thread_info = ti;
 	ti->task = tsk;
-
+	
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	return tsk;
diff -urpN -X /export/src/patches/dontdiff -X /export/src/patches/dontdiff2 2.6.11-pfm/kernel/sched.c 2.6.11-artis-cvs/kernel/sched.c
--- 2.6.11-pfm/kernel/sched.c	2005-03-02 08:38:19.000000000 +0100
+++ 2.6.11-artis-cvs/kernel/sched.c	2005-04-24 01:09:22.000000000 +0200
@@ -46,9 +46,25 @@
 #include <linux/syscalls.h>
 #include <linux/times.h>
 #include <asm/tlb.h>
+#include <linux/artis.h>
 
 #include <asm/unistd.h>
 
+#ifdef CONFIG_ARTIS
+#include <linux/proc_fs.h>
+#include <linux/ctype.h>
+#if defined(__ia64__)
+#define artis_get_time(x) ((x)=ia64_get_itc())
+#elif defined(__i386__)
+#define artis_get_time(x) rdtscl(x)
+#else
+#define artis_get_time(x) ((x)=jiffies)
+#endif
+#define KERN_ARTIS_LEVEL ""
+#define ARTIS_PRINTK noprintk
+int noprintk(char *s, ...) { return 0; }
+#endif
+
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
@@ -234,6 +250,11 @@ struct runqueue {
 	task_t *migration_thread;
 	struct list_head migration_queue;
 #endif
+#ifdef CONFIG_ARTIS
+	unsigned long nr_rt;
+	int prev_cpu_load_rt[NR_CPUS];
+#endif
+
 
 #ifdef CONFIG_SCHEDSTATS
 	/* latency stats */
@@ -288,6 +309,12 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
+/* ARTiS migration */
+#ifdef CONFIG_ARTIS
+DEFINE_PER_CPU(artis_per_cpu_info_t, artis_percpu);
+EXPORT_PER_CPU_SYMBOL(artis_percpu);
+#endif
+
 /*
  * Default context-switch locking:
  */
@@ -296,6 +323,12 @@ static DEFINE_PER_CPU(struct runqueue, r
 # define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
+#ifdef CONFIG_ARTIS
+#ifndef artis_complete_arch
+#define artis_complete_arch(rq, task)  do { } while (0)
+#define artis_finish_complete_arch(rq, task)  do { } while (0)
+#endif
+#endif /* CONFIG_ARTIS */
 
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
@@ -628,6 +661,22 @@ static int effective_prio(task_t *p)
 	return prio;
 }
 
+#ifdef CONFIG_ARTIS
+static inline void increase_nr_rt(task_t *p, runqueue_t *rq)
+{
+	if (unlikely(rt_task(p)))
+		rq->nr_rt++;
+}
+static inline void decrease_nr_rt(task_t *p, runqueue_t *rq)
+{
+	if (unlikely(rt_task(p)))
+		rq->nr_rt--;
+}
+#else
+static inline void increase_nr_rt(task_t *p, runqueue_t *rq){}
+static inline void decrease_nr_rt(task_t *p, runqueue_t *rq){}
+#endif /* CONFIG_ARTIS */
+
 /*
  * __activate_task - move a task to the runqueue.
  */
@@ -635,6 +684,7 @@ static inline void __activate_task(task_
 {
 	enqueue_task(p, rq->active);
 	rq->nr_running++;
+	increase_nr_rt(p, rq);
 }
 
 /*
@@ -644,6 +694,7 @@ static inline void __activate_idle_task(
 {
 	enqueue_task_head(p, rq->active);
 	rq->nr_running++;
+	increase_nr_rt(p, rq); //XXX probably not needed as the idle task is never RT
 }
 
 static void recalc_task_prio(task_t *p, unsigned long long now)
@@ -761,7 +812,11 @@ static void activate_task(task_t *p, run
  */
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
+	ARTIS_BUG(artis_flag(p) & ARTIS_STATUS_FETCH, p, rq);
 	rq->nr_running--;
+	decrease_nr_rt(p, rq);
+	if (p->state == TASK_UNINTERRUPTIBLE)
+		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
 	p->array = NULL;
 }
@@ -917,13 +972,106 @@ static inline unsigned long source_load(
 	return min(rq->cpu_load, load_now);
 }
 
+#ifdef CONFIG_ARTIS
+
+/* periods are expressed in nsec (like sched_clock()) */
+#define FSHIFT_P	11		/* nr of bits of precision */
+#define FIXED_P_1	(1<<FSHIFT_P)	/* 1.0 as fixed-point */
+#define EXP_PERIOD	2028		/* 1/exp(1attempt/100attempt) as fixed-point */
+
+#define CALC_PERIOD(period,n)			\
+	*period *= EXP_PERIOD;			\
+	*period += (n)*(FIXED_P_1-EXP_PERIOD);	\
+	*period >>= FSHIFT_P;
+
+/* period of time considered too short to worth migration to RT before next migration attempt */
+#define PERIOD_BEFORE_NMA	(2 * NSEC_PER_SEC/HZ)	/* two scheduling ticks - empirical, could be a bit more */
+/*
+ * Period of time after next migration attempt long enough signifying the forecast was wrong.
+ * It's expressed as a multiplier to the current period.
+ */
+#define MULTIPLY_AFTER_NMA	(2)		/* that should be enough */
+
+/* 
+ * update the statistics about the migration attempts by saving the 
+ * new timestamp of the attempt and re-computing the average period.
+ * Warning: this function must be lock-free
+ */
+void artis_migration_stat(artis_task_status_t *status)
+{
+	unsigned long long old = status->last_attempt;
+	unsigned long long current_period;
+
+	status->last_attempt = sched_clock();
+	// XXX necessary? should not it be just set in init?
+	if (unlikely(old == 0)) /* on the first migration we just initialise the value*/
+		return;
+
+	current_period = (status->last_attempt - old) * FIXED_P_1;
+	
+	CALC_PERIOD(&status->attempt_period, current_period);
+}
+
+#define FSHIFT_RT	15		/* nr of bits of precision */
+#define FIXED_RT_1	(1<<FSHIFT_RT)	/* 1.0 as fixed-point */
+#define EXP_RT		32703		/* 1/exp(1tick/500ticks) as fixed-point */
+#define MAX_RT		FIXED_RT_1 - (FIXED_RT_1/(FIXED_RT_1 - EXP_RT)) /* the maximum possible */
+
+#define CALC_RT(load,n)				\
+	*load *= EXP_RT;			\
+	*load += (n)*(FIXED_RT_1-EXP_RT);	\
+	*load >>= FSHIFT_RT;
+/*
+ * update the statistics about the RT task CPU consumption and the time 
+ * they donot consume. We always insert 1 or 0 in the mean so it should
+ * always be between 0 and 1.
+ */
+void artis_rt_stat(task_t *p, struct cpu_usage_stat *cpustat)
+{
+	int rt_ticks = rt_task(p) ? FIXED_RT_1 : 0;
+
+	CALC_RT(&cpustat->rt, rt_ticks);
+}
+
+/*
+ * It is called RT ratio but actually it is the inverse of the cpu time NOT consumed
+ * by RT tasks.
+ * Returns 1, the minimum, when no RT process was ran.
+ * The maximum value of the rt stat is MAX_RT, to avoid division by 0
+ * when only RT tasks are running it returns MAX_RT+1.
+ */ 
+unsigned int get_rt_ratio(int cpu)
+{
+	unsigned int nrt;
+	struct cpu_usage_stat *cpustat = &(kstat_cpu(cpu)).cpustat;
+
+	if (!artis_info.active)
+		return 1;
+	
+	nrt = (MAX_RT - cpustat->rt) ?: 1;
+	return (unsigned int)(nrt + cpustat->rt)/nrt;
+}
+
+/* return the number of active RT tasks on a runqueue */
+static inline unsigned int get_nr_rt(runqueue_t *rq)
+{
+	return (artis_info.active) ? rq->nr_rt : 0;
+}
+#else /* CONFIG_ARTIS */
+#define get_rt_ratio(cpu) 1
+#define get_nr_rt(cpu) 0
+#define artis_rt_stat(p, cpustat) 
+#define artis_migration_stat(status) 
+#endif /* CONFIG_ARTIS */
+
 /*
  * Return a high guess at the load of a migration-target cpu
  */
 static inline unsigned long target_load(int cpu)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long load_now = rq->nr_running * SCHED_LOAD_SCALE;
+	unsigned long load_now = (rq->nr_running - get_nr_rt(rq))
+	       				* get_rt_ratio(cpu) * SCHED_LOAD_SCALE;
 
 	return max(rq->cpu_load, load_now);
 }
@@ -938,6 +1086,11 @@ static inline unsigned long target_load(
  *
  * Returns the CPU we should wake onto.
  */
+
+/* XXX on ARTiS, it's probably a bad idea to wake up a task on a RT CPU
+ * because it is very likely to take a lock in order to wake up the task,
+ * a migration to an NRT CPU would followed.
+ */
 #if defined(ARCH_HAS_SCHED_WAKE_IDLE)
 static int wake_idle(int cpu, task_t *p)
 {
@@ -1166,6 +1319,10 @@ void fastcall sched_fork(task_t *p)
 	 */
 	p->thread_info->preempt_count = 1;
 #endif
+#ifdef CONFIG_ARTIS
+	/* Reset the migration counter for the newly created process */
+	p->artis_status.nb_migration = 0;
+#endif
 	/*
 	 * Share the timeslice between parent and child, thus the
 	 * total amount of pending timeslices in the system doesn't change,
@@ -1241,6 +1398,7 @@ void fastcall wake_up_new_task(task_t * 
 				p->array = current->array;
 				p->array->nr_active++;
 				rq->nr_running++;
+				increase_nr_rt(p, rq);
 			}
 			set_need_resched();
 		} else
@@ -1344,6 +1502,14 @@ static void finish_task_switch(task_t *p
 	 *		Manfred Spraul <manfred@colorfullife.com>
 	 */
 	prev_task_flags = prev->flags;
+#ifdef CONFIG_ARTIS
+	/* 
+	 * We complete the migration here because the next task can re-run from
+	 * differents places : schedule(), schedule_tail()... 
+	 */
+	if (artis_test_migrating(prev))
+		artis_complete_migration(prev);
+#endif
 	finish_arch_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
@@ -1358,10 +1524,13 @@ static void finish_task_switch(task_t *p
 asmlinkage void schedule_tail(task_t *prev)
 	__releases(rq->lock)
 {
+	/* ARTiS: this is part of the scheduler, migration is forbiden */
+	artis_migration_disable();
 	finish_task_switch(prev);
 
 	if (current->set_child_tid)
 		put_user(current->pid, current->set_child_tid);
+	artis_migration_enable();
 }
 
 /*
@@ -1621,6 +1790,46 @@ out:
 	put_cpu();
 }
 
+#ifdef CONFIG_ARTIS
+
+static void artis_valois_push(artis_migration_queue_t *queue, task_t *task);
+/*
+ * push_task - move a task from the local runqueue to a remote runqueue.
+ * Only local runqueue needs lock, useful for ARTiS
+ */
+static inline
+void push_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p,
+	       int dest_cpu)
+{
+	artis_per_cpu_info_t *artis_cpu = cpu_artis(dest_cpu);
+	artis_migration_queue_t *queue = artis_cpu->queues[smp_processor_id()][dest_cpu];
+
+	/*
+	 * compared to pull_task(), we deactivate the task the full way because 
+	 * valois_pull() will reactivate it the full way.
+	 */
+	deactivate_task(p, src_rq);
+	
+	//XXX we should have a valois_push() clean and available for every part of the kernel
+	get_task_struct(p);
+	/*
+	 * we do it the opposite way than the ARTiS migration:
+	 * local flag stays NULL.
+	 * artis_fetch_from_migration() will notice it and avoid changing the flag
+	 * and giving the struct back. That's necessary because we can't keep the 
+	 * local variable available.
+	 */
+	ARTIS_BUG(artis_local(p), artis_local(p));
+	set_task_cpu(p, dest_cpu);
+	artis_flag(p) = ARTIS_STATUS_LB;
+
+	atomic_inc(&(cpu_artis(dest_cpu)->fetch_size));
+	atomic_inc(&(artis_info.size));
+	artis_valois_push(queue, p);
+}
+
+#endif
+
 /*
  * pull_task - move a task from a remote runqueue to the local runqueue.
  * Both runqueues must be locked.
@@ -1631,8 +1840,10 @@ void pull_task(runqueue_t *src_rq, prio_
 {
 	dequeue_task(p, src_array);
 	src_rq->nr_running--;
+	decrease_nr_rt(p, src_rq);
 	set_task_cpu(p, this_cpu);
 	this_rq->nr_running++;
+	increase_nr_rt(p, this_rq);
 	enqueue_task(p, this_array);
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
@@ -1674,9 +1885,118 @@ int can_migrate_task(task_t *p, runqueue
 
 	if (task_hot(p, rq->timestamp_last_tick, sd))
 			return 0;
+#ifdef CONFIG_ARTIS
+	/* 4) ARTIS-migrating */
+	if (artis_flag(p))
+		return 0;
+	/* 5) likely to migrate soon if going to a RT CPU */
+	/* this_cpu is actually the _destination_ CPU */
+	if ((artis_info.active > 0) && artis_is_cpu_rt(this_cpu)) {
+		artis_task_status_t *status = &p->artis_status;
+		unsigned long long next_attempt = status->last_attempt + status->attempt_period;
+		unsigned long long now = sched_clock();
+
+		if ((now > (next_attempt - PERIOD_BEFORE_NMA)) && 
+		    (now > (next_attempt + status->attempt_period * MULTIPLY_AFTER_NMA)))
+			return 0;
+	}
+#endif
 	return 1;
 }
 
+
+#ifdef CONFIG_ARTIS
+
+/*
+ * move_tasks_push pushes up to max_nr_move task to the destination CPU.
+ * used for ARTiS to avoid lock on destination CPU.
+ *
+ * called with only the local runqueue locked
+ */
+static int move_tasks_push(runqueue_t *this_rq, int this_cpu, int idlest_cpu,
+		      unsigned long max_nr_move, struct sched_domain *sd,
+		      int only_rt)
+{
+	prio_array_t *array;
+	struct list_head *head, *curr;
+	int idx, pushed = 0, did_modulo, start;
+	task_t *tmp;
+
+	if (max_nr_move <= 0 || cpu_rq(this_cpu)->nr_running <= 1)
+		goto out;
+
+	/*
+	 * We first consider expired tasks. Those will likely not be
+	 * executed in the near future, and they are most likely to
+	 * be cache-cold, thus switching CPUs has the least effect
+	 * on them.
+	 */
+	if (this_rq->expired->nr_active)
+		array = this_rq->expired;
+	else
+		array = this_rq->active;
+
+	/* when from RT -> NRT, we first move the Linux task and keep the RT tasks */
+	if (artis_is_cpu_rt(this_cpu) && artis_is_cpu_nrt(idlest_cpu))
+		start = MAX_RT_PRIO;
+	else
+		start = MAX_PRIO;
+
+new_array:
+	did_modulo = 0;
+	idx = start;
+skip_bitmap:
+	/* special trick to be able to start anywhere in the mask */
+	if (!did_modulo && (idx >= MAX_PRIO)) {
+		idx = 0;
+		did_modulo = 1;
+	}
+
+	if (!idx)
+		idx = sched_find_first_bit(array->bitmap);
+	else
+		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
+	if ((idx >= MAX_PRIO) || (only_rt && (idx >= MAX_RT_PRIO))) {
+		if (array == this_rq->expired && this_rq->active->nr_active) {
+			array = this_rq->active;
+			goto new_array;
+		}
+		goto out;
+	}
+
+	head = array->queue + idx;
+	curr = head->prev;
+skip_queue:
+	tmp = list_entry(curr, task_t, run_list);
+
+	curr = curr->prev;
+
+	if (!can_migrate_task(tmp, this_rq, idlest_cpu, sd, 0)) {
+		if (curr != head)
+			goto skip_queue;
+		idx++;
+		goto skip_bitmap;
+	}
+
+	push_task(this_rq, array, tmp, idlest_cpu);
+	pushed++;
+
+	/* We only want to steal up to the prescribed number of tasks. */
+	if (pushed < max_nr_move) {
+		if (curr != head)
+			goto skip_queue;
+		idx++;
+		goto skip_bitmap;
+	}
+out:
+	if (pushed) {
+		set_tsk_need_resched(cpu_curr(idlest_cpu));
+		smp_send_reschedule(idlest_cpu);
+	}
+	return pushed;
+}
+#endif
+
 /*
  * move_tasks tries to move up to max_nr_move tasks from busiest to this_rq,
  * as part of a balancing operation within "domain". Returns the number of
@@ -1763,6 +2083,152 @@ out:
 	return pulled;
 }
 
+#ifdef CONFIG_ARTIS
+/*
+ * find_idlest_group does the opposite as find_busiest_group,
+ * used only for ARTiS, for active policy
+ * idle is useless here, if we are idle we don't have anything to move
+ * actually it should not even happen that we are called when idle
+ */
+static struct sched_group *
+find_idlest_group(struct sched_domain *sd, int this_cpu,
+		   unsigned long *imbalance, int only_rt)
+{
+	struct sched_group *idlest = NULL, *this = NULL, *group = sd->groups;
+	unsigned long min_load, avg_load, total_load, this_load, total_pwr;
+
+	min_load = ULONG_MAX;
+	this_load = total_load = total_pwr = 0;
+
+	do {
+		cpumask_t tmp;
+		unsigned long load;
+		int local_group;
+		int i, nr_cpus = 0;
+
+		local_group = cpu_isset(this_cpu, group->cpumask);
+
+		/* Tally up the load of all CPUs in the group */
+		avg_load = 0;
+		cpus_and(tmp, group->cpumask, cpu_online_map);
+		if (only_rt)
+			cpus_and(tmp, tmp, artis_info.cpus_nrt);
+
+		if (unlikely(cpus_empty(tmp)))
+			goto nextgroup;
+
+		for_each_cpu_mask(i, tmp) {
+			/* Bias balancing toward cpus of our domain */
+			if (local_group)
+				load = source_load(i);
+			else
+				load = target_load(i);
+
+			nr_cpus++;
+			avg_load += load;
+		}
+
+		if (!nr_cpus)
+			goto nextgroup;
+
+		total_load += avg_load;
+		total_pwr += group->cpu_power;
+
+		/* Adjust by relative CPU power of the group */
+		avg_load = (avg_load * SCHED_LOAD_SCALE) / group->cpu_power;
+
+		if (local_group) {
+			this_load = avg_load;
+			this = group;
+			goto nextgroup;
+		} else if (avg_load < min_load) {
+			min_load = avg_load;
+			idlest = group;
+		}
+nextgroup:
+		group = group->next;
+	} while (group != sd->groups);
+
+	if (!idlest || this_load <= min_load)
+		goto out_balanced;
+	
+	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
+
+	if (this_load <= avg_load ||
+			100*this_load <= sd->imbalance_pct*min_load)
+		goto out_balanced;
+
+	/*
+	 * We're trying to get all the cpus to the average_load, so we don't
+	 * want to push ourselves above the average load, nor do we wish to
+	 * reduce the max loaded cpu below the average load, as either of these
+	 * actions would just result in more rebalancing later, and ping-pong
+	 * tasks around. Thus we look for the minimum possible imbalance.
+	 * Negative imbalances (*we* are more loaded than anyone else) will
+	 * be counted as no imbalance for these purposes -- we can't fix that
+	 * by pulling tasks to us.  Be careful of negative numbers as they'll
+	 * appear as very large values with unsigned longs.
+	 */
+	*imbalance = min(avg_load - min_load, this_load - avg_load);
+
+	/* How much load to actually move to equalise the imbalance */
+	*imbalance = (*imbalance * min(idlest->cpu_power, this->cpu_power))
+				/ SCHED_LOAD_SCALE;
+
+	if (*imbalance < SCHED_LOAD_SCALE - 1) {
+		unsigned long pwr_now = 0, pwr_move = 0;
+		unsigned long tmp;
+
+		if (this_load - min_load >= SCHED_LOAD_SCALE*2) {
+			*imbalance = 1;
+			return idlest;
+		}
+
+		/*
+		 * OK, we don't have enough imbalance to justify moving tasks,
+		 * however we may be able to increase total CPU power used by
+		 * moving them.
+		 */
+
+		pwr_now += idlest->cpu_power*min(SCHED_LOAD_SCALE, min_load);
+		pwr_now += this->cpu_power*min(SCHED_LOAD_SCALE, this_load);
+		pwr_now /= SCHED_LOAD_SCALE;
+
+		/* Amount of load we'd subtract */
+		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/this->cpu_power;
+		if (this_load > tmp)
+			pwr_move += this->cpu_power*min(SCHED_LOAD_SCALE,
+							tmp - this_load);
+
+		/* Amount of load we'd add */
+		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/idlest->cpu_power;
+		if (this_load < tmp)
+			tmp = this_load;
+		pwr_move += idlest->cpu_power*min(SCHED_LOAD_SCALE, min_load + tmp);
+		pwr_move /= SCHED_LOAD_SCALE;
+
+		/* Move if we gain another 8th of a CPU worth of throughput */
+		if (pwr_move < pwr_now + SCHED_LOAD_SCALE / 8)
+			goto out_balanced;
+
+		*imbalance = 1;
+		return idlest;
+	}
+
+	/* Get rid of the scaling factor, rounding down as we divide */
+	*imbalance = (*imbalance + 1) / SCHED_LOAD_SCALE;
+
+	return idlest;
+
+out_balanced:
+	// maybe we should check if the idlest CPU is idle, in this case we
+	// could move one task.
+
+	*imbalance = 0;
+	return NULL;
+}
+#endif
+
 /*
  * find_busiest_group finds and returns the busiest CPU group within the
  * domain. It calculates and returns the number of tasks which should be
@@ -1781,13 +2247,26 @@ find_busiest_group(struct sched_domain *
 		unsigned long load;
 		int local_group;
 		int i, nr_cpus = 0;
+		cpumask_t tmp = group->cpumask;
 
-		local_group = cpu_isset(this_cpu, group->cpumask);
+		local_group = cpu_isset(this_cpu, tmp);
+
+#ifdef CONFIG_ARTIS
+		/* we forbid balancing from the RT-CPUS because first it 
+		 * implies the lock of the RT runqueue and second the 
+		 * ARTiS migration does a lot of "balance" from RT-CPUS
+		 * 
+		 * However it is not done for the local group since it is
+		 * used to calculated the local reference and it must be done.
+		 */ 
+		if ((artis_info.active > 0) && !local_group)
+			cpus_and(tmp, tmp, artis_info.cpus_nrt);
+#endif
 
 		/* Tally up the load of all CPUs in the group */
 		avg_load = 0;
 
-		for_each_cpu_mask(i, group->cpumask) {
+		for_each_cpu_mask(i, tmp) {
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
 				load = target_load(i);
@@ -1901,6 +2380,37 @@ out_balanced:
 	return NULL;
 }
 
+
+#ifdef CONFIG_ARTIS
+/*
+ * find_idlest_queue 
+ * does the opposite of find_busiest_queue, used for ARTiS
+ * instead of returning the runqueue we return the cpu (-1 if nothing)
+ */
+static int find_idlest_queue(struct sched_group *group, int only_rt)
+{
+	cpumask_t tmp;
+	unsigned long load, min_load = ULONG_MAX;
+	int i, idlest = -1;
+
+	cpus_and(tmp, group->cpumask, cpu_online_map);
+	if (only_rt)
+		cpus_and(tmp, tmp, artis_info.cpus_nrt);
+
+	for_each_cpu_mask(i, tmp) {
+		load = target_load(i);
+
+		if (load < min_load) {
+			min_load = load;
+			idlest = i;
+		}
+	}
+
+	return idlest;
+}
+
+#endif
+
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in group.
  */
@@ -1909,8 +2419,13 @@ static runqueue_t *find_busiest_queue(st
 	unsigned long load, max_load = 0;
 	runqueue_t *busiest = NULL;
 	int i;
+	cpumask_t tmp = group->cpumask;
 
-	for_each_cpu_mask(i, group->cpumask) {
+#ifdef CONFIG_ARTIS
+	if (artis_info.active > 0)
+		cpus_and(tmp, tmp, artis_info.cpus_nrt);
+#endif
+	for_each_cpu_mask(i, tmp) {
 		load = source_load(i);
 
 		if (load > max_load) {
@@ -1922,6 +2437,81 @@ static runqueue_t *find_busiest_queue(st
 	return busiest;
 }
 
+#ifdef CONFIG_ARTIS
+
+/*
+ * Same as the load_balance function but with "active" policy.
+ * This is good for ARTiS because it doesn't need to lock the destination
+ * CPU. However it also means we never do "passive" -pull- policy.
+ *
+ * Called with this_rq unlocked.
+ */
+
+static int load_balance_push(int this_cpu, runqueue_t *this_rq,
+			struct sched_domain *sd, int only_rt)
+{
+	struct sched_group *group;
+	unsigned long imbalance;
+	int nr_moved, idlest;
+	
+	spin_lock(&this_rq->lock);
+
+	group = find_idlest_group(sd, this_cpu, &imbalance, only_rt);
+	if (!group)
+		goto out_balanced;
+	
+	idlest = find_idlest_queue(group, only_rt);
+	if (idlest == -1)
+		goto out_balanced;
+	
+	/*
+	 * This should be "impossible", but since load
+	 * balancing is inherently racy and statistical,
+	 * it could happen in theory.
+	 */
+	if (unlikely(idlest == this_cpu)) {
+		WARN_ON(1);
+		goto out_balanced;
+	}
+
+	nr_moved = 0;
+	if (cpu_rq(this_cpu)->nr_running > 1) {
+		/*
+		 * This should be only one function wich move task and manages
+		 * the flags and all other small things, in common with 
+		 * artis_complete_migration(). But here the point is that we 
+		 * don't want to send the resched flag too often.
+		 */
+		nr_moved = move_tasks_push(this_rq, this_cpu, idlest,
+						imbalance, sd, only_rt);
+		
+	}
+	spin_unlock(&this_rq->lock);
+
+	/*
+	 * In the normal load_balance() we do would force "active" LB is
+	 * the passive one hasn't work. Here we already do "active" one
+	 * so we don't re-force it, however we don't force "passive" one
+	 * neither because there is no easy to do that without lock...
+	 */
+	sd->nr_balance_failed = 0;
+
+	/* We were unbalanced, so reset the balancing interval */
+	sd->balance_interval = sd->min_interval;
+
+	return nr_moved;
+
+out_balanced:
+	spin_unlock(&this_rq->lock);
+
+	/* tune up the balancing interval */
+	if (sd->balance_interval < sd->max_interval)
+		sd->balance_interval *= 2;
+
+	return 0;
+}
+
+#endif
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -2042,6 +2632,16 @@ static int load_balance_newidle(int this
 	unsigned long imbalance;
 	int nr_moved = 0;
 
+#ifdef CONFIG_ARTIS
+		/*
+		 *  don't balance when idle if the CPU can only do push
+		 *  == if the CPU is a RT CPU.
+		 */
+		if ((artis_info.active > 0) && (artis_is_cpu_rt(this_cpu)))
+			goto out;
+#endif
+
+
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
 	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
 	if (!group) {
@@ -2172,7 +2772,8 @@ static void rebalance_tick(int this_cpu,
 
 	/* Update our load */
 	old_load = this_rq->cpu_load;
-	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;
+	this_load = (this_rq->nr_running - get_nr_rt(this_rq))
+					* get_rt_ratio(this_cpu) * SCHED_LOAD_SCALE;
 	/*
 	 * Round up the averaging division if load is increasing. This
 	 * prevents us from getting stuck on 9 if the load is 10, for
@@ -2189,6 +2790,32 @@ static void rebalance_tick(int this_cpu,
 			continue;
 
 		interval = sd->balance_interval;
+
+#ifdef CONFIG_ARTIS
+		unsigned long interval_rt = ULONG_MAX;
+
+		if (artis_info.active > 0) {
+			/*
+			 *  don't balance when idle if the CPU can only do push
+			 *  (== if the CPU is a RT CPU).
+			 */
+			if ((idle == SCHED_IDLE) && (artis_is_cpu_rt(this_cpu)))
+				return;
+			/*
+			 * On NRT CPUs we have two load-balancing:
+			 * - one very often that only sends back RT tasks to RT CPUs
+			 * - one usual
+			 */
+			if (artis_is_cpu_nrt(this_cpu)) {
+				/* scale ms to jiffies */
+				interval_rt = msecs_to_jiffies(interval / 4);
+				if (unlikely(!interval_rt))
+					interval_rt = 1;
+			}
+		}
+		
+#endif
+
 		if (idle != SCHED_IDLE)
 			interval *= sd->busy_factor;
 
@@ -2198,12 +2825,27 @@ static void rebalance_tick(int this_cpu,
 			interval = 1;
 
 		if (j - sd->last_balance >= interval) {
+#ifdef CONFIG_ARTIS
+			if (artis_info.active > 0)
+				load_balance_push(this_cpu, this_rq, sd, 0);	
+			else
+#endif
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/* We've pulled tasks over so no longer idle */
 				idle = NOT_IDLE;
 			}
 			sd->last_balance += interval;
 		}
+#ifdef CONFIG_ARTIS
+		/* 
+		 * This might not be called exatly as often as expected because some
+		 * ticks might be missed but it's not a problem, in general
+		 * it works and that's enough. At least it keeps the code simple.
+		 */
+		else if ((interval_rt != ULONG_MAX) &&
+			 (((j - sd->last_balance) % interval_rt) == 0))
+			load_balance_push(this_cpu, this_rq, sd, 1);
+#endif
 	}
 }
 #else
@@ -2344,6 +2986,7 @@ void account_user_time(struct task_struc
 		cpustat->nice = cputime64_add(cpustat->nice, tmp);
 	else
 		cpustat->user = cputime64_add(cpustat->user, tmp);
+	artis_rt_stat(p, cpustat);
 }
 
 /*
@@ -2379,6 +3022,7 @@ void account_system_time(struct task_str
 		cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
 	else
 		cpustat->idle = cputime64_add(cpustat->idle, tmp);
+	artis_rt_stat(p, cpustat);
 }
 
 /*
@@ -2677,16 +3321,42 @@ asmlinkage void __sched schedule(void)
 	 */
 	if (likely(!current->exit_state)) {
 		if (unlikely(in_atomic())) {
+#ifdef CONFIG_ARTIS
+			printk(KERN_ERR "bad: scheduling while atomic! (pid=%d/%d, preempt=%d, kernel_lock=%d)\n",
+					current->pid, current->thread_info->cpu, 
+					preempt_count(), current->lock_depth);
+#else
 			printk(KERN_ERR "scheduling while atomic: "
 				"%s/0x%08x/%d\n",
 				current->comm, preempt_count(), current->pid);
+#endif
 			dump_stack();
 		}
 	}
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
 need_resched:
+	artis_migration_disable();
 	preempt_disable();
+
+#ifdef CONFIG_ARTIS
+	if ((artis_info.active > 0) &&
+	       (smp_processor_id() == first_cpu(artis_info.cpus_nrt))) {
+		int i;
+		for_each_cpu_mask(i, artis_info.cpus_rt)
+			artis_check_dummyfifo(i);
+	}
+#endif
+
+
+#ifdef CONFIG_ARTIS_DEBUG
+	if (current->pid>200 && (artis_migration_count()>2 || (artis_migration_count()>1 && artis_this_flag() == ARTIS_STATUS_REQUEST1))) {
+		ARTIS_PRINTK(KERN_ARTIS_LEVEL "ARTIS debug: In schedule (p=%d/%d) migration=%d\n",
+				current->pid, smp_processor_id(), 
+				artis_migration_count());
+	}
+#endif
+
 	prev = current;
 	release_kernel_lock(prev);
 need_resched_nonpreemptible:
@@ -2716,14 +3386,47 @@ need_resched_nonpreemptible:
 
 	spin_lock_irq(&rq->lock);
 
+#ifdef CONFIG_ARTIS
+	if (atomic_read(&(this_artis()->fetch_size))) {
+		int i;
+		for_each_cpu(i)
+			artis_fetch_from_migration(i);
+	}
+#endif /* CONFIG_ARTIS */
+
 	if (unlikely(prev->flags & PF_DEAD))
 		prev->state = EXIT_DEAD;
 
 	switch_count = &prev->nivcsw;
-	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
+#ifdef CONFIG_ARTIS
+	/* 
+	 * if the flag ARTIS is set, we know where we come from
+	 * and where we go (may be !!!) so we force deactivation of
+	 * the task
+	 */
+	if (unlikely(artis_flag(prev) & (ARTIS_STATUS_REQUEST1|ARTIS_STATUS_DUMMY1|ARTIS_STATUS_DUMMY2)) &&
+			!(preempt_count() & PREEMPT_ACTIVE)) {
+		ARTIS_BUG(!prev->array, prev);
+		artis_flag(prev) = ARTIS_STATUS_REQUEST2;
+		deactivate_task(prev, rq);
+	} else
+#endif
+	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE) 
+#ifdef CONFIG_ARTIS
+	/*
+	 * We don't want to be deactivated before ending
+	 * the request function.
+	 *
+	 * This can happen if the migrated task has been 
+	 * choosen but the need_resched flag implies the 
+	 * restarting of schedule (cf. label need_resched:)
+	 */
+		&& !(artis_flag(prev) & ARTIS_STATUS_FETCH)
+#endif
+		) {
 		switch_count = &prev->nvcsw;
 		if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
-				unlikely(signal_pending(prev))))
+			     unlikely(signal_pending(prev))))
 			prev->state = TASK_RUNNING;
 		else {
 			if (prev->state == TASK_UNINTERRUPTIBLE)
@@ -2731,10 +3434,21 @@ need_resched_nonpreemptible:
 			deactivate_task(prev, rq);
 		}
 	}
+	ARTIS_BUG(artis_test_migrating(prev) && prev->array, prev);
 
 	cpu = smp_processor_id();
 	if (unlikely(!rq->nr_running)) {
 go_idle:
+#ifdef CONFIG_ARTIS
+		/* 
+		 * On the migration flag, we skip load_balancing for 2 reasons :
+		 *  - we want to migrate quickly
+		 *  - load_balance() can call double_balance_lock() which can 
+		 *  release the runqueue lock. So a wake-up would have been 
+		 *  able to re-activate the task
+		 */
+		if (likely(!artis_test_migrating(prev)))
+#endif
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
@@ -2779,6 +3493,7 @@ go_idle:
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
+	ARTIS_BUG(artis_test_migrating(prev) && prev==next, prev);
 
 	if (!rt_task(next) && next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
@@ -2798,6 +3513,7 @@ switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));
+	ARTIS_BUG(artis_test_migrating(prev) && prev->array, prev);
 
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0)
@@ -2806,6 +3522,8 @@ switch_tasks:
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
+		ARTIS_BUG(artis_test_migrating(prev) && prev->array, prev);
+
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -2815,14 +3533,19 @@ switch_tasks:
 		prev = context_switch(rq, prev, next);
 		barrier();
 
+		ARTIS_BUG(artis_test_migrating(current), artis_flag(current));
+
 		finish_task_switch(prev);
-	} else
+	} else {
+		ARTIS_BUG(artis_test_migrating(prev), prev);
 		spin_unlock_irq(&rq->lock);
+	}
 
 	prev = current;
 	if (unlikely(reacquire_kernel_lock(prev) < 0))
 		goto need_resched_nonpreemptible;
 	preempt_enable_no_resched();
+	artis_migration_enable();
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
 		goto need_resched;
 }
@@ -3486,6 +4209,620 @@ static int do_sched_setscheduler(pid_t p
 	return retval;
 }
 
+#ifdef CONFIG_ARTIS
+
+void
+artis_bug(int line, char *file, unsigned long time, ...) {
+	artis_migration_disable();
+	artis_get_time(time);
+	printk("ARTIS BUG (%s:%d@%ld) KDB_ENTER (%d/%d)=%x\n",
+		file, line, time, (int)current->pid, (int)smp_processor_id(),
+		(int)artis_this_flag());
+	artis_migration_enable();
+}
+EXPORT_SYMBOL(artis_bug);
+
+/*
+ * Main function of ARTiS: when a task endangers RT properties of the CPU,
+ * this function is called and check the task is allowed. If not then it's
+ * migrated.
+ * When entering, the preemption is already disabled.
+ */
+void artis_try_to_migrate(void) {
+	if (!_artis_ismigrable_nostat())
+		return;
+
+	artis_migration_stat(&current->artis_status);
+
+	if (!_artis_ismigrable_stat())
+		return;
+
+	/* we will come back from this function on an NRT CPU */
+	artis_request_for_migration();
+}
+EXPORT_SYMBOL(artis_try_to_migrate);
+
+void
+function_artis_migration_disable(void) {
+	artis_migration_disable();
+}
+EXPORT_SYMBOL(function_artis_migration_disable);
+
+void
+function_artis_migration_enable(void) {
+	artis_migration_enable();
+}
+EXPORT_SYMBOL(function_artis_migration_enable);
+
+
+/**
+ * artis_valois_push - append a task to a migration queue
+ * @queue the migration queue
+ * @task the task
+ */
+static void
+artis_valois_push(artis_migration_queue_t *queue, task_t *task) {
+	artis_fifo_node_t *node, *otail;
+	node=task->artis_status.fifo_node;
+	ARTIS_BUG(node->task!=task, task, node, node->task);
+	ARTIS_BUG(node->next, task, node, node->next);
+	otail=queue->tail;
+	ARTIS_BUG(!otail, task, queue);
+	atomic_inc(&(queue->size));
+	otail->next=node;
+	queue->tail=node;
+}
+
+
+/**
+ * artis_valois_pull_all - pull all the tasks from a migration queue
+ * @queue the migration queue
+ *
+ * It returns the last task in the migration queue or NULL if the migration queue
+ * is empty.
+ *
+ * The migration queue is supposed to be a FIFO queue but this does not seem
+ * to be that important, so we return a linked list of the tasks in the migration
+ * queue with the last element at the begining.
+ */
+static task_t *
+artis_valois_pull_all(artis_migration_queue_t *queue) {
+	artis_fifo_node_t *node, *dummy;
+	task_t *task;
+	int i;
+	dummy=queue->head;
+	ARTIS_BUG(!dummy, queue);
+	ARTIS_BUG(dummy->task, queue, dummy, dummy->task);
+	if (!dummy->next)
+		return NULL;
+	for(i=1, node=dummy;node->next->next;node=node->next, i++)
+		;
+	task=node->next->task;
+	node->next->task=NULL;
+	dummy->task=task;
+	task->artis_status.fifo_node=dummy;
+	queue->head=node->next;
+	node->next=NULL;
+	atomic_sub(i, &(queue->size));
+	return task;
+}
+
+
+/**
+ * artis_valois_next - next task in the list retrieved from the migration queue
+ * @task current task
+ * @reset_next set next node to NULL ?
+ *
+ * It returns the task in the next node or NULL if there is no next node.
+ */
+static inline task_t *
+artis_valois_next(task_t *task, int reset_next) {
+	artis_fifo_node_t *node;
+	task_t *rtask;
+	node=task->artis_status.fifo_node;
+	ARTIS_BUG(!node, task);
+	if (!node->next)
+		return NULL;
+	rtask=node->next->task;
+	ARTIS_BUG(!rtask, task, node, node->next);
+	if (reset_next)
+		node->next=NULL;
+	return rtask;
+}
+
+#define VALOIS_NEXT(t) artis_valois_next((t),1)
+#define VALOIS_NEXT_NOBREAK(t) artis_valois_next((t),0)
+
+
+/**
+ * artis_request_for_migration - prepares a task for migration
+ *
+ * This function is called when executing preempt_disable().
+ *
+ * We mark ourself with ARTiS flag then call scheduling to be dropped 
+ * from the run-queue. The rest of action takes place in 
+ * finish_task_switch() after the context-switch.
+ */
+void
+artis_request_for_migration(void) {
+	/* Preemption is already disabled */
+	artis_local_task_status_t artis_local_task_status = ARTIS_LOCAL_TASK_STATUS_INIT;
+	struct thread_info *ti;
+	artis_per_cpu_info_t *artis_cpu;
+
+	artis_migration_disable();
+	get_task_struct(current);
+	ARTIS_BUG(artis_this_local(), artis_this_local());
+	artis_this_local() = &artis_local_task_status;
+#ifdef CONFIG_ARTIS_STAT
+	artis_get_time(artis_this_local()->migration_delta[0]);
+#endif
+	ARTIS_BUG(irqs_disabled(), 0);
+	ti = current_thread_info();
+	ARTIS_BUG(ti->preempt_count != 1, ti, ti->preempt_count);
+	ARTIS_BUG(!current->array, current->array);
+	ARTIS_BUG(artis_test_this_migrating() || artis_this_flag(), artis_this_flag());
+	artis_cpu = this_artis();
+#ifdef CONFIG_ARTIS_DEBUG
+	artis_get_time(artis_this_local()->request.time);
+	artis_put_trace(artis_this_local()->request.bt, current, 0);
+#endif
+
+	artis_this_flag() = ARTIS_STATUS_REQUEST1;
+
+	/* Even if there is a wake_up() on this task, force it to stay 
+	 * on this CPU */
+	artis_this_local()->cpus_allowed_bak = current->cpus_allowed;
+	current->cpus_allowed = cpumask_of_cpu(smp_processor_id());
+#ifdef CONFIG_ARTIS_DEBUG
+	/* debug : save the cpu value */
+	artis_this_local()->cpu = smp_processor_id();
+#endif
+#ifdef CONFIG_ARTIS_STAT
+	artis_get_time(artis_this_local()->migration_delta[1]);
+#endif
+	/*
+	 * Now that artis flag is set and affinity has been changed, we 
+	 * can re-enable preemption
+	 */
+	preempt_enable();
+	/*
+	 * loop for the dummy task that have been re-activated unwillingly
+	 */
+	do {
+		schedule();
+		ARTIS_BUG(artis_this_flag() & ~(ARTIS_STATUS_FETCH|ARTIS_STATUS_DUMMY1|ARTIS_STATUS_DUMMY2), artis_this_flag());
+	} while(artis_this_flag() & (ARTIS_STATUS_DUMMY1|ARTIS_STATUS_DUMMY2));
+	ARTIS_BUG(smp_processor_id() == artis_this_local()->cpu, artis_this_local()->cpu);
+	/* restore original mask and ensure that the current cpu is in */
+	cpu_set(smp_processor_id(), artis_this_local()->cpus_allowed_bak);
+	current->cpus_allowed = artis_this_local()->cpus_allowed_bak;
+
+	artis_this_local() = NULL;
+	/* We release flag to enable kmigration but before we disable 
+	 * preemption like it was at the call.
+	 */ 
+	preempt_disable();
+	artis_this_flag() = 0;
+	artis_migration_enable();
+}
+
+EXPORT_SYMBOL(artis_request_for_migration);
+
+/**
+ * artis_complete_migration - push a task to migrate in a migration queue
+ * @task the task
+ *
+ * This function is called from finish_task_switch(). It moves the current
+ * task to a NRT processor.
+ *
+ * Several threads can enter this function.
+ */
+int 
+artis_complete_migration(task_t *task) {
+	/*
+	 * We come from finish_task_switch() so we know that:
+	 * - preemption is disabled
+	 * - irq are disabled
+	 * - artis migration is disabled
+	 * - the runqueue is locked (except on IA64)
+	 */
+	artis_per_cpu_info_t *artis_cpu;
+	artis_migration_queue_t *queue;
+	runqueue_t *rq;
+	int nrt_processor;
+	cpumask_t cpuchoice;
+
+#ifdef CONFIG_ARTIS_STAT
+	artis_get_time(artis_local(task)->migration_delta[2]);
+#endif
+	rq = this_rq();
+	artis_complete_arch(rq, task);
+	/* now we have the runqueue lock */
+	/* and the task must not be in the runqueue */
+	ARTIS_BUG(task->array, task);
+	/* debug: flag ARTIS must be set */
+	ARTIS_BUG(!artis_test_migrating(task) || (artis_flag(task) != ARTIS_STATUS_REQUEST2), task);
+	artis_flag(task) = ARTIS_STATUS_COMPLETE1;
+	artis_cpu = this_artis();
+	/* debug: are we on the same cpu */
+	ARTIS_BUG(smp_processor_id() != artis_local(task)->cpu, task);
+
+#if defined(CONFIG_ARTIS_DEBUG)
+	artis_get_time(current->artis_status.complete.time);
+	artis_put_trace(current->artis_status.complete.bt, current, 0);
+	current->artis_status.complete_to = task;
+	artis_get_time(current->artis_status.complete_to_at);
+	artis_local(task)->complete_by = current;
+	artis_get_time(artis_local(task)->complete_by_at);
+#endif
+	/* 
+	 * Which NRT processor to choose? for the time being
+	 * we choose the first one which respects the affinity
+	 */
+	cpus_and(cpuchoice, artis_local(task)->cpus_allowed_bak, artis_info.cpus_nrt);
+	nrt_processor = any_online_cpu(cpuchoice);
+
+	/*
+	 * The solution of putting the task in a dummy queue is 
+	 * redhibitory for kthread. So we prefer to force migration
+	 * on any NRT CPU and change the affinity of the task.
+	 */
+	if (nrt_processor == NR_CPUS)
+		nrt_processor = first_cpu(artis_info.cpus_nrt);
+
+	queue = artis_cpu->queues[smp_processor_id()][nrt_processor];
+
+#ifdef CONFIG_ARTIS_DEBUG
+	ARTIS_PRINTK(KERN_ARTIS_LEVEL "ARTIS debug: enter artis_complete_migration (p=%d) cpu %d(%d) -> %d with (%p)\n", task->pid, task->thread_info->cpu, smp_processor_id(), nrt_processor, task->array);
+#endif
+
+	/* now we want the re-activation take place on the NRT cpu */
+	task->cpus_allowed = cpumask_of_cpu(nrt_processor);
+	set_task_cpu(task, nrt_processor);
+	artis_flag(task) = (nrt_processor<NR_CPUS ? ARTIS_STATUS_COMPLETE2 : ARTIS_STATUS_DUMMY1);
+
+	atomic_inc(&(cpu_artis(nrt_processor)->fetch_size));
+	atomic_inc(&(artis_info.size));
+	artis_valois_push(queue, task);
+	
+	artis_finish_complete_arch(rq, task);
+	/* 
+	 * Now that the lock has been released, we force a schedule on
+	 * the NRT CPU. It doesn't matter if the current task changes just
+	 * before we set the flag since that means the cpu has been 
+	 * re-scheduled.
+	 */
+	set_tsk_need_resched(cpu_curr(nrt_processor));
+	smp_send_reschedule(nrt_processor);
+
+#ifdef CONFIG_ARTIS_STAT
+	artis_get_time(artis_local(task)->migration_delta[3]);
+#endif
+#ifdef CONFIG_ARTIS_STAT
+	{ unsigned long t, i, delta;
+		artis_get_time(t);
+		if (!(artis_cpu->nb_migration & 0x3ff)) { 
+			for(i=0; i<3; i++) 
+				artis_cpu->migration_delta[i] = 0; 
+		}
+		for(i=0; i<3; i++) { 
+			delta = artis_local(task)->migration_delta[i+1] -
+			       	artis_local(task)->migration_delta[i]; 
+			if (delta > artis_cpu->migration_delta[i]) 
+				artis_cpu->migration_delta[i] = delta;
+		}
+	}
+#endif
+	artis_cpu->nb_migration++;
+
+	return (nrt_processor<NR_CPUS);
+}
+
+EXPORT_SYMBOL(artis_complete_migration);
+
+/**
+ * artis_fetch_from_migration - fetch all the tasks being moved from a RT CPU
+ * @cpu_orig the processor where the tasks come from
+ *
+ */
+void artis_fetch_from_migration(int cpu_orig)
+{
+	/* This function is called from schedule() so we know that :
+	 * - preemption is disabled
+	 * - irq are disabled
+	 * - artis migration is disabled
+	 * - the runqueue is locked
+	 */
+ 	runqueue_t *rq = this_rq();
+	artis_migration_queue_t *queue = this_artis()->queues[cpu_orig][smp_processor_id()];
+	task_t *p;
+	int size;
+
+	rq = this_rq();
+	/* there is one queue per couple rt_processor/nrt_processor */
+	for (p=artis_valois_pull_all(queue), size=0; p; p=VALOIS_NEXT(p)) {
+		/*
+		 * A wake-up has been able to reactivate the task but 
+		 * since we are in schedule(), it cannot take cpu before
+		 * the fetch has been runned. Therefore the local_status
+		 * is still available.
+		 * If the task comes from load-balancing then local_status
+		 * is null and we avoid doing checks on it.
+		 */
+		if (artis_local(p))
+			ARTIS_BUG((artis_flag(p) != ARTIS_STATUS_COMPLETE2), p);
+		if (!(artis_flag(p) & ARTIS_STATUS_LB))
+			 artis_flag(p) = ARTIS_STATUS_FETCH;
+		/* 
+		 * the task could have been re-activated by a wake-up 
+		 * but this code is part of scheduler so it has the
+		 * hand before the task can be scheduled
+		 */
+		if (!p->array)
+			activate_task(p, rq, 1);
+		ARTIS_BUG(!p->array, p);
+		p->artis_status.nb_migration++;
+		if (artis_flag(p) & ARTIS_STATUS_LB)
+			artis_flag(p) = 0;
+		put_task_struct(p);
+		size++;
+	}
+	atomic_sub(size, &(this_artis()->fetch_size));
+	atomic_sub(size, &(artis_info.size));
+}
+
+EXPORT_SYMBOL(artis_fetch_from_migration);
+
+/*
+ * We do the printk here because if we do it in artis_complete there is
+ * a freeze (may be because the IRQ are disabled).
+ *
+ * We are in schedule() and we know that:
+ *  - artis migration is disabled
+ *  - preemption is disabled
+ */
+void 
+artis_check_dummyfifo(int rt) {
+	artis_migration_queue_t *queue = this_artis()->queues[rt][NR_CPUS];
+	task_t *p;
+	
+	ARTIS_BUG(!queue->head, queue);
+	if (!queue->head->next)
+		return;
+	for(p=queue->head->next->task; p; p=VALOIS_NEXT_NOBREAK(p)) {
+		if (artis_flag(p) & ARTIS_STATUS_DUMMY1) {
+			printk("ARTIS Error : no NRT CPU found for pid=%d from cpu %d. Using dummy queue\n", (int)p->pid, rt);
+			artis_flag(p) = ARTIS_STATUS_DUMMY2;
+		}
+	}
+}
+
+artis_info_t artis_info = ARTIS_INFO_INIT;
+
+/* CPU j is a NRT-CPU or the dummy CPUa */
+#define isNRT(j,nrt_mask) ((j)==NR_CPUS || cpu_isset((j),(nrt_mask)))
+
+
+static cpumask_t artis_default_maskrt;
+static int artis_boot_active;
+
+/**
+ * setup_artis_maskrt
+ * @s rt cpus mask
+ */
+static int setup_artis_maskrt (char *s)
+{
+	cpumask_t mask;
+	int err;
+	
+	if (!s || !(*s))
+		return 0;
+
+	err = cpumask_parse(s, strlen(s), mask);
+	if (err)
+		return err;
+	
+	/* Is there a clear way to copy a mask into another? */
+	cpus_and(artis_default_maskrt, mask, mask);
+
+       return 1;
+}
+
+__setup("artis_maskrt=", setup_artis_maskrt);
+
+
+/**
+ * setup_artis_active
+ * @s
+ *
+ * Activates ARTiS at boot time
+ */
+static int setup_artis_active (char *s)
+{
+       artis_boot_active = 1;
+
+       return 1;
+}
+
+__setup("artis_active", setup_artis_active);
+
+
+
+/**
+ * artis_init - initializes ARTiS subsystem
+ * @rt_cpu_mask real-time CPUs mask
+ *
+ * This function is called at boottime.
+ */
+void __init artis_init(void)
+{
+	artis_per_cpu_info_t *artis_cpu=NULL;
+	artis_per_cpu_info_t artis_cpu_init=ARTIS_PER_CPU_INFO_INIT;
+	artis_migration_queue_t ***queues_matrix;
+	artis_migration_queue_t queue_init=ARTIS_MIGRATION_QUEUE_INIT;
+	artis_fifo_node_t an_init = ARTIS_FIFO_NODE_INIT;
+	int i, j;
+
+	cpus_clear(artis_info.cpus_rt);
+	cpus_clear(artis_info.cpus_nrt);
+	/* initialization of shared runqueue matrix*/
+	queues_matrix = (artis_migration_queue_t ***) kmalloc(NR_CPUS * sizeof(artis_migration_queue_t **), GFP_KERNEL);
+	if (!queues_matrix)
+		goto nomem1;
+
+	memset(queues_matrix, 0, NR_CPUS * sizeof(artis_migration_queue_t **));
+	printk("ARTIS : initialization of the matrix queue (%p)\n", queues_matrix);
+
+	/* initialization of per-CPU structures */
+	/* on X86 it seems for_each_cpu doesn't work yet */
+	for(i = 0; i < NR_CPUS; i++) {
+		artis_cpu = cpu_artis(i);
+		*artis_cpu = artis_cpu_init;
+		artis_cpu->queues = queues_matrix;
+		if (cpu_isset(i, artis_default_maskrt)) {
+			/* rt cpu. Init queues matrix */
+			printk("ARTIS CPU%d: configured as Real-Time (%p)\n", i, artis_cpu);
+			artis_cpu->cpu_type = ARTIS_RT_CPU;
+			cpu_set(i, artis_info.cpus_rt);
+		} else {
+			printk("ARTIS CPU%d: configured as Non Real-Time (%p)\n", i, artis_cpu);
+			artis_cpu->cpu_type = ARTIS_NRT_CPU;
+			cpu_set(i, artis_info.cpus_nrt);
+		}
+	}
+
+	/* init queue between RT and NRT 
+	 * the access order is first RT then NRT : [RT][NRT]
+	 */
+	for (i = 0; i < NR_CPUS; i++) {
+		queues_matrix[i] = (artis_migration_queue_t **) kmalloc((NR_CPUS+1) * sizeof(artis_migration_queue_t *), GFP_KERNEL);
+		if (!queues_matrix[i])
+			goto nomem2;
+
+		memset(queues_matrix[i], 0, (NR_CPUS+1) * sizeof(artis_migration_queue_t *));
+		for(j = 0; j <= NR_CPUS; j++) {
+			artis_migration_queue_t *queue;
+			artis_fifo_node_t *an;
+
+			/* alloc the dummy node of the FIFO */
+			an = alloc_artis_fifo_node(tsk);
+			*an = an_init;
+
+			artis_cpu->queues[i][j] = (artis_migration_queue_t *) kmalloc(sizeof(artis_migration_queue_t), GFP_KERNEL);
+			if (!artis_cpu->queues[i][j])
+				goto nomem2;
+
+			queue = artis_cpu->queues[i][j];
+			*queue = queue_init;
+			queue->head = queue->tail = an;
+			if (j < NR_CPUS) {
+				printk("ARTIS CPU%d: initialization of the queue for CPU%d (%p+%ld)\n",
+						i, j, queue, (long)sizeof(artis_migration_queue_t));
+			} else {
+				printk("ARTIS CPU%d: initialization of the dummy queue (%p+%ld)\n",
+						i, queue, (long)sizeof(artis_migration_queue_t));
+			}
+		}
+	}
+
+	printk("ARTIS debug : NR_CPUS=%d PREEMPT_ACTIVE=%lx PREEMPT_MASK=%lx HARDIRQ_MASK=%lx SOFTIRQ_MASK=%lx\n",
+			(int)NR_CPUS,
+			(unsigned long)PREEMPT_ACTIVE,
+			(unsigned long)PREEMPT_MASK,
+			(unsigned long)HARDIRQ_MASK,
+			(unsigned long)SOFTIRQ_MASK
+		);
+	
+	/* Create /proc/artis struct */
+	artis_proc_init();
+
+	/* activate ARTiS if artis_active was specified on command line */
+	artis_info.active = artis_boot_active;
+
+	printk ("ARTiS succesfully initialized...\n");
+
+	return;
+
+nomem2:
+	/* Not enough memory (at boot time ?!), free up everything */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (queues_matrix[i]) {
+			for(j = 0; j <= NR_CPUS; j++)
+				if (artis_cpu->queues[i][j])
+					kfree(artis_cpu->queues[i][j]);
+			kfree(queues_matrix[i]);
+		}
+	}
+
+	kfree(queues_matrix);
+
+nomem1:
+	printk("ARTiS initialization error\n");
+}
+
+
+
+/**
+ * artis_reinit - reinitializes ARTiS subsystem
+ * @rt_cpu_mask real-time CPUs mask
+ *
+ * Returns 0 on success, -1 on failure.
+ *
+ * This function is called when the RT mask is changed using
+ * /proc/artis/maskrt
+ */
+int
+artis_reinit(cpumask_t rt_cpu_mask)
+{
+	artis_per_cpu_info_t *artis_cpu=NULL;
+	artis_migration_queue_t ***queues_matrix;
+	cpumask_t old_rt_mask, old_nrt_mask, tmp;
+	int i;
+
+	/* test if the new config has at least a NRT-CPU */
+	cpus_complement(tmp, rt_cpu_mask);
+	cpus_and(tmp, tmp, cpu_online_map);
+	if (cpus_empty(tmp)) {
+		printk("ARTIS Error : re-initialization without any online NRT-CPUs (%ld)\n", cpus_addr(rt_cpu_mask)[0]);
+		return -1;
+	}
+
+	old_rt_mask = artis_info.cpus_rt;
+	old_nrt_mask = artis_info.cpus_nrt;
+	queues_matrix = this_artis()->queues;
+	printk("ARTIS : re-initialization of the configuration (%p)\n", queues_matrix);
+
+	cpus_clear(artis_info.cpus_rt);
+	cpus_clear(artis_info.cpus_nrt);
+
+	for_each_cpu(i) {
+		artis_cpu = cpu_artis(i);
+		if (cpu_isset(i, rt_cpu_mask)) {
+			/* rt cpu. Init queues matrix */
+			if (cpu_isset(i, old_rt_mask))
+				printk("ARTIS CPU%d: stay Real-Time (%p)\n", i, artis_cpu);
+			else
+				printk("ARTIS CPU%d: reconfigured as Real-Time (%p)\n", i, artis_cpu);
+			artis_cpu->cpu_type = ARTIS_RT_CPU;
+			cpu_set(i, artis_info.cpus_rt);
+		} else {
+			if (cpu_isset(i, old_nrt_mask))
+				printk("ARTIS CPU%d: stay Non Real-Time (%p)\n", i, artis_cpu);
+			else
+				printk("ARTIS CPU%d: reconfigured as Non Real-Time (%p)\n", i, artis_cpu);
+			artis_cpu->cpu_type = ARTIS_NRT_CPU;
+			cpu_set(i, artis_info.cpus_nrt);
+		}
+	}
+
+	return 0;
+}
+
+
+#endif /* CONFIG_ARTIS */
+
+
 /**
  * sys_sched_setscheduler - set/change the scheduler policy and RT priority
  * @pid: the pid in question.

--------------040001060200010108080207--
