Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270350AbTGRUIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270352AbTGRUIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:08:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:58844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270350AbTGRUIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:08:00 -0400
Date: Fri, 18 Jul 2003 13:15:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
Message-Id: <20030718131527.7cf4ca5e.akpm@osdl.org>
In-Reply-To: <m2oezrppxo.fsf@telia.com>
References: <m2wueh2axz.fsf@telia.com>
	<20030717200039.GA227@elf.ucw.cz>
	<20030717130906.0717b30d.akpm@osdl.org>
	<m2d6g8cg06.fsf@telia.com>
	<20030718032433.4b6b9281.akpm@osdl.org>
	<20030718152205.GA407@elf.ucw.cz>
	<m2el0nvnhm.fsf@telia.com>
	<20030718094542.07b2685a.akpm@osdl.org>
	<m2oezrppxo.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> The patch below works, but doesn't really solve anything, because it
> is just as slow as the original code.

That's OK - it's a step in the right direction.

> This is not surprising because
> it is still balance_pgdat() that does the page freeing, the only
> difference being that it is now called from kswapd which is woken up
> by the alloc_page() call.

Yup.  Probaby we should not be throttling kswapd if it is making good
progress, but this needs broad testing and thought.  Something like this,
untested:


--- 25/mm/vmscan.c~less-kswapd-throttling	Thu Jul 17 15:35:09 2003
+++ 25-akpm/mm/vmscan.c	Thu Jul 17 15:35:12 2003
@@ -930,7 +930,8 @@ static int balance_pgdat(pg_data_t *pgda
 		}
 		if (all_zones_ok)
 			break;
-		blk_congestion_wait(WRITE, HZ/10);
+		if (to_free)
+			blk_congestion_wait(WRITE, HZ/10);
 	}
 	return nr_pages - to_free;
 }


> Note that I had to use HZ/5 in free_some_memory() or else the loop
> would terminate too early. The main problem seems to be that
> balance_pgdat() is too slow when freeing memory. The function can fail
> to free memory in the inner loop either because the disk is congested
> or because too few pages are scanned, but in both cases the function
> calls blk_congestion_wait(), and in the second case the disk may be
> idle and then blk_congestion_wait() doesn't return until the timeout
> expires.

hm, perhaps because kswapd is throttled rather than doing work.

Try the above change, see if you still need the extended timeout in
free_some_memory().

Also, play around with using __GFP_WAIT|__GFP_HIGH|__GFP_NORETRY rather
than GFP_ATOMIC.


