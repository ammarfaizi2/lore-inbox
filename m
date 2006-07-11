Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWGKX1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWGKX1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWGKX1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:27:13 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:10395 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751347AbWGKX1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:27:12 -0400
Message-ID: <44B433CE.1030103@oracle.com>
Date: Tue, 11 Jul 2006 16:27:10 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [openib-general] ipoib lockdep warning
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
In-Reply-To: <adawtajzra5.fsf@cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> No time to really look at this in detail, but I think the issue is a
> slightly bogus conversion to netif_tx_lock().  Can you try this patch
> and see if things are better?

> -	local_irq_save(flags);
>  	netif_tx_lock(dev);
> -	spin_lock(&priv->lock);
> +	spin_lock_irqsave(&priv->lock, flags);

Hmm, won't that hold dev->_xmit_lock with interrupts enabled?  That
seems like it'd deadlock with dev_watchdog grabbing it from a softirq?

But setting that aside, I don't think this will help as it doesn't
change the order that the locks are acquired in this path.  This can
still be racing with other cpus that are each in the other two paths
(queue_idr.lock -> softirq -> dev->_xmit_lock, priv->lock ->
queue_idr.lock).  The local state of interrupt masking on this cpu
doesn't stop the other cpus from each grabbing the first lock in their
path and then trying to grab the second.  Imagine that they all race to
grab the first (A, B, C) and succeed and then all get stuck spinning on
their second lock (B, C, A).

Maybe you could get the priv->lock here before dev->_xmit_lock.  Then
we'd have AB, BC, AC, and that's OK.  I'm going to guess that this won't
work because other paths have dev->_xmit_lock -> priv->lock ordering.

Another possibility is masking interrupts when getting queue_idr.lock.
That drops the implicit dependency between queue_idr and _xmit_lock and
gives us AB, B, CA -- which is fine.  That means blocking ints while in
idr_pre_get() which allocs which leads to GFP_ATOMIC and more likely
allocation failure.

That's my reading, anyway.

- z
