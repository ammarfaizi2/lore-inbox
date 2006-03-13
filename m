Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWCMIHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWCMIHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWCMIHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:07:24 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:57044 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932339AbWCMIHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:07:23 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [PATCH][2/4] sched: add discrete weighted cpu load function
Date: Mon, 13 Mar 2006 19:06:11 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2955
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200603131906.11739.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the type of weighting is known to be zero we can use a simpler
version of source_load with a weighted_cpuload() function. Export that
function to allow relative weighted cpu load to be used by other
subsystems if desired.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 include/linux/sched.h |    1 +
 kernel/sched.c        |   10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc6-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/linux/sched.h	2006-03-13 13:25:31.000000000 +1100
+++ linux-2.6.16-rc6-mm1/include/linux/sched.h	2006-03-13 18:29:34.000000000 +1100
@@ -102,6 +102,7 @@ extern int nr_processes(void);
 extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
 extern unsigned long nr_iowait(void);
+extern unsigned long weighted_cpuload(const int cpu);
 
 #include <linux/time.h>
 #include <linux/param.h>
Index: linux-2.6.16-rc6-mm1/kernel/sched.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/sched.c	2006-03-13 13:25:39.000000000 +1100
+++ linux-2.6.16-rc6-mm1/kernel/sched.c	2006-03-13 17:05:26.000000000 +1100
@@ -914,6 +914,12 @@ inline int task_curr(const task_t *p)
 	return cpu_curr(task_cpu(p)) == p;
 }
 
+/* Used instead of source_load when we know the type == 0 */
+unsigned long weighted_cpuload(const int cpu)
+{
+	return (cpu_rq(cpu)->raw_weighted_load);
+}
+
 #ifdef CONFIG_SMP
 typedef struct {
 	struct list_head list;
@@ -1114,7 +1120,7 @@ find_idlest_cpu(struct sched_group *grou
 	cpus_and(tmp, group->cpumask, p->cpus_allowed);
 
 	for_each_cpu_mask(i, tmp) {
-		load = source_load(i, 0);
+		load = weighted_cpuload(i);
 
 		if (load < min_load || (load == min_load && i == this_cpu)) {
 			min_load = load;
@@ -2186,7 +2192,7 @@ static runqueue_t *find_busiest_queue(st
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
-		load = source_load(i, 0);
+		load = weighted_cpuload(i);
 
 		if (load > max_load) {
 			max_load = load;
