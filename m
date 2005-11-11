Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVKKWS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVKKWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVKKWS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:18:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:48906 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751263AbVKKWSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:18:55 -0500
Date: Fri, 11 Nov 2005 23:02:29 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Peter Staubach <staubach@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] poll(2) timeout values
Message-ID: <20051111220229.GA27438@alpha.home.local>
References: <437375DE.1070603@redhat.com> <1131642956.20099.39.camel@localhost.localdomain> <20051110210255.GF11266@alpha.home.local> <4374FCDD.4060805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4374FCDD.4060805@redhat.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 03:19:41PM -0500, Peter Staubach wrote:
> >I posted a different fix here about a month ago (but I sent it 3 times,
> >as it was twice wrong). Andrew was about to merge it in his tree but I
> >have not checked yet. It was different in the sense that it used
> >msecs_to_jiffies() to do the arithmetic in the best possible way 
> >depending
> >on the HZ value and the ints size. Most of the time (when 1000 % HZ == 
> >0),
> >it will simplify the operations to a single divide by a constant and
> >correctly check for integer overflows. Eg, with HZ=250, a simple 2 bits
> >right shift will replace a multiply followed by an divide.
> >
> >I'll check whether 2.6.14-mm1 has it, otherwise I can repost it.
> >
> 
> Yes, I remember the conversation.  I hadn't seen the final patch included
> anywhere, so I posted this one.
> 
> That said, I think that msecs_to_jiffies() can still suffer from overflows
> if (HZ % MSECS_PER_SEC) != 0 && (MSECS_PER_SEC % HZ) != 0.  I'd like to
> see the rest of your patch to see how this was worked around.

The original msecs_to_jiffies() had lots of overflow cases. That's why I
started by fixing it. Here it comes, along with the timeout change for
poll() and epoll(). However, I remember there was one thing to fix in the
epoll() and poll() patch below : it does not replace MAX_JIFFY_OFFSET with
MAX_SCHEDULE_TIMEOUT while it should because this is what indicates the
overflow. I believe I have another version somewhere, but I'll have to
search on my other machine.

> The patch that I posted does not suffer from overflow issues.

Agreed, but it will require some heavy operations that can be optimized away
in most cases (eg: HZ=1000 or HZ=250).

Cheers,
Willy

--- linux-2.6.14-rc2-mm1/include/linux/jiffies.h	Thu Sep 29 23:04:49 2005
+++ linux-2.6.14-rc2-mm1-jiffies2/include/linux/jiffies.h	Sat Oct  1 19:12:13 2005
@@ -246,6 +246,37 @@
 
 #endif
 
