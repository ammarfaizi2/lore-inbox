Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSGVKsL>; Mon, 22 Jul 2002 06:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSGVKsL>; Mon, 22 Jul 2002 06:48:11 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20488 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316674AbSGVKsH>; Mon, 22 Jul 2002 06:48:07 -0400
Message-ID: <3D3BE257.40401@evision.ag>
Date: Mon, 22 Jul 2002 12:45:43 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 sched
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000006040006060602090206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000006040006060602090206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Don't use __wait_event_interruptible() use wait_event_interruptible()
instead.
- Remove unused get_current_user() macro.

--------------000006040006060602090206
Content-Type: text/plain;
 name="sched-2.5.27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-2.5.27.diff"

diff -urN linux-2.5.27/drivers/scsi/sg.c linux/drivers/scsi/sg.c
--- linux-2.5.27/drivers/scsi/sg.c	2002-07-20 21:11:17.000000000 +0200
+++ linux/drivers/scsi/sg.c	2002-07-22 00:46:39.000000000 +0200
@@ -295,10 +295,9 @@
 	}
 	if (sdp->headfp && (flags & O_NONBLOCK))
             goto error_out;
-        res = 0; 
-	__wait_event_interruptible(sdp->o_excl_wait,
-	       ((sdp->headfp || sdp->exclude) ? 0 : (sdp->exclude = 1)),
-                                   res);
+
+	res = wait_event_interruptible(sdp->o_excl_wait,
+	       ((sdp->headfp || sdp->exclude) ? 0 : (sdp->exclude = 1)));
         if (res) {
             retval = res; /* -ERESTARTSYS because signal hit process */
 	    goto error_out;
@@ -307,15 +306,14 @@
     else if (sdp->exclude) { /* some other fd has an exclusive lock on dev */
         if (flags & O_NONBLOCK)
             goto error_out;
-        res = 0; 
-        __wait_event_interruptible(sdp->o_excl_wait, (! sdp->exclude), res);
+        res = wait_event_interruptible(sdp->o_excl_wait, (! sdp->exclude));
         if (res) {
             retval = res; /* -ERESTARTSYS because signal hit process */
 	    goto error_out;
         }
     }
     if (sdp->detached) {
-    	retval = -ENODEV;
+	retval = -ENODEV;
 	goto error_out;
     }
     if (! sdp->headfp) { /* no existing opens on this device */
@@ -400,9 +398,8 @@
         if (filp->f_flags & O_NONBLOCK)
             return -EAGAIN;
 	while (1) {
-	    res = 0;  /* following is a macro that beats race condition */
-	    __wait_event_interruptible(sfp->read_wait, (sdp->detached || 
-		    (srp = sg_get_rq_mark(sfp, req_pack_id))), res);
+	    res = wait_event_interruptible(sfp->read_wait, (sdp->detached ||
+		    (srp = sg_get_rq_mark(sfp, req_pack_id))));
 	    if (sdp->detached)
 		return -ENODEV;
 	    if (0 == res)
@@ -783,16 +780,14 @@
 		return -ENODEV;
 	    if(! scsi_block_when_processing_errors(sdp->device) )
 		return -ENXIO;
-	    result = verify_area(VERIFY_WRITE, (void *)arg, SZ_SG_IO_HDR);
-	    if (result) return result;
 	    result = sg_new_write(sfp, (const char *)arg, SZ_SG_IO_HDR,
 				  blocking, read_only, &srp);
-	    if (result < 0) return result;
+	    if (result < 0)
+		    return result;
 	    srp->sg_io_owned = 1;
 	    while (1) {
-		result = 0;  /* following macro to beat race condition */
-		__wait_event_interruptible(sfp->read_wait,
-		       (sdp->detached || sfp->closed || srp->done), result);
+		result = wait_event_interruptible(sfp->read_wait,
+		       (sdp->detached || sfp->closed || srp->done));
 		if (sdp->detached)
 		    return -ENODEV;
 		if (sfp->closed)
diff -urN linux-2.5.27/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.27/include/linux/sched.h	2002-07-20 21:11:07.000000000 +0200
+++ linux/include/linux/sched.h	2002-07-22 00:52:37.000000000 +0200
@@ -236,11 +236,6 @@
 	uid_t uid;
 };
 
-#define get_current_user() ({ 				\
-	struct user_struct *__user = current->user;	\
-	atomic_inc(&__user->__count);			\
-	__user; })
-
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
@@ -679,27 +674,6 @@
 	__wait_event(wq, condition);					\
 } while (0)
 
-#define __wait_event_interruptible(wq, condition, ret)			\
-do {									\
-	wait_queue_t __wait;						\
-	init_waitqueue_entry(&__wait, current);				\
-									\
-	add_wait_queue(&wq, &__wait);					\
-	for (;;) {							\
-		set_current_state(TASK_INTERRUPTIBLE);			\
-		if (condition)						\
-			break;						\
-		if (!signal_pending(current)) {				\
-			schedule();					\
-			continue;					\
-		}							\
-		ret = -ERESTARTSYS;					\
-		break;							\
-	}								\
-	current->state = TASK_RUNNING;					\
-	remove_wait_queue(&wq, &__wait);				\
-} while (0)
-	
 /*
  * Must be called with the spinlock in the wait_queue_head_t held.
  */
@@ -722,8 +696,25 @@
 #define wait_event_interruptible(wq, condition)				\
 ({									\
 	int __ret = 0;							\
-	if (!(condition))						\
-		__wait_event_interruptible(wq, condition, __ret);	\
+	if (!(condition)) {						\
+		wait_queue_t __wait;					\
+		init_waitqueue_entry(&__wait, current);			\
+									\
+		add_wait_queue(&wq, &__wait);				\
+		for (;;) {						\
+			set_current_state(TASK_INTERRUPTIBLE);		\
+			if (condition)					\
+				break;					\
+			if (!signal_pending(current)) {			\
+				schedule();				\
+				continue;				\
+			}						\
+			__ret = -ERESTARTSYS;				\
+			break;						\
+		}							\
+		current->state = TASK_RUNNING;				\
+		remove_wait_queue(&wq, &__wait);			\
+	}								\
 	__ret;								\
 })
 
diff -urN linux-2.5.27/net/irda/af_irda.c linux/net/irda/af_irda.c
--- linux-2.5.27/net/irda/af_irda.c	2002-07-20 21:11:12.000000000 +0200
+++ linux/net/irda/af_irda.c	2002-07-22 00:48:04.000000000 +0200
@@ -2373,9 +2373,8 @@
 			add_timer(&(self->watchdog));
 
 			/* Wait for IR-LMP to call us back */
-			__wait_event_interruptible(self->query_wait,
-			   (self->cachediscovery!=NULL || self->errno==-ETIME),
-						   ret);
+			ret = wait_event_interruptible(self->query_wait,
+			   (self->cachediscovery!=NULL || self->errno==-ETIME));
 
 			/* If watchdog is still activated, kill it! */
 			if(timer_pending(&(self->watchdog)))

--------------000006040006060602090206--

