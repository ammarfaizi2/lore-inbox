Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129146AbRCEKVf>; Mon, 5 Mar 2001 05:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRCEKVZ>; Mon, 5 Mar 2001 05:21:25 -0500
Received: from iso.horizon.ie ([193.120.106.19]:16089 "EHLO iso.horizon.ie")
	by vger.kernel.org with ESMTP id <S129146AbRCEKVI>;
	Mon, 5 Mar 2001 05:21:08 -0500
Message-Id: <200103051006.f25A6FD06987@luggage.horizon.ie>
X-Mailer: exmh version 2.3.1 01/18/2001 with nmh-1.0.4
From: chris.higgins@horizon.ie
To: linux-kernel@vger.kernel.org
cc: chris.higgins@horizon.ie (Chris Higgins)
Subject: PATCH: kernel/sched.c - Optimisation of some variable assignments
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Mar 2001 10:06:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was reading through sched.c and noticed two places where variable
assignments occur immediately prior to 'if(test) goto label:' statements.
If the test is TRUE, then the jump happens and in both cases the
variables are either not used, or immediately over-written..

So I've re-sequenced the two sets of statements to 'test then assign'
rather than 'assign regardless, then test'.

I presume that the C compiler is optimising this out, but not all 
platforms may been seeing this... It's probably only going to save
a couple of cycles on any iteration through the scheduler, but
the more available for everyone else the better :)


--- kernel/sched.c.orig Fri Feb  9 19:37:03 2001
+++ kernel/sched.c      Sun Mar  4 20:27:42 2001
@@ -507,11 +507,11 @@
 
        if (!current->active_mm) BUG();
 need_resched_back:
+       if (in_interrupt())
+               goto scheduling_in_interrupt;
        prev = current;
        this_cpu = prev->processor;
 
-       if (in_interrupt())
-               goto scheduling_in_interrupt;
 
        release_kernel_lock(prev, this_cpu);
 
@@ -553,10 +553,10 @@
        /*
         * Default process to select..
         */
-       next = idle_task(this_cpu);
-       c = -1000;
        if (prev->state == TASK_RUNNING)
                goto still_running;
+       next = idle_task(this_cpu);
+       c = -1000;
 
 still_running_back:
        list_for_each(tmp, &runqueue_head) {


--END-OF-PATCH---


-- 
** Chris Higgins                         e: chris.higgins at horizon.ie **
** Technical Business Development        tel: +353-1-6204916            **
** Horizon Technology Group              fax: +353-1-6204949            **


