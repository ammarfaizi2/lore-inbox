Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbUCRRk1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbUCRRk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:40:27 -0500
Received: from aun.it.uu.se ([130.238.12.36]:35327 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262801AbUCRRkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:40:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16473.57066.436278.252046@alkaid.it.uu.se>
Date: Thu, 18 Mar 2004 18:39:54 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: tulip (pnic) errors in 2.6.5-rc1
In-Reply-To: <20040318090907.56a3d458.rddunlap@osdl.org>
References: <16473.28514.341276.209224@alkaid.it.uu.se>
	<40597123.8020903@pobox.com>
	<405971B3.3080700@pobox.com>
	<16473.32039.160055.63522@alkaid.it.uu.se>
	<40597E68.7090908@pobox.com>
	<16473.52851.367709.934661@alkaid.it.uu.se>
	<20040318090907.56a3d458.rddunlap@osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap writes:
 > On Thu, 18 Mar 2004 17:29:39 +0100 Mikael Pettersson wrote:
 > 
 > | Jeff Garzik writes:
 > |  > Mikael Pettersson wrote:
 > |  > > Jeff Garzik writes:
 > |  > >  > er, oops... lemme find the right patch...
 > |  > > 
 > |  > > No change, still a flood of those tulip_rx() interrupt messages.
 > |  > 
 > |  > hmmm.  Well, it is something unrelated to tulip driver, then.
 > | 
 > | Testing older -bk versions I've found that 2.6.4-bk2
 > | is Ok but 2.6.4-bk3 has this message flood problem.
 > 
 > Other than the netdev_priv() changes, I see removal of
 > KERNEL_SYSCALLS and the addition of CONFIG_NET_POLL_CONTROLLER.
 > Are you enabling CONFIG_NET_POLL_CONTROLLER?
 > If so, can you test with it disabled?

No it wasn't NET_POLL_CONTROLLER (I didn't enable it).

I split the bk2->bk3 patch in pieces, and traced the bug to the
netdev_priv() change in in loopback.c. The bug is that loopback's
dev is static and its ->priv actually points to kmalloc:d space.
The netdev_priv() transformation is invalid for anything not
allocated with alloc_etherdev or alloc_netdev, so the patch
to loopback caused it to access and clobber static memory just
after its own dev.

It was my bad luck that tulip was the victim of that clobber.

Reverting the patch below solves the problem.

/Mikael

diff -ruN linux-2.6.4-bk2/drivers/net/loopback.c linux-2.6.4-bk3/drivers/net/loopback.c
--- linux-2.6.4-bk2/drivers/net/loopback.c	2004-03-11 14:01:28.000000000 +0100
+++ linux-2.6.4-bk3/drivers/net/loopback.c	2004-03-18 16:12:28.000000000 +0100
@@ -123,7 +123,7 @@
  */
 static int loopback_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct net_device_stats *stats = (struct net_device_stats *)dev->priv;
+	struct net_device_stats *stats = netdev_priv(dev);
 
 	skb_orphan(skb);
 
