Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVELHxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVELHxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 03:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVELHxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 03:53:23 -0400
Received: from ozlabs.org ([203.10.76.45]:42728 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261250AbVELHxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 03:53:19 -0400
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2/4] iseries_veth: Set dev->trans_start so watchdog timer works right
Date: Thu, 12 May 2005 17:53:18 +1000
User-Agent: KMail/1.8
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505121753.19267.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Jeff,

The iseries_veth driver doesn't set dev->trans_start in it's TX path. This
will cause the net device watchdog timer to fire earlier than we want it to,
which causes the driver to needlessly reset its connections to other LPARs.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
--

 iseries_veth.c |    2 ++
 1 files changed, 2 insertions(+)

Index: veth-fixes/drivers/net/iseries_veth.c
===================================================================
--- veth-fixes.orig/drivers/net/iseries_veth.c
+++ veth-fixes/drivers/net/iseries_veth.c
@@ -1023,6 +1023,8 @@ static int veth_start_xmit(struct sk_buf
 
 	lpmask = veth_transmit_to_many(skb, lpmask, dev);
 
+	dev->trans_start = jiffies;
+
 	if (! lpmask) {
 		dev_kfree_skb(skb);
 	} else {
