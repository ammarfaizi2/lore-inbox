Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266918AbTGHJiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 05:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266919AbTGHJiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 05:38:05 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:52742 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S266918AbTGHJha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 05:37:30 -0400
Date: Tue, 8 Jul 2003 19:49:41 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
In-Reply-To: <20030703175153.GC27556@gtf.org>
Message-ID: <Mutt.LNX.4.44.0307081942550.7740-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003, Jeff Garzik wrote:

> 3) I wonder if the kernel should have a generic hash table ADT?

Below is a patch which splits the hash table code from SELinux and makes 
it available as a kernel library component.  It was generated against 
2.5.74-bk1 with Stephen's SELinux patch.

There are also some cleanups: removal of typedefs, limit the total number 
of hash nodes, sizeof(obj) instead of sizeof(type), mitigate some integer 
overflow issues etc.

This hash table code may be a little too generic -- many of the 
interesting hashes in the kernel use very specific and specialized 
techniques e.g. the flow cache, futexes, ext3 dirhash.

Comments?

 include/linux/hashtab.h        |  127 ++++++++++++++++
 lib/Kconfig                    |    8 +
 lib/Makefile                   |    1 
 lib/hashtab.c                  |  301 +++++++++++++++++++++++++++++++++++++++
 security/selinux/Kconfig       |    1 
 security/selinux/ss/Makefile   |    2 
 security/selinux/ss/hashtab.c  |  310 -----------------------------------------
 security/selinux/ss/hashtab.h  |  144 -------------------
 security/selinux/ss/policydb.c |  124 ++++++++--------
 security/selinux/ss/services.c |   35 ++--
 security/selinux/ss/symtab.c   |   10 -
 security/selinux/ss/symtab.h   |    4 
 12 files changed, 531 insertions(+), 536 deletions(-)


- James
-- 
James Morris
<jmorris@intercode.com.au>


diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/include/linux/hashtab.h linux-2.5.74-bk1-sel.w1/include/linux/hashtab.h
--- linux-2.5.74-bk1-sel.orig/include/linux/hashtab.h	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/include/linux/hashtab.h	2003-07-04 15:25:43.000000000 +1000
@@ -0,0 +1,127 @@
+/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+
+/*
+ * A hash table (hashtab) maintains associations between
+ * key values and datum values.  The type of the key values 
+ * and the type of the datum values is arbitrary.  The
+ * functions for hash computation and key comparison are
+ * provided by the creator of the table.
+ */
+
+#ifndef _LINUX_HASHTAB_H_
+#define _LINUX_HASHTAB_H_
+
+#define HASHTAB_MAX_NODES	0xffffffff
+
+struct hashtab_node {
+	void *key;
+	void *datum;
+	struct hashtab_node *next;
+};
+
+struct hashtab {
+	struct hashtab_node **htable;	/* hash table */
+	u32 size;			/* number of slots in hash table */
+	u32 nel;			/* number of elements in hash table */
+	u32 (*hash_value)(struct hashtab *h, void *key);
+					/* hash function */
+	int (*keycmp)(struct hashtab *h, void *key1, void *key2);
+					/* key comparison function */
+};
+
+struct hashtab_info {
+	u32 slots_used;
+	u32 max_chain_len;
+};
+
+/*
+   Creates a new hash table with the specified characteristics.
+
+   Returns NULL if insufficent space is available or
+   the new hash table otherwise.
+ */
+struct hashtab *
+hashtab_create(u32 (*hash_value)(struct hashtab *h, void *key),
+               int (*keycmp)(struct hashtab *h, void *key1, void *key2),
+               u32 size);
+
+/*
+   Inserts the specified (key, datum) pair into the specified hash table.
+
+   Returns -ENOMEM on memory allocation error,
+   -EEXIST if there is already an entry with the same key,
+   -EINVAL for general errors or
+   0 otherwise.
+ */
+int hashtab_insert(struct hashtab *h, void *k, void *d);
+
+/*
+   Removes the entry with the specified key from the hash table.
+   Applies the specified destroy function to (key,datum,args) for
+   the entry.
+
+   Returns -ENOENT if no entry has the specified key,
+   -EINVAL for general errors or
+   0 otherwise.
+ */
+int hashtab_remove(struct hashtab *h, void *k,
+		   void (*destroy)(void *k, void *d, void *args),
+		   void *args);
+
+/*
+   Insert or replace the specified (key, datum) pair in the specified
+   hash table.  If an entry for the specified key already exists,
+   then the specified destroy function is applied to (key,datum,args)
+   for the entry prior to replacing the entry's contents.
+
+   Returns -ENOMEM if insufficient space is available,
+   -EINVAL for general errors or
+   0 otherwise.
+ */
+int hashtab_replace(struct hashtab *h, void *k, void *d,
+		    void (*destroy)(void *k, void *d, void *args),
+		    void *args);
+
+/*
+   Searches for the entry with the specified key in the hash table.
+
+   Returns NULL if no entry has the specified key or
+   the datum of the entry otherwise.
+ */
+void *hashtab_search(struct hashtab *h, void *k);
+
+/*
+   Destroys the specified hash table.
+ */
+void hashtab_destroy(struct hashtab *h);
+
+/*
+   Applies the specified apply function to (key,datum,args)
+   for each entry in the specified hash table.
+
+   The order in which the function is applied to the entries
+   is dependent upon the internal structure of the hash table.
+
+   If apply returns a non-zero status, then hashtab_map will cease
+   iterating through the hash table and will propagate the error
+   return to its caller.
+ */
+int hashtab_map(struct hashtab *h,
+		int (*apply)(void *k, void *d, void *args),
+		void *args);
+
+/*
+   Same as hashtab_map, except that if apply returns a non-zero status,
+   then the (key,datum) pair will be removed from the hashtab and the
+   destroy function will be applied to (key,datum,args).
+*/
+void hashtab_map_remove_on_error(struct hashtab *h,
+                                 int (*apply)(void *k, void *d, void *args),
+                                 void (*destroy)(void *k, void *d, void *args),
+                                 void *args);
+
+
+/* Fill info with some hash table statistics */
+void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
+
+#endif	/* _LINUX_HASHTAB_H */
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/lib/hashtab.c linux-2.5.74-bk1-sel.w1/lib/hashtab.c
--- linux-2.5.74-bk1-sel.orig/lib/hashtab.c	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/lib/hashtab.c	2003-07-04 22:23:38.000000000 +1000
@@ -0,0 +1,301 @@
+/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+/*
+ * Adapted for kernel library use by James Morris <jmorris@intercode.com.au>
+ * 
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ */
+
+/*
+ * Implementation of the hash table type.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/hashtab.h>
+
+struct hashtab *
+hashtab_create(u32 (*hash_value)(struct hashtab *h, void *key),
+               int (*keycmp)(struct hashtab *h, void *key1, void *key2),
+               u32 size)
+{
+	u32 i;
+	struct hashtab *p;
+
+	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	if (p == NULL)
+		return p;
+
+	memset(p, 0, sizeof(*p));
+	p->size = size;
+	p->nel = 0;
+	p->hash_value = hash_value;
+	p->keycmp = keycmp;
+	p->htable = kmalloc(sizeof(p) * size, GFP_KERNEL);
+	if (p->htable == NULL) {
+		kfree(p);
+		return NULL;
+	}
+
+	for (i = 0; i < size; i++)
+		p->htable[i] = NULL;
+	return p;
+}
+
+int hashtab_insert(struct hashtab *h, void *key, void *datum)
+{
+	u32 hvalue;
+	struct hashtab_node *prev, *cur, *newnode;
+
+	if (!h || h->nel == HASHTAB_MAX_NODES)
+		return -EINVAL;
+
+	hvalue = h->hash_value(h, key);
+	prev = NULL;
+	cur = h->htable[hvalue];
+	while (cur && h->keycmp(h, key, cur->key) > 0) {
+		prev = cur;
+		cur = cur->next;
+	} 
+
+	if (cur && (h->keycmp(h, key, cur->key) == 0))
+		return -EEXIST;
+
+	newnode = kmalloc(sizeof(*newnode), GFP_KERNEL);
+	if (newnode == NULL)
+		return -ENOMEM;
+
+	memset(newnode, 0, sizeof(*newnode));
+	newnode->key = key;
+	newnode->datum = datum;
+	if (prev) {
+		newnode->next = prev->next;
+		prev->next = newnode;
+	} else {
+		newnode->next = h->htable[hvalue];
+		h->htable[hvalue] = newnode;
+	}
+
+	h->nel++;
+	return 0;
+}
+
+int hashtab_remove(struct hashtab *h, void *key,
+		   void (*destroy)(void *k, void *d, void *args),
+		   void *args)
+{
+	u32 hvalue;
+	struct hashtab_node *cur, *last;
+
+	if (!h)
+		return -EINVAL;
+
+	hvalue = h->hash_value(h, key);
+	last = NULL;
+	cur = h->htable[hvalue];
+	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
+		last = cur;
+		cur = cur->next;
+	}
+
+	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
+		return -ENOENT;
+
+	if (last == NULL)
+		h->htable[hvalue] = cur->next;
+	else
+		last->next = cur->next;
+
+	if (destroy)
+		destroy(cur->key, cur->datum, args);
+	kfree(cur);
+	h->nel--;
+	return 0;
+}
+
+int hashtab_replace(struct hashtab *h, void *key, void *datum,
+		    void (*destroy)(void *k, void *d, void *args),
+		    void *args)
+{
+	u32 hvalue;
+	struct hashtab_node *prev, *cur, *newnode;
+
+	if (!h)
+		return -EINVAL;
+
+	hvalue = h->hash_value(h, key);
+	prev = NULL;
+	cur = h->htable[hvalue];
+	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
+		prev = cur;
+		cur = cur->next;
+	}
+
+	if (cur && (h->keycmp(h, key, cur->key) == 0)) {
+		if (destroy)
+			destroy(cur->key, cur->datum, args);
+		cur->key = key;
+		cur->datum = datum;
+	} else {
+		newnode = kmalloc(sizeof(*newnode), GFP_KERNEL);
+		if (newnode == NULL)
+			return -ENOMEM;
+		memset(newnode, 0, sizeof(*newnode));
+		newnode->key = key;
+		newnode->datum = datum;
+		if (prev) {
+			newnode->next = prev->next;
+			prev->next = newnode;
+		} else {
+			newnode->next = h->htable[hvalue];
+			h->htable[hvalue] = newnode;
+		}
+	}
+
+	return 0;
+}
+
+void *hashtab_search(struct hashtab *h, void *key)
+{
+	u32 hvalue;
+	struct hashtab_node *cur;
+
+	if (!h)
+		return NULL;
+
+	hvalue = h->hash_value(h, key);
+	cur = h->htable[hvalue];
+	while (cur != NULL && h->keycmp(h, key, cur->key) > 0)
+		cur = cur->next;
+
+	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
+		return NULL;
+
+	return cur->datum;
+}
+
+void hashtab_destroy(struct hashtab *h)
+{
+	u32 i;
+	struct hashtab_node *cur, *temp;
+
+	if (!h)
+		return;
+
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		while (cur != NULL) {
+			temp = cur;
+			cur = cur->next;
+			kfree(temp);
+		}
+		h->htable[i] = NULL;
+	}
+
+	kfree(h->htable);
+	h->htable = NULL;
+
+	kfree(h);
+}
+
+int hashtab_map(struct hashtab *h,
+		int (*apply)(void *k, void *d, void *args),
+		void *args)
+{
+	u32 i;
+	int ret;
+	struct hashtab_node *cur;
+
+	if (!h)
+		return 0;
+
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		while (cur != NULL) {
+			ret = apply(cur->key, cur->datum, args);
+			if (ret)
+				return ret;
+			cur = cur->next;
+		}
+	}
+	return 0;
+}
+
+
+void hashtab_map_remove_on_error(struct hashtab *h,
+                                 int (*apply)(void *k, void *d, void *args),
+                                 void (*destroy)(void *k, void *d, void *args),
+                                 void *args)
+{
+	u32 i;
+	int ret;
+	struct hashtab_node *last, *cur, *temp;
+
+	if (!h)
+		return;
+
+	for (i = 0; i < h->size; i++) {
+		last = NULL;
+		cur = h->htable[i];
+		while (cur != NULL) {
+			ret = apply(cur->key, cur->datum, args);
+			if (ret) {
+				if (last)
+					last->next = cur->next;
+				else
+					h->htable[i] = cur->next;
+
+				temp = cur;
+				cur = cur->next;
+				if (destroy)
+					destroy(temp->key, temp->datum, args);
+				kfree(temp);
+				h->nel--;
+			} else {
+				last = cur;
+				cur = cur->next;
+			}
+		}
+	}
+	return;
+}
+
+void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
+{
+	u32 i, chain_len, slots_used, max_chain_len;
+	struct hashtab_node *cur;
+
+	slots_used = 0;
+	max_chain_len = 0;
+	for (slots_used = max_chain_len = i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		if (cur) {
+			slots_used++;
+			chain_len = 0;
+			while (cur) {
+				chain_len++;
+				cur = cur->next;
+			}
+
+			if (chain_len > max_chain_len)
+				max_chain_len = chain_len;
+		}
+	}
+	
+	info->slots_used = slots_used;
+	info->max_chain_len = max_chain_len;
+}
+
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL_GPL(hashtab_create);
+EXPORT_SYMBOL_GPL(hashtab_insert);
+EXPORT_SYMBOL_GPL(hashtab_remove);
+EXPORT_SYMBOL_GPL(hashtab_replace);
+EXPORT_SYMBOL_GPL(hashtab_search);
+EXPORT_SYMBOL_GPL(hashtab_destroy);
+EXPORT_SYMBOL_GPL(hashtab_map);
+EXPORT_SYMBOL_GPL(hashtab_map_remove_on_error);
+EXPORT_SYMBOL_GPL(hashtab_stat);
+
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/lib/Kconfig linux-2.5.74-bk1-sel.w1/lib/Kconfig
--- linux-2.5.74-bk1-sel.orig/lib/Kconfig	2003-05-01 01:09:03.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/lib/Kconfig	2003-07-04 13:50:44.000000000 +1000
@@ -12,6 +12,14 @@
 	  kernel tree does. Such modules that use library CRC32 functions
 	  require M here.
 
+config HASHTAB
+	tristate "Generic hash table support"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  module requires library hash table support, but a module built
+	  outside the kernel tree does. Such modules that use library hash
+	  table functions require M or Y here.
+
 #
 # Do we need the compression support?
 #
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/lib/Makefile linux-2.5.74-bk1-sel.w1/lib/Makefile
--- linux-2.5.74-bk1-sel.orig/lib/Makefile	2003-07-04 11:27:41.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/lib/Makefile	2003-07-04 12:40:19.000000000 +1000
@@ -16,6 +16,7 @@
 endif
 
 obj-$(CONFIG_CRC32)	+= crc32.o
+obj-$(CONFIG_HASHTAB)	+= hashtab.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/Makefile linux-2.5.74-bk1-sel.w1/Makefile
--- linux-2.5.74-bk1-sel.orig/Makefile	2003-07-04 11:29:01.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/Makefile	2003-07-04 22:04:32.000000000 +1000
@@ -214,7 +214,7 @@
 
 CPPFLAGS	:= -D__KERNEL__ -Iinclude
 CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  	   -fno-strict-aliasing -fno-common
+	  	   -fno-strict-aliasing -fno-common -g
 AFLAGS		:= -D__ASSEMBLY__ $(CPPFLAGS)
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/security/selinux/Kconfig linux-2.5.74-bk1-sel.w1/security/selinux/Kconfig
--- linux-2.5.74-bk1-sel.orig/security/selinux/Kconfig	2003-07-04 12:10:24.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/security/selinux/Kconfig	2003-07-04 21:20:54.000000000 +1000
@@ -1,6 +1,7 @@
 config SECURITY_SELINUX
 	bool "NSA SELinux Support"
 	depends on SECURITY
+	select HASHTAB
 	default n
 	help
 	  This enables NSA Security-Enhanced Linux (SELinux).
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/security/selinux/ss/hashtab.c linux-2.5.74-bk1-sel.w1/security/selinux/ss/hashtab.c
--- linux-2.5.74-bk1-sel.orig/security/selinux/ss/hashtab.c	2003-07-04 12:10:24.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/security/selinux/ss/hashtab.c	1970-01-01 10:00:00.000000000 +1000
@@ -1,310 +0,0 @@
-
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
-
-/* FLASK */
-
-/*
- * Implementation of the hash table type.
- */
-
-#include "hashtab.h"
-
-hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-						     hashtab_key_t key),
-			 int (*keycmp) (hashtab_t h,
-					hashtab_key_t key1,
-					hashtab_key_t key2),
-			 unsigned int size)
-{
-	hashtab_t p;
-	int i;
-
-
-	p = (hashtab_t) kmalloc(sizeof(hashtab_val_t),GFP_KERNEL);
-	if (p == NULL)
-		return p;
-
-	memset(p, 0, sizeof(hashtab_val_t));
-	p->size = size;
-	p->nel = 0;
-	p->hash_value = hash_value;
-	p->keycmp = keycmp;
-	p->htable = (hashtab_ptr_t *) kmalloc(sizeof(hashtab_ptr_t) * size,GFP_KERNEL);
-	if (p->htable == NULL) {
-		kfree(p);
-		return NULL;
-	}
-	for (i = 0; i < size; i++)
-		p->htable[i] = (hashtab_ptr_t) NULL;
-
-	return p;
-}
-
-
-int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
-{
-	int hvalue;
-	hashtab_ptr_t prev, cur, newnode;
-
-
-	if (!h)
-		return HASHTAB_OVERFLOW;
-
-	hvalue = h->hash_value(h, key);
-	prev = NULL;
-	cur = h->htable[hvalue];
-	while (cur && h->keycmp(h, key, cur->key) > 0) {
-		prev = cur;
-		cur = cur->next;
-	} 
-
-	if (cur && (h->keycmp(h, key, cur->key) == 0))
-		return HASHTAB_PRESENT;
-
-	newnode = (hashtab_ptr_t) kmalloc(sizeof(hashtab_node_t),GFP_KERNEL);
-	if (newnode == NULL)
-		return HASHTAB_OVERFLOW;
-	memset(newnode, 0, sizeof(struct hashtab_node));
-	newnode->key = key;
-	newnode->datum = datum;
-	if (prev) {
-		newnode->next = prev->next;
-		prev->next = newnode;
-	} else {
-		newnode->next = h->htable[hvalue];
-		h->htable[hvalue] = newnode;
-	}
-
-	h->nel++;
-	return HASHTAB_SUCCESS;
-}
-
-
-int hashtab_remove(hashtab_t h, hashtab_key_t key,
-		   void (*destroy) (hashtab_key_t k,
-				    hashtab_datum_t d,
-				    void *args),
-		   void *args)
-{
-	int hvalue;
-	hashtab_ptr_t cur, last;
-
-
-	if (!h)
-		return HASHTAB_MISSING;
-
-	hvalue = h->hash_value(h, key);
-	last = NULL;
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
-		last = cur;
-		cur = cur->next;
-	}
-
-	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
-		return HASHTAB_MISSING;
-
-	if (last == NULL)
-		h->htable[hvalue] = cur->next;
-	else
-		last->next = cur->next;
-
-	if (destroy)
-		destroy(cur->key, cur->datum, args);
-	kfree(cur);
-	h->nel--;
-	return HASHTAB_SUCCESS;
-}
-
-
-int hashtab_replace(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
-		    void (*destroy) (hashtab_key_t k,
-				     hashtab_datum_t d,
-				     void *args),
-		    void *args)
-{
-	int hvalue;
-	hashtab_ptr_t prev, cur, newnode;
-
-
-	if (!h)
-		return HASHTAB_OVERFLOW;
-
-	hvalue = h->hash_value(h, key);
-	prev = NULL;
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
-		prev = cur;
-		cur = cur->next;
-	}
-
-	if (cur && (h->keycmp(h, key, cur->key) == 0)) {
-		if (destroy)
-			destroy(cur->key, cur->datum, args);
-		cur->key = key;
-		cur->datum = datum;
-	} else {
-		newnode = (hashtab_ptr_t) kmalloc(sizeof(hashtab_node_t),GFP_KERNEL);
-		if (newnode == NULL)
-			return HASHTAB_OVERFLOW;
-		memset(newnode, 0, sizeof(struct hashtab_node));
-		newnode->key = key;
-		newnode->datum = datum;
-		if (prev) {
-			newnode->next = prev->next;
-			prev->next = newnode;
-		} else {
-			newnode->next = h->htable[hvalue];
-			h->htable[hvalue] = newnode;
-		}
-	}
-
-	return HASHTAB_SUCCESS;
-}
-
-
-hashtab_datum_t
-hashtab_search(hashtab_t h, hashtab_key_t key)
-{
-	int hvalue;
-	hashtab_ptr_t cur;
-
-
-	if (!h)
-		return NULL;
-
-	hvalue = h->hash_value(h, key);
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0)
-		cur = cur->next;
-
-	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
-		return NULL;
-
-	return cur->datum;
-}
-
-
-void hashtab_destroy(hashtab_t h)
-{
-	int i;
-	hashtab_ptr_t cur, temp;
-
-
-	if (!h)
-		return;
-
-	for (i = 0; i < h->size; i++) {
-		cur = h->htable[i];
-		while (cur != NULL) {
-			temp = cur;
-			cur = cur->next;
-			kfree(temp);
-		}
-		h->htable[i] = NULL;
-	}
-
-	kfree(h->htable);
-	h->htable = NULL;
-
-	kfree(h);
-}
-
-
-int hashtab_map(hashtab_t h,
-		int (*apply) (hashtab_key_t k,
-			      hashtab_datum_t d,
-			      void *args),
-		void *args)
-{
-	int i, ret;
-	hashtab_ptr_t cur;
-
-
-	if (!h)
-		return HASHTAB_SUCCESS;
-
-	for (i = 0; i < h->size; i++) {
-		cur = h->htable[i];
-		while (cur != NULL) {
-			ret = apply(cur->key, cur->datum, args);
-			if (ret)
-				return ret;
-			cur = cur->next;
-		}
-	}
-	return HASHTAB_SUCCESS;
-}
-
-
-void hashtab_map_remove_on_error(hashtab_t h,
-				 int (*apply) (hashtab_key_t k,
-					       hashtab_datum_t d,
-					       void *args),
-				 void (*destroy) (hashtab_key_t k,
-						  hashtab_datum_t d,
-						  void *args),
-				 void *args)
-{
-	int i, ret;
-	hashtab_ptr_t last, cur, temp;
-
-
-	if (!h)
-		return;
-
-	for (i = 0; i < h->size; i++) {
-		last = NULL;
-		cur = h->htable[i];
-		while (cur != NULL) {
-			ret = apply(cur->key, cur->datum, args);
-			if (ret) {
-				if (last) {
-					last->next = cur->next;
-				} else {
-					h->htable[i] = cur->next;
-				}
-
-				temp = cur;
-				cur = cur->next;
-				if (destroy)
-					destroy(temp->key, temp->datum, args);
-				kfree(temp);
-				h->nel--;
-			} else {
-				last = cur;
-				cur = cur->next;
-			}
-		}
-	}
-
-	return;
-}
-
-void hashtab_hash_eval(hashtab_t h, char *tag)
-{
-	int i, chain_len, slots_used, max_chain_len;
-	hashtab_ptr_t cur;
-
-
-	slots_used = 0;
-	max_chain_len = 0;
-	for (i = 0; i < h->size; i++) {
-		cur = h->htable[i];
-		if (cur) {
-			slots_used++;
-			chain_len = 0;
-			while (cur) {
-				chain_len++;
-				cur = cur->next;
-			}
-
-			if (chain_len > max_chain_len)
-				max_chain_len = chain_len;
-		}
-	}
-
-	printk("%s:  %d entries and %d/%d buckets used, longest chain length %d\n",
-	       tag, h->nel, slots_used, h->size, max_chain_len);
-}
-
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/security/selinux/ss/hashtab.h linux-2.5.74-bk1-sel.w1/security/selinux/ss/hashtab.h
--- linux-2.5.74-bk1-sel.orig/security/selinux/ss/hashtab.h	2003-07-04 12:10:24.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/security/selinux/ss/hashtab.h	1970-01-01 10:00:00.000000000 +1000
@@ -1,144 +0,0 @@
-
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
-
-/* FLASK */
-
-/*
- * A hash table (hashtab) maintains associations between
- * key values and datum values.  The type of the key values 
- * and the type of the datum values is arbitrary.  The
- * functions for hash computation and key comparison are
- * provided by the creator of the table.
- */
-
-#ifndef _HASHTAB_H_
-#define _HASHTAB_H_
-
-typedef char *hashtab_key_t;	/* generic key type */
-typedef void *hashtab_datum_t;	/* generic datum type */
-
-typedef struct hashtab_node *hashtab_ptr_t;
-
-typedef struct hashtab_node {
-	hashtab_key_t key;
-	hashtab_datum_t datum;
-	hashtab_ptr_t next;	
-} hashtab_node_t;
-
-typedef struct hashtab_val {
-	hashtab_ptr_t *htable; /* hash table */
-	unsigned int size; /* number of slots in hash table */
-	__u32 nel;  	  /* number of elements in hash table */
-	unsigned int (*hash_value) (struct hashtab_val *h, hashtab_key_t key); /* hash function */
-	int (*keycmp) (struct hashtab_val *h, hashtab_key_t key1, hashtab_key_t key2); /* key comparison function */
-} hashtab_val_t;
-
-
-typedef hashtab_val_t *hashtab_t;
-
-/* Define status codes for hash table functions */
-#define HASHTAB_SUCCESS     0
-#define HASHTAB_OVERFLOW    -ENOMEM
-#define HASHTAB_PRESENT     -EEXIST
-#define HASHTAB_MISSING     -ENOENT
-
-/*
-   Creates a new hash table with the specified characteristics.
-
-   Returns NULL if insufficent space is available or
-   the new hash table otherwise.
- */
-hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-						     hashtab_key_t key),
-			 int (*keycmp) (hashtab_t h,
-					hashtab_key_t key1,
-					hashtab_key_t key2),
-			 unsigned int size);
-
-/*
-   Inserts the specified (key, datum) pair into the specified hash table.
-
-   Returns HASHTAB_OVERFLOW if insufficient space is available or
-   HASHTAB_PRESENT  if there is already an entry with the same key or
-   HASHTAB_SUCCESS otherwise.
- */
-int hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_t d);
-
-/*
-   Removes the entry with the specified key from the hash table.
-   Applies the specified destroy function to (key,datum,args) for
-   the entry.
-
-   Returns HASHTAB_MISSING if no entry has the specified key or
-   HASHTAB_SUCCESS otherwise.
- */
-int hashtab_remove(hashtab_t h, hashtab_key_t k,
-		   void (*destroy) (hashtab_key_t k,
-				    hashtab_datum_t d,
-				    void *args),
-		   void *args);
-
-/*
-   Insert or replace the specified (key, datum) pair in the specified
-   hash table.  If an entry for the specified key already exists,
-   then the specified destroy function is applied to (key,datum,args)
-   for the entry prior to replacing the entry's contents.
-
-   Returns HASHTAB_OVERFLOW if insufficient space is available or
-   HASHTAB_SUCCESS otherwise.
- */
-int hashtab_replace(hashtab_t h, hashtab_key_t k, hashtab_datum_t d,
-		    void (*destroy) (hashtab_key_t k,
-				     hashtab_datum_t d,
-				     void *args),
-		    void *args);
-
-/*
-   Searches for the entry with the specified key in the hash table.
-
-   Returns NULL if no entry has the specified key or
-   the datum of the entry otherwise.
- */
-hashtab_datum_t hashtab_search(hashtab_t h, hashtab_key_t k);
-
-/*
-   Destroys the specified hash table.
- */
-void hashtab_destroy(hashtab_t h);
-
-/*
-   Applies the specified apply function to (key,datum,args)
-   for each entry in the specified hash table.
-
-   The order in which the function is applied to the entries
-   is dependent upon the internal structure of the hash table.
-
-   If apply returns a non-zero status, then hashtab_map will cease
-   iterating through the hash table and will propagate the error
-   return to its caller.
- */
-int hashtab_map(hashtab_t h,
-		int (*apply) (hashtab_key_t k,
-			      hashtab_datum_t d,
-			      void *args),
-		void *args);
-
-/*
-   Same as hashtab_map, except that if apply returns a non-zero status,
-   then the (key,datum) pair will be removed from the hashtab and the
-   destroy function will be applied to (key,datum,args).
- */
-void hashtab_map_remove_on_error(hashtab_t h,
-				 int (*apply) (hashtab_key_t k,
-					       hashtab_datum_t d,
-					       void *args),
-				 void (*destroy) (hashtab_key_t k,
-						  hashtab_datum_t d,
-						  void *args),
-				 void *args);
-
-void hashtab_hash_eval(hashtab_t h, char *tag);
-
-
-#endif
-
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/security/selinux/ss/Makefile linux-2.5.74-bk1-sel.w1/security/selinux/ss/Makefile
--- linux-2.5.74-bk1-sel.orig/security/selinux/ss/Makefile	2003-07-04 12:10:24.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/security/selinux/ss/Makefile	2003-07-04 21:19:15.000000000 +1000
@@ -6,7 +6,7 @@
 
 obj-y := ss.o
 
