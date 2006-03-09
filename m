Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751713AbWCIGx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbWCIGx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbWCIGxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:53:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:51939 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751715AbWCIGxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:53:33 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:52:29 +1100
Message-Id: <1060309065229.24678@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 013 of 14] knfsd: Unexport cache_fresh and fix a small race.
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cache_fresh is now only used in cache.c, so unexport it.

Part of cache_fresh (setting CACHE_VALID) should really be done under the
lock, while part (calling cache_revisit_request etc) must be done outside
the lock.  So we split it up appropriately.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/cache.h |    2 -
 ./net/sunrpc/cache.c           |   51 ++++++++++++++++++++++++-----------------
 ./net/sunrpc/sunrpc_syms.c     |    1 
 3 files changed, 30 insertions(+), 24 deletions(-)

diff ./include/linux/sunrpc/cache.h~current~ ./include/linux/sunrpc/cache.h
--- ./include/linux/sunrpc/cache.h~current~	2006-03-09 17:41:52.000000000 +1100
+++ ./include/linux/sunrpc/cache.h	2006-03-09 17:33:29.000000000 +1100
@@ -165,8 +165,6 @@ static inline int cache_put(struct cache
 }
 
 extern void cache_init(struct cache_head *h);
-extern void cache_fresh(struct cache_detail *detail,
-			struct cache_head *head, time_t expiry);
 extern int cache_check(struct cache_detail *detail,
 		       struct cache_head *h, struct cache_req *rqstp);
 extern void cache_flush(void);

diff ./net/sunrpc/cache.c~current~ ./net/sunrpc/cache.c
--- ./net/sunrpc/cache.c~current~	2006-03-09 17:41:52.000000000 +1100
+++ ./net/sunrpc/cache.c	2006-03-09 17:45:46.000000000 +1100
@@ -96,6 +96,27 @@ struct cache_head *sunrpc_cache_lookup(s
 }
 EXPORT_SYMBOL(sunrpc_cache_lookup);
 
+
+static void queue_loose(struct cache_detail *detail, struct cache_head *ch);
+
+static int cache_fresh_locked(struct cache_head *head, time_t expiry)
+{
+	head->expiry_time = expiry;
+	head->last_refresh = get_seconds();
+	return !test_and_set_bit(CACHE_VALID, &head->flags);
+}
+
+static void cache_fresh_unlocked(struct cache_head *head,
+			struct cache_detail *detail, int new)
+{
+	if (new)
+		cache_revisit_request(head);
+	if (test_and_clear_bit(CACHE_PENDING, &head->flags)) {
+		cache_revisit_request(head);
+		queue_loose(detail, head);
+	}
+}
+
 struct cache_head *sunrpc_cache_update(struct cache_detail *detail,
 				       struct cache_head *new, struct cache_head *old, int hash)
 {
@@ -105,6 +126,7 @@ struct cache_head *sunrpc_cache_update(s
 	 */
 	struct cache_head **head;
 	struct cache_head *tmp;
+	int is_new;
 
 	if (!test_bit(CACHE_VALID, &old->flags)) {
 		write_lock(&detail->hash_lock);
@@ -113,9 +135,9 @@ struct cache_head *sunrpc_cache_update(s
 				set_bit(CACHE_NEGATIVE, &old->flags);
 			else
 				detail->update(old, new);
-			/* FIXME cache_fresh should come first */
+			is_new = cache_fresh_locked(old, new->expiry_time);
 			write_unlock(&detail->hash_lock);
-			cache_fresh(detail, old, new->expiry_time);
+			cache_fresh_unlocked(old, detail, is_new);
 			return old;
 		}
 		write_unlock(&detail->hash_lock);
@@ -138,9 +160,11 @@ struct cache_head *sunrpc_cache_update(s
 	tmp->next = *head;
 	*head = tmp;
 	cache_get(tmp);
+	is_new = cache_fresh_locked(tmp, new->expiry_time);
+	cache_fresh_locked(old, 0);
 	write_unlock(&detail->hash_lock);
-	cache_fresh(detail, tmp, new->expiry_time);
-	cache_fresh(detail, old, 0);
+	cache_fresh_unlocked(tmp, detail, is_new);
+	cache_fresh_unlocked(old, detail, 0);
 	detail->cache_put(old, detail);
 	return tmp;
 }
@@ -192,7 +216,8 @@ int cache_check(struct cache_detail *det
 				clear_bit(CACHE_PENDING, &h->flags);
 				if (rv == -EAGAIN) {
 					set_bit(CACHE_NEGATIVE, &h->flags);
-					cache_fresh(detail, h, get_seconds()+CACHE_NEW_EXPIRY);
+					cache_fresh_unlocked(h, detail,
+					     cache_fresh_locked(h, get_seconds()+CACHE_NEW_EXPIRY));
 					rv = -ENOENT;
 				}
 				break;
@@ -213,22 +238,6 @@ int cache_check(struct cache_detail *det
 	return rv;
 }
 
-static void queue_loose(struct cache_detail *detail, struct cache_head *ch);
-
-void cache_fresh(struct cache_detail *detail,
-		 struct cache_head *head, time_t expiry)
-{
-
-	head->expiry_time = expiry;
-	head->last_refresh = get_seconds();
-	if (!test_and_set_bit(CACHE_VALID, &head->flags))
-		cache_revisit_request(head);
-	if (test_and_clear_bit(CACHE_PENDING, &head->flags)) {
-		cache_revisit_request(head);
-		queue_loose(detail, head);
-	}
-}
-
 /*
  * caches need to be periodically cleaned.
  * For this we maintain a list of cache_detail and

diff ./net/sunrpc/sunrpc_syms.c~current~ ./net/sunrpc/sunrpc_syms.c
--- ./net/sunrpc/sunrpc_syms.c~current~	2006-03-09 17:41:52.000000000 +1100
+++ ./net/sunrpc/sunrpc_syms.c	2006-03-09 17:33:47.000000000 +1100
@@ -105,7 +105,6 @@ EXPORT_SYMBOL(auth_unix_lookup);
 EXPORT_SYMBOL(cache_check);
 EXPORT_SYMBOL(cache_flush);
 EXPORT_SYMBOL(cache_purge);
-EXPORT_SYMBOL(cache_fresh);
 EXPORT_SYMBOL(cache_init);
 EXPORT_SYMBOL(cache_register);
 EXPORT_SYMBOL(cache_unregister);
