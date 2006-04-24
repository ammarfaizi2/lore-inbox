Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWDXIgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWDXIgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWDXIgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:36:51 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:13413 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932065AbWDXIgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:36:50 -0400
Date: Mon, 24 Apr 2006 16:36:49 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] use hlist_unhashed()
Message-ID: <20060424083649.GA6227@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use hlist_unhashed() rather than accessing inside data structure.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
CC: "David S. Miller" <davem@davemloft.net>

 include/linux/list.h             |    2 +-
 include/net/inet_timewait_sock.h |    2 +-
 include/net/sock.h               |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: 2.6-git/include/net/inet_timewait_sock.h
===================================================================
--- 2.6-git.orig/include/net/inet_timewait_sock.h
+++ 2.6-git/include/net/inet_timewait_sock.h
@@ -150,7 +150,7 @@ static inline void inet_twsk_add_bind_no
 
 static inline int inet_twsk_dead_hashed(const struct inet_timewait_sock *tw)
 {
-	return tw->tw_death_node.pprev != NULL;
+	return !hlist_unhashed(&tw->tw_death_node);
 }
 
 static inline void inet_twsk_dead_node_init(struct inet_timewait_sock *tw)
Index: 2.6-git/include/net/sock.h
===================================================================
--- 2.6-git.orig/include/net/sock.h
+++ 2.6-git/include/net/sock.h
@@ -279,7 +279,7 @@ static inline int sk_unhashed(const stru
 
 static inline int sk_hashed(const struct sock *sk)
 {
-	return sk->sk_node.pprev != NULL;
+	return !sk_unhashed(sk);
 }
 
 static __inline__ void sk_node_init(struct hlist_node *node)
Index: 2.6-git/include/linux/list.h
===================================================================
--- 2.6-git.orig/include/linux/list.h
+++ 2.6-git/include/linux/list.h
@@ -619,7 +619,7 @@ static inline void hlist_del_rcu(struct 
 
 static inline void hlist_del_init(struct hlist_node *n)
 {
-	if (n->pprev)  {
+	if (!hlist_unhashed(n)) {
 		__hlist_del(n);
 		INIT_HLIST_NODE(n);
 	}
