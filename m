Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUH1Kzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUH1Kzx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUH1Kzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:55:45 -0400
Received: from verein.lst.de ([213.95.11.210]:61593 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262329AbUH1KzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 06:55:19 -0400
Date: Sat, 28 Aug 2004 12:55:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] move ghash.h were it does less harm
Message-ID: <20040828105512.GA11067@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grmp, UML folks re-added ghash.h despite beeing told repeatedly not to
do so.  At least move it to arch/um/ so people don't start to use it
again when they are on similar drugs as thge UML people.


diff -uNr linux-2.6.9-rc1-mm1/arch/um/kernel/ghash.h linux-2.6.9-rc1-mm1-hch/arch/um/kernel/ghash.h
--- linux-2.6.9-rc1-mm1/arch/um/kernel/ghash.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc1-mm1-hch/arch/um/kernel/ghash.h	2004-08-28 12:17:39.033454000 +0200
@@ -0,0 +1,236 @@
+/*
+ * include/linux/ghash.h -- generic hashing with fuzzy retrieval
+ *
+ * (C) 1997 Thomas Schoebel-Theuer
+ *
+ * The algorithms implemented here seem to be a completely new invention,
+ * and I'll publish the fundamentals in a paper.
+ */
+
+#ifndef _GHASH_H
+#define _GHASH_H
+/* HASHSIZE _must_ be a power of two!!! */
+
+
+#define DEF_HASH_FUZZY_STRUCTS(NAME,HASHSIZE,TYPE) \
+\
+struct NAME##_table {\
+	TYPE * hashtable[HASHSIZE];\
+	TYPE * sorted_list;\
+	int nr_entries;\
+};\
+\
+struct NAME##_ptrs {\
+	TYPE * next_hash;\
+	TYPE * prev_hash;\
+	TYPE * next_sorted;\
+	TYPE * prev_sorted;\
+};
+
+#define DEF_HASH_FUZZY(LINKAGE,NAME,HASHSIZE,TYPE,PTRS,KEYTYPE,KEY,KEYCMP,KEYEQ,HASHFN)\
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
+\
+	ptr = prev;\
+	if(!ptr) {\
+		ptr = tbl->sorted_list;\
+		prev = NULL;\
+	} else {\
+		prev = ptr->PTRS.prev_sorted;\
+	}\
+	while(ptr) {\
+		TYPE * next = ptr->PTRS.next_hash;\
+		if(next && KEYCMP(next->KEY, elem->KEY)) {\
+			prev = ptr;\
+			ptr = next;\
+		} else if(KEYCMP(ptr->KEY, elem->KEY)) {\
+			prev = ptr;\
+			ptr = ptr->PTRS.next_sorted;\
+		} else\
+			break;\
+	}\
+	elem->PTRS.next_sorted = ptr;\
+	elem->PTRS.prev_sorted = prev;\
+	if(ptr) {\
+		ptr->PTRS.prev_sorted = elem;\
+	}\
+	if(prev) {\
+		prev->PTRS.next_sorted = elem;\
+	} else {\
+		tbl->sorted_list = elem;\
+	}\
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
+\
+	next = elem->PTRS.next_sorted;\
+	prev = elem->PTRS.prev_sorted;\
+	if(next)\
+		next->PTRS.prev_sorted = prev;\
+	if(prev)\
+		prev->PTRS.next_sorted = next;\
+	else\
+		tbl->sorted_list = next;\
+}\
+\
+LINKAGE TYPE * find_##NAME##_hash(struct NAME##_table * tbl, KEYTYPE pos)\
+{\
+	int ix = hashfn(pos);\
+	TYPE * ptr = tbl->hashtable[ix];\
+	while(ptr && KEYCMP(ptr->KEY, pos))\
+		ptr = ptr->PTRS.next_hash;\
+	if(ptr && !KEYEQ(ptr->KEY, pos))\
+		ptr = NULL;\
+	return ptr;\
+}\
+\
+LINKAGE TYPE * find_##NAME##_hash_fuzzy(struct NAME##_table * tbl, KEYTYPE pos)\
+{\
+	int ix;\
+	int offset;\
+	TYPE * ptr;\
+	TYPE * next;\
+\
+	ptr = tbl->sorted_list;\
+	if(!ptr || KEYCMP(pos, ptr->KEY))\
+		return NULL;\
+	ix = HASHFN(pos);\
+	offset = HASHSIZE;\
+	do {\
+		offset >>= 1;\
+		next = tbl->hashtable[(ix+offset) & ((HASHSIZE)-1)];\
+		if(next && (KEYCMP(next->KEY, pos) || KEYEQ(next->KEY, pos))\
+		   && KEYCMP(ptr->KEY, next->KEY))\
+			ptr = next;\
+	} while(offset);\
+\
+	for(;;) {\
+		next = ptr->PTRS.next_hash;\
+		if(next) {\
+			if(KEYCMP(next->KEY, pos)) {\
+				ptr = next;\
+				continue;\
+			}\
+		}\
+		next = ptr->PTRS.next_sorted;\
+		if(next && KEYCMP(next->KEY, pos)) {\
+			ptr = next;\
+			continue;\
+		}\
+		return ptr;\
+	}\
+	return NULL;\
+}
+
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
+
+#endif
diff -uNr linux-2.6.9-rc1-mm1/arch/um/kernel/physmem.c linux-2.6.9-rc1-mm1-hch/arch/um/kernel/physmem.c
--- linux-2.6.9-rc1-mm1/arch/um/kernel/physmem.c	2004-08-28 12:17:24.928599096 +0200
+++ linux-2.6.9-rc1-mm1-hch/arch/um/kernel/physmem.c	2004-08-28 12:26:10.152752888 +0200
@@ -4,7 +4,6 @@
  */
 
 #include "linux/mm.h"
-#include "linux/ghash.h"
 #include "linux/slab.h"
 #include "linux/vmalloc.h"
 #include "linux/bootmem.h"
@@ -18,6 +17,7 @@
 #include "os.h"
 #include "kern.h"
 #include "init.h"
+#include "ghash.h"
 
 #if 0
 static pgd_t physmem_pgd[PTRS_PER_PGD];
diff -uNr linux-2.6.9-rc1-mm1/include/linux/ghash.h linux-2.6.9-rc1-mm1-hch/include/linux/ghash.h
--- linux-2.6.9-rc1-mm1/include/linux/ghash.h	2004-08-28 12:17:39.033454832 +0200
+++ linux-2.6.9-rc1-mm1-hch/include/linux/ghash.h	1970-01-01 01:00:00.000000000 +0100
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
