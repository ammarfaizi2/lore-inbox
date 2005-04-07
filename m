Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVDGOrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVDGOrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVDGOrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:47:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:44182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262480AbVDGOpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:45:51 -0400
Date: Thu, 7 Apr 2005 07:47:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, stsp@aknet.ru, linux-kernel@vger.kernel.org,
       VANDROVE@vc.cvut.cz
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
In-Reply-To: <20050407041006.4c9db8b2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0504070737190.28951@ppc970.osdl.org>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru>
 <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru>
 <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru>
 <20050407080004.GA27252@elte.hu> <20050407041006.4c9db8b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Andrew Morton wrote:
>
> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > --- linux/arch/i386/kernel/entry.S.orig
> >  +++ linux/arch/i386/kernel/entry.S
> >  @@ -179,12 +179,17 @@ need_resched:
> >   ENTRY(sysenter_entry)
> >   	movl TSS_sysenter_esp0(%esp),%esp
> >   sysenter_past_esp:
> >  -	sti
> >  +	#
> >  +	# irqs are disabled: set up an entry stackframe without
> >  +	# allowing irqs to potentially preempt us with an
> >  +	# incomplete entry frame!
> >  +	#
> >   	pushl $(__USER_DS)
> >   	pushl %ebp
> >   	pushfl
> >   	pushl $(__USER_CS)
> >   	pushl $SYSENTER_RETURN
> >  +	sti
> >   
> 
> Well that bites the big one.
>> 
> Program received signal SIGTRAP, Trace/breakpoint trap.
> 0xc015c4ba in __find_get_block (bdev=0xc18cd988, block=2818614, size=4096) at fs/buffer.c:1371
> 1371            BUG_ON(irqs_disabled());

Yes. With the change in place "entry.S" will always save the wrogn EIP, so 
we'll return with interrupts disabled.

Your suggested patch is pretty horrid, though. It's sufficient to enable
interrupts after the two first pushes, since that has already now set up
enough of a kernel stack that any subsequent interrupt will always have at
least a "fake" SS/ESP (ie some values there, although not anything
relevant).

So the sysenter sequence might as well look like

	pushl $(__USER_DS)	
	pushl %ebp
	sti
	pushfl
	..

which actually does three protected pushes thanks to the one-instruction 
"interrupt shadow" after an sti.

Another alternative (and to some degree a maybe a better one) is to not
use "pushfl" at all in the sysenter sequence, but instead just push a
fixed default value. At that point, the "sti" can stay where it was.

After all, I very strongly suspect that we don't actually really _care_ if
eflags stays the same over a system call, and I could see that some
dynamic CPU's might prefer not having to push an eflags value that just
got changed by the "sti", so it _might_ save several cycles to avoid that
dependency, and also obviously avoid a subtle dependency on a sw level
that the previous patch clearly introduced.

Anybody willing to time it? ;)

		Linus
