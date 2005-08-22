Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVHVXOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVHVXOn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHVXOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:14:43 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:38033 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932366AbVHVXOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:14:41 -0400
Message-ID: <43091CCC.80906@trash.net>
Date: Mon, 22 Aug 2005 02:31:08 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gopalakrishnan Raman <gopal@rgopal.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: tcpdump confused with NAT-T+IPSec Packets
References: <20050821165608.A9993@portal.rgopal.com>
In-Reply-To: <20050821165608.A9993@portal.rgopal.com>
Content-Type: multipart/mixed;
 boundary="------------040203020802080907040407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040203020802080907040407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gopalakrishnan Raman wrote:
> Hi
> I'm using 2.6.11.7 and debugging why my ESP tunnel mode does
> not work between two 2.6 machines one of which is behind a NAT.
> I'm using tcpdump to capture NAT-T packets on one of the hosts
> and using espdecrypt (http://www.cs.rpi.edu/~flemej/freebsd/espdecrypt/)
> to see it in the clear.
> 
> Turns out, tcpdump will display an incoming NAT-T packet after it
> has been mangled by udp_encap_rcv(). udp_encap_rcv() changes the
> protocol field in the IP hdr to ESP from UDP and also moves other
> bytes in the sk_buff data area.
> 
> The problem is that packet_rcv() calls skb_clone() which is the
> right thing to do in all cases except when the data portion of the
> incoming skb is being modified in place. I replaced it with a pskb_copy()
> in the case when the packet is likely to be NAT-T or ESP. The patch
> for this follows the end of this mail and seems to work quite well.
> 
> Note that af_packet.c is the right place for the ESP/NAT-T check.
> Can't do it in ESP or UDP code because we can't tell if these packets
> are also being captured by tcpdump/ethereal.

Herbert already fixed it with this patch.

--------------040203020802080907040407
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[IPSEC]: COW skb header in UDP decap

The following patch just makes the header part of the skb writeable.
This is needed since we modify the IP headers just a few lines below.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>

---
commit 4d78b6c78ae6d87e4c1c8072f42efa716f04afb9
tree e04f156e8d74c28b925bf53e62d3e4b424a6ffb7
parent c7f905f0f6d49ed8c1aa4566c31f0383a0ba0c9d
author Herbert Xu <herbert@gondor.apana.org.au> Tue, 19 Apr 2005 22:48:59 -0700
committer David S. Miller <davem@davemloft.net> Tue, 19 Apr 2005 22:48:59 -0700

 net/ipv4/udp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -955,6 +955,8 @@ static int udp_encap_rcv(struct sock * s
 	 * header and optional ESP marker bytes) and then modify the
 	 * protocol to ESP, and then call into the transform receiver.
 	 */
+	if (skb_cloned(skb) && pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+		return 0;
 
 	/* Now we can update and verify the packet length... */
 	iph = skb->nh.iph;

--------------040203020802080907040407--
