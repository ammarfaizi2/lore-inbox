Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269779AbRHDDe4>; Fri, 3 Aug 2001 23:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269781AbRHDDeq>; Fri, 3 Aug 2001 23:34:46 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:50191 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269779AbRHDDei>;
	Fri, 3 Aug 2001 23:34:38 -0400
Date: Sat, 4 Aug 2001 00:34:37 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108032318330.14842-100000@touchme.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33L.0108040032030.2526-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Ben LaHaise wrote:

> See, after applying this patch, it no longer deadlocks on io.  The
> jerky interactive performance still exists,

Would something like this help ?

(yes, there's a small SMP race, but since the system survives
the starvation bug today that isn't critical)


--- ./ll_rw_blk.c.batch	Sat Aug  4 00:30:55 2001
+++ ./ll_rw_blk.c	Sat Aug  4 00:33:48 2001
@@ -1031,15 +1031,19 @@

 	for (i = 0; i < nr; i++) {
 		struct buffer_head *bh = bhs[i];
+		static int queued_sector_waiters;

 		/*
 		 * don't lock any more buffers if we are above the high
 		 * water mark. instead start I/O on the queued stuff.
 		 */
-		if (atomic_read(&queued_sectors) >= high_queued_sectors) {
+		if (atomic_read(&queued_sectors) >= high_queued_sectors
+				|| queued_sector_waiters) {
 			run_task_queue(&tq_disk);
+			queued_sector_waiters = 1;
 			wait_event(blk_buffers_wait,
 			 atomic_read(&queued_sectors) < low_queued_sectors);
+			queued_sector_waiters = 0;
 		}

 		/* Only one thread can actually submit the I/O. */


Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

