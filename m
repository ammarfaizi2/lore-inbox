Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSAZKIT>; Sat, 26 Jan 2002 05:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSAZKIF>; Sat, 26 Jan 2002 05:08:05 -0500
Received: from nrg.org ([216.101.165.106]:39266 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S289046AbSAZKHw>;
	Sat, 26 Jan 2002 05:07:52 -0500
Date: Sat, 26 Jan 2002 02:07:38 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Robert Love <rml@tech9.net>
cc: David Howells <dhowells@redhat.com>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <1011998120.3505.29.camel@phantasy>
Message-ID: <Pine.LNX.4.40.0201260155300.16648-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jan 2002, Robert Love wrote:
> Mmm, I like it.  Ingo Molnar talked to me about this (he wants such a
> feature, too) earlier.  This is a real win.
>
> This patch is beneficial to the kernel preemption patch.

Note that with a fully preemptible kernel, there is no need to test
need_resched on return from system call, since any needed reschedule
should already have been done.  If the need_resched was set by an
interrupt handler, the preempt_schedule on return from interrupt (or on
exit from non-preemptible region) will have done the reschedule.  And if
need_resched was set because one process woke up another (higher
priority) process, we can do the schedule() immediately, unless we are
in a non-preemptible region in which case it will happen on exit from
that region.  I don't think we do an immediate schedule on wakeup yet
but, with the existing preemption patch, that would make the test on
syscall exit completely redundant (which may enable the cli instruction
to be safely removed).

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

