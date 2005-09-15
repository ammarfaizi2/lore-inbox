Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbVIOBH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbVIOBH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbVIOBH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:07:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030308AbVIOBE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:04:57 -0400
Message-Id: <20050915010402.416490000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       manfred@colorfullife.com, Jeff Garzik <jgarzik@pobox.com>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 03/11] [PATCH] forcedeth: Initialize link settings in every nv_open()
Content-Disposition: inline; filename=forcedeth-init-link-settings-in-nv_open.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

R�diger found a bug in nv_open that explains some of the reports
with duplex mismatches:
nv_open calls nv_update_link_speed for initializing the hardware link speed
registers. If current link setting matches the values in np->linkspeed and
np->duplex, then the function does nothing.
Usually, doing nothing is the right thing, but not in nv_open: During
nv_open, the registers must be initialized because the nic was reset.

The attached patch fixes that by setting np->linkspeed to an invalid value
before calling nv_update_link_speed from nv_open.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/net/forcedeth.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.13.y/drivers/net/forcedeth.c
===================================================================
--- linux-2.6.13.y.orig/drivers/net/forcedeth.c
+++ linux-2.6.13.y/drivers/net/forcedeth.c
@@ -1888,6 +1888,9 @@ static int nv_open(struct net_device *de
 		writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
 		dprintk(KERN_INFO "startup: got 0x%08x.\n", miistat);
 	}
+	/* set linkspeed to invalid value, thus force nv_update_linkspeed
+	 * to init hw */
+	np->linkspeed = 0; 
 	ret = nv_update_linkspeed(dev);
 	nv_start_rx(dev);
 	nv_start_tx(dev);

--
