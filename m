Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271318AbRHORU5>; Wed, 15 Aug 2001 13:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271319AbRHORUr>; Wed, 15 Aug 2001 13:20:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34570 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271318AbRHORUh>; Wed, 15 Aug 2001 13:20:37 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 15 Aug 2001 10:19:37 -0700
Message-Id: <200108151719.f7FHJbS02350@penguin.transmeta.com>
To: s3293115@student.anu.edu.au, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kswapd using all cpu for long periods in 2.4.9-pre4
Newsgroups: linux.dev.kernel
In-Reply-To: <000c01c12569$65581630$0200a8c0@W2K>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed something..

In article <000c01c12569$65581630$0200a8c0@W2K> you write:
>
>kswapd is using all cpu for long periods (100-200 seconds then 100-200
>seconds break....) there is very little disk activity (heres a vmstat while
>its happening)
>
>mem info during:
>SysRq: Show Memory
>Mem-info:
>Free pages: 3744kB ( 0kB HighMem)
>( Active: 6946, inactive_dirty: 4296, inactive_clean: 895, free: 936 (256
>512 2048) )

This shows your freepages.min low and high: 256. 512 and 2048
respectively.

And that's WRONG. Your "freepages.high" is _way_ too high. You must have
changed it through the /proc interface somehow, which should be
impossible (the /proc/sys/vm/freepages file is read-only), but I suspect
that maybe there's a sysctl backdoor.

How do I know that "freepages.high" is too big? Because it should always
be 3*freepages.min. Yours is 8*min.

And why does this matter? Because what has apparently happened is:
 - your setup somehow modifies the global free target
 - but the per-zone targets are still the old ones

The end result: we always think that we are under a global shortage, but
the actual page freeing routines refuse to free pages because all the
_zones_ think that they are fine.

Which gives you _exactly_ the behaviour you're describing. "kswapd" will
run forever, and never make any progress at all.

I wonder if this is more common? Does any of the distributions maybe
have some "system tuning" script that modifies the freepages values
through sysctl? That would certainly explain why some people see the
problem and others do not..

How DID you change that value?

		Linus
