Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSKCUU6>; Sun, 3 Nov 2002 15:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263438AbSKCUU5>; Sun, 3 Nov 2002 15:20:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1805 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263333AbSKCUUF>; Sun, 3 Nov 2002 15:20:05 -0500
Date: Sun, 3 Nov 2002 21:26:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>, William Lee Irwin III <wli@holomorphy.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Hot/cold allocation -- swsusp can not handle hot pages
Message-ID: <20021103202636.GD22668@atrey.karlin.mff.cuni.cz>
References: <20021102181900.GA140@elf.ucw.cz> <20021102184612.GI23425@holomorphy.com> <20021102202208.GC18576@atrey.karlin.mff.cuni.cz> <3DC44839.A3AEAE41@digeo.com> <20021103200809.GC27271@elf.ucw.cz> <3DC58563.94BAE24C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC58563.94BAE24C@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi!

> > ...
> > "big-picture" should be in Documentation/swsusp.txt...
> > 
> > *Should* be :-(. I need to copy all used memory, to make sure my
> > snapshot is atomic.
> > 
> > Copying works by looking at what is allocated, counting needed pages,
> > allocating 'directory' for them, allocating memory for copies, and
> > actually copying.
> 
> Ah.  I see.
>  
> > When I suddenly find I have less data to copy than I thought, it
> > screws up the code.
> 
> Having a less-than-expected amount to copy sounds like it can
> be safely handled?


It means I have to kill some sanity checks and complicate things a
little bit. Yes it can be done.


> > > I'm not really sure what to suggest here.  Emptying the per-cpu
> > > page pools would be tricky.  Maybe a swsusp-special page allocator
> > > which goes direct to the buddy lists or something.
> > 
> > Well, see the patch above. That seems to do the trick for
> > me. It seems that even "cold" allocation can give page from per-cpu
> > pool. I thought that was a bug?
> 
> There are two queues per cpu.  cache-warm pages and cache-cold
> pages.  The cold queue is mainly for lock amortisation, to avoid
> taking the zone lock once per page.  But we can also allocate
> from the cold queue for situations where we'll be invalidating the
> cache anyway (file readahead).  We don't want to waste cache-hot
> pages.  Your change breaks that.

I thought I was making it go to "cold" pages when user requested it,
not to hot ones, but I did not read the code too much.

							Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
