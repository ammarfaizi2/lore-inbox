Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWHDFvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWHDFvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWHDFvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:51:37 -0400
Received: from mx1.suse.de ([195.135.220.2]:3301 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030331AbWHDFoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:44:06 -0400
Date: Thu, 3 Aug 2006 22:39:28 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stefan Rompf <stefan@loplof.de>, Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/23] VLAN state handling fix
Message-ID: <20060804053928.GK769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="vlan-state-handling-fix.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stefan Rompf <stefan@loplof.de>

[VLAN]: Fix link state propagation

When the queue of the underlying device is stopped at initialization time
or the device is marked "not present", the state will be propagated to the
vlan device and never change. Based on an analysis by Patrick McHardy.

Signed-off-by: Stefan Rompf <stefan@loplof.de>
ACKed-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/8021q/vlan.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- linux-2.6.17.7.orig/net/8021q/vlan.c
+++ linux-2.6.17.7/net/8021q/vlan.c
@@ -67,10 +67,6 @@ static struct packet_type vlan_packet_ty
 	.func = vlan_skb_recv, /* VLAN receive method */
 };
 
-/* Bits of netdev state that are propagated from real device to virtual */
-#define VLAN_LINK_STATE_MASK \
-	((1<<__LINK_STATE_PRESENT)|(1<<__LINK_STATE_NOCARRIER)|(1<<__LINK_STATE_DORMANT))
-
 /* End of global variables definitions. */
 
 /*
@@ -470,7 +466,9 @@ static struct net_device *register_vlan_
 	new_dev->flags = real_dev->flags;
 	new_dev->flags &= ~IFF_UP;
 
-	new_dev->state = real_dev->state & ~(1<<__LINK_STATE_START);
+	new_dev->state = (real_dev->state & ((1<<__LINK_STATE_NOCARRIER) |
+					     (1<<__LINK_STATE_DORMANT))) |
+			 (1<<__LINK_STATE_PRESENT);
 
 	/* need 4 bytes for extra VLAN header info,
 	 * hope the underlying device can handle it.

--
