Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275506AbRJJLlx>; Wed, 10 Oct 2001 07:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275511AbRJJLld>; Wed, 10 Oct 2001 07:41:33 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:64528 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP
	id <S275506AbRJJLlZ>; Wed, 10 Oct 2001 07:41:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Date: Wed, 10 Oct 2001 07:41:54 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200110100358.NAA17519@isis.its.uow.edu.au> <3BC3D916.B0284E00@zip.com.au> <20011010072607.P726@athlon.random>
In-Reply-To: <20011010072607.P726@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011010114132Z275506-760+23131@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 October 2001 01:26, Andrea Arcangeli wrote:
> On Tue, Oct 09, 2001 at 10:13:58PM -0700, Andrew Morton wrote:
> > I don't understand why Andrea is pointing at write throttling?  xmms
> > doesn't do any disk writes, does it??
>
> Of course it doesn't. You're right it could be just because of I/O
> bandwith shortage. But it could really be also because of vm write
> throttling.
>
> xmms can end waiting I/O completion for I/O submitted by other I/O bound
> tasks. This because xmms is reading from disk and in turn it is
> allocating cache and in turn it is allocating memory. While allocating
> memory it may need to write throttle.
>
> Copying the file to /dev/shm fixed the problem but that would cover both
> the write throttling and the disk bandwith problems at the same time and
> I guess it's a mixed effect of both things.
>
> > Andrea's VM has a rescheduling point in shrink_cache(), which is the
> > analogue of the other VM's page_launder().  This rescheduling point
> > is *absolutely critial*, because it opens up what is probably the
> > longest-held spinlock in the kernel (under common use).  If there
> > were a similar reschedulig point in page_launder(), comparisons
> > would be more valid...
>
> Indeed.
>
> > I would imagine that for a (very) soft requirement such as audio
> > playback, the below patch, combined with mlockall and renicing
> > should fix the problems.  I would expect that this patch will
> > give effects which are similar to the preempt patch.  This is because
>
> I didn't checked the patch in the detail yet but it seems you covered
> read/write some bits in /proc and a lru list during buffer flushing. I
> agree that it should be enough to give the same effects of the preempt
> patch.
>
> > most of the other latency problems are under locks - icache/dcache
> > shrinking and zap_page_range(), etc.
>
> Exactly.
>
> > This patch should go into the stock 2.4 kernel.
> >
> > Oh.  And always remember to `renice -19' your X server.
Blah,  You shouldn't need to. You shouldn't have anything able to lag your X 
server unless you're running so many programs your cpu time slices are too 
small for it's needs ( or memory).


> I don't renice my X server (I rather renice all cpu hogs to +19 and I
> left -20 for something that really needs to run as fast as possible
> regardless of the X server).
>
> Andrea

freeamp runs with no noticable cpu usage, meaning it's 0.0 nearly 100% of the 
time and i have 256K of input buffer and 16K of output.   Then i have a 
process like dbench create a bunch of threads (32) and cause freeamp to skip. 
  Now how is that a fair spread of cpu?  The point is that this doesn't have 
to do with cpu spread and getting locked out of cpu.  It just has to do with 
dbench holding the kernel for too long in places and the kernel should know 
that and tell it to wait  since other processes are behaving.   There needs 
to be a threshhold of kernel usage before the kernel will begin to preempt 
that task for all the ones within the threshhold unless YOU want that kernel 
hogger to run at full speed. In which case you can renice it to a lower nice 
(higher priority).  Dbench is getting it's share of cpu maybe, but it's 
getting for too much of it's share of kernel time and that needs to be 
stopped and it's unfair in a multi-user multiprocessing system.   That's what 
i meant earlier.  

It's just my opinion that kernel hoggers should need to be given user defined 
higher priority to hog the kernel and not everything else to just run because 
you're running a kernel hogger. 
