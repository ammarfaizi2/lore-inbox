Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVCOFhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVCOFhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVCOFhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:37:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:2241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262263AbVCOFg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:36:58 -0500
Date: Mon, 14 Mar 2005 21:36:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixes to mmtimer driver
Message-Id: <20050314213643.77d9a0fe.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503142105480.16582@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503142105480.16582@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> Fix the issue that the timer sometimes will not fire if the scheduled
>  time has already expired. Plus some simplifications and style changes.

Tosses a reject due to the itimer patches which went in last week.

***************
*** 430,436 ****
  		if (n > 20)
  			return 1;
  
- 	} while (mmtimer_setup(x->i, t->it_timer.expires));
  
  	return 0;
  }
--- 418,424 ----
  		if (n > 20)
  			return 1;
  
+ 	} while (!mmtimer_setup(x->i, t->it_timer.expires));
  
  	return 0;
  }

Which I fixed up as below.

Please, we've pushed in 14MB of patches in 11 days - it's really important
to make sure that we're working against the latest tree.


--- 25/drivers/char/mmtimer.c~fixes-to-mmtimer-driver	2005-03-14 21:33:04.000000000 -0800
+++ 25-akpm/drivers/char/mmtimer.c	2005-03-14 21:33:45.000000000 -0800
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
 
-	} while (mmtimer_setup(x->i, t->it.mmtimer.expires));
+	} while (!mmtimer_setup(x->i, t->it.mmtimer.expires));
 
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
 	timr->it.mmtimer.expires = when;
 
 	if (period == 0) {
-		if (mmtimer_setup(i, when)) {
+		if (!mmtimer_setup(i, when)) {
 			mmtimer_disable_int(-1, i);
 			posix_timer_event(timr, 0);
 			timr->it.mmtimer.expires = 0;
_

