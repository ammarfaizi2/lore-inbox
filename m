Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVCOFKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVCOFKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVCOFKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:10:15 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:698 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262254AbVCOFHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:07:14 -0500
Date: Mon, 14 Mar 2005 21:07:12 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Fixes to mmtimer driver
Message-ID: <Pine.LNX.4.58.0503142105480.16582@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. this somehow did not make it to akpm and lkml when I posted it a
week ago.

Fix the issue that the timer sometimes will not fire if the scheduled
time has already expired. Plus some simplifications and style changes.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

Index: linux-2.6.11/drivers/char/mmtimer.c
===================================================================
--- linux-2.6.11.orig/drivers/char/mmtimer.c	2005-03-01 23:38:13.000000000 -0800
+++ linux-2.6.11/drivers/char/mmtimer.c	2005-03-09 09:48:40.000000000 -0800
@@ -71,11 +71,6 @@ static struct file_operations mmtimer_fo
 };

 /*
- * Comparators and their associated info.  Shub has
- * three comparison registers.
- */
-
-/*
  * We only have comparison registers RTC1-4 currently available per
  * node.  RTC0 is used by SAL.
  */
@@ -174,14 +169,10 @@ static void inline mmtimer_setup_int_2(u
  * This function must be called with interrupts disabled and preemption off
  * in order to insure that the setup succeeds in a deterministic time frame.
  * It will check if the interrupt setup succeeded.
- * mmtimer_setup will return the cycles that we were too late if the
- * initialization failed.
  */
 static int inline mmtimer_setup(int comparator, unsigned long expires)
 {

-	long diff;
-
 	switch (comparator) {
 	case 0:
 		mmtimer_setup_int_0(expires);
@@ -194,17 +185,14 @@ static int inline mmtimer_setup(int comp
 		break;
 	}
 	/* We might've missed our expiration time */
-        diff = rtc_time() - expires;
-	if (diff > 0) {
-		if (mmtimer_int_pending(comparator)) {
-			/* We'll get an interrupt for this once we're done */
-                        return 0;
-		}
-		/* Looks like we missed it */
-		return diff;
-        }
+	if (rtc_time() < expires)
+		return 1;

-	return 0;
+	/*
+	 * If an interrupt is already pending then its okay
+	 * if not then we failed
+	 */
+	return mmtimer_int_pending(comparator);
 }

 static int inline mmtimer_disable_int(long nasid, int comparator)
@@ -430,7 +418,7 @@ static int inline reschedule_periodic_ti
 		if (n > 20)
 			return 1;

-	} while (mmtimer_setup(x->i, t->it_timer.expires));
+	} while (!mmtimer_setup(x->i, t->it_timer.expires));

 	return 0;
 }
@@ -594,9 +582,15 @@ static int sgi_timer_set(struct k_itimer

 	if (flags & TIMER_ABSTIME) {
 		struct timespec n;
+		unsigned long now;

 		getnstimeofday(&n);
-		when -= timespec_to_ns(n);
+		now = timespec_to_ns(n);
+		if (when > now)
+			when -= now;
+		else
+			/* Fire the timer immediately */
+			when = 0;
 	}

 	/*
@@ -644,7 +638,7 @@ retry:
 	timr->it_timer.expires = when;

 	if (period == 0) {
-		if (mmtimer_setup(i, when)) {
+		if (!mmtimer_setup(i, when)) {
 			mmtimer_disable_int(-1, i);
 			posix_timer_event(timr, 0);
 			timr->it_timer.expires = 0;
