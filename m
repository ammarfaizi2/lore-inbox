Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSLYIY1>; Wed, 25 Dec 2002 03:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSLYIY0>; Wed, 25 Dec 2002 03:24:26 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:15367 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262326AbSLYIYZ>; Wed, 25 Dec 2002 03:24:25 -0500
Message-Id: <200212250824.gBP8Nus17429@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Subject: Re: Poor performance with 2.5.52, load and process in D state
Date: Wed, 25 Dec 2002 11:12:38 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20021222113754.15064.qmail@linuxmail.org> <3E06F399.655E0005@digeo.com>
In-Reply-To: <3E06F399.655E0005@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ok, I'm back with the results of the osdb test against 2.4.19 and
> > 2.5.52 Both the kernel booted with apm=off mem=40M
> > osdb ran with 40M of data.
> > To summarize the results:
> > 2.4.19 "Single User Test"       806.78 seconds  (0:13:26.78)
> > 2.5.52 "Single User Test"       3771.85 seconds (1:02:51.85)
>
> I could reproduce this.
>
> What's happening is that when the test starts up it does a lot of
> writing which causes 2.4 to do a bunch of swapout.  So for the rest
> of the test 2.4 has an additional 8MB of cache available.
>
> The problem of write activity causing swapout was fixed in 2.5.  It
> does not swap out at all in this test.  But this time, we want it to.
>
> End result: 2.4 has ~20 megabytes of cache for the test and 2.5 has
> ~12 megabytes.   The working pagecache set is around 16 MB, so we're
> right on the edge - it makes 2.5 run 10x slower.  You can get most of
> this back by boosting /proc/sys/vm/swappiness.  I think the default
> of 60 is too unswappy really.  I run my machines at 80.

Swap problem can be generalized. Let's consider these real-world
example pairs:

* cache/RAM,
* local node RAM/remote node RAM (in a NUMA box)
* RAM/disk
* local disk/networked storage
* RAM/fast solid storage "disk" (USB Flash or IDE built from DRAM)
  (etc)

We have faster storage and slower storage.
We want to swap unused data from faster one for needed data
on slower one. The larger the speed gap between the two,
the more we feel the pain when our swap algorithms go wrong.

Note that speed differences (ratios) are very different:
from 1/5 to 1/1000000.

I wonder whether swappiness should be related to the speed
ratio between storage types? How exactly?

Having to play with tunables is not an ideal way to go,
I hate to think that Andrew's (and others) work can go down
the drain at the very next technology jump.
--
vda
