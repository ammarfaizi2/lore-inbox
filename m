Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVDWS6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVDWS6x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVDWS4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:56:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41604 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261714AbVDWSzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:55:13 -0400
Date: Sat, 23 Apr 2005 14:55:04 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] non-resident page management
In-Reply-To: <Pine.LNX.4.61.0504231310160.26710@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0504231453210.26710@chimarrao.boston.redhat.com>
References: <1114255557.10805.2.camel@localhost>
 <Pine.LNX.4.61.0504231310160.26710@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2005, Rik van Riel wrote:

> The next part of my cunning plan is to get rid of the object
> generation number,

Here's the change, incremental to the previous patch.  This should
simplify things for the caller and work with both the swap cache
and filesystem backed inodes - assuming filesystems are smart about
recycling inode numbers, otherwise I may need to use another field
too ...

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.11/include/linux/nonresident.h.nr2	2005-04-23 14:10:00.000000000 -0400
+++ linux-2.6.11/include/linux/nonresident.h	2005-04-23 14:10:18.000000000 -0400
@@ -7,6 +7,6 @@
  * Keeps track of whether a non-resident page was recently evicted
  * and should be immediately promoted to the active list.
  */
-extern int recently_evicted(void *, unsigned long, unsigned long);
-extern int remember_page(void *, unsigned long, unsigned long);
+extern int recently_evicted(void *, unsigned long);
+extern int remember_page(void *, unsigned long);
 void init_nonresident(unsigned long);
--- linux-2.6.11/mm/nonresident.c.nr2	2005-04-23 14:10:07.000000000 -0400
+++ linux-2.6.11/mm/nonresident.c	2005-04-23 14:52:31.000000000 -0400
@@ -26,14 +26,6 @@
 
 static unsigned long nr_buckets;
 
-/*
- * We fold the object generation number into the offset field, since
- * that one has the most "free" bits on a 32 bit system.
- */
-#define NR_GEN_SHIFT		(BITS_PER_LONG * 7 / 8)
-#define NR_OFFSET_MASK		((1 << NR_GEN_SHIFT) - 1)
-#define make_nr_oag(x,y)	(((x) & NR_OFFSET_MASK) + ((y) << NR_GEN_SHIFT))
-
 struct nr_page {
 	void * mapping;
 	unsigned long offset_and_gen;
@@ -51,19 +43,31 @@ struct nr_bucket
 /* The non-resident page hash table. */
 static struct nr_bucket * nr_hashtable;
 
-struct nr_bucket * nr_hash(void * mapping, unsigned long offset_and_gen)
+struct nr_bucket * nr_hash(void * mapping, unsigned long offset)
 {
 	unsigned long bucket;
 	unsigned long hash;
 
-	hash = 17;
-	hash = 37 * hash + hash_ptr_mul(mapping);
-	hash = 37 * hash + hash_long_mul(offset_and_gen);
+	hash = hash_ptr_mul(mapping);
+	hash = 37 * hash + hash_long_mul(offset);
 	bucket = hash % nr_buckets;
 
 	return nr_hashtable + bucket;
 }
 
+static unsigned long nr_cookie(struct address_space * mapping, unsigned long offset)
+{
+	unsigned long cookie = offset;
+
+	if (mapping->host) {
+		cookie = hash_mul_long(offset);
+		cookie = 37 * cookie + hash_ptr_mul(mapping->host->i_ino);
+		cookie = 37 * cookie + hash_ptr_mul(mapping->host->i_sb);
+	}
+
+	return cookie;
+}
+
 static int nr_same(struct nr_page * first, struct nr_page * second)
 {
 	/* Chances are this nr_page belongs to a different mapping ... */
@@ -77,10 +81,10 @@ static int nr_same(struct nr_page * firs
 	return 0;
 }
 
-int recently_evicted(void * mapping, unsigned long offset, unsigned long gen)
+int recently_evicted(struct address_space * mapping, unsigned long offset)
 {
-	unsigned long offset_and_gen = make_nr_oag(offset, gen);
-	struct nr_bucket * nr_bucket = nr_hash(mapping, offset_and_gen);
+	unsigned long offset_and_gen = nr_cookie(mapping, offset);
+	struct nr_bucket * nr_bucket = nr_hash(mapping, offset);
 	struct nr_page wanted;
 	int state = -1;
 	int i;
@@ -102,10 +106,10 @@ int recently_evicted(void * mapping, uns
 	return state;
 }
 
-int remember_page(void * mapping, unsigned long offset, unsigned long gen)
+int remember_page(struct address_space * mapping, unsigned long offset)
 {
-	unsigned long offset_and_gen = make_nr_oag(offset, gen);
-	struct nr_bucket * nr_bucket = nr_hash(mapping, offset_and_gen);
+	unsigned long offset_and_gen = nr_cookie(mapping, offset);
+	struct nr_bucket * nr_bucket = nr_hash(mapping, offset);
 	struct nr_page * victim;
 	int recycled = 0;
 	int i;
