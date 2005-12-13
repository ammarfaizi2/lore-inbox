Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVLMI0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVLMI0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVLMIZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:57219 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932554AbVLMIY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:57 -0500
Date: Tue, 13 Dec 2005 00:22:33 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       tgraf@suug.ch, davem@davemloft.net, netdev@vger.kernel.org
Subject: [patch 07/26] [NETLINK]: Fix processing of fib_lookup netlink messages
Message-ID: <20051213082233.GH5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-processing-of-fib_lookup-netlink-messages.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Thomas Graf <tgraf@suug.ch>

The receive path for fib_lookup netlink messages is lacking sanity
checks for header and payload and is thus vulnerable to malformed
netlink messages causing illegal memory references.

Signed-off-by: Thomas Graf <tgraf@suug.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/fib_frontend.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.14.3.orig/net/ipv4/fib_frontend.c
+++ linux-2.6.14.3/net/ipv4/fib_frontend.c
@@ -545,12 +545,16 @@ static void nl_fib_input(struct sock *sk
 	struct sk_buff *skb = NULL;
         struct nlmsghdr *nlh = NULL;
 	struct fib_result_nl *frn;
-	int err;
 	u32 pid;     
 	struct fib_table *tb;
 	
-	skb = skb_recv_datagram(sk, 0, 0, &err);
+	skb = skb_dequeue(&sk->sk_receive_queue);
 	nlh = (struct nlmsghdr *)skb->data;
+	if (skb->len < NLMSG_SPACE(0) || skb->len < nlh->nlmsg_len ||
+	    nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*frn))) {
+		kfree_skb(skb);
+		return;
+	}
 	
 	frn = (struct fib_result_nl *) NLMSG_DATA(nlh);
 	tb = fib_get_table(frn->tb_id_in);

--
