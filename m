Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315584AbSEIBD1>; Wed, 8 May 2002 21:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315585AbSEIBD0>; Wed, 8 May 2002 21:03:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:51212 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315584AbSEIBDZ>; Wed, 8 May 2002 21:03:25 -0400
Date: Wed, 8 May 2002 21:55:21 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] IO wait accounting
Message-ID: <Pine.LNX.4.44L.0205082153010.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch implements simple IO wait accounting, with the
following two oddities:

1) only page fault IO is currently counted
2) while idle, a tick can be counted as both system time
   and iowait time, hence IO wait time is not substracted
   from idle time (also to ensure backwards compatability
   with procps)

I'm doubting whether or not to change these two issues and if
they should be changed, how should they behave instead ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.383.26.6 -> 1.383.26.7
#	  include/linux/mm.h	1.43    -> 1.44
#	 fs/proc/proc_misc.c	1.14    -> 1.15
#	      kernel/timer.c	1.3     -> 1.3.1.1
#	include/linux/kernel_stat.h	1.3     -> 1.4
#	         mm/memory.c	1.52    -> 1.53
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/08	riel@mirkwood.rielhome.conectiva	1.383.26.7
# iowait accounting, note that iowait is not substracted from idle time
# since a jiffie can be counted as both system and iowait
# (still untested, -pre7 doesn't boot on my test box)
# --------------------------------------------
#
diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Wed May  8 21:51:32 2002
+++ b/fs/proc/proc_misc.c	Wed May  8 21:51:32 2002
@@ -266,7 +266,7 @@
 	int i, len;
 	extern unsigned long total_forks;
 	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0;
+	unsigned int sum = 0, user = 0, nice = 0, system = 0, iowait = 0;
 	int major, disk;

 	for (i = 0 ; i < smp_num_cpus; i++) {
@@ -275,23 +275,26 @@
 		user += kstat.per_cpu_user[cpu];
 		nice += kstat.per_cpu_nice[cpu];
 		system += kstat.per_cpu_system[cpu];
+		iowait += kstat.per_cpu_iowait[cpu];
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
 			sum += kstat.irqs[cpu][j];
 #endif
 	}

-	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
+	len = sprintf(page, "cpu  %u %u %u %lu %lu\n", user, nice, system,
+		      jif * smp_num_cpus - (user + nice + system),
+		      iowait);
 	for (i = 0 ; i < smp_num_cpus; i++)
-		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
+		len += sprintf(page + len, "cpu%d %u %u %u %lu %u\n",
 			i,
 			kstat.per_cpu_user[cpu_logical_map(i)],
 			kstat.per_cpu_nice[cpu_logical_map(i)],
 			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
-				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+			jif - (  kstat.per_cpu_user[cpu_logical_map(i)]
+				   + kstat.per_cpu_nice[cpu_logical_map(i)]
+				   + kstat.per_cpu_system[cpu_logical_map(i)]),
+			kstat.per_cpu_iowait[cpu_logical_map(i)]);
 	len += sprintf(page + len,
 		"page %u %u\n"
 		"swap %u %u\n"
diff -Nru a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
--- a/include/linux/kernel_stat.h	Wed May  8 21:51:32 2002
+++ b/include/linux/kernel_stat.h	Wed May  8 21:51:32 2002
@@ -18,7 +18,8 @@
 struct kernel_stat {
 	unsigned int per_cpu_user[NR_CPUS],
 	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS];
+	             per_cpu_system[NR_CPUS],
+		     per_cpu_iowait[NR_CPUS];
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Wed May  8 21:51:32 2002
+++ b/include/linux/mm.h	Wed May  8 21:51:32 2002
@@ -18,6 +18,7 @@
 extern unsigned long num_mappedpages;
 extern void * high_memory;
 extern int page_cluster;
+extern atomic_t pagefaults_in_progress;

 #include <asm/page.h>
 #include <asm/pgtable.h>
diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Wed May  8 21:51:32 2002
+++ b/kernel/timer.c	Wed May  8 21:51:32 2002
@@ -592,8 +592,16 @@
 		else
 			kstat.per_cpu_user[cpu] += user_tick;
 		kstat.per_cpu_system[cpu] += system;
-	} else if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
-		kstat.per_cpu_system[cpu] += system;
+	} else {
+		/*
+		 * No process is running, but if we're handling interrupts
+		 * or processes are waiting on disk IO, we're not really idle.
+		 */
+		if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
+			kstat.per_cpu_system[cpu] += system;
+		if (atomic_read(&pagefaults_in_progress) > 0)
+			kstat.per_cpu_iowait[cpu] += system;
+	}
 }

 /*
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Wed May  8 21:51:32 2002
+++ b/mm/memory.c	Wed May  8 21:51:32 2002
@@ -57,6 +57,7 @@
 unsigned long num_mappedpages;
 void * high_memory;
 struct page *highmem_start_page;
+atomic_t pagefaults_in_progress = ATOMIC_INIT(0);

 /*
  * We special-case the C-O-W ZERO_PAGE, because it's such
@@ -1381,6 +1382,7 @@
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
+	int ret = -1;

 	current->state = TASK_RUNNING;
 	pgd = pgd_offset(mm, address);
@@ -1397,16 +1399,20 @@
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
 	 */
+	atomic_inc(&pagefaults_in_progress);
 	spin_lock(&mm->page_table_lock);
 	pmd = pmd_alloc(mm, pgd, address);

 	if (pmd) {
 		pte_t * pte = pte_alloc(mm, pmd, address);
 		if (pte)
-			return handle_pte_fault(mm, vma, address, write_access, pte);
+			ret = handle_pte_fault(mm, vma, address, write_access, pte);
+		else
+			spin_unlock(&mm->page_table_lock);
 	}
-	spin_unlock(&mm->page_table_lock);
-	return -1;
+
+	atomic_dec(&pagefaults_in_progress);
+	return ret;
 }

 /*

