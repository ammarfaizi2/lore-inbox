Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbVLWWwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbVLWWwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbVLWWwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:52:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:59599 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161105AbVLWWt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:29 -0500
Date: Fri, 23 Dec 2005 14:48:06 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, shemminger@osdl.org
Subject: [patch 08/19] [VLAN]: Fix hardware rx csum errors
Message-ID: <20051223224806.GH19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-vlan-checksumming.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

Receiving VLAN packets over a device (without VLAN assist) that is
doing hardware checksumming (CHECKSUM_HW), causes errors because the
VLAN code forgets to adjust the hardware checksum.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/8021q/vlan_dev.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.14.4.orig/net/8021q/vlan_dev.c
+++ linux-2.6.14.4/net/8021q/vlan_dev.c
@@ -165,6 +165,9 @@ int vlan_skb_recv(struct sk_buff *skb, s
 
 	skb_pull(skb, VLAN_HLEN); /* take off the VLAN header (4 bytes currently) */
 
+	/* Need to correct hardware checksum */
+	skb_postpull_rcsum(skb, vhdr, VLAN_HLEN);
+
 	/* Ok, lets check to make sure the device (dev) we
 	 * came in on is what this VLAN is attached to.
 	 */

--
