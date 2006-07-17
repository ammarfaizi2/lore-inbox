Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWGQQmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWGQQmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWGQQcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:2491 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750941AbWGQQcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:32 -0400
Date: Mon, 17 Jul 2006 09:26:56 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Thomas Graf <tgraf@suug.ch>,
       "David S. Miller" <davem@davemloft.net>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/45] PKT_SCHED: Fix illegal memory dereferences when dumping actions
Message-ID: <20060717162656.GO4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pkt_sched-fix-illegal-memory-dereferences-when-dumping-actions.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Thomas Graf <tgraf@suug.ch>

The TCA_ACT_KIND attribute is used without checking its
availability when dumping actions therefore leading to a
value of 0x4 being dereferenced.

The use of strcmp() in tc_lookup_action_n() isn't safe
when fed with string from an attribute without enforcing
proper NUL termination.

Both bugs can be triggered with malformed netlink message
and don't require any privileges.

Signed-off-by: Thomas Graf <tgraf@suug.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/sched/act_api.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- linux-2.6.17.3.orig/net/sched/act_api.c
+++ linux-2.6.17.3/net/sched/act_api.c
@@ -777,7 +777,7 @@ replay:
 	return ret;
 }
 
-static char *
+static struct rtattr *
 find_dump_kind(struct nlmsghdr *n)
 {
 	struct rtattr *tb1, *tb2[TCA_ACT_MAX+1];
@@ -805,7 +805,7 @@ find_dump_kind(struct nlmsghdr *n)
 		return NULL;
 	kind = tb2[TCA_ACT_KIND-1];
 
-	return (char *) RTA_DATA(kind);
+	return kind;
 }
 
 static int
@@ -818,16 +818,15 @@ tc_dump_action(struct sk_buff *skb, stru
 	struct tc_action a;
 	int ret = 0;
 	struct tcamsg *t = (struct tcamsg *) NLMSG_DATA(cb->nlh);
-	char *kind = find_dump_kind(cb->nlh);
+	struct rtattr *kind = find_dump_kind(cb->nlh);
 
 	if (kind == NULL) {
 		printk("tc_dump_action: action bad kind\n");
 		return 0;
 	}
 
-	a_o = tc_lookup_action_n(kind);
+	a_o = tc_lookup_action(kind);
 	if (a_o == NULL) {
-		printk("failed to find %s\n", kind);
 		return 0;
 	}
 
@@ -835,7 +834,7 @@ tc_dump_action(struct sk_buff *skb, stru
 	a.ops = a_o;
 
 	if (a_o->walk == NULL) {
-		printk("tc_dump_action: %s !capable of dumping table\n", kind);
+		printk("tc_dump_action: %s !capable of dumping table\n", a_o->kind);
 		goto rtattr_failure;
 	}
 

--
