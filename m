Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWB0Wcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWB0Wcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWB0Wco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:32:44 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:8576 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932459AbWB0WcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:32:14 -0500
Message-Id: <20060227223404.613303000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:34 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: [patch 34/39] [NETLINK]: Fix a severe bug
Content-Disposition: inline; filename=fix-a-severe-bug.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

netlink overrun was broken while improvement of netlink.
Destination socket is used in the place where it was meant to be source socket,
so that now overrun is never sent to user netlink sockets, when it should be,
and it even can be set on kernel socket, which results in complete deadlock
of rtnetlink.

Suggested fix is to restore status quo passing source socket as additional
argument to netlink_attachskb().

A little explanation: overrun is set on a socket, when it failed
to receive some message and sender of this messages does not or even
have no way to handle this error. This happens in two cases:
1. when kernel sends something. Kernel never retransmits and cannot
   wait for buffer space.
2. when user sends a broadcast and the message was not delivered
   to some recipients.

Signed-off-by: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 include/linux/netlink.h  |    3 ++-
 ipc/mqueue.c             |    3 ++-
 net/netlink/af_netlink.c |    7 ++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

--- linux-2.6.15.4.orig/include/linux/netlink.h
+++ linux-2.6.15.4/include/linux/netlink.h
@@ -160,7 +160,8 @@ extern int netlink_unregister_notifier(s
 
 /* finegrained unicast helpers: */
 struct sock *netlink_getsockbyfilp(struct file *filp);
-int netlink_attachskb(struct sock *sk, struct sk_buff *skb, int nonblock, long timeo);
+int netlink_attachskb(struct sock *sk, struct sk_buff *skb, int nonblock,
+		long timeo, struct sock *ssk);
 void netlink_detachskb(struct sock *sk, struct sk_buff *skb);
 int netlink_sendskb(struct sock *sk, struct sk_buff *skb, int protocol);
 
--- linux-2.6.15.4.orig/ipc/mqueue.c
+++ linux-2.6.15.4/ipc/mqueue.c
@@ -1017,7 +1017,8 @@ retry:
 				goto out;
 			}
 
-			ret = netlink_attachskb(sock, nc, 0, MAX_SCHEDULE_TIMEOUT);
+			ret = netlink_attachskb(sock, nc, 0,
+					MAX_SCHEDULE_TIMEOUT, NULL);
 			if (ret == 1)
 		       		goto retry;
 			if (ret) {
--- linux-2.6.15.4.orig/net/netlink/af_netlink.c
+++ linux-2.6.15.4/net/netlink/af_netlink.c
@@ -701,7 +701,8 @@ struct sock *netlink_getsockbyfilp(struc
  * 0: continue
  * 1: repeat lookup - reference dropped while waiting for socket memory.
  */
-int netlink_attachskb(struct sock *sk, struct sk_buff *skb, int nonblock, long timeo)
+int netlink_attachskb(struct sock *sk, struct sk_buff *skb, int nonblock,
+		long timeo, struct sock *ssk)
 {
 	struct netlink_sock *nlk;
 
@@ -711,7 +712,7 @@ int netlink_attachskb(struct sock *sk, s
 	    test_bit(0, &nlk->state)) {
 		DECLARE_WAITQUEUE(wait, current);
 		if (!timeo) {
-			if (!nlk->pid)
+			if (!ssk || nlk_sk(ssk)->pid == 0)
 				netlink_overrun(sk);
 			sock_put(sk);
 			kfree_skb(skb);
@@ -796,7 +797,7 @@ retry:
 		kfree_skb(skb);
 		return PTR_ERR(sk);
 	}
-	err = netlink_attachskb(sk, skb, nonblock, timeo);
+	err = netlink_attachskb(sk, skb, nonblock, timeo, ssk);
 	if (err == 1)
 		goto retry;
 	if (err)

--
