Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbTKZSw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTKZSw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:52:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2434 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264278AbTKZSwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:52:55 -0500
Date: Wed, 26 Nov 2003 13:55:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG (non-kernel), can hurt developers.
In-Reply-To: <Pine.LNX.4.58.0311261021400.1524@home.osdl.org>
Message-ID: <Pine.LNX.4.53.0311261344280.11326@chaos>
References: <Pine.LNX.4.53.0311261153050.10929@chaos>
 <Pine.LNX.4.58.0311261021400.1524@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, Linus Torvalds wrote:

>
> On Wed, 26 Nov 2003, Richard B. Johnson wrote:
> >
> > Note  to hackers. Even though this is a lib-c bug
>
> It's not.
>
> It's a bug in your program.
>
> You can't just randomly use library functions in signal handlers. You can
> only use a very specific "signal-safe" set.
>
> POSIX lists that set in 3.3.1.3 (3f), and says
>
> 	"All POSIX.1 functions not in the preceding table and all
> 	 functions defined in the C standard {2} not stated to be callable
> 	 from a signal-catching function are considered to be /unsafe/
> 	 with respect to signals. .."
>
> typos mine.
>
> The thing is, they have internal state that makes then non-reentrant (and
> note that even the re-entrant ones might not be signal-safe, since they
> may have deadlock issues: being thread-safe is _not_ the same as being
> signal-safe).
>
> In other words, if you want to do complex things from signals, you should
> really just set a flag (of type "sigatomic_t") and have your main loop do
> them. Or you have to be very very careful and only use stuff that is
> defined to be signal-safe (mainly core system calls - stuff like <stdio.h>
> is right out).
>
> 		Linus
>

Well, again, I took a very compilcated sequence of events and
minimized them to where they could be readily observed. The actual
problem in the production machine involves two absolutely independent
tasks that end up using the same shared 'C' runtime library. There
should be no interaction between them, none whatsover. However, when
they both execute rand(), they interact in bad ways. This interraction
occurs on random days at monthly intervals. To find this bug, I
had to compress that time. So, I allowed rand() to be "interrupted"
just as it would be in a context-switch. I simply used a signal
handler, knowing quite well that the "interrupt" could occur at
any time. Now, I didn't give a damn about the value returned in
either function invovation. What I brought to light was a SIGSEGV
that can occur when the shared-library rand() function is
"interrupted".  This is likely caused by the failure to use "-s"
in the compilation of a shared library function, fixed in subsequent
releases.

So don't pick on the code. It was designed to emphasize the
problem. It is not supposed to show how to write a signal
handler.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


