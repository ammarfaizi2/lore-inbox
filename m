Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWGDUBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWGDUBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWGDUBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:01:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37045 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932370AbWGDUBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 16:01:21 -0400
Subject: Re: 2.6.17-mm6
From: Arjan van de Ven <arjan@infradead.org>
To: netdev@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200607042153.31848.rjw@sisk.pl>
References: <20060703030355.420c7155.akpm@osdl.org>
	 <200607042153.31848.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 22:01:11 +0200
Message-Id: <1152043271.3109.95.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is one for the networking people, and thus netdev


On Tue, 2006-07-04 at 21:53 +0200, Rafael J. Wysocki wrote:
> On Monday 03 July 2006 12:03, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> > 
> > 
> > - A major update to the e1000 driver.
> > 
> > - 1394 updates
> 
> Just found this in dmesg:
> 
> =================================
> [ INFO: inconsistent lock state ]
> ---------------------------------
> inconsistent {in-hardirq-W} -> {hardirq-on-W} usage.
> nscd/4929 [HC0[0]:SC0[1]:HE1:SE0] takes:
>  (&skb_queue_lock_key){++..}, at: [<ffffffff8044fe40>] udp_ioctl+0x50/0xa0
> {in-hardirq-W} state was registered at:
>   [<ffffffff8024b4fa>] lock_acquire+0x8a/0xc0
>   [<ffffffff80476e3f>] _spin_lock_irqsave+0x3f/0x60
>   [<ffffffff80408c25>] skb_queue_tail+0x25/0x60

ok so skb_queue_lock is used in a hardirq context

>   [<ffffffff881c9517>] queue_packet_complete+0x27/0x40 [ieee1394]
>   [<ffffffff881c9d6b>] hpsb_packet_sent+0xab/0x100 [ieee1394]
>   [<ffffffff8822a4b5>] dma_trm_reset+0x115/0x140 [ohci1394]
>   [<ffffffff8822c512>] ohci_devctl+0x1c2/0x540 [ohci1394]
>   [<ffffffff881c9673>] hpsb_bus_reset+0x43/0xb0 [ieee1394]
>   [<ffffffff8822d7f6>] ohci_irq_handler+0x416/0x830 [ohci1394]
>   [<ffffffff802631ab>] handle_IRQ_event+0x2b/0x70
>   [<ffffffff80264dd4>] handle_level_irq+0xc4/0x130
>   [<ffffffff8020c762>] do_IRQ+0x112/0x130
>   [<ffffffff80209d90>] common_interrupt+0x64/0x65
> irq event stamp: 4280
> hardirqs last  enabled at (4279): [<ffffffff8047606a>] trace_hardirqs_on_thunk+0x35/0x37
> hardirqs last disabled at (4278): [<ffffffff804760a1>] trace_hardirqs_off_thunk+0x35/0x67
> softirqs last  enabled at (4258): [<ffffffff804065b5>] release_sock+0xd5/0xe0
> softirqs last disabled at (4280): [<ffffffff804764d1>] _spin_lock_bh+0x11/0x50
> 
> other info that might help us debug this:
> no locks held by nscd/4929.
> 
> stack backtrace:
> 
> Call Trace:
>  [<ffffffff8020ab9f>] show_trace+0x9f/0x240
>  [<ffffffff8020af75>] dump_stack+0x15/0x20
>  [<ffffffff80249e52>] print_usage_bug+0x272/0x290
>  [<ffffffff8024a0d7>] mark_lock+0x267/0x5f0
>  [<ffffffff8024a9a6>] __lock_acquire+0x546/0xd10
>  [<ffffffff8024b4fb>] lock_acquire+0x8b/0xc0
>  [<ffffffff804764f4>] _spin_lock_bh+0x34/0x50
>  [<ffffffff8044fe40>] udp_ioctl+0x50/0xa0

yet udp_ioctl takes it only for _bh

>  [<ffffffff80457359>] inet_ioctl+0x69/0x70
>  [<ffffffff804033ac>] sock_ioctl+0x22c/0x270
>  [<ffffffff802a32b1>] do_ioctl+0x31/0xa0
>  [<ffffffff802a35db>] vfs_ioctl+0x2bb/0x2e0
>  [<ffffffff802a366a>] sys_ioctl+0x6a/0xa0
>  [<ffffffff8020985a>] system_call+0x7e/0x83
>  [<00002b2d76ab98a9>]


is this a real scenario, or is this a case of "firewire is special and
needs it's own rules"?


