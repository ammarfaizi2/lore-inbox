Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWIKExo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWIKExo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 00:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWIKExo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 00:53:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:56228 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932094AbWIKExn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 00:53:43 -0400
Subject: Re: TG3 data corruption (TSO ?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1157745256.5344.8.camel@rh4>
References: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
	 <9EAEC3B2-260E-444E-BCA1-3C9806340F65@kernel.crashing.org>
	 <1157745256.5344.8.camel@rh4>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 14:53:30 +1000
Message-Id: <1157950410.31071.402.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oh, we know about this.  The powerpc writel() used to have memory
> barriers in 2.4 kernels but not any more in 2.6 kernels.  Red Hat's
> version of tg3 has extra wmb()'s to fix this problem.  David doesn't
> think that the upstream version of tg3 should have these wmb()'s, and
> the problem should instead be fixed in powerpc's writel().

I've added a wmb() in tw32_rx_mbox() and tw32_tx_mbox() and can still
reproduce the problem. I've also done a 2 days run without TSO enabled
without a failure (my test program normally fails after a couple of
minutes).

Thus, do you see any other code path in the driver where a
synchronisation might be missing ? Is there any case where the chip
might use data in memory before it has been told to do so  with a
mailbox write ? (There are no "OWN" bits that I can see in the
descriptors, thus I doubt it will use a transmit descriptor that is
half-built before the store to the mailbox allows using it) but who
knows....

That leads to the question that there might be an unrelated bug in the
driver. Segher thinks we might be overriding "live" descriptors, though
I haven't seen how yet. It seems to be TSO specific tho... maybe some
missing smp synchronisation in the driver itself or a problem when the
TX ring is full ?

I don't have the chip docs and I'm not familiar with the driver, so I'll
keep looking, but advice is welcome. I'll also see if I can reproduce
with some other TSO capable card, in case the problem is in the kernel
TSO code and not in the driver.

Cheers,
Ben.


