Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270964AbUJUVGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270964AbUJUVGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270418AbUJUVCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:02:51 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:164
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270844AbUJUU5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:57:24 -0400
Subject: Re: [PATCH] Completion API extension
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1098289871.12223.1603.camel@thomas>
References: <1098289871.12223.1603.camel@thomas>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098391759.27089.86.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 22:49:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected Version. We missed some bits (:

Additional functions for the completion API.

wait_for_completion_interruptible()
wait_for_completion_timeout()
wait_for_completion_interruptible_timeout()

Those are neccecary to convert the users of the racy and 
obsolete sleep_on variants to the completion API

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>

---

 2.6.9-bk-041020-thomas/include/linux/completion.h |    6 +
 2.6.9-bk-041020-thomas/kernel/sched.c             |   95
++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff -puN include/linux/completion.h~completion
include/linux/completion.h
--- 2.6.9-bk-041020/include/linux/completion.h~completion	2004-10-20
15:22:47.000000000 +0200
+++ 2.6.9-bk-041020-thomas/include/linux/completion.h	2004-10-20
15:22:47.000000000 +0200
@@ -28,6 +28,12 @@ static inline void init_completion(struc
 }
 
 extern void FASTCALL(wait_for_completion(struct completion *));
+extern int FASTCALL(wait_for_completion_interruptible(struct completion
*));
+extern unsigned long FASTCALL(wait_for_completion_timeout(struct
completion *,
+							  unsigned long));
+extern unsigned long FASTCALL(wait_for_completion_timeout_interruptible
+			(struct completion *, unsigned long));
+
 extern void FASTCALL(complete(struct completion *));
 extern void FASTCALL(complete_all(struct completion *));
 
diff -puN kernel/sched.c~completion kernel/sched.c
--- 2.6.9-bk-041020/kernel/sched.c~completion	2004-10-20
15:22:47.000000000 +0200
+++ 2.6.9-bk-041020-thomas/kernel/sched.c	2004-10-21 20:13:09.000000000
+0200
@@ -2811,6 +2811,101 @@ void fastcall __sched wait_for_completio
 }
 EXPORT_SYMBOL(wait_for_completion);
 
+unsigned long fastcall __sched
+wait_for_completion_timeout(struct completion *x, unsigned long
timeout)
+{
+	might_sleep();
+
+	spin_lock_irq(&x->wait.lock);
+	if (!x->done) {
+		DECLARE_WAITQUEUE(wait, current);
+
+		wait.flags |= WQ_FLAG_EXCLUSIVE;
+		__add_wait_queue_tail(&x->wait, &wait);
+		do {
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+			spin_unlock_irq(&x->wait.lock);
+			timeout = schedule_timeout(timeout);
+			if (!timeout)
+				goto out;
+			spin_lock_irq(&x->wait.lock);
+		} while (!x->done);
+		__remove_wait_queue(&x->wait, &wait);
+	}
+	x->done--;
+	spin_unlock_irq(&x->wait.lock);
+out:
+	return timeout;
+}
+EXPORT_SYMBOL(wait_for_completion_timeout);
+
+int fastcall __sched wait_for_completion_interruptible(struct
completion *x)
+{
+	int ret = 0;
+
+	might_sleep();
+
+	spin_lock_irq(&x->wait.lock);
+	if (!x->done) {
+		DECLARE_WAITQUEUE(wait, current);
+
+		wait.flags |= WQ_FLAG_EXCLUSIVE;
+		__add_wait_queue_tail(&x->wait, &wait);
+		do {
+			if (signal_pending(current)) {
+				ret = -ERESTARTSYS;
+				goto out;
+			}
+			__set_current_state(TASK_INTERRUPTIBLE);
+			spin_unlock_irq(&x->wait.lock);
+			schedule();
+			spin_lock_irq(&x->wait.lock);
+		} while (!x->done);
+		__remove_wait_queue(&x->wait, &wait);
+	}
+	x->done--;
+out:
+	spin_unlock_irq(&x->wait.lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(wait_for_completion_interruptible);
+
+unsigned long fastcall __sched
+wait_for_completion_interruptible_timeout(struct completion *x,
+					  unsigned long timeout)
+{
+	might_sleep();
+
+	spin_lock_irq(&x->wait.lock);
+	if (!x->done) {
+		DECLARE_WAITQUEUE(wait, current);
+
+		wait.flags |= WQ_FLAG_EXCLUSIVE;
+		__add_wait_queue_tail(&x->wait, &wait);
+		do {
+			if (signal_pending(current)) {
+				timeout = -ERESTARTSYS;
+				goto out_unlock;
+			}
+			__set_current_state(TASK_INTERRUPTIBLE);
+			spin_unlock_irq(&x->wait.lock);
+			timeout = schedule_timeout(timeout);
+			if (!timeout)
+				goto out;
+			spin_lock_irq(&x->wait.lock);
+		} while (!x->done);
+		__remove_wait_queue(&x->wait, &wait);
+	}
+	x->done--;
+out_unlock:
+	spin_unlock_irq(&x->wait.lock);
+out:
+	return timeout;
+}
+EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
+
+
 #define	SLEEP_ON_VAR					\
 	unsigned long flags;				\
 	wait_queue_t wait;				\
_


