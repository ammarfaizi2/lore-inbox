Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbUBAVEK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUBAVEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:04:09 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:10902 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S265471AbUBAVDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:03:20 -0500
Date: Sun, 1 Feb 2004 22:02:37 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: Unrecognizable insn
Message-ID: <20040201210237.GA22841@localhost>
References: <20040201204143.GA26961@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040201204143.GA26961@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday February 1st 2004 Herbert Poetzl wrote:

> anybody seen that before?
> 
> fs/proc/array.c: In function `proc_pid_stat':
> fs/proc/array.c:441: Unrecognizable insn:
> ...

Yes, it's a known compiler bug, specific for gcc 2.96. It's recommended
you upgrade it. Or use the following workaround until you do: ;-)

--- linux-2.6.0-test8/fs/proc/array.c.orig	2003-10-21 16:18:40.000000000 +0200
+++ linux-2.6.0-test8/fs/proc/array.c	2003-10-23 09:30:27.000000000 +0200
@@ -302,6 +302,7 @@
 	pid_t ppid;
 	int num_threads = 0;
 	struct mm_struct *mm;
+	unsigned long long starttime;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -343,9 +344,7 @@
 	read_lock(&tasklist_lock);
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
-	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu ",
 		task->pid,
 		task->comm,
 		state,
@@ -355,7 +354,9 @@
 		tty_nr,
 		tty_pgrp,
 		task->flags,
-		task->min_flt,
+		task->min_flt);
+	starttime = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
+	res += sprintf(buffer + res,"%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu ",
 		task->cmin_flt,
 		task->maj_flt,
 		task->cmaj_flt,
@@ -367,15 +368,15 @@
 		nice,
 		num_threads,
 		jiffies_to_clock_t(task->it_real_value),
-		(unsigned long long)
-		    jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES),
+		starttime,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
 		mm ? mm->start_stack : 0,
-		esp,
+		esp);
+	res += sprintf(buffer + res,"%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		eip,
 		/* The signal information here is obsolete.
 		 * It must be decimal for Linux 2.0 compatibility.
