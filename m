Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSHOR4S>; Thu, 15 Aug 2002 13:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSHOR4S>; Thu, 15 Aug 2002 13:56:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52231 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317269AbSHOR4S>; Thu, 15 Aug 2002 13:56:18 -0400
Date: Thu, 15 Aug 2002 11:02:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208151235560.3306-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208151055440.3130-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Ingo Molnar wrote:
> 
> in fact testing these changes in glibc revealed another thing - the top of
> the thread's stack has to be 16-byte aligned (for SSE2 support), so the
> attached patch ontop of BK-curr would be a better solution, it does not
> modify the thread's stack alignment but simply writes to the top of the
> stack. (which is the first word of the thread control block.) This removes
> a few instructions both from glibc and from the kernel.

I do not understand why you want to link this to the stack at all. It 
doesn't really make sense to me. The "thread exited" thing has nothing to 
do with the stack, and you're only focused on that because you want to 
free (or re-use) the stack when it exits.

I personally believe that it would make a lot more sense to either pass in
a totally independent pointer, or - my preferred approach - to just re-use
the TID pointer. Think about it: thread creation sets the TID (if
CLONE_SETTID is set) in the thread data structures, and thread exit clears
the TID (if CLONE_CLRTID is set). That sounds like a _sensible_ interface.

(CLONE_RELEASE_VM doesn't really make sense as a name. It doesn't describe
what the flag _means_, it really only describes an implementation detail
inside the kernel).

Eh?

			Linus

