Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274813AbRJJF0W>; Wed, 10 Oct 2001 01:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274832AbRJJF0F>; Wed, 10 Oct 2001 01:26:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:42793 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274813AbRJJFZv>; Wed, 10 Oct 2001 01:25:51 -0400
Date: Wed, 10 Oct 2001 07:26:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010072607.P726@athlon.random>
In-Reply-To: <200110100358.NAA17519@isis.its.uow.edu.au> <3BC3D916.B0284E00@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC3D916.B0284E00@zip.com.au>; from akpm@zip.com.au on Tue, Oct 09, 2001 at 10:13:58PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 10:13:58PM -0700, Andrew Morton wrote:
> I don't understand why Andrea is pointing at write throttling?  xmms
> doesn't do any disk writes, does it??

Of course it doesn't. You're right it could be just because of I/O
bandwith shortage. But it could really be also because of vm write
throttling.

xmms can end waiting I/O completion for I/O submitted by other I/O bound
tasks. This because xmms is reading from disk and in turn it is
allocating cache and in turn it is allocating memory. While allocating
memory it may need to write throttle.

Copying the file to /dev/shm fixed the problem but that would cover both
the write throttling and the disk bandwith problems at the same time and
I guess it's a mixed effect of both things.

> Andrea's VM has a rescheduling point in shrink_cache(), which is the
> analogue of the other VM's page_launder().  This rescheduling point
> is *absolutely critial*, because it opens up what is probably the
> longest-held spinlock in the kernel (under common use).  If there
> were a similar reschedulig point in page_launder(), comparisons
> would be more valid...

Indeed.

> I would imagine that for a (very) soft requirement such as audio
> playback, the below patch, combined with mlockall and renicing
> should fix the problems.  I would expect that this patch will
> give effects which are similar to the preempt patch.  This is because

I didn't checked the patch in the detail yet but it seems you covered
read/write some bits in /proc and a lru list during buffer flushing. I
agree that it should be enough to give the same effects of the preempt
patch.

> most of the other latency problems are under locks - icache/dcache
> shrinking and zap_page_range(), etc.

Exactly.

> This patch should go into the stock 2.4 kernel.
> 
> Oh.  And always remember to `renice -19' your X server.  

I don't renice my X server (I rather renice all cpu hogs to +19 and I
left -20 for something that really needs to run as fast as possible
regardless of the X server).

Andrea
