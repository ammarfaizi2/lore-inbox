Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264191AbUEHIYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbUEHIYk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 04:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbUEHIYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 04:24:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:32148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264191AbUEHIYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 04:24:31 -0400
Date: Sat, 8 May 2004 01:23:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: davej@redhat.com, torvalds@osdl.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040508012357.3559fb6e.akpm@osdl.org>
In-Reply-To: <409B1511.6010500@colorfullife.com>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(added lkml)

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Andrew Morton wrote:
> 
> >It does seem a little excessive.  Maybe we should round the size up by "the
> >next multiple of sizeof(void*) which is greater than 32".
> >  
> >
> Sounds good.
> But the SLAB_HWCACHE_ALIGN parameter from the kmem_cache_create call 
> must be removed as well - otherwise slab will round the size up to 256 
> again.
> 

There are a couple of things I don't understand in the dentry name handling:

a) How come switch_names does a memcpy of d_iname even if the name might
   not be in there?

b) Why does d_alloc() resize the storage for the out-of-line name to the
   next multiple of 16?

c) Why is it that when we generate an out-of-line name we allocate a
   complete new qstr rather than just storage for the name?  The dentry has
   a whole qstr just sitting there doing nothing, and from a quick squizz
   it seems that we could simply remove dentry.d_qstr, make
   dentry.d_name.name point at the kmalloced name and not allocate all the
   other parts of the qstr?


Anyway, here be a patch.



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
--- 25/fs/dcache.c~dentry-shrinkage	2004-05-08 00:55:58.762312080 -0700
+++ 25-akpm/fs/dcache.c	2004-05-08 00:56:22.590689616 -0700
@@ -42,6 +42,13 @@ EXPORT_SYMBOL(dcache_lock);
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
@@ -1563,8 +1567,8 @@ static void __init dcache_init(unsigned 
 	 * flag could be removed here, to hint to the allocator that
 	 * it should not try to get multiple page regions.  
 	 */
-	dentry_cache = kmem_cache_create("dentry_cache", sizeof(struct dentry),
-			0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_PANIC,
+	dentry_cache = kmem_cache_create("dentry_cache", DENTRY_STORAGE,
+			0, SLAB_RECLAIM_ACCOUNT|SLAB_PANIC,
 			NULL, NULL);
 	
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
diff -puN include/linux/dcache.h~dentry-shrinkage include/linux/dcache.h
--- 25/include/linux/dcache.h~dentry-shrinkage	2004-05-08 00:55:58.774310256 -0700
+++ 25-akpm/include/linux/dcache.h	2004-05-08 00:55:58.779309496 -0700
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

