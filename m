Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130661AbRA1Jts>; Sun, 28 Jan 2001 04:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132382AbRA1Jti>; Sun, 28 Jan 2001 04:49:38 -0500
Received: from relay3.inwind.it ([212.141.53.74]:58615 "EHLO relay3.inwind.it")
	by vger.kernel.org with ESMTP id <S130661AbRA1Jtb>;
	Sun, 28 Jan 2001 04:49:31 -0500
Message-Id: <3.0.6.32.20010128104843.01367eb0@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Sun, 28 Jan 2001 10:48:43 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: 2.4.1-pre10 deadlock (Re: ps hang in 241-pre10)
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.10.10101271524010.1076-100000@penguin.transmeta
 .com>
In-Reply-To: <3.0.6.32.20010127220102.01367ce0@pop.tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15.40 27/01/01 -0800, you wrote:
>
>
>On Sat, 27 Jan 2001, Lorenzo Allegrucci wrote:
>> 
>> A trivial "while(1) fork()" is enough to trigger it.
>> "mem=32M" by lilo, ulimit -u is 1024.
>
>Hmm.. This does not look like a VM deadlock - it looks like some IO
>request is waiting forever on "__get_request_wait()". In fact, it looks
>like a _lot_ of people are waiting for requests.
>
>So what happens is that somebody takes a page fault (and gets the mm
>lock), tries to read something in, and never gets anything back, thus
>leaving the MM locked.
>
>Jens: this looks suspiciously like somebody isn't waking things up when
>they add requests back to the request lists. Alternatively, maybe the
>unplugging isn't properly done, so that we have a lot of pending IO that
>doesn't get started..
>
>Ho humm. Jens: imagine that you have more people waiting for requests than
>"batchcount". Further, imagine that you have multiple requests finishing
>at the same time. Not unlikely. Now, imagine that one request finishes,
>and causes "batchcount" users to wake up, and immediately another request
>finishes but THAT one doesn't wake anybody up because it notices that the
>freelist isn't empty - so it thinks that it doesn't need to wake anybody.
>
>Lorenzo, does the problem go away for you if you remove the
>
>	if (!list_empty(&q->request_freelist[rw])) {
>		...
>	}
>
>code from blkdev_release_request() in drivers/block/ll_rw_block.c?

Yes, it does.

--
Lorenzo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
