Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132859AbRDDRRo>; Wed, 4 Apr 2001 13:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132860AbRDDRRY>; Wed, 4 Apr 2001 13:17:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1816 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132859AbRDDRRX>; Wed, 4 Apr 2001 13:17:23 -0400
Date: Wed, 4 Apr 2001 19:16:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Hubertus Franke <frankeh@us.ibm.com>,
        Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
Message-ID: <20010404191604.O20911@athlon.random>
In-Reply-To: <20010404170846.V20911@athlon.random> <200104041650.JAA95432@google.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104041650.JAA95432@google.engr.sgi.com>; from kanoj@google.engr.sgi.com on Wed, Apr 04, 2001 at 09:50:58AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 09:50:58AM -0700, Kanoj Sarcar wrote:
> > 
> > I didn't seen anything from Kanoj but I did something myself for the wildfire:
> > 
> > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.3aa1/10_numa-sched-1
> > 
> > this is mostly an userspace issue, not really intended as a kernel optimization
> > (however it's also partly a kernel optimization). Basically it splits the load
> > of the numa machine into per-node load, there can be unbalanced load across the
> > nodes but fairness is guaranteed inside each node. It's not extremely well
> > tested but benchmarks were ok and it is at least certainly stable.
> >
> 
> Just a quick comment. Andrea, unless your machine has some hardware
> that imply pernode runqueues will help (nodelevel caches etc), I fail 
> to understand how this is helping you ... here's a simple theory though. 

It helps by keeping the task in the same node if it cannot keep it in
the same cpu anymore.

Assume task A is sleeping and it last run on cpu 8 node 2. It gets a wakeup
and it gets running and for some reason cpu 8 is busy and there are other
cpus idle in the system. Now with the current scheduler it can be moved in any
cpu in the system, with the numa sched applied we will try to first reschedule
it in the idles cpus of node 2 for example. The per-node runqueue are mainly
necessary to implement the heuristic.

> cpus on nodes where they have allocated most of their memory on. I am 
> not sure what the situation will be under huge loads though.

after all cpus are busy we try to reschedule only on the cpus of the local
node, that's why it can generate some unbalance yes, but it will tend to
rebalance over the time because some node will end with all tasks with
zero counter first if it's less loaded, and so then it will start
getting tasks with has_cpu 0 in the runqueues out of other nodes.

You may want to give it a try on your machines and see what difference it
makes, I'd be curious to know of course.

Andrea