-ss-objs := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o 
+ss-objs := ebitmap.o symtab.o sidtab.o avtab.o policydb.o services.o 
 
 ifeq ($(CONFIG_SECURITY_SELINUX_MLS),y)
 ss-objs += mls.o
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/security/selinux/ss/policydb.c linux-2.5.74-bk1-sel.w1/security/selinux/ss/policydb.c
--- linux-2.5.74-bk1-sel.orig/security/selinux/ss/policydb.c	2003-07-04 12:10:24.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/security/selinux/ss/policydb.c	2003-07-05 00:12:30.907312246 +1000
@@ -10,7 +10,9 @@
 #include "policydb.h"
 #include "mls.h"
 
-#if 0
+#define DEBUG_HASHES
+
+#ifdef DEBUG_HASHES
 static char *symtab_name[SYM_NUM] = {
 	"common prefixes",
 	"classes",
@@ -116,84 +118,84 @@
  * of a class, role, or user are needed.
  */
 
-static int common_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
+static int common_index(void *key, void *datum, void *datap)
 {
 	policydb_t *p;
 	common_datum_t *comdatum;
 
 
-	comdatum = (common_datum_t *) datum;
-	p = (policydb_t *) datap;
+	comdatum = datum;
+	p = datap;
 
-	p->p_common_val_to_name[comdatum->value - 1] = (char *) key;
+	p->p_common_val_to_name[comdatum->value - 1] = key;
 
 	return 0;
 }
 
 
-static int class_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
+static int class_index(void *key, void *datum, void *datap)
 {
 	policydb_t *p;
 	class_datum_t *cladatum;
 
 
-	cladatum = (class_datum_t *) datum;
-	p = (policydb_t *) datap;
+	cladatum = datum;
+	p = datap;
 
-	p->p_class_val_to_name[cladatum->value - 1] = (char *) key;
+	p->p_class_val_to_name[cladatum->value - 1] = key;
 	p->class_val_to_struct[cladatum->value - 1] = cladatum;
 
 	return 0;
 }
 
 
-static int role_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
+static int role_index(void *key, void *datum, void *datap)
 {
 	policydb_t *p;
 	role_datum_t *role;
 
 
-	role = (role_datum_t *) datum;
-	p = (policydb_t *) datap;
+	role = datum;
+	p = datap;
 
-	p->p_role_val_to_name[role->value - 1] = (char *) key;
+	p->p_role_val_to_name[role->value - 1] = key;
 	p->role_val_to_struct[role->value - 1] = role;
 
 	return 0;
 }
 
 
-static int type_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
+static int type_index(void *key, void *datum, void *datap)
 {
 	policydb_t *p;
 	type_datum_t *typdatum;
 
 
-	typdatum = (type_datum_t *) datum;
-	p = (policydb_t *) datap;
+	typdatum = datum;
+	p = datap;
 
 	if (typdatum->primary)
-		p->p_type_val_to_name[typdatum->value - 1] = (char *) key;
+		p->p_type_val_to_name[typdatum->value - 1] = key;
 
 	return 0;
 }
 
-static int user_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
+static int user_index(void *key, void *datum, void *datap)
 {
 	policydb_t *p;
 	user_datum_t *usrdatum;
 
 
-	usrdatum = (user_datum_t *) datum;
-	p = (policydb_t *) datap;
+	usrdatum = datum;
+	p = datap;
 
-	p->p_user_val_to_name[usrdatum->value - 1] = (char *) key;
+	p->p_user_val_to_name[usrdatum->value - 1] = key;
 	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
 
 	return 0;
 }
 
-static int (*index_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum, void *datap) =
+static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 {
 	common_index,
 	class_index,
@@ -234,6 +236,22 @@
 	return 0;
 }
 
+#ifdef DEBUG_HASHES
+static void symtab_hash_eval(symtab_t *s)
+{
+	int i;
+	
+	for (i = 0; i < SYM_NUM; i++) {
+		struct hashtab *h = s[i].table;
+		struct hashtab_info info;
+	
+		hashtab_stat(h, &info);
+		printk("%s:  %d entries and %d/%d buckets used, longest "
+		       "chain length %d\n", symtab_name[i], h->nel, info.slots_used,
+		       h->size, info.max_chain_len);
+	}
+}
+#endif
 
 /*
  * Define the other val_to_name and val_to_struct arrays
@@ -252,10 +270,9 @@
 	printk("security:  %d classes, %d rules\n",
 	       p->p_classes.nprim, p->te_avtab.nel);
 
-#if 0
+#ifdef DEBUG_HASHES
 	avtab_hash_eval(&p->te_avtab, "rules");
-	for (i = 0; i < SYM_NUM; i++) 
-		hashtab_hash_eval(p->symtab[i].table, symtab_name[i]);
+	symtab_hash_eval(p->symtab);
 #endif
 
 	p->role_val_to_struct = (role_datum_t **)
@@ -287,22 +304,20 @@
  * symbol data in the policy database.
  */
 
-static int perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int perm_destroy(void *key, void *datum, void *p)
 {
-	if (key)
-		kfree(key);
+	kfree(key);
 	kfree(datum);
 	return 0;
 }
 
 
-static int common_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int common_destroy(void *key, void *datum, void *p)
 {
 	common_datum_t *comdatum;
 
-	if (key)
-		kfree(key);
-	comdatum = (common_datum_t *) datum;
+	kfree(key);
+	comdatum = datum;
 	hashtab_map(comdatum->permissions.table, perm_destroy, 0);
 	hashtab_destroy(comdatum->permissions.table);
 	kfree(datum);
@@ -310,15 +325,14 @@
 }
 
 
-static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int class_destroy(void *key, void *datum, void *p)
 {
 	class_datum_t *cladatum;
 	constraint_node_t *constraint, *ctemp;
 	constraint_expr_t *e, *etmp;
 
-	if (key)
-		kfree(key);
-	cladatum = (class_datum_t *) datum;
+	kfree(key);
+	cladatum = datum;
 	hashtab_map(cladatum->permissions.table, perm_destroy, 0);
 	hashtab_destroy(cladatum->permissions.table);
 	constraint = cladatum->constraints;
@@ -334,40 +348,36 @@
 		constraint = constraint->next;
 		kfree(ctemp);
 	}
-	if (cladatum->comkey)
-		kfree(cladatum->comkey);
+	kfree(cladatum->comkey);
 	kfree(datum);
 	return 0;
 }
 
