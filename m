Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWGQQpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWGQQpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWGQQpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:45:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:49082 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750937AbWGQQcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:18 -0400
Date: Mon, 17 Jul 2006 09:27:06 -0700
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
Subject: [patch 16/45] PKT_SCHED: Fix error handling while dumping actions
Message-ID: <20060717162706.GQ4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pkt_sched-fix-error-handling-while-dumping-actions.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Thomas Graf <tgraf@suug.ch>

"return -err" and blindly inheriting the error code in the netlink
failure exception handler causes errors codes to be returned as
positive value therefore making them being ignored by the caller.

May lead to sending out incomplete netlink messages.

Signed-off-by: Thomas Graf <tgraf@suug.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/sched/act_api.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.17.3.orig/net/sched/act_api.c
+++ linux-2.6.17.3/net/sched/act_api.c
@@ -251,15 +251,17 @@ tcf_action_dump(struct sk_buff *skb, str
 		RTA_PUT(skb, a->order, 0, NULL);
 		err = tcf_action_dump_1(skb, a, bind, ref);
 		if (err < 0)
-			goto rtattr_failure;
+			goto errout;
 		r->rta_len = skb->tail - (u8*)r;
 	}
 
 	return 0;
 
 rtattr_failure:
+	err = -EINVAL;
+errout:
 	skb_trim(skb, b - skb->data);
-	return -err;
+	return err;
 }
 
 struct tc_action *tcf_action_init_1(struct rtattr *rta, struct rtattr *est,

--
