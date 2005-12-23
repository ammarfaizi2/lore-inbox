Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161118AbVLWWtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbVLWWtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbVLWWtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:49:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:15568 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161110AbVLWWti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:38 -0500
Date: Fri, 23 Dec 2005 14:47:50 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>, Pablo Neira <pablo@eurodev.net>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Krzysztof Oledzki <olenf@ans.pl>, kaber@trash.net, davem@davemloft.net
Subject: [patch 04/19] [NETFILTER]: Fix unbalanced read_unlock_bh in ctnetlink
Message-ID: <20051223224750.GD19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-unbalanced-read_unlock_bh-in-ctnetlink.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Patrick McHardy <kaber@trash.net>

NFA_NEST calls NFA_PUT which jumps to nfattr_failure if the skb has no
room left. We call read_unlock_bh at nfattr_failure for the NFA_PUT
inside the locked section, so move NFA_NEST inside the locked section
too.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.14.4.orig/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
+++ linux-2.6.14.4/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
@@ -341,9 +341,10 @@ static int tcp_print_conntrack(struct se
 static int tcp_to_nfattr(struct sk_buff *skb, struct nfattr *nfa,
 			 const struct ip_conntrack *ct)
 {
-	struct nfattr *nest_parms = NFA_NEST(skb, CTA_PROTOINFO_TCP);
+	struct nfattr *nest_parms;
 	
 	read_lock_bh(&tcp_lock);
+	nest_parms = NFA_NEST(skb, CTA_PROTOINFO_TCP);
 	NFA_PUT(skb, CTA_PROTOINFO_TCP_STATE, sizeof(u_int8_t),
 		&ct->proto.tcp.state);
 	read_unlock_bh(&tcp_lock);

--
