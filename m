Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSJTALc>; Sat, 19 Oct 2002 20:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265707AbSJTALc>; Sat, 19 Oct 2002 20:11:32 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38168 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265708AbSJTALb>; Sat, 19 Oct 2002 20:11:31 -0400
Date: Sun, 20 Oct 2002 02:15:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021020001540.GR23930@dualathlon.random>
References: <20021019050139.GM23930@dualathlon.random> <200210192343.SAA03642@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210192343.SAA03642@ccure.karaya.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 06:43:28PM -0500, Jeff Dike wrote:
> andrea@suse.de said:
> > the sysctl would replace the vsyscall fixmap fixmap entry for the
> > current cpu enterely at switch_to time, I certainly don't want to add
> > not necessary branches in the core vsyscall code.  Doing it globally
> > is zerocost but it would probably need privilegies as said, per-task
> > could be more dynamic without privilegies and it would be an unlikely
> > branch added in switch_to, still a very low cost so still acceptable. 
> 
> If I'm understanding this (and reading the code) correctly, this would
> allow UML to specify that, for a given process, it should have a page of
> its choosing mapped into the vsyscall area.  Correct?

What I suggested is an arch specific syscall to shutdown vsyscalls
enterely for the current task and its childs, the vsyscall will call
into the real syscall with sysenter, and you will be able to
revirtualize gettimeofday/time like you do on x86 with ptrace.

> If so, I can go along with this.  It makes vsyscalls virtualizable, and thus
> available to UML, which needs them more than the other arches :-)

what do you mean that uml needs the vsyscalls more than the other archs?
You can use the vsyscall in-kernel by executing such syscall to turn the
vsyscall on and then turning them off again before returning to
the uml userspace. Remapping the vsyscall address is messy, we would
need to define a fallback place where to put them and we'd need to deal
with mapping your userspace bytecode in the place of the kernel code
containing the vsyscalls, it's an overdesign mess and it breaks so many
things about the mm design. I much prefer you to keep trapping the
gettimeofday and time with ptrace after shutting down the vsyscalls for
the current task, it's so much cleaner. The overhead of ptrace cannot be
your point, if that overhead is a showstopper uml isn't an option in the
first place.

> The one suggestion I'd make is to make it per-mm rather than per-task and 
> put it in switch_mm rather than switch_to.

doesn't make sense to me, the time of the day has nothing specific to
the mm. The fact that turning off the vsyscall involves an invlpg
doesn't matter either since they're global and they need the explicit
flush anyways, furthmore the per-task info would be in the task struct
not in the mm_struct. I don't see any point in binding a time-of-day
information with the mm. It sounds quite natural to make it a per-task
information not per-mm (also think strace/ptrace, maybe strace/ptrace
could like to still handle gettimeofday, but there's no point to force
all other threads to use the syscall just because we're playing with one
task in the process group).

Andrea
