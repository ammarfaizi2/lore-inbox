Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311618AbSCTGmk>; Wed, 20 Mar 2002 01:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311619AbSCTGmb>; Wed, 20 Mar 2002 01:42:31 -0500
Received: from [202.135.142.194] ([202.135.142.194]:46861 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311618AbSCTGmP>; Wed, 20 Mar 2002 01:42:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin.Wirth@dlr.de
Cc: Ulrich Drepper <drepper@redhat.com>, pwaechtler@loewe-komp.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Tue, 19 Mar 2002 09:34:39 BST."
             <3C96F81F.1020608@dlr.de> 
Date: Wed, 20 Mar 2002 17:45:02 +1100
Message-Id: <E16nZqJ-0004mi-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C96F81F.1020608@dlr.de> you write:
> Rusty Russell wrote:
> 
> 
> > 1) Where this is flawed,
> 
> 
> I. There is a race in __pthread_cond_wait between timeout and a 
> cond_signal or broadcast. If the signal comes in
> 
> } while (ret < 0 && errno == EINTR);
>  >>>>> we leave with errno==ETIMEDOUT and get signal or broadcast called 
> here
> 	if (atomic_dec_and_test(cond->num_waiting))
> 
> then you up cond->wait one time to often, leaving it in an invalid state.

Hmmm... this is true.

> II. Your implementation relies on the fact that the signal or broadcast
> caller owns the mutex used in cond_wait. According to the POSIX spec 
> this need not be the case. The only thing that may happen is that you
> miss a wakeup. But it is not allowed to screw up the internal state of
> of the condition variable, which might well happen in your 
> implementation. (Note: Calling cond_signal without holding the mutex is 
> not necessarily flawed software. Think of a periodically occurring 
> new_data or data_changed flag where it is not really important to sleep 
> race free)

I hadn't appreciated this.  That makes it harder.  I think I have to
abandon the atomics and use a mutex inside the condition variable.

> III. Minor nit: You should also clear cond->ack.count
> in cond_signal otherwise it may wrap around soon (at least for a
> 24-bit atomic variable) if you mostly use cond_signal.

Yep.

> > 2) Where this is suboptimal,
> 
> 
> As said in a previous e-mail, you need an futex_up(..,n) that
> really wakes_up n thread at once.

OK, we could read the value in the kernel's up() and wake that many.

> > 3) What kernel primitive would help to resolve these?
> 
> Your exported waitqueues or my suggestion for a second waitqueue 
> associated with a futex.

Any chance of a rough patch (to the code below, at least)?

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

--- non-pthreads.c.19-March-2002	Wed Mar 20 17:37:17 2002
+++ non-pthreads.c	Wed Mar 20 17:43:42 2002
@@ -11,6 +11,7 @@
 
 typedef struct 
 {
+	struct futex lock;
 	int num_waiting;
 	struct futex wait, ack;
 } pthread_cond_t;
@@ -48,23 +49,29 @@
 
 int pthread_cond_signal(pthread_cond_t *cond)
 {
+	futex_down(&cond->lock);
+	/* Reset this so it doesn't overflow */
+	cond->ack.count = 0;
 	if (cond->num_waiters)
 		return futex_up(&cond->futex, 1);
+	futex_up(&cond->lock, 1);
 	return 0;
 }
 
 int pthread_cond_broadcast(pthread_cond_t *cond)
 {
-	unsigned int waiters = cond->num_waiting;
-
-	if (waiters) {
-		/* Re-initialize ACK.  Could have been upped by
-                   pthread_cond_signal and pthread_cond_wait. */
+	futex_down(&cond->lock);
+	if (cond->num_waiting) {
 		cond->ack.count = 0;
+		/* Release the waiters. */
 		futex_up(&cond->futex, waiters);
 		/* Wait for ack before returning. */
 		futex_down(&cond->ack);
+		/* Reset wait, in case someone who was waiting timed
+                   out and didn't decrement. */
+		cond->wait.count = 0;
 	}
+	futex_up(&cond->lock);
 	return 0;
 }
 
@@ -75,8 +82,10 @@
 	int ret;
 
 	/* Increment first so broadcaster knows we are waiting. */
+	futex_down(&cond->lock);
 	atomic_inc(cond->num_waiting);
 	futex_up(&mutex, 1);
+	futex_up(&cond->lock, 1);
 	do {
 		ret = futex_down_time(&cond, reltime);
 	} while (ret < 0 && errno == EINTR);
