Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVCYKFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVCYKFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 05:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVCYKFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 05:05:24 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:40075 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261588AbVCYKEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 05:04:07 -0500
Subject: [patch 2/2] fork_connector: fix problem in the message lenght
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Date: Fri, 25 Mar 2005 11:03:55 +0100
Message-Id: <1111745035.687.51.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 25/03/2005 11:13:36,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 25/03/2005 11:13:38,
	Serialize complete at 25/03/2005 11:13:38
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch fixes a bug in the __cn_rx_skb() routine when checking the
size of the netlink message. 

  It applies to 2.6.12-rc1-mm3.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
--- 

 connector.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

Index: linux-2.6.12-rc1-mm3-cnfork/drivers/connector/connector.c
===================================================================
--- linux-2.6.12-rc1-mm3-cnfork.orig/drivers/connector/connector.c	2005-03-25 10:42:57.000000000 +0100
+++ linux-2.6.12-rc1-mm3-cnfork/drivers/connector/connector.c	2005-03-25 10:43:16.000000000 +0100
@@ -168,12 +168,11 @@ static int __cn_rx_skb(struct sk_buff *s
 	group = NETLINK_CB((skb)).groups;
 	msg = (struct cn_msg *)NLMSG_DATA(nlh);
 
-	if (msg->len != nlh->nlmsg_len - sizeof(*msg) - sizeof(*nlh)) {
+	if (NLMSG_SPACE(msg->len + sizeof(*msg)) != nlh->nlmsg_len) {
 		printk(KERN_ERR "skb does not have enough length: "
-				"requested msg->len=%u[%u], nlh->nlmsg_len=%u[%u], skb->len=%u[must be %u].\n", 
-				msg->len, NLMSG_SPACE(msg->len), 
-				nlh->nlmsg_len, nlh->nlmsg_len - sizeof(*nlh),
-				skb->len, msg->len + sizeof(*msg));
+				"requested msg->len=%u[%u], nlh->nlmsg_len=%u, skb->len=%u.\n",
+				msg->len, NLMSG_SPACE(msg->len + sizeof(*msg)),
+				nlh->nlmsg_len, skb->len);
 		kfree_skb(skb);
 		return -EINVAL;
 	}


