Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130265AbQKUPms>; Tue, 21 Nov 2000 10:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130802AbQKUPmi>; Tue, 21 Nov 2000 10:42:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33037 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130319AbQKUPm3>; Tue, 21 Nov 2000 10:42:29 -0500
Date: Tue, 21 Nov 2000 16:12:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kumon@flab.fujitsu.co.jp
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
        Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
Message-ID: <20001121161217.B26625@athlon.random>
In-Reply-To: <200011210828.RAA27311@asami.proc.flab.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011210828.RAA27311@asami.proc.flab.fujitsu.co.jp>; from kumon@flab.fujitsu.co.jp on Tue, Nov 21, 2000 at 05:28:40PM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 05:28:40PM +0900, kumon@flab.fujitsu.co.jp wrote:
> @@ -47,6 +47,11 @@
>  			break;
>  		tmp->elevator_sequence--;
>  	}
> +	if (entry == head) {
> +		tmp = blkdev_entry_to_request(entry);
> +		if (IN_ORDER(req, tmp))
> +			entry = real_head->prev;
> +	}
>  	list_add(&req->queue, entry);
>  }

This patch is buggy. head with scsi doesn't point to a request so it
doesn't make sense to compare it.

> To implement a complete elevator scheduling, preparing an alternate

Complete elevator scheduling is _just_ implemented, but it's enterely disabled.
You should always enable it before running a 2.4.x kernel. To do that use
elvtune or apply this patch:

--- 2.4.0-test11-pre6/include/linux/elevator.h.~1~	Wed Jul 19 06:43:10 2000
+++ 2.4.0-test11-pre6/include/linux/elevator.h	Tue Nov 21 15:57:51 2000
@@ -100,8 +100,8 @@
 ((elevator_t) {							\
 	0,				/* not used */		\
 								\
-	1000000,				/* read passovers */	\
-	2000000,				/* write passovers */	\
+	500,				/* read passovers */	\
+	1000,				/* write passovers */	\
 	0,				/* max_bomb_segments */	\
 								\
 	0,				/* not used */		\


The "DoS" attack is the bug that is been fixed by implementing the new elevator
with proper scheduling.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
