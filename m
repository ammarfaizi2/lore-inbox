Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWIBUJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWIBUJR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 16:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWIBUJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 16:09:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:47879 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751498AbWIBUJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 16:09:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ReIsRUyfe3JbS3c7/Yn9EyRoTQfRWn/wRxV1pGt1CAaCef48ssmyxWxWu0z0kz4Zubo5jckCcY5yRDlUgZTrEDupKKxkjqWo6UPNv0Qn2HrBKCudP4ROHlJAUpjBgVO05USFP1WcZAJGSH6fy8smOMVQfvisKXeMQLrX8YrEp2A=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix possible NULL ptr deref in forcedeth
Date: Sat, 2 Sep 2006 22:10:25 +0200
User-Agent: KMail/1.9.4
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609022210.26114.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a possible NULL pointer deref bug in 
drivers/net/forcedeth.c::nv_loopback_test().
If dev_alloc_skb() fails, the next line will call skb_put()
with a NULL first argument which it'll then try to deref - 
kaboom: a NULL pointer deref.
Found by coverity (#1337).


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/net/forcedeth.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.18-rc5-git6-orig/drivers/net/forcedeth.c	2006-09-02 21:34:14.000000000 +0200
+++ linux-2.6.18-rc5-git6/drivers/net/forcedeth.c	2006-09-02 22:02:13.000000000 +0200
@@ -3656,6 +3656,12 @@ static int nv_loopback_test(struct net_d
 	/* setup packet for tx */
 	pkt_len = ETH_DATA_LEN;
 	tx_skb = dev_alloc_skb(pkt_len);
+	if (!tx_skb) {
+		printk(KERN_ERR "dev_alloc_skb() failed during loopback test"
+			 " of %s\n", dev->name);
+		ret = 0;
+		goto out;
+	}
 	pkt_data = skb_put(tx_skb, pkt_len);
 	for (i = 0; i < pkt_len; i++)
 		pkt_data[i] = (u8)(i & 0xff);
@@ -3720,7 +3726,7 @@ static int nv_loopback_test(struct net_d
 		       tx_skb->end-tx_skb->data,
 		       PCI_DMA_TODEVICE);
 	dev_kfree_skb_any(tx_skb);
-
+ out:
 	/* stop engines */
 	nv_stop_rx(dev);
 	nv_stop_tx(dev);

-- 
VGER BF report: U 0.499932
