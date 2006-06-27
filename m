Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWF0E7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWF0E7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933400AbWF0EkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:40:13 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:29659 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S932737AbWF0Ej4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:56 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/13] [Suspend2] Netlink receive message routines.
Date: Tue, 27 Jun 2006 14:39:54 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043952.14630.72309.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend2's routines for receiving netlink messages. We don't accept
that many messages, so the logic is pretty simple.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index 9094c92..c5b4bea 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -171,3 +171,89 @@ static int nl_ready(struct user_helper_d
 	return 0;
 }
 
+static int suspend_nl_gen_rcv_msg(struct user_helper_data *uhd,
+		struct sk_buff *skb, struct nlmsghdr *nlh)
+{
+	int type;
+	int *data;
+	int err;
+
+	/* Let the more specific handler go first. It returns
+	 * 1 for valid messages that it doesn't know. */
+	if ((err = uhd->rcv_msg(skb, nlh)) != 1)
+		return err;
+	
+	type = nlh->nlmsg_type;
+
+	/* Only allow one task to receive NOFREEZE privileges */
+	if (type == NETLINK_MSG_NOFREEZE_ME && uhd->pid != -1) {
+		printk("Received extra nofreeze me requests.\n");
+		return -EBUSY;
+	}
+
+	data = (int*)NLMSG_DATA(nlh);
+
+	switch (type) {
+		case NETLINK_MSG_NOFREEZE_ME:
+			if ((err = nl_set_nofreeze(uhd, nlh->nlmsg_pid)) != 0)
+				return err;
+			break;
+		case NETLINK_MSG_GET_DEBUGGING:
+			send_whether_debugging(uhd);
+			break;
+		case NETLINK_MSG_READY:
+			if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(int))) {
+				printk("Invalid ready mesage.\n");
+				return -EINVAL;
+			}
+			if ((err = nl_ready(uhd, *data)) != 0)
+				return err;
+			break;
+	}
+
+	return 0;
+}
+
+static void suspend_user_rcv_skb(struct user_helper_data *uhd,
+				  struct sk_buff *skb)
+{
+	int err;
+	struct nlmsghdr *nlh;
+
+	while (skb->len >= NLMSG_SPACE(0)) {
+		u32 rlen;
+
+		nlh = (struct nlmsghdr *) skb->data;
+		if (nlh->nlmsg_len < sizeof(*nlh) || skb->len < nlh->nlmsg_len)
+			return;
+
+		rlen = NLMSG_ALIGN(nlh->nlmsg_len);
+		if (rlen > skb->len)
+			rlen = skb->len;
+
+		if ((err = suspend_nl_gen_rcv_msg(uhd, skb, nlh)) != 0)
+			netlink_ack(skb, nlh, err);
+		else if (nlh->nlmsg_flags & NLM_F_ACK)
+			netlink_ack(skb, nlh, 0);
+		skb_pull(skb, rlen);
+	}
+}
+
+static void suspend_netlink_input(struct sock *sk, int len)
+{
+	struct user_helper_data *uhd = uhd_list;
+
+	while (uhd && uhd->netlink_id != sk->sk_protocol)
+		uhd= uhd->next;
+
+	BUG_ON(!uhd);
+
+	do {
+		struct sk_buff *skb;
+		while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+			suspend_user_rcv_skb(uhd, skb);
+			put_skb(uhd, skb);
+		}
+	} while (uhd->nl && uhd->nl->sk_receive_queue.qlen);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
