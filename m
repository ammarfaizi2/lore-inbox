Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266956AbRGQTZa>; Tue, 17 Jul 2001 15:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266960AbRGQTZU>; Tue, 17 Jul 2001 15:25:20 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:42249 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266959AbRGQTZM>; Tue, 17 Jul 2001 15:25:12 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.4.6 possible problem
Date: Tue, 17 Jul 2001 19:24:23 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9j23d7$1qs$1@penguin.transmeta.com>
In-Reply-To: <3B54454B.97AA34E6@ueidaq.com> <Pine.LNX.3.95.1010717103652.1430A-100000@chaos.analogic.com>
X-Trace: palladium.transmeta.com 995397895 24674 127.0.0.1 (17 Jul 2001 19:24:55 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 17 Jul 2001 19:24:55 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1010717103652.1430A-100000@chaos.analogic.com>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
>
>    ticks = 1 * HZ;        /* For 1 second */
>    while((ticks = interruptible_sleep_on_timeout(&wqhead, ticks)) > 0)
>                  ;

Don't do this.

Imagine what happens if a signal comes in and wakes you up? The signal
will continue to be pending, which will make your "sleep loop" be a busy
loop as you can never go to sleep interruptibly with a pending signal.

In short: if you have to wait for a certain time or for a certain event,
you MUST NOT USE a interruptible sleep.

If it is ok to return early due to signals or similar (which is nice -
you can allow people to kill the process), then you use an interruptible
sleep, but then you mustn't have the above kind of loop.

		Linus
