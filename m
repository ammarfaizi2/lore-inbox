Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWHCNzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWHCNzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWHCNzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:55:17 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:20491 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932401AbWHCNzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:55:15 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: arjan@infradead.org (Arjan van de Ven)
Subject: Re: orinoco driver causes *lots* of lockdep spew
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net, linville@tuxdriver.com, jt@hpl.hp.com
Organization: Core
In-Reply-To: <1154607380.2965.25.camel@laptopd505.fenrus.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G8der-0001fm-00@gondolin.me.apana.org.au>
Date: Thu, 03 Aug 2006 23:54:41 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
> 
> this is another one of those nasty buggers;

Good catch.  It's really time that we fix this properly rather than
adding more kludges to the core code.

Dave, once this goes in you can revert the previous netlink workaround
that added the _bh suffix.

[WIRELESS]: Send wireless netlink events with a clean slate

Drivers expect to be able to call wireless_send_event in arbitrary
contexts.  On the other hand, netlink really doesn't like being
invoked in an IRQ context.  So we need to postpone the sending of
netlink skb's to a tasklet.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au> 

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
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
