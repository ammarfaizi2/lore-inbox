Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbUJ3OmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUJ3OmC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUJ3Olp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:41:45 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:49629 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261189AbUJ3Ohf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:37:35 -0400
Message-ID: <4183A721.6070704@kolivas.org>
Date: Sun, 31 Oct 2004 00:37:21 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 5/28] Make sleep functions public
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD9E30E45969B2770383A85FE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD9E30E45969B2770383A85FE
Content-Type: multipart/mixed;
 boundary="------------090808060902030308090009"

This is a multi-part message in MIME format.
--------------090808060902030308090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make sleep functions public


--------------090808060902030308090009
Content-Type: text/x-patch;
 name="publicise_sleepstuff.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_sleepstuff.diff"

All the sleepstuff can be shared so make it public.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:45:10.305945023 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:46:27.313926895 +1000
@@ -2912,77 +2912,6 @@ void fastcall __sched wait_for_completio
 }
 EXPORT_SYMBOL(wait_for_completion);
 
-#define	SLEEP_ON_VAR					\
-	unsigned long flags;				\
-	wait_queue_t wait;				\
-	init_waitqueue_entry(&wait, current);
-
-#define SLEEP_ON_HEAD					\
-	spin_lock_irqsave(&q->lock,flags);		\
-	__add_wait_queue(q, &wait);			\
-	spin_unlock(&q->lock);
-
-#define	SLEEP_ON_TAIL					\
-	spin_lock_irq(&q->lock);			\
-	__remove_wait_queue(q, &wait);			\
-	spin_unlock_irqrestore(&q->lock, flags);
-
-void fastcall __sched interruptible_sleep_on(wait_queue_head_t *q)
-{
-	SLEEP_ON_VAR
-
-	current->state = TASK_INTERRUPTIBLE;
-
-	SLEEP_ON_HEAD
-	schedule();
-	SLEEP_ON_TAIL
-}
-
-EXPORT_SYMBOL(interruptible_sleep_on);
-
-long fastcall __sched interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
-{
-	SLEEP_ON_VAR
-
-	current->state = TASK_INTERRUPTIBLE;
-
-	SLEEP_ON_HEAD
-	timeout = schedule_timeout(timeout);
-	SLEEP_ON_TAIL
-
-	return timeout;
-}
-
-EXPORT_SYMBOL(interruptible_sleep_on_timeout);
-
-void fastcall __sched sleep_on(wait_queue_head_t *q)
-{
-	SLEEP_ON_VAR
-
-	current->state = TASK_UNINTERRUPTIBLE;
-
-	SLEEP_ON_HEAD
-	schedule();
-	SLEEP_ON_TAIL
-}
-
-EXPORT_SYMBOL(sleep_on);
-
-long fastcall __sched sleep_on_timeout(wait_queue_head_t *q, long timeout)
-{
-	SLEEP_ON_VAR
-
-	current->state = TASK_UNINTERRUPTIBLE;
-
-	SLEEP_ON_HEAD
-	timeout = schedule_timeout(timeout);
-	SLEEP_ON_TAIL
-
-	return timeout;
-}
-
-EXPORT_SYMBOL(sleep_on_timeout);
-
 static void ingo_set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
@@ -4710,28 +4639,6 @@ static void __init ingo_sched_init(void)
 	init_idle(current, smp_processor_id());
 }
 
