Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbTBHCT3>; Fri, 7 Feb 2003 21:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbTBHCT3>; Fri, 7 Feb 2003 21:19:29 -0500
Received: from ns.suse.de ([213.95.15.193]:16912 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266962AbTBHCT2>;
	Fri, 7 Feb 2003 21:19:28 -0500
Date: Sat, 8 Feb 2003 03:29:08 +0100
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
Message-ID: <20030208022908.GA29776@wotan.suse.de>
References: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel> <p73ptq3bxh6.fsf@oldwotan.suse.de> <1044659375.18676.80.camel@w-jstultz2.beaverton.ibm.com> <20030208001844.GA20849@wotan.suse.de> <1044665441.18670.106.camel@w-jstultz2.beaverton.ibm.com> <20030208015235.GA25432@wotan.suse.de> <1044670483.21642.18.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044670483.21642.18.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 06:14:43PM -0800, john stultz wrote:
> On Fri, 2003-02-07 at 17:52, Andi Kleen wrote:
> > > However this doesn't work on systems w/o a synced TSC, so by simply
> > 
> > Why not? This shouldn't be performance critical and you can make 
> > it monotonous with an additional variable + lock if backwards jumps
> > should be a problem.
> > 
> 
> That sounds horrible! The extra locking and variable reading is going to
> kill most of the performance concerns you have about reading an
> alternate time source. 
> 
> I'm not sure I understand your resistance to using an alternate clock
> for get_cycles(). Could you better explain your problem with it?

I want to keep get_cycles() as a very fast primitive useful for benchmarking
etc. and the random device. Accessing the southbridge would make it magnitudes 
slower.

Regarding the watchdog: what it basically wants is a POSIX
CLOCK_MONOTONIC clock. This isn't currently implemented by Linux, 
but I expect it will be eventually because it's really useful for a lot
of applications who just need an increasing time stamp in user space,
and who do not want to fight ntpd for this. One example for such 
an application is the X server who needs this for its internal 
event sequencing.

Implementing it based on the current time infrastructure is very easy -
you just do not add xtime and wall jiffies in, but only jiffies.

I don't think doing any special hacks and complicating get_cycles()
for it is the right way. Just implement a new monotonic clock primitive
(and eventually export it to user space too) 

-Andi

