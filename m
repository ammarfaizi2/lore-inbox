Return-Path: <linux-kernel-owner+w=401wt.eu-S1751151AbXAFChm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbXAFChm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbXAFChf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:37:35 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53940 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbXAFChT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:37:19 -0500
Message-Id: <20070106023638.586094000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:38 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, David L Stevens <dlstevens@us.ibm.com>
Subject: [patch 45/50] IPV4/IPV6: Fix inet{,6} device initialization order.
Content-Disposition: inline; filename=ipv4-ipv6-fix-inet-6-device-initialization-order.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David L Stevens <dlstevens@us.ibm.com>

It is important that we only assign dev->ip{,6}_ptr
only after all portions of the inet{,6} are setup.

Otherwise we can receive packets before the multicast
spinlocks et al. are initialized.

Signed-off-by: David L Stevens <dlstevens@us.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit 30c4cf577fb5b68c16e5750d6bdbd7072e42b279

 net/ipv4/devinet.c  |    5 +++--
 net/ipv6/addrconf.c |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.19.1.orig/net/ipv4/devinet.c
+++ linux-2.6.19.1/net/ipv4/devinet.c
@@ -165,9 +165,8 @@ struct in_device *inetdev_init(struct ne
 			      NET_IPV4_NEIGH, "ipv4", NULL, NULL);
 #endif
 
-	/* Account for reference dev->ip_ptr */
+	/* Account for reference dev->ip_ptr (below) */
 	in_dev_hold(in_dev);
-	rcu_assign_pointer(dev->ip_ptr, in_dev);
 
 #ifdef CONFIG_SYSCTL
 	devinet_sysctl_register(in_dev, &in_dev->cnf);
@@ -176,6 +175,8 @@ struct in_device *inetdev_init(struct ne
 	if (dev->flags & IFF_UP)
 		ip_mc_up(in_dev);
 out:
+	/* we can receive as soon as ip_ptr is set -- do this last */
+	rcu_assign_pointer(dev->ip_ptr, in_dev);
 	return in_dev;
 out_kfree:
 	kfree(in_dev);
--- linux-2.6.19.1.orig/net/ipv6/addrconf.c
+++ linux-2.6.19.1/net/ipv6/addrconf.c
@@ -413,8 +413,6 @@ static struct inet6_dev * ipv6_add_dev(s
 	if (netif_carrier_ok(dev))
 		ndev->if_flags |= IF_READY;
 
-	/* protected by rtnl_lock */
-	rcu_assign_pointer(dev->ip6_ptr, ndev);
 
 	ipv6_mc_init_dev(ndev);
 	ndev->tstamp = jiffies;
@@ -425,6 +423,8 @@ static struct inet6_dev * ipv6_add_dev(s
 			      NULL);
 	addrconf_sysctl_register(ndev, &ndev->cnf);
 #endif
+	/* protected by rtnl_lock */
+	rcu_assign_pointer(dev->ip6_ptr, ndev);
 	return ndev;
 }
 

--
