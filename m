Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267423AbSKQAxm>; Sat, 16 Nov 2002 19:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbSKQAxm>; Sat, 16 Nov 2002 19:53:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:43170 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267423AbSKQAxl>;
	Sat, 16 Nov 2002 19:53:41 -0500
Message-ID: <3DD6EA31.6CF5D7D4@digeo.com>
Date: Sat, 16 Nov 2002 17:00:33 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.47-mm3 IO rate question
References: <200211151837.gAFIbm610839@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Nov 2002 01:00:33.0567 (UTC) FILETIME=[BB5AD2F0:01C28DD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> 
> ...
> max_sectors = 512
> SG_SEGMENTS = 32
> [root]# vmstat 5
>    procs                      memory      swap          io     system      cpu
>  r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
>  0 20  0      0 3652472   7752  34464    0    0 170755    15 2354  3477  2 98  0
>  0 20  0      0 3652472   7756  34464    0    0 172771     3 2363  3512  2 98  0
>  0 20  0      0 3652472   7760  34464    0    0 174031     3 2372  3576  0 100  0
>  0 20  0      0 3652408   7764  34464    0    0 173074     7 2384  3538 10 87  3
>  0 20  0      0 3652408   7768  34464    0    0 172670     3 2364  3502  2 98  0

I don't know what happened to your bandwidth, but that context switch rate
is excessive.  qlogic's small BIOs are hurting.

We don't actually need to perform a wakeup-per-BIO in there.  It is sufficient
to deliver a single wakeup on the very last BIO.

This should drop your CPU load a bit.  (vmstat numbers might not change - the
statistical process accounting may not be very accurate for this sort of 
thing.  Use cyclesoak: http://www.zip.com.au/~akpm/linux/#zc)


 fs/direct-io.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

--- 25/fs/direct-io.c~dio-reduce-context-switch-rate	Sat Nov 16 16:55:25 2002
+++ 25-akpm/fs/direct-io.c	Sat Nov 16 16:55:25 2002
@@ -105,7 +105,8 @@ struct dio {
 	int page_errors;		/* errno from get_user_pages() */
 
 	/* BIO completion state */
-	atomic_t bio_count;		/* nr bios in flight */
+	atomic_t bio_count;		/* nr bios to be completed */
+	atomic_t bios_in_flight;	/* nr bios in flight */
 	spinlock_t bio_list_lock;	/* protects bio_list */
 	struct bio *bio_list;		/* singly linked via bi_private */
 	struct task_struct *waiter;	/* waiting task (NULL if none) */
@@ -238,7 +239,8 @@ static int dio_bio_end_io(struct bio *bi
 	spin_lock_irqsave(&dio->bio_list_lock, flags);
 	bio->bi_private = dio->bio_list;
 	dio->bio_list = bio;
-	if (dio->waiter)
+	atomic_dec(&dio->bios_in_flight);
+	if (dio->waiter && atomic_read(&dio->bios_in_flight) == 0)
 		wake_up_process(dio->waiter);
 	spin_unlock_irqrestore(&dio->bio_list_lock, flags);
 	return 0;
@@ -271,6 +273,7 @@ static void dio_bio_submit(struct dio *d
 
 	bio->bi_private = dio;
 	atomic_inc(&dio->bio_count);
+	atomic_inc(&dio->bios_in_flight);
 	submit_bio(dio->rw, bio);
 
 	dio->bio = NULL;
@@ -852,6 +855,7 @@ direct_io_worker(int rw, struct kiocb *i
 	 * still submittion BIOs.
 	 */
 	atomic_set(&dio->bio_count, 1);
+	atomic_set(&dio->bios_in_flight, 0);
 	spin_lock_init(&dio->bio_list_lock);
 	dio->bio_list = NULL;
 	dio->waiter = NULL;

_
