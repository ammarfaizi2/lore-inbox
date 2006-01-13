Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161661AbWAMDXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161661AbWAMDXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161669AbWAMDXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:23:10 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51586 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161651AbWAMDTj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:39 -0500
Message-Id: <20060113032238.565599000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:39 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>,
       " Greg Kroah-Hartman " <gregkh@suse.de>
Subject: [PATCH 01/17] BRIDGE: Fix faulty check in br_stp_recalculate_bridge_id()
Content-Disposition: inline; filename=bridge-fix-faulty-check-in-br_stp_recalculate_bridge_id.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

There is a regression in 2.6.15.
One of the conversions from memcmp to compare_ether_addr is incorrect.
We need to do relative comparison to determine min MAC address to
use in bridge id. This will cause the wrong bridge id to be chosen
which violates 802.1d Spanning Tree Protocol, and may create forwarding
loops.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 net/bridge/br_stp_if.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15.y/net/bridge/br_stp_if.c
===================================================================
--- linux-2.6.15.y.orig/net/bridge/br_stp_if.c
+++ linux-2.6.15.y/net/bridge/br_stp_if.c
@@ -158,7 +158,7 @@ void br_stp_recalculate_bridge_id(struct
 
 	list_for_each_entry(p, &br->port_list, list) {
 		if (addr == br_mac_zero ||
-		    compare_ether_addr(p->dev->dev_addr, addr) < 0)
+		    memcmp(p->dev->dev_addr, addr, ETH_ALEN) < 0)
 			addr = p->dev->dev_addr;
 
 	}

--
