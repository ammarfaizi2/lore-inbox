Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVANSy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVANSy1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVANSy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:54:26 -0500
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:34248 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S261305AbVANSyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:54:22 -0500
Message-ID: <41E8155D.3020802@pantasys.com>
Date: Fri, 14 Jan 2005 10:54:21 -0800
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jyri.poldre@artecdesign.ee
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet driver link state propagation to ip stack
References: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
In-Reply-To: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-4; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Jan 2005 18:49:12.0078 (UTC) FILETIME=[BCE3EAE0:01C4FA69]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

Jüri Põldre wrote:
> I am experiencing issues with connecting two network adapters to the same
> subnet, eg.

I recently had similar problems (specifically with the e1000 driver). 
When one hang goes down a send to the other interface will hang. This 
was when we were using the same socket to send on both interfaces, what 
resulted is that the socket buffer would fill up and cause the send to 
block. If you aren't using the same socket to send out on both 
interfaces you should be fine. the rather large hack that i used to get 
this to work on my system is below. basically it will not enqueue a 
packet when the interface is down. this may well do nasty things to tcp...

peter

---
--- linux-2.6.8-24.3/net/core/dev.c
+++ linux-2.6.8-24.3/net/core/dev.c
@@ -1379,6 +1379,11 @@
  #ifdef CONFIG_NET_CLS_ACT
  	skb->tc_verd = SET_TC_AT(skb->tc_verd,AT_EGRESS);
  #endif
+	if (!netif_carrier_ok(dev)) {
+		rc = NET_XMIT_DROP;
+		goto out_kfree_skb;
+	}
+
  	if (q->enqueue) {
  		/* Grab device queue */
  		spin_lock(&dev->queue_lock);
