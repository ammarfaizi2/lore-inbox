Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUEKAix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUEKAix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUEKAix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:38:53 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:50589 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262850AbUEKAio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:38:44 -0400
Subject: Re: ptrace in 2.6.5
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040510225818.GA24796@nevyn.them.org>
References: <1UlcA-6lq-9@gated-at.bofh.it>
	 <m365b4kth8.fsf@averell.firstfloor.org>
	 <1084220684.1798.3.camel@slack.domain.invalid>
	 <877jvkx88r.fsf@devron.myhome.or.jp> <873c67yk5v.fsf@devron.myhome.or.jp>
	 <20040510225818.GA24796@nevyn.them.org>
Content-Type: text/plain
Message-Id: <1084236054.1763.25.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 10 May 2004 21:40:54 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2004-05-10 at 19:58, Daniel Jacobowitz wrote:
> On Tue, May 11, 2004 at 07:47:08AM +0900, OGAWA Hirofumi wrote:
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
> > 
> > > So single-step exception happen *after* executed the "mov ...".
> > > Probably you need to use the breakpoint instead of single-step.
> > 
> > Ah, sorry. Just use PTRACE_SYSCALL instead of PTRACE_SINGLESTEP.
> > It's will stop before/after does syscall.
> 
> Doing it this way is pretty lousy - you have to inspect the code after
> every step to see if it's an int $0x80.  Is there some reason not to
> report a trap on the syscall return path if single-stepping?

Strange thing. When entering a syscall, the int 0x80 does clear the
trap, but first it is saved into the stack. When the iret is executed,
the eflags is restored from the stack, thus single stepping is
re-enabled.

The question is: the int 0x80 can be seen as complex instructions that
is only completed after the iret. This way, I do not see why a debug
trap is not generated afer the int 0x80 and BEFORE the mov.

I reinvented the wheel and built a module that did the same thing as
a singlestep ptrace, and a the trap WAS generated after the int 0x80
completed, before the mov. 

So I think it has sth to do with the debug trap handler. 

I DO NOT BELIEVE THIS BEAVIOUR is right, since if it is not stopping
after the int 0x80, ptrace is not TRULLY singlestepping.


