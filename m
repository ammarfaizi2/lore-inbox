Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUEJVu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUEJVu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUEJVu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:50:27 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:32527 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261925AbUEJVuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:50:19 -0400
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace in 2.6.5
References: <1UlcA-6lq-9@gated-at.bofh.it>
	<m365b4kth8.fsf@averell.firstfloor.org>
	<1084220684.1798.3.camel@slack.domain.invalid>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 11 May 2004 06:49:56 +0900
In-Reply-To: <1084220684.1798.3.camel@slack.domain.invalid>
Message-ID: <877jvkx88r.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabiano Ramos <ramos_fabiano@yahoo.com.br> writes:

> > >      Is ptrace(), in singlestep mode, required to stop after a int 0x80?
> > >     When tracing a sequence like
> > >
> > > 	mov ...
> > > 	int 0x80
> > > 	mov ....
> > >
> > >     ptrace would notify the tracer after the two movs, but not after the
> > > int 0x80. I want to know if it is a bug or the expected behaviour.
> > 
> > What happens is that after the int 0x80 the CPU is in ring 0 (you
> > don't get an trace event in that mode unless you use a kernel debugger). 
> > Then when the kernel returns the last instruction executed before it is an 
> > IRET. But the IRET is also executed still in ring 0 and you should not get 
> > an event for it (you can not even access its code from user space).
> 
> I got it. But I need it to stop after the instruction. I am a newbie,
> so is it trivial to patch the kernel so that it STOPS after the int
> 0x80? Can  you give me some light on it?

This is the behavior of CPU, not kernel. "iret" after "int 0x80",
it restores the eip to "mov ...".

 	int 0x80
        		does syscall
                        iret
 	mov ....
                  <---- exception here (eip = "next insn")
	next insn
        
So single-step exception happen *after* executed the "mov ...".
Probably you need to use the breakpoint instead of single-step.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
