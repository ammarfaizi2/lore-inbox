Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318957AbSHFAnM>; Mon, 5 Aug 2002 20:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318958AbSHFAnM>; Mon, 5 Aug 2002 20:43:12 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:15531 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S318957AbSHFAnK>;
	Mon, 5 Aug 2002 20:43:10 -0400
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
From: Chris Mason <mason@suse.com>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208060030150.1357-100000@pc40.e18.physik.tu-muenchen.de>
References: <Pine.LNX.4.44.0208060030150.1357-100000@pc40.e18.physik.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Aug 2002 20:47:55 -0400
Message-Id: <1028594875.27694.350.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 18:46, Roland Kuhn wrote:
> > 
> Ahh, thanks! This sounds like a good idea to me, hopefully your patch will 
> be accepted despite the fact that Alan is busy doing other things ;-)
> 
> Coming back to the issue: applying these patches increased the throughput
> by about 20% :-) Now it takes about 100sec instead of 120sec to write a
> 2GB file. Tomorrow I will try it without the write_times part, to see how 
> much that does.

The write_times patch fixes a lot of latency problems, but all 5 of my
patches kind of build on each other to solve problems in different
workloads.

> 
> But more important: the hiccups are more seldom and sometimes shorter than 
> before. With plain 2.4.19 I would hit it about twice per minute (I have 
> not measured it), now it happens only after two minutes when writing 1M 
> chunks at 20MB/s. The longest seen so far was also about 4 seconds, 
> though.

This is harder to guess at ;-)  But I'll try 2 things I know I've fixed.

#1 I've made the metadata writeback code much more efficient, especially
for smaller transactions.  A dd to a large file won't generate lots of
log traffic, writing 700M only changes about 160 blocks in 30 seconds. 
Anyway, 03-data-logging-24 might make a big difference.

#2 During an ls, the current code ends up reading the directory more or
less one block at a time.  Try 05-search_reada-4.diff, which will read
more tree nodes at once.

If that still doesn't work, I'm porting forward some reiserfs
low-latency work that andrew morton did, we can give it a try.

-chris






