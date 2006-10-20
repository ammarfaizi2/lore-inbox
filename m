Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWJTSdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWJTSdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWJTSdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:33:12 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:57810 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S2992516AbWJTSdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:33:11 -0400
Message-Id: <20061020182820.978932000@mvista.com>
User-Agent: quilt/0.45-1
Date: Fri, 20 Oct 2006 11:28:20 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Auke Kok <auke-jan.h.kok@intel.com>
Cc: linux-kernel@vger.kernel.org
From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH] e100_shutdown: netif_poll_disable hang
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine annoyingly hangs while rebooting. I tracked it down
to e100-fix-reboot-f-with-netconsole-enabled.patch in 2.6.18-rc2-mm2

I review the changes and it seemed to be calling netif_poll_disable
one too many time. Once in e100_down(), and again in e100_shutdown().

The second one in e100_shutdown() caused the hang. So this patch
removes it. 

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 drivers/net/e100.c |    1 -
 1 files changed, 1 deletion(-)

Index: linux-2.6.18/drivers/net/e100.c
===================================================================
--- linux-2.6.18.orig/drivers/net/e100.c
+++ linux-2.6.18/drivers/net/e100.c
@@ -2709,7 +2709,6 @@ static void e100_shutdown(struct pci_dev
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
 
-	netif_poll_disable(nic->netdev);
 	del_timer_sync(&nic->watchdog);
 	netif_carrier_off(nic->netdev);
 
--

