Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTJZQ1d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263291AbTJZQ1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:27:33 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:22175 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S263290AbTJZQ1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:27:22 -0500
Date: Sun, 26 Oct 2003 17:27:18 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test9
Message-ID: <20031026162718.GC23792@localhost>
References: <1067182375.17710.11.camel@mars.goatskin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1067182375.17710.11.camel@mars.goatskin.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday Oktober 26th 2003 at 10:32 uur Shane Shrybman wrote:

> gcc2.96, from Mandrake 8.2 (I would suspect that Redhat 7.* releases are
> in this boat too) has a bug that prevents the compilation -test9.

Yes, several people have reported this for the gcc 2.96 included in
RedHat 7.[23] as well. It started with 2.6.0-test8.

> fs/proc/array.c: In function `proc_pid_stat':
> fs/proc/array.c:398: Unrecognizable insn:
> (insn/i 1337 1673 1667 (parallel[ 
> ...

> and a little patch that resolves it for me
> 
> diff -ur linux-2.6.0-test9/fs/proc/array.c
> linux-2.6.0-test9-A/fs/proc/array.c
> --- linux-2.6.0-test9/fs/proc/array.c   Sat Oct 25 18:21:46 2003
> +++ linux-2.6.0-test9-A/fs/proc/array.c Sat Oct 25 19:14:15 2003
> @@ -295,7 +295,8 @@
>  {
>         unsigned long vsize, eip, esp, wchan;
>         long priority, nice;
> -       int tty_pgrp = -1, tty_nr = 0;
> +       int tty_pgrp = -1;
> +       volatile int tty_nr = 0;
>         sigset_t sigign, sigcatch;
>         char state;
>         int res;
> 

Here is another patch which solves the same problem in a different way!
There was a thread with some discussion on it several days ago; I objected
against the apparent magic in the use of 'volatile' here. It obviously
solves the compilation for you, but I wonder is there some deeper reason
it's used?

The following different patch (sent earlier in the mentioned thread)
'solves' this compilation issue as well by just simplifying and factoring
out some stuff. It's against 2.6.0-test8 but applies against 2.6.0-test9
and 2.6.0-test8-mm1 as well.

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

