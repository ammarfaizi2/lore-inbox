Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUETNsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUETNsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 09:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265156AbUETNsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 09:48:43 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:42333 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S265135AbUETNsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 09:48:40 -0400
Message-ID: <40AC0EB4.1020501@ThinRope.net>
Date: Thu, 20 May 2004 10:49:40 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Tons of "ICMPv6 checksum failed" in the logs
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I hope this is the right ML to post, if not please enlighten me where to ask :-)

With 2.6.5 I started experiemnting with IPv6 and now most everything is working OK.

However I found tons of the following in kernel logs:

May 14 05:39:40 [kernel] ICMPv6 checksum failed [2001:0200:0000:1800:0000:0000:09c4:0002 > 2001:02f8:0040:0002:020e:0cff:fe07:898b]
May 14 05:39:47 [kernel] ICMPv6 checksum failed [2001:0200:0000:1800:0000:0000:2497:0000 > 2001:02f8:0040:0002:020e:0cff:fe07:898b]
May 14 09:34:27 [kernel] ICMPv6 checksum failed [fe80:0000:0000:0000:0240:66ff:fe10:c062 > ff02:0000:0000:0000:0000:0000:0000:0001]
                - Last output repeated 5 times -
May 14 16:55:42 [kernel] ICMPv6 checksum failed [2001:0240:0517:0001:0000:0000:0000:0002 > 2001:02f8:0040:0002:020e:0cff:fe07:898b]
May 14 16:55:42 [kernel] ICMPv6 checksum failed [2001:02f8:0001:0000:0000:0000:0000:0009 > 2001:02f8:0040:0002:020e:0cff:fe07:898b]

Searching on google, for "ICMPv6 checksum failed" got me some mostly irrelevant results :-(

I also found some patches for 2.6.6 of the kind:

diff -Nru a/net/ipv6/icmp.c b/net/ipv6/icmp.c
--- a/net/ipv6/icmp.c   Tue Apr 27 18:37:22 2004
+++ b/net/ipv6/icmp.c   Tue Apr 27 18:37:22 2004
@@ -570,17 +570,17 @@
       skb->ip_summed = CHECKSUM_UNNECESSARY;
       if (csum_ipv6_magic(saddr, daddr, skb->len, IPPROTO_ICMPV6,
                 skb->csum)) {
-         if (net_ratelimit())
-            printk(KERN_DEBUG "ICMPv6 hw checksum failed\n");
+         LIMIT_NETDEBUG(
+            printk(KERN_DEBUG "ICMPv6 hw checksum failed\n"));
          skb->ip_summed = CHECKSUM_NONE;
       }
    }
    if (skb->ip_summed == CHECKSUM_NONE) {
       if (csum_ipv6_magic(saddr, daddr, skb->len, IPPROTO_ICMPV6,
                 skb_checksum(skb, 0, skb->len, 0))) {
-         if (net_ratelimit())
+         LIMIT_NETDEBUG(
             printk(KERN_DEBUG "ICMPv6 checksum failed [%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x > %04x:%04x:%04x:%04x:%04x:%04x:%+
04x:%04x]\n",
-                   NIP6(*saddr), NIP6(*daddr));
+                   NIP6(*saddr), NIP6(*daddr)));
          goto discard_it;
       }
    }

[ Full patch at http://www.linuxhq.com/kernel/v2.6/6-rc3/net/ipv6/icmp.c ]

And looking on my 2.6.6 machine, there are just a few of these errors in the log.

Does this mean that they don't happen or they are just not logged (because of LIMIT_NETDEBUG )?

Anyway, are these errors of any concern at all? I have really no idea what they mean, just the word error seems bad to me :-|

I will provide any information (.config, lspci, etc.) if needed.

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
