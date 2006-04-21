Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWDUErg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWDUErg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWDUEoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:10114 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932248AbWDUEoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:16 -0400
Date: Thu, 20 Apr 2006 21:39:07 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       netdev-core@vger.kernel.org, yoshfuji@linux-ipv6.org,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/22] IPV6: XFRM: Fix decoding session with preceding extension header(s).
Message-ID: <20060421043907.GM12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipv6-xfrm-fix-decoding-session-with-preceding-extension-header.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[IPV6] XFRM: Fix decoding session with preceding extension header(s).

We did not correctly decode session with preceding extension
header(s).  This was because we had already pulled preceding
headers, skb->nh.raw + 40 + 1 - skb->data was minus, and
pskb_may_pull() failed.

We now have IP6CB(skb)->nhoff and skb->h.raw, and we can
start parsing / decoding upper layer protocol from current
position.

Tracked down by Noriaki TAKAMIYA <takamiya@po.ntts.co.jp>
and tested by Kazunori Miyazawa <kazunori@miyazawa.org>.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv6/xfrm6_policy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16.9.orig/net/ipv6/xfrm6_policy.c
+++ linux-2.6.16.9/net/ipv6/xfrm6_policy.c
@@ -191,10 +191,10 @@ error:
 static inline void
 _decode_session6(struct sk_buff *skb, struct flowi *fl)
 {
-	u16 offset = sizeof(struct ipv6hdr);
+	u16 offset = skb->h.raw - skb->nh.raw;
 	struct ipv6hdr *hdr = skb->nh.ipv6h;
 	struct ipv6_opt_hdr *exthdr;
-	u8 nexthdr = skb->nh.ipv6h->nexthdr;
+	u8 nexthdr = skb->nh.raw[IP6CB(skb)->nhoff];
 
 	memset(fl, 0, sizeof(struct flowi));
 	ipv6_addr_copy(&fl->fl6_dst, &hdr->daddr);

--
