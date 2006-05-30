Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWE3VYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWE3VYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWE3VYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:24:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3463 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932471AbWE3VYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:24:50 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <447CB42E.5060004@free.fr>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <447CB42E.5060004@free.fr>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 May 2006 23:24:47 +0200
Message-Id: <1149024287.3636.121.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 23:07 +0200, Laurent Riffard wrote:
> Le 30.05.2006 11:29, Andrew Morton a écrit :
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> > ...
> >  Runtime locking validation.
> 
> ============================
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {hardirq-on-W} -> {in-hardirq-W} usage.
> events/0/4 [HC1[1]:SC0[0]:HE0:SE1] takes:
>  (&list->lock){+...}, at: [<c0247689>] skb_dequeue+0x12/0x43

hmmm skb_dequeue is called in a hard irq... 



> {hardirq-on-W} state was registered at:
>   [<c012d2a1>] lockdep_acquire+0x56/0x6f
>   [<c029595b>] _spin_lock_bh+0x1c/0x29
>   [<c02922e0>] unix_stream_connect+0x2d8/0x3a7

.. yet it was taken only with spin_lock_bh() in unix_stream_connect,
leaving interrupts enabled (and thus not allowing use inside a hard irq)

>   [<c0243fb4>] sys_connect+0x54/0x71
>   [<c0244c5c>] sys_socketcall+0x6f/0x166
>   [<c0295afd>] sysenter_past_esp+0x56/0x8d
> irq event stamp: 1886
> hardirqs last  enabled at (1885): [<c0295a2b>] _spin_unlock_irqrestore+0x35/0x3b
> hardirqs last disabled at (1886): [<c01032fb>] common_interrupt+0x1b/0x2c
> softirqs last  enabled at (0): [<c0114af0>] copy_process+0x265/0x11dc
> softirqs last disabled at (0): [<00000000>] init+0x3feffde0/0x1da
> 
> other info that might help us debug this:
> no locks held by events/0/4.
> 
> stack backtrace:
>  [<c0103810>] show_trace_log_lvl+0x4b/0xf4
>  [<c0103e11>] show_trace+0xd/0x10
>  [<c0103e58>] dump_stack+0x19/0x1b
>  [<c012b8be>] print_usage_bug+0x1a4/0x1ae
>  [<c012c3c6>] mark_lock+0x8a/0x411
>  [<c012cc55>] __lockdep_acquire+0x302/0x8f8
>  [<c012d2a1>] lockdep_acquire+0x56/0x6f
>  [<c0295906>] _spin_lock_irqsave+0x20/0x2f
>  [<c0247689>] skb_dequeue+0x12/0x43
>  [<e0bdb7ac>] hpsb_bus_reset+0x55/0xa2 [ieee1394]

yet hpsb_bus_reset() calls skb_dequeue (indirectly, via the inlined
abort_requests() function) in a hard irq.



