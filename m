Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbTGQUCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbTGQUB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:01:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:5789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269291AbTGQUBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:01:40 -0400
Date: Thu, 17 Jul 2003 13:09:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: petero2@telia.com, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
Message-Id: <20030717130906.0717b30d.akpm@osdl.org>
In-Reply-To: <20030717200039.GA227@elf.ucw.cz>
References: <m2wueh2axz.fsf@telia.com>
	<20030717200039.GA227@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> > --- linux/mm/vmscan.c.old	Thu Jul 17 21:30:09 2003
> > +++ linux/mm/vmscan.c	Thu Jul 17 21:29:58 2003
> > @@ -930,7 +930,7 @@
> >  		}
> >  		if (all_zones_ok)
> >  			break;
> > -		blk_congestion_wait(WRITE, HZ/10);
> > +		blk_congestion_wait(WRITE, HZ/50);
> >  	}
> >  	return nr_pages - to_free;
> >  }
> 
> This is certainly not okay. Andrew, you know more about vm
> internals... What does this ugly constant mean?

Most of the time the timeout is a "can't happen" - blk_congestion_wait() is
terminated by completion of writeout.  The timeout is mainly there to
prevent hangs if weird and rare races happen.  Otherwise we'd need lots
more locking.

I don't think we want to be calling it at all if reclaim is working well. 
Something like this.


diff -puN mm/vmscan.c~a mm/vmscan.c
--- 25/mm/vmscan.c~a	Thu Jul 17 13:05:36 2003
+++ 25-akpm/mm/vmscan.c	Thu Jul 17 13:05:58 2003
@@ -921,7 +921,7 @@ static int balance_pgdat(pg_data_t *pgda
 			if (i < ZONE_HIGHMEM) {
 				reclaim_state->reclaimed_slab = 0;
 				shrink_slab(max_scan + nr_mapped, GFP_KERNEL);
-				to_free += reclaim_state->reclaimed_slab;
+				to_free -= reclaim_state->reclaimed_slab;
 			}
 			if (zone->all_unreclaimable)
 				continue;
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

_

