Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSJWFhx>; Wed, 23 Oct 2002 01:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262872AbSJWFhw>; Wed, 23 Oct 2002 01:37:52 -0400
Received: from mail.eskimo.com ([204.122.16.4]:11532 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S262871AbSJWFhv>;
	Wed, 23 Oct 2002 01:37:51 -0400
Date: Tue, 22 Oct 2002 22:43:44 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Elladan <elladan@eskimo.com>, Jeff Dike <jdike@karaya.com>,
       Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021023054344.GA2002@eskimo.com>
References: <20021020023321.GS23930@dualathlon.random> <200210220507.AAA06089@ccure.karaya.com> <20021022052717.GO19337@dualathlon.random> <20021022072438.GA4853@eskimo.com> <20021022074006.GS19337@dualathlon.random> <20021023051208.GA1350@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023051208.GA1350@eskimo.com>
User-Agent: Mutt/1.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 10:12:08PM -0700, Elladan wrote:
> 
> Try 2:
> 
> Create a second mapping of the vsyscall page in some special location
> above the normal page.  Make a new sysctl, which globally invalidates
> the page that the standard mapping is on.  Basically, this disables
> vsyscalls for everyone when turned on.
> 
> Now, obviously this won't work without some trick.  What we do now is,
> we make the page fault handler path for vsyscalls (to be added anyway)
> work like so:
> 
> If the pc is within the allocated vsyscall page(s), then:
> 
> If the pc is on the entrypoint to a vsyscall function, check whether the
> process is being traced.  If so, turn this into a somewhat normal
> looking syscall so it can be virtualized (or do something else, if you
> want - have userspace jump somewhere, etc).
> 
> If not traced, or if the pc is not at the entrypoint, reset the pc to be
> on the second vsyscall copy, with the same offset, and return to
> userspace.
> 
> This lets us do a global vsyscall disable, but (I hope) fixes up the
> problem of userspace going to sleep inside a vsyscall.  The process
> wakes up, faults, and gets shunted off to identical code in another
> location, which should have the same behavior.
> 
> Downside: vgettimeofday takes a performance penalty for everyone in the
> special case where UML is running with full time virtualization, because
> of the page fault.  This is the very unusual case, so who cares?
> 
> Downside 2: Would this actually work?  It's a bit scary sounding...

One caveat to this, I suppose, is that the vsyscall itself would need to
be position-independant code (which might not be overhead, if done very
carefully), or else the code would have to be modified inside the
sysctl() at invalidation time.  Both of which make the implementation
ugly.

-J
