Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbUKXRjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbUKXRjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbUKXRjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:39:15 -0500
Received: from zeus.kernel.org ([204.152.189.113]:36033 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262783AbUKXReo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:34:44 -0500
Date: Wed, 24 Nov 2004 10:09:05 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch] wait_for_completion(_interruptible)?(_timeout)?
In-reply-to: <41A40C74.9000804@sun.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Linux kernel <linux-kernel@vger.kernel.org>
Message-id: <41A4A411.2080503@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_W4b8NA7uWJlDDfzd0VAMIA)"
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <41A40C74.9000804@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_W4b8NA7uWJlDDfzd0VAMIA)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mike Waychison wrote:
> Hi Thomas, Ingo,
> 
> I've tried using the wait_for_completion_interruptible from the patch
> posted to lkml (http://lkml.org/lkml/2004/10/20/461).
> 
> It appears that the timeout/sigpending paths don't call
> __remove_wait_queue, which is bad when somebody gets around to calling
> complete_all.
> 
> Fixed up patch attached.
> 

Ugh.  I must have been half asleep when I originally sent.  The attached
patch does the fix properly (without the two other typos in the two
_timeout variants).


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBpKQQdQs4kOxk3/MRAuseAKCMWWJR/GdteDuAxLY73O5wSnzhVgCeIe0t
K2tuUbZ7ctYQb4ojNIvnCG8=
=DPoG
-----END PGP SIGNATURE-----

--Boundary_(ID_W4b8NA7uWJlDDfzd0VAMIA)
Content-type: text/x-patch; name=wait_for_completion_interruptible.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=wait_for_completion_interruptible.patch

Additional functions for the completion API.

wait_for_completion_interruptible()
wait_for_completion_timeout()
wait_for_completion_interruptible_timeout()

Those are neccecary to convert the users of the racy and 
obsolete sleep_on variants to the completion API

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mike Waychison <michael.waychison@sun.com>

Index: linux-2.6.9-quilt/include/linux/completion.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/completion.h	2004-11-23 20:47:36.000000000 -0800
+++ linux-2.6.9-quilt/include/linux/completion.h	2004-11-23 20:47:39.000000000 -0800
@@ -28,6 +28,12 @@ static inline void init_completion(struc
 }
 
 extern void FASTCALL(wait_for_completion(struct completion *));
+extern int FASTCALL(wait_for_completion_interruptible(struct completion *));
+extern unsigned long FASTCALL(wait_for_completion_timeout(struct completion *,
+							  unsigned long));
+extern unsigned long FASTCALL(wait_for_completion_timeout_interruptible
+			(struct completion *, unsigned long));
+
 extern void FASTCALL(complete(struct completion *));
 extern void FASTCALL(complete_all(struct completion *));
 
Index: linux-2.6.9-quilt/kernel/sched.c
===================================================================
--- linux-2.6.9-quilt.orig/kernel/sched.c	2004-11-23 20:47:36.000000000 -0800
+++ linux-2.6.9-quilt/kernel/sched.c	2004-11-24 07:36:45.400598432 -0800
@@ -2957,6 +2957,106 @@ void fastcall __sched wait_for_completio
 }
 EXPORT_SYMBOL(wait_for_completion);
 
+unsigned long fastcall __sched
+wait_for_completion_timeout(struct completion *x, unsigned long timeout)
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
+			spin_lock_irq(&x->wait.lock);
+			if (!timeout) {
+				__remove_wait_queue(&x->wait, &wait);
+				goto out;
+			}
+		} while (!x->done);
+		__remove_wait_queue(&x->wait, &wait);
+	}
+	x->done--;
+out:
+	spin_unlock_irq(&x->wait.lock);
+	return timeout;
+}
+EXPORT_SYMBOL(wait_for_completion_timeout);
+
+int fastcall __sched wait_for_completion_interruptible(struct completion *x)
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
+				__remove_wait_queue(&x->wait, &wait);
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
+				__remove_wait_queue(&x->wait, &wait);
+				goto out_unlock;
+			}
+			__set_current_state(TASK_INTERRUPTIBLE);
+			spin_unlock_irq(&x->wait.lock);
+			timeout = schedule_timeout(timeout);
+			spin_lock_irq(&x->wait.lock);
+			if (!timeout) {
+				__remove_wait_queue(&x->wait, &wait);
+				goto out_unlock;
+			}
+		} while (!x->done);
+		__remove_wait_queue(&x->wait, &wait);
+	}
+	x->done--;
+out_unlock:
+	spin_unlock_irq(&x->wait.lock);
+	return timeout;
+}
+EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
+
+
 #define	SLEEP_ON_VAR					\
 	unsigned long flags;				\
 	wait_queue_t wait;				\

--Boundary_(ID_W4b8NA7uWJlDDfzd0VAMIA)--
