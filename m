Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTJUAJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTJUAJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:09:53 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:48811 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263057AbTJUAJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:09:39 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Karl Vogel <karl.vogel@seagha.com>
Date: Tue, 21 Oct 2003 10:09:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16276.31028.9351.994009@notabene.cse.unsw.edu.au>
Cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: LVM on md0: raid0_make_request bug: can't convert block across
	chunks or bigger than 64k
In-Reply-To: message from Karl Vogel on Monday October 20
References: <1066682115.1799.15.camel@kvo.local.org>
	<200310201606.09098.kevcorry@us.ibm.com>
	<1066686755.1146.6.camel@kvo.local.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 20, karl.vogel@seagha.com wrote:
> On Mon, 2003-10-20 at 23:06, Kevin Corry wrote:
> > On Monday 20 October 2003 15:35, Karl Vogel wrote:
> > > I'm getting the following kernel messages on V2.6.0-test8-mm1 (I've also
> > > tried plain -test7 and some kernels before that) when copying moderately
> > > sized files from a raid-0/LVM volume:
> > >
> > > --- snip ---
> > > raid0_make_request bug: can't convert block across chunks or bigger than
> > > 64k 24081064 64
> > > raid0_make_request bug: can't convert block across chunks or bigger than
> > > 64k 24080656 64
> > > raid0_make_request bug: can't convert block across chunks or bigger than
> > > 64k 24080784 64
> > > raid0_make_request bug: can't convert block across chunks or bigger than
> > > 64k 24080928 64
> > 
> > Looks like this was just recently fixed on the linux-raid list.
> > 
> > http://marc.theaimsgroup.com/?l=linux-raid&m=106661294929434
> 
> Applied the patch on 2.6.0-test8-mm1 but it made no difference.

no, thats a completely different problem.

> 
> Somebody else referred to this posting:
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=103369952814053&w=2
> 
> but that patch doesn't apply cleanly anymore and I'm not familiar with
> the code to be confident to fix it up myself. (that post was from almost
> exactly 1 year ago, so alot changed probably :)

That patch is already included.

The problem is that dm is not honouring the merge_bvec_fn that
raid0 has set.

This patch might fix it, but I'm not very familiar with the dm code,
so I make no promises.

(I wonder why you are running LVM on top of raid0 given that lvm
contains raid0 functionality).

NeilBrown



 ----------- Diffstat output ------------
 ./drivers/md/dm-table.c |    5 +++++
 1 files changed, 5 insertions(+)

diff ./drivers/md/dm-table.c~current~ ./drivers/md/dm-table.c
--- ./drivers/md/dm-table.c~current~	2003-10-21 10:05:29.000000000 +1000
+++ ./drivers/md/dm-table.c	2003-10-21 10:06:27.000000000 +1000
@@ -489,6 +489,11 @@ int dm_get_device(struct dm_target *ti, 
 		rs->max_sectors =
 			min_not_zero(rs->max_sectors, q->max_sectors);
 
+		if (q->merge_bvec_fn)
+			rs->max_sectors =
+				min_not_zero(rs->max_sectors, PAGE_SIZE>>9);
+			
+
 		rs->max_phys_segments =
 			min_not_zero(rs->max_phys_segments,
 				     q->max_phys_segments);
