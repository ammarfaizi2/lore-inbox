Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264785AbUEKXBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264785AbUEKXBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbUEKXBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:01:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:28810 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264785AbUEKXBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:01:04 -0400
Date: Tue, 11 May 2004 16:03:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Geoff Gustafson <geoff@linux.jf.intel.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-Id: <20040511160326.1b192cad.akpm@osdl.org>
In-Reply-To: <40A152A8.4080104@linux.intel.com>
References: <40A152A8.4080104@linux.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geoff Gustafson <geoff@linux.jf.intel.com> wrote:
>
> Andrew Morton wrote:
>  > <anal>del_singleshot_timer_sync</anal>
>  >
>  > I vote we leave it up to Ken.  But please, not del_timer_kenneth().
> 
> Despite your markup language, I thought keeping the 'sync' sounded like
> a good idea, since that's the function it's replacing.
> 
> Here's a patch. I've done a small amount of testing with a 4p machine.
> I've at least seen that the average call to singleshot is down around 90
> cycles, pretty similar/expected.

Looks good.  Your email client performs bizarre whitespace transformations, so I had to
fix the patch up by hand.

Here's an incremental patch:



diff -puN include/linux/timer.h~del_singleshot_timer_sync-tweaks include/linux/timer.h
--- 25/include/linux/timer.h~del_singleshot_timer_sync-tweaks	Tue May 11 15:59:57 2004
+++ 25-akpm/include/linux/timer.h	Tue May 11 15:59:57 2004
@@ -87,8 +87,8 @@ static inline void add_timer(struct time
 }
 
 #ifdef CONFIG_SMP
-  extern int del_timer_sync(struct timer_list * timer);
-  extern int del_singleshot_timer_sync(struct timer_list * timer);
+  extern int del_timer_sync(struct timer_list *timer);
+  extern int del_singleshot_timer_sync(struct timer_list *timer);
 #else
 # define del_timer_sync(t) del_timer(t)
 # define del_singleshot_timer_sync(t) del_timer(t)
diff -puN kernel/timer.c~del_singleshot_timer_sync-tweaks kernel/timer.c
--- 25/kernel/timer.c~del_singleshot_timer_sync-tweaks	Tue May 11 15:59:57 2004
+++ 25-akpm/kernel/timer.c	Tue May 11 15:59:57 2004
@@ -317,10 +317,16 @@ EXPORT_SYMBOL(del_timer);
  *
  * Synchronization rules: callers must prevent restarting of the timer,
  * otherwise this function is meaningless. It must not be called from
- * interrupt contexts. Upon exit the timer is not queued and the handler
- * is not running on any CPU.
+ * interrupt contexts. The caller must not hold locks which would prevent
+ * completion of the timer's handler.  Upon exit the timer is not queued and
+ * the handler is not running on any CPU.
  *
  * The function returns whether it has deactivated a pending timer or not.
+ *
+ * del_timer_sync() is slow and complicated because it copes with timer
+ * handlers which re-arm the timer (periodic timers).  If the timer handler
+ * is known to not do this (a single shot timer) then use
+ * del_singleshot_timer_sync() instead.
  */
 int del_timer_sync(struct timer_list *timer)
 {
@@ -348,7 +354,6 @@ del_again:
 
 	return ret;
 }
-
 EXPORT_SYMBOL(del_timer_sync);
 
 /***
@@ -361,8 +366,9 @@ EXPORT_SYMBOL(del_timer_sync);
  *
  * Synchronization rules: callers must prevent restarting of the timer,
  * otherwise this function is meaningless. It must not be called from
- * interrupt contexts. Upon exit the timer is not queued and the handler
- * is not running on any CPU.
+ * interrupt contexts. The caller must not hold locks which would prevent
+ * completion of the timer's handler.  Upon exit the timer is not queued and
+ * the handler is not running on any CPU.
  *
  * The function returns whether it has deactivated a pending timer or not.
  */
@@ -377,7 +383,6 @@ int del_singleshot_timer_sync(struct tim
 
 	return ret;
 }
-
 EXPORT_SYMBOL(del_singleshot_timer_sync);
 #endif
 

_

