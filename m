Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318118AbSGMHnJ>; Sat, 13 Jul 2002 03:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318119AbSGMHnI>; Sat, 13 Jul 2002 03:43:08 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:38919 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S318118AbSGMHnF>; Sat, 13 Jul 2002 03:43:05 -0400
Date: Sat, 13 Jul 2002 09:45:53 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Ed Sweetman <safemode@speakeasy.net>
cc: <linux-kernel@vger.kernel.org>
Subject: [Patch] Re: fs/fs.o linking error in 2.5.25-dj2
In-Reply-To: <1026536041.1203.107.camel@psuedomode>
Message-ID: <Pine.LNX.4.33.0207130926450.11082-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jul 2002, Ed Sweetman wrote:

> When compiling with the 2.5 ide subsystem i get undefined references to
> __udivdi3  
> 
>   ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o /usr/src/linux-2.5.25/arch/i386/lib/lib.a lib/lib.a /usr/src/linux-2.5.25/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
> fs/fs.o: In function `proc_pid_stat':
> fs/fs.o(.text+0x1ff3f): undefined reference to `__udivdi3'
> fs/fs.o: In function `kstat_read_proc':
> fs/fs.o(.text+0x20fc8): undefined reference to `__udivdi3'
> fs/fs.o(.text+0x2105e): undefined reference to `__udivdi3'
> 

The following patch fixes this. It was intended to go into -dj2, but 
unfortunately got eaten by Daves harddisk (or something like that, don't 
know exactly).

Tim


--- linux-2.5.25-dj2/kernel/timer.c	Sat Jul 13 08:42:01 2002
+++ linux-2.5.25-dj2-jfix/kernel/timer.c	Sat Jul 13 08:42:53 2002
@@ -24,8 +24,10 @@
 #include <linux/interrupt.h>
 #include <linux/tqueue.h>
 #include <linux/kernel_stat.h>
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 struct kernel_stat kstat;
 
@@ -938,13 +940,16 @@
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
+	u64 uptime;
 	unsigned long mem_total, sav_total;
 	unsigned int mem_unit, bitcount;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
 	read_lock_irq(&xtime_lock);
-	val.uptime = jiffies / HZ;
+	uptime = jiffies_64;
+	do_div(uptime, HZ);
+	val.uptime = (unsigned long) uptime;
 
 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);

--- linux-2.5.25-dj2/fs/proc/array.c	Sat Jul 13 08:41:59 2002
+++ linux-2.5.25-dj2-jfix/fs/proc/array.c	Sat Jul 13 09:05:22 2002
@@ -346,7 +346,7 @@
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
 		task->comm,
@@ -369,7 +369,7 @@
 		nice,
 		0UL /* removed */,
 		jiffies_to_clock_t(task->it_real_value),
-		jiffies_to_clock_t(task->start_time),
+		(unsigned long long) jiffies_64_to_clock_t(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.5.25-dj2/fs/proc/proc_misc.c	Sat Jul 13 08:41:59 2002
+++ linux-2.5.25-dj2-jfix/fs/proc/proc_misc.c	Sat Jul 13 09:10:16 2002
@@ -310,7 +310,9 @@
 		jiffies_to_clock_t(user),
 		jiffies_to_clock_t(nice),
 		jiffies_to_clock_t(system),
-		jiffies_to_clock_t(jif * num_online_cpus() - (user + nice + system)));
+		(unsigned long long)
+		jiffies_64_to_clock_t(jif * num_online_cpus()
+		                      - user - nice - system));
 	for (i = 0 ; i < NR_CPUS; i++){
 		if (!cpu_online(i)) continue;
 		len += sprintf(page + len, "cpu%d %lu %lu %lu %llu\n",
@@ -318,9 +320,10 @@
 			jiffies_to_clock_t(kstat.per_cpu_user[i]),
 			jiffies_to_clock_t(kstat.per_cpu_nice[i]),
 			jiffies_to_clock_t(kstat.per_cpu_system[i]),
-			jiffies_to_clock_t(jif - (  kstat.per_cpu_user[i] \
-			       + kstat.per_cpu_nice[i] \
-			       + kstat.per_cpu_system[i])));
+			(unsigned long long)
+			jiffies_64_to_clock_t(jif - kstat.per_cpu_user[i]
+			                          - kstat.per_cpu_nice[i]
+			                          - kstat.per_cpu_system[i]));
 	}
 	len += sprintf(page + len,
 		"page %u %u\n"

--- linux-2.5.25-dj2/include/linux/times.h	Sat Jul 13 08:40:21 2002
+++ linux-2.5.25-dj2-jfix/include/linux/times.h	Sat Jul 13 09:06:05 2002
@@ -2,7 +2,22 @@
 #define _LINUX_TIMES_H
 
 #ifdef __KERNEL__
+#include <asm/div64.h>
+#include <asm/types.h>
+
 # define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
+
+/* 
+ * returning a different type than the function name says is
+ * ugly as hell, and only intended to stay until I know what type
+ * should replace clock_t
+ */
+
+static inline u64 jiffies_64_to_clock_t(u64 x)
+{
+	do_div(x, HZ / USER_HZ);
+	return x;
+}
 #endif
 
 struct tms {

