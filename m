Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUIISon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUIISon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUIIS0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:26:03 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:34257 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266669AbUIISLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:11:20 -0400
Subject: [patch 1/2] uml: fold ghash.h inside physmem.c
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, hch@infradead.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 09 Sep 2004 20:05:18 +0200
Message-Id: <20040909180519.61C2DA374@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since we don't want ghash.h, just move the two needed macros (which don't use
the nasty fuzzy algorithm) to physmem.c. This should at all safe, and will
avoid ghash.h making its way inside 2.6.9. A separate patch will also fold the
macros inside their uses (there is just one defined hash), but since this hook
is not very used in this particular moment, I'll defer that to later. However
I'm posting the second one for review (but not for merging).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/physmem.c |   80 +++++++
 uml-linux-2.6.8.1/include/linux/ghash.h          |  236 -----------------------
 2 files changed, 79 insertions(+), 237 deletions(-)

diff -L include/linux/ghash.h -puN include/linux/ghash.h~uml-fold-ghash-h-inside-physmem-c /dev/null
--- uml-linux-2.6.8.1/include/linux/ghash.h
+++ /dev/null	2004-06-25 17:47:25.000000000 +0200
@@ -1,236 +0,0 @@
-/*
- * include/linux/ghash.h -- generic hashing with fuzzy retrieval
- *
- * (C) 1997 Thomas Schoebel-Theuer
- *
- * The algorithms implemented here seem to be a completely new invention,
- * and I'll publish the fundamentals in a paper.
- */
-
-#ifndef _GHASH_H
-#define _GHASH_H
-/* HASHSIZE _must_ be a power of two!!! */
-
-
-#define DEF_HASH_FUZZY_STRUCTS(NAME,HASHSIZE,TYPE) \
-\
-struct NAME##_table {\
-	TYPE * hashtable[HASHSIZE];\
-	TYPE * sorted_list;\
-	int nr_entries;\
-};\
-\
-struct NAME##_ptrs {\
-	TYPE * next_hash;\
-	TYPE * prev_hash;\
-	TYPE * next_sorted;\
-	TYPE * prev_sorted;\
-};
-
-#define DEF_HASH_FUZZY(LINKAGE,NAME,HASHSIZE,TYPE,PTRS,KEYTYPE,KEY,KEYCMP,KEYEQ,HASHFN)\
-\
-LINKAGE void insert_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
-{\
-	int ix = HASHFN(elem->KEY);\
-	TYPE ** base = &tbl->hashtable[ix];\
-	TYPE * ptr = *base;\
-	TYPE * prev = NULL;\
-\
-	tbl->nr_entries++;\
-	while(ptr && KEYCMP(ptr->KEY, elem->KEY)) {\
-		base = &ptr->PTRS.next_hash;\
-		prev = ptr;\
-		ptr = *base;\
-	}\
-	elem->PTRS.next_hash = ptr;\
-	elem->PTRS.prev_hash = prev;\
-	if(ptr) {\
-		ptr->PTRS.prev_hash = elem;\
-	}\
-	*base = elem;\
-\
-	ptr = prev;\
-	if(!ptr) {\
-		ptr = tbl->sorted_list;\
-		prev = NULL;\
-	} else {\
-		prev = ptr->PTRS.prev_sorted;\
-	}\
-	while(ptr) {\
-		TYPE * next = ptr->PTRS.next_hash;\
-		if(next && KEYCMP(next->KEY, elem->KEY)) {\
-			prev = ptr;\
-			ptr = next;\
-		} else if(KEYCMP(ptr->KEY, elem->KEY)) {\
-			prev = ptr;\
-			ptr = ptr->PTRS.next_sorted;\
-		} else\
-			break;\
-	}\
-	elem->PTRS.next_sorted = ptr;\
-	elem->PTRS.prev_sorted = prev;\
-	if(ptr) {\
-		ptr->PTRS.prev_sorted = elem;\
-	}\
-	if(prev) {\
-		prev->PTRS.next_sorted = elem;\
-	} else {\
-		tbl->sorted_list = elem;\
-	}\
-}\
-\
-LINKAGE void remove_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
-{\
-	TYPE * next = elem->PTRS.next_hash;\
-	TYPE * prev = elem->PTRS.prev_hash;\
-\
-	tbl->nr_entries--;\
-	if(next)\
-		next->PTRS.prev_hash = prev;\
-	if(prev)\
-		prev->PTRS.next_hash = next;\
-	else {\
-		int ix = HASHFN(elem->KEY);\
-		tbl->hashtable[ix] = next;\
-	}\
-\
-	next = elem->PTRS.next_sorted;\
-	prev = elem->PTRS.prev_sorted;\
-	if(next)\
-		next->PTRS.prev_sorted = prev;\
-	if(prev)\
-		prev->PTRS.next_sorted = next;\
-	else\
-		tbl->sorted_list = next;\
-}\
-\
-LINKAGE TYPE * find_##NAME##_hash(struct NAME##_table * tbl, KEYTYPE pos)\
-{\
-	int ix = hashfn(pos);\
-	TYPE * ptr = tbl->hashtable[ix];\
-	while(ptr && KEYCMP(ptr->KEY, pos))\
-		ptr = ptr->PTRS.next_hash;\
-	if(ptr && !KEYEQ(ptr->KEY, pos))\
-		ptr = NULL;\
-	return ptr;\
-}\
-\
-LINKAGE TYPE * find_##NAME##_hash_fuzzy(struct NAME##_table * tbl, KEYTYPE pos)\
-{\
-	int ix;\
-	int offset;\
-	TYPE * ptr;\
-	TYPE * next;\
-\
-	ptr = tbl->sorted_list;\
-	if(!ptr || KEYCMP(pos, ptr->KEY))\
-		return NULL;\
-	ix = HASHFN(pos);\
-	offset = HASHSIZE;\
-	do {\
-		offset >>= 1;\
-		next = tbl->hashtable[(ix+offset) & ((HASHSIZE)-1)];\
-		if(next && (KEYCMP(next->KEY, pos) || KEYEQ(next->KEY, pos))\
-		   && KEYCMP(ptr->KEY, next->KEY))\
-			ptr = next;\
-	} while(offset);\
-\
-	for(;;) {\
-		next = ptr->PTRS.next_hash;\
-		if(next) {\
-			if(KEYCMP(next->KEY, pos)) {\
-				ptr = next;\
-				continue;\
-			}\
-		}\
-		next = ptr->PTRS.next_sorted;\
-		if(next && KEYCMP(next->KEY, pos)) {\
-			ptr = next;\
-			continue;\
-		}\
-		return ptr;\
-	}\
-	return NULL;\
-}
-
-/* LINKAGE - empty or "static", depending on whether you want the definitions to
- *	be public or not
- * NAME - a string to stick in names to make this hash table type distinct from
- * 	any others
- * HASHSIZE - number of buckets
- * TYPE - type of data contained in the buckets - must be a structure, one 
- * 	field is of type NAME_ptrs, another is the hash key
- * PTRS - TYPE must contain a field of type NAME_ptrs, PTRS is the name of that
- * 	field
- * KEYTYPE - type of the key field within TYPE
- * KEY - name of the key field within TYPE
- * KEYCMP - pointer to function that compares KEYTYPEs to each other - the
- * 	prototype is int KEYCMP(KEYTYPE, KEYTYPE), it returns zero for equal, 
- * 	non-zero for not equal
- * HASHFN - the hash function - the prototype is int HASHFN(KEYTYPE),
- * 	it returns a number in the range 0 ... HASHSIZE - 1
- * Call DEF_HASH_STRUCTS, define your hash table as a NAME_table, then call
- * DEF_HASH.
- */
-
-#define DEF_HASH_STRUCTS(NAME,HASHSIZE,TYPE) \
-\
-struct NAME##_table {\
-	TYPE * hashtable[HASHSIZE];\
-	int nr_entries;\
-};\
-\
-struct NAME##_ptrs {\
-	TYPE * next_hash;\
-	TYPE * prev_hash;\
-};
-
-#define DEF_HASH(LINKAGE,NAME,TYPE,PTRS,KEYTYPE,KEY,KEYCMP,HASHFN)\
-\
-LINKAGE void insert_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
-{\
-	int ix = HASHFN(elem->KEY);\
-	TYPE ** base = &tbl->hashtable[ix];\
-	TYPE * ptr = *base;\
-	TYPE * prev = NULL;\
-\
-	tbl->nr_entries++;\
-	while(ptr && KEYCMP(ptr->KEY, elem->KEY)) {\
-		base = &ptr->PTRS.next_hash;\
-		prev = ptr;\
-		ptr = *base;\
-	}\
-	elem->PTRS.next_hash = ptr;\
-	elem->PTRS.prev_hash = prev;\
-	if(ptr) {\
-		ptr->PTRS.prev_hash = elem;\
-	}\
-	*base = elem;\
-}\
-\
-LINKAGE void remove_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
-{\
-	TYPE * next = elem->PTRS.next_hash;\
-	TYPE * prev = elem->PTRS.prev_hash;\
-\
-	tbl->nr_entries--;\
-	if(next)\
-		next->PTRS.prev_hash = prev;\
-	if(prev)\
-		prev->PTRS.next_hash = next;\
-	else {\
-		int ix = HASHFN(elem->KEY);\
-		tbl->hashtable[ix] = next;\
-	}\
-}\
-\
-LINKAGE TYPE * find_##NAME##_hash(struct NAME##_table * tbl, KEYTYPE pos)\
-{\
-	int ix = HASHFN(pos);\
-	TYPE * ptr = tbl->hashtable[ix];\
-	while(ptr && KEYCMP(ptr->KEY, pos))\
-		ptr = ptr->PTRS.next_hash;\
-	return ptr;\
-}
-
-#endif
diff -puN arch/um/kernel/physmem.c~uml-fold-ghash-h-inside-physmem-c arch/um/kernel/physmem.c
--- uml-linux-2.6.8.1/arch/um/kernel/physmem.c~uml-fold-ghash-h-inside-physmem-c	2004-09-09 18:56:28.381109520 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/physmem.c	2004-09-09 19:43:52.463743240 +0200
@@ -4,7 +4,6 @@
  */
 
 #include "linux/mm.h"
