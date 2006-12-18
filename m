Return-Path: <linux-kernel-owner+w=401wt.eu-S932288AbWLRXvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWLRXvb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWLRXvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:51:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:44022 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288AbWLRXva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:51:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:message-id:user-agent:mime-version:content-type:sender;
        b=EGF03Oy9ZDnJdz0ioK2Tko9U6Hcj1pIs475xD4uL4kzVLTeilvBe7L4RemnFUQp5AIyJs+EZuZIxW2pXQ31MdPbtG+2km1f7L+MvOJe+cmAoi14KjGE8WbJF0j2NMkRn8vk0t6uiPn6eV4Imlqi3zgBARUUpaFfEPHC184dG5LQ=
From: David Wragg <david@wragg.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] procfs: export context switch counts in /proc/*/stat
Date: Mon, 18 Dec 2006 23:50:08 +0000
Message-ID: <87zm9k228f.fsf@wragg.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel already maintains context switch counts for each task, and
exposes them through getrusage(2).  These counters can also be used
more generally to track which processes on the system are active
(i.e. getting scheduled to run), but getrusage is too constrained to
use it in that way.

This patch (against 2.6.19/2.6.19.1) adds the four context switch
values (voluntary context switches, involuntary context switches, and
the same values accumulated from terminated child processes) to the
end of /proc/*/stat, similarly to min_flt, maj_flt and the time used
values.

Signed-off-by: David Wragg <david@wragg.org>

diff -uprN --exclude='*.o' --exclude='*~' --exclude='.*' linux-2.6.19.1/fs/proc/array.c linux-2.6.19.1.build/fs/proc/array.c
--- linux-2.6.19.1/fs/proc/array.c	2006-12-18 14:35:36.000000000 +0000
+++ linux-2.6.19.1.build/fs/proc/array.c	2006-12-18 14:43:21.000000000 +0000
@@ -327,6 +327,8 @@ static int do_task_stat(struct task_stru
 	unsigned long cmin_flt = 0, cmaj_flt = 0;
 	unsigned long  min_flt = 0,  maj_flt = 0;
 	cputime_t cutime, cstime, utime, stime;
+	unsigned long cnvcsw = 0, cnivcsw = 0;
+	unsigned long  nvcsw = 0,  nivcsw = 0;
 	unsigned long rsslim = 0;
 	char tcomm[sizeof(task->comm)];
 	unsigned long flags;
@@ -369,6 +371,8 @@ static int do_task_stat(struct task_stru
 		cmaj_flt = sig->cmaj_flt;
 		cutime = sig->cutime;
 		cstime = sig->cstime;
+		cnvcsw = sig->cnvcsw;
+		cnivcsw = sig->cnivcsw;
 		rsslim = sig->rlim[RLIMIT_RSS].rlim_cur;
 
 		/* add up live thread stats at the group level */
@@ -379,6 +383,8 @@ static int do_task_stat(struct task_stru
 				maj_flt += t->maj_flt;
 				utime = cputime_add(utime, t->utime);
 				stime = cputime_add(stime, t->stime);
+				nvcsw += t->nvcsw;
+				nivcsw += t->nivcsw;
 				t = next_thread(t);
 			} while (t != task);
 
@@ -386,6 +392,8 @@ static int do_task_stat(struct task_stru
 			maj_flt += sig->maj_flt;
 			utime = cputime_add(utime, sig->utime);
 			stime = cputime_add(stime, sig->stime);
+			nvcsw += sig->nvcsw;
+			nivcsw += sig->nivcsw;
 		}
 
 		sid = sig->session;
@@ -404,6 +412,8 @@ static int do_task_stat(struct task_stru
 		maj_flt = task->maj_flt;
 		utime = task->utime;
 		stime = task->stime;
+		nvcsw = task->nvcsw;
+		nivcsw = task->nivcsw;		
 	}
 
 	/* scale priority and nice values from timeslices to -20..20 */
@@ -420,7 +430,7 @@ static int do_task_stat(struct task_stru
 
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu %lu %lu %lu %lu\n",
 		task->pid,
 		tcomm,
 		state,
@@ -465,7 +475,12 @@ static int do_task_stat(struct task_stru
 		task_cpu(task),
 		task->rt_priority,
 		task->policy,
-		(unsigned long long)delayacct_blkio_ticks(task));
+		(unsigned long long)delayacct_blkio_ticks(task),
+		nvcsw,
+		cnvcsw,
+		nivcsw,
+		cnivcsw);
+                
 	if(mm)
 		mmput(mm);
 	return res;


