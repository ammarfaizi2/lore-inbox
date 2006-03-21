Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWCUM7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWCUM7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWCUM7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:59:20 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:50443 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751631AbWCUM7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:59:20 -0500
Date: Tue, 21 Mar 2006 13:59:00 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321125900.GA25943@w.ods.org>
References: <1142592375.7895.43.camel@homer> <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer> <20060321064723.GH21493@w.ods.org> <1142927498.7667.34.camel@homer> <20060321091353.GA25248@w.ods.org> <20060321091422.GA9207@elte.hu> <20060321111552.GA25651@w.ods.org> <20060321111850.GA2776@elte.hu> <1142942878.7807.9.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142942878.7807.9.camel@homer>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 01:07:58PM +0100, Mike Galbraith wrote:
> On Tue, 2006-03-21 at 12:18 +0100, Ingo Molnar wrote:
> 
> > great work by Mike! One detail: i'd like there to be just one default 
> > throttling value, i.e. no grace_g tunables [so that we have just one 
> > default scheduler behavior]. Is the default grace_g[12] setting good 
> > enough for your workload?

The default values are infinitely better than mainline, but it is still
a huge improvement to reduce them (at least grace_g2) :

default : grace_g1=10, grace_g2=14400, loadavg oscillating between 7 and 12 :

willy@wtap:~$ time ls -la /data/src/tmp/|wc
   2271   18250  212211

real    0m5.759s
user    0m0.028s
sys     0m0.008s
willy@wtap:~$ time ls -la /data/src/tmp/|wc
   2271   18250  212211

real    0m3.476s
user    0m0.020s
sys     0m0.016s
willy@wtap:~$ 

I can still observe some occasionnal pauses of 1 to 3 seconds (once
to 4 times per minute).

- grace_g2 set to 0, load converges to a stable 8 :

willy@wtap:~$ time ls -la /data/src/tmp/|wc
   2271   18250  212211

real    0m0.441s
user    0m0.036s
sys     0m0.004s
willy@wtap:~$ time ls -la /data/src/tmp/|wc
   2271   18250  212211

real    0m0.400s
user    0m0.032s
sys     0m0.008s

I can still observe some rare cases of 1 second pauses (once or twice per
minute).

- grace_g2 and grace_g1 set to zero :

willy@wtap:~$ time ls -la /data/src/tmp/|wc
   2271   18250  212211

real    0m0.214s
user    0m0.028s
sys     0m0.008s
willy@wtap:~$ time ls -la /data/src/tmp/|wc
   2271   18250  212211

real    0m0.193s
user    0m0.032s
sys     0m0.008s

=> I never observe any pause, and the numbers above sometimes even
   get lower (around 75 ms).

I have also tried injecting traffic on my proxy, and at 16000 hits/s,
its does not impact overall system's responsiveness, whatever (g1,g2).

> I can make the knobs compile time so we don't see random behavior
> reports, but I don't think they can be totally eliminated.  Would that
> be sufficient?
> 
> If so, the numbers as delivered should be fine for desktop boxen I
> think.  People who are building custom kernels can bend to fit as
> always.

That would suit me perfectly. I think I would set them both to zero.
It's not clear to me what workload they can help, it seems that they
try to allow a sometimes unfair scheduling.

> 	-Mike

Cheers,
Willy

