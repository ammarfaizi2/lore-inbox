Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTEVIPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 04:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTEVIPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 04:15:34 -0400
Received: from ns.suse.de ([213.95.15.193]:45319 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262571AbTEVIPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 04:15:32 -0400
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use of sti in entry.S question
References: <200305220939.13619.baldrick@wanadoo.fr.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 May 2003 10:28:33 +0200
In-Reply-To: <200305220939.13619.baldrick@wanadoo.fr.suse.lists.linux.kernel>
Message-ID: <p73ptmb8jwu.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands <baldrick@wanadoo.fr> writes:

> 2.5/arch/i386/kernel/entry.S:
> 
> In work_resched, schedule may be called with
> interrupts off:
> 
> work_resched:
>         call schedule
>         cli                             # make sure we don't miss an interrupt
>                                         # setting need_resched or sigpending
>                                         # between sampling and the iret
>         movl TI_FLAGS(%ebp), %ecx
>         andl $_TIF_WORK_MASK, %ecx      # is there any work to be done other
>                                         # than syscall tracing?
>         jz restore_all
>         testb $_TIF_NEED_RESCHED, %cl
>         jnz work_resched <====== schedule with interrupts disabled
> 
> Is this a mistake or an optimization?  Elsewhere in entry.S, interrupts
> are turned on before calling schedule:

It's a mistake, but a harmless one. The scheduler turns off interrupts
soon itself and the instructions it executes before that don't care.
The only reason it's not recommended to call schedule with interrupts
off is that the scheduler will turn them on again, usually breaking
your critical section. In this case it's ok because the next
instrution is a cli again.

-Andi
