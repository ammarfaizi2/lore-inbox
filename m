Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbRABSZe>; Tue, 2 Jan 2001 13:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRABSZZ>; Tue, 2 Jan 2001 13:25:25 -0500
Received: from www.wen-online.de ([212.223.88.39]:33031 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131005AbRABSZL>;
	Tue, 2 Jan 2001 13:25:11 -0500
Date: Tue, 2 Jan 2001 15:59:26 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Anton Blanchard <anton@linuxcare.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
In-Reply-To: <20010103010103.D18056@linuxcare.com>
Message-ID: <Pine.Linu.4.10.10101021542460.648-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Anton Blanchard wrote:

>  
> Hi Mike,
> 
> > I am seeing (what I believe is;) severe process CPU starvation in
> > 2.4.0-prerelease.  At first, I attributed it to semaphore troubles
> > as when I enable semaphore deadlock detection in IKD and set it to
> > 5 seconds, it triggers 100% of the time on nscd when I do sequential
> > I/O (iozone eg).  In the meantime, I've done a slew of tracing, and
> > I think the holder of the semaphore I'm timing out on just flat isn't
> > being scheduled so it can release it.  In the usual case of nscd, I
> > _think_ it's another nscd holding the semaphore.  In no trace can I
> > go back far enough to catch the taker of the semaphore or any user
> > task other than iozone running between __down() time and timeout 5
> > seconds later.  (trace buffer covers ~8 seconds of kernel time)
> 
> Did this just appear in recent kernels? Maybe bdflush was hiding the
> situation in earlier kernels as it would cause io hogs to block when
> things got only mildly interesting.

Yes and no.  I've seen nasty stalls for quite a while now.  (I think
that there is a wakeup problem lurking)

I found the change which triggers my horrid stalls.  Nobody is going
to believe this...

diff -urN linux-2.4.0-test13-pre6/fs/buffer.c linux-2.4.0-test13-pre7/fs/buffer.c
--- linux-2.4.0-test13-pre6/fs/buffer.c	Sat Dec 30 08:58:56 2000
+++ linux-2.4.0-test13-pre7/fs/buffer.c	Sun Dec 31 06:22:31 2000
@@ -122,16 +122,17 @@
 				  when trying to refill buffers. */
 		int interval; /* jiffies delay between kupdate flushes */
 		int age_buffer;  /* Time for normal buffer to age before we flush it */
-		int dummy1;    /* unused, was age_super */
+		int nfract_sync; /* Percentage of buffer cache dirty to 
+				    activate bdflush synchronously */
 		int dummy2;    /* unused */
 		int dummy3;    /* unused */
 	} b_un;
 	unsigned int data[N_PARAM];
-} bdf_prm = {{40, 500, 64, 256, 5*HZ, 30*HZ, 5*HZ, 1884, 2}};
+} bdf_prm = {{40, 500, 64, 256, 5*HZ, 30*HZ, 80, 0, 0}};
 
 /* These are the min and max parameter values that we will allow to be assigned */
-int bdflush_min[N_PARAM] = {  0,  10,    5,   25,  0,   1*HZ,   1*HZ, 1, 1};
-int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,600*HZ, 6000*HZ, 6000*HZ, 2047, 5};
+int bdflush_min[N_PARAM] = {  0,  10,    5,   25,  0,   1*HZ,   0, 0, 0};
+int bdflush_max[N_PARAM] = {100,50000, 20000, 20000,600*HZ, 6000*HZ, 100, 0, 0};
 
 /*
  * Rewrote the wait-routines to use the "new" wait-queue functionality,
@@ -1032,9 +1034,9 @@
 	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
 	tot = nr_free_buffer_pages();
 
-	dirty *= 200;
+	dirty *= 100;
 	soft_dirty_limit = tot * bdf_prm.b_un.nfract;
-	hard_dirty_limit = soft_dirty_limit * 2;
+	hard_dirty_limit = tot * bdf_prm.b_un.nfract_sync;
 
 	/* First, check for the "real" dirty limit. */
 	if (dirty > soft_dirty_limit) {

...but reversing this cures my semaphore timeouts.  Don't say impossible
:) I didn't believe it either until I retested several times.  I wager
that if I just fiddle with parameters I'll be able to make the problem
come and go at will.  (means the real problem is gonna be a weird one:)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
