Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131226AbRCWQZT>; Fri, 23 Mar 2001 11:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131227AbRCWQY7>; Fri, 23 Mar 2001 11:24:59 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:56836 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131226AbRCWQYx>; Fri, 23 Mar 2001 11:24:53 -0500
Message-Id: <200103231624.f2NGO4xY001489@pincoya.inf.utfsm.cl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init 
In-Reply-To: Message from Mikael Pettersson <mikpe@csd.uu.se> 
   of "Fri, 23 Mar 2001 01:09:32 +0100." <200103230009.BAA22702@harpo.it.uu.se> 
Date: Fri, 23 Mar 2001 12:24:03 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> said:
> Oh I know 99% of the processes getting this will die. The behaviour I'd
> expect from vanilla code in this particular case (stack overflow) is:
> - page fault in stack "segment"
> - no backing store available
> - post SIGSEGV to current
>   * push sighandler frame on current stack (or altstack, if registered) [+]
>   * no room? SIG_DFL, i.e kill

I.e., kill innocent processes which try to increase their memory usage just
at the wrong moment. This is exactly what happened before the OOM-killer...

> My point is that with overcommit removed, there's no question as to
> which process is actually out of memory. No need for the kernel to guess;
> since it doesn't guess, it cannot guess wrong.

Just too bad there is no complete accounting for memory usage in the kernel
right now (a lot of complex data structures in kernel do consume varying
amounts of memory, not always in the name of a specific process; much of
the extra flexibility in later kernels is exactly because some structures
aren't static anymore). Say good-bye to modules, you could as well have
everything under the sun built in (as the memory for each possible module
will have to be assumed in use, just in case).

> Concerning the stack: sure, oom makes it problematic to report the
> error in a useful way. So use sigaltstack() and SA_ONSTACK. [+]
> Processes that don't do this get killed, but not because oom_kill
> did some fancy guesswork.

They just get killed for requesting memory at the wrong moment, which is a
lot worse.

> [+] Speaking as a hacker on a runtime system for a concurrent
> programming language (Erlang), I consider the current Unix/POSIX/Linux
> default of having the kernel throw up[*] at the user's current stack
> pointer to be unbelievably broken. sigaltstack() and SA_ONSTACK should
> not be options but required behaviour.
> 
> [*] Signal & trap frames used to be called "stack puke" in old 68k days.

Can we please remember that OOM is *not* in any way a "normal system state"
that has to be handled in a civilized, orderly way? This is just an escape
route in case everything else has failed.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
