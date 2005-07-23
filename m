Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVGWQYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVGWQYn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 12:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVGWQYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 12:24:43 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36039 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261876AbVGWQYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 12:24:41 -0400
Date: Sat, 23 Jul 2005 09:23:40 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, domen@coderock.org, linux-kernel@vger.kernel.org,
       clucas@rotomalug.org
Subject: [UPDATE PATCH] Add schedule_timeout_{interruptible,uninterruptible}_msecs() interfaces
Message-ID: <20050723162338.GA4951@us.ibm.com>
References: <20050707213138.184888000@homer> <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain> <20050723010801.GA4366@us.ibm.com> <20050723123000.1808f3c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050723123000.1808f3c4.akpm@osdl.org>
X-Operating-System: Linux 2.6.13-rc3-mm1 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.2005 [12:30:00 +1000], Andrew Morton wrote:
> Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> >
> > 
> > +/*
> > + * schedule_timeout_msecs - sleep until timeout
> > + * @timeout_msecs: timeout value in milliseconds
> > + *
> > + * A human-time (but otherwise identical) alternative to
> > + * schedule_timeout() The state, therefore, *does* need to be set before
> > + * calling this function, but this function should *never* be called
> > + * directly. Use the nice wrappers, schedule_{interruptible,
> > + * uninterruptible}_timeout_msecs().
> > + *
> > + * See the comment for schedule_timeout() for details.
> > + */
> > +inline unsigned int __sched schedule_timeout_msecs(unsigned int timeout_msecs)
> > +{
> 
> Making this inline will add more kernel text.    Can't we uninline it?

Uninlined in the latest version (see below).

> I'm surprised that this function is not implemented as a call to the
> existing schedule_timeout()?

Well, I was considering doing that, but I tried to make this new
interface a little more sane. I don't think we need to worry about
signedness of the parameter any more (and thus we don't need to consider
returning a negative value). Calling schedule_timeout() underneath
schedule_timeout_msecs() will require us to do those conditional checks;
I guess this isn't criticial in a sleeping path.

Also, I would need to make some modifications (not critical, really), so
that MAX_SCHEDULE_TIMEOUT_MSECS would map 1:1 to MAX_SCHEDULE_TIMEOUT
(which is in jiffies).

But I'm happy to change this, also done below -- does that map better to
what you were thinking?

> > +	init_timer(&timer);
> > +	timer.expires = expire_jifs;
> > +	timer.data = (unsigned long) current;
> > +	timer.function = process_timeout;
> 
> hm, if we add the needed typecast to TIMER_INITIALIZER() the above could be
> 
> 	timer = TIMER_INITIALIZER(process_timeout, expire_jifs,
> 				(unsigned long)current);

Done as well below.

Thanks,
Nish

Description: Add millisecond wrapper for schedule_timeout(),
schedule_timeout_msecs(). Add wrappers for interruptible/uninterruptible
schedule_timeout_msecs() callers.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 include/linux/sched.h |    7 ++++
 kernel/timer.c        |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff -urpN 2.6.13-rc3/include/linux/sched.h 2.6.13-rc3-new_interfaces/include/linux/sched.h
--- 2.6.13-rc3/include/linux/sched.h	2005-07-13 15:52:14.000000000 -0700
+++ 2.6.13-rc3-new_interfaces/include/linux/sched.h	2005-07-22 18:06:36.000000000 -0700
@@ -181,8 +181,13 @@ extern void scheduler_tick(void);
 /* Is this address in the __sched functions? */
 extern int in_sched_functions(unsigned long addr);
 
-#define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT_MSECS	UINT_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern unsigned int schedule_timeout_msecs_interruptible
+						(unsigned int timeout_msecs);
+extern unsigned int schedule_timeout_msecs_uninterruptible
+						(unsigned int timeout_msecs);
 asmlinkage void schedule(void);
 
 struct namespace;
diff -urpN 2.6.13-rc3/kernel/timer.c 2.6.13-rc3-new_interfaces/kernel/timer.c
--- 2.6.13-rc3/kernel/timer.c	2005-07-13 15:52:14.000000000 -0700
+++ 2.6.13-rc3-new_interfaces/kernel/timer.c	2005-07-23 09:20:51.000000000 -0700
@@ -1153,6 +1153,81 @@ fastcall signed long __sched schedule_ti
 
 EXPORT_SYMBOL(schedule_timeout);
 
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
+unsigned int __sched schedule_timeout_msecs_interruptible
+						(unsigned int timeout_msecs)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	return schedule_timeout_msecs(timeout_msecs);
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_msecs_interruptible);
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
+unsigned int __sched schedule_timeout_msecs_uninterruptible
+						(unsigned int timeout_msecs)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	return schedule_timeout_msecs(timeout_msecs);
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_msecs_uninterruptible);
+
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
