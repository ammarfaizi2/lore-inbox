Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161460AbWJKVKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161460AbWJKVKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161451AbWJKVKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:10:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:25251 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161448AbWJKVJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:11 -0400
Date: Wed, 11 Oct 2006 14:08:24 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 55/67] IPV6: Disable SG for GSO unless we have checksum
Message-ID: <20061011210824.GD16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipv6-disable-sg-for-gso-unless-we-have-checksum.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Miller <davem@davemloft.net>

Because the system won't turn off the SG flag for us we
need to do this manually on the IPv6 path.  Otherwise we
will throw IPv6 packets with bad checksums at the hardware.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv6/ipv6_sockglue.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.18.orig/net/ipv6/ipv6_sockglue.c
+++ linux-2.6.18/net/ipv6/ipv6_sockglue.c
@@ -123,6 +123,9 @@ static struct sk_buff *ipv6_gso_segment(
 	struct ipv6hdr *ipv6h;
 	struct inet6_protocol *ops;
 
+	if (!(features & NETIF_F_HW_CSUM))
+		features &= ~NETIF_F_SG;
+
 	if (unlikely(skb_shinfo(skb)->gso_type &
 		     ~(SKB_GSO_UDP |
 		       SKB_GSO_DODGY |

--
