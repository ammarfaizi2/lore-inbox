Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030545AbWBNKMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030545AbWBNKMB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWBNKLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:11:41 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:38634 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030324AbWBNKLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:11:35 -0500
Date: Tue, 14 Feb 2006 11:11:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 08/12] hrtimer: completely remove it_real_value
Message-ID: <Pine.LNX.4.61.0602141111270.3731@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove the it_real_value from /proc/*/stat, during 1.2.x was the last
time it returned useful data (as it was directly maintained by the
scheduler), now it's only a waste of time to calculate it.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 fs/proc/array.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6-git/fs/proc/array.c
===================================================================
--- linux-2.6-git.orig/fs/proc/array.c	2006-02-13 22:29:44.000000000 +0100
+++ linux-2.6-git/fs/proc/array.c	2006-02-13 22:30:08.000000000 +0100
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
