Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932850AbVIHB3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbVIHB3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932851AbVIHB3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:29:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932850AbVIHB3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:29:34 -0400
Message-Id: <20050908012903.782898000@localhost.localdomain>
References: <20050908012842.299637000@localhost.localdomain>
Date: Wed, 07 Sep 2005 18:28:50 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 8/9] [IPV4]: Reassembly trim not clearing CHECKSUM_HW
Content-Disposition: inline; filename=ipv4-fragmentation-csum-handling.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

[IPV4]: Reassembly trim not clearing CHECKSUM_HW

This was found by inspection while looking for checksum problems
with the skge driver that sets CHECKSUM_HW. It did not fix the
problem, but it looks like it is needed.

If IP reassembly is trimming an overlapping fragment, it
should reset (or adjust) the hardware checksum flag on the skb.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 net/ipv4/ip_fragment.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13.y/net/ipv4/ip_fragment.c
===================================================================
--- linux-2.6.13.y.orig/net/ipv4/ip_fragment.c
+++ linux-2.6.13.y/net/ipv4/ip_fragment.c
@@ -457,7 +457,7 @@ static void ip_frag_queue(struct ipq *qp
 
 	if (pskb_pull(skb, ihl) == NULL)
 		goto err;
-	if (pskb_trim(skb, end-offset))
+	if (pskb_trim_rcsum(skb, end-offset))
 		goto err;
 
 	/* Find out which fragments are in front and at the back of us

--
