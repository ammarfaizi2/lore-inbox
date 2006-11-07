Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754087AbWKGH1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbWKGH1A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 02:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbWKGH1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 02:27:00 -0500
Received: from brick.kernel.dk ([62.242.22.158]:13122 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1754087AbWKGH07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 02:26:59 -0500
Date: Tue, 7 Nov 2006 08:29:07 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Brent Baccala <cosine@freesoft.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
Message-ID: <20061107072906.GO19471@kernel.dk>
References: <Pine.LNX.4.64.0611061903220.27775@debian.freesoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611061903220.27775@debian.freesoft.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06 2006, Brent Baccala wrote:
> On Mon, 6 Nov 2006, Chen, Kenneth W wrote:
> 
> >I've tried that myself too and see similar result.  One thing to note is
> >that I/O being submitted are pretty big at 1MB, so the vector list inside
> >bio is going to be pretty long and it will take a while to construct that.
> >Drop the size for each I/O to something like 4KB will significantly reduce
> >the time.  I haven't done the measurement whether the time to submit I/O
> >grows linearly with respect to I/O size.  Most likely it will.  If it is
> >not, then we might have a scaling problem (though I don't believe we have
> >this problem).
> >
> >- Ken
> >
> >
> 
> I'm basically an end user here (as far as the kernel is concerned), so
> let me ask the basic "dumb user" question here:
> 
> How should I do my async I/O if I just want to read or write
> sequentially through a file, using O_DIRECT, and letting the CPU get
> some work done in the meantime?  What about more random access?

For sequential io, you'll pretty quickly hit the transfer size sweet
spot where growing the io larger wont yield any benefits. In this case
you don't want a huge queue depth, 100 ios is an insane amount for
sequential io. If you have a properly sized io unit and a depth of 4 or
so, I doubt you'll see any improvement beyond that on most hardware.

For random io, you want a bigger queue depth. If the hardware can do
queueing, you want to make sure that you can fill that queue. 100 ios is
still a lot in this case, though.

> I've already concluded that I should try to keep my read and write
> files on seperate disks and hopefully on seperate controllers, but I
> still seem to be fighting this thing to keep it from blocking.

Shrink your queue size and/or io size :-)

-- 
Jens Axboe

