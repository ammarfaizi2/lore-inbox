Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267670AbSLTAv0>; Thu, 19 Dec 2002 19:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267673AbSLTAv0>; Thu, 19 Dec 2002 19:51:26 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:59365 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267670AbSLTAvZ>; Thu, 19 Dec 2002 19:51:25 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Dan Merillat <harik@chaos.ao.net>
Date: Fri, 20 Dec 2002 11:59:17 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15874.27493.835799.195199@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raid5 multi-drive-failure and recovery?
In-Reply-To: message from Dan Merillat on Thursday December 19
References: <200212200049.gBK0n5NS016297@chaos.ao.net>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 19, harik@chaos.ao.net wrote:
> 
> I've got a problem.  Two drives in my array developed bad sectors at
> the same time.  They're in completely different places, but I can't
> read the disk because md simply fails out both of them, and marks the
> array unusable.
> 
> Now, I can either buy new drives and dd the raw partition over, or I
> can hack the kernel to make it a bit smarter about unrecoverable
> reads.
> 
> Obviously, if I have raid5_error not mark the drive bad, it will hammer
> away on it, failing over and over.  My thought was to let the read
> fail, catch it in raid5_end_read_request then tag the stripe_head
> with the device that's failed.  If one has already failed, return
> EIO.   This way further reads on the stripe_head will go to the parity
> disk (until it's eventually freed.  One IO error per stripe isn't too
> harsh a price to pay for disaster recovery)
> 
> in 2.4.20, I'm at raid5.c:421 where we're about to call md_error.
> What happens to the bh from that point?  Obviously, it's not up-to-date,
> so when 1 drive fails how does it get re-issued to be pulled from a parity
> drive to reconstruct it?

Nothing much happens to the bh.  It just has Uptodate cleared.

A little later (line 433) we call release_stripe.  Once all the active
IO requests have finished the stripe will be completely released and
handle_stripe gets called (from raid5d) to handle the stripe.
It notices there is a block that is being read (bh_read) but that
isn't uptodate, and so tries to schedule a read.  Line 949 notices
that the block it wants to read is on a failed drive, so it causes all
blocks to be read in.  Once they are read in, handle_stripe gets
called again, and this time it gets to line 955 where it computes the
block that you want.

What you want to do is add a 'failed_drive' field to the stripe_head
which gets initialised to -1 in init_stripe, and set at line 421
instead of calling md_error.  Then in handle_stripe, line 875 changes
from
		if (!conf->disks[i].operational) {
to
		if (!conf->disks[i].operational || sh->failed_drive == i) {
and it might just work for you.

Good luck
NeilBrown
