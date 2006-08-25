Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422842AbWHYFYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422842AbWHYFYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 01:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422841AbWHYFYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 01:24:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55443 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422840AbWHYFYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 01:24:46 -0400
From: Neil Brown <neilb@suse.de>
To: David Chinner <dgc@sgi.com>
Date: Fri, 25 Aug 2006 15:24:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17646.35231.690105.300713@cse.unsw.edu.au>
Cc: Andi Kleen <ak@suse.de>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
In-Reply-To: message from David Chinner on Tuesday August 22
References: <20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<20060818001102.GW51703024@melbourne.sgi.com>
	<20060817232942.c35b1371.akpm@osdl.org>
	<20060818070314.GE798@suse.de>
	<p73hd0998is.fsf@verdi.suse.de>
	<17640.65491.458305.525471@cse.unsw.edu.au>
	<20060821031505.GQ51703024@melbourne.sgi.com>
	<17641.24478.496091.79901@cse.unsw.edu.au>
	<20060821142802.GU51703024@melbourne.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 22, dgc@sgi.com wrote:
> On Mon, Aug 21, 2006 at 05:24:14PM +1000, Neil Brown wrote:
> > So my feeling (at the moment) is that balance_dirty_pages should look
> > like:
> > 
> >  if below threshold 
> >        return
> >  writeback_inodes({.bdi = mapping->backing_dev_info)} )
> > 
> >  while (above threshold + 10%)
> >         writeback_inodes(.bdi = NULL)
> >         blk_congestion_wait
> > 
> > and all bdis should impose a queue limit.
> 
> I don't really like the "+ 10%" in there - it's too rubbery given
> the range of memory sizes Linux supports (think of an Altix with
> several TBs of RAM in it ;). With bdis imposing a queue limit, the
> number of writeback pages should be bound  and so we shouldn't need
> headroom like this.

I had that there precisely because some BDIs are not bounded - nfs in
particular (which is what started this whole thread).
I think I'm now convinced that nfs really need to limit its writeout
queue. 

> 
> Hmmm - the above could put the writer to sleep on the request queue
> of the slow device that holds all dirty+writeback. This could
> effectively slow all writers down to the rate of the slowest device
> in the system as they all attempt to do blocking writeback on the
> only dirty bdi (the really slow one).


> 
> AFAICT, all we need to do is prevent interactions between bdis and
> the current problem is that we loop on clean bdis waiting for slow
> dirty ones to drain.
> 
> My thoughts are along the lines of a decay in nr_to_write between
> loop iterations when we don't write out enough pages (i.e. clean
> bdi) so we break out of the loop sooner rather than later.

I don't understand the purpose of the decay.  Once you are sure the
bdi is clean, why not break out of the loop straight away?

Also, your code is a little confusing.  The 
  pages_written += write_chunk - wbc.nr_to_write
in the loop assumes that wbc.nr_to_write equalled write_chunk just
before the call to writeback_inodes, however as you have moved the
initialisation of wbc out of the loop, this is no longer true.

So I would like us to break out of the loop as soon as there is good
reason to believe the bdi is clean.

So maybe something like this..
Note that we *must* have bounded queue on all bdis or this patch can
cause substantial badness.

NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./mm/page-writeback.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff .prev/mm/page-writeback.c ./mm/page-writeback.c
--- .prev/mm/page-writeback.c	2006-08-25 15:18:37.000000000 +1000
+++ ./mm/page-writeback.c	2006-08-25 15:22:39.000000000 +1000
@@ -187,7 +187,7 @@ static void balance_dirty_pages(struct a
 			.bdi		= bdi,
 			.sync_mode	= WB_SYNC_NONE,
 			.older_than_this = NULL,
-			.nr_to_write	= write_chunk,
+			.nr_to_write	= write_chunk - pages_written,
 			.range_cyclic	= 1,
 		};
 
@@ -217,10 +217,13 @@ static void balance_dirty_pages(struct a
 				global_page_state(NR_WRITEBACK)
 					<= dirty_thresh)
 						break;
-			pages_written += write_chunk - wbc.nr_to_write;
+			if (pages_written == write_chunk - wbc.nr_to_write)
+				break;		/* couldn't write - must be clean */
+			pages_written = write_chunk - wbc.nr_to_write;
 			if (pages_written >= write_chunk)
 				break;		/* We've done our duty */
-		}
+		} else
+			break;
 		blk_congestion_wait(WRITE, HZ/10);
 	}
 
