Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWGQQjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWGQQjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWGQQdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:33:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:12476 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750976AbWGQQdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:19 -0400
Date: Mon, 17 Jul 2006 09:28:21 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 30/45] : Fix IPv4/DECnet routing rule dumping
Message-ID: <20060717162821.GE4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-ipv4-decnet-routing-rule-dumping.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Patrick McHardy <kaber@trash.net>


When more rules are present than fit in a single skb, the remaining
rules are incorrectly skipped.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/decnet/dn_rules.c |    3 ++-
 net/ipv4/fib_rules.c  |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.17.6.orig/net/decnet/dn_rules.c
+++ linux-2.6.17.6/net/decnet/dn_rules.c
@@ -400,9 +400,10 @@ int dn_fib_dump_rules(struct sk_buff *sk
 	rcu_read_lock();
 	hlist_for_each_entry(r, node, &dn_fib_rules, r_hlist) {
 		if (idx < s_idx)
-			continue;
+			goto next;
 		if (dn_fib_fill_rule(skb, r, cb, NLM_F_MULTI) < 0)
 			break;
+next:
 		idx++;
 	}
 	rcu_read_unlock();
--- linux-2.6.17.6.orig/net/ipv4/fib_rules.c
+++ linux-2.6.17.6/net/ipv4/fib_rules.c
@@ -458,13 +458,13 @@ int inet_dump_rules(struct sk_buff *skb,
 
 	rcu_read_lock();
 	hlist_for_each_entry(r, node, &fib_rules, hlist) {
-
 		if (idx < s_idx)
-			continue;
+			goto next;
 		if (inet_fill_rule(skb, r, NETLINK_CB(cb->skb).pid,
 				   cb->nlh->nlmsg_seq,
 				   RTM_NEWRULE, NLM_F_MULTI) < 0)
 			break;
+next:
 		idx++;
 	}
 	rcu_read_unlock();

--
