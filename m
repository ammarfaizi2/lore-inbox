Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271150AbTHQXO2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 19:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271152AbTHQXO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 19:14:28 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:12523 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S271150AbTHQXO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 19:14:26 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Mon, 18 Aug 2003 09:14:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16192.3135.69070.901901@gargle.gargle.HOWL>
Cc: Joe Thornber <thornber@sistina.com>, Andrew Morton <akpm@osdl.org>,
       Tupshin Harper <tupshin@tupshin.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
In-Reply-To: message from Mike Fedyk on Sunday August 17
References: <3F3951F1.9040605@tupshin.com>
	<20030812142846.46eacc48.akpm@osdl.org>
	<16185.29398.80225.875488@gargle.gargle.HOWL>
	<20030815212707.GR1027@matchmail.com>
	<16189.58517.211393.526998@gargle.gargle.HOWL>
	<20030816235245.GU1027@matchmail.com>
	<16190.51307.990399.306100@gargle.gargle.HOWL>
	<20030817175050.GX1027@matchmail.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday August 17, mfedyk@matchmail.com wrote:
> On Sun, Aug 17, 2003 at 10:12:27AM +1000, Neil Brown wrote:
> > On Saturday August 16, mfedyk@matchmail.com wrote:
> > > I have a raid5 with "4" 18gb drives, and one of the "drives" is two 9gb
> > > drives in a linear md "array".
> > > 
> > > I'm guessing this will hit this bug too?
> > 
> > This should be safe.  raid5 only ever submits 1-page (4K) requests
> > that are page aligned, and linear arrays will have the boundary
> > between drives 4k aligned (actually "chunksize" aligned, and chunksize
> > is atleast 4k). 
> > 
> 
> So why is this hitting with raid0?  Is lvm2 on top of md the problem and md
> on lvm2 is ok?
> 

The various raid levels under md are in many ways quite independent.
You cannot generalise about "md works" or "md doesn't work", you have
to talk about the specific raid levels.

The problem happens when 
 1/ The underlying device defines a merge_bvec_fn, and 
 2/ the driver (meta-device) that uses that device
     2a/  does not honour the merge_bvec_fn, and 
     2b/  passes on requests larger than one page.

md/linear, md/raid0, and lvm all define a merge_bvec_fn, and so can be
a problem as an underlying device by point (1).

md/* and lvm do not honour merge_bvec_fn and so can be a problem as a
meta-device by 2a.
However md/raid5 never passes on requests larger than one page, so it
escapes being a problem by point 2b.

So the problem can happen with
  md/linear, md/raid0, or lvm being a component of 
  md/linear, md/raid0, md/raid1, md/multipath, lvm.

(I have possibly oversimplified the situation with lvm due to lack of
precise knowledge).

I hope that clarifies the situation.

> > So raid5 should be safe over everything (unless dm allows striping
> > with a chunk size less than pagesize).
> > 
> > Thinks: as an interim solution of other raid levels - if the
> > underlying device has a merge_bvec_function which is being ignored, we
> > could set max_sectors to PAGE_SIZE/512.  This should be safe, though
> > possibly not optimal (but "safe" is trumps "optimal" any day).
> 
> Assuming that sectors are always 512 bytes (true for any hard drive I've
> seen) that will be 512 * 8 = one 4k page.
> 
> Any chance sector != 512?

No.  'sector' in the kernel means '512 bytes'.
Some devices might request requests to be at least 2 sectors long and
have even sector addresses because they have physical sectors that are
1K, but the parameters like max_sectors are still in multiples of 512
bytes.

NeilBrown
