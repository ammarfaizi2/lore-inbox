Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270200AbTHLLyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270210AbTHLLyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:54:15 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:20912 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270200AbTHLLyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:54:14 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: mb <mb/lkml@dcs.qmul.ac.uk>
Date: Tue, 12 Aug 2003 21:53:31 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16184.54587.28573.816157@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1, ext3 (external journal): nasty filesystem corruption
 under high load
In-Reply-To: message from mb on Tuesday August 12
References: <Pine.LNX.4.56.0308121058230.2147@r2-pc.dcs.qmul.ac.uk>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 12, mb/lkml@dcs.qmul.ac.uk wrote:
> Hi,
> 
> Admittedly I was being pathological, but I've got a new toy to play with!
> Our new server is a dual-Athlon, 1.5G RAM (the other .5 failed memtest) +
> about 6GB swap, with 15x70GB drives running under gdth.o with 12 as the
> RAID-5 set, and the journal on 2 as a RAID-1 pair. System on IDE for now.
> 
> It's currently running Red Hat "severn" + 2.6.0-test2-mm1 (with PREEMPT
> for now), and this particular stress test was attempting to build 
> 2.6.0-test3-mm1 with the scary invocation "make -j". More info on request.
> 
> I saw thousands of messages like:
> 	cc1: page allocation failure. order:0, mode:0x20
> (where only the process names might change). I don't know how Bad
> this is.

I think this si just noise.  0x20 is GFP_ATOMIC, and you expect atomic
allocations to fail sometimes.

> 
> Amazingly I could still ssh in to the box and discover that its load had
> more than likely broken 1000. However, the compile started to complain
> bitterly about non-ASCII characters in source files, and indeed corruption
> did occur (random overwriting, it would appear).

Almost certainly a raid5 bug, fix by the following patch.

NeilBrown

==========================================================================
Disable raid5 handling of read-ahead

raid5 trys to honour RWA_MASK, but messes it up and can return bad data.
Just ignore RAW_MASK for now.

 ----------- Diffstat output ------------
 ./drivers/md/raid5.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2003-08-11 09:01:44.000000000 +1000
+++ ./drivers/md/raid5.c	2003-08-11 09:01:44.000000000 +1000
@@ -1326,7 +1326,7 @@ static int make_request (request_queue_t
 			(unsigned long long)new_sector, 
 			(unsigned long long)logical_sector);
 
-		sh = get_active_stripe(conf, new_sector, pd_idx, (bi->bi_rw&RWA_MASK));
+		sh = get_active_stripe(conf, new_sector, pd_idx, 0/*(bi->bi_rw&RWA_MASK)*/);
 		if (sh) {
 
 			add_stripe_bio(sh, bi, dd_idx, (bi->bi_rw&RW_MASK));
