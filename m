Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbSJRCe4>; Thu, 17 Oct 2002 22:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSJRCe4>; Thu, 17 Oct 2002 22:34:56 -0400
Received: from zero.aec.at ([193.170.194.10]:37391 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262835AbSJRCez>;
	Thu, 17 Oct 2002 22:34:55 -0400
Date: Fri, 18 Oct 2002 04:40:41 +0200
From: Andi Kleen <ak@muc.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Mark Gross <markgross@thegnar.org>,
       Ingo Molnar <mingo@elte.hu>, Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>, linux-kernel@vger.kernel.org,
       NPT library mailing list <phil-list@redhat.com>
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Message-ID: <20021018024041.GA4015@averell>
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <m33cr4pn56.fsf@averell.firstfloor.org> <200210171835.21647.markgross@thegnar.org> <20021018021242.GA15853@averell> <3DAF70B5.5010208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAF70B5.5010208@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I want the x86 CPU error code, which often has interesting clues on
> > the problem.
> > trapno would be useful too. I suspect other CPUs have similar extended
> > state for exceptions.
> 
> 
> I don't know whether you refer to this but the si_erno and si_code field
> of the elf_siginfo structure are currently not used.  They are filled
> with zero all the time.

Could be used yes.

> > Eventually (in a future kernel) I would love to have the exception
> > handler save the last branch debugging registers of the CPU and the
> > let the
> > core dumper put that into the dump too.  Then you could easily
> > figure out what the program did shortly before the crash.
> 
> 
> One the 2.7 kernel development opens I hope *a lot* will change in the
> core dump handling.  The current format isn't even adequate to represent
> the currently represented information correctly (uid and gid are 16
> bits) and there is other information which isn't even available.

You can always extend it with more elf notes.

> 
> I'm perfectly willing to consult anybody who wants to do some work in
> this area.  Actually, the kernel side should be mostly simple, it "just"
> means accessing and copying the right data.

At least the debugging register access is not that simple. The exception
handler has to be changed into an interrupt gate (to avoid interrupts
messing up the state) and then the debugging msrs have to be saved before
doing any other jumps. Worse they are CPU specific (P6, P4, and Athlon
have it different MSRs. You probably don't want that overhead
for normal page faults (reading MSRs is quite costly), so it would need 
special entry points and could be only done for GPF etc. not for normal
segfault. Still I think it would be worth it.

More state that could be saved are all the %dr* bits for hardware breakpoint
exceptions.

-Andi
