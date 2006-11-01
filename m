Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946526AbWKAFmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946526AbWKAFmZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946532AbWKAFlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:41:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:21138 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946510AbWKAFlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:41:00 -0500
Message-Id: <20061101054054.108583000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:12 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Eli Cohen <eli@mellanox.co.il>,
       Michael S Tsirkin <mst@mellanox.co.il>,
       Roland Dreier <rolandd@cisco.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 32/61] IPoIB: Rejoin all multicast groups after a port event
Content-Disposition: inline; filename=ipoib-rejoin-all-multicast-groups-after-a-port-event.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Eli Cohen <eli@mellanox.co.il>

When ipoib_ib_dev_flush() is called because of a port event, the
driver needs to rejoin all multicast groups, since the flush will call
ipoib_mcast_dev_flush() (via ipoib_ib_dev_down()).  Otherwise no
(non-broadcast) multicast groups will be rejoined until the networking
core calls ->set_multicast_list again, and so multicast reception will
be broken for potentially a long time.

Signed-off-by: Eli Cohen <eli@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.18.1.orig/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ linux-2.6.18.1/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -619,8 +619,10 @@ void ipoib_ib_dev_flush(void *_dev)
 	 * The device could have been brought down between the start and when
 	 * we get here, don't bring it back up if it's not configured up
 	 */
-	if (test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
+	if (test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags)) {
 		ipoib_ib_dev_up(dev);
+		ipoib_mcast_restart_task(dev);
+	}
 
 	mutex_lock(&priv->vlan_mutex);
 

--
