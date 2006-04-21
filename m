Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWDUEuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWDUEuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWDUEtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:49:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:50049 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932239AbWDUEoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:05 -0400
Date: Thu, 20 Apr 2006 21:38:42 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       netdev-core@vger.kernel.org, yoshfuji@linux-ipv6.org,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/22] IPV6: Ensure to have hop-by-hop options in our header of &sk_buff.
Message-ID: <20060421043842.GK12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipv6-ensure-to-have-hop-by-hop-options-in-our-header-of-sk_buff.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[IPV6]: Ensure to have hop-by-hop options in our header of &sk_buff.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

---
 net/ipv6/exthdrs.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- linux-2.6.16.9.orig/net/ipv6/exthdrs.c
+++ linux-2.6.16.9/net/ipv6/exthdrs.c
@@ -489,6 +489,18 @@ int ipv6_parse_hopopts(struct sk_buff *s
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
 
+	/*
+	 * skb->nh.raw is equal to skb->data, and
+	 * skb->h.raw - skb->nh.raw is always equal to
+	 * sizeof(struct ipv6hdr) by definition of
+	 * hop-by-hop options.
+	 */
+	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
+	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + ((skb->h.raw[1] + 1) << 3))) {
+		kfree_skb(skb);
+		return -1;
+	}
+
 	opt->hop = sizeof(struct ipv6hdr);
 	if (ip6_parse_tlv(tlvprochopopt_lst, skb)) {
 		skb->h.raw += (skb->h.raw[1]+1)<<3;

--
