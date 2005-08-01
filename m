Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVHATgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVHATgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVHATgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:36:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:39343 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261199AbVHATg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:36:29 -0400
Date: Mon, 1 Aug 2005 12:35:22 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: [UPDATE PATCH] Add schedule_timeout_{intr,unintr}{,_msecs}() interfaces
Message-ID: <20050801193522.GA24909@us.ibm.com>
References: <1122116986.3582.7.camel@localhost.localdomain> <Pine.LNX.4.61.0507231340070.3743@scrub.home> <1122123085.3582.13.camel@localhost.localdomain> <Pine.LNX.4.61.0507231456000.3728@scrub.home> <20050723164310.GD4951@us.ibm.com> <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507310046590.3728@scrub.home>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.2005 [01:35:35 +0200], Roman Zippel wrote:
> Hi,
> 
> On Wed, 27 Jul 2005, Nishanth Aravamudan wrote:
> 
> > > > My goal is to distinguish between these cases in sleeping-logic:
> > > > 
> > > > 1) tick-oriented
> > > > 	use schedule_timeout(), add_timer(), etc.
> > > > 
> > > > 2) time-oriented
> > > > 	use schedule_timeout_msecs()
> > > 
> > > There is _no_ difference, the scheduler is based on ticks. Even if we soon 
> > > have different time sources, the scheduler will continue to measure the 
> > > time in ticks and for a simple reason - portability. Jiffies _are_ simple, 
> > > don't throw that away.
> > 
> > I agree that from an internal perspective there is no difference, but
> > from an *interface* perspective they are hugely different, simply on the
> > basis that one uses human-time units and one does not.
> > 
> > I guess we must continue to agree to disagree.
> 
> I'm not really sure, what you disagree about.
> 1 HZ is about one second, which I don't think is such a difficult concept. 
> I already said wrapper functions are fine and for anything smaller than 
> HZ/2 it's probably a good idea nowadays.
> My main point is to keep the core functionality in jiffies and provide 
> some wrapper functions. What exactly do you disagree here on?

Well, I was under the impression you were against the patch I had sent
to add some millisecond wrappers (which did *not* change any core
functionality) for schedule_timeout(). If that isn't the case, I'm
sorry, I misunderstood.  Here's the patch again. I'm still open to
feedback.

Thanks,
Nish

Description: Add wrappers for interruptible/uninterruptible
schedule_timeout() callers. Also add millisecond equivalents. I tried to
make the names a bit more reasonable to prevent long lines.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 include/linux/sched.h |    7 +++
 kernel/timer.c        |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff -urpN 2.6.13-rc4/include/linux/sched.h 2.6.13-rc4-dev/include/linux/sched.h
--- 2.6.13-rc4/include/linux/sched.h	2005-07-29 14:11:49.000000000 -0700
+++ 2.6.13-rc4-dev/include/linux/sched.h	2005-08-01 11:20:31.000000000 -0700
@@ -181,8 +181,13 @@ extern void scheduler_tick(void);
 /* Is this address in the __sched functions? */
 extern int in_sched_functions(unsigned long addr);
 
-#define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT_MSECS	UINT_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern signed long schedule_timeout_intr(signed long timeout);
+extern signed long schedule_timeout_unintr(signed long timeout);
+extern unsigned int schedule_timeout_msecs_intr(unsigned int timeout_msecs);
+extern unsigned int schedule_timeout_msecs_unintr(unsigned int timeout_msecs);
 asmlinkage void schedule(void);
 
 struct namespace;
diff -urpN 2.6.13-rc4/kernel/timer.c 2.6.13-rc4-dev/kernel/timer.c
--- 2.6.13-rc4/kernel/timer.c	2005-07-29 14:11:49.000000000 -0700
+++ 2.6.13-rc4-dev/kernel/timer.c	2005-08-01 12:31:53.000000000 -0700
@@ -1153,6 +1153,95 @@ fastcall signed long __sched schedule_ti
 
 EXPORT_SYMBOL(schedule_timeout);
 
+signed long __sched schedule_timeout_intr(signed long timeout)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	return schedule_timeout(timeout);
+}
+
+EXPORT_SYMBOL(schedule_timeout_intr);
+
+signed long __sched schedule_timeout_unintr(signed long timeout)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	return schedule_timeout(timeout);
+}
+
+EXPORT_SYMBOL(schedule_timeout_unintr);
+
+/*
+ * schedule_timeout_msecs - sleep until timeout
+ * @timeout_msecs: timeout value in milliseconds
+ *
+ * A human-time (but otherwise identical) alternative to
+ * schedule_timeout() The state, therefore, *does* need to be set before
+ * calling this function, but this function should *never* be called
+ * directly. Use the nice wrappers, schedule_{interruptible,
+ * uninterruptible}_timeout_msecs().
+ *
+ * See the comment for schedule_timeout() for details.
+ */
+unsigned int __sched schedule_timeout_msecs(unsigned int timeout_msecs)
+{
+	unsigned long expire_jifs;
+
+	if (timeout_msecs == MAX_SCHEDULE_TIMEOUT_MSECS) {
+		expire_jifs = MAX_SCHEDULE_TIMEOUT;
+	} else {
+		/*
+		 * msecs_to_jiffies() is a unit conversion, which truncates
+		 * (rounds down), so we need to add 1.
+		 */
+		expire_jifs = msecs_to_jiffies(timeout_msecs) + 1;
+	}
+
+	expire_jifs = schedule_timeout(expire_jifs);
+
+	/*
+	 * don't need to add 1 here, even though there is truncation,
+	 * because we will add 1 if/when the value is sent back in
+	 */
+	return jiffies_to_msecs(expire_jifs);
+}
+
+/**
+ * schedule_timeout_msecs_interruptible - sleep until timeout,
+ *						 wait-queue event, or signal
+ * @timeout_msecs: timeout value in milliseconds
+ *
+ * A nice wrapper for the common
+ * set_current_state()/schedule_timeout_msecs() usage.  The state,
+ * therefore, does *not* need to be set before calling this function.
+ *
+ * See the comment for schedule_timeout() for details.
+ */
+unsigned int __sched schedule_timeout_msecs_intr(unsigned int timeout_msecs)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	return schedule_timeout_msecs(timeout_msecs);
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_msecs_intr);
+
+/**
+ * schedule_timeout_msecs_uninterrutible - sleep until timeout or
+ * 						wait-queue event
+ * @timeout_msecs: timeout value in milliseconds
+ *
+ * A nice wrapper for the common
+ * set_current_state()/schedule_timeout_msecs() usage.  The state,
+ * therefore, does *not* need to be set before calling this function.
+ *
+ * See the comment for schedule_timeout() for details.
+ */
+unsigned int __sched schedule_timeout_msecs_unintr(unsigned int timeout_msecs)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	return schedule_timeout_msecs(timeout_msecs);
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_msecs_unintr);
+
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
