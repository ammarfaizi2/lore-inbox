Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTJWHux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 03:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbTJWHux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 03:50:53 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:57476 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S261321AbTJWHuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 03:50:50 -0400
Date: Thu, 23 Oct 2003 09:48:10 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: ndiamond@wta.att.ne.jp
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RH7.3 can't compile 2.6.0-test8 (fs/proc/array.c)
Message-ID: <20031023074810.GA1809@localhost>
References: <20031023011658.9B576E1EA@smtp3.att.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031023011658.9B576E1EA@smtp3.att.ne.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday Oktober 23 2003 at 10:16 uur Norman Diamond wrote:

> Marco Roeland wrote (privately but I hope not secretly :-)

I hope you didn't circumvent any digital information rights management
schemes?  ;-) No, my fault. Private communication is very un-open-source!
I wrote without access to sources (only some recent patches available) in
a very noisy office and was afraid my post would be as clear as a long quote
from Ulysses.
 
> > Perhaps working out the jiffies call in a separate variable
> > long long tmp = jiffies_64_to_clock_t(...); and then using
> > that in the sprintf() might work?
> 
> unsigned long long.
> 
> It worked.  I made this change after applying the patch
> previously posted by Mr. Roeland.  I think the present
> workaround might also work without the previous patch,
> and will try it that way if I have time.

Ok! As the compiler seems to be at the edge of overasking its capabilities
(three *different* simplifications which each should normally haven't made
any difference *did* make it compile for different people with gcc 2.96)
it might not be a bad idea to apply both simplifications (the 'volatile'
solution I think is not proper C here).
 
> Again this is with Red Hat's nonstandard gcc 2.96.

Well it is standard to RedHat 7! If a slight simplification makes it
work again whats wrong with that, as long as its proper C?

Ok, so we have something like this:

Simplify a longish expression so that gcc 2.96 doesn't choke on it.

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

