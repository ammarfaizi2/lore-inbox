Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUD3VeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUD3VeC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUD3VeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:34:02 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:40083 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261396AbUD3Vd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:33:56 -0400
Date: Fri, 30 Apr 2004 16:33:24 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, "Jose R. Santos" <jrsantos@austin.ibm.com>,
       linux-kernel@vger.kernel.org, anton@samba.org, dheger@us.ibm.com
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance changes.
Message-ID: <20040430213324.GK14271@rx8.ibm.com>
References: <20040430191539.GC14271@rx8.ibm.com> <20040430131832.45be6956.akpm@osdl.org> <20040430205701.GG14271@rx8.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040430205701.GG14271@rx8.ibm.com> (from jrsantos@austin.ibm.com on Fri, Apr 30, 2004 at 15:57:01 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/04 15:57:01, Jose R. Santos wrote:
> err... Wrote the patch to fast.  It should read
> 
> 	tmp = (hashval * sb) ^ (GOLDEN_RATIO_PRIME + hashval) / L1_CACHE_BYTES
> 
> I screw up... I'll send a fixed patch in a while.

Just notice I've made another error in the inode hash code.

Fixed patch (I hope) with beautification.

-JRS


diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Fri Apr 30 16:27:41 2004
+++ b/fs/dcache.c	Fri Apr 30 16:27:41 2004
@@ -28,6 +28,7 @@
 #include <asm/uaccess.h>
 #include <linux/security.h>
 #include <linux/seqlock.h>
+#include <linux/hash.h>
 
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
@@ -799,8 +800,8 @@
 
 static inline struct hlist_head * d_hash(struct dentry * parent, unsigned long hash)
 {
-	hash += (unsigned long) parent / L1_CACHE_BYTES;
-	hash = hash ^ (hash >> D_HASHBITS);
+	hash += ((unsigned long) parent ^ GOLDEN_RATIO_PRIME) / L1_CACHE_BYTES;
+	hash = hash ^ ((hash ^ GOLDEN_RATIO_PRIME) >> D_HASHBITS);
 	return dentry_hashtable + (hash & D_HASHMASK);
 }
 
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Fri Apr 30 16:27:41 2004
+++ b/fs/inode.c	Fri Apr 30 16:27:41 2004
@@ -671,12 +671,13 @@
 
 static inline unsigned long hash(struct super_block *sb, unsigned long hashval)
 {
-	unsigned long tmp = hashval + ((unsigned long) sb / L1_CACHE_BYTES);
-	tmp = tmp + (tmp >> I_HASHBITS);
+	unsigned long tmp;
+	
+	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
+			L1_CACHE_BYTES;
+	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> I_HASHBITS);
 	return tmp & I_HASHMASK;
 }
-
-/* Yeah, I know about quadratic hash. Maybe, later. */
 
 /**
  *	iunique - get a unique inode number
