Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVFOVJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVFOVJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVFOVHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:07:49 -0400
Received: from [24.24.2.57] ([24.24.2.57]:55960 "EHLO ms-smtp-03.nyroc.rr.com")
	by vger.kernel.org with ESMTP id S261553AbVFOVFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:05:21 -0400
Subject: Re: [BUG] Race condition with it_real_fn in kernel/itimer.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Roland McGrath <roland@redhat.com>
In-Reply-To: <20050615132522.3b6a857c.akpm@osdl.org>
References: <1118852632.4508.48.camel@localhost.localdomain>
	 <20050615132522.3b6a857c.akpm@osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 15 Jun 2005 17:01:29 -0400
Message-Id: <1118869289.5035.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 13:25 -0700, Andrew Morton wrote:

> 
> And that will fix it.  (Labels start in column zero, and a comment is
> needed here).

I blame emacs for that bad label :-)

> 
> However I wonder if it would be sufficient to remove the del_timer_sync()
> call altogether and just do mod_timer() in it_real_arm().
> 
> If the handler happens to be running on another CPU and if the handler
> tries to run mod_timer() _after_ the do_setitimer() has run mod_timer(),
> the handler will use the desired value of it_real_incr anyway.
> 

So do you prefer a patch like the following?

--- linux-2.6.12-rc6/kernel/itimer.c.orig	2005-06-15 16:33:13.000000000 -0400
+++ linux-2.6.12-rc6/kernel/itimer.c	2005-06-15 16:42:45.000000000 -0400
@@ -118,6 +118,8 @@
  */
 static inline void it_real_arm(struct task_struct *p, unsigned long interval)
 {
+	unsigned long expires;
+
 	p->signal->it_real_value = interval; /* XXX unnecessary field?? */
 	if (interval == 0)
 		return;
@@ -127,8 +129,8 @@
 	 * the interval requested. This could happen if
 	 * time requested % (usecs per jiffy) is more than the usecs left
 	 * in the current jiffy */
-	p->signal->real_timer.expires = jiffies + interval + 1;
-	add_timer(&p->signal->real_timer);
+	expires = jiffies + interval + 1;
+	mod_timer(&p->signal->real_timer, expires);
 }
 
 void it_real_fn(unsigned long __data)
@@ -156,8 +158,6 @@
 		spin_lock_irq(&tsk->sighand->siglock);
 		interval = tsk->signal->it_real_incr;
 		val = it_real_value(tsk->signal);
-		if (val)
-			del_timer_sync(&tsk->signal->real_timer);
 		tsk->signal->it_real_incr =
 			timeval_to_jiffies(&value->it_interval);
 		it_real_arm(tsk, timeval_to_jiffies(&value->it_value));


Now the question is, what happens on the following scenario?

ksoftirqd:

  calls it_real_func 

process:

   calls do_setitimer blocks on siglock;

ksoftirqd: unlocks siglock calls it_real_arm and after it assigns
expires it takes an interrupt before calling mod_timer.

process:

   calls it_real_arm and does the changes to mod_timer first.

ksoftirqd: comes back from interrupt and then calls mod_timer with the
wrong value.

This may be a small chance in hell of happening, and the result may not
be to drastic, but this is still a race condition.  So far I think that
my unconditional calling of del_timer_sync, although inefficient, it
doesn't have any races.

-- Steve

