Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271752AbRH2AwS>; Tue, 28 Aug 2001 20:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271774AbRH2AwI>; Tue, 28 Aug 2001 20:52:08 -0400
Received: from 64-60-75-69-cust.telepacific.net ([64.60.75.69]:59404 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S271752AbRH2Av4>; Tue, 28 Aug 2001 20:51:56 -0400
Message-ID: <3B8C3C87.6090307@ixiacom.com>
Date: Tue, 28 Aug 2001 17:51:19 -0700
From: Bryan Rittmeyer <bryan@ixiacom.com>
Organization: Ixia
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: davem@redhat.com, ak@muc.de, kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: skb->dev set redundantly in net/ipv4/arp.c:arp_send()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think skb->dev is being set twice, for no purpose,
in net/ipv4/arp.c:489 and net/ipv4/arp.c:563. The
only external calls between these lines are memcpy
and dev->hard_header, and neither of those will ever
change skb->dev. So we can get rid of the redundant
"skb->dev = dev" line right before dev_queue_xmit()
unless I'm really stupid :-)

Anyway, here's my proposed patch against 2.4.9:

--- net/ipv4/arp-orig.c Tue Aug 28 17:36:45 2001
+++ net/ipv4/arp.c      Tue Aug 28 17:38:52 2001
@@ -560,7 +560,6 @@
                 memset(arp_ptr, 0, dev->addr_len);
         arp_ptr+=dev->addr_len;
         memcpy(arp_ptr, &dest_ip, 4);
-       skb->dev = dev;

         dev_queue_xmit(skb);
         return;

Comments?

-Bryan

-- 
Bryan Rittmeyer
mailto:bryan@ixiacom.com

