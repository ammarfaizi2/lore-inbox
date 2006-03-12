Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWCLKiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWCLKiI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWCLKhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:37:42 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:29670
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751411AbWCLKg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:36:58 -0500
Message-Id: <20060312080332.430560000@localhost.localdomain>
References: <20060312080316.826824000@localhost.localdomain>
Date: Sun, 12 Mar 2006 10:37:19 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 6/8] Remove it_real_value calculation from proc/*/stat
Content-Disposition: inline; filename=remove-it-real-value.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roman Zippel <zippel@linux-m68k.org>

Remove the it_real_value from /proc/*/stat, during 1.2.x was the last
time it returned useful data (as it was directly maintained by the
scheduler), now it's only a waste of time to calculate it. Return 0
instead.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Acked-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>

 fs/proc/array.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6.16-updates/fs/proc/array.c
===================================================================
--- linux-2.6.16-updates.orig/fs/proc/array.c
+++ linux-2.6.16-updates/fs/proc/array.c
@@ -330,7 +330,6 @@ static int do_task_stat(struct task_stru
 	unsigned long  min_flt = 0,  maj_flt = 0;
 	cputime_t cutime, cstime, utime, stime;
 	unsigned long rsslim = 0;
-	DEFINE_KTIME(it_real_value);
 	struct task_struct *t;
 	char tcomm[sizeof(task->comm)];
 
@@ -386,7 +385,6 @@ static int do_task_stat(struct task_stru
 			utime = cputime_add(utime, task->signal->utime);
 			stime = cputime_add(stime, task->signal->stime);
 		}
-		it_real_value = task->signal->real_timer.expires;
 	}
 	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
@@ -413,7 +411,7 @@ static int do_task_stat(struct task_stru
 	start_time = nsec_to_clock_t(start_time);
 
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
 		tcomm,
@@ -435,7 +433,6 @@ static int do_task_stat(struct task_stru
 		priority,
 		nice,
 		num_threads,
-		(long) ktime_to_clock_t(it_real_value),
 		start_time,
 		vsize,
 		mm ? get_mm_rss(mm) : 0,

--

