Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUEKWsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUEKWsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 18:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUEKWrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 18:47:15 -0400
Received: from fmr06.intel.com ([134.134.136.7]:16610 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265025AbUEKWq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 18:46:57 -0400
Message-ID: <40A157CB.1010100@linux.intel.com>
Date: Tue, 11 May 2004 15:46:35 -0700
From: Geoff Gustafson <geoff@linux.jf.intel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, mingo@elte.hu, kenneth.w.chen@intel.com,
       hch@infradead.org
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
 > <anal>del_singleshot_timer_sync</anal>
 >
 > I vote we leave it up to Ken.  But please, not del_timer_kenneth().

Despite your markup language, I thought keeping the 'sync' sounded like
a good idea, since that's the function it's replacing.

Here's a patch. I've done a small amount of testing with a 4p machine.
I've at least seen that the average call to singleshot is down around 90
cycles, pretty similar/expected. We'll test on the original platform and
post results.

- Geoff

* I am in a transitional period w/ email clients and can't seem to use
any of them properly. Sorry for the dups, etc.

diff -Naur fresh/fs/aio.c timer/fs/aio.c
--- fresh/fs/aio.c	Sun May  9 19:32:29 2004
+++ timer/fs/aio.c	Tue May 11 15:14:47 2004
@@ -793,7 +793,7 @@

  static inline void clear_timeout(struct timeout *to)
  {
-	del_timer_sync(&to->timer);
+	del_singleshot_timer_sync(&to->timer);
  }

  static int read_events(struct kioctx *ctx,
diff -Naur fresh/include/linux/timer.h timer/include/linux/timer.h
--- fresh/include/linux/timer.h	Sun May  9 19:32:54 2004
+++ timer/include/linux/timer.h	Tue May 11 14:21:36 2004
@@ -88,8 +88,10 @@

  #ifdef CONFIG_SMP
    extern int del_timer_sync(struct timer_list * timer);
+  extern int del_singleshot_timer_sync(struct timer_list * timer);
  #else
  # define del_timer_sync(t) del_timer(t)
+# define del_singleshot_timer_sync(t) del_timer(t)
  #endif

  extern void init_timers(void);
diff -Naur fresh/kernel/timer.c timer/kernel/timer.c
--- fresh/kernel/timer.c	Sun May  9 19:33:13 2004
+++ timer/kernel/timer.c	Tue May 11 15:08:24 2004
@@ -350,6 +350,35 @@
  }

  EXPORT_SYMBOL(del_timer_sync);
+
+/***
+ * del_singleshot_timer_sync - deactivate a non-recursive timer
+ * @timer: the timer to be deactivated
+ *
+ * This function is an optimization of del_timer_sync for the case where the
+ * caller can guarantee the timer does not reschedule itself in its timer
+ * function.
+ *
+ * Synchronization rules: callers must prevent restarting of the timer,
+ * otherwise this function is meaningless. It must not be called from
+ * interrupt contexts. Upon exit the timer is not queued and the handler
+ * is not running on any CPU.
+ *
+ * The function returns whether it has deactivated a pending timer or not.
+ */
+int del_singleshot_timer_sync(struct timer_list *timer)
+{
+	int ret = del_timer(timer);
+
+	if (!ret) {
+		ret = del_timer_sync(timer);
+		BUG_ON(ret);
+	}
+
+	return ret;
+}
+
+EXPORT_SYMBOL(del_singleshot_timer_sync);
  #endif

  static int cascade(tvec_base_t *base, tvec_t *tv, int index)
@@ -1109,7 +1138,7 @@

  	add_timer(&timer);
  	schedule();
-	del_timer_sync(&timer);
+	del_singleshot_timer_sync(&timer);

  	timeout = expire - jiffies;

