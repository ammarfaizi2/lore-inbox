Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbULHBrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbULHBrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbULHBrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:47:18 -0500
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:28759 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261988AbULHBrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:47:13 -0500
Subject: Re: Time sliced CFQ io scheduler
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041208013732.GF16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de>
	 <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org>
	 <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random>
	 <1102467253.8095.10.camel@npiggin-nld.site>
	 <20041208013732.GF16322@dualathlon.random>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 12:47:08 +1100
Message-Id: <1102470428.8095.29.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 02:37 +0100, Andrea Arcangeli wrote:
> On Wed, Dec 08, 2004 at 11:54:13AM +1100, Nick Piggin wrote:
> > That is synch write bandwidth. Yes that seems to be a problem.
> 
> It's not just sync write, it's a write in general, blkdev doesn't know
> if the one waiting is pdflush or some other task. Once this will be
> fixed I will have to reconsider my opinion of course, but I guess after

Yeah those sorts of dependencies are tricky. I think the best bet is
to not get _too_ fancy, and try to cover the basics like keeping
fairness good, and minimising write latency as much as possible.

> it gets fixed the benefit of "as" on the desktop will as well decrease
> compared to cfq. The desktop is ok with "as" simply because it's
> normally optimal to stop writes completely, since there are few apps
> doing write journaling or heavy writes, and there's normally no
> contigous read happening in the background. Desktop just needs a
> temporary peak read max bandwidth when you click on openoffice or
> similar app (and "as" provides it). But on a mixed server doing some
> significant read and write (i.e.  somebody downloading the kernel from
> kernel.org and installing it on some application server) I don't think
> "as" is general purpose enough. Another example is the multiuser usage
> with one user reading a big mbox folder in mutt, whole the other user
> s exiting mutt at the same time. The one exiting will pratically have to
> wait the first user to finish its read I/O. All I/O becomes sync when it
> exceeds the max size of the writeback cache.
> 

AS is surprisingly good when doing concurrent reads and buffered writes.
The buffered writes don't get starved too badly. Basically, AS just
ensures a reader will get the chance to play out its entire read batch
before switching to another reader or a writer.

Buffered writes don't suffer the same problem obviously because the
disk can can easily be kept fed from cache. Any read vs buffered write
starvation you see will mainly be due to the /sys tunables that give
more priority to reads (which isn't a bad idea, generally).


> "as" is clearly the best for the common case of the very desktop usage
> (i.e. machine 99.9% idle and without any I/O except when starting an app
> or saving a file, and the user noticing delay only while waiting the
> window to open up after he clicked the button).  But I believe cfq is
> better for a general purpose usage where we cannot assume how the kernel
> will be used.

Maybe. CFQ may be a bit closer to a traditional elevator behaviour,
while AS uses some significantly different concepts which I guess
aren't as well tested and optimised for.


