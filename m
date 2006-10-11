Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161455AbWJKVLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161455AbWJKVLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161440AbWJKVKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:10:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:59043 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161452AbWJKVJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:33 -0400
Date: Wed, 11 Oct 2006 14:09:14 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 66/67] NETFILTER: NAT: fix NOTRACK checksum handling
Message-ID: <20061011210914.GO16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="netfilter-nat-fix-notrack-checksum-handling.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Patrick McHardy <kaber@trash.net>

The whole idea with the NOTRACK netfilter target is that
you can force the netfilter code to avoid connection
tracking, and all costs assosciated with it, by making
traffic match a NOTRACK rule.

But this is totally broken by the fact that we do a checksum
calculation over the packet before we do the NOTRACK bypass
check, which is very expensive.  People setup NOTRACK rules
explicitly to avoid all of these kinds of costs.

This patch from Patrick, already in Linus's tree, fixes the
bug.

Move the check for ip_conntrack_untracked before the call to
skb_checksum_help to fix NOTRACK excemptions from NAT. Pre-2.6.19
NAT code breaks TSO by invalidating hardware checksums for every
packet, even if explicitly excluded from NAT through NOTRACK.

2.6.19 includes a fix that makes NAT and TSO live in harmony,
but the performance degradation caused by this deserves making
at least the workaround work properly in -stable.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/netfilter/ip_nat_standalone.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- linux-2.6.18.orig/net/ipv4/netfilter/ip_nat_standalone.c
+++ linux-2.6.18/net/ipv4/netfilter/ip_nat_standalone.c
@@ -110,12 +110,17 @@ ip_nat_fn(unsigned int hooknum,
 	IP_NF_ASSERT(!((*pskb)->nh.iph->frag_off
 		       & htons(IP_MF|IP_OFFSET)));
 
+	ct = ip_conntrack_get(*pskb, &ctinfo);
+
+	/* Don't try to NAT if this packet is not conntracked */
+	if (ct == &ip_conntrack_untracked)
+		return NF_ACCEPT;
+
 	/* If we had a hardware checksum before, it's now invalid */
 	if ((*pskb)->ip_summed == CHECKSUM_HW)
 		if (skb_checksum_help(*pskb, (out == NULL)))
 			return NF_DROP;
 
-	ct = ip_conntrack_get(*pskb, &ctinfo);
 	/* Can't track?  It's not due to stress, or conntrack would
 	   have dropped it.  Hence it's the user's responsibilty to
 	   packet filter it out, or implement conntrack/NAT for that
@@ -137,10 +142,6 @@ ip_nat_fn(unsigned int hooknum,
 		return NF_ACCEPT;
 	}
 
-	/* Don't try to NAT if this packet is not conntracked */
-	if (ct == &ip_conntrack_untracked)
-		return NF_ACCEPT;
-
 	switch (ctinfo) {
 	case IP_CT_RELATED:
 	case IP_CT_RELATED+IP_CT_IS_REPLY:

--
