Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSLLSnE>; Thu, 12 Dec 2002 13:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSLLSnE>; Thu, 12 Dec 2002 13:43:04 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:28910 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264806AbSLLSnD>; Thu, 12 Dec 2002 13:43:03 -0500
Date: Thu, 12 Dec 2002 10:53:17 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.5.51] add wait_event() to <linux/completion.h>
To: "Milton D. Miller II" <miltonm@realtime.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <3DF8DB1D.4000208@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_u5O2VD96tUutsE5nbyU8RQ)"
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212120746.gBC7kR482233@sullivan.realtime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_u5O2VD96tUutsE5nbyU8RQ)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Milton D. Miller II wrote:
>  __remove_wait_queue(&x->wait, &wait); 
> 
> should be under 
> spin_lock_irq(&x->wait.lock); 

Duh!  Updated patch is attached.

- Dave


--Boundary_(ID_u5O2VD96tUutsE5nbyU8RQ)
Content-type: text/plain; name=sched2.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=sched2.patch

--- ./include/linux-dist/completion.h	Mon Dec  9 23:49:44 2002
+++ ./include/linux/completion.h	Tue Dec 10 09:35:57 2002
@@ -28,6 +28,7 @@
 }
 
 extern void FASTCALL(wait_for_completion(struct completion *));
+extern int FASTCALL(wait_timeout(struct completion *, signed long jiffies));
 extern void FASTCALL(complete(struct completion *));
 extern void FASTCALL(complete_all(struct completion *));
 
--- ./kernel-dist/ksyms.c	Thu Dec 12 10:24:44 2002
+++ ./kernel/ksyms.c	Tue Dec 10 09:35:57 2002
@@ -404,7 +404,9 @@ EXPORT_SYMBOL(autoremove_wake_function);
 
 /* completion handling */
 EXPORT_SYMBOL(wait_for_completion);
+EXPORT_SYMBOL(wait_timeout);
 EXPORT_SYMBOL(complete);
+EXPORT_SYMBOL(complete_all);
 
 /* The notion of irq probe/assignment is foreign to S/390 */
 
--- ./kernel-dist/sched.c	Thu Dec 12 10:24:44 2002
+++ ./kernel/sched.c	Thu Dec 12 10:15:56 2002
@@ -1204,6 +1204,11 @@ void complete_all(struct completion *x)
 
 void wait_for_completion(struct completion *x)
 {
+	(void) wait_timeout (x, MAX_SCHEDULE_TIMEOUT);
+}
+
+int wait_timeout(struct completion *x, signed long timeout)
+{
 	might_sleep();
 	spin_lock_irq(&x->wait.lock);
 	if (!x->done) {
@@ -1214,13 +1219,18 @@ void wait_for_completion(struct completi
 		do {
 			__set_current_state(TASK_UNINTERRUPTIBLE);
 			spin_unlock_irq(&x->wait.lock);
-			schedule();
+			timeout = schedule_timeout(timeout);
 			spin_lock_irq(&x->wait.lock);
-		} while (!x->done);
+		} while (!x->done && timeout != 0);
 		__remove_wait_queue(&x->wait, &wait);
 	}
-	x->done--;
+	if (x->done) {
+		timeout = 1;
+		x->done--;
+	}
 	spin_unlock_irq(&x->wait.lock);
+	/* nonzero return means we timed out */
+	return timeout == 0;
 }
 
 #define	SLEEP_ON_VAR				\

--Boundary_(ID_u5O2VD96tUutsE5nbyU8RQ)--
