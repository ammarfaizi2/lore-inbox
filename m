Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130692AbQKRBcL>; Fri, 17 Nov 2000 20:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbQKRBcB>; Fri, 17 Nov 2000 20:32:01 -0500
Received: from smartmail.smartweb.net ([207.202.14.198]:63504 "EHLO
	smartmail.smartweb.net") by vger.kernel.org with ESMTP
	id <S130692AbQKRBbu>; Fri, 17 Nov 2000 20:31:50 -0500
Message-ID: <3A15D4F5.B39D61BD@dm.ultramaster.com>
Date: Fri, 17 Nov 2000 20:01:41 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] semaphore fairness patch against test11-pre6
Content-Type: multipart/mixed;
 boundary="------------53C4593FE355E8AC56FE8732"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------53C4593FE355E8AC56FE8732
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Linus et al,

I've applied your semaphore fairness patch (slightly fixed) below.  It
fixes my original bug report of vmstat, ps etc. stalls waiting for the
mmap_sem.  I can now run my memory 'hog' processes and actually see
vmstat update every second even under heavy memory pressure.  More
importantly, ps works so I can find the pid to kill.  I'm no expert in
checking for races, but I went over all (I think) the 2 process cases as
well as I could and they seem to look ok to me, but what do I know.  I
know someone else reported it didn't fix the problem, but perhaps that's
some other issue.

I ran many 'ps' (20?) in the background trying to simulate many process
contention, and everything still worked fine.  I've run some other
stress tests too (dbench, my own I/O throughput test etc) and so far
all's well (famous last words).

If you can find the time to check this out more completely, I recommend
it, because it seems like a great improvement to be able to accurately
see vmstat numbers in times of system load.  I hope the other side
effects are beneficial as well :-)

The change to the patch was that you had 'if (sleepers > 1)' when
obviously you meant 'if (sem->sleepers > 1)'...

Here's your patch again (also attached in case of mangling):

--- linux/arch/i386/kernel/semaphore.c	2000/11/16 19:58:26	1.3
+++ linux/arch/i386/kernel/semaphore.c	2000/11/17 23:12:48
@@ -64,6 +64,14 @@
 
 	spin_lock_irq(&semaphore_lock);
 	sem->sleepers++;
+
+	/*
+	 * Are there other people waiting for this?
+	 * They get to go first.
+	 */
+	if (sem->sleepers > 1)
+		goto inside;
+
 	for (;;) {
 		int sleepers = sem->sleepers;
 
@@ -76,6 +84,7 @@
 			break;
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
+inside:
 		spin_unlock_irq(&semaphore_lock);
 
 		schedule();
--------------53C4593FE355E8AC56FE8732
Content-Type: text/plain; charset=us-ascii;
 name="sem-patch.test11-pre6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sem-patch.test11-pre6"

Index: linux/arch/i386/kernel/semaphore.c
===================================================================
RCS file: /home/kernel/cvs_master/linux/arch/i386/kernel/semaphore.c,v
retrieving revision 1.3
diff -u -r1.3 semaphore.c
--- linux/arch/i386/kernel/semaphore.c	2000/11/16 19:58:26	1.3
+++ linux/arch/i386/kernel/semaphore.c	2000/11/17 23:12:48
@@ -64,6 +64,14 @@
 
 	spin_lock_irq(&semaphore_lock);
 	sem->sleepers++;
+
+	/*
+	 * Are there other people waiting for this?
+	 * They get to go first.
+	 */
+	if (sem->sleepers > 1)
+		goto inside;
+
 	for (;;) {
 		int sleepers = sem->sleepers;
 
@@ -76,6 +84,7 @@
 			break;
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
+inside:
 		spin_unlock_irq(&semaphore_lock);
 
 		schedule();

--------------53C4593FE355E8AC56FE8732--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
