Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265234AbSJRR2U>; Fri, 18 Oct 2002 13:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265307AbSJRR1p>; Fri, 18 Oct 2002 13:27:45 -0400
Received: from [195.223.140.120] ([195.223.140.120]:34064 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265234AbSJRRPM>; Fri, 18 Oct 2002 13:15:12 -0400
Date: Fri, 18 Oct 2002 19:21:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
Message-ID: <20021018172121.GO23930@dualathlon.random>
References: <20021018171139.GM23930@dualathlon.random> <Pine.LNX.4.44.0210181018070.21302-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210181018070.21302-100000@home.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 10:19:58AM -0700, Linus Torvalds wrote:
> 
> On Fri, 18 Oct 2002, Andrea Arcangeli wrote:
> 
> > On Fri, Oct 18, 2002 at 09:45:41AM -0700, george anzinger wrote:
> > > Stephen Hemminger wrote:
> > > > current cpu (and maybe current pid) somehow.  And it would be possible
> > > > to avoid  preemption while in a vsyscall text page, some other Unix
> > > > variants do this to implement portions of the thread library in kernel
> > > > provided user text pages.
> > > > 
> > > Now there is an idea!  Lock preemption in user space if and
> > 
> > sounds not good to me, you would miss a wakeup and you would delay the
> > schedule of 1/HZ in the worst (close to the common) case.
> 
> That's not the real problem.
> 
> The real problem is that somebody can jump into the middle of a function 
> (or even into the middle of an instruction), causing the function to do 
> something totally different from the intended effect.
> 
> In particular, it can cause the function to loop forever.
> 
> If you disable preemption of user space, you now killed the machine.
> 
> In short - others may do it, but it's a total _DISASTER_ from a security 
> and stability standpoint. Don't go there.

agreed. Hear my idea:

	actually my idea on 64bit was to use the high 8 bit of each 64bit word to
	give you the cpuid, to get out the coherent data, including the sequence
	number that are read and written inversely with mb() like now (the
	sequence number as well will become per-cpu), so it is definitely doable
	without any single problem and in a very performant way, just not as
	easy as without the per-cpu info. Even if segmentation per-cpu tricks
	would be possible or available (remeber long mode is pure paging, no
	segmentation) it would be not worthwhile IMHO, the cpuid encoded
	atomically in each 64bit data provided by the vsyscall seems a much
	simpler and possibly more performant solution. You set a different
	per-cpu data-mapping with different pte settings in each cpu. The
	vsyscall bytecode remains the same, aware about this cpuid encoded in
	each 64bit word. Doing it in 32bit is ugly (or at least much slower)
	since most data is natively at least 32bit, it would need some slow
	demultiplexing.

Andrea
