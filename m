Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVCZK7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVCZK7i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 05:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVCZK7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 05:59:38 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:7944 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262031AbVCZK7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 05:59:35 -0500
Date: Sat, 26 Mar 2005 11:59:22 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Linux 2.4.30-rc2
Message-ID: <20050326105922.GM30052@alpha.home.local>
References: <20050326004631.GC17637@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326004631.GC17637@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, David,

could we merge this patch from Mitch Williams in 2.4.30 ? It fixes a
stack dump when unloading the bonding module in 802.3ad mode if spinlock
debugging is turned on.

Thanks in advance,
Willy


diff -urN linux-2.4.29/drivers/net/bonding/bond_main.c linux-2.4.29-bond-2.6.1/drivers/net/bonding/bond_main.c
--- linux-2.4.29/drivers/net/bonding/bond_main.c	Sun Dec 12 12:06:28 2004
+++ linux-2.4.29-bond-2.6.1/drivers/net/bonding/bond_main.c	Sun Feb  6 20:32:49 2005
@@ -469,6 +469,13 @@
  *	  * Add support for VLAN hardware acceleration capable slaves.
  *	  * Add capability to tag self generated packets in ALB/TLB modes.
  *	  Set version to 2.6.0.
+ * 2004/10/29 - Mitch Williams <mitch.a.williams at intel dot com>
+ *	- Fixed bug when unloading module while using 802.3ad.  If
+ *	  spinlock debugging is turned on, this causes a stack dump.
+ *	  Solution is to move call to dev_remove_pack outside of the
+ *	  spinlock.
+ *	  Set version to 2.6.1.
+ *
  */
 
 //#define BONDING_DEBUG 1
@@ -3565,14 +3572,14 @@
 {
 	struct bonding *bond = bond_dev->priv;
 
-	write_lock_bh(&bond->lock);
-
-	bond_mc_list_destroy(bond);
-
 	if (bond->params.mode == BOND_MODE_8023AD) {
 		/* Unregister the receive of LACPDUs */
 		bond_unregister_lacpdu(bond);
 	}
+
+	write_lock_bh(&bond->lock);
+
+	bond_mc_list_destroy(bond);
 
 	/* signal timers not to re-arm */
 	bond->kill_timers = 1;


