Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVC0R0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVC0R0a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 12:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVC0R0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 12:26:30 -0500
Received: from colin2.muc.de ([193.149.48.15]:29965 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261191AbVC0R00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 12:26:26 -0500
Date: 27 Mar 2005 19:26:25 +0200
Date: Sun, 27 Mar 2005 19:26:25 +0200
From: Andi Kleen <ak@muc.de>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 preemption fix from IRQ and BKL in 2.6.12-rc1-mm2
Message-ID: <20050327172625.GC18506@muc.de>
References: <20050324044114.5aa5b166.akpm@osdl.org> <1111778785.14840.13.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111778785.14840.13.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 08:26:25PM +0100, Christophe Saout wrote:
> Fortunately the kernel locked up and there was no data corruption.
> 
> I've got PREEMPT and PREEMPT_BKL enabled under UP.
> 
> I just took a look at the change and found this:
> 
> x86-64 does this (in entry.S):
> 
>         bt   $9,EFLAGS-ARGOFFSET(%rsp)  /* interrupts off? */
>         jnc   retint_restore_args
>         movl $PREEMPT_ACTIVE,threadinfo_preempt_count(%rcx)
>         sti
>         call schedule
>         cli
>         GET_THREAD_INFO(%rcx)
>         movl $0,threadinfo_preempt_count(%rcx)
>         jmp exit_intr
> 
> while i386 does this:
> 
>         testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
>         jz restore_all
>         call preempt_schedule_irq
>         jmp need_resched
> 
> preempt_schedule_irq is not an i386 specific function and seems to take
> special care of BKL preemption and since reiserfs does use the BKL to do
> certain things I think this actually might be the problem...?

Hmm, preempt_schedule_irq is not in mainline as far as I can see.
My patches are always for mainline; i dont do a special
patch kit for -mm*

It looks like a unfortunate interaction with some other patches
in mm. Andrew, can you disable CONFIG_PREEMPT on x86-64 in
mm for now?

Just calling preempt_schedule_irq may also work, 
but most likely the patch that introduces that function needs
careful reading if it does not require more support from architectures.
BTW I suspect it will break other archs too...

> Unfortunately I don't have a amd64 machine to play with, so can somebody
> please check this?

How did you generate the crash dumps above then?

-Andi
