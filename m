Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266078AbUFPCxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266078AbUFPCxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUFPCxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:53:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20907 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266078AbUFPCvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:51:13 -0400
Date: Tue, 15 Jun 2004 22:51:09 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Chris Wright <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>,
       <selinux@tycho.nsa.gov>
Subject: [SELINUX][PATCH 2/4] Fine-grained Netlink support - move
 security_netlink_send() hook.
In-Reply-To: <Xine.LNX.4.44.0406152226150.30562@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0406152228190.30562-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the security_netlink_send() LSM hook after the user copy,
so that LSM modules can safely examine skb payload content.  For SELinux,
we need to look at the Netlink message type.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>

 net/netlink/af_netlink.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -purN -X dontdiff linux-2.6.7-rc3.p/net/netlink/af_netlink.c linux-2.6.7-rc3.w/net/netlink/af_netlink.c
--- linux-2.6.7-rc3.p/net/netlink/af_netlink.c	2004-06-07 18:54:14.000000000 -0400
+++ linux-2.6.7-rc3.w/net/netlink/af_netlink.c	2004-06-09 10:44:25.682210736 -0400
@@ -728,14 +728,14 @@ static int netlink_sendmsg(struct kiocb 
 	   to corresponding kernel module.   --ANK (980802)
 	 */
 
-	err = security_netlink_send(skb);
-	if (err) {
+	err = -EFAULT;
+	if (memcpy_fromiovec(skb_put(skb,len), msg->msg_iov, len)) {
 		kfree_skb(skb);
 		goto out;
 	}
 
-	err = -EFAULT;
-	if (memcpy_fromiovec(skb_put(skb,len), msg->msg_iov, len)) {
+	err = security_netlink_send(skb);
+	if (err) {
 		kfree_skb(skb);
 		goto out;
 	}




