Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267584AbSLFJII>; Fri, 6 Dec 2002 04:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267585AbSLFJII>; Fri, 6 Dec 2002 04:08:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:50094 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267584AbSLFJIH>;
	Fri, 6 Dec 2002 04:08:07 -0500
Message-ID: <3DF06AB8.C31E6EFF@digeo.com>
Date: Fri, 06 Dec 2002 01:15:36 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-bk5-wli-1
References: <20021206080009.GB11023@holomorphy.com> <3DF05EA7.4BDCBFF0@digeo.com> <20021206085252.GO9882@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 09:15:37.0555 (UTC) FILETIME=[0A28F230:01C29D08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> William Lee Irwin III wrote:
> >> 2.5.50-wli-bk5-12 resize inode cache wait table -- 8 is too small
> 
> On Fri, Dec 06, 2002 at 12:24:07AM -0800, Andrew Morton wrote:
> > Heh.  I decided to make that really, really, really tiny in the expectation
> > that if it was _too_ small, someone would notice.
> > For what workload is the 8 too small, and what is the call path
> > of the waiters?
> > (If it is `tiobench 100000000' and the wait is in __writeback_single_inode(),
> > then we should probably just return from there if !sync and the inode is locked)
> 
> This is actually the result of quite a bit of handwaving; in the OOM-
> handling series of patches with the GFP_NOKILL business, I found that
> tasks would block exessively in wait_on_inode() (which was tiobench
> 16384).

Yup.  I haven't really considered or tested any other strategies
here, but it's part of writer throttling.  If we let these processes
skip an inode which is already under writeback and go on to the next
one there is a risk that we end up submitting IO all over the disk.

Or not.  I have not tried it.

All those threads would end up throttling in get_request_wait() instead.
Which is a single waitqueue.  But it is wake-one.

> The entire summary of results
> of that series of patches was "highmem drops dead under load".

There really is no shame in sending out bugreports, you know.

> But performance benefits from this minor increase in size should be obvious.
> 

But they're all waiting on the same inode ;)
