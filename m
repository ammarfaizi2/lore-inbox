Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbULMOi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbULMOi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbULMOi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:38:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55258 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261221AbULMOiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:38:52 -0500
Date: Mon, 13 Dec 2004 15:38:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, nickpiggin@yahoo.com.au
Subject: Re: IO Priorities
Message-ID: <20041213143809.GO3033@suse.de>
References: <20041213142217.GA22853@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213142217.GA22853@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13 2004, Jeff Sipek wrote:
> Hello all,
> 	About a week ago, I said I would try to implement IO priorities.
> I tried. I got the whole thing done, but there is one major problem - it

I did too, did you see my patch?

> doesn't work the way it is supposed to. For example, I wrote a little
> shell script that calls:
> 
> time dd if=/dev/zero of=dump bs=4096 count=200000
> 
> It calls it twice, once as the highest priority (0) and once as the
> lowest priority (39). The only difference (besides the output file) is
> the io priority. Nice values are _not_ connected with io prio (at least
> not yet.) The only thing that the io_prio affects is the coefficient in
> front of the cfq time slice length (see patch). The interesting thing
> that happens is that sometimes the lower priority process finishes before
> the higher priority one - even though the time slices are WAY way different
> in size (1ms and 223ms). Con Kolivas told me that he experienced the same
> odd behaviour when he implemented io priorities on top of deadline.

Well, for this specific case, I'd suggest you check out how much of the
write out actually happens in context of that process. Often you end up
with pdflush(es) doing the process dirty work, and the io priorities
aren't inherited across that boundary.

> -static int cfq_slice_sync = HZ / 10;
> -static int cfq_slice_async = HZ / 25;
> +static int cfq_slice_sync = HZ / 1000;
> +static int cfq_slice_async = HZ / 1000;
>  static int cfq_slice_async_rq = 16;
> -static int cfq_slice_idle = HZ / 249;
> +static int cfq_slice_idle = HZ / 1000;

You need to be careful, on archs with HZ == 100 you just set every time
slice to 0.

> +/* the slice scaling factors */
> +static int cfq_prio_scale[] = {223, 194, 169, 147, 128,		/* 0..4 */
> +			       111,  97,  84,  73,  64,		/* 5..9 */
> +			        56,  49,  42,  36,  32,		/* 10..14 */
> +			        28,  24,  21,  18,  16,		/* 15..19 */
> +			        14,  12,  11,   9,   8,		/* 20..24 */
> +			         7,   6,   5,   5,   4,		/* 25..29 */
> +			         3,   3,   2,   2,   2,		/* 30..34 */
> +			         1,   1,   1,   1,   1};	/* 35..39 */

I think it's pointless to scale it so fine grained (see my earlier
postings).

Additionally, you don't do anything with the priorities internally.

-- 
Jens Axboe

