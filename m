Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUCDSNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUCDSNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:13:17 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:779
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262059AbUCDSNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:13:05 -0500
Date: Thu, 4 Mar 2004 19:13:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Zaitsev <peter@mysql.com>
Cc: Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040304181345.GR4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040303200704.17d81bda.akpm@osdl.org> <20040304045212.GG4922@dualathlon.random> <1078417285.2770.100.camel@abyss.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078417285.2770.100.camel@abyss.local>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 08:21:26AM -0800, Peter Zaitsev wrote:
> On Wed, 2004-03-03 at 20:52, Andrea Arcangeli wrote:
> 
> Andrea,
> 
> > mysql is threaded (it's not using processes that force tlb flushes at
> > every context switch), so the only time a tlb flush ever happens is when
> > a syscall or an irq or a page fault happens with 4:4. Not tlb flush
> > would ever happen with 3:1 in the whole workload (yeah, some background
> > tlb flushing happens anyways when you type char on bash or move the
> > mouse of course but it's very low frequency)
> 
> Do not we get TLB flush also due to latching or are pthread_mutex_lock
> etc implemented without one nowadays ?

pthread mutex uses futex in nptl and ngpt or they use sched_yield in
linuxthreads, either ways they don't need to flush the tlb. The address
space is the same, no need of changing address space for the mutex
(otherwise mutex would be very detrimental too). Kernel threads as well
don't require a tlb flush.

> > (to be fair, because it's threaded it means they also find 512m of
> > address space lost more problematic than the db using processes, though
> > besides the reduced address space there would be no measurable slowdown
> > with 2.5:1.5)
> 
> Hm. What 512Mb of address space loss are you speaking here. Are threaded
> programs only able to use 2.5G in  3G/1G memory split ? 

I was talking about the 2.5:1.5: split here, 3:1 gives you 3G of address
space (both for threads and processes), 2.5:1.5 would give you only 2.5G
of address space to use instead (with a loss of 512m that are being used
by kernel to handle properly a 64G box).

> > Also the 4:4 pretty much depends on the vgettimeofday to be backported
> > from the x86-64 tree and an userspace to use it, so the test may be
> > repeated with vgettimeofday, though it's very possible mysql isn't using
> > that much gettimeofday as other databases, especially the I/O bound
> > workload shouldn't matter that much with gettimeofday.
> 
> You're right.  MySQL does not use gettimeofday very frequently now,
> actually it uses time() most of the time, as some platforms used to have
> huge performance problems with gettimeofday() in the past.
> 
> The amount of gettimeofday() use will increase dramatically in the
> future so it is good to know about this matter.

If you noticed Martin mentioned a >30% figure due gettimeofday being
called frequently (w/o vsyscalls implementing vgettimeofday like in
x86-64), this figure it certainly won't sum to your current number
linearly but you can expect a significant further loss by calling
gettimeofday dramatically more frequently.
