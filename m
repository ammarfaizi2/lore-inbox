Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbTJUQ3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 12:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTJUQ3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 12:29:35 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:13976 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263188AbTJUQ3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 12:29:32 -0400
Subject: Re: LVM on md0: raid0_make_request bug: can't convert block across
	chunks or bigger than 64k
From: Karl Vogel <karl.vogel@seagha.com>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Joe Thornber <thornber@sistina.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200310210841.45452.kevcorry@us.ibm.com>
References: <1066682115.1799.15.camel@kvo.local.org>
	 <1066686755.1146.6.camel@kvo.local.org>
	 <16276.31028.9351.994009@notabene.cse.unsw.edu.au>
	 <200310210841.45452.kevcorry@us.ibm.com>
Content-Type: text/plain
Message-Id: <1066753760.1161.4.camel@kvo.local.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Tue, 21 Oct 2003 18:29:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 15:41, Kevin Corry wrote:
> On Monday 20 October 2003 19:09, Neil Brown wrote:
> > On Monday October 20, karl.vogel@seagha.com wrote:
> > > On Mon, 2003-10-20 at 23:06, Kevin Corry wrote:
> > > > On Monday 20 October 2003 15:35, Karl Vogel wrote:
> > > > > I'm getting the following kernel messages on V2.6.0-test8-mm1 (I've
> > > > > also tried plain -test7 and some kernels before that) when copying
> > > > > moderately sized files from a raid-0/LVM volume:
> > > > >
> > > > > --- snip ---
> > > > > raid0_make_request bug: can't convert block across chunks or bigger
> > > > > than 64k 24081064 64
> > > > > raid0_make_request bug: can't convert block across chunks or bigger
> > > > > than 64k 24080656 64
> > > > > raid0_make_request bug: can't convert block across chunks or bigger
> > > > > than 64k 24080784 64
> > > > > raid0_make_request bug: can't convert block across chunks or bigger
> > > > > than 64k 24080928 64
> > > >
> > > > Looks like this was just recently fixed on the linux-raid list.
> > > >
> > > > http://marc.theaimsgroup.com/?l=linux-raid&m=106661294929434
> > >
> > > Applied the patch on 2.6.0-test8-mm1 but it made no difference.
> >
> > no, thats a completely different problem.
> 
> Sorry for the confusion. Karl's error messages looked just like ones that were 
> reported on the evms-devel list, which were supposedly fixed by the above 
> patch.
> 
> > The problem is that dm is not honouring the merge_bvec_fn that
> > raid0 has set.
> >
> > This patch might fix it, but I'm not very familiar with the dm code,
> > so I make no promises.
> >
> >  ----------- Diffstat output ------------
> >  ./drivers/md/dm-table.c |    5 +++++
> >  1 files changed, 5 insertions(+)
> >
> > diff ./drivers/md/dm-table.c~current~ ./drivers/md/dm-table.c
> > --- ./drivers/md/dm-table.c~current~	2003-10-21 10:05:29.000000000 +1000
> > +++ ./drivers/md/dm-table.c	2003-10-21 10:06:27.000000000 +1000
> > @@ -489,6 +489,11 @@ int dm_get_device(struct dm_target *ti,
> >  		rs->max_sectors =
> >  			min_not_zero(rs->max_sectors, q->max_sectors);
> >
> > +		if (q->merge_bvec_fn)
> > +			rs->max_sectors =
> > +				min_not_zero(rs->max_sectors, PAGE_SIZE>>9);
> > +
> > +
> >  		rs->max_phys_segments =
> >  			min_not_zero(rs->max_phys_segments,
> >  				     q->max_phys_segments);
> 
> This will probably work, as long as raid0 can split a one-page request that 
> spans a chunk boundary. I'll be interested to see if this solves Karl's 
> problem.

Good news... it solves the problem with my setup. I was able to copy
files off the logical volume (did an md5sum compare to make sure I got
the complete files.)


> Joe Thornber was telling me about an idea he had to solve the 
> Device-Mapper-on-top-of-MD problem using the dm-io code in his latest 
> Device-Mapper patchset 
> (http://people.sistina.com/~thornber/patches/2.6/2.6.0-test6/2.6.0-t6-mm1-dm2.tar.bz2). 
> I believe he's away for this week, but I'll ask him about it again the next 
> time I talk to him.


