Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423053AbWJVGgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423053AbWJVGgr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 02:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423049AbWJVGgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 02:36:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423045AbWJVGgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 02:36:46 -0400
Date: Sat, 21 Oct 2006 23:36:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: preining@logic.at, linux-kernel@vger.kernel.org,
       Michael Chan <mchan@broadcom.com>, netdev@vger.kernel.org
Subject: Re: tg3 kernel bug in 2.6.18-mm3 and 2.6.19-rc2-mm2
Message-Id: <20061021233610.f190e0a8.akpm@osdl.org>
In-Reply-To: <20061021.123814.106436476.davem@davemloft.net>
References: <20061021132239.GA29288@gamma.logic.tuwien.ac.at>
	<20061021.123814.106436476.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2006 12:38:14 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Norbert Preining <preining@logic.at>
> Date: Sat, 21 Oct 2006 15:22:39 +0200
> 
> >  [<c010469d>] dump_stack+0x12/0x14
> >  [<c0141cb3>] softlockup_tick+0xaa/0xc1
> >  [<c0129bad>] update_process_times+0x3b/0x5e
> >  [<c01362a1>] handle_update_profile+0x14/0x1e
> >  [<c0115956>] smp_apic_timer_interrupt+0x49/0x5b
> >  [<c0103998>] apic_timer_interrupt+0x28/0x30
> > DWARF2 unwinder stuck at apic_timer_interrupt+0x28/0x30
> > Leftover inexact backtrace:
> >  [<c01d03af>] delay_tsc+0xb/0x13
> >  [<c01d03e0>] __delay+0x6/0x7
> 
> It's OOPS'ing by softlockup'ing in udelay() and then we get a corrupt
> backtrace.

The unwinder-based backtrace is screwed up (yet again) but the old-style
backtrace is there, in all its messy glory.

Weeding out the crap, I think it's this:

 [<c01d03af>] delay_tsc+0xb/0x13
 [<c01d03e0>] __delay+0x6/0x7
 [<c022c240>] _tw32_flush+0x3f/0x51
 [<c022da97>] tg3_switch_clocks+0x8f/0x93

 <I assume tg3_init_hw() got inlined>

 [<c0237673>] tg3_open+0x250/0x520
 [<c02d3263>] dev_open+0x2b/0x62
 [<c02d1dd8>] dev_change_flags+0x47/0xe4
 [<c0307fcc>] devinet_ioctl+0x252/0x556
 [<c02d2e5a>] dev_ifsioc+0x113/0x38d
 [<c02d29c4>] dev_load+0x24/0x4b
 [<c02c9265>] sock_ioctl+0x19e/0x1c2

It's strange that the post-2.6.19-rc2 changes triggered this - that code
won't have run yet.

Norbert, are you really sure?
