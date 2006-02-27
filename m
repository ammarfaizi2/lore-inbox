Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWB0Wki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWB0Wki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWB0WkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:40:22 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:1667 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932365AbWB0WkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:40:10 -0500
Message-Id: <20060227223328.573637000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:09 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Henrik Brix Andersen <brix@gentoo.org>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, dsd@gentoo.org,
       Juha-Matti Tapio <jmtapio@verkkotelakka.net>,
       "David S. Miller" <davem@davemloft.net>,
       Kristian Slavov <kristian.slavov@nomadiclab.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/39] [IPV6]: Address autoconfiguration does not work after device down/up cycle
Content-Disposition: inline; filename=address-autoconfiguration-does-not-work-after-device-down-up-cycle.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

If you set network interface down and up again, the IPv6 address
autoconfiguration does not work. 'ip addr' shows that the link-local
address is in tentative state. We don't even react to periodical router
advertisements.

During NETDEV_DOWN we clear IF_READY, and we don't set it back in
NETDEV_UP. While starting to perform DAD on the link-local address, we
notice that the device is not in IF_READY, and we abort autoconfiguration
process (which would eventually send router solicitations).

Acked-by: Juha-Matti Tapio <jmtapio@verkkotelakka.net>
Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 net/ipv6/addrconf.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.15.4.orig/net/ipv6/addrconf.c
+++ linux-2.6.15.4/net/ipv6/addrconf.c
@@ -2164,6 +2164,9 @@ static int addrconf_notify(struct notifi
 					dev->name);
 				break;
 			}
+
+			if (idev)
+				idev->if_flags |= IF_READY;
 		} else {
 			if (!netif_carrier_ok(dev)) {
 				/* device is still not ready. */

--
