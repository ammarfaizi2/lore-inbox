Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbWCIG4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWCIG4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWCIGxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:53:01 -0500
Received: from mail.suse.de ([195.135.220.2]:56752 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751666AbWCIGwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:52:46 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:51:43 +1100
Message-Id: <1060309065143.24557@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 14] knfsd: Create cache_lookup function instead of using a macro to declare one.
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The C++-like 'template' approach proves to be too ugly and hard
to work with.

The old 'template' won't go away until all users are updated.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/cache.h |   12 +++++
 ./net/sunrpc/cache.c           |   98 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff ./include/linux/sunrpc/cache.h~current~ ./include/linux/sunrpc/cache.h
--- ./include/linux/sunrpc/cache.h~current~	2006-03-09 17:15:13.000000000 +1100
+++ ./include/linux/sunrpc/cache.h	2006-03-09 17:15:14.000000000 +1100
@@ -81,6 +81,11 @@ struct cache_detail {
 					      struct cache_detail *cd,
 					      struct cache_head *h);
 
+	struct cache_head *	(*alloc)(void);
+	int			(*match)(struct cache_head *orig, struct cache_head *new);
+	void			(*init)(struct cache_head *orig, struct cache_head *new);
+	void			(*update)(struct cache_head *orig, struct cache_head *new);
+
 	/* fields below this comment are for internal use
 	 * and should not be touched by cache owners
 	 */
@@ -237,6 +242,13 @@ RTN *FNAME ARGS										\
 	& FUNC##_cache, FUNC##_hash(item), FUNC##_match(item, tmp),	\
 	STRUCT##_init(new, item), STRUCT##_update(tmp, item))
 
+extern struct cache_head *
+sunrpc_cache_lookup(struct cache_detail *detail,
+		    struct cache_head *key, int hash);
+extern struct cache_head *
+sunrpc_cache_update(struct cache_detail *detail,
+		    struct cache_head *new, struct cache_head *old, int hash);
+
 
 #define cache_for_each(pos, detail, index, member) 						\
 	for (({read_lock(&(detail)->hash_lock); index = (detail)->hash_size;}) ;		\

diff ./net/sunrpc/cache.c~current~ ./net/sunrpc/cache.c
--- ./net/sunrpc/cache.c~current~	2006-03-09 17:12:58.000000000 +1100
+++ ./net/sunrpc/cache.c	2006-03-09 17:15:14.000000000 +1100
@@ -47,6 +47,104 @@ void cache_init(struct cache_head *h)
 	h->last_refresh = now;
 }
 
+struct cache_head *sunrpc_cache_lookup(struct cache_detail *detail,
+				       struct cache_head *key, int hash)
+{
+	struct cache_head **head,  **hp;
+	struct cache_head *new = NULL;
+
+	head = &detail->hash_table[hash];
+
+	read_lock(&detail->hash_lock);
+
+	for (hp=head; *hp != NULL ; hp = &(*hp)->next) {
+		struct cache_head *tmp = *hp;
+		if (detail->match(tmp, key)) {
+			cache_get(tmp);
+			read_unlock(&detail->hash_lock);
+			return tmp;
+		}
+	}
+	read_unlock(&detail->hash_lock);
+	/* Didn't find anything, insert an empty entry */
+
+	new = detail->alloc();
+	if (!new)
+		return NULL;
+	cache_init(new);
+
+	write_lock(&detail->hash_lock);
+
+	/* check if entry appeared while we slept */
+	for (hp=head; *hp != NULL ; hp = &(*hp)->next) {
+		struct cache_head *tmp = *hp;
+		if (detail->match(tmp, key)) {
+			cache_get(tmp);
+			write_unlock(&detail->hash_lock);
+			detail->cache_put(new, detail);
+			return tmp;
+		}
+	}
+	detail->init(new, key);
+	new->next = *head;
+	*head = new;
+	detail->entries++;
+	cache_get(new);
+	write_unlock(&detail->hash_lock);
+
+	return new;
+}
+EXPORT_SYMBOL(sunrpc_cache_lookup);
+
+struct cache_head *sunrpc_cache_update(struct cache_detail *detail,
+				       struct cache_head *new, struct cache_head *old, int hash)
+{
+	/* The 'old' entry is to be replaced by 'new'.
+	 * If 'old' is not VALID, we update it directly,
+	 * otherwise we need to replace it
+	 */
+	struct cache_head **head;
+	struct cache_head *tmp;
+
+	if (!test_bit(CACHE_VALID, &old->flags)) {
+		write_lock(&detail->hash_lock);
+		if (!test_bit(CACHE_VALID, &old->flags)) {
+			if (test_bit(CACHE_NEGATIVE, &new->flags))
+				set_bit(CACHE_NEGATIVE, &old->flags);
+			else
+				detail->update(old, new);
+			/* FIXME cache_fresh should come first */
+			write_unlock(&detail->hash_lock);
+			cache_fresh(detail, old, new->expiry_time);
+			return old;
+		}
+		write_unlock(&detail->hash_lock);
+	}
+	/* We need to insert a new entry */
+	tmp = detail->alloc();
+	if (!tmp) {
+		detail->cache_put(old, detail);
+		return NULL;
+	}
+	cache_init(tmp);
+	detail->init(tmp, old);
+	head = &detail->hash_table[hash];
+
+	write_lock(&detail->hash_lock);
+	if (test_bit(CACHE_NEGATIVE, &new->flags))
+		set_bit(CACHE_NEGATIVE, &tmp->flags);
+	else
+		detail->update(tmp, new);
+	tmp->next = *head;
+	*head = tmp;
+	cache_get(tmp);
+	write_unlock(&detail->hash_lock);
+	cache_fresh(detail, tmp, new->expiry_time);
+	cache_fresh(detail, old, 0);
+	detail->cache_put(old, detail);
+	return tmp;
+}
+EXPORT_SYMBOL(sunrpc_cache_update);
 
 static int cache_make_upcall(struct cache_detail *detail, struct cache_head *h);
 /*
