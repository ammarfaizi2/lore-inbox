Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136694AbREGWLV>; Mon, 7 May 2001 18:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136695AbREGWLL>; Mon, 7 May 2001 18:11:11 -0400
Received: from [64.64.109.142] ([64.64.109.142]:62732 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S136694AbREGWLB>; Mon, 7 May 2001 18:11:01 -0400
Message-ID: <3AF71D3B.E4D0AFFB@didntduck.org>
Date: Mon, 07 May 2001 18:10:03 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: nigel@nrg.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <Pine.LNX.4.31.0105071443080.1195-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 7 May 2001, Brian Gerst wrote:
> >
> > Keep in mind that regs->eflags could be from user space, and could have
> > some undesirable flags set.  That's why I did a test/sti instead of
> > reloading eflags.  Plus my patch leaves interrupts disabled for the
> > minimum time possible.
> 
> The plain "popf" should be ok: the way intel works, you cannot actually
> use popf to set any of the strange flags (if vm86 mode etc).

TF (trap flag) would be one that I wouldn't want to get reset.  You
could use
	local_irq_restore(regs->eflags & ~(TF|RF|VM|NT))
which are all the flags cleared by an interrupt/trap gate.  Or
	if (regs->eflags & IF) sti();
Take your pick.

--

				Brian Gerst
