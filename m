Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264291AbUEIENX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUEIENX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 00:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUEIENX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 00:13:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:18411 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264291AbUEIENO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 00:13:14 -0400
Date: Sat, 8 May 2004 21:12:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dipankar@in.ibm.com, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: dentry bloat.
Message-Id: <20040508211236.10481447.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
References: <409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
	<20040508120148.1be96d66.akpm@osdl.org>
	<Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
	<Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org>
	<20040508204239.GB6383@in.ibm.com>
	<20040508135512.15f2bfec.akpm@osdl.org>
	<20040508211920.GD4007@in.ibm.com>
	<20040508171027.6e469f70.akpm@osdl.org>
	<Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
>  while we're discussing the other things, how about for now
>  just having this fairly minimal patch to get rid of the most egregious 
>  memory mis-use.
> 
>  This removes the SLAB_HWCACHE_ALIGN and the cache line alignment on
>  "struct dentry", and to compensate for the fact that the inline name
>  length will shrink quite a bit it changes DNAME_INLINE_LEN_MIN from 16 to
>  24.

I think that'll crash.  DNAME_INLINE_LEN_MIN is the *minimum* storage in
the dentry.  The actual storage is assumed to be DNAME_INLINE_LEN and the
patch doesn't change that value.

The calculation of DNAME_INLINE_LEN assumes that slab padded the dentry out
to the next cacheline.

If we want a quickie deporkification, this will do it.  But I don't see a
rush on it.





Save a bit of dcache space.

Currently we use all the space from the start of dentry.d_name to the next
cacheline for the inline name.  That can be 128 bytes or more nowadays, which
is excessive.  In fact it's exactly 128 bytes of inline name length for an x86
P4 build (both UP and SMP).

Rework things so that the inline name length is between 31 and 48 bytes.

On SMP P4-compiled x86 each dentry goes from 256 bytes (15 per page) to 160
bytes (24 per page).  The downside is that we'll have more out-of-line names.

Here's the histogram of name lengths on all 1.5M files on my workstation:

1:  0%
2:  0%
3:  1%
4:  5%
5:  8%
6:  13%
7:  19%
8:  26%
9:  33%
10:  42%
11:  49%
12:  55%
13:  60%
14:  64%
15:  67%
16:  69%
17:  71%
18:  73%
19:  75%
20:  76%
21:  78%
22:  79%
23:  80%
24:  81%
25:  82%
26:  83%
27:  85%
28:  86%
29:  87%
30:  88%
31:  89%
32:  90%
33:  91%
34:  92%
35:  93%
36:  94%
37:  95%
38:  96%
39:  96%
40:  96%
41:  96%
42:  96%
43:  96%
44:  97%
45:  97%
46:  97%
47:  97%
48:  97%
49:  98%
50:  98%
51:  98%
52:  98%
53:  98%
54:  98%
55:  98%
56:  98%
57:  98%
58:  98%
59:  98%
60:  99%
61:  99%
62:  99%
63:  99%
64:  99%

So on x86 we'll fit 89% of filenames into the inline name.


The patch also removes the NAME_ALLOC_LEN() rounding-up of the storage for the
out-of-line names.  That seems unnecessary.


---

 25-akpm/fs/dcache.c            |   16 ++++++++++------
 25-akpm/include/linux/dcache.h |    8 ++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff -puN fs/dcache.c~dentry-shrinkage fs/dcache.c
--- 25/fs/dcache.c~dentry-shrinkage	2004-05-08 21:09:00.620787784 -0700
+++ 25-akpm/fs/dcache.c	2004-05-08 21:09:37.413194488 -0700
@@ -41,6 +41,13 @@ EXPORT_SYMBOL(dcache_lock);
 static kmem_cache_t *dentry_cache; 
 
 /*
+ * The allocation size for each dentry.  It is a multiple of 16 bytes.  We
+ * leave the final 32-47 bytes for the inline name.
+ */
+#define DENTRY_STORAGE	(((sizeof(struct dentry)+32) + 15) & ~15)
+#define DNAME_INLINE_LEN (DENTRY_STORAGE - sizeof(struct dentry))
+
+/*
  * This is the single most critical data structure when it comes
  * to the dcache: the hashtable for lookups. Somebody should try
  * to make this good - I've just made it work.
@@ -665,8 +672,6 @@ static int shrink_dcache_memory(int nr, 
 	return dentry_stat.nr_unused;
 }
 
-#define NAME_ALLOC_LEN(len)	((len+16) & ~15)
-
 /**
  * d_alloc	-	allocate a dcache entry
  * @parent: parent of entry to allocate
@@ -688,8 +693,7 @@ struct dentry * d_alloc(struct dentry * 
 		return NULL;
 
 	if (name->len > DNAME_INLINE_LEN-1) {
-		qstr = kmalloc(sizeof(*qstr) + NAME_ALLOC_LEN(name->len), 
-				GFP_KERNEL);  
+		qstr = kmalloc(sizeof(*qstr) + name->len + 1, GFP_KERNEL);
 		if (!qstr) {
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
@@ -1563,9 +1567,9 @@ static void __init dcache_init(unsigned 
 	 * it should not try to get multiple page regions.  
 	 */
 	dentry_cache = kmem_cache_create("dentry_cache",
-					 sizeof(struct dentry),
+					 DENTRY_STORAGE,
 					 0,
-					 SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					 SLAB_RECLAIM_ACCOUNT,
 					 NULL, NULL);
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
diff -puN include/linux/dcache.h~dentry-shrinkage include/linux/dcache.h
--- 25/include/linux/dcache.h~dentry-shrinkage	2004-05-08 21:09:00.621787632 -0700
+++ 25-akpm/include/linux/dcache.h	2004-05-08 21:09:00.628786568 -0700
@@ -74,8 +74,6 @@ full_name_hash(const unsigned char *name
 	return end_name_hash(hash);
 }
 
-#define DNAME_INLINE_LEN_MIN 16
-
 struct dcookie_struct;
  
 struct dentry {
@@ -101,11 +99,9 @@ struct dentry {
 	struct qstr d_name;
 	struct hlist_node d_hash;	/* lookup hash list */	
 	struct hlist_head * d_bucket;	/* lookup hash bucket */
-	unsigned char d_iname[DNAME_INLINE_LEN_MIN]; /* small names */
-} ____cacheline_aligned;
+	unsigned char d_iname[0];	/* small names */
+};
 
-#define DNAME_INLINE_LEN	(sizeof(struct dentry)-offsetof(struct dentry,d_iname))
- 
 struct dentry_operations {
 	int (*d_revalidate)(struct dentry *, struct nameidata *);
 	int (*d_hash) (struct dentry *, struct qstr *);

_

