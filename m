Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVC0KCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVC0KCY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 05:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVC0KCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 05:02:24 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:6826 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261504AbVC0KCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 05:02:15 -0500
Message-ID: <42468606.280849C6@tv-sign.ru>
Date: Sun, 27 Mar 2005 14:08:06 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Christoph Lameter <christoph@lameter.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] timers: description
References: <200503261952.j2QJq1g27569@unix-os.sc.intel.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" wrote:
>
> Oleg Nesterov wrote on March 19, 2005 17:28:48
> > These patches are updated version of 'del_timer_sync: proof of
> > concept' 2 patches.
>
> I changed schedule_timeout() to call the new del_timer_sync instead of
> currently del_singleshot_timer_sync in attempt to stress these set of
> patches a bit more and I just observed a kernel hang.
>
> The symptom starts with lost network connectivity.  It looks like the
> entire ethernet connections were gone, followed by blank screen on the
> console.  I'm not sure whether it is a hard or soft hang, but system
> is inaccessible (blank screen and no network connection). I'm forced
> to do a reboot when that happens.

Very strange. I am running 2.6.11 + timer patches +
	#define del_singleshot_timer_sync(t) del_timer_sync(t)
without any problems.

This timer is private to schedule_timeout(), it can't change
base, so del_timer_sync() should be "obviously correct" in
that case.

What kernel version? Could you try this stupid patch?

Oleg.

--- TST/kernel/timer.c~	2005-03-27 16:47:20.000000000 +0400
+++ TST/kernel/timer.c	2005-03-27 17:16:32.000000000 +0400
@@ -352,27 +352,46 @@ EXPORT_SYMBOL(del_timer);
  */
 int del_timer_sync(struct timer_list *timer)
 {
+	unsigned long tout;
+	int running = 0, migrated = 0, done = 0;
 	int ret;
 
 	check_timer(timer);
 
+	preempt_disable();
+	tout = jiffies + 10;
+
 	ret = 0;
 	for (;;) {
 		unsigned long flags;
 		tvec_base_t *base;
 
 		base = timer_base(timer);
-		if (!base)
+		if (!base) {
+			preempt_enable();
 			return ret;
+		}
+		if (time_after(jiffies, tout)) {
+			preempt_enable();
+			printk(KERN_ERR "del_timer_sync hang: %d %d %d %d\n",
+				running, migrated, done, ret);
+			dump_stack();
+			return 0;
+		}
 
 		spin_lock_irqsave(&base->lock, flags);
 
-		if (base->running_timer == timer)
+		if (base->running_timer == timer) {
+			++running;
 			goto unlock;
+		}
 
-		if (timer_base(timer) != base)
+		if (timer_base(timer) != base) {
+			++migrated;
 			goto unlock;
+		}
 
+		++done;
 		if (timer_pending(timer)) {
 			list_del(&timer->entry);
 			ret = 1;
