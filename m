Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280935AbRKTG4G>; Tue, 20 Nov 2001 01:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280939AbRKTGz4>; Tue, 20 Nov 2001 01:55:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41224 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280935AbRKTGzp>; Tue, 20 Nov 2001 01:55:45 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
Date: Tue, 20 Nov 2001 06:50:50 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9tcuga$1gi$1@penguin.transmeta.com>
In-Reply-To: <20011119173935.A10597@asooo.flowerfire.com> <20011119210941.C10597@asooo.flowerfire.com> <20011120043222.T1331@athlon.random> <20011119235422.F10597@asooo.flowerfire.com>
X-Trace: palladium.transmeta.com 1006239338 3857 127.0.0.1 (20 Nov 2001 06:55:38 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 Nov 2001 06:55:38 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011119235422.F10597@asooo.flowerfire.com>,
Ken Brownfield  <brownfld@irridia.com> wrote:
>kswapd goes up to 5-10% CPU (vs 3-6) but it finishes without issue or
>apparent interactivity problems.  I'm keeping it in while( 1 ), but it's
>been predictable so far.
>
>3-10 is a lot better than 99, but is kswapd really going to eat that
>much CPU in an essentially allocation-less state?

Well, it's obviously not allocation-less: updatedb will really hit on
the dcache and icache (which are both in the NORMAL zone only, which is
why Andrea asked for it), and obviously your Oracle load itself seems to
be happily paging stuff around, which causes a lot of allocations for
page-ins. 

It only _looks_ static, because once you find the proper "balance", the
VM numbers themselves shouldn't change under a constant load.

We could make kswapd use less CPU time, of course, simply by making the
actual working processes do more of the work to free memory.  The total
work ends up being the same, though, and the advantage of kswapd is that
it tends to make the freeing slightly more asynchronous, which helps
throughput. 

The _disadvantage_ of kswapd is that if it goes crazy and uses up all
CPU time, you get bad results ;)

But it doesn't sound crazy in your load.  I'd be happier if the VM took
less CPU, of course, but for now we seem to be doing ok.

		Linus
