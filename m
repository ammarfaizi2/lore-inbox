Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271191AbTHRA2l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271194AbTHRA2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:28:41 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:43023
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271191AbTHRA2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:28:39 -0400
Date: Sun, 17 Aug 2003 17:28:33 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Joe Thornber <thornber@sistina.com>, Andrew Morton <akpm@osdl.org>,
       Tupshin Harper <tupshin@tupshin.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
Message-ID: <20030818002833.GB6125@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Joe Thornber <thornber@sistina.com>, Andrew Morton <akpm@osdl.org>,
	Tupshin Harper <tupshin@tupshin.com>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>
References: <3F3951F1.9040605@tupshin.com> <20030812142846.46eacc48.akpm@osdl.org> <16185.29398.80225.875488@gargle.gargle.HOWL> <20030815212707.GR1027@matchmail.com> <16189.58517.211393.526998@gargle.gargle.HOWL> <20030816235245.GU1027@matchmail.com> <16190.51307.990399.306100@gargle.gargle.HOWL> <20030817175050.GX1027@matchmail.com> <16192.3135.69070.901901@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16192.3135.69070.901901@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 09:14:07AM +1000, Neil Brown wrote:
> The various raid levels under md are in many ways quite independent.
> You cannot generalise about "md works" or "md doesn't work", you have
> to talk about the specific raid levels.
> 
> The problem happens when 
>  1/ The underlying device defines a merge_bvec_fn, and 
>  2/ the driver (meta-device) that uses that device
>      2a/  does not honour the merge_bvec_fn, and 
>      2b/  passes on requests larger than one page.
> 
> md/linear, md/raid0, and lvm all define a merge_bvec_fn, and so can be
> a problem as an underlying device by point (1).
> 
> md/* and lvm do not honour merge_bvec_fn and so can be a problem as a
> meta-device by 2a.
> However md/raid5 never passes on requests larger than one page, so it
> escapes being a problem by point 2b.
> 
> So the problem can happen with
>   md/linear, md/raid0, or lvm being a component of 
>   md/linear, md/raid0, md/raid1, md/multipath, lvm.
> 
> (I have possibly oversimplified the situation with lvm due to lack of
> precise knowledge).
> 
> I hope that clarifies the situation.

Thanks Neil.  That was very informative. :)

> > On Sun, Aug 17, 2003 at 10:12:27AM +1000, Neil Brown wrote:
> > > So raid5 should be safe over everything (unless dm allows striping
> > > with a chunk size less than pagesize).
> > > 
> > > Thinks: as an interim solution of other raid levels - if the
> > > underlying device has a merge_bvec_function which is being ignored, we
> > > could set max_sectors to PAGE_SIZE/512.  This should be safe, though
> > > possibly not optimal (but "safe" is trumps "optimal" any day).
> > 
> > Assuming that sectors are always 512 bytes (true for any hard drive I've
> > seen) that will be 512 * 8 = one 4k page.
> > 
> > Any chance sector != 512?
> 
> No.  'sector' in the kernel means '512 bytes'.
> Some devices might request requests to be at least 2 sectors long and
> have even sector addresses because they have physical sectors that are
> 1K, but the parameters like max_sectors are still in multiples of 512
> bytes.
> 
> NeilBrown

Any idea of the ETA for that nice interim patch?

And if there is already a merge_bvec_function defined and coded, why is it
not being used?!  Isn't that supposed to be detected by the BIO sybsystem,
and used automatically when it's defined?  Or were there some bugs found in
it and it was disabled temporarily?  Maybe not everyone agrees on bio
spliting/merging?  (I seem to recall a thread about that a while back, but I
thougth it was resolved...)