-#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
-void __might_sleep(char *file, int line)
-{
-#if defined(in_atomic)
-	static unsigned long prev_jiffy;	/* ratelimiting */
-
-	if ((in_atomic() || irqs_disabled()) &&
-	    system_state == SYSTEM_RUNNING) {
-		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
-			return;
-		prev_jiffy = jiffies;
-		printk(KERN_ERR "Debug: sleeping function called from invalid"
-				" context at %s:%d\n", file, line);
-		printk("in_atomic():%d, irqs_disabled():%d\n",
-			in_atomic(), irqs_disabled());
-		dump_stack();
-	}
-#endif
-}
-EXPORT_SYMBOL(__might_sleep);
-#endif
-
 #if defined(CONFIG_DEBUG_KERNEL)&&defined(CONFIG_SYSCTL)&&defined(CONFIG_SMP)
 static struct ctl_table sd_ctl_dir[] = {
 	{1, "sched_domain", NULL, 0, 0755, NULL, },
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:45:13.658421824 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:45:18.916601215 +1000
@@ -141,6 +141,99 @@ need_resched:
 EXPORT_SYMBOL(preempt_schedule);
 #endif /* CONFIG_PREEMPT */
 
+#define	SLEEP_ON_VAR					\
+	unsigned long flags;				\
+	wait_queue_t wait;				\
+	init_waitqueue_entry(&wait, current);
+
+#define SLEEP_ON_HEAD					\
+	spin_lock_irqsave(&q->lock,flags);		\
+	__add_wait_queue(q, &wait);			\
+	spin_unlock(&q->lock);
+
+#define	SLEEP_ON_TAIL					\
+	spin_lock_irq(&q->lock);			\
+	__remove_wait_queue(q, &wait);			\
+	spin_unlock_irqrestore(&q->lock, flags);
+
+void fastcall __sched interruptible_sleep_on(wait_queue_head_t *q)
+{
+	SLEEP_ON_VAR
+
+	current->state = TASK_INTERRUPTIBLE;
+
+	SLEEP_ON_HEAD
+	schedule();
+	SLEEP_ON_TAIL
+}
+
+EXPORT_SYMBOL(interruptible_sleep_on);
+
+long fastcall __sched interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
+{
+	SLEEP_ON_VAR
+
+	current->state = TASK_INTERRUPTIBLE;
+
+	SLEEP_ON_HEAD
+	timeout = schedule_timeout(timeout);
+	SLEEP_ON_TAIL
+
+	return timeout;
+}
+
+EXPORT_SYMBOL(interruptible_sleep_on_timeout);
+
+void fastcall __sched sleep_on(wait_queue_head_t *q)
+{
+	SLEEP_ON_VAR
+
+	current->state = TASK_UNINTERRUPTIBLE;
+
+	SLEEP_ON_HEAD
+	schedule();
+	SLEEP_ON_TAIL
+}
+
+EXPORT_SYMBOL(sleep_on);
+
+long fastcall __sched sleep_on_timeout(wait_queue_head_t *q, long timeout)
+{
+	SLEEP_ON_VAR
+
+	current->state = TASK_UNINTERRUPTIBLE;
+
+	SLEEP_ON_HEAD
+	timeout = schedule_timeout(timeout);
+	SLEEP_ON_TAIL
+
+	return timeout;
+}
+
+EXPORT_SYMBOL(sleep_on_timeout);
+
+#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
+void __might_sleep(char *file, int line)
+{
+#if defined(in_atomic)
+	static unsigned long prev_jiffy;	/* ratelimiting */
+
+	if ((in_atomic() || irqs_disabled()) &&
+	    system_state == SYSTEM_RUNNING) {
+		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
+			return;
+		prev_jiffy = jiffies;
+		printk(KERN_ERR "Debug: sleeping function called from invalid"
+				" context at %s:%d\n", file, line);
+		printk("in_atomic():%d, irqs_disabled():%d\n",
+			in_atomic(), irqs_disabled());
+		dump_stack();
+	}
+#endif
+}
+EXPORT_SYMBOL(__might_sleep);
+#endif
+
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;
 


--------------090808060902030308090009--

--------------enigD9E30E45969B2770383A85FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6chZUg7+tp6mRURAv7bAJ9J7O6FSlROk92LGG2iXPNqqzIXAACeNFPj
MkgpbMSNx2ystEN0m1EgfVA=
=8r5l
-----END PGP SIGNATURE-----

--------------enigD9E30E45969B2770383A85FE--
