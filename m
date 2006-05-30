Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWE3K06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWE3K06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWE3K06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:26:58 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:30683 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932196AbWE3K05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:26:57 -0400
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
From: Arjan van de Ven <arjan@linux.intel.com>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: jketreno@linux.intel.com, yi.zhu@intel.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060530091415.GA13341@ens-lyon.fr>
References: <20060529212109.GA2058@elte.hu>
	 <20060530091415.GA13341@ens-lyon.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 May 2006 12:26:27 +0200
Message-Id: <1148984787.3636.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 11:14 +0200, Benoit Boissinot wrote:
> On 5/29/06, Ingo Molnar <mingo@elte.hu> wrote:
> > We are pleased to announce the first release of the "lock dependency
> > correctness validator" kernel debugging feature, which can be downloaded
> > from:
> >
> >   http://redhat.com/~mingo/lockdep-patches/
> > [snip]
> 
> I get this right after ipw2200 is loaded (it is quite verbose, I
> probably shoudln't post everything...)
> 
> ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
> ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)


>  <c0301efa> netlink_broadcast+0x7a/0x360  

this isn't allow to be called from IRQ context, because it takes
nl_table_lock for read, but that is taken as
        write_lock_bh(&nl_table_lock);
in 
	static void netlink_table_grab(void)
so without disabling interrupts; which would thus deadlock if this
read_lock-from-irq would hit.

>  <c02fb6a4> wireless_send_event+0x304/0x340
>  <e1cf8e11> ipw_rx+0x1371/0x1bb0 [ipw2200] 
>  <e1cfe6ac> ipw_irq_tasklet+0x13c/0x500 [ipw2200]
>  <c0121ea0> tasklet_action+0x40/0x90  

but it's more complex than that, since we ARE in BH context.
The complexity comes from us holding &priv->lock, which is 
used in hard irq context.

so the deadlock is like this:


cpu 0: user context					cpu1: softirq context
   netlink_table_grab takes nl_table_lock as		take priv->lock	in ipw_irq_tasklet
   write_lock_bh, but leaves irqs enabled


   hardirq comes in and the isr tries to take           in ipw_rx, call wireless_send_event which
   priv->lock but has to wait on cpu 1                  tries to take nl_table_lock for read
                                                        but has to wait for cpu0

and... kaboom kabang deadlock :)


