Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130330AbQL1Tw4>; Thu, 28 Dec 2000 14:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbQL1Twr>; Thu, 28 Dec 2000 14:52:47 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:24847 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130382AbQL1Twe>; Thu, 28 Dec 2000 14:52:34 -0500
Date: Thu, 28 Dec 2000 14:19:19 -0500
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <447650000.978031159@coffee>
In-Reply-To: <3A4B60FA.FD05ED4C@innominate.de>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, December 28, 2000 16:49:14 +0100 Daniel Phillips <phillips@innominate.de> wrote:

[ dbench 48 test on the anon space mapping patch ]

> 
> This benchmark doesn't seem to suffer a lot from noise, so the 7%
> slowdown with your patch likely real.
> 

Ok, page_launder is supposed to run through the inactive dirty
list twice, and on the second run, it wants to start i/o.  But,
if the page is dirty, writepage is called on the first run.  With
my patch, this flushes lots more data than it used to.  

I have writepage doing all the i/o, and try_to_free_buffers
only waits on it.  This diff makes it so writepage is only called
on the second loop through the inactive dirty list, could you 
please give it a try (slightly faster in my tests).

Linus and Rik are cc'd in to find out if this is a good idea in
general.

-chris

--- linux-test13-pre4/mm/vmscan.c	Sat Dec 23 13:14:26 2000
+++ linux/mm/vmscan.c	Thu Dec 28 15:02:08 2000
@@ -609,7 +609,7 @@
 				goto page_active;
 
 			/* Can't start IO? Move it to the back of the list */
-			if (!can_get_io_locks) {
+			if (!launder_loop || !can_get_io_locks) {
 				list_del(page_lru);
 				list_add(page_lru, &inactive_dirty_list);
 				UnlockPage(page);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
