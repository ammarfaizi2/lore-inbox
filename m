Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267648AbTBYFfP>; Tue, 25 Feb 2003 00:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267674AbTBYFfP>; Tue, 25 Feb 2003 00:35:15 -0500
Received: from packet.digeo.com ([12.110.80.53]:52221 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267648AbTBYFfN>;
	Tue, 25 Feb 2003 00:35:13 -0500
Date: Mon, 24 Feb 2003 21:45:43 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jonah Sherman <jsherman@stuy.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.5.63 - NULL pointer dereference in loop device
Message-Id: <20030224214543.0e9e2de7.akpm@digeo.com>
In-Reply-To: <20030224212530.GA631@j0nah.ath.cx>
References: <20030224212530.GA631@j0nah.ath.cx>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 05:45:21.0178 (UTC) FILETIME=[15AC57A0:01C2DC91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonah Sherman <jsherman@stuy.edu> wrote:
>
> I have come across a bug in the loop driver.

So you have.  See, the `dd' fills the machine up with dirty memory and the
loop driver wants to take a copy of all that memory to write it out.  It takes
this copy inside page reclaim, where we are allowed to use *all* memory.

So obviously, as there is so much memory to be written, we just run out of
the stuff.

The loop driver has a tendency to do this sort of thing.  Whenever it does,
we slap another bandaid on it.  


diff -puN drivers/block/loop.c~loop-hack drivers/block/loop.c
--- 25/drivers/block/loop.c~loop-hack	2003-02-24 21:21:11.000000000 -0800
+++ 25-akpm/drivers/block/loop.c	2003-02-24 21:45:13.000000000 -0800
@@ -447,7 +447,22 @@ static struct bio *loop_get_buffer(struc
 		goto out_bh;
 	}
 
-	bio = bio_copy(rbh, GFP_NOIO, rbh->bi_rw & WRITE);
+	/*
+	 * When called on the page reclaim -> writepage path, this code can
+	 * trivially consume all memory.  So we drop PF_MEMALLOC to avoid
+	 * stealing all the page reserves and throttle to the writeout rate.
+	 * pdflush will have been woken by page reclaim.  Let it do its work.
+	 */
+	do {
+		int flags = current->flags;
+
+		current->flags &= ~PF_MEMALLOC;
+		bio = bio_copy(rbh, (GFP_ATOMIC & ~__GFP_HIGH) | __GFP_NOWARN,
+					rbh->bi_rw & WRITE);
+		current->flags = flags;
+		if (bio == NULL)
+			blk_congestion_wait(WRITE, HZ/10);
+	} while (bio == NULL);
 
 	bio->bi_end_io = loop_end_io_transfer;
 	bio->bi_private = rbh;

_

