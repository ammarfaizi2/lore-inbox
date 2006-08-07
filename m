Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWHGWOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWHGWOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWHGWOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:14:35 -0400
Received: from [198.99.130.12] ([198.99.130.12]:30660 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932119AbWHGWOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:14:35 -0400
Date: Mon, 7 Aug 2006 18:14:00 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] uml: fix proc-vs-interrupt context spinlock deadlock
Message-ID: <20060807221400.GC5890@ccure.user-mode-linux.org>
References: <20060806154700.536.32978.stgit@memento.home.lan> <20060806154703.536.80128.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806154703.536.80128.stgit@memento.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 05:47:03PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> This spinlock can be taken on interrupt too, so spin_lock_irq[save] must be used.
> 
> However, Documentation/networking/netdevices.txt explains we are called with
> rtnl_lock() held - so we don't need to care about other concurrent opens.
> Verified also in LDD3 and by direct checking. Also verified that the network
> layer (through a state machine) guarantees us that nobody will close the
> interface while it's being used. Please correct me if I'm wrong.
> 
> Also, we must check we don't sleep with irqs disabled!!! But anyway, this is not
> news - we already can't sleep while holding a spinlock. Who says this is
> guaranted really by the present code?

This patch looks fairly scary.  It's protecting the device private
data, you're removing the locking from some accesses and leaving it
(albeit with irqs off now) on others.  It seems to me that can't be
right.  It's either always there, or always not.

You observe that open and close are protected by rtnl_lock.  I observe
that uml_net_change_mtu and uml_net_set_mac are as well, in dev_ioctl.

The spinlock protecting this has to be _irqsave because the interrupt
routine takes it, to protect against receiving packets on an interface
that's being closed.  If that's impossible, we should prove that, and
remove the locking from uml_net_interrupt.

I can't decide about uml_net_start_xmit - there's some RCU stuff
around one call that leads to it, but I don't see any sign of
rtnl_lock.

So, I'd say there are some changes needed here, but they're not
entirely the ones in this patch.

				Jeff
