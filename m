Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266363AbSLTXbV>; Fri, 20 Dec 2002 18:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbSLTXbV>; Fri, 20 Dec 2002 18:31:21 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:14572 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266363AbSLTXbT>;
	Fri, 20 Dec 2002 18:31:19 -0500
Date: Fri, 20 Dec 2002 23:38:25 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, hpa@transmeta.com, terje.eggestad@scali.com,
       matti.aarnio@zmailer.org, hugh@veritas.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021220233825.GA22232@bjl1.asuk.net>
References: <20021220120656.GA20674@bjl1.asuk.net> <Pine.LNX.4.44.0212200834590.2035-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212200834590.2035-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> And if the caller cannot depend on registers being saved, the caller may
> actually end up being more complicated. For example, with the current
> setup, you can have
> 
> 	getpid():
> 		movl $__NR_getpid,%eax
> 		jmp *%gs:0x18
> 
> but if system calls clobber registers, the caller needs to be
> 
> [long code snippet]
> 
> and notice how the _real_ code sequence actually got much _worse_ from the
> fact that you tried to save time by not saving registers.

No, your "real" code sequence is wrong.

%ebx/%edi/%esi are preserved across sysenter/sysexit, whereas
%ecx/%edx are call-clobbered registers in the i386 function call ABI.

This is not a coincidence.

So, getpid looks like this with the _smaller_ vsyscall code:

 	getpid():
 		movl $__NR_getpid,%eax
 		call *%gs:0x18
 		ret

Intel didn't choose %ecx/%edx as the sysexit registers by accident.
They were chosen for exactly this reason.

By the way, the same applies to AMD's syscall/sysret, which clobbers %ecx.

What I'm suggesting is that we should say that "call 0xffffe000"
clobbers only the registers (%eax/%ecx/%edx) that _normal_ function
calls clobber on i386, and preserves the call-saved registers.

This keeps the size of system call stubs in libc to the minimum.
Think about it.

-- Jamie
