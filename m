Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261702AbSJJRe1>; Thu, 10 Oct 2002 13:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbSJJRe1>; Thu, 10 Oct 2002 13:34:27 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18959 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261702AbSJJRe0>; Thu, 10 Oct 2002 13:34:26 -0400
Date: Thu, 10 Oct 2002 13:32:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>
cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.40-mm2 with contest
In-Reply-To: <3DA233EC.1119CD7B@digeo.com>
Message-ID: <Pine.LNX.3.96.1021010131852.17862A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Andrew Morton wrote:

> Problem is, users have said they don't want that.  They say that they
> want to copy ISO images about all day and not swap.  I think.
> 
> It worries me.  It means that we'll be really slow to react to sudden
> load swings, and it increases the complexity of the analysis and
> testing.  And I really do want to give the user a single knob,
> which has understandable semantics and for which I can feasibly test
> all operating regions.
> 
> I really, really, really, really don't want to get too fancy in there.

It is really desirable to improve write intense performance in 2.5. My
response benchmark shows that 2.5.xx is seriously worse under heavy write
load than 2.4. And in 2.4 it is desirable to do tuning of bdflush for
write loads, to keep performance up in -aa kernels. Andrea was kind enough
to provide me some general hints in this area.

Here's what I think is happening.

1 - the kernel is buffering too much data in the hope that it will
possibly be reread. This is fine, but it results in swapping a lot of
programs to make room, and finally a big cleanup to disk, which
triggers...

2 - without the io scheduler having a bunch of writes has a very bad
effect on read performance, including swap-in. While it's hard to be sure,
I think I see a program getting a fault to page in a data page (while
massive write load is present) and while blocked some of the code pages
are released.

I think there's room for improving the performance, as the "swappiness"
patch shows. I played with trying to block a process after it had a
certain amount of data buffered for write, but it didn't do what I wanted.
I think the total buffered data in the system needs to be considered as
well.

I believe one of the people who actually works on this stuff regularly has
mentioned this, I don't find the post quickly.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

