Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132754AbRDIN4p>; Mon, 9 Apr 2001 09:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132755AbRDIN4g>; Mon, 9 Apr 2001 09:56:36 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:62055 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132754AbRDIN4Y>; Mon, 9 Apr 2001 09:56:24 -0400
Date: Mon, 9 Apr 2001 09:55:04 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@devserv.devel.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <andrewm@uow.edu.au>, David Howells <dhowells@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rw_semaphores
In-Reply-To: <Pine.LNX.4.31.0104082030080.7830-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0104090902150.16636-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Apr 2001, Linus Torvalds wrote:

>
> The "down_writer_failed()" case was wrong:

Which is exactly the same problem in the original code.  How about the
following patch against the original code?  I hadn't sent it yet as the
test code isn't finished (hence, it's untested), but given that Andrew is
going full steam ahead, people might as well give this a try.

		-ben

rwsem-2.4.4-pre1-A0.diff
diff -ur v2.4.4-pre1/arch/i386/kernel/semaphore.c work-2.4.4-pre1/arch/i386/kernel/semaphore.c
--- v2.4.4-pre1/arch/i386/kernel/semaphore.c	Sat Nov 18 20:31:25 2000
+++ work-2.4.4-pre1/arch/i386/kernel/semaphore.c	Mon Apr  9 09:47:02 2001
@@ -269,10 +269,9 @@
 	ret

 2:	call	down_write_failed
-	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jz	1b
-	jnc	2b
-	jmp	3b
+	popl	%ecx
+	popl	%edx
+	ret
 "
 );

@@ -366,19 +365,56 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);

-	__up_write(sem);	/* this takes care of granting the lock */
+	/* Originally we called __up_write here, but that
+	 * doesn't work: the lock add operation could result
+	 * in us failing to detect a bias grant.  Instead,
+	 * we'll use a compare and exchange to get the lock
+	 * from a known state: either <= -BIAS while another
+	 * waiter is still around, or > -BIAS if we were given
+	 * the lock's bias.
+	 */

+	do {
+		int old = atomic_read(&sem->count), new, res;
+		if (old > -RW_LOCK_BIAS)
+			return down_write_failed_biased(sem);
+		new = old + RW_LOCK_BIAS;
+		res = cmpxchg(&sem->count.counter, old, new);
+	} while (res != old);
+
+again:
+	/* We are now removed from the lock.  Wait for all other
+	 * waiting writers to go away.
+	 */
 	add_wait_queue_exclusive(&sem->wait, &wait);

 	while (atomic_read(&sem->count) < 0) {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&sem->count) >= 0)
+		if (atomic_read(&sem->count) >= 0) {
 			break;	/* we must attempt to acquire or bias the lock */
+		}
+
 		schedule();
 	}

 	remove_wait_queue(&sem->wait, &wait);
 	tsk->state = TASK_RUNNING;
+
+	/* Okay, try to grab the lock. */
+	for (;;) {
+		int old = atomic_read(&sem->count), new, res;
+		if (old < 0)
+			goto again;
+		new = old - RW_LOCK_BIAS;
+		res = cmpxchg(&sem->count.counter, old, new);
+		if (res != old)
+			continue;
+		if (old == RW_LOCK_BIAS)
+			break;
+		if (old >= 0)
+			return down_write_failed_biased(sem);
+		goto again;
+	}

 	return sem;
 }

