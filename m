Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267304AbRGKM5O>; Wed, 11 Jul 2001 08:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267305AbRGKM5E>; Wed, 11 Jul 2001 08:57:04 -0400
Received: from pat.uio.no ([129.240.130.16]:45047 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267304AbRGKM4t>;
	Wed, 11 Jul 2001 08:56:49 -0400
To: kladit@t-online.de (Klaus Dittrich),
        Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
In-Reply-To: <200107110849.f6B8nlm00414@df1tlpc.local.here>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Jul 2001 14:56:43 +0200
In-Reply-To: kladit@t-online.de's message of "Wed, 11 Jul 2001 10:49:47 +0200 (METDST)"
Message-ID: <shslmlv62us.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Klaus Dittrich <kladit@t-online.de> writes:

     > Kernel: 2.4.7p5 or 2.4.7p6 System: PII-SMP, BX-Chipset

     > The kernel boots up to the message

     > ..  Linux NET4.0 for Linux 2.4 Based upon Swansea University
     > Computer Society NET3.039

     > and then stops.

     > I actually use 2.4.7p3 without problems.

I have the same problem on my setup. To me, it looks like the loop in
spawn_ksoftirqd() is suffering from some sort of atomicity problem.

I managed to band-aid over the problem by replacing the loop with a
semaphore which the child clears when it has been initialized (as per
the appended patch).

Linus?

Cheers,
  Trond

--- linux-2.4.7-smp/kernel/softirq.c.orig	Wed Jul 11 10:31:50 2001
+++ linux-2.4.7-smp/kernel/softirq.c	Wed Jul 11 14:43:03 2001
@@ -371,6 +371,8 @@
 	}
 }
 
+static DECLARE_MUTEX_LOCKED(ksoftirqd_start);
+
 static int ksoftirqd(void * __bind_cpu)
 {
 	int bind_cpu = *(int *) __bind_cpu;
@@ -391,6 +393,7 @@
 	mb();
 
 	ksoftirqd_task(cpu) = current;
+	up(&ksoftirqd_start);
 
 	for (;;) {
 		if (!softirq_pending(cpu))
@@ -416,12 +419,8 @@
 		if (kernel_thread(ksoftirqd, (void *) &cpu,
 				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			printk("spawn_ksoftirqd() failed for cpu %d\n", cpu);
-		else {
-			while (!ksoftirqd_task(cpu_logical_map(cpu))) {
-				current->policy |= SCHED_YIELD;
-				schedule();
-			}
-		}
+		else
+			down(&ksoftirqd_start);
 	}
 
 	return 0;
