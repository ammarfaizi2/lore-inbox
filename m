Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWE3LmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWE3LmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWE3LmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:42:08 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:15563 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1750899AbWE3LmH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:42:07 -0400
Date: Tue, 30 May 2006 13:42:57 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: jketreno@linux.intel.com, yi.zhu@intel.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530114257.GA17628@ens-lyon.fr>
References: <20060529212109.GA2058@elte.hu> <20060530091415.GA13341@ens-lyon.fr> <1148984787.3636.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148984787.3636.45.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 12:26:27PM +0200, Arjan van de Ven wrote:
> On Tue, 2006-05-30 at 11:14 +0200, Benoit Boissinot wrote:
> > On 5/29/06, Ingo Molnar <mingo@elte.hu> wrote:
> > > We are pleased to announce the first release of the "lock dependency
> > > correctness validator" kernel debugging feature, which can be downloaded
> > > from:
> > >
> > >   http://redhat.com/~mingo/lockdep-patches/
> > > [snip]
> > 
> > I get this right after ipw2200 is loaded (it is quite verbose, I
> > probably shoudln't post everything...)
> > 
> > ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
> > ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)
> 
> 
> >  <c0301efa> netlink_broadcast+0x7a/0x360  
> 
> this isn't allow to be called from IRQ context, because it takes
> nl_table_lock for read, but that is taken as
>         write_lock_bh(&nl_table_lock);
> in 
> 	static void netlink_table_grab(void)
> so without disabling interrupts; which would thus deadlock if this
> read_lock-from-irq would hit.
> 
> >  <c02fb6a4> wireless_send_event+0x304/0x340
> >  <e1cf8e11> ipw_rx+0x1371/0x1bb0 [ipw2200] 
> >  <e1cfe6ac> ipw_irq_tasklet+0x13c/0x500 [ipw2200]
> >  <c0121ea0> tasklet_action+0x40/0x90  
> 
> but it's more complex than that, since we ARE in BH context.
> The complexity comes from us holding &priv->lock, which is 
> used in hard irq context.

It is probably related, but I got this in my log too:

BUG: warning at kernel/softirq.c:86/local_bh_disable()
 <c010402d> show_trace+0xd/0x10  <c0104687> dump_stack+0x17/0x20
 <c0121fdc> local_bh_disable+0x5c/0x70  <c03520f1> _read_lock_bh+0x11/0x30
 <c02e8dce> sock_def_readable+0x1e/0x80  <c0302130> netlink_broadcast+0x2b0/0x360
 <c02fb6a4> wireless_send_event+0x304/0x340  <e1cf8e11> ipw_rx+0x1371/0x1bb0 [ipw2200]
 <e1cfe6ac> ipw_irq_tasklet+0x13c/0x500 [ipw2200] <c0121ea0> tasklet_action+0x40/0x90
 <c01223b4> __do_softirq+0x54/0xc0  <c01056bb> do_softirq+0x5b/0xf0
 =======================
 <c0122455> irq_exit+0x35/0x40  <c01057c7> do_IRQ+0x77/0xc0
 <c0103949> common_interrupt+0x25/0x2c 

> 
> so the deadlock is like this:
> 
> 
> cpu 0: user context					cpu1: softirq context
>    netlink_table_grab takes nl_table_lock as		take priv->lock	in ipw_irq_tasklet
>    write_lock_bh, but leaves irqs enabled
> 
> 
>    hardirq comes in and the isr tries to take           in ipw_rx, call wireless_send_event which
>    priv->lock but has to wait on cpu 1                  tries to take nl_table_lock for read
>                                                         but has to wait for cpu0
> 
> and... kaboom kabang deadlock :)
> 
> 

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