-#include "linux/ghash.h"
 #include "linux/slab.h"
 #include "linux/vmalloc.h"
 #include "linux/bootmem.h"
@@ -45,6 +44,85 @@ static struct add_mapping(void *addr, st
 #define PHYS_HASHSIZE (8192)
 
 struct phys_desc;
+/* LINKAGE - empty or "static", depending on whether you want the definitions to
+ *	be public or not
+ * NAME - a string to stick in names to make this hash table type distinct from
+ * 	any others
+ * HASHSIZE - number of buckets
+ * TYPE - type of data contained in the buckets - must be a structure, one
+ * 	field is of type NAME_ptrs, another is the hash key
+ * PTRS - TYPE must contain a field of type NAME_ptrs, PTRS is the name of that
+ * 	field
+ * KEYTYPE - type of the key field within TYPE
+ * KEY - name of the key field within TYPE
+ * KEYCMP - pointer to function that compares KEYTYPEs to each other - the
+ * 	prototype is int KEYCMP(KEYTYPE, KEYTYPE), it returns zero for equal,
+ * 	non-zero for not equal
+ * HASHFN - the hash function - the prototype is int HASHFN(KEYTYPE),
+ * 	it returns a number in the range 0 ... HASHSIZE - 1
+ * Call DEF_HASH_STRUCTS, define your hash table as a NAME_table, then call
+ * DEF_HASH.
+ */
+
+#define DEF_HASH_STRUCTS(NAME,HASHSIZE,TYPE) \
+\
+struct NAME##_table {\
+	TYPE * hashtable[HASHSIZE];\
+	int nr_entries;\
+};\
+\
+struct NAME##_ptrs {\
+	TYPE * next_hash;\
+	TYPE * prev_hash;\
+};
+
+#define DEF_HASH(LINKAGE,NAME,TYPE,PTRS,KEYTYPE,KEY,KEYCMP,HASHFN)\
+\
+LINKAGE void insert_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
+{\
+	int ix = HASHFN(elem->KEY);\
+	TYPE ** base = &tbl->hashtable[ix];\
+	TYPE * ptr = *base;\
+	TYPE * prev = NULL;\
+\
+	tbl->nr_entries++;\
+	while(ptr && KEYCMP(ptr->KEY, elem->KEY)) {\
+		base = &ptr->PTRS.next_hash;\
+		prev = ptr;\
+		ptr = *base;\
+	}\
+	elem->PTRS.next_hash = ptr;\
+	elem->PTRS.prev_hash = prev;\
+	if(ptr) {\
+		ptr->PTRS.prev_hash = elem;\
+	}\
+	*base = elem;\
+}\
+\
+LINKAGE void remove_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
+{\
+	TYPE * next = elem->PTRS.next_hash;\
+	TYPE * prev = elem->PTRS.prev_hash;\
+\
+	tbl->nr_entries--;\
+	if(next)\
+		next->PTRS.prev_hash = prev;\
+	if(prev)\
+		prev->PTRS.next_hash = next;\
+	else {\
+		int ix = HASHFN(elem->KEY);\
+		tbl->hashtable[ix] = next;\
+	}\
+}\
+\
+LINKAGE TYPE * find_##NAME##_hash(struct NAME##_table * tbl, KEYTYPE pos)\
+{\
+	int ix = HASHFN(pos);\
+	TYPE * ptr = tbl->hashtable[ix];\
+	while(ptr && KEYCMP(ptr->KEY, pos))\
+		ptr = ptr->PTRS.next_hash;\
+	return ptr;\
+}
 
 DEF_HASH_STRUCTS(virtmem, PHYS_HASHSIZE, struct phys_desc);
 
_
