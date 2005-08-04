Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVHDXXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVHDXXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVHDXVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:21:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:65433 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262701AbVHDXUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:20:46 -0400
Date: Fri, 5 Aug 2005 01:20:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] push rounding up of relative request to schedule_timeout()
In-Reply-To: <20050804191123.GA6614@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0508042347020.3728@scrub.home>
References: <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home>
 <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home>
 <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home>
 <20050804005147.GC4255@us.ibm.com> <Pine.LNX.4.61.0508041123220.3728@scrub.home>
 <20050804143339.GE4520@us.ibm.com> <Pine.LNX.4.61.0508042049450.3728@scrub.home>
 <20050804191123.GA6614@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 4 Aug 2005, Nishanth Aravamudan wrote:

> > What makes you think the comment is correct? This comment was added at 
> > 2.4.3, while schedule_timeout() has this behaviour since it was added at 
> > 2.1.127.
> 
> Fair enough. Should we change the comment?

It can't hurt to fix the comment.

> If a user requests schedule_timeout(HZ/100); which, if HZ is 1000, is 10
> jiffies, yes? But, since we are between ticks, we want to actually add
> that request to the next interval, not to the current one. Otherwise, we
> do have the possibility of returning early. Currently, we require
> callers to add the +1 to their request, and thus they only add it to the
> first one. The problem with my patch which pushed it to
> schedule_timeout(), is that we will do +1 to every request. I'm not
> sure, without some sort of "persistent" timeout control structure, how
> we get around that, though, in the schedule_timeout() case. Does that
> make any more sense?

I don't disagree, but please create some sane interfaces, e.g. something 
like below. This allows to first convert as much as possible 
schedule_timeout() users and then we can still change the 
schedule_timeout() interface.

bye, Roman

 include/linux/sched.h |   17 +++++++++++
 kernel/timer.c        |   71 +++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 78 insertions(+), 10 deletions(-)

Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2005-06-18 15:00:59.000000000 +0200
+++ linux-2.6/include/linux/sched.h	2005-08-04 23:42:43.000000000 +0200
@@ -182,9 +182,24 @@ extern void scheduler_tick(void);
 extern int in_sched_functions(unsigned long addr);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
-extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern void schedule_until(unsigned long expire) fastcall;
+extern int schedule_until_intr(unsigned long expire) fastcall;
+extern int schedule_until_unintr(unsigned long expire) fastcall;
+extern signed long schedule_timeout(signed long timeout) fastcall;
+extern int schedule_timeout_intr(signed long timeout) fastcall;
+extern int schedule_timeout_unintr(signed long timeout) fastcall;
 asmlinkage void schedule(void);
 
+static inline int schedule_timeout_msecs_intr(unsigned int timeout)
+{
+	return schedule_timeout_intr(msecs_to_jiffies(timeout));
+}
+
+static inline int schedule_timeout_msecs_unintr(unsigned int timeout)
+{
+	return schedule_timeout_unintr(msecs_to_jiffies(timeout));
+}
+
 struct namespace;
 
 /* Maximum number of active map areas.. This is a random (large) number */
Index: linux-2.6/kernel/timer.c
===================================================================
--- linux-2.6.orig/kernel/timer.c	2005-06-18 15:01:12.000000000 +0200
+++ linux-2.6/kernel/timer.c	2005-08-04 23:42:36.000000000 +0200
@@ -1049,6 +1049,67 @@ static void process_timeout(unsigned lon
 	wake_up_process((task_t *)__data);
 }
 
+fastcall __sched void schedule_until(unsigned long expire)
+{
+	struct timer_list timer;
+
+	init_timer(&timer);
+	timer.expires = expire;
+	timer.data = (unsigned long) current;
+	timer.function = process_timeout;
+
+	add_timer(&timer);
+	schedule();
+	del_singleshot_timer_sync(&timer);
+}
+EXPORT_SYMBOL(schedule_until);
+
+fastcall __sched int schedule_until_intr(unsigned long expire)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_until(expire);
+	return time_before(expire, jiffies);
+}
+EXPORT_SYMBOL(schedule_until_intr);
+
+fastcall __sched int schedule_until_unintr(unsigned long expire)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_until(expire);
+	return time_before(expire, jiffies);
+}
+EXPORT_SYMBOL(schedule_until_intr);
+
+fastcall __sched int schedule_timeout_intr(signed long timeout)
+{
+	unsigned long expire;
+	
+	set_current_state(TASK_INTERRUPTIBLE);
+	if (timeout >= MAX_SCHEDULE_TIMEOUT - 1) {
+		schedule();
+		return 1;
+	}
+	expire = jiffies + timeout + 1;
+	schedule_until(expire);
+	return time_before(expire, jiffies);
+}
+EXPORT_SYMBOL(schedule_timeout_intr);
+
+fastcall __sched int schedule_timeout_unintr(signed long timeout)
+{
+	unsigned long expire;
+
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	if (timeout >= MAX_SCHEDULE_TIMEOUT - 1) {
+		schedule();
+		return 1;
+	}
+	expire = jiffies + timeout + 1;
+	schedule_until(expire);
+	return time_before(expire, jiffies);
+}
+EXPORT_SYMBOL(schedule_timeout_unintr);
+
 /**
  * schedule_timeout - sleep until timeout
  * @timeout: timeout value in jiffies
@@ -1077,7 +1138,6 @@ static void process_timeout(unsigned lon
  */
 fastcall signed long __sched schedule_timeout(signed long timeout)
 {
-	struct timer_list timer;
 	unsigned long expire;
 
 	switch (timeout)
@@ -1112,14 +1172,7 @@ fastcall signed long __sched schedule_ti
 
 	expire = timeout + jiffies;
 
-	init_timer(&timer);
-	timer.expires = expire;
-	timer.data = (unsigned long) current;
-	timer.function = process_timeout;
-
-	add_timer(&timer);
-	schedule();
-	del_singleshot_timer_sync(&timer);
+	schedule_until(expire);
 
 	timeout = expire - jiffies;
 
