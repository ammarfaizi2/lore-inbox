Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVHCHHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVHCHHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVHCHHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 03:07:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34271 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262119AbVHCHGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:06:54 -0400
Date: Wed, 3 Aug 2005 00:06:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, tommy.christensen@tpack.net,
       dsd@gentoo.org, davem@davemloft.net
Subject: [12/13] [VLAN]: Fix early vlan adding leads to not functional device
Message-ID: <20050803070600.GA7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

[VLAN]: Fix early vlan adding leads to not functional device

OK, I can see what's happening here. eth0 doesn't detect link-up until
after a few seconds, so when the vlan interface is opened immediately
after eth0 has been opened, it inherits the link-down state. Subsequently
the vlan interface is never properly activated and are thus unable to
transmit any packets.

dev->state bits are not supposed to be manipulated directly. Something
similar is probably needed for the netif_device_present() bit, although
I don't know how this is meant to work for a virtual device.
  
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -578,6 +578,14 @@ static int vlan_device_event(struct noti
 			if (!vlandev)
 				continue;
 
+			if (netif_carrier_ok(dev)) {
+				if (!netif_carrier_ok(vlandev))
+					netif_carrier_on(vlandev);
+			} else {
+				if (netif_carrier_ok(vlandev))
+					netif_carrier_off(vlandev);
+			}
+
 			if ((vlandev->state & VLAN_LINK_STATE_MASK) != flgs) {
 				vlandev->state = (vlandev->state &~ VLAN_LINK_STATE_MASK) 
 					| flgs;

