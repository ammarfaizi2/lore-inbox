Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTLKNhM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTLKNhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:37:12 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:45195 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S264905AbTLKNgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:36:38 -0500
Date: Thu, 11 Dec 2003 14:33:41 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Arjan van Staalduijnen <linuxkernel@bioscoopagenda.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Compile failure when 'Preemptible Kernel' is disabled in 2.6.0-test11.
Message-ID: <20031211133341.GA14573@localhost>
References: <3FD86820.2010507@bioscoopagenda.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3FD86820.2010507@bioscoopagenda.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday december 11th 2003 Arjan van Staalduijnen wrote:

> [compile failure for fs/proc/array.c]

> [1.] Compile failure when 'Preemptible Kernel' is disabled.

It has nothing to do with 'preemptible'!
 
> [4.] Currently compiling under kernel version 'Linux version 2.6.0-test9 
> (root@airraid.toptracker.com) (gcc version 2.96 20000731 (Red Hat Linux 
> 7.3 2.96-113)) #1 Thu Nov 13 21:53:51 CET 2003'

This is a known compiler bug for RedHat's gcc 2.96 version. It has
difficulty casting 'unsigned long long's! Try this, it applies against
2.6.0-test8 and later.

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

