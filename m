Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265846AbTLIOPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265850AbTLIOPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:15:39 -0500
Received: from 0x50a14495.albnxx15.adsl-dhcp.tele.dk ([80.161.68.149]:58628
	"EHLO 0x50a14495.albnxx15.adsl-dhcp.tele.dk") by vger.kernel.org
	with ESMTP id S265846AbTLIOP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:15:29 -0500
Date: Tue, 9 Dec 2003 15:15:02 +0100
From: Rask Ingemann Lambertsen <rask@sygehus.dk>
To: "David S. Miller" <davem@redhat.com>
Cc: jt@hpl.hp.com, jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org,
       tsbogend@alpha.franken.de, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: [BUG 2.6.0-test11] pcnet32 oops
Message-ID: <20031209151459.A1345@sygehus.dk>
References: <20031205234510.GA2319@bougret.hpl.hp.com> <20031205165900.2920ea6a.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031205165900.2920ea6a.davem@redhat.com>; from davem@redhat.com on Fri, Dec 05, 2003 at 04:59:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 04:59:00PM -0800, David S. Miller wrote:
> This is the classic case of doing disabling/enabling of software
> interrupts with hardware interrupts disabled, which is a bug.
> 
> In this case pcnet32_set_multicast_list() is disabling hardware
> interrupts, and the packet freeing of pcnet32_purge_tx_ring()
> is what leads to the software interrupt disable/enable.

I think the root cause of this problem is that pcnet32_set_multicast_list()
dumps the entire TX ring on the floor (as a side effect of calling
pcnet32_restart()). I don't think dev->set_multicast_list() is supposed to
do that.

> However, I'm inclined to believe that we should change dev_kfree_skb_any()
> to fix this class of problems, by making it check for hardware interrupts
> being disabled as well as being in an interrupt.

I've been wondering about this too with the recent netpoll patches. Many
(including pcnet32) implement the poll controller simply as

	disable_irq (dev->irq);
	driver_interrupt_handler (dev->irq, dev, NULL);
	enable_irq (dev->irq);

If the interrupt handler calls dev_kfree_skb_any(), could you then run into
this kind of problem? Or is it just if you call spin_lock_irq*() that you
have a problem?

-- 
Regards,
Rask Ingemann Lambertsen
