Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbSLLEwn>; Wed, 11 Dec 2002 23:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbSLLEwn>; Wed, 11 Dec 2002 23:52:43 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:45279 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S267377AbSLLEwl>; Wed, 11 Dec 2002 23:52:41 -0500
Date: Wed, 11 Dec 2002 21:04:51 -0800
From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.5.51] add wait_event() to <linux/completion.h>
To: linux-kernel@vger.kernel.org
Message-id: <3DF818F3.6050308@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_YeqJ5GjQU34PMJZ5Hxdh2w)"
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_YeqJ5GjQU34PMJZ5Hxdh2w)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Folk periodically talk about evolving the "struct completion"
support ... here's one:

   int wait_event (struct completion *x, signed long timeout_jiffies);

Returns zero if the event happened, nonzero if it timed out.
An example timeout action might be to cancel a request then
use wait_for_completion(x) to synchronize with that.

It's been behaving for me so far.  Questions from me:

- Is this appropriate to merge as-is?  The tradeoff I'm
   thinking of is code duplication; this patch avoids it
   ("smaller==better" rule-of-thumb) but maybe someone has
   real tuning knowledge, or a "standard" lk policy applies.
   Or there might be bugs or api transgressions.

- One routine was unavailable to modules; now exported.
   That seemed to just be an oversight.

This doesn't add an "interruptible wait" api mode, which
I'd expect some others might find a use for.  This patch
will let us clean up some dubious code in usbcore which
is more or less trying to do a wait_event().

Thanks in advance for any comments.

- Dave

--Boundary_(ID_YeqJ5GjQU34PMJZ5Hxdh2w)
Content-type: text/plain; name=sched.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=sched.patch

--- ./include/linux-dist/completion.h	Sun Dec  8 10:57:47 2002
+++ ./include/linux/completion.h	Mon Dec  9 15:11:51 2002
@@ -28,6 +28,7 @@
 }
 
 extern void FASTCALL(wait_for_completion(struct completion *));
+extern int FASTCALL(wait_timeout(struct completion *, signed long jiffies));
 extern void FASTCALL(complete(struct completion *));
 extern void FASTCALL(complete_all(struct completion *));
 
--- ./kernel-dist/ksyms.c	Sun Dec  8 10:57:48 2002
+++ ./kernel/ksyms.c	Mon Dec  9 15:13:47 2002
@@ -404,7 +404,9 @@ EXPORT_SYMBOL(autoremove_wake_function);
 
 /* completion handling */
 EXPORT_SYMBOL(wait_for_completion);
+EXPORT_SYMBOL(wait_timeout);
 EXPORT_SYMBOL(complete);
+EXPORT_SYMBOL(complete_all);
 
 /* The notion of irq probe/assignment is foreign to S/390 */
 
--- ./kernel-dist/sched.c	Sun Dec  8 10:57:48 2002
+++ ./kernel/sched.c	Mon Dec  9 15:34:36 2002
@@ -1204,6 +1204,11 @@ void complete_all(struct completion *x)
 
 void wait_for_completion(struct completion *x)
 {
+	wait_timeout (x, MAX_SCHEDULE_TIMEOUT);
+}
+
+int wait_timeout(struct completion *x, signed long timeout_jiffies)
+{
 	might_sleep();
 	spin_lock_irq(&x->wait.lock);
 	if (!x->done) {
@@ -1214,13 +1219,19 @@ void wait_for_completion(struct completi
 		do {
 			__set_current_state(TASK_UNINTERRUPTIBLE);
 			spin_unlock_irq(&x->wait.lock);
-			schedule();
+			timeout_jiffies = schedule_timeout(timeout_jiffies);
+			if (timeout_jiffies == 0) {
+				__remove_wait_queue(&x->wait, &wait);
+				/* caller should wait again */
+				return 1;
+			}
 			spin_lock_irq(&x->wait.lock);
 		} while (!x->done);
 		__remove_wait_queue(&x->wait, &wait);
 	}
 	x->done--;
 	spin_unlock_irq(&x->wait.lock);
+	return 0;
 }
 
 #define	SLEEP_ON_VAR				\

--Boundary_(ID_YeqJ5GjQU34PMJZ5Hxdh2w)--
