Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWCMTcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWCMTcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWCMTck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:32:40 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:24583 "EHLO
	sg2.chelsio.com") by vger.kernel.org with ESMTP id S932334AbWCMTci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:32:38 -0500
Message-ID: <4415C87B.90107@chelsio.com>
Date: Mon, 13 Mar 2006 11:31:07 -0800
From: Scott Bardone <sbardone@chelsio.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: maintainers@chelsio.com, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/net/chelsio/sge.c: two array overflows
References: <20060311013720.GG21864@stusta.de>
In-Reply-To: <20060311013720.GG21864@stusta.de>
Content-Type: multipart/mixed;
 boundary="------------030407090506050808000205"
X-OriginalArrivalTime: 13 Mar 2006 19:31:30.0811 (UTC) FILETIME=[BAD414B0:01C646D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030407090506050808000205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian,

This is a bug. The array should contain 2 elements.

Attached is a patch which fixes it.
Thanks.

Signed-off-by: Scott Bardone <sbardone@chelsio.com>


Adrian Bunk wrote:
> The Coverity checker spotted the following two array overflows in 
> drivers/net/chelsio/sge.c (in both cases, the arrays contain 3 elements):
> 
> <--  snip  -->
> 
> ...
> static void restart_tx_queues(struct sge *sge)
> {
> ...
>                                 sge->stats.cmdQ_restarted[3]++;
> ...
> static int t1_sge_tx(struct sk_buff *skb, struct adapter *adapter,
>                      unsigned int qid, struct net_device *dev)
> {
> ...
>                         sge->stats.cmdQ_full[3]++;
> ...
> 
> <--  snip  -->
> 
> 
> cu
> Adrian
> 

--------------030407090506050808000205
Content-Type: text/x-patch;
 name="sge.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sge.patch"

--- sge.c	2006-02-17 14:23:45.000000000 -0800
+++ sge.fix.c	2006-03-13 10:51:24.000000000 -0800
@@ -1021,7 +1021,7 @@
 			if (test_and_clear_bit(nd->if_port,
 					       &sge->stopped_tx_queues) &&
 			    netif_running(nd)) {
-				sge->stats.cmdQ_restarted[3]++;
+				sge->stats.cmdQ_restarted[2]++;
 				netif_wake_queue(nd);
 			}
 		}
@@ -1350,7 +1350,7 @@
 	 	if (unlikely(credits < count)) {
 			netif_stop_queue(dev);
 			set_bit(dev->if_port, &sge->stopped_tx_queues);
-			sge->stats.cmdQ_full[3]++;
+			sge->stats.cmdQ_full[2]++;
 			spin_unlock(&q->lock);
 			if (!netif_queue_stopped(dev))
 				CH_ERR("%s: Tx ring full while queue awake!\n",
@@ -1358,7 +1358,7 @@
 			return NETDEV_TX_BUSY;
 		}
 		if (unlikely(credits - count < q->stop_thres)) {
-			sge->stats.cmdQ_full[3]++;
+			sge->stats.cmdQ_full[2]++;
 			netif_stop_queue(dev);
 			set_bit(dev->if_port, &sge->stopped_tx_queues);
 		}

--------------030407090506050808000205--
