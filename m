Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265682AbUGMSuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUGMSuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 14:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUGMSuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 14:50:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:21475 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265729AbUGMSuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 14:50:00 -0400
Date: Tue, 13 Jul 2004 11:48:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713114829.705b9607.akpm@osdl.org>
In-Reply-To: <20040713162539.GD974@dualathlon.random>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	<200407130001.i6D01pkJ003489@localhost.localdomain>
	<20040712170844.6bd01712.akpm@osdl.org>
	<20040713162539.GD974@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Mon, Jul 12, 2004 at 05:08:44PM -0700, Andrew Morton wrote:
> > of code then it's pretty obvious what's happening.  If the trace is due to
> > a long irq-off time then it will point up into the offending
> > local_irq_enable().
> 
> schedule should be called with irq enabled, and I noticed here it's not
> (jnz work_resched is executed with irq off so there is a window for
> schedule to be called with irq off):
> 
> Index: linux-2.5/arch/i386/kernel/entry.S
> ===================================================================
> RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/kernel/entry.S,v
> retrieving revision 1.86
> diff -u -p -r1.86 entry.S
> --- linux-2.5/arch/i386/kernel/entry.S	23 May 2004 05:03:15 -0000	1.86
> +++ linux-2.5/arch/i386/kernel/entry.S	13 Jul 2004 04:21:55 -0000
> @@ -302,6 +310,7 @@ work_pending:
>  	testb $_TIF_NEED_RESCHED, %cl
>  	jz work_notifysig
>  work_resched:
> +	sti
>  	call schedule
>  	cli				# make sure we don't miss an interrupt
>  					# setting need_resched or sigpending

sys_sched_yield() also calls schedule() with local interrupts disabled. 
It's a bit grubby, but saves a few cycles.  Nick and Ingo prefer it that way.
