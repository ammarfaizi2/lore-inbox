Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271817AbTGRKHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271813AbTGRKFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:05:52 -0400
Received: from maile.telia.com ([194.22.190.16]:45556 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id S271532AbTGRJrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:47:48 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz>
	<20030717130906.0717b30d.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 18 Jul 2003 11:59:21 +0200
In-Reply-To: <20030717130906.0717b30d.akpm@osdl.org>
Message-ID: <m2d6g8cg06.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > > --- linux/mm/vmscan.c.old	Thu Jul 17 21:30:09 2003
> > > +++ linux/mm/vmscan.c	Thu Jul 17 21:29:58 2003
> > > @@ -930,7 +930,7 @@
> > >  		}
> > >  		if (all_zones_ok)
> > >  			break;
> > > -		blk_congestion_wait(WRITE, HZ/10);
> > > +		blk_congestion_wait(WRITE, HZ/50);
> > >  	}
> > >  	return nr_pages - to_free;
> > >  }
> > 
> > This is certainly not okay. Andrew, you know more about vm
> > internals... What does this ugly constant mean?
> 
> Most of the time the timeout is a "can't happen" - blk_congestion_wait() is
> terminated by completion of writeout.  The timeout is mainly there to
> prevent hangs if weird and rare races happen.  Otherwise we'd need lots
> more locking.
> 
> I don't think we want to be calling it at all if reclaim is working well. 
> Something like this.
...
> -		blk_congestion_wait(WRITE, HZ/10);
> +		if (to_free)
> +			blk_congestion_wait(WRITE, HZ/10);

It doesn't make any difference in my tests. to_free is very large when
called from the suspend code, so it almost never becomes zero.

With the patch below, page freeing is very fast on my computer. The
idea is to not call blk_congestion_wait at all until we can't make any
more progress. Then make the call, try again, and if we still can't
make any more progress, give up.

I've tested this patch in two scenarios. The first is to boot rh7.3 on
a 256MB computer to runlevel 3, log in and start emacs, then
immediately suspend. The old code could easily take 15s while the new
code runs in ~1s.

The second test case was to also start a program that allocates 200MB
and goes to sleep. The new code swaps out all data and the disk light
is turned on constantly. The old code swapped out some data (the disk
light was not turned on constantly), then gave up and failed to
suspend. (I only tested the old code once. Maybe this was just "bad
luck".)

If this patch is an acceptable approach to fix the problem, the
balance_pgdat function should probably be cleaned up. We either call
it with nr_pages=0 (from kswapd) or nr_pages="big number" (from
shrink_all_memory). Maybe we should replace the nr_pages parameter
with a boolean parameter, or just split the function in two. It should
be possible to make some simplifications for the "free as much as
possible" case.

What do you think?

diff -u -r orig/linux-p1/kernel/suspend.c linux-p1/kernel/suspend.c
--- orig/linux-p1/kernel/suspend.c	Sat Jul 12 00:52:16 2003
+++ linux-p1/kernel/suspend.c	Fri Jul 18 11:30:29 2003
@@ -621,9 +621,20 @@
  */
 static void free_some_memory(void)
 {
+	int state = 0;
+
 	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
+	for (;;) {
+		if (shrink_all_memory(10000)) {
+			state = 0;
+		} else {
+			state++;
+			if (state > 1)
+				break;
+			blk_congestion_wait(WRITE, HZ/5);
+		}
 		printk(".");
+	}
 	printk("|\n");
 }
 
diff -u -r orig/linux-p1/mm/vmscan.c linux-p1/mm/vmscan.c
--- orig/linux-p1/mm/vmscan.c	Mon Jul 14 09:07:43 2003
+++ linux-p1/mm/vmscan.c	Fri Jul 18 11:30:38 2003
@@ -921,7 +921,7 @@
 			if (i < ZONE_HIGHMEM) {
 				reclaim_state->reclaimed_slab = 0;
 				shrink_slab(max_scan + nr_mapped, GFP_KERNEL);
-				to_free += reclaim_state->reclaimed_slab;
+				to_free -= reclaim_state->reclaimed_slab;
 			}
 			if (zone->all_unreclaimable)
 				continue;
@@ -930,7 +930,8 @@
 		}
 		if (all_zones_ok)
 			break;
-		blk_congestion_wait(WRITE, HZ/10);
+		if (nr_pages == 0)
+			blk_congestion_wait(WRITE, HZ/10);
 	}
 	return nr_pages - to_free;
 }

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
