Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbREZOZe>; Sat, 26 May 2001 10:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbREZOZY>; Sat, 26 May 2001 10:25:24 -0400
Received: from [209.10.41.242] ([209.10.41.242]:43427 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262659AbREZOZQ>;
	Sat, 26 May 2001 10:25:16 -0400
Date: Sat, 26 May 2001 16:18:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526161825.T9634@athlon.random>
In-Reply-To: <20010526051156.S9634@athlon.random> <Pine.LNX.4.21.0105252107010.1520-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105252107010.1520-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, May 25, 2001 at 09:22:05PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 09:22:05PM -0700, Linus Torvalds wrote:
> per zone, or that we have a real thinko somewhere that allows eating up

I think I found the real thinko for the create_buffers other deadlock
experienced by Ben, I suspect this fix is enough to address the
deadlock, this was real bug not just hiding factor (reserved bh aren't
released by irqs, the bounces frees memory, memory balancing stop, no bh
is released and we dealdock in wait_event), I also increased a bit the
reserved bh just in case:

--- 2.4.5pre6aa1/fs/buffer.c.~1~	Fri May 25 04:57:46 2001
+++ 2.4.5pre6aa1/fs/buffer.c	Sat May 26 16:15:03 2001
@@ -61,7 +61,7 @@
 
 #define BUFSIZE_INDEX(X) ((int) buffersize_index[(X)>>9])
 #define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
-#define NR_RESERVED (2*MAX_BUF_PER_PAGE)
+#define NR_RESERVED (10*MAX_BUF_PER_PAGE)
 #define MAX_UNUSED_BUFFERS NR_RESERVED+20 /* don't ever have more than this 
 					     number of unused buffer heads */
 
@@ -1416,11 +1416,9 @@
 	 */
 	run_task_queue(&tq_disk);
 
-	/* 
-	 * Set our state for sleeping, then check again for buffer heads.
-	 * This ensures we won't miss a wake_up from an interrupt.
-	 */
-	wait_event(buffer_wait, nr_unused_buffer_heads >= MAX_BUF_PER_PAGE);
+	current->policy |= SCHED_YIELD;
+	__set_current_state(TASK_RUNNING);
+	schedule();
 	goto try_again;
 }
 

please people with >1G machines try to reproduce the deadlock with
cerberus on top of 2.4.5 + the above patch.

I didn't checked the alloc_pages() other thing mentioned by Ben, if
alloc_pages() deadlocks internally that's yet another completly
orthogonal bug and that will be addressed by another patch if it
persists.

Andrea
