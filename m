Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130008AbRBYJzW>; Sun, 25 Feb 2001 04:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130015AbRBYJzN>; Sun, 25 Feb 2001 04:55:13 -0500
Received: from colorfullife.com ([216.156.138.34]:31502 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130008AbRBYJzF>;
	Sun, 25 Feb 2001 04:55:05 -0500
Message-ID: <3A98D5D3.6A6B6686@colorfullife.com>
Date: Sun, 25 Feb 2001 10:52:19 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Lahr <lahr@sequent.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability
In-Reply-To: <20010215104656.A6856@w-lahr.des.sequent.com>
Content-Type: multipart/mixed;
 boundary="------------6A6AF872F4E618CA2D9E3555"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6A6AF872F4E618CA2D9E3555
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jonathan Lahr wrote:
> 
> To discover possible locking limitations to scalability, I have collected
> locking statistics on a 2-way, 4-way, and 8-way performing as networked
> database servers.  I patched the [48]-way kernels with Kravetz's multiqueue
> patch in the hope that mitigating runqueue_lock contention might better
> reveal other lock contention.
>

The dual cpu numbers are really odd. Extremely high count of
add_timer(), del_timer_sync(), schedule() and process_timeout().

That could be a kernel bug:
perhaps someone uses
for(;;) {
	set_current_state(TASK_INTERRUPTIBLE);
	schedule_timeout(100);
}
without checking signal_pending()?


> In the attached document, I describe my test environment and excerpt
> lockstat output to show the more contentious locks for a typical run on
> each of my server configurations.  I'm interested in comparing these data
> to other lock contention data, so information regarding previous or ongoing
> lock contention work would be appreciated.  I'm aware of timer scalability
> work ongoing at people.redhat.com/mingo/scalable-timers, but is anyone
> working on reducing sem_ids contention?
>

Is that really a problem?
The contention is high, but the actual lost time is quite small.

The 8-way test ran for ~ 129 seconds wall clock time (total cpu time
1030 seconds), and around 0.7 seconds were lost due to spinning.
The high contention is caused by the wakeups: cpu0 scans the list of
waiting processes and if it finds one it is woken up. If that thread
runs before cpu0 can release the spinlock, the second cpu will spin.

I've attached 2 changes that might reduce the contention, but it's just
an idea, completely untested.

* slightly more efficient try_atomic_semop().
* don't acquire the spinlock if q->alter was 0. It could slightly
improve performance, but I assume that q->alter will be always 1.

Btw, I found a small bug in try_atomic_semop():
If a semaphore operation with sem_op==0 blocks, then the pid is
corrupted. The bug also exists in 2.2.

--
	Manfred
--------------6A6AF872F4E618CA2D9E3555
Content-Type: text/plain; charset=us-ascii;
 name="patch-sem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-sem"

--- sem.c.old	Sun Feb 25 10:50:55 2001
+++ sem.c	Sun Feb 25 10:51:19 2001
@@ -250,23 +250,23 @@
 		curr = sma->sem_base + sop->sem_num;
 		sem_op = sop->sem_op;
 
-		if (!sem_op && curr->semval)
+		result = curr->semval;
+		if (!sem_op && result)
 			goto would_block;
+		result += sem_op;
+		if (result < 0)
+			goto would_block;
+		if (result > SEMVMX)
+			goto out_of_range;
 
 		curr->sempid = (curr->sempid << 16) | pid;
-		curr->semval += sem_op;
+		curr->semval = result;
 		if (sop->sem_flg & SEM_UNDO)
 			un->semadj[sop->sem_num] -= sem_op;
-
-		if (curr->semval < 0)
-			goto would_block;
-		if (curr->semval > SEMVMX)
-			goto out_of_range;
 	}
 
 	if (do_undo)
 	{
-		sop--;
 		result = 0;
 		goto undo;
 	}
@@ -285,6 +285,7 @@
 		result = 1;
 
 undo:
+	sop--;
 	while (sop >= sops) {
 		curr = sma->sem_base + sop->sem_num;
 		curr->semval -= sop->sem_op;
@@ -305,7 +306,9 @@
 {
 	int error;
 	struct sem_queue * q;
+	int do_retry = 0;
 
+retry:
 	for (q = sma->sem_pending; q; q = q->next) {
 			
 		if (q->status == 1)
@@ -323,10 +326,17 @@
 				q->status = 1;
 				return;
 			}
-			q->status = error;
 			remove_from_queue(sma,q);
+			wmb();
+			q->status = error;
+			/* FIXME: retry only required if an increase was
+			 * executed
+			 */
+			do_retry = 1;
 		}
 	}
+	if (do_retry)
+		goto retry;
 }
 
 /* The following counts are associated to each semaphore:
@@ -919,7 +929,13 @@
 		sem_unlock(semid);
 
 		schedule();
-
+		if (queue.status == 0) {
+			error = 0;
+			if (queue.prev)
+				BUG();
+			current->semsleeping = NULL;
+			goto out_free;
+		}
 		tmp = sem_lock(semid);
 		if(tmp==NULL) {
 			if(queue.prev != NULL)

--------------6A6AF872F4E618CA2D9E3555--


