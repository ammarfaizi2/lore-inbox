Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSKCUPb>; Sun, 3 Nov 2002 15:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262784AbSKCUPb>; Sun, 3 Nov 2002 15:15:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:22993 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262780AbSKCUPa>;
	Sun, 3 Nov 2002 15:15:30 -0500
Message-ID: <3DC58563.94BAE24C@digeo.com>
Date: Sun, 03 Nov 2002 12:21:55 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: William Lee Irwin III <wli@holomorphy.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Hot/cold allocation -- swsusp can not handle hot pages
References: <20021102181900.GA140@elf.ucw.cz> <20021102184612.GI23425@holomorphy.com> <20021102202208.GC18576@atrey.karlin.mff.cuni.cz> <3DC44839.A3AEAE41@digeo.com> <20021103200809.GC27271@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2002 20:21:56.0421 (UTC) FILETIME=[A7CA0750:01C28376]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> ...
> "big-picture" should be in Documentation/swsusp.txt...
> 
> *Should* be :-(. I need to copy all used memory, to make sure my
> snapshot is atomic.
> 
> Copying works by looking at what is allocated, counting needed pages,
> allocating 'directory' for them, allocating memory for copies, and
> actually copying.

Ah.  I see.
 
> When I suddenly find I have less data to copy than I thought, it
> screws up the code.

Having a less-than-expected amount to copy sounds like it can
be safely handled?

> > I'm not really sure what to suggest here.  Emptying the per-cpu
> > page pools would be tricky.  Maybe a swsusp-special page allocator
> > which goes direct to the buddy lists or something.
> 
> Well, see the patch above. That seems to do the trick for
> me. It seems that even "cold" allocation can give page from per-cpu
> pool. I thought that was a bug?

There are two queues per cpu.  cache-warm pages and cache-cold
pages.  The cold queue is mainly for lock amortisation, to avoid
taking the zone lock once per page.  But we can also allocate
from the cold queue for situations where we'll be invalidating the
cache anyway (file readahead).  We don't want to waste cache-hot
pages.  Your change breaks that.
