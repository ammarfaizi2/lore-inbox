Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269100AbUIBWKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbUIBWKn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUIBWIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:08:32 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6528
	"EHLO x30.random") by vger.kernel.org with ESMTP id S269234AbUIBWEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:04:06 -0400
Date: Fri, 3 Sep 2004 00:03:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       rlrevell@joe-job.com, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040902220301.GA18212@x30.random>
References: <20040713213847.GH974@dualathlon.random> <20040713145424.1217b67f.akpm@osdl.org> <20040713220103.GJ974@dualathlon.random> <20040713152532.6df4a163.akpm@osdl.org> <20040713223701.GM974@dualathlon.random> <20040713154448.4d29e004.akpm@osdl.org> <20040713225305.GO974@dualathlon.random> <20040713160628.596b96a3.akpm@osdl.org> <20040713231803.GP974@dualathlon.random> <20040719115952.GA13564@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719115952.GA13564@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Mon, Jul 19, 2004 at 01:59:52PM +0200, Ingo Molnar wrote:
> yes. Btw., i'm not sure whether you've noticed but last week i've also
> created a 'clean' variant of the patch. The latest version against -mm
> is:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-clean-2.6.7-mm7-H4
> 
> this one doesnt have any of the debugging/development helpers and
> switches. I have still made it a .config option. Note how minimal the
> patch became this way.

as said in a part of a previous email might_sleep() just like BUG() can
be defined to noop.

cond_resched() is the API to use.

if you're scared that there are too many cond_resched (I'm not scared
and people should enable them anyways if they make a difference, they
still should be less than the number of spin_unlocks with preempt
enabled), then you should add a cond_resched_costly and add a config
option that turns it off. I think you don't even need to add the config
option, you can define cond_resched_costly as cond_resched, and to just
use it to mark the places that might be expensive.

Then you should change cond_resched to call might_sleep in the else
branch (as I discussed with Andrew last month).

this was the core of the patch I was playing with last month which
should be still valid and it solves the preprocessor issues with
cond_resched (and I hope the bug was not in the below code ;)

could you modify your patch accordingly? thanks!

Index: linux-2.5/include/linux/kernel.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/linux/kernel.h,v
retrieving revision 1.53
diff -u -p -r1.53 kernel.h
--- linux-2.5/include/linux/kernel.h	27 Jun 2004 17:55:19 -0000	1.53
+++ linux-2.5/include/linux/kernel.h	13 Jul 2004 02:19:43 -0000
@@ -48,12 +48,23 @@ struct completion;
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
 void __might_sleep(char *file, int line);
 #define might_sleep() __might_sleep(__FILE__, __LINE__)
-#define might_sleep_if(cond) do { if (unlikely(cond)) might_sleep(); } while (0)
 #else
 #define might_sleep() do {} while(0)
-#define might_sleep_if(cond) do {} while (0)
 #endif
 
+#define need_resched() unlikely(test_thread_flag(TIF_NEED_RESCHED))
+
+extern void __cond_resched(void);
+#define cond_resched()				\
+do {						\
+	if (need_resched())			\
+		__cond_resched();		\
+	else					\
+		might_sleep();			\
+} while (0)
+
+#define cond_resched_if(cond) do { if (unlikely(cond)) cond_resched(); } while (0)
+
 #define abs(x) ({				\
 		int __x = (x);			\
 		(__x < 0) ? -__x : __x;		\
Index: linux-2.5/include/linux/sched.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/linux/sched.h,v
retrieving revision 1.245
diff -u -p -r1.245 sched.h
--- linux-2.5/include/linux/sched.h	2 Jul 2004 17:31:23 -0000	1.245
+++ linux-2.5/include/linux/sched.h	13 Jul 2004 02:33:12 -0000
@@ -1012,18 +1013,6 @@ static inline int signal_pending(struct 
 {
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
-  
-static inline int need_resched(void)
-{
-	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
-}
-
-extern void __cond_resched(void);
-static inline void cond_resched(void)
-{
-	if (need_resched())
-		__cond_resched();
-}
 
 /*
  * cond_resched_lock() - if a reschedule is pending, drop the given lock,
