Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVDWL1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVDWL1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 07:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVDWL1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 07:27:45 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:17542 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261547AbVDWL1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 07:27:41 -0400
Subject: Re: [RFC] non-resident page management
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: riel@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Sat, 23 Apr 2005 14:25:56 +0300
Message-Id: <1114255557.10805.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/23/05, Rik van Riel <riel@redhat.com> wrote:
> Note that this code could use an actual hash function.

How about this? It computes hash for the two longs and combines them by
addition and multiplication as suggested by [Bloch01].

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/linux/hash.h |   13 ++++++++++++-
 mm/nonresident.c     |   11 ++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

Index: 2.6/include/linux/hash.h
===================================================================
--- 2.6.orig/include/linux/hash.h	2004-12-24 23:35:39.000000000 +0200
+++ 2.6/include/linux/hash.h	2005-04-23 13:57:46.000000000 +0300
@@ -23,7 +23,7 @@
 #error Define GOLDEN_RATIO_PRIME for your wordsize.
 #endif
 
-static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+static inline unsigned long hash_long_mul(unsigned long val)
 {
 	unsigned long hash = val;
 
@@ -46,6 +46,17 @@
 	/* On some cpus multiply is faster, on others gcc will do shifts */
 	hash *= GOLDEN_RATIO_PRIME;
 #endif
+	return hash;
+}
+
+static inline unsigned long hash_ptr_mul(void *ptr)
+{
+	return hash_long_mul((unsigned long)ptr);
+}
+
+static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+{
+	unsigned long hash = hash_long_mul(val);
 
 	/* High bits are more random, so use them. */
 	return hash >> (BITS_PER_LONG - bits);
Index: 2.6/mm/nonresident.c
===================================================================
--- 2.6.orig/mm/nonresident.c	2005-04-23 13:46:24.000000000 +0300
+++ 2.6/mm/nonresident.c	2005-04-23 14:18:20.000000000 +0300
@@ -21,7 +21,7 @@
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 #include <linux/bootmem.h>
-#include <linux/jhash.h>
+#include <linux/hash.h>
 // #include <linux/nonresident.h>
 
 static unsigned long nr_buckets;
@@ -51,11 +51,16 @@
 /* The non-resident page hash table. */
 static struct nr_bucket * nr_hashtable;
 
-/* Wanted: a real hash function for 2 longs. */
 struct nr_bucket * nr_hash(void * mapping, unsigned long offset_and_gen)
 {
+	unsigned long hash;
 	unsigned long bucket;
-	bucket = ((unsigned long)mapping + offset_and_gen) % nr_buckets;
+
+	hash = 17;
+	hash = 37 * hash + hash_ptr_mul(mapping);
+	hash = 37 * hash + hash_long_mul(offset_and_gen);
+	bucket = hash % nr_buckets;
+
 	return nr_hashtable + bucket;
 }
 


