Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968299AbWLEP0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968299AbWLEP0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968304AbWLEP0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:26:34 -0500
Received: from mga03.intel.com ([143.182.124.21]:14544 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968299AbWLEP0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:26:32 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,501,1157353200"; 
   d="scan'208"; a="154068033:sNHT554703079"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Christoph Lameter'" <clameter@sgi.com>, "Ingo Molnar" <mingo@elte.hu>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [-mm patch] sched remove lb_stopbalance counter
Date: Tue, 5 Dec 2006 07:21:48 -0800
Message-ID: <000001c71881$1ad82850$a884030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccYgRUyCx4w7rxDS2eHwg+txC/jow==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding to sched-decrease-number-of-load-balances.patch currently
in -mm tree: I would like to revert the change on adding lb_stopbalance
counter.  This count can be calculated by: lb_balanced - lb_nobusyg -
lb_nobusyq.  There is no need to create gazillion counters while we
can derive the value.  I'm more of against changing sched-stat format
unless it is absolutely necessary as all user land tool parsing
/proc/schedstat needs to be updated and it's a real pain trying to keep
multiple versions of it.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- ./include/linux/sched.h.orig	2006-12-05 07:56:11.000000000 -0800
+++ ./include/linux/sched.h	2006-12-05 07:57:55.000000000 -0800
@@ -684,7 +684,6 @@ struct sched_domain {
 	unsigned long lb_hot_gained[MAX_IDLE_TYPES];
 	unsigned long lb_nobusyg[MAX_IDLE_TYPES];
 	unsigned long lb_nobusyq[MAX_IDLE_TYPES];
-	unsigned long lb_stopbalance[MAX_IDLE_TYPES];
 
 	/* Active load balancing */
 	unsigned long alb_cnt;
--- ./kernel/sched.c.orig	2006-12-05 07:56:31.000000000 -0800
+++ ./kernel/sched.c	2006-12-05 08:02:11.000000000 -0800
@@ -428,7 +428,7 @@ static inline void task_rq_unlock(struct
  * bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 13
+#define SCHEDSTAT_VERSION 12
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -466,7 +466,7 @@ static int show_schedstat(struct seq_fil
 			seq_printf(seq, "domain%d %s", dcnt++, mask_str);
 			for (itype = SCHED_IDLE; itype < MAX_IDLE_TYPES;
 					itype++) {
-				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu",
+				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu",
 				    sd->lb_cnt[itype],
 				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
@@ -474,8 +474,7 @@ static int show_schedstat(struct seq_fil
 				    sd->lb_gained[itype],
 				    sd->lb_hot_gained[itype],
 				    sd->lb_nobusyq[itype],
-				    sd->lb_nobusyg[itype],
-				    sd->lb_stopbalance[itype]);
+				    sd->lb_nobusyg[itype]);
 			}
 			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu\n",
 			    sd->alb_cnt, sd->alb_failed, sd->alb_pushed,
@@ -2579,10 +2578,8 @@ redo:
 	group = find_busiest_group(sd, this_cpu, &imbalance, idle, &sd_idle,
 				   &cpus, balance);
 
-	if (*balance == 0) {
-		schedstat_inc(sd, lb_stopbalance[idle]);
+	if (*balance == 0)
 		goto out_balanced;
-	}
 
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[idle]);



