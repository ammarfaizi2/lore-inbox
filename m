Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWE2V3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWE2V3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWE2V1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:27:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:482 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751378AbWE2V1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:27:02 -0400
Date: Mon, 29 May 2006 23:27:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 53/61] lock validator: special locking: bh_lock_sock()
Message-ID: <20060529212723.GA3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/net/sock.h  |    3 +++
 net/ipv4/tcp_ipv4.c |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: linux/include/net/sock.h
===================================================================
--- linux.orig/include/net/sock.h
+++ linux/include/net/sock.h
@@ -743,6 +743,9 @@ extern void FASTCALL(release_sock(struct
 
 /* BH context may only use the following locking interface. */
 #define bh_lock_sock(__sk)	spin_lock(&((__sk)->sk_lock.slock))
+#define bh_lock_sock_nested(__sk) \
+				spin_lock_nested(&((__sk)->sk_lock.slock), \
+				SINGLE_DEPTH_NESTING)
 #define bh_unlock_sock(__sk)	spin_unlock(&((__sk)->sk_lock.slock))
 
 extern struct sock		*sk_alloc(int family,
Index: linux/net/ipv4/tcp_ipv4.c
===================================================================
--- linux.orig/net/ipv4/tcp_ipv4.c
+++ linux/net/ipv4/tcp_ipv4.c
@@ -1088,7 +1088,7 @@ process:
 
 	skb->dev = NULL;
 
-	bh_lock_sock(sk);
+	bh_lock_sock_nested(sk);
 	ret = 0;
 	if (!sock_owned_by_user(sk)) {
 		if (!tcp_prequeue(sk, skb))
