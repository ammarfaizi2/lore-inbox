Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263285AbTCUGaK>; Fri, 21 Mar 2003 01:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263287AbTCUGaJ>; Fri, 21 Mar 2003 01:30:09 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:46529 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S263285AbTCUGaI>; Fri, 21 Mar 2003 01:30:08 -0500
Message-ID: <3E7AB696.40204@pacbell.net>
Date: Thu, 20 Mar 2003 22:52:06 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.name>
CC: linux-kernel@vger.kernel.org
Subject: Re: question on macros in wait.h
Content-Type: multipart/mixed;
 boundary="------------000900040803020806070700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000900040803020806070700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


  > is there some deeper reason that there's no macro for waiting
  > uninterruptablely with a timeout? Or did just nobody feel a need
  > as yet?

Those macros seem to have moved out of <linux/sched.h> (2.4)
and wait_event_interruptible_timeout() was added about 6
months ago; the changelog entry says it was for smbfs.
So I'd guess "no need yet".

Here's an updated version of your patch, now using the same
calling convention that the other two "can return 'early'"
calls there provide.  It's behaved in my testing, to replace the
chaos in the usb synchronous call wrappers.

- Dave


--------------000900040803020806070700
Content-Type: text/plain;
 name="sched3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched3.patch"

--- 1.7/include/linux/wait.h	Sun Nov 17 12:30:14 2002
+++ edited/include/linux/wait.h	Thu Mar 20 21:57:52 2003
@@ -173,6 +173,32 @@
 	__ret;								\
 })
 
+#define __wait_event_timeout(wq, condition, ret)			\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue(&wq, &__wait);					\
+	for (;;) {							\
+		set_current_state(TASK_UNINTERRUPTIBLE);		\
+		if (condition)						\
+			break;						\
+		ret = schedule_timeout(ret);				\
+		if (!ret)						\
+			break;						\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define wait_event_timeout(wq, condition, timeout)			\
+({									\
+	long __ret = timeout;						\
+	if (!(condition))						\
+		__wait_event_timeout(wq, condition, __ret);		\
+	__ret;								\
+})
+	
 #define __wait_event_interruptible_timeout(wq, condition, ret)		\
 do {									\
 	wait_queue_t __wait;						\

--------------000900040803020806070700--

