Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132281AbRCWANk>; Thu, 22 Mar 2001 19:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132245AbRCWAMn>; Thu, 22 Mar 2001 19:12:43 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:24705 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S132277AbRCWAKp>;
	Thu, 22 Mar 2001 19:10:45 -0500
Date: Fri, 23 Mar 2001 01:09:32 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200103230009.BAA22702@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001 23:43:57 +0000 (GMT), Alan Cox wrote:

> > >How do you return an out of memory error to a C program that is out of memory
> > >due to a stack growth fault. There is actually not a language construct for it
> > SIGSEGV.
> > Stack overflow for a language like C using standard implementation techniques
> > is the same as a page fault while accessing a page for which there is no backing
> > store. SIGSEGV is the logical choice, and the one I'd expect on other Unices.
> 
> Guess again. You are expanding the stack because you have no room left on it.
> You take a fault. You want to report a SIGSEGV. Now where are you
> going to put the stack frame ?
> 
> SIGSEGV in combination with a preallocated alternate stack maybe

Oh I know 99% of the processes getting this will die. The behaviour I'd
expect from vanilla code in this particular case (stack overflow) is:
- page fault in stack "segment"
- no backing store available
- post SIGSEGV to current
  * push sighandler frame on current stack (or altstack, if registered) [+]
  * no room? SIG_DFL, i.e kill

My point is that with overcommit removed, there's no question as to
which process is actually out of memory. No need for the kernel to guess;
since it doesn't guess, it cannot guess wrong.

Concerning the stack: sure, oom makes it problematic to report the
error in a useful way. So use sigaltstack() and SA_ONSTACK. [+]
Processes that don't do this get killed, but not because oom_kill
did some fancy guesswork.

[+] Speaking as a hacker on a runtime system for a concurrent
programming language (Erlang), I consider the current Unix/POSIX/Linux
default of having the kernel throw up[*] at the user's current stack
pointer to be unbelievably broken. sigaltstack() and SA_ONSTACK should
not be options but required behaviour.

[*] Signal & trap frames used to be called "stack puke" in old 68k days.

/Mikael
