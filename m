Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVHVACj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVHVACj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 20:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVHVACj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 20:02:39 -0400
Received: from pop-sarus.atl.sa.earthlink.net ([207.69.195.72]:29430 "EHLO
	pop-sarus.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1750903AbVHVACi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 20:02:38 -0400
Date: Sun, 21 Aug 2005 16:56:08 -0700
From: Gopalakrishnan Raman <gopal@rgopal.com>
To: linux-kernel@vger.kernel.org
Cc: gopal@rgopal.com
Subject: tcpdump confused with NAT-T+IPSec Packets
Message-ID: <20050821165608.A9993@portal.rgopal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Gopal's Domain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I'm using 2.6.11.7 and debugging why my ESP tunnel mode does
not work between two 2.6 machines one of which is behind a NAT.
I'm using tcpdump to capture NAT-T packets on one of the hosts
and using espdecrypt (http://www.cs.rpi.edu/~flemej/freebsd/espdecrypt/)
to see it in the clear.

Turns out, tcpdump will display an incoming NAT-T packet after it
has been mangled by udp_encap_rcv(). udp_encap_rcv() changes the
protocol field in the IP hdr to ESP from UDP and also moves other
bytes in the sk_buff data area.

The problem is that packet_rcv() calls skb_clone() which is the
right thing to do in all cases except when the data portion of the
incoming skb is being modified in place. I replaced it with a pskb_copy()
in the case when the packet is likely to be NAT-T or ESP. The patch
for this follows the end of this mail and seems to work quite well.

Note that af_packet.c is the right place for the ESP/NAT-T check.
Can't do it in ESP or UDP code because we can't tell if these packets
are also being captured by tcpdump/ethereal.
Cheers
-gopal

============================================================================
--- af_packet.c 2005-04-07 11:57:50.000000000 -0700
+++ /usr/src/linux-2.6.11.7/net/packet/af_packet.c      2005-08-21 16:20:34.000000000 -0700
@@ -424,6 +424,28 @@
        return res;
 }

+static int is_likely_esp_pkt(struct sk_buff *skb)
+{
+       /* Don't bother if skb does not have entire IP hdr */
+       if (skb_headlen(skb) < sizeof(struct iphdr)) return 0 ;
+
+       /* Check for IPPROTO_ESP || (IPPROTO_UDP && (dport == 4500 || 500) */
+       if (skb->protocol == htons(ETH_P_IP)) {
+               struct iphdr *iph = (struct iphdr *)skb->nh.raw;
+               if (iph->protocol == IPPROTO_ESP) return 1 ;
+               if (iph->protocol == IPPROTO_UDP) {
+                       struct udphdr *udph ;
+                       if (skb_headlen(skb) < ((iph->ihl << 2)
+                               + sizeof(struct udphdr))) return 0 ;
+                       udph = (struct udphdr *)((u8 *)iph+(iph->ihl << 2)) ;
+                       if ((udph->dest == htons(500)) ||
+                           (udph->dest == htons(4500)))
+                               return 1 ;
+               }
+       }
+       return 0 ;
+}
+
 /*
    This function makes lazy skb cloning in hope that most of packets
    are discarded by BPF.
@@ -484,7 +506,11 @@
                goto drop_n_acct;

        if (skb_shared(skb)) {
-               struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+               struct sk_buff *nskb ;
+               if (is_likely_esp_pkt(skb))
+                       nskb = pskb_copy(skb, GFP_ATOMIC);
+               else
+                       nskb = skb_clone(skb, GFP_ATOMIC);
                if (nskb == NULL)
                        goto drop_n_acct;
============================================================================
