Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267240AbUGMXsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267240AbUGMXsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267241AbUGMXsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:48:41 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:47841 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S267240AbUGMXs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:48:28 -0400
Date: Tue, 13 Jul 2004 16:48:19 -0700
Message-Id: <200407132348.i6DNmJpj006615@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@suse.de>
X-Fcc: ~/Mail/linus
Cc: akpm@osdl.org, torvalds@osdl.org, mingo@redhat.com, jparadis@redhat.com,
       cagney@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 support for singlestep into 32-bit system calls
In-Reply-To: Andi Kleen's message of  Tuesday, 13 July 2004 09:23:07 +0200 <20040713092307.4cd6b5aa.ak@suse.de>
X-Zippy-Says: Should I start with the time I SWITCHED personalities with a
   BEATNIK hair stylist or my failure to refer five TEENAGERS to a
   good OCULIST?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would prefer not to merge this. It looks extremly ugly and the current
> behaviour is not that unreasonable and gdb has lived with it forever,
> so why can't it continue it? It has to keep supporting old versions
> anyways and other i386 OS it supports probably do the same.
> 
> If i386 merges it I guess it's ok for consistency, but it would be 
> better to not do it at all.

Just because it has always been wrong before doesn't mean it's not wrong or
shouldn't be fixed.  I think I have stated the case for the i386 behavior
change in that thread, so I won't reiterate it.  The solution currently in
-mm is arguably ugly, but it adds no overhead and affects only the behavior
of the ptrace cases, and makes the user semantics go from ugly to correct.

Certainly the changes for x86_64's ia32 support should go in if the i386
native changes do and not if they don't--the purpose of the x86_64 ia32
support is to behave the same way the native i386 kernel does.  But as to
whether both together should be in or out, the people who actually use
ptrace are agreed that they should go in.

> > +#ifdef CONFIG_IA32_EMULATION
> > +	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
> > +#endif
> 
> This looks wrong. Why do you do this unconditionally when 32bit 
> emulation is compiled in? Either it is correct to do for 64bit 
> processes, then the ifdef should go, or it is not correct then
> it would need a test. For me dropping the flag both for 32bit
> and 64bit looks wrong.

It is not wrong; it is sometimes superfluous.  In 64-bit processes it is
superfluous because the flag can never be set in a 64-bit process anyway.
But there is no reason to do it at all when there are no 32-bit processes
to consider, hence the #ifdef's.  I figured the superfluous bit clearing
would be cheaper than the extra test and branch to avoid it.  But I haven't
done any measurements to support that.  It would also be correct to do:

	#ifdef CONFIG_IA32_EMULATION
		if (test_tsk_thread_flag(child, TIF_IA32))
			clear_tsk_thread_flag(child, TIF_SINGLESTEP);
	#endif


Thanks,
Roland
