Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUIIS3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUIIS3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUIIS04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:26:56 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:11967 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266657AbUIISKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:10:14 -0400
Subject: [patch 2/2] uml: remove ghash.h - part 2
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, hch@infradead.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 09 Sep 2004 20:05:21 +0200
Message-Id: <20040909180521.B8FF9A434@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch will fold the macros inside their uses (there is just one defined
hash), but since this hook is not very used in this particular moment, I'll
defer this patch to later. However I'm posting this one for review (but not
for merging).
Actually, it's just a search and replace, but who knows...

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/physmem.c |  141 +++++++++--------------
 1 files changed, 56 insertions(+), 85 deletions(-)

diff -puN arch/um/kernel/physmem.c~uml-remove-ghash-h-take-2 arch/um/kernel/physmem.c
--- uml-linux-2.6.8.1/arch/um/kernel/physmem.c~uml-remove-ghash-h-take-2	2004-09-09 20:04:22.175798592 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/physmem.c	2004-09-09 20:04:22.178798136 +0200
@@ -44,88 +44,17 @@ static struct add_mapping(void *addr, st
 #define PHYS_HASHSIZE (8192)
 
 struct phys_desc;
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
+struct virtmem_table {
+	struct phys_desc * hashtable[PHYS_HASHSIZE];
+	int nr_entries;
+} virtmem_hash;
+
+struct virtmem_ptrs {
+	struct phys_desc * next_hash;
+	struct phys_desc * prev_hash;
 };
 
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
-DEF_HASH_STRUCTS(virtmem, PHYS_HASHSIZE, struct phys_desc);
-
 struct phys_desc {
 	struct virtmem_ptrs virt_ptrs;
 	int fd;
@@ -135,21 +64,63 @@ struct phys_desc {
 	struct list_head list;
 };
 
-struct virtmem_table virtmem_hash;
-
-static int virt_cmp(void *virt1, void *virt2)
+static inline int virt_cmp(void *virt1, void *virt2)
 {
 	return(virt1 != virt2);
 }
 
-static int virt_hash(void *virt)
+static inline int virt_hash(void *virt)
 {
 	unsigned long addr = ((unsigned long) virt) >> PAGE_SHIFT;
 	return(addr % PHYS_HASHSIZE);
 }
 
-DEF_HASH(static, virtmem, struct phys_desc, virt_ptrs, void *, virt, virt_cmp, 
-	 virt_hash);
+
+static void insert_virtmem_hash(struct virtmem_table * tbl, struct phys_desc * elem)
+{
+	int ix = virt_hash(elem->virt);
+	struct phys_desc ** base = &tbl->hashtable[ix];
+	struct phys_desc * ptr = *base;
+	struct phys_desc * prev = NULL;
+
+	tbl->nr_entries++;
+	while(ptr && virt_cmp(ptr->virt, elem->virt)) {
+		base = &ptr->virt_ptrs.next_hash;
+		prev = ptr;
+		ptr = *base;
+	}
+	elem->virt_ptrs.next_hash = ptr;
+	elem->virt_ptrs.prev_hash = prev;
+	if(ptr) {
+		ptr->virt_ptrs.prev_hash = elem;
+	}
+	*base = elem;
+}
+
+static void remove_virtmem_hash(struct virtmem_table * tbl, struct phys_desc * elem)
+{
+	struct phys_desc * next = elem->virt_ptrs.next_hash;
+	struct phys_desc * prev = elem->virt_ptrs.prev_hash;
+
+	tbl->nr_entries--;
+	if(next)
+		next->virt_ptrs.prev_hash = prev;
+	if(prev)
+		prev->virt_ptrs.next_hash = next;
+	else {
+		int ix = virt_hash(elem->virt);
+		tbl->hashtable[ix] = next;
+	}
+}
+
+static struct phys_desc * find_virtmem_hash(struct virtmem_table * tbl, void* pos)
+{
+	int ix = virt_hash(pos);
+	struct phys_desc * ptr = tbl->hashtable[ix];
+	while(ptr && virt_cmp(ptr->virt, pos))
+		ptr = ptr->virt_ptrs.next_hash;
+	return ptr;
+}
 
 LIST_HEAD(descriptor_mappings);
 
_
