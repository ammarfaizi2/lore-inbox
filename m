Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVLMWAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVLMWAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVLMWAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:00:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:19161 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030259AbVLMWAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:00:14 -0500
Date: Tue, 13 Dec 2005 13:59:54 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       ryanh@us.ibm.com, davem@davemloft.net, netdev@oss.sgi.com
Subject: [patch 2/2] [PATCH] br: fix race on bridge del if
Message-ID: <20051213215954.GC16739@kroah.com>
References: <20051213214109.971735000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="br-fix-race-on-bridge-del-if.patch"
In-Reply-To: <20051213215936.GA16739@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

This fixes the RCU race on bridge delete interface.  Basically,
the network device has to be detached from the bridge in the first
step (pre-RCU), rather than later. At that point, no more bridge traffic
will come in, and the other code will not think that network device
is part of a bridge.

This should also fix the XEN test problems. If there is another
2.6.13-stable, add it as well.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/bridge/br_if.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13.4.orig/net/bridge/br_if.c
+++ linux-2.6.13.4/net/bridge/br_if.c
@@ -79,7 +79,6 @@ static void destroy_nbp(struct net_bridg
 {
 	struct net_device *dev = p->dev;
 
-	dev->br_port = NULL;
 	p->br = NULL;
 	p->dev = NULL;
 	dev_put(dev);
@@ -100,6 +99,7 @@ static void del_nbp(struct net_bridge_po
 	struct net_bridge *br = p->br;
 	struct net_device *dev = p->dev;
 
+	dev->br_port = NULL;
 	dev_set_promiscuity(dev, -1);
 
 	spin_lock_bh(&br->lock);

--
