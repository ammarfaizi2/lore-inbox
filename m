Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbUKHSdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbUKHSdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUKHScu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:32:50 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:8966 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261180AbUKHSav convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:30:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: SCHED_RR and kernel threads
Date: Mon, 8 Nov 2004 10:30:48 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B002A7F094@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SCHED_RR and kernel threads
thread-index: AcTFwRvUtqxEIC47RguV2n75YytOLQ==
From: "Stephen Warren" <SWarren@nvidia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Nov 2004 18:30:50.0007 (UTC) FILETIME=[1253FA70:01C4C5C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

We have an application that is running on kernel 2.6.9. This application
makes use of real-time threads, namely using the SCHED_RR policy.

It appears that during times of high application CPU usage, some
*kernel* threads don't get to run. As an example, this means that local
keyboard presses aren't processed (or are processed very slowly) by the
kernel, so our application never sees them. This has the effect of
hanging the system, since the way to get out of the higher CPU usage
portion of the application is to press the ESC key, and our application
never sees that keypress.

This appears to be due to the fact that the kernel threads are all
SCHED_OTHER, so our SCHED_RR user-space application trumps them!

So, we made a little patch to make the kernel threads SCHED_RR too, so
that they will be guaranteed to get some CPU time, even when user-space
threads suck a lot of CPU (depending on their priority - at present,
most of our app threads are the same priority as the kernel threads,
with just a few being elevated).

The patch is below. Can anyone comment on whether this is a safe and/or
sensible thing to do? Any comments on alternative "right ways" to do
this would be great as well.

Thanks for any help!

Notes: The first part of the patch is where we initialize things to get
SCHED_RR for all tasks/threads in the system. The second is to work
around the fact that some of the init_task data is trashed later, so we
restore it back...

diff -urN linux-kernel.org/include/linux/init_task.h
linux-kernel.org-2/include/linux/init_task.h
--- linux-kernel.org/include/linux/init_task.h	2004-08-13
23:36:16.000000000 -0600
+++ linux-kernel.org-2/include/linux/init_task.h	2004-11-08
10:31:51.851216704 -0700
@@ -71,9 +71,10 @@
 	.usage		= ATOMIC_INIT(2),
\
 	.flags		= 0,
\
 	.lock_depth	= -1,
\
-	.prio		= MAX_PRIO-20,
\
+	.prio		= (MAX_RT_PRIO / 2) - 1,
\
 	.static_prio	= MAX_PRIO-20,
\
-	.policy		= SCHED_NORMAL,
\
+	.policy		= SCHED_RR,
\
+	.rt_priority	= MAX_RT_PRIO / 2,
\
 	.cpus_allowed	= CPU_MASK_ALL,
\
 	.mm		= NULL,
\
 	.active_mm	= &init_mm,
\
diff -urN linux-kernel.org/init/main.c linux-kernel.org-2/init/main.c
--- linux-kernel.org/init/main.c	2004-08-16 06:58:48.000000000
-0600
+++ linux-kernel.org-2/init/main.c	2004-11-08 10:32:12.001153448
-0700
@@ -660,6 +660,11 @@
 	 */
 	child_reaper = current;
 
+	/* Reset the prio to allow SCHED_RR tasks */
+	if (current->policy == SCHED_RR) {
+		current->prio = current->rt_priority - 1;
+	}
+
 	/* Sets up cpus_possible() */
 	smp_prepare_cpus(max_cpus);

-- 
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
