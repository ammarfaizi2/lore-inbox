Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRCWMax>; Fri, 23 Mar 2001 07:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbRCWMan>; Fri, 23 Mar 2001 07:30:43 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:55263 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129116AbRCWMae>;
	Fri, 23 Mar 2001 07:30:34 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15035.16824.85440.900102@harpo.it.uu.se>
Date: Fri, 23 Mar 2001 13:29:44 +0100
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3ABA986F.3816FB62@uow.edu.au>
In-Reply-To: <200103230009.BAA22702@harpo.it.uu.se>
	<3ABA986F.3816FB62@uow.edu.au>
X-Mailer: VM 6.76 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Mikael Pettersson wrote:
 > > 
 > > [+] Speaking as a hacker on a runtime system for a concurrent
 > > programming language (Erlang), I consider the current Unix/POSIX/Linux
 > > default of having the kernel throw up[*] at the user's current stack
 > > pointer to be unbelievably broken. sigaltstack() and SA_ONSTACK should
 > > not be options but required behaviour.
 > > 
 > 
 > Why?  What problem does stack puke cause?

It makes user-space stack management difficult or more costly.
You either have to over-estimate the size of each coroutine's [*]
stack, or you have to run with all signals blocked, or you have
to give up on using the machine's native stack.

The first leads to memory wastage (we're talking thousands of coroutines
here, each usually having a quite small stack), the second causes overheads
when resuming or suspending a coroutine (sigprocmask), and the third
loses performance badly on x86 (you lose one g.p. register to point to
your simulated stack, and you lose return-stack branch prediction since
you can't use call/ret instructions any more).

I currently work around this on Linux/x86 by overriding sigaction() et al
to always assert SA_ONSTACK. Unfortunately, this hack doesn't work on
all Unices we'd like to support. (I override sigaction since I also
need to trap signal setup calls from libraries linked with our code.)

[*] I use the term "coroutine" here to avoid the connotations associated
with term like "thread" and "process".
