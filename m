Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268427AbTGIQro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268428AbTGIQro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:47:44 -0400
Received: from dark.pcgames.pl ([195.205.62.2]:57521 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id S268427AbTGIQrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:47:24 -0400
Date: Wed, 9 Jul 2003 19:01:59 +0200 (CEST)
From: =?ISO-8859-2?Q?Krzysztof_Ol=EAdzki?= <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Hm.. [IPV4]: Be more verbose about invalid ICMPs sent to broadcast.
Message-ID: <Pine.LNX.4.33.0307091845530.8877-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have just changed kernel on one of my servers from 2.4.21-rc6 into
2.4.22-pre3. One host in my network has some problems with so IP stack
implementation so I get used to read a lot of error messages from kernel
about invalid ICMP error.

I noticed that old, well known message:
Jul  9 18:27:46 mac kernel: 192.168.0.108 sent an invalid ICMP error to a broadcast.

suddenly chaned into:
Jul  9 18:36:28 mac kernel: 192.168.0.230 sent an invalid ICMP type 3, code 0 error to a broadcast:192.168.3.255 on eth0

As you can see the sender is different. If you look at the patch you can
see that NIPQUAD(skb->nh.iph->saddr) was chaned into NIPQUAD(iph->saddr):

--- 1.16/net/ipv4/icmp.c        Mon Feb 24 03:17:59 2003
+++ 1.17/net/ipv4/icmp.c        Mon Jun 23 13:16:17 2003
@@ -595,8 +595,11 @@
                if (inet_addr_type(iph->daddr) == RTN_BROADCAST)
                {
                        if (net_ratelimit())
-                               printk(KERN_WARNING "%u.%u.%u.%u sent an invalid ICMP error to a broadcast.\n",
-                               NIPQUAD(skb->nh.iph->saddr)); <- THIS ONE
+                               printk(KERN_WARNING "%u.%u.%u.%u sent an invalid ICMP type %u, code %u error to a broadcast: %u.%u.%u.%u on %s\n",
+                                       NIPQUAD(iph->saddr),  <- THIS ONE
+                                       icmph->type, icmph->code,
+                                       NIPQUAD(iph->daddr),
+                                       skb->dev->name);
                        goto out;
                }
        }

There is a line:
  iph = (struct iphdr *) skb->data;"
so AFAIK this line:
  ((struct iphdr*) skb->data)->saddr
is not the same like this one:
   skb->nh.iph->saddr
or am I wrong? Any other reason why this message has now different sender
address?


Best Regards,


			Krzysztof Oledzki