-static int role_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int role_destroy(void *key, void *datum, void *p)
 {
 	role_datum_t *role;
 
-	if (key)
-		kfree(key);
-	role = (role_datum_t *) datum;
+	kfree(key);
+	role = datum;
 	ebitmap_destroy(&role->dominates);
 	ebitmap_destroy(&role->types);
 	kfree(datum);
 	return 0;
 }
 
-static int type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int type_destroy(void *key, void *datum, void *p)
 {
-	if (key)
-		kfree(key);
+	kfree(key);
 	kfree(datum);
 	return 0;
 }
 
-static int user_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int user_destroy(void *key, void *datum, void *p)
 {
 	user_datum_t *usrdatum;
 
-	if (key)
-		kfree(key);
-	usrdatum = (user_datum_t *) datum;
+	kfree(key);
+	usrdatum = datum;
 	ebitmap_destroy(&usrdatum->roles);
 	mls_user_destroy(usrdatum);
 	kfree(datum);
@@ -375,7 +385,7 @@
 }
 
 
-static int (*destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum, void *datap) =
+static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 {
 	common_destroy,
 	class_destroy,
@@ -561,7 +571,7 @@
  * binary representation file.
  */
 
-static int perm_read(policydb_t * p, hashtab_t h, void * fp)
+static int perm_read(policydb_t * p, struct hashtab * h, void * fp)
 {
 	char *key = 0;
 	perm_datum_t *perdatum;
@@ -601,7 +611,7 @@
 }
 
 
-static int common_read(policydb_t * p, hashtab_t h, void * fp)
+static int common_read(policydb_t * p, struct hashtab * h, void * fp)
 {
 	char *key = 0;
 	common_datum_t *comdatum;
@@ -650,7 +660,7 @@
 }
 
 
-static int class_read(policydb_t * p, hashtab_t h, void * fp)
+static int class_read(policydb_t * p, struct hashtab * h, void * fp)
 {
 	char *key = 0;
 	class_datum_t *cladatum;
@@ -806,7 +816,7 @@
 }
 
 
-static int role_read(policydb_t * p, hashtab_t h, void * fp)
+static int role_read(policydb_t * p, struct hashtab * h, void * fp)
 {
 	char *key = 0;
 	role_datum_t *role;
@@ -861,7 +871,7 @@
 }
 
 
-static int type_read(policydb_t * p, hashtab_t h, void * fp)
+static int type_read(policydb_t * p, struct hashtab * h, void * fp)
 {
 	char *key = 0;
 	type_datum_t *typdatum;
@@ -899,7 +909,7 @@
 	return -1;
 }
 
-static int user_read(policydb_t * p, hashtab_t h, void * fp)
+static int user_read(policydb_t * p, struct hashtab * h, void * fp)
 {
 	char *key = 0;
 	user_datum_t *usrdatum;
@@ -944,7 +954,7 @@
 }
 
 
-static int (*read_f[SYM_NUM]) (policydb_t * p, hashtab_t h, void * fp) =
+static int (*read_f[SYM_NUM]) (policydb_t * p, struct hashtab * h, void * fp) =
 {
 	common_read,
 	class_read,
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/security/selinux/ss/services.c linux-2.5.74-bk1-sel.w1/security/selinux/ss/services.c
--- linux-2.5.74-bk1-sel.orig/security/selinux/ss/services.c	2003-07-04 12:10:24.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/security/selinux/ss/services.c	2003-07-04 21:51:39.000000000 +1000
@@ -445,7 +445,7 @@
 	*p++ = 0;
 
 	usrdatum = (user_datum_t *) hashtab_search(policydb.p_users.table,
-					      (hashtab_key_t) scontextp);
+					           scontextp);
 	if (!usrdatum)
 		goto out;
 
@@ -462,7 +462,7 @@
 	*p++ = 0;
 
 	role = (role_datum_t *) hashtab_search(policydb.p_roles.table,
-					       (hashtab_key_t) scontextp);
+					       scontextp);
 	if (!role)
 		goto out;
 	context.role = role->value;