+
+/*
+ * We define MAX_MSEC_OFFSET and MAX_USEC_OFFSET as maximal values that can be
+ * accepted by msecs_to_jiffies() and usec_to_jiffies() respectively, without
+ * risking a multiply overflow. Those functions return MAX_JIFFY_OFFSET for
+ * arguments above those values.
+ */
+
+#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX - (MSEC_PER_SEC / HZ) + 1)
+#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX / (HZ / MSEC_PER_SEC))
+#else
+#  define MAX_MSEC_OFFSET \
+	((ULONG_MAX - (MSEC_PER_SEC - 1)) / HZ)
+#endif
+
+#if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
+#  define MAX_USEC_OFFSET \
+	(ULONG_MAX - (USEC_PER_SEC / HZ) + 1)
+#elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
+#  define MAX_USEC_OFFSET \
+	(ULONG_MAX / (HZ / USEC_PER_SEC))
+#else
+#  define MAX_USEC_OFFSET \
+	((ULONG_MAX - (USEC_PER_SEC - 1)) / HZ)
+#endif
+
+
 /*
  * Convert jiffies to milliseconds and back.
  *
@@ -276,27 +307,29 @@
 
 static inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
-	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+	if (MAX_MSEC_OFFSET < UINT_MAX && m > (unsigned int)MAX_MSEC_OFFSET)
 		return MAX_JIFFY_OFFSET;
 #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
-	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
+	return ((unsigned long)m + (MSEC_PER_SEC / HZ) - 1) /
+		(MSEC_PER_SEC / HZ);
 #elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
-	return m * (HZ / MSEC_PER_SEC);
+	return (unsigned long)m * (HZ / MSEC_PER_SEC);
 #else
-	return (m * HZ + MSEC_PER_SEC - 1) / MSEC_PER_SEC;
+	return ((unsigned long)m * HZ + MSEC_PER_SEC - 1) / MSEC_PER_SEC;
 #endif
 }
 
 static inline unsigned long usecs_to_jiffies(const unsigned int u)
 {
-	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
+	if (MAX_USEC_OFFSET < UINT_MAX && u > (unsigned int)MAX_USEC_OFFSET)
 		return MAX_JIFFY_OFFSET;
 #if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
-	return (u + (USEC_PER_SEC / HZ) - 1) / (USEC_PER_SEC / HZ);
+	return ((unsigned long)u + (USEC_PER_SEC / HZ) - 1) /
+		(USEC_PER_SEC / HZ);
 #elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
-	return u * (HZ / USEC_PER_SEC);
+	return (unsigned long)u * (HZ / USEC_PER_SEC);
 #else
-	return (u * HZ + USEC_PER_SEC - 1) / USEC_PER_SEC;
+	return ((unsigned long)u * HZ + USEC_PER_SEC - 1) / USEC_PER_SEC;
 #endif
 }
 

[ poll() patch - not to be merged ]

diff -purN linux-2.6.14-rc2-mm1/fs/select.c linux-2.6.14-rc2-mm1-poll/fs/select.c
--- linux-2.6.14-rc2-mm1/fs/select.c	Sat Sep 24 21:12:36 2005
+++ linux-2.6.14-rc2-mm1-poll/fs/select.c	Sat Sep 24 21:23:21 2005
@@ -469,7 +469,6 @@ asmlinkage long sys_poll(struct pollfd _
 {
 	struct poll_wqueues table;
 	int fdcount, err;
-	int overflow;
  	unsigned int i;
 	struct poll_list *head;
  	struct poll_list *walk;
@@ -486,22 +485,11 @@ asmlinkage long sys_poll(struct pollfd _
 		return -EINVAL;
 
 	/*
-	 * We compare HZ with 1000 to work out which side of the
-	 * expression needs conversion.  Because we want to avoid
-	 * converting any value to a numerically higher value, which
-	 * could overflow.
-	 */
-#if HZ > 1000
-	overflow = timeout_msecs >= jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
-#else
-	overflow = msecs_to_jiffies(timeout_msecs) >= MAX_SCHEDULE_TIMEOUT;
-#endif
-
-	/*
 	 * If we would overflow in the conversion or a negative timeout
-	 * is requested, sleep indefinitely.
+	 * is requested, sleep indefinitely. Note: msecs_to_jiffies checks
+	 * for the overflow.
 	 */
-	if (overflow || timeout_msecs < 0)
+	if (timeout_msecs < 0)
 		timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
 	else
 		timeout_jiffies = msecs_to_jiffies(timeout_msecs) + 1;



[ epoll() patch - not to be merged ]

diff -purN linux-2.6.14-rc2-mm1/fs/eventpoll.c linux-2.6.14-rc2-mm1-epoll/fs/eventpoll.c
--- linux-2.6.14-rc2-mm1/fs/eventpoll.c	Sat Sep 24 21:11:49 2005
+++ linux-2.6.14-rc2-mm1-epoll/fs/eventpoll.c	Sat Sep 24 21:20:10 2005
@@ -1502,12 +1502,11 @@ static int ep_poll(struct eventpoll *ep,
 	wait_queue_t wait;
 
 	/*
-	 * Calculate the timeout by checking for the "infinite" value ( -1 )
-	 * and the overflow condition. The passed timeout is in milliseconds,
-	 * that why (t * HZ) / 1000.
+	 * Calculate the timeout by checking for the "infinite" value ( < 0 )
+	 * and the overflow condition. The passed timeout is in milliseconds.
 	 */
-	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
-		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
+	jtimeout = (timeout < 0) ?
+	    MAX_SCHEDULE_TIMEOUT : msecs_to_jiffies(timeout);
 
 retry:
 	write_lock_irqsave(&ep->lock, flags);



