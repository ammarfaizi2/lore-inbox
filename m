Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVHaMHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVHaMHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVHaMHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:07:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9404 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964773AbVHaMHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:07:12 -0400
Date: Wed, 31 Aug 2005 14:07:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
Message-ID: <20050831120714.GT4018@suse.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de> <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de> <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31 2005, Holger Kiehl wrote:
> >>>Ok, I did run the following dd command in different combinations:
> >>>
> >>>   dd if=/dev/zero of=/dev/sd?1 bs=4k count=5000000
> >>
> >>I think a bs of 4k is way too small and will cause huge CPU overhead.
> >>Can you try with something like 4M? Also, you can use /dev/full to avoid
> >>the pre-zeroing.
> >
> >That was my initial thought as well, but since he's writing the io side
> >should look correct. I doubt 8 dd's writing 4k chunks will gobble that
> >much CPU as to make this much difference.
> >
> >Holger, we need vmstat 1 info while the dd's are running. A simple
> >profile would be nice as well, boot with profile=2 and do a readprofile
> >-r; run tests; readprofile > foo and send the first 50 lines of foo to
> >this list.
> >
> Here vmstat for 8 dd's still with 4k blocksize:
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- 
> ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id 
>  wa
>  9  2   5244  38272 7738248  10400    0    0     3 11444  390    24  0  5 
>  75 20
>  5 10   5244  30824 7747680   8684    0    0     0 265672 2582  1917  1 95  
>  0  4
>  2 12   5244  30948 7747248   8708    0    0     0 222620 2858   292  0 33  
>  0 67
>  4 10   5244  31072 7747516   8644    0    0     0 236400 3132   326  0 43  
>  0 57
>  2 12   5244  31320 7747792   8512    0    0     0 250204 3225   285  0 37  
>  0 63
>  1 13   5244  30948 7747412   8552    0    0    24 227600 3261   312  0 41  
>  0 59
>  2 12   5244  32684 7746124   8616    0    0     0 235392 3219   274  0 32  
>  0 68

[snip]

Looks as expected, nothing too excessive showing up. About 30-40% sys
time, but it should not bog the machine down that much.

> And here the profile output (I assume you meant sorted):

I did, thanks :)

> 3236497 total                                      1.4547
> 2507913 default_idle                             52248.1875
> 158752 shrink_zone                               43.3275
> 121584 copy_user_generic_c                      3199.5789
>  34271 __wake_up_bit                            713.9792
>  31131 __make_request                            23.1629
>  22096 scsi_request_fn                           18.4133
>  21915 rotate_reclaimable_page                   80.5699
>  20641 end_buffer_async_write                    86.0042
>  18701 __clear_user                             292.2031

Nothing sticks out here either. There's plenty of idle time. It smells
like a driver issue. Can you try the same dd test, but read from the
drives instead? Use a bigger blocksize here, 128 or 256k.

You might want to try the same with direct io, just to eliminate the
costly user copy. I don't expect it to make much of a difference though,
feels like the problem is elsewhere (driver, most likely).

If we still can't get closer to this, it would be interesting to try my
block tracing stuff so we can see what is going on at the queue level.
But lets gather some more info first, since it requires testing -mm.

-- 
Jens Axboe

