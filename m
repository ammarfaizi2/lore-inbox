Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVDEU6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVDEU6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVDEU5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:57:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22915 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262022AbVDEUoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:44:44 -0400
Date: Tue, 5 Apr 2005 22:44:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050405204436.GA31523@elte.hu>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru> <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru> <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > > So I'd actually prefer to get that mystery explained..
> > IIRC if the interrupt doesn't do the CPL
> > switch, the interrupt gate doesn't save
> > the stack, and so there may not be the
> > full "struct pt_regs" when the kernel
> > thread is interrupted.
> 
> Yes. But how do you have _such_ an empty stack when the interrupt 
> comes in? See what I mean? IOW, that requires that the kernel stack 
> would have only two words on it when the interrupt happens. How?
> 
> It may be a 4kB stack issue or something. Does this happen only with 
> CONFIG_4KSTACKS, and just after a stack switch to an irq stack, for 
> example?

i didnt have 4K stacks set. In all crashes, esp had the same pattern:

 esi: 009b63f9   edi: 00000001   ebp: f543a000   esp: f543bfc8

i.e. esp & 0xfff was 0xfc8 - while i think it should normally be 0xfc4 
(page boundary minus size of pt_regs == 0 - 0x3c == 0xfc4). So somewhere 
we lost 4 bytes of esp? An extra popl, or an addl $4, %esp? But why dont 
we crash in that case - it ought to shift all the pt_regs structure by a 
word, making it a completely senseless return frame. Any task in such a 
situation ought to at least segfault. So if this is during thread 
startup, i dont know how it survives the first execution.

	Ingo
