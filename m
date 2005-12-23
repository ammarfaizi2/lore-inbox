Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbVLWWwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbVLWWwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVLWWwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:52:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:63183 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161106AbVLWWt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:29 -0500
Date: Fri, 23 Dec 2005 14:48:37 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net
Subject: [patch 14/19] [IPSEC]: Perform SA switchover immediately.
Message-ID: <20051223224837.GN19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipsec-perform-SA-switchover-immediately.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: "David S. Miller" <davem@davemloft.net>

When we insert a new xfrm_state which potentially
subsumes an existing one, make sure all cached
bundles are flushed so that the new SA is used
immediately.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/net/xfrm.h     |    1 +
 net/xfrm/xfrm_policy.c |   19 ++++++++++++++-----
 net/xfrm/xfrm_state.c  |    5 +++++
 3 files changed, 20 insertions(+), 5 deletions(-)

--- linux-2.6.14.4.orig/include/net/xfrm.h
+++ linux-2.6.14.4/include/net/xfrm.h
@@ -890,6 +890,7 @@ struct xfrm_state * xfrm_find_acq(u8 mod
 extern void xfrm_policy_flush(void);
 extern int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
 extern int xfrm_flush_bundles(void);
+extern void xfrm_flush_all_bundles(void);
 extern int xfrm_bundle_ok(struct xfrm_dst *xdst, struct flowi *fl, int family);
 extern void xfrm_init_pmtu(struct dst_entry *dst);
 
--- linux-2.6.14.4.orig/net/xfrm/xfrm_policy.c
+++ linux-2.6.14.4/net/xfrm/xfrm_policy.c
@@ -1014,13 +1014,12 @@ int __xfrm_route_forward(struct sk_buff 
 }
 EXPORT_SYMBOL(__xfrm_route_forward);
 
-/* Optimize later using cookies and generation ids. */
-
 static struct dst_entry *xfrm_dst_check(struct dst_entry *dst, u32 cookie)
 {
-	if (!stale_bundle(dst))
-		return dst;
-
+	/* If it is marked obsolete, which is how we even get here,
+	 * then we have purged it from the policy bundle list and we
+	 * did that for a good reason.
+	 */
 	return NULL;
 }
 
@@ -1104,6 +1103,16 @@ int xfrm_flush_bundles(void)
 	return 0;
 }
 
+static int always_true(struct dst_entry *dst)
+{
+	return 1;
+}
+
+void xfrm_flush_all_bundles(void)
+{
+	xfrm_prune_bundles(always_true);
+}
+
 void xfrm_init_pmtu(struct dst_entry *dst)
 {
 	do {
--- linux-2.6.14.4.orig/net/xfrm/xfrm_state.c
+++ linux-2.6.14.4/net/xfrm/xfrm_state.c
@@ -435,6 +435,8 @@ void xfrm_state_insert(struct xfrm_state
 	spin_lock_bh(&xfrm_state_lock);
 	__xfrm_state_insert(x);
 	spin_unlock_bh(&xfrm_state_lock);
+
+	xfrm_flush_all_bundles();
 }
 EXPORT_SYMBOL(xfrm_state_insert);
 
@@ -482,6 +484,9 @@ out:
 	spin_unlock_bh(&xfrm_state_lock);
 	xfrm_state_put_afinfo(afinfo);
 
+	if (!err)
+		xfrm_flush_all_bundles();
+
 	if (x1) {
 		xfrm_state_delete(x1);
 		xfrm_state_put(x1);

--
