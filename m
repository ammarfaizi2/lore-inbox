Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266260AbTGECMt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 22:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266261AbTGECMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 22:12:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:64145 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266260AbTGECMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 22:12:48 -0400
Date: Fri, 4 Jul 2003 19:28:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.5.74] bad: scheduling while atomic!
Message-Id: <20030704192806.76f07845.akpm@osdl.org>
In-Reply-To: <20030704153407.GA3540@k3.hellgate.ch>
References: <20030704153407.GA3540@k3.hellgate.ch>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi <rl@hellgate.ch> wrote:
>
> I haven't had the time to investigate this, so I don't have much
> information to share beyond the trace below. I think I have seen this at
> least with 2.5.73, too. The system looks okay, then, usually hours later
> (if at all, it's a rare event), something triggers a flood of those call
> traces (many of them per second).
> 
> The syslog seems to suggest it might be related to IDE DMA:
> 
> Jul  4 17:17:28 [kernel] hda: dma_timer_expiry: dma status == 0x61
> Jul  4 17:17:44 [kernel] hda: timeout waiting for DMA
> Jul  4 17:17:44 [kernel]  [<c0107000>] default_idle+0x0/0x40
> Jul  4 17:17:44 [kernel] bad: scheduling while atomic!
> 
> Compiler is gcc 3.2.3.
> 
> bad: scheduling while atomic!
> Call Trace:
>  [<c0107000>] default_idle+0x0/0x40
>  [<c011f110>] schedule+0x500/0x510
>  [<c0107063>] poll_idle+0x23/0x40
>  [<c0118073>] apm_cpu_idle+0xa3/0x140
>  [<c0117fd0>] apm_cpu_idle+0x0/0x140
>  [<c0107000>] default_idle+0x0/0x40
>  [<c01070b8>] cpu_idle+0x38/0x40
>  [<c0105000>] rest_init+0x0/0x30
>  [<c037c738>] start_kernel+0x138/0x140
>  [<c037c4c0>] unknown_bootoption+0x0/0x100

Possibly the IDE error handler has a locking imbalance.  It returned from
the interrupt handler without having unlocked a lock which it should have
unlocked, and that left the currently-running process (the idle task in
this case) with an incorrect preempt count.
