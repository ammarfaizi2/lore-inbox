Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTEMRIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTEMRIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:08:47 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:18614 "HELO
	vaxjo.synopsys.com") by vger.kernel.org with SMTP id S262429AbTEMRIo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:08:44 -0400
Date: Tue, 13 May 2003 19:21:14 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.69+bk: "sleeping function called from illegal context" on card release while shutting down
Message-ID: <20030513172114.GH32559@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
References: <20030513135759.GG32559@Synopsys.COM> <1052837896.1000.2.camel@teapot.felipe-alfaro.com> <1052839860.2255.19.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052839860.2255.19.camel@diemos>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum, Tue, May 13, 2003 17:31:01 +0200:
> > > Just tried to eject the card while the system was shutting down.
> > Don't know if this is fixed by latest Russell patches, but vanilla and
> > -bk snapshots do *not* contain the latest PCMCIA/CardBus code. Is it
> > possible for you to try 2.5.69-mm4?
> 
> Russell's patches do not address this.

still i'm going to give them a spin a bit later.

> Individual PCMCIA drivers need to be updated to call
> thier release function directly when processing a
> CARD_RELEASE message instead of from a timer procedure.
> 
> Similar to this patch for synclink_cs.c:
...
> -		    mod_timer(&link->release, jiffies + HZ/20);
> +		    mgslpc_release((u_long)link);

Tried that. This time the trace looks different:

Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0118bc8>] __might_sleep+0x58/0x70
 [<c6a31eb6>] +0x82/0x58c [pcmcia_core]
 [<c6a2d193>] undo_irq+0x23/0x90 [pcmcia_core]
 [<c6a31eb6>] +0x82/0x58c [pcmcia_core]
 [<c6a302f8>] pcmcia_release_irq+0xb8/0xe0 [pcmcia_core]
 [<c6a25e00>] pcnet_release+0x0/0x80 [pcnet_cs]
 [<c6a312d5>] CardServices+0x155/0x260 [pcmcia_core]
 [<c6a312c9>] CardServices+0x149/0x260 [pcmcia_core]
 [<c6a25e56>] pcnet_release+0x56/0x80 [pcnet_cs]
 [<c01224a4>] run_timer_softirq+0xc4/0x1a0
 [<c010a8b3>] handle_IRQ_event+0x33/0xf0
 [<c011e889>] do_softirq+0xa9/0xb0
 [<c010abb5>] do_IRQ+0x125/0x150
 [<c01093a8>] common_interrupt+0x18/0x20
 [<c013cfb6>] zap_pte_range+0xd6/0x1d0
 [<c013d0f3>] zap_pmd_range+0x43/0x70
 [<c013d153>] unmap_page_range+0x33/0x60
 [<c013d271>] unmap_vmas+0xf1/0x260
 [<c01412d5>] exit_mmap+0x65/0x180
 [<c0119196>] mmput+0x56/0xb0
 [<c01556ce>] exec_mmap+0xce/0x150
 [<c01557e8>] flush_old_exec+0x18/0x830
 [<c01555ea>] kernel_read+0x3a/0x50
 [<c0170483>] load_elf_binary+0x283/0xba0
 [<c01316fd>] generic_file_aio_read+0x3d/0x50
 [<c0134379>] buffered_rmqueue+0xc9/0x160
 [<c0170200>] load_elf_binary+0x0/0xba0
 [<c015639b>] search_binary_handler+0xcb/0x2d0
 [<c01566f9>] do_execve+0x159/0x1a0
 [<c0157d28>] getname+0x78/0xc0
 [<c0107a46>] sys_execve+0x36/0x70
 [<c0109187>] syscall_call+0x7/0xb
