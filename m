Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSHDS7Y>; Sun, 4 Aug 2002 14:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318169AbSHDS7Y>; Sun, 4 Aug 2002 14:59:24 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:12704 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318194AbSHDS7V>; Sun, 4 Aug 2002 14:59:21 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Richard Zidlicky <rz@linux-m68k.org>, Jeff Dike <jdike@karaya.com>,
       Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode linux]
References: <1028294887.18635.71.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208031332120.7531-100000@localhost.localdomain>
From: Andi Kleen <ak@muc.de>
Date: 04 Aug 2002 08:46:40 +0200
In-Reply-To: Ingo Molnar's message of "Sat, 03 Aug 2002 14:20:04 +0200"
Message-ID: <m3u1mb5df3.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:


> actually the opposite is true, on a 2.2 GHz P4:
> 
>   $ ./lat_sig catch
>   Signal handler overhead: 3.091 microseconds
> 
>   $ ./lat_ctx -s 0 2
>   2 0.90
> 
> ie. *process to process* context switches are 3.4 times faster than signal
> delivery. Ie. we can switch to a helper thread and back, and still be
> faster than a *single* signal.

This is because the signal save/restore does a lot of unnecessary stuff.
One optimization I implemented at one time was adding a SA_NOFP signal
bit that told the kernel that the signal handler did not intend 
to modify floating point state (few signal handlers need FP) It would 
not save the FPU state then and reached quite some speedup in signal
latency. 

Linux got a lot slower in signal delivery when the SSE2 support was
added. That got this speed back.

The target were certain applications that use signal handlers for async
IO. 

If there is interest I can dig up the old patches. They were really simple.

x86-64 does it also faster by FXSAVE'ing directly to the user space
frame with exception handling instead of copying manually. But that's
not possible in i386 because it still has to use the baroque iBCS 
FP context format on the stack.

-Andi
