Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130362AbRABXrI>; Tue, 2 Jan 2001 18:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130250AbRABXq7>; Tue, 2 Jan 2001 18:46:59 -0500
Received: from hermes.mixx.net ([212.84.196.2]:45830 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129776AbRABXqr>;
	Tue, 2 Jan 2001 18:46:47 -0500
Message-ID: <3A52609D.E1D466EA@innominate.de>
Date: Wed, 03 Jan 2001 00:13:33 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org
Subject: Re: scheduling problem?
In-Reply-To: <20010103010103.D18056@linuxcare.com> <Pine.Linu.4.10.10101021542460.648-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Wed, 3 Jan 2001, Anton Blanchard wrote:
> >
> > > I am seeing (what I believe is;) severe process CPU starvation in
> > > 2.4.0-prerelease.  At first, I attributed it to semaphore troubles
> > > as when I enable semaphore deadlock detection in IKD and set it to
> > > 5 seconds, it triggers 100% of the time on nscd when I do sequential
> > > I/O (iozone eg).  In the meantime, I've done a slew of tracing, and
> > > I think the holder of the semaphore I'm timing out on just flat isn't
> > > being scheduled so it can release it.  In the usual case of nscd, I
> > > _think_ it's another nscd holding the semaphore.  In no trace can I
> > > go back far enough to catch the taker of the semaphore or any user
> > > task other than iozone running between __down() time and timeout 5
> > > seconds later.  (trace buffer covers ~8 seconds of kernel time)
> >
> > Did this just appear in recent kernels? Maybe bdflush was hiding the
> > situation in earlier kernels as it would cause io hogs to block when
> > things got only mildly interesting.
> 
> Yes and no.  I've seen nasty stalls for quite a while now.  (I think
> that there is a wakeup problem lurking)

Could you try this patch just to see what happens?  It uses semaphores
for the bdflush synchronization instead of banging directly on the task
wait queues.  It's supposed to be a drop-in replacement for the bdflush
wakeup/waitfor mechanism, but who knows, it may have subtly different
behavious in your case.

--- 2.4.0.clean/fs/buffer.c	Sat Dec 30 20:19:13 2000
+++ 2.4.0/fs/buffer.c	Tue Jan  2 23:05:14 2001
@@ -2528,33 +2528,28 @@
  * response to dirty buffers.  Once this process is activated, we write
back
  * a limited number of buffers to the disks and then go back to sleep
again.
  */
-static DECLARE_WAIT_QUEUE_HEAD(bdflush_done);
+
+/* Semaphore wakeups, Daniel Phillips, phillips@innominate.de, 2000/12
*/
+
 struct task_struct *bdflush_tsk = 0;
+DECLARE_MUTEX_LOCKED(bdflush_request);
+DECLARE_MUTEX_LOCKED(bdflush_waiter);
+atomic_t bdflush_waiters /*= 0*/;
 
 void wakeup_bdflush(int block)
 {
-	DECLARE_WAITQUEUE(wait, current);
-
 	if (current == bdflush_tsk)
 		return;
 
-	if (!block) {
-		wake_up_process(bdflush_tsk);
+	if (!block)
+	{
+		up(&bdflush_request);
 		return;
 	}
 
-	/* bdflush can wakeup us before we have a chance to
-	   go to sleep so we must be smart in handling
-	   this wakeup event from bdflush to avoid deadlocking in SMP
-	   (we are not holding any lock anymore in these two paths). */
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	add_wait_queue(&bdflush_done, &wait);
-
-	wake_up_process(bdflush_tsk);
-	schedule();
-
-	remove_wait_queue(&bdflush_done, &wait);
-	__set_current_state(TASK_RUNNING);
+	atomic_inc(&bdflush_waiters);
+	up(&bdflush_request);
+	down(&bdflush_waiter);
 }
 
 /* This is the _only_ function that deals with flushing async writes
@@ -2699,7 +2694,7 @@
 int bdflush(void *sem)
 {
 	struct task_struct *tsk = current;
-	int flushed;
+	int flushed, waiters;
 	/*
 	 *	We have a bare-bones task_struct, and really should fill
 	 *	in a few more things so "top" and /proc/2/{exe,root,cwd}
@@ -2727,28 +2722,16 @@
 		if (free_shortage())
 			flushed += page_launder(GFP_BUFFER, 0);
 
-		/* If wakeup_bdflush will wakeup us
-		   after our bdflush_done wakeup, then
-		   we must make sure to not sleep
-		   in schedule_timeout otherwise
-		   wakeup_bdflush may wait for our
-		   bdflush_done wakeup that would never arrive
-		   (as we would be sleeping) and so it would
-		   deadlock in SMP. */
-		__set_current_state(TASK_INTERRUPTIBLE);
-		wake_up_all(&bdflush_done);
-		/*
-		 * If there are still a lot of dirty buffers around,
-		 * skip the sleep and flush some more. Otherwise, we
-		 * go to sleep waiting a wakeup.
-		 */
-		if (!flushed || balance_dirty_state(NODEV) < 0) {
+	        waiters = atomic_read(&bdflush_waiters);
+	        atomic_sub(waiters, &bdflush_waiters);
+		while (waiters--)
+			up(&bdflush_waiter);
+
+		if (!flushed || balance_dirty_state(NODEV) < 0) 
+		{
 			run_task_queue(&tq_disk);
-			schedule();
+			down(&bdflush_request);
 		}
-		/* Remember to mark us as running otherwise
-		   the next schedule will block. */
-		__set_current_state(TASK_RUNNING);
 	}
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
