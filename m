Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSHBDeC>; Thu, 1 Aug 2002 23:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSHBDeC>; Thu, 1 Aug 2002 23:34:02 -0400
Received: from mnh-1-08.mv.com ([207.22.10.40]:35077 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318035AbSHBDeB>;
	Thu, 1 Aug 2002 23:34:01 -0400
Message-Id: <200208020440.XAA04793@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Accelerating user mode linux 
In-Reply-To: Your message of "Thu, 01 Aug 2002 16:16:58 -0400."
             <200208012016.g71KGwK27981@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Aug 2002 23:40:28 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@redhat.com said:
> We add
> 	sys_switchmm(address);
> This switches to the altmm (creating one if it doesnt exist as a copy
> of the current mm), flushes the tlb and jumps to the address given. 

You didn't explicitly say (and so I had to ask :-) that this is intended
to be the mechanism by which UML returns to userspace, rather than the
normal sigreturn you'd get by just returning from the handler.

So, this would make the entry to userspace look like:
	restore registers
		.
		.
		.
	sys_switchmm(ip);

The problem with this is that it needs to be atomic wrt signals.  There
can't be an interrupt in the middle of that sequence.  So, sys_switchmm
would also have to restore the old signal mask, which you'd have to pass
in unless you're going to read it off the signal frame.  Also, it would
have to be open coded because you've already restored the stack pointer.

So, the entry to userspace starts looking like:
	block signals
	restore registers
	sys_switchmm(ip, new_sigmask);

Well, except for the blocking signals part, this is sigreturn under a 
different name and partly moved into userspace.  

Your objection to returning through sigreturn was performance.  Is performance
a veto of adding an mm switch to sigreturn, or it is possible to make it
acceptible?

Also, is a new sigreturn_mm() reasonable?  This would be close to sys_switchmm,
except that it would restore registers and would be a plug replacement for
sigreturn[_rt].  I don't favor this because it would probably have to choose 
whether to be an _rt return or not, and I'd like the option of having UML 
register some signals as SA_INFO (currently, they are all non SA_INFO).

Comments, brickbats, spanners?

				Jeff

