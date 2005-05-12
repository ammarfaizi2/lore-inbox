Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVELHzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVELHzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 03:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVELHzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 03:55:19 -0400
Received: from ozlabs.org ([203.10.76.45]:46568 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261251AbVELHzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 03:55:09 -0400
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 3/4] iseries_veth: Don't leak skbs in RX path
Date: Thu, 12 May 2005 17:55:08 +1000
User-Agent: KMail/1.8
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505121755.09132.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Jeff,

Under some strange circumstances the iseries_veth driver can leak skbs.

Fix is simply to call dev_kfree_skb() in the right place.
Fix up the comment as well.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
--

 iseries_veth.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

Index: veth-fixes/drivers/net/iseries_veth.c
===================================================================
--- veth-fixes.orig/drivers/net/iseries_veth.c
+++ veth-fixes/drivers/net/iseries_veth.c
@@ -1264,13 +1264,18 @@ static void veth_receive(struct veth_lpa
 
 		vlan = skb->data[9];
 		dev = veth_dev[vlan];
-		if (! dev)
-			/* Some earlier versions of the driver sent
-			   broadcasts down all connections, even to
-			   lpars that weren't on the relevant vlan.
-			   So ignore packets belonging to a vlan we're
-			   not on. */
+		if (! dev) {
+			/*
+			 * Some earlier versions of the driver sent
+			 * broadcasts down all connections, even to lpars
+			 * that weren't on the relevant vlan. So ignore
+			 * packets belonging to a vlan we're not on.
+			 * We can also be here if we receive packets while
+			 * the driver is going down, because then dev is NULL.
+			 */
+			dev_kfree_skb_irq(skb);
 			continue;
+		}
 
 		port = (struct veth_port *)dev->priv;
 		dest = *((u64 *) skb->data) & 0xFFFFFFFFFFFF0000;
