Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVIGTlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVIGTlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVIGTlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:41:09 -0400
Received: from [67.40.69.52] ([67.40.69.52]:17914 "EHLO morpheus")
	by vger.kernel.org with ESMTP id S932220AbVIGTlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:41:08 -0400
Subject: Gracefully killing kswapd, or any kernel thread
From: Kristis Makris <kristis.makris@asu.edu>
To: linux-kernel@vger.kernel.org
Date: Wed, 07 Sep 2005 12:41:08 -0700
Message-Id: <1126122068.2744.20.camel@syd.mkgnu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to kill a kernel thread gracefully, in particular kswapd,
without any success.

The goal is to start another kernel thread that contains updated kswapd
functionality, through a loadable module; no kernel recompilation.

I noticed that kernel threads block SIGKILL. Hence, on module load I'm
running:

task = find_task_by_name("kswapd");
if (task != NULL) {
    spin_lock_irq(&task->sigmask_lock);
    sigdelset(&task->blocked, SIGKILL);
    recalc_sigpending(task);
    spin_unlock_irq(&task->sigmask_lock);
    // Also tried issuing here a: kill_proc(task->pid, SIGKILL, 1);
}

Then from userspace I issue:

# ps aux |grep -i swap
root         4  0.0  0.0     0    0 ?        SW   18:36   0:00 [kswapd]
$ kill -9 4

After the kill is issued, kswapd is taking up 99.9% of CPU time and
remains at a runnable state:
# ps aux |grep -i swap
root         4  0.2  0.0     0    0 ?        RW   18:36   0:02 [kswapd]


Can anyone explain why this is happening ? I've tried this with linux
kernels 2.2.19 and 2.4.27 (with patch kdb-4.3). What is the proper way
of gracefully killing a kernel thread launched from the original kernel
image (not a module) in kernels < 2.6 (ie. without the new kernel thread
API that contains the stop_kthread call documented in
http://www.scs.ch/~frey/linux/kernelthreads.html)

I've also tried the same with kflushd, kupdate, and keventd in 2.2.19.
When I do issue a "kill -9" for them I see:

# ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         2  0.0  0.0     0    0 ?        SW   12:18   0:00 [kflushd]
root         3  1.5  0.0     0    0 ?        RW   12:18   0:16 [kupdate]
root         5  0.0  0.0     0    0 ?        SW   12:18   0:00 [keventd]

All 3 kernel threads remain in the process list. kupdate also appears to
be in a running state consuming 99.9% of the CPU when killed. What's so
special about kupdate and kswapd that makes them stay at a running
state, and why do all kernel threads seem unkillable?

Thanks,
Kristis

