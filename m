Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVBXCZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVBXCZM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVBXCZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:25:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16854 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261690AbVBXCY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:24:58 -0500
Date: Wed, 23 Feb 2005 18:24:52 -0800
Message-Id: <200502240224.j1O2OqHL010736@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@osdl.org>
X-Fcc: ~/Mail/linus
Subject: [PATCH] set RLIMIT_SIGPENDING limit based on RLIMIT_NPROC
In-Reply-To: Jeremy Fitzhardinge's message of  Wednesday, 23 February 2005 15:09:51 -0800 <421D0D3F.40902@goop.org>
X-Zippy-Says: Yow!  And then we could sit on the hoods of cars at stop lights!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking into the issues Jeremy had with the RLIMIT_SIGPENDING limit,
it occurred to me that the normal setting of this limit is bizarrely low.
The initial hard limit setting (MAX_SIGPENDING) was taken from the old
max_queued_signals parameter, which was for the entire system in aggregate.
But even as a per-user limit, the 1024 value is incongruously low for this.
On my machine, RLIMIT_NPROC allows me 8192 processes, but only 1024 queued
signals, i.e. fewer even than one pending signal in each process.  (To me,
this really puts in doubt the sensibility of using a per-user limit for
this rather than a per-process one, i.e. counted in sighand_struct or
signal_struct, which could have a much smaller reasonable value.  I don't
recall the rationale for making this new limit per-user in the first place.)

This patch sets the default RLIMIT_SIGPENDING limit at boot time, using the
calculation that decides the default RLIMIT_NPROC limit.  This uses the
same value for those two limits, which I think is still pretty conservative
on the RLIMIT_SIGPENDING value.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/include/asm-generic/resource.h
+++ linux-2.6/include/asm-generic/resource.h
@@ -51,7 +51,7 @@
 	[RLIMIT_MEMLOCK]	= {   MLOCK_LIMIT,   MLOCK_LIMIT },	\
 	[RLIMIT_AS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
 	[RLIMIT_LOCKS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
-	[RLIMIT_SIGPENDING]	= { MAX_SIGPENDING, MAX_SIGPENDING },	\
+	[RLIMIT_SIGPENDING]	= { 		0,	       0 },	\
 	[RLIMIT_MSGQUEUE]	= { MQ_BYTES_MAX, MQ_BYTES_MAX },	\
 }
 
--- linux-2.6/include/linux/signal.h
+++ linux-2.6/include/linux/signal.h
@@ -8,8 +8,6 @@
 
 #ifdef __KERNEL__
 
-#define MAX_SIGPENDING	1024
-
 /*
  * Real Time signals may be queued.
  */
--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -129,6 +129,8 @@ void __init fork_init(unsigned long memp
 
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
+	init_task.signal->rlim[RLIMIT_SIGPENDING] =
+		init_task.signal->rlim[RLIMIT_NPROC];
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
