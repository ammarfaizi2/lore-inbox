Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030537AbWHIGZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030537AbWHIGZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbWHIGZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:25:41 -0400
Received: from havoc.gtf.org ([69.61.125.42]:22681 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030533AbWHIGZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:25:40 -0400
Date: Wed, 9 Aug 2006 02:25:39 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20060809062539.GA27541@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-greg' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-greg

to receive the following updates:

 drivers/net/myri10ge/myri10ge.c |    2 +-
 net/core/wireless.c             |   24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

Brice Goglin:
      myri10ge: always re-enable dummy rdmas in myri10ge_resume

Herbert Xu:
      Send wireless netlink events with a clean slate

diff --git a/drivers/net/myri10ge/myri10ge.c b/drivers/net/myri10ge/myri10ge.c
index 06440a8..9bdd43a 100644
--- a/drivers/net/myri10ge/myri10ge.c
+++ b/drivers/net/myri10ge/myri10ge.c
@@ -2425,7 +2425,7 @@ static int myri10ge_resume(struct pci_de
 	}
 
 	myri10ge_reset(mgp);
-	myri10ge_dummy_rdma(mgp, mgp->tx.boundary != 4096);
+	myri10ge_dummy_rdma(mgp, 1);
 
 	/* Save configuration space to be restored if the
 	 * nic resets due to a parity error */
diff --git a/net/core/wireless.c b/net/core/wireless.c
index d2bc72d..de0bde4 100644
--- a/net/core/wireless.c
+++ b/net/core/wireless.c
@@ -82,6 +82,7 @@ #include <linux/seq_file.h>
 #include <linux/init.h>			/* for __init */
 #include <linux/if_arp.h>		/* ARPHRD_ETHER */
 #include <linux/etherdevice.h>		/* compare_ether_addr */
+#include <linux/interrupt.h>
 
 #include <linux/wireless.h>		/* Pretty obvious */
 #include <net/iw_handler.h>		/* New driver API */
@@ -1842,6 +1843,18 @@ #endif	/* CONFIG_NET_WIRELESS_RTNETLINK 
  */
 
 #ifdef WE_EVENT_RTNETLINK
+static struct sk_buff_head wireless_nlevent_queue;
+
+static void wireless_nlevent_process(unsigned long data)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&wireless_nlevent_queue)))
+		netlink_broadcast(rtnl, skb, 0, RTNLGRP_LINK, GFP_ATOMIC);
+}
+
+static DECLARE_TASKLET(wireless_nlevent_tasklet, wireless_nlevent_process, 0);
+
 /* ---------------------------------------------------------------- */
 /*
  * Fill a rtnetlink message with our event data.
@@ -1904,8 +1917,17 @@ static inline void rtmsg_iwinfo(struct n
 		return;
 	}
 	NETLINK_CB(skb).dst_group = RTNLGRP_LINK;
-	netlink_broadcast(rtnl, skb, 0, RTNLGRP_LINK, GFP_ATOMIC);
+	skb_queue_tail(&wireless_nlevent_queue, skb);
+	tasklet_schedule(&wireless_nlevent_tasklet);
+}
+
+static int __init wireless_nlevent_init(void)
+{
+	skb_queue_head_init(&wireless_nlevent_queue);
+	return 0;
 }
+
+subsys_initcall(wireless_nlevent_init);
 #endif	/* WE_EVENT_RTNETLINK */
 
 /* ---------------------------------------------------------------- */