@@ -475,7 +475,7 @@
 	*p++ = 0;
 
 	typdatum = (type_datum_t *) hashtab_search(policydb.p_types.table,
-					      (hashtab_key_t) scontextp);
+					           scontextp);
 
 	if (!typdatum)
 		goto out;
@@ -719,22 +719,22 @@
  * existing policy is still defined with the same value
  * in the new policy.
  */
-static int validate_perm(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int validate_perm(void *key, void *datum, void *p)
 {
-	hashtab_t h;
+	struct hashtab *h;
 	perm_datum_t *perdatum, *perdatum2;
 
 
-	h = (hashtab_t) p;
-	perdatum = (perm_datum_t *) datum;
+	h = p;
+	perdatum = datum;
 
 	perdatum2 = (perm_datum_t *) hashtab_search(h, key);
 	if (!perdatum2) {
-		printk("security:  permission %s disappeared", key);
+		printk("security:  permission %s disappeared", (char *)key);
 		return -1;
 	}
 	if (perdatum->value != perdatum2->value) {
-		printk("security:  the value of permission %s changed", key);
+		printk("security:  the value of permission %s changed", (char *)key);
 		return -1;
 	}
 	return 0;
@@ -746,38 +746,39 @@
  * existing policy is still defined with the same 
  * attributes in the new policy.
  */
-static int validate_class(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int validate_class(void *key, void *datum, void *p)
 {
 	policydb_t *newp;
 	class_datum_t *cladatum, *cladatum2;
 
-	newp = (policydb_t *) p;
-	cladatum = (class_datum_t *) datum;
+	newp = p;
+	cladatum = datum;
 
 	cladatum2 = (class_datum_t *) hashtab_search(newp->p_classes.table, key);
 	if (!cladatum2) {
-		printk("security:  class %s disappeared\n", key);
+		printk("security:  class %s disappeared\n", (char *)key);
 		return -1;
 	}
 	if (cladatum->value != cladatum2->value) {
-		printk("security:  the value of class %s changed\n", key);
+		printk("security:  the value of class %s changed\n", (char *)key);
 		return -1;
 	}
 	if ((cladatum->comdatum && !cladatum2->comdatum) ||
 	    (!cladatum->comdatum && cladatum2->comdatum)) {
-		printk("security:  the inherits clause for the access vector definition for class %s changed\n", key);
+		printk("security:  the inherits clause for the access "
+		       "vector definition for class %s changed\n", (char *)key);
 		return -1;
 	}
 	if (cladatum->comdatum) {
 		if (hashtab_map(cladatum->comdatum->permissions.table, validate_perm,
 				cladatum2->comdatum->permissions.table)) {
-			printk(" in the access vector definition for class %s\n", key);
+			printk(" in the access vector definition for class %s\n", (char *)key);
 			return -1;
 		}
 	}
 	if (hashtab_map(cladatum->permissions.table, validate_perm,
 			cladatum2->permissions.table)) {
-		printk(" in access vector definition for class %s\n", key);
+		printk(" in access vector definition for class %s\n", (char *)key);
 		return -1;
 	}
 	return 0;
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/security/selinux/ss/symtab.c linux-2.5.74-bk1-sel.w1/security/selinux/ss/symtab.c
--- linux-2.5.74-bk1-sel.orig/security/selinux/ss/symtab.c	2003-07-04 12:10:24.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/security/selinux/ss/symtab.c	2003-07-04 23:53:29.325200129 +1000
@@ -9,7 +9,7 @@
 
 #include "symtab.h"
 
-static unsigned int symhash(hashtab_t h, hashtab_key_t key)
+static unsigned int symhash(struct hashtab *h, void *key)
 {
 	char *p, *keyp;
 	unsigned int size;
@@ -17,20 +17,20 @@
 
 
 	val = 0;
-	keyp = (char *) key;
+	keyp = key;
 	size = strlen(keyp);
 	for (p = keyp; (p - keyp) < size; p++)
 		val = (val << 4 | (val >> (8*sizeof(unsigned int)-4))) ^ (*p);
 	return val & (h->size - 1);
 }
 
-static int symcmp(hashtab_t h, hashtab_key_t key1, hashtab_key_t key2)
+static int symcmp(struct hashtab *h, void *key1, void *key2)
 {
 	char *keyp1, *keyp2;
 
 
-	keyp1 = (char *) key1;
-	keyp2 = (char *) key2;
+	keyp1 = key1;
+	keyp2 = key2;
 	return strcmp(keyp1, keyp2);
 }
 
diff -urN -X dontdiff linux-2.5.74-bk1-sel.orig/security/selinux/ss/symtab.h linux-2.5.74-bk1-sel.w1/security/selinux/ss/symtab.h
--- linux-2.5.74-bk1-sel.orig/security/selinux/ss/symtab.h	2003-07-04 12:10:24.000000000 +1000
+++ linux-2.5.74-bk1-sel.w1/security/selinux/ss/symtab.h	2003-07-04 23:53:35.480756202 +1000
@@ -13,10 +13,10 @@
 #ifndef _SYMTAB_H_
 #define _SYMTAB_H_
 
-#include "hashtab.h"
+#include <linux/hashtab.h>
 
 typedef struct {
-	hashtab_t table;	/* hash table (keyed on a string) */
+	struct hashtab *table;	/* hash table (keyed on a string) */
 	__u32 nprim;		/* number of primary names in table */
 } symtab_t;
 

