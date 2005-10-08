Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbVJHAuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbVJHAuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbVJHAuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:50:12 -0400
Received: from smarthost4.mail.uk.easynet.net ([212.135.6.14]:47375 "EHLO
	smarthost4.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S1161024AbVJHAuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:50:10 -0400
Message-ID: <434717B7.30505@uklinux.net>
Date: Sat, 08 Oct 2005 01:49:59 +0100
From: Jon Burgess <jburgess@uklinux.net>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kenneth.w.chen@intel.com
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-netdev@vger.kernel.org
Subject: Re: kernel performance update - 2.6.14-rc3
Content-Type: multipart/mixed;
 boundary="------------090901020903010106040408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090901020903010106040408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

"Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:

 > Even though
 > softirq is invoked at the end of dev_queue_xmit() via local_bh_enable(),
 > not all execution of softirq will result a __wake_up().  With higher
 > HZ rate, timer interrupt is more frequent and thus more softirq
 > invocation and leads to more __wake_up(), which then takes us to higher
 > throughput because cpu spend less time in idle.

Since the loopback xmit->rx path probably isn't being called in 
interrupt context might something like the patch below be needed?

Please forgive me if this is wrong, i've not even tried compiling this 
change let alone tested it.

	Jon



--------------090901020903010106040408
Content-Type: text/x-patch;
 name="loopback-netif_rx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="loopback-netif_rx.patch"

--- linux-2.6.13/drivers/net/loopback.c-orig	2005-10-08 01:32:50.000000000 +0100
+++ linux-2.6.13/drivers/net/loopback.c	2005-10-08 01:33:32.000000000 +0100
@@ -153,7 +153,7 @@ static int loopback_xmit(struct sk_buff 
 	lb_stats->tx_packets++;
 	put_cpu();
 
-	netif_rx(skb);
+	netif_rx_ni(skb);
 
 	return(0);
 }

--------------090901020903010106040408--
