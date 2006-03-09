Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751685AbWCIGx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbWCIGx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWCIGxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:53:50 -0500
Received: from ns2.suse.de ([195.135.220.15]:50915 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751685AbWCIGx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:53:27 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:52:24 +1100
Message-Id: <1060309065224.24665@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 012 of 14] knfsd: Remove DefineCacheLookup
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This has been replaced by more traditional code.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/cache.h |  113 -----------------------------------------
 1 file changed, 113 deletions(-)

diff ./include/linux/sunrpc/cache.h~current~ ./include/linux/sunrpc/cache.h
--- ./include/linux/sunrpc/cache.h~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./include/linux/sunrpc/cache.h	2006-03-09 17:32:38.000000000 +1100
@@ -128,119 +128,6 @@ struct cache_deferred_req {
 					   int too_many);
 };
 
-/*
- * just like a template in C++, this macro does cache lookup
- * for us.
- * The function is passed some sort of HANDLE from which a cache_detail
- * structure can be determined (via SETUP, DETAIL), a template
- * cache entry (type RTN*), and a "set" flag.  Using the HASHFN and the 
- * TEST, the function will try to find a matching cache entry in the cache.
- * If "set" == 0 :
- *    If an entry is found, it is returned
- *    If no entry is found, a new non-VALID entry is created.
- * If "set" == 1 :
- *    If no entry is found a new one is inserted with data from "template"
- *    If a non-CACHE_VALID entry is found, it is updated from template using UPDATE
- *    If a CACHE_VALID entry is found, a new entry is swapped in with data
- *       from "template"
- *
- * If the passed handle has the CACHE_NEGATIVE flag set, then UPDATE is not
- * run but insteead CACHE_NEGATIVE is set in any new item.
-
- *  In any case, the new entry is returned with a reference count.
- *
- *    
- * RTN is a struct type for a cache entry
- * MEMBER is the member of the cache which is cache_head, which must be first
- * FNAME is the name for the function	
- * ARGS are arguments to function and must contain RTN *item, int set.  May
- *   also contain something to be usedby SETUP or DETAIL to find cache_detail.
- * SETUP  locates the cache detail and makes it available as...
- * DETAIL identifies the cache detail, possibly set up by SETUP
- * HASHFN returns a hash value of the cache entry "item"
- * TEST  tests if "tmp" matches "item"
- * INIT copies key information from "item" to "new"
- * UPDATE copies content information from "item" to "tmp"
- */
-#define DefineCacheLookup(RTN,MEMBER,FNAME,ARGS,SETUP,DETAIL,HASHFN,TEST,INIT,UPDATE)	\
-RTN *FNAME ARGS										\
-{											\
-	RTN *tmp, *new=NULL;								\
-	struct cache_head **hp, **head;							\
-	SETUP;										\
-	head = &(DETAIL)->hash_table[HASHFN];						\
- retry:											\
-	if (set||new) write_lock(&(DETAIL)->hash_lock);					\
-	else read_lock(&(DETAIL)->hash_lock);						\
-	for(hp=head; *hp != NULL; hp = &tmp->MEMBER.next) {				\
-		tmp = container_of(*hp, RTN, MEMBER);					\
-		if (TEST) { /* found a match */						\
-											\
-			if (set && test_bit(CACHE_VALID, &tmp->MEMBER.flags) && !new)	\
-				break;							\
-											\
-			if (new)							\
-				{INIT;}							\
-			if (set) {							\
-				if (test_bit(CACHE_VALID, &tmp->MEMBER.flags))\
-				{ /* need to swap in new */				\
-					RTN *t2;					\
-											\
-					new->MEMBER.next = tmp->MEMBER.next;		\
-					*hp = &new->MEMBER;				\
-					tmp->MEMBER.next = NULL;			\
-					t2 = tmp; tmp = new; new = t2;			\
-				}							\
-				if (test_bit(CACHE_NEGATIVE,  &item->MEMBER.flags))	\
-					set_bit(CACHE_NEGATIVE, &tmp->MEMBER.flags);	\
-				else {							\
-					UPDATE;						\
-					clear_bit(CACHE_NEGATIVE, &tmp->MEMBER.flags);	\
-				}							\
-			}								\
-			cache_get(&tmp->MEMBER);					\
-			if (set||new) write_unlock(&(DETAIL)->hash_lock);		\
-			else read_unlock(&(DETAIL)->hash_lock);				\
-			if (set)							\
-				cache_fresh(DETAIL, &tmp->MEMBER, item->MEMBER.expiry_time); \
-			if (set && new) cache_fresh(DETAIL, &new->MEMBER, 0);	\
-			if (new) (DETAIL)->cache_put(&new->MEMBER, DETAIL);		\
-			return tmp;							\
-		}									\
-	}										\
-	/* Didn't find anything */							\
-	if (new) {									\
-		INIT;									\
-		new->MEMBER.next = *head;						\
-		*head = &new->MEMBER;							\
-		(DETAIL)->entries ++;							\
-		cache_get(&new->MEMBER);						\
-		if (set) {								\
-			tmp = new;							\
-			if (test_bit(CACHE_NEGATIVE, &item->MEMBER.flags))		\
-				set_bit(CACHE_NEGATIVE, &tmp->MEMBER.flags);		\
-			else {UPDATE;}							\
-		}									\
-	}										\
-	if (set||new) write_unlock(&(DETAIL)->hash_lock);				\
-	else read_unlock(&(DETAIL)->hash_lock);						\
-	if (new && set)									\
-		cache_fresh(DETAIL, &new->MEMBER, item->MEMBER.expiry_time);		\
-	if (new)				       					\
-		return new;								\
-	new = kmalloc(sizeof(*new), GFP_KERNEL);					\
-	if (new) {									\
-		cache_init(&new->MEMBER);						\
-		goto retry;								\
-	}										\
-	return NULL;									\
-}
-
-#define DefineSimpleCacheLookup(STRUCT, FUNC)				\
-        DefineCacheLookup(struct STRUCT, h, FUNC##_lookup,		\
-        (struct STRUCT *item, int set), /*no setup */,			\
-	& FUNC##_cache, FUNC##_hash(item), FUNC##_match(item, tmp),	\
-	STRUCT##_init(new, item), STRUCT##_update(tmp, item))
 
 extern struct cache_head *
 sunrpc_cache_lookup(struct cache_detail *detail,
