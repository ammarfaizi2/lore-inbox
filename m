Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbSJJSF3>; Thu, 10 Oct 2002 14:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbSJJSF3>; Thu, 10 Oct 2002 14:05:29 -0400
Received: from packet.digeo.com ([12.110.80.53]:22963 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261823AbSJJSF1>;
	Thu, 10 Oct 2002 14:05:27 -0400
Message-ID: <3DA5C2B9.3AC1D7AD@digeo.com>
Date: Thu, 10 Oct 2002 11:11:05 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.40-mm2 with contest
References: <3DA233EC.1119CD7B@digeo.com> <Pine.LNX.3.96.1021010131852.17862A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2002 18:11:05.0190 (UTC) FILETIME=[662D4060:01C27088]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On Mon, 7 Oct 2002, Andrew Morton wrote:
> 
> > Problem is, users have said they don't want that.  They say that they
> > want to copy ISO images about all day and not swap.  I think.
> >
> > It worries me.  It means that we'll be really slow to react to sudden
> > load swings, and it increases the complexity of the analysis and
> > testing.  And I really do want to give the user a single knob,
> > which has understandable semantics and for which I can feasibly test
> > all operating regions.
> >
> > I really, really, really, really don't want to get too fancy in there.
> 
> It is really desirable to improve write intense performance in 2.5. My
> response benchmark shows that 2.5.xx is seriously worse under heavy write
> load than 2.4.

2.5 and 2.5-mm are very different in this area.  You did not specify.

> And in 2.4 it is desirable to do tuning of bdflush for
> write loads, to keep performance up in -aa kernels. Andrea was kind enough
> to provide me some general hints in this area.
> 
> Here's what I think is happening.
> 
> 1 - the kernel is buffering too much data in the hope that it will
> possibly be reread. This is fine, but it results in swapping a lot of
> programs to make room, and finally a big cleanup to disk, which
> triggers...

This is why 2.5.41-mm2 has improved writer throttling, and it's
why it adjusts the throttling threshold down when the amount
of mapped memory is high.
 
> 2 - without the io scheduler having a bunch of writes has a very bad
> effect on read performance, including swap-in. While it's hard to be sure,
> I think I see a program getting a fault to page in a data page (while
> massive write load is present) and while blocked some of the code pages
> are released.

Yes, that happens quite a lot.
 
> I think there's room for improving the performance, as the "swappiness"
> patch shows. I played with trying to block a process after it had a
> certain amount of data buffered for write, but it didn't do what I wanted.
> I think the total buffered data in the system needs to be considered as
> well.

It does.  The throttling of write(2) callers is a critical part
of the VM.   Large amounts of dirty data cause lots of problems.
