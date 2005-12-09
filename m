Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVLIPWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVLIPWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVLIPWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:22:52 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:54201 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932242AbVLIPWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:22:51 -0500
Date: Fri, 9 Dec 2005 16:22:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/17] s390: cputime_t fixes.
Message-ID: <20051209152247.GB6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 1/17] s390: cputime_t fixes.

There are some more places where the use of cputime_t instead of an
integer type and the associated macros is necessary for the virtual
cputime accounting on s390. Affected are the s390 specific appldata
code and BSD process accounting.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/appldata/appldata_os.c |   14 +++++++-------
 kernel/acct.c                    |   16 +++++++++-------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_os.c linux-2.6-patched/arch/s390/appldata/appldata_os.c
--- linux-2.6/arch/s390/appldata/appldata_os.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_os.c	2005-12-09 14:24:20.000000000 +0100
@@ -141,19 +141,19 @@ static void appldata_get_os_data(void *d
 	j = 0;
 	for_each_online_cpu(i) {
 		os_data->os_cpu[j].per_cpu_user =
-					kstat_cpu(i).cpustat.user;
+			cputime_to_jiffies(kstat_cpu(i).cpustat.user);
 		os_data->os_cpu[j].per_cpu_nice =
-					kstat_cpu(i).cpustat.nice;
+			cputime_to_jiffies(kstat_cpu(i).cpustat.nice);
 		os_data->os_cpu[j].per_cpu_system =
-					kstat_cpu(i).cpustat.system;
+			cputime_to_jiffies(kstat_cpu(i).cpustat.system);
 		os_data->os_cpu[j].per_cpu_idle =
-					kstat_cpu(i).cpustat.idle;
+			cputime_to_jiffies(kstat_cpu(i).cpustat.idle);
 		os_data->os_cpu[j].per_cpu_irq =
-					kstat_cpu(i).cpustat.irq;
+			cputime_to_jiffies(kstat_cpu(i).cpustat.irq);
 		os_data->os_cpu[j].per_cpu_softirq =
-					kstat_cpu(i).cpustat.softirq;
+			cputime_to_jiffies(kstat_cpu(i).cpustat.softirq);
 		os_data->os_cpu[j].per_cpu_iowait =
-					kstat_cpu(i).cpustat.iowait;
+			cputime_to_jiffies(kstat_cpu(i).cpustat.iowait);
 		j++;
 	}
 
diff -urpN linux-2.6/kernel/acct.c linux-2.6-patched/kernel/acct.c
--- linux-2.6/kernel/acct.c	2005-12-09 14:21:54.000000000 +0100
+++ linux-2.6-patched/kernel/acct.c	2005-12-09 14:24:20.000000000 +0100
@@ -427,6 +427,7 @@ static void do_acct_process(long exitcod
 	u64 elapsed;
 	u64 run_time;
 	struct timespec uptime;
+	unsigned long jiffies;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -467,12 +468,12 @@ static void do_acct_process(long exitcod
 #endif
 	do_div(elapsed, AHZ);
 	ac.ac_btime = xtime.tv_sec - elapsed;
-	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(
-					    current->signal->utime +
-					    current->group_leader->utime));
-	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(
-					    current->signal->stime +
-					    current->group_leader->stime));
+	jiffies = cputime_to_jiffies(cputime_add(current->group_leader->utime,
+						 current->signal->utime));
+	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(jiffies));
+	jiffies = cputime_to_jiffies(cputime_add(current->group_leader->stime,
+						 current->signal->stime));
+	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(jiffies));
 	/* we really need to bite the bullet and change layout */
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
@@ -580,7 +581,8 @@ void acct_process(long exitcode)
 void acct_update_integrals(struct task_struct *tsk)
 {
 	if (likely(tsk->mm)) {
-		long delta = tsk->stime - tsk->acct_stimexpd;
+		long delta =
+			cputime_to_jiffies(tsk->stime) - tsk->acct_stimexpd;
 
 		if (delta == 0)
 			return;
