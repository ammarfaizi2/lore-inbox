Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTLJIcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 03:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTLJIcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 03:32:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53920 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263185AbTLJIcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 03:32:35 -0500
Date: Wed, 10 Dec 2003 00:30:59 -0800
From: "David S. Miller" <davem@redhat.com>
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: jt@hpl.hp.com, jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org,
       tsbogend@alpha.franken.de, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: [BUG 2.6.0-test11] pcnet32 oops
Message-Id: <20031210003059.24fdd370.davem@redhat.com>
In-Reply-To: <20031209151459.A1345@sygehus.dk>
References: <20031205234510.GA2319@bougret.hpl.hp.com>
	<20031205165900.2920ea6a.davem@redhat.com>
	<20031209151459.A1345@sygehus.dk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003 15:15:02 +0100
Rask Ingemann Lambertsen <rask@sygehus.dk> wrote:

> On Fri, Dec 05, 2003 at 04:59:00PM -0800, David S. Miller wrote:
> > This is the classic case of doing disabling/enabling of software
> > interrupts with hardware interrupts disabled, which is a bug.
> > 
> > In this case pcnet32_set_multicast_list() is disabling hardware
> > interrupts, and the packet freeing of pcnet32_purge_tx_ring()
> > is what leads to the software interrupt disable/enable.
> 
> I think the root cause of this problem is that pcnet32_set_multicast_list()
> dumps the entire TX ring on the floor (as a side effect of calling
> pcnet32_restart()). I don't think dev->set_multicast_list() is supposed to
> do that.

The task of dev->set_multicast_list() is to do whatever is necessary
to update the multicast filter.

If the pcnet32 hardware for some odd reason requires that you flush
the TX list, it is appropriate.

> I've been wondering about this too with the recent netpoll patches. Many
> (including pcnet32) implement the poll controller simply as
> 
> 	disable_irq (dev->irq);
> 	driver_interrupt_handler (dev->irq, dev, NULL);
> 	enable_irq (dev->irq);
> 
> If the interrupt handler calls dev_kfree_skb_any(), could you then run into
> this kind of problem? Or is it just if you call spin_lock_irq*() that you
> have a problem?

No, it would not be a problem because the thing that dev_kfree_skb_any()
_does_ test right now ('in_irq()') would trigger.
