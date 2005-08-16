Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVHPXFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVHPXFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVHPXFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:05:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:6274 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750718AbVHPXFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:05:20 -0400
Date: Tue, 16 Aug 2005 16:05:12 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: George Anzinger <george@mvista.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [UPDATE PATCH] push rounding up of relative request to schedule_timeout()
Message-ID: <20050816230512.GD2806@us.ibm.com>
References: <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com> <20050804051434.GA4520@us.ibm.com> <42F24643.7080702@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F24643.7080702@mvista.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.2005 [09:45:55 -0700], George Anzinger wrote:
> Uh... PLEASE tell me you are NOT changing timespec_to_jiffies() (and 
> timeval_to_jiffies() to add 1.  This is NOT the right thing to do.  For 
> repeating times (see setitimer code) we need the actual time as we KNOW 
> where the jiffies edge is in the repeating case.  The +1 is needed ONLY 
> for the initial time, not the repeating time.
> 
> 
> See:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112208357906156&w=2

I followed that thread, George, but I think it's a different case with
schedule_timeout() [maybe this indicates drivers/other users should
maybe be using itimers, but I'll get to that in a sec].

With schedule_timeout(), we are just given a relative jiffies value. We
have no context as to which task is requesting the delay, per se,
meaning we don't (can't) know from the interface whether this is the
first delay in a sequence, or a brand new one, without changing all
users to have some sort of control structure. The callers of
schedule_timeout() don't even get a pointer to the timer added
internally.

So, adding 1 to all sleeps seems like it might be reasonable, as looping
sleeps probably need to use a different interface. I had worked a bit
ago on something like poll_event() with the kernel-janitors group, which
would abstract out the repeated sleeps. Basically wait_event() without
wait-queues... Maybe we could make such an interface just use itimers?
I've attached my old patch for poll_event(), just for reference.

My point, I guess, is that in the schedule_timeout() case, we don't know
where the jiffies edge is, as we either expire or receive a wait-queue
event/signal, we never mod_timer() the internal timer... So we have to
assume that we need to sleep the request. But maybe Roman's idea of
sleeping a certain number of jiffy edges is sufficient. I am not yet
convinced driver authors want/need such an interface, though, still
thinking it over.

Thanks for all the feedback,

Nish


--- 2.6.11-kj-v/include/linux/delay.h	2005-03-01 23:37:51.000000000 -0800
+++ 2.6.11-kj/include/linux/delay.h	2005-03-04 16:03:24.000000000 -0800
@@ -47,4 +47,106 @@ static inline void ssleep(unsigned int s
 	msleep(seconds * 1000);
 }
 
+/*
+ * poll_event* check if an @condition is true every @interval milliseconds,
+ * up to a @timeout maximum, if specified, else forever.
+ * The *_interruptible versions will sleep in TASK_INTERRUPTIBLE
+ * (instead of TASK_UNINTERRUPTIBLE) and will return early on signals
+ * Note that these interfaces are distinctly different than
+ * wait_event*() in two ways:
+ * 	1) No wait-queues
+ * 	2) Specify the time you want to sleep, not when you want to
+ * 	wake-up. Thus, callers should not add the current time to
+ * 	@timeout before calling, as it will be done by the macro.
+ */
+
+/**
+ * poll_event - check a condition at regular intervals
+ * @condition: Condition to check
+ * @interval: Number of milliseconds between checks
+ */
+#define poll_event(condition, interval)				\
+do {								\
+	while (!(condition))					\
+		msleep(interval);				\
+} while(0)
+
+/**
+ * poll_event_timeout - check a condition at regular intervals with a timeout
+ * @condition: Condition to check
+ * @interval: Number of milliseconds between checks
+ * @timeout: Maximum total number of milliseconds to take
+ * returns: 0, if condition caused return
+ * 	    -ETIME, if timeout
+ */
+#define poll_event_timeout(condition, interval, timeout)		\
+({									\
+	int __ret = 0;							\
+	unsigned long stop = jiffies + msecs_to_jiffies(timeout);	\
+ 									\
+	for (;;) {							\
+		if (condition)						\
+			break;						\
+		msleep(interval);					\
+		if (time_after(jiffies, stop)) {			\
+			__ret = -ETIME;					\
+ 			break;						\
+		}							\
+	}								\
+	__ret;								\
+})
+
+/**
+ * poll_event_interruptible - check a condition at regular intervals, returning early on signals
+ * @condition: Condition to check
+ * @interval: Number of milliseconds between checks
+ * returns: 0, if condition caused return
+ * 	    -EINTR, if a signal
+ */
+#define poll_event_interruptible(condition, interval)	\
+({							\
+	int __ret = 0;					\
+							\
+	for (;;) {					\
+		if (condition)				\
+			break;				\
+		msleep_interruptible(interval);		\
+		if (signal_pending(current)) {		\
+			__ret = -EINTR;			\
+ 			break;				\
+		}					\
+	}						\
+	__ret;
+})
+
+/**
+ * poll_event_interruptible_timeout - check a condition at regular intervals with a timeout, returning early on signals
+ * @condition: Condition to check
+ * @interval: Number of milliseconds between checks
+ * @timeout: Maximum total number of milliseconds to take
+ * returns 0, if condition caused return
+ * 	   -EINTR, if a signal
+ * 	   -ETIME, if timeout
+ */
+#define poll_event_interruptible_timeout(conditition, interval, timeout)	\
+({										\
+	int __ret = 0;								\
+	unsigned long stop = jiffies + msecs_to_jiffies(timeout);		\
+										\
+	for (;;) {								\
+		if (condition)							\
+			break;							\
+		msleep_interruptible(interval);					\
+		if (signal_pending(current)) {					\
+			__ret = -EINTR;						\
+			break;							\
+		}								\
+		if (time_after(jiffies, stop)) {				\
+			__ret = -ETIME;						\
+			break;							\
+		}								\
+	}									\
+	__ret;									\
+})
+
 #endif /* defined(_LINUX_DELAY_H) */
