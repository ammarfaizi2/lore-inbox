Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUBFDWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266340AbUBFDWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:22:10 -0500
Received: from ns.suse.de ([195.135.220.2]:41953 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266189AbUBFDWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:22:04 -0500
Date: Fri, 6 Feb 2004 04:18:34 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com, lord@xfs.org
Subject: Re: Limit hash table size
Message-ID: <20040206031834.GA24890@wotan.suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel> <20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel> <p73isilkm4x.fsf@verdi.suse.de> <20040205190904.0cacd513.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205190904.0cacd513.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 07:09:04PM -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > > Ken, I remain unhappy with this patch.  If a big box has 500 million
> > > dentries or inodes in cache (is possible), those hash chains will be more
> > > than 200 entries long on average.  It will be very slow.
> > 
> > How about limiting the global size of the dcache in this case ? 
> 
> But to what size?

Some percent of memory (but less than currently), with a upper limit.
Let's say 2GB on a 60GB 64bit box.  And a sysctl for users to enlarge.

> 
> The thing is, any workload which touches a huge number of dentries/inodes
> will, if it touches them again, touch them again in exactly the same order.
> This triggers the worst-case LRU behaviour.
> 
> So if you limit dcache to 100MB and you happen to have a workload which
> touches 101MB's worth, you get a 100% miss rate.  You suffer a 100000%
> slowdown on the second pass, which is unhappy.  It doesn't seem worth
> crippling such workloads just because of the updatedb thing.

You always risk crippling some workloads. But letting all your memory
slowly getting taken over by the dcache is likely to break more 
things than limiting it to a reasonable upper size
(and let people enlarge it for extreme workloads) 

And it makes the actual dcache lookups slow too because you have
to walk hundreds of "zombies" in your hash table just to figure out
that the dentry you need it is not cached.

I remember sct fixed that in 2.1 timeframe.  But
it got later broken by the dynamic memory sizing heuristics.

The dynamic memory sizing was mainly an optimization for diff -burpN 
on source trees for kernel hackers. While I like having that fast too
I don't think it's a good idea to cripple big machines in general for it.


> > 500 million dentries. It just risks to keep the whole file system
> > after an updatedb in memory on a big box, which is not necessarily
> > good use of the memory.
> 
> A decent approach to the updatedb problem is an application hint which says
> "reclaim i/dcache harder".  Just turn it on during the updatedb run -
> crude, but it's a start.
> 
> But I've been telling poeple for a year that they should set
> /proc/sys/vm/swappiness to zero during the updatedb run and afaik nobody has
> bothered to try it...

I do not think such hacks are the right way to do. If updatedb does not
do that backup will or maybe your nightly tripwire run or some other
random application that walks file systems. Hacking all of them is just not 
realistic.

-Andi
